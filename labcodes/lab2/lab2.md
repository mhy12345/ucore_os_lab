# 操作系统 第二次试验报告

计62 毛晗扬 2016011275

## 练习0

我使用`meld`工具使用可视化界面进行合并


## 练习1

### 题目

实现FirstFit内存分配算法

### 解答

FirstFit内存分配算法基本上可以服用Default版本的代码，因为Default版本的代码对于内存的分配也是从链表头开始顺序查找到第一个满足条件的块。

唯一的区别在于，Default版本并没有保证链表顺序等同于内存地址顺序。而可能导致乱序的地方是`default_free_pages`函数中，释放`base`对应页时，使用了如下实现。

```c
list_add(&free_list, &(base->page_link)); 
```

这种实现中，`base`块被插到了链表头部，因而打乱了链表的顺序性。为了解决这个问题，我们可以设计算法，让`base`插到能够维持链表顺序性的位置，即

* `base->prev`代表的内存地址小于`base`页的内存地址
* `base->next`代表的内存地址大于`base`页的内存地址

算法为——

```c
list_entry_t *left = &free_list;                                                                                               
    while (list_next(left) != &free_list &&                                                                                        
            list_next(left) < base) {                                                                                              
        left = list_next(left);                                                                                                    
    }                                                                                                                              
list_add(left, &(base->page_link));       
```

相似的，需要改进`default_alloc_pages`函数，该函数中，当一个块在分配了N页后，尚且有剩余，则处理方式如下

```c
if (page != NULL) {
    list_del(&(page->page_link));
    if (page->property > n) {
        struct Page *p = page + n;
        p->property = page->property - n;
        list_add(&free_list, &(p->page_link));
    }
    nr_free -= n;                                                                                                              
    ClearPageProperty(page);                                                                     
}
```

较小的页并没有插入原来的位置，而是插入链表头。为了维护链表的顺序性，需要将上面代码修改为——

```c
if (page != NULL) {                                                                                                            
    if (page->property > n) {                                                                                                  
        struct Page *p = page + n;                                                                                             
        p->property = page->property - n;                                                                                      
        SetPageProperty(p);                                                                                                    
        list_add_after(&(page->page_link), &(p->page_link));                                                                   
    }                                                                                                                          
    list_del(&(page->page_link));                                                                                              
    nr_free -= n;                                                                                                              
    ClearPageProperty(page);                                                                                                   
}                        
```



### 改进空间

除了地址分配的`alloc_pages`函数，由于`FirstFit`算法的要求，需要逐一遍历链表，其他地方还多次遍历链表，如新增加的`free_pages`中的两个`while`语句。实际上，由于`while`语句作用仅仅在于“在一个有序链表中，找到一个值大于等于x的节点”，这种需求在使用链表时间复杂度$O(N)$，但是使用诸如平衡树等方法，可以将时间复杂度将为$O(logN)$


## 练习2

[练习2-1] ： 请描述页目录项（Pag Director Entry）和页表（Page Table Entry）中每个组成部分的含义和以及对ucore而言的潜在用处。

下面将通过`init/entry.S`中对于列表的描述解答。

`boot_pgdir`是一个全局指针，指向了一个巨大的空闲空间，这个空间中，可以放置若干PDE表项。系列代码就是对于该空间的定义。

```
.globl __boot_pgdir
    # map va 0 ~ 4M to pa 0 ~ 4M (temporary)
    .long REALLOC(__boot_pt1) + (PTE_P | PTE_U | PTE_W)
    .space (KERNBASE >> PGSHIFT >> 10 << 2) - (. - __boot_pgdir) # pad to PDE of KERNBASE
    # map va KERNBASE + (0 ~ 4M) to pa 0 ~ 4M
    .long REALLOC(__boot_pt1) + (PTE_P | PTE_U | PTE_W)
    .space PGSIZE - (. - __boot_pgdir) # pad to PGSIZE
```

上面的PDE表项，仅仅对PDE设置了两个表项，其他地方都置了零。这两项运行了内核代码的两种索引方式——

* 使用0~4M地址空间索引
* 使用KERNBASE+(0~4M)索引

其中第一种方法是临时的，会在之后清楚。

每一个“存在”的页目录项都指向了一个页表项(PTE)的列表，该列表的每一个元素，都指向了实际的页号。如下列代码，同时为PDE中的两个非零表项所引用。

```
.set i, 0
__boot_pt1:
.rept 1024
    .long i * PGSIZE + (PTE_P | PTE_W)
    .set i, i + 1
.endr
```

这样的设计我认为有如下用处——

