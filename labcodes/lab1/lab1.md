# lab1 实验报告

计62 毛晗扬 2016011275


## 练习1
[练习1-1] : 操作系统镜像文件ucore.img是如何一步一步生成的？

该文件本身通过下列命令生成：

```bash
dd if=/dev/zero of=bin/ucore.img count=10000
dd if=bin/bootblock of=bin/ucore.img conv=notrunc
dd if=bin/kernel of=bin/ucore.img seek=1 conv=notrunc
```
这一系列命令依次做了——

* 将全0的字节流拷贝到`bin/ucore.img`中，大小为10000*512bytes
* 将`bin/bootblock`文件拷贝到`bin/ucore.img`的第0个block（前512字节）
* 将`bin/kernel`文件拷贝到`bin/ucore.img`的第1个block


而对于`ucore.img`的生成又依赖于文件`bin/bootblock`和`bin/kernel`，其中`bin/kernel`是内核可执行文件，直接通过`ld`命令打包而成的，`bin/bootblock`是二进制文件，是通过`ld`命令打包后，通过`objcopy`命令将ELF格式转化为二进制格式形成的。

[练习1-2] :一个被系统认为是符合规范的硬盘主引导扇区的特征是什么？

答：以0x55,0xAA结束的512字节块

## 练习2

[练习2-1] ：从CPU加电后执行的第一条指令开始，单步跟踪BIOS的执行。

修改`tools/gdbinit`，加入断点与自动输出汇编指令的语句

```
file bin/kernel
target remote :1234
break *0x7c00
break kern_init
display /i $pc
```

此时，运行`make debug`命令，即可开始但不调试，使用指令`si`可以进行汇编语句层面的单步调试。

[练习2-2] : 在初始化位置`0x7c00`设置实地址断点,测试断点正常。

见[练习2-1]中的`tools/gdbinit`的第三行。该语句设置了断点，在进入`gdb`后，直接执行`continue`命令即可跳转到`0x7c00`

[练习2-3] : 从0x7c00开始跟踪代码运行,将单步跟踪反汇编得到的代码与`bootasm.S`和 `bootblock.asm`进行比较

运行gdb，并输入`continue`指令，则程序停止到`0x7c00`处，这里正好是`bootasm.S`文件的入口处。接下来一系列代码定义了关于特权等级的设定等初始化操作。而`bootblock.asm`文件是合并了`bootbasm.S`和`bootmain.c`内代码的一个二进制文件。

执行完`bootasm.S`内部定义的一系列汇编代码后，pc跳转至`bootmain.c`文件的`bootmain`函数处。在该函数中，cpu通过硬件的方式加载了第二个扇区中的ELF文件（内含kernel源码）。并在ELF文件头中，查询到`kernel`的入口地址，并直接跳过去。这一部分比较长，可以接使用`continue`指令跳转。

在kernel源码中，我们就可以使用`step`命令，在C语句级别调试了

[练习2-4] : 自己找一个bootloader或内核中的代码位置，设置断点并进行测试。

在`bootblock.asm`中，可以看到bootloader中间所有汇编指令的内存地址，使用`break *<address>`形式的指令可以再该处设置断点。而`kernel`中任意C函数亦可通过`break <function>`设置断点。

## 练习3

[练习3-1]：为何开启A20，以及如何开启A20。

A20是键盘控制器上的一个引脚，用于控制地址线长度是否为20比特，默认该引脚值为0，此时，任意大于20比特的地址空间都将默认回卷到`0x0ffef`。为了使用更大的地址空间，需要将该引脚置为1。通过键盘控制器，即对`port 0x60`的写可以实现该操作。

在`lab1/boot/bootasm.S`源码中，对应了

```asm
inb $0x64, %al          # Wait for not busy(8042 input buffer empty).                                  
testb $0x2, %al         
jnz seta20.2                         
movb $0xdf, %al       # 0xdf -> port 0x60                                                            
outb %al, $0x60       # 0xdf = 11011111, means set P2's A20 bit(the 1 bit) to 1                      
```

