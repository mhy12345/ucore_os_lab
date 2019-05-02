# 操作系统 第三次试验报告

计62 毛晗扬 2016011275

## 练习1

[练习1-1]：请描述页目录项（Pag Director Entry）和页表（Page Table Entry）中组成部分对ucore实现页替换算法的潜在用处。

 如，列表项中dirty位可以为clock置换算法提供帮助。
 
 

[练习1-2]：如果ucore的缺页服务例程在执行过程中访问内存，出现了页访问异常，请问硬件要做哪些事情？

* 产生Double Fault中断
* 若找到成功swap in对应的页，则退回至level1的缺页服务例程
* 若没有找到对应的页，产生triple fault，CPU强制重置

## 练习2

[练习2-1]：如果要在ucore上实现"extended clock页替换算法"请给你的设计方案，现有的swap_manager框架是否足以支持在ucore中实现此算法？如果是，请给你的设计方案。如果不是，请给出你的新的扩展和基此扩展的设计方案。并需要回答如下问题

* 需要被换出的页的特征是什么？
* 在ucore中如何判断具有这样特征的页？
* 何时进行换入和换出操作？

解答：

[1]：特征是经过若干跳转后，遇到的第一个“访问位为0，修改位为0”的页。
[2]：可以拓展`struct Page`，在里面加上记录位的空间，并且为`swap_manager`设置钩子函数，在页被访问的时候调用（不过尚且不清楚ucore如何高效检测一个页是否被访问）。
[3]：发生缺页时。

不足以实现，如果题目中的框架指的是类似于下面代码定义的函数，那么我认为该框架是足够的，但是实际上，从lab3的ucore代码上来看，函数`tick_event`从来就没有被调用过。通过函数名，我猜测该函数是用来维护也访问信息的，倘若在每次页访问时，该函数都会被调用，那么该框架应该是足够的。

```c
struct swap_manager swap_manager_fifo =
{
     .name            = "fifo swap manager",
     .init            = &_fifo_init,
     .init_mm         = &_fifo_init_mm,
     .tick_event      = &_fifo_tick_event,
     .map_swappable   = &_fifo_map_swappable,
     .set_unswappable = &_fifo_set_unswappable,
     .swap_out_victim = &_fifo_swap_out_victim,
     .check_swap      = &_fifo_check_swap,
};
```

设计方案包括，对于Page结构体的定义加上

```c
/* *                                                                                                                               
 * struct Page - Page descriptor structures. Each Page describes one                                                               
 * physical page. In kern/mm/pmm.h, you can find lots of useful functions                                                          
 * that convert Page to other data types, such as phyical address.                                                                 
 * */                                                                                                                              
struct Page {                                                                                                                      
    int ref;                        // page frame's reference counter                                                              
    uint32_t flags;                 // array of flags that describe the status of the page frame                                   
    unsigned int property;          // the num of free block, used in first fit pm manager                                         
    list_entry_t page_link;         // free list link
    list_entry_t pra_page_link;     // used for pra (page replace algorithm)
    uintptr_t pra_vaddr;            // used for pra (page replace algorithm)
    int status;//Clock算法中的标志位，修改位
};
```

也可以每次`tick_event`触发时，扫描整个manager维护的页集合，找到其中`access_bit`和`dirty_bit`变化了的页面，并进而更新status。

在每次出现`timer_interrupt`时，调用`tick_event`函数。

## 实验报告

### 练习1

出现缺页异常时，分为两个情况

1. 对应页压根儿不存在。
2. 对应页曾经在内存中，不过被swap out到磁盘中去了。

对于第一种情况，我们可以使用`if (!*ptep)`加以判断。（之前我曾经试图通过`if (!(*ptep & PTE_P)) `判断，后来发现，被swap out到磁盘中只会导致`PTE_P`位为空，而并不会清空整个`*ptep`.


```c
    ptep = get_pte(mm->pgdir, addr, 1);            //(1) try to find a pte, if pte's PT(Page Table) isn't existed, then create a PT.                                                                                                                                  
    //if (!(*ptep & PTE_P)) {                                                                                                      
    if (!*ptep) {                                                                                                                  
        struct Page* page = pgdir_alloc_page(mm->pgdir, addr, perm); //(2) if the phy addr isn't exist, then alloc a page & map the
 phy addr with logical addr                                                                                                        
        *ptep = page2pa(page) | PTE_P | perm;
    }
```

对于第二种情况，我们可以依次

* 将对应页Swap In
* 将对应页加入页集合中
* 将页标记为“可交换”

```c
    else {                                                                                                                     
        if(swap_init_ok) {                                                                                                         
            struct Page *page=NULL;                                                                                                
            swap_in(mm, addr, &page);                                                                                              
            page_insert(mm->pgdir, page, addr, perm);                                                                              
            swap_map_swappable(mm, addr, page, 1);                                                                                 
            page->pra_vaddr = addr;                                                                                                
                                    //(1）According to the mm AND addr, try to load the content of right disk page                 
                                    //    into the memory which page managed.                                                      
                                    //(2) According to the mm, addr AND page, setup the map of phy addr <---> logical addr         
                                    //(3) make the page swappable.                                                                 
        }            
```


### 练习2

该函数用于选择swapout的对象，由于我们的链表类似于一个队列，因此选择出一个最早插入的对象，等同于从链表末尾去一个对象，代码如下。

```c
static int                                                                                                                         
_fifo_swap_out_victim(struct mm_struct *mm, struct Page ** ptr_page, int in_tick)                                                  
{                                                                                                                                  
     list_entry_t *head=(list_entry_t*) mm->sm_priv;                                                                               
     assert(head != NULL);                                                                                                         
     assert(in_tick==0);                                                                                                           
     /* Select the victim */                                                                                                       
     /*LAB3 EXERCISE 2: 2016011275*/                                                                                               
     //(1)  unlink the  earliest arrival page in front of pra_list_head qeueue                                                     
     //(2)  assign the value of *ptr_page to the addr of this page                                                                 
     list_entry_t *le = head->prev;                                                                                                
     struct Page* page = le2page(le, pra_page_link);                                                                               
     list_del(le);                                                                                                                 
     *ptr_page = page;                                                                                                             
     return 0;                                                                                                                     
}                      
```


在选择好swap对象，并且将对象保存至磁盘后，kernel会调用`fifo_map_swappable`函数，将swap in的页面加入fifo队列，供以后使用——

```c
static int                                                                                                                         
_fifo_map_swappable(struct mm_struct *mm, uintptr_t addr, struct Page *page, int swap_in)                                          
{                                                                                                                                  
    list_entry_t *head=(list_entry_t*) mm->sm_priv;                                                                                
    list_entry_t *entry=&(page->pra_page_link);                                                                                    
                                                                                                                                   
    assert(entry != NULL && head != NULL);                                                                                         
    //record the page access situlation                                                                                            
    /*LAB3 EXERCISE 2: 2016011275*/                                                                                                
    //(1)link the most recent arrival page at the back of the pra_list_head qeueue.                                                
    list_add(head, entry);                                                                                                         
    return 0;                                                                                                                      
}  
```


## 和标准答案的差别

由于这次的代码量比较少，因此和标准答案基本没有区别，唯一的区别诸如将`if (!*ptep) `写成`if (!(*ptep & PTE_P)) ` 也由于没有通过测试样例而很快改正了过来。


## 结果

`make grade`

```text
Check SWAP:              (2.4s)
  -check pmm:                                OK
  -check page table:                         OK
  -check vmm:                                OK
  -check swap page fault:                    OK
  -check ticks:                              OK
Total Score: 45/45
```