* 支持通过修改level1的PDE表项权限，批量修改诸多页的权限。而目录表项可以用于进程权限设置。特别的，有了这种设计，我们可以很容易实现两个进程共享一个很大的内存空间。只需要共享一个PDE表项的互相读写权限即可。
* 兼容后来的64位系统（虽然也许不会考虑那么远），因为Linear Address在这种实现中可以变得很大。


[练习2-2]：如果ucore执行过程中访问内存，出现了页访问异常，请问硬件要做哪些事情？

硬件需要出发一个缺页中断(page fault)，而将后续的工作交由操作系统软件执行

### 实验设计

当需要获得`la`线性地址对应的页表pte时，有如下代码。

```c
    pde_t *pdep = &pgdir[PDX(la)];                                                                                                 
    if (! (*pdep & PTE_P)) {                                                                                                       
        if (!create)                                                                                                               
            return NULL;                                                                                                           
        struct Page* page = alloc_pages(1);                                                                                        
        if (!page)                                                                                                                 
            return NULL;                                                                                                           
        set_page_ref(page, 1);                                                                                                     
        uintptr_t addr = page2pa(page);                                                                                            
        memset(KADDR(addr), 0, PGSIZE);                                                                                            
        *pdep = addr | PTE_P | PTE_W | PTE_U;                                                                                      
    }                                                                                                                              
    pte_t *ptep = &((pde_t*)KADDR(PDE_ADDR(*pdep)))[PTX(la)];                                                                      
    return ptep;
```

这段代码我是完全按照提示一步一步写的，在中途参考了答案的设计思路。分别做了下面的事情：

* 通过`pgdir[PDX(la)]`在`pgdir`中进行第一级索引，其中`pgdir`可以理解为等同于`boot_dir`
* 如果`pdep`的`PTE_P`位为0，则说明这一个目录压根儿还不存在，倘若输入参数`create`指示需要新建不存在的表项，则需要进行后续操作
* 新建一个`page`，用于存放页表，并将`pdep`重置为该页对应的内存地址，此时`pdep`指向了一个合法的页表
* 通过`pdep`指向的页表进行索引。

## 练习3

[练习3-1]：数据结构Page的全局变量（其实是一个数组）的每一项与页表中的页目录项和页表项有无对应关系？如果有，其对应关系是啥？

有，有如下关系：

* 每一个页表目录项`pdep`如果存在，一定指向一个页的起始虚拟地址，该页处于已被分配状态，不在链表中，ref非零，权限RWP
* 每一个页表项如果存在，一定指向一个页的起始虚拟地址，该页处于已被分配状态，不在链表中，ref非零，权限P

[练习3-2]：如果希望虚拟地址与物理地址相等，则需要如何修改lab2，完成此事？ 鼓励通过编程来具体完成这个问题

实际的映射关系为 `virt addr = linear addr = phy addr + 0xC0000000`，发现在`pmm.c`文件中有如下函数调用——

```c
// map all physical memory to linear memory with base linear addr KERNBASE                                                     
// linear_addr KERNBASE ~ KERNBASE + KMEMSIZE = phy_addr 0 ~ KMEMSIZE                                                          
boot_map_segment(boot_pgdir, KERNBASE, KMEMSIZE, 0, PTE_W);                                                                    
```

倘若将它改为

```c
boot_map_segment(boot_pgdir, 0, KMEMSIZE, 0, PTE_W);   
```

即可实现`virt addr = linear addr = phy addr`的映射关系。

### 实验设计

这一部分是我在没有参考答案的情况下，通过类比练习2代码实现的——

```c
if (*ptep & PTE_P) {                                                                                                           
    struct Page* page = pte2page(*ptep);                                                                                       
    page_ref_dec(page);                                                                                                        
    if (page->ref == 0) {                                                                                                      
        free_page(page);                                                                                                       
    }                                                                                                                          
    *ptep &= ~PTE_P;                                                                                                           
    tlb_invalidate(pgdir, la);                                                                                                 
```

这一部分的实现思路为——

* 首先测试ptep是否合法
* 将页引用减一，若不存在其他引用，则释放页
* 将页表项置为不合法
* 清空tlb缓存

## 拓展练习：Buddy System