这段代码直接向端口`0x60`写入了值`0xdf`（`0b11011111`)，写入改值后，A20引脚（第2个bit）被置为了1，此时就可以寻址更大的空间了。A20相关引脚可在[此处](https://www.win.tue.nl/~aeb/linux/kbd/scancodes-11.html)查阅。

[练习3-2]：如何初始化GDT表

在`lab1/boot/bootasm.S`源码中，对应了

```asm
lgdt gdtdesc                                                                                                                   
```

使用了汇编指令lgdt直接加载GDT表位置。

GDT表定义如下，其中`gdtdesc`指示了GDT表的入口

```asm
# Bootstrap GDT
.p2align 2                                          # force 4 byte alignment
gdt:
    SEG_NULLASM                                     # null seg
    SEG_ASM(STA_X|STA_R, 0x0, 0xffffffff)           # code seg for bootloader and kernel
    SEG_ASM(STA_W, 0x0, 0xffffffff)                 # data seg for bootloader and kernel

gdtdesc:
    .word 0x17                                      # sizeof(gdt) - 1
    .long gdt    
```

上面程序中gdt表项可以通过`asm.h`中的宏定义展开

```c
/* Normal segment */
#define SEG_NULLASM                                             \
    .word 0, 0;                                                 \
    .byte 0, 0, 0, 0

#define SEG_ASM(type,base,lim)                                  \
    .word (((lim) >> 12) & 0xffff), ((base) & 0xffff);          \
    .byte (((base) >> 16) & 0xff), (0x90 | (type)),             \
        (0xC0 | (((lim) >> 28) & 0xf)), (((base) >> 24) & 0xff)
```

通过对照`lab1/kern/mm/mmu.h`中对于`segdesc`的定义，可以对照理解。

```c
/* segment descriptors */                                                                                                          
struct segdesc {                                                                                                                   
    unsigned sd_lim_15_0 : 16;        // low bits of segment limit                                                                 
    unsigned sd_base_15_0 : 16;        // low bits of segment base address                                                         
    unsigned sd_base_23_16 : 8;        // middle bits of segment base address                                                      
    unsigned sd_type : 4;            // segment type (see STS_ constants)                                                          
    unsigned sd_s : 1;                // 0 = system, 1 = application                                                               
    unsigned sd_dpl : 2;            // descriptor Privilege Level                                                                  
    unsigned sd_p : 1;                // present                                                                                   
    unsigned sd_lim_19_16 : 4;        // high bits of segment limit                                                                
    unsigned sd_avl : 1;            // unused (available for software use)                                                         
    unsigned sd_rsv1 : 1;            // reserved                                                                                   
    unsigned sd_db : 1;                // 0 = 16-bit segment, 1 = 32-bit segment                                                   
    unsigned sd_g : 1;                // granularity: limit scaled by 4K when set                                                  
    unsigned sd_base_31_24 : 8;        // high bits of segment base address                                                        
};  
```

最终发现，此时的GDT段索引中，TEXT段、DATA段是重合的，都是整个地址空间，这其实是可以理解的，毕竟前期的初始化工作并不需要考虑安全性等问题。

[练习3-3]：如何使能和进入保护模式

在`lab1/boot/bootasm.S`源码中，对应了

```asm
movl %cr0, %eax                                                                                                                
orl $CR0_PE_ON, %eax                                                                                                           
movl %eax, %cr0                                                                                                                
```
其中，CR0是x86重要的控制寄存器，在[这里](https://en.wikipedia.org/wiki/Control_register)可以了解到，CR0的PE位用于指示保护模式(1)或实模式(0)，而通过`orl`操作，可以在不改变其他位的情况下，开启保护模式。

开启保护模式后，段寄存器并不会立即被加载，需要使用`ljmp`命令触发。

```asm
# Jump to next instruction, but in 32-bit code segment.                                                                        
# Switches processor into 32-bit mode.                                                                                         
ljmp $PROT_MODE_CSEG, $protcseg                                                                                                
```

## 练习4

通过阅读bootmain.c，了解bootloader如何加载ELF文件。通过分析源代码和通过qemu来运行并调试bootloader&OS，

[练习4-1]：bootloader如何读取硬盘扇区的？

在`bootmain.c`中，使用如下方式读取一个扇区

```c
/* waitdisk - wait for disk ready */                                                                                               
static void                                                                                                                        
waitdisk(void) {                                                                                                                   
    while ((inb(0x1F7) & 0xC0) != 0x40)                                                                                            
        /* do nothing */;                                                                                                          
}                                                                                                                                  
                                                                                                                                   
/* readsect - read a single sector at @secno into @dst */                                                                          
static void                                                                                                                        
readsect(void *dst, uint32_t secno) {                                                                                              
    // wait for disk to be ready                                                                                                   
    waitdisk();                                                                                                                    
                                                                                                                                   
    outb(0x1F2, 1);                         // count = 1                                                                           
    outb(0x1F3, secno & 0xFF);                                                                                                     
    outb(0x1F4, (secno >> 8) & 0xFF);                                                                                              
    outb(0x1F5, (secno >> 16) & 0xFF);                                                                                             
    outb(0x1F6, ((secno >> 24) & 0xF) | 0xE0);                                                                                     
    outb(0x1F7, 0x20);                      // cmd 0x20 - read sectors                                                             
                                                                                                                                   
    // wait for disk to be ready                                                                                                   
    waitdisk();                                                                                                                    
                                                                                                                                   
    // read a sector                                                                                                               
    insl(0x1F0, dst, SECTSIZE / 4);                                                                                                
}                                    
```

在上面的函数中，使用端口的方式和硬件交互，磁盘操作对应的端口为`0x01F0-0x01F7`，正是上面函数所使用的端口。

首先`waitdisk(void)`函数使用一个`while(true)`循环，检测某个读端口的值，判断磁盘是否完成上一次读写。

接下来，通过6个`outb`指令，将读取磁盘的指令以及相关参数交给磁盘。

此时，磁盘将按照命令，读取`secno`编号的1个扇区。接下来，一个`waitdisk`函数确认读取完毕。

最后，使用`insl`指令，将数据拷贝到dst位置。

使用`objdump`分析`bootmain.c`的汇编代码，也可以了解到`insl`命令的内部实现。其实就是一个字符串的拷贝。

```asm
  89:   fc                      cld                                                                                                
  8a:   f2 6d                   repnz insl (%dx),%es:(%edi)                                                                        
```

[练习4-2]：bootloader是如何加载ELF格式的OS？

相关函数如下

```c
void
bootmain(void) {
    // read the 1st page off disk
    readseg((uintptr_t)ELFHDR, SECTSIZE * 8, 0);

    // is this a valid ELF?
    if (ELFHDR->e_magic != ELF_MAGIC) {
        goto bad;
    }

    struct proghdr *ph, *eph;

    // load each program segment (ignores ph flags)
    ph = (struct proghdr *)((uintptr_t)ELFHDR + ELFHDR->e_phoff);
    eph = ph + ELFHDR->e_phnum;
    for (; ph < eph; ph ++) {
        readseg(ph->p_va & 0xFFFFFF, ph->p_memsz, ph->p_offset);
    }

    // call the entry point from the ELF header
    // note: does not return
    ((void (*)(void))(ELFHDR->e_entry & 0xFFFFFF))();

bad:
    outw(0x8A00, 0x8A00);
    outw(0x8A00, 0x8E00);

    /* do nothing */
    while (1);
}
```

首先，在`ucore.img`生成时，已经保证了`kernel`源码被放置在了`0x10000`位置，即文中`ELFHDR`指针指向的位置，故第4行`readseg((uintptr_t)ELFHDR, SECTSIZE * 8, 0);`可直接读取到`kernel`对应的ELF文件的头部，此时，检查`e_magic`域以确定这是不是真的是一个合法的ELF文件。从ELF头中，可以度去出代码扇区总数`ELF_HDR->e_phnum`，按照该数值，可以逐一加载所有扇区，加载完毕后，调至`ELFHDR->e_entry`指示的位置即可。

## 练习5

实际输出如下

```text
Kernel executable memory footprint: 64KB
ebp:0x00007b38 eip:0x00100a3d args:0x00007b48 0x00100d03 0x00010094 0x00010094
    kern/debug/kdebug.c:306: print_stackframe+22
ebp:0x00007b48 eip:0x00100d03 args:0x00007b68 0x0010007f 0x00000000 0x00000000
    kern/debug/kmonitor.c:125: mon_backtrace+10
ebp:0x00007b68 eip:0x0010007f args:0x00007b88 0x001000a1 0x00000000 0x00007b90
    kern/init/init.c:48: grade_backtrace2+19
ebp:0x00007b88 eip:0x001000a1 args:0x00007ba8 0x001000be 0x00000000 0xffff0000
    kern/init/init.c:53: grade_backtrace1+27
ebp:0x00007ba8 eip:0x001000be args:0x00007bc8 0x001000df 0x00000000 0x00100000
    kern/init/init.c:58: grade_backtrace0+19
ebp:0x00007bc8 eip:0x001000df args:0x00007be8 0x00100050 0x00000000 0x00000000
    kern/init/init.c:63: grade_backtrace+26
ebp:0x00007be8 eip:0x00100050 args:0x00007bf8 0x00007d6e 0x00000000 0x00000000
    kern/init/init.c:28: kern_init+79
ebp:0x00007bf8 eip:0x00007d6e args:0x00000000 0x00007c4f 0xc031fcfa 0xc08ed88e
    <unknow>: -- 0x00007d6d --
```

其中，最后一行`<unknow>: -- 0x00007d6d --`中的数值，实际上为倒数第二行的`eip`数值加一。仅仅由于该地址位于`bootblock`中，没有对应的C语言函数信息，从而输出的`<unknow>`。

在`obj/bootblock.asm`中，可以找到该位置的上下文——

```asm
    // call the entry point from the ELF header
    // note: does not return
    ((void (*)(void))(ELFHDR->e_entry & 0xFFFFFF))();
    7d62:       a1 18 00 01 00          mov    0x10018,%eax
    7d67:       25 ff ff ff 00          and    $0xffffff,%eax
    7d6c:       ff d0                   call   *%eax
```

正是`kernel`的上一层调用位置加一。

## 练习6

[练习6-1]：中断描述符表（也可简称为保护模式下的中断向量表）中一个表项占多少字节？其中哪几位代表中断处理代码的入口？

中断描述符`idt`是一个`gatedesc`数组，而`gatedesc`定义如下

```c
/* Gate descriptors for interrupts and traps */                                                                                    
struct gatedesc {                                                                                                                  
    unsigned gd_off_15_0 : 16;        // low 16 bits of offset in segment                                                          
    unsigned gd_ss : 16;            // segment selector                                                                            
    unsigned gd_args : 5;            // # args, 0 for interrupt/trap gates                                                         
    unsigned gd_rsv1 : 3;            // reserved(should be zero I guess)                                                           
    unsigned gd_type : 4;            // type(STS_{TG,IG32,TG32})                                                                   
    unsigned gd_s : 1;                // must be 0 (system)                                                                        
    unsigned gd_dpl : 2;            // descriptor(meaning new) privilege level                                                     
    unsigned gd_p : 1;                // Present                                                                                   
    unsigned gd_off_31_16 : 16;        // high bits of offset in segment                                                           
};                                                                                                                                 
```

加总发现，占用8个字节。

[练习6-2]：请编程完善kern/trap/trap.c中对中断向量表进行初始化的函数idt_init。在idt_init函数中，依次对所有中断入口进行初始化。使用mmu.h中的SETGATE宏，填充idt数组内容。每个中断的入口由tools/vectors.c生成，使用trap.c中声明的vectors数组即可。

略，见代码

[练习6-3]：请编程完善trap.c中的中断处理函数trap，在对时钟中断进行处理的部分填写trap函数中处理时钟中断的部分，使操作系统每遇到100次时钟中断后，调用print_ticks子程序，向屏幕上打印一行文字”100 ticks”。

略，见代码

## 拓展练习

[拓展练习1]：扩展proj4,增加syscall功能，即增加一用户态函数（可执行一特定系统调用：获得时钟计数值），当内核初始完毕后，可从内核态返回到用户态的函数，而用户态的函数又通过系统调用得到内核态的服务（通过网络查询所需信息，可找老师咨询。如果完成，且有兴趣做代替考试的实验，可找老师商量）。需写出详细的设计和分析报告。完成出色的可获得适当加分。


`trapframe`结构体定义如下——

```c
struct trapframe {
    struct pushregs tf_regs;
    uint16_t tf_gs;
    uint16_t tf_padding0;
    uint16_t tf_fs;
    uint16_t tf_padding1;
    uint16_t tf_es;
    uint16_t tf_padding2;
    uint16_t tf_ds;
    uint16_t tf_padding3;
    uint32_t tf_trapno;
    /* below here defined by x86 hardware */
    uint32_t tf_err;
    uintptr_t tf_eip;
    uint16_t tf_cs;
    uint16_t tf_padding4;
    uint32_t tf_eflags;
    /* below here only when crossing rings, such as from user to kernel */
    uintptr_t tf_esp;
    uint16_t tf_ss;
    uint16_t tf_padding5;
} __attribute__((packed));
```

其中`tf_err`和`tf_trapno`在`vector.S`中，被压入栈中。

```
.globl vector149                                                                                                                   
vector149:                                                                                                                         
  pushl $0                                                                                                                         
  pushl $149                                                                                                                       
  jmp __alltraps  
```

`tf_ds`,`tf_es`,`tf_fs`,`tf_gs`在`trapentry.S`中被赋值

```
.globl __alltraps                                                                                                                  
__alltraps:                                                                                                                        
    # push registers to build a trap frame                                                                                         
    # therefore make the stack look like a struct trapframe                                                                        
    pushl %ds                                                                                                                      
    pushl %es
    pushl %fs
    pushl %gs
    pushal

    # load GD_KDATA into %ds and %es to set up data segments for kernel
    movl $GD_KDATA, %eax
    movw %ax, %ds
    movw %ax, %es

    # push %esp to pass a pointer to the trapframe as an argument to trap()
    pushl %esp

    # call trap(tf), where tf=%esp
    call trap

    # pop the pushed stack pointer
    popl %esp

    # return falls through to trapret...
```

即，在`trap`函数被调用时，栈内情况如下

| 内存数据 | 产生者 |
| ------ | ---- |
| esp | hardware |
| ss | hardware |
| eflags | hardware |
| cs | hardware |
| eip | hardware |
| err | vector.S |
| trapno | vector.S |
| ds | trapentry.S |
| es | trapentry.S |
| fs | trapentry.S |
| gs | trapentry.S |
| addr\_of\_gs | pushl %esp | 
| ret\_addr\_from\_trap | call trap |

在`trap_dispatch`被调用时，且更新`%ebp`后，栈内情况如下

| 内存数据 | 产生者 | hint |
| ------ | ---- | ---- |
| esp | hardware | 
| ss | hardware |
| eflags | hardware |
| cs | hardware |
| eip | hardware |
| err | vector.S |
| trapno | vector.S |
| ds | trapentry.S |
| es | trapentry.S |
| fs | trapentry.S |
| gs | trapentry.S |
| reg_eax | trapentry.S |
| reg_ecx | trapentry.S |
| reg_edx | trapentry.S |
| reg_ebx | trapentry.S |
| reg_oesp | trapentry.S |
| reg_ebp | trapentry.S |
| reg_esi | trapentry.S |
| reg_edi | trapentry.S | `trapframe` addr |
| addr\_of\_trap\_frame | pushl %esp | tf |
| `trap()` rip | call trap |
| old_ebp | trap() | <-ebp of `trap()` |
| ??? | trap() -`subl $0x8,%esp` |
| ??? |
| ??? | trap() -`subl $0xc,%esp` |
| ??? |
| ??? |
| addr\_of\_trap\_frame | trap()-`pushl 0x8(%ebp)`|
| `trap_dispatch()` rip | 
| ebp | trap\_dispatch() | `trap_dispatch()` ebp |
| ??? | trap\_dispatch()-`subl $0x18,%esp` |
| ??? |
| ??? |
| ??? |
| ??? |
| ??? | | esp |

从上表可以发现，倘若trap程序需要修改后续的上下文，可直接使用新的`trapframe`结构体替换`trapframe_addr`处的结构体即可。在C函数中，使用`((uint32_t*)tf-1)`索引。对于`trapframe`结构体，我们一次需要修改`ds`,`es`,`gs`,`fs`和`esp`。

需要理解修改的方式，需要先学习`iret`指令的含义，在[IRET - Interrupt Return](http://faydoc.tripod.com/cpu/iret.htm)中有叙述

> If the return is to another privilege level, the IRET instruction also pops the stack pointer and SS from the stack, before resuming program execution. If the return is to virtual-8086 mode, the processor also pops the data segment registers from the stack.

故，对于优先级切换的程序，我们需要通过设置`ss`，`esp`实现iret后栈顶指针的目的地的设置。

```c
userframe.tf_ss = USER_DS;
userframe.tf_esp = (uint32_t)tf + sizeof(struct trapframe) - 8; 
```
同时，还需要设定[I/O Privilege level](https://en.wikipedia.org/wiki/Protection_ring#IOPL)，由于本题是在0、3优先级中切换，因此，在`trap_dispatch()`函数中，需要对IOPL位进行设置。

```c
userframe.tf_eflags |= FL_IOPL_MASK;                                                                                   
```

[拓展练习2]：用键盘实现用户模式内核模式切换。具体目标是：“键盘输入3时切换到用户模式，键盘输入0时切换到内核模式”。 基本思路是借鉴软中断(syscall功能)的代码，并且把trap.c中软中断处理的设置语句拿过来。

曾经尝试使用`int`实现，但是由于一直出现`general protection`，从而无法成功。

后来直接在键盘中断触发后，调用上一问的`trapframe`，即可很轻松完成本练习。

```c
c = cons_getc();                                                                                                           
cprintf("kbd [%03d] %c\n", c, c);                                                                                          
if (c == '3') {                                                                                                            
    //__asm__ ("int %0\n" : : "N"(T_SWITCH_TOU));                                                                          
    if (tf->tf_cs == KERNEL_CS) {                                                                                          
        cprintf("T_SWITH_TOU\n");                                                                                          
        userframe =  *tf;                                                                                                  
        userframe.tf_cs = USER_CS;                                                                                         
        userframe.tf_ds = USER_DS;                                                                                         
        userframe.tf_es = USER_DS;                                                                                         
        userframe.tf_ss = USER_DS;                                                                                         
        //userframe.tf_fs = USER_DS;                                                                                       
        userframe.tf_eflags |= FL_IOPL_MASK;                                                                               
        userframe.tf_esp = (uint32_t)tf + sizeof(struct trapframe) - 8;                                                    
        *((uint32_t *)tf - 1) = (uint32_t)&userframe;//???                                                                 
    }                                                                                                                      
} else if (c == '0') {                                                                                                     
    //__asm__ ("int %0\n" : : "N"(T_SWITCH_TOK));                                                                          
    if (tf->tf_cs == USER_CS) {                                                                                            
        cprintf("T_SWITH_TOK\n");                                                                                          
        tf->tf_cs = KERNEL_CS;                                                                                             
        tf->tf_ds = tf->tf_es = KERNEL_DS;                                                                                 
        //tf->tf_ss = KERNEL_DS;                                                                                           
        tf->tf_eflags &= ~FL_IOPL_MASK;                                                                                    
                                                                                                                           
        kernelframe = (uint32_t)tf->tf_esp - (sizeof(struct trapframe) - 8);                                               
        memmove(kernelframe, tf, sizeof(struct trapframe) - 8);                                                            
        *((uint32_t *)tf - 1) = (uint32_t)kernelframe;//???                                                                
    }                                                                                                                      
}                                
```

## 与标准答案对照

我的实现与标准答案主要有如下区别——

* 所有的类似于`lidt`这类汇编指令，标准答案直接用的C函数，但是我不知道，都是使用的内嵌汇编实现的。
* Challenge2标准答案没有做

## 重要知识点

* “镜像”的含义，之前我一直不知道为什么需要把一个系统打包成为镜像
* BIOS引导
* GDT和IDT，这两点同时是OS原理中的重要知识点，在实验中，更加偏重于对于表项的初始化处理，而对表的索引都丢给了CPU做了。而OS课程则会更加系统介绍CPU如何解析并且使用这些表项。
* trap，这个我感觉OS课程讲的完全不够，而试验对这个的考察非常细。

## 试验未覆盖的点

* 中断、异常、系统调用的区别应该能够在实验中体现。