算法在理解了[伙伴分配器的一个极简实现](http://coolshell.cn/articles/10427.html)文章后，直接通过少量修改，写成了`kern/mm/buddy_pmm.c(h)`

### 模型设计

#### 问题分析

分析问题，我们需要实现——

* 一个二叉树森林，其中每一棵二叉树对应了一个Memory块的页表（实际上在本实验中，退化为了一颗二叉树）
* 二叉树支持能够从其中的任意节点(struct Page)，反推出二叉树根节点，及其大小信息。
* 实现`pmm_manager`内定义的所有函数，尽量和`default_pmm_manager`有相同表现

```c
const struct pmm_manager default_pmm_manager = {
    .name = "default_pmm_manager",
    .init = default_init,
    .init_memmap = default_init_memmap,
    .alloc_pages = default_alloc_pages,
    .free_pages = default_free_pages,
    .nr_free_pages = default_nr_free_pages,
    .check = default_check,
};
```

#### 模型设计

最初的思路是需要有一个地方，可以供我放原文中的`longest`域，然后我发现了对于`Page`的定义如下

```c
struct Page {
    int ref;                        // page frame's reference counter
    uint32_t flags;                 // array of flags that describe the status of the page frame
    unsigned int property;          // the num of free block, used in first fit pm manager
    list_entry_t page_link;         // free list link
};
```


显然，倘若要实现伙伴分配器的话，显然并不需要使用链表，那么`Page`的`list_entry_t`域就没有用了。这样的话，`list_entry_t`域的两个4字节数就正好可以供我们存放`Page`的最大分配长度`longest`以及该`Page`所述的二叉树的编号`label`，修改为如下——（使用union主要是为了不改变Page的大小，防止出现一些意料之外的问题）


```c
typedef struct {
    uint32_t label;
    uint32_t longest;
} buddy_entry_t;

struct Page {                                                                                                                      
    int ref;                        // page frame's reference counter                                                              
    uint32_t flags;                 // array of flags that describe the status of the page frame                                   
    unsigned int property;          // the num of free block, used in first fit pm manager
    union {
        list_entry_t page_link;         // free list link
        buddy_entry_t buddy_info;
    };
};
```

上述两个结构体可以说定义了二叉树的节点`Page`，而二叉树森林的定义如下

```c
#define MAX_BUDDY 20

typedef struct {
    size_t size;
    struct Page* header;
} buddy_item_t;

typedef struct {
    uint32_t total;
    buddy_item_t items[MAX_BUDDY];
} buddy_t;
```

这里定义了一个能够容纳20棵树的森林，`header`指向森林根节点的`Page`指针。而`header`指示位置后连续`size`个`Page`结构体顺序组成一个二叉树结构。

而`Page`中的`label`域则是从`Page`反查`items`编号的方式。

上述数据结构，可以让我们能够访问任意二叉树的任意节点，并且还可以从`Page`反推出各种信息。因此能够支持[伙伴分配器的一个极简实现](http://coolshell.cn/articles/10427.html)中的算法要求。

### 复现方法

在`kern/mm/pmm.c`中，注释掉第13行的`//#define USE_BUDDY_MANAGER`即可将分配器修改为`buddy_pmm`分配器。

### 测试

按照复现方法，运行`make qemu`，输出为

```txt
buddy_check()...                                                                                                                   
the max blocks can be alloc : 8192                                                                                                 
alloc page sized 1,2,3,3 ...                                                                                                       
BUDDY : ALLOC MEMORY AT 0                                                                                                          
BUDDY : ALLOC MEMORY AT 2                                                                                                          
BUDDY : ALLOC MEMORY AT 4                                                                                                          
BUDDY : ALLOC MEMORY AT 8                                                                                                          
>        0.11.222.333....                                                                                                          
free the first three blocks ...                                                                                                    
BUDDY : FREE MEMORY AT 0                                                                                                           
BUDDY : FREE MEMORY AT 2                                                                                                           
BUDDY : FREE MEMORY AT 4                                                                                                           
>        .........333....                                                                                                          
alloc a block sized 8 ...                                                                                                          
BUDDY : ALLOC MEMORY AT 0                                                                                                          
>        444444444333....                                                                                                          
the max blocks can be alloc : 4096                                                                                                 
buddy_check() success.                     
```

这一段输出同时测试了分配不同大小的block，释放block，并且检验了释放合并的效果，以及可分配内存空间总量的计算。

同时，按照该数据结构，在执行`make grade`后，能够得到除了`default_pmm_manager`之外的所有分数，也能证明该模型的正确性。

```txt
Check PMM:               (2.3s)
  -check pmm:                                WRONG
   -e !! error: missing 'memory management: default_pmm_manager'

  -check page table:                         OK
  -check ticks:                              OK
Total Score: 30/50
Makefile:265: recipe for target 'grade' failed
make: *** [grade] Error 1
```
