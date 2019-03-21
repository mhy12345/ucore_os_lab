
trap.o:     file format elf32-i386


Disassembly of section .text:

00000000 <print_ticks>:
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 08             	sub    $0x8,%esp
   6:	83 ec 08             	sub    $0x8,%esp
   9:	6a 64                	push   $0x64
   b:	68 00 00 00 00       	push   $0x0
  10:	e8 fc ff ff ff       	call   11 <print_ticks+0x11>
  15:	83 c4 10             	add    $0x10,%esp
  18:	90                   	nop
  19:	c9                   	leave  
  1a:	c3                   	ret    

0000001b <idt_init>:
  1b:	55                   	push   %ebp
  1c:	89 e5                	mov    %esp,%ebp
  1e:	83 ec 10             	sub    $0x10,%esp
  21:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  28:	e9 c3 00 00 00       	jmp    f0 <idt_init+0xd5>
  2d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  30:	8b 04 85 00 00 00 00 	mov    0x0(,%eax,4),%eax
  37:	89 c2                	mov    %eax,%edx
  39:	8b 45 fc             	mov    -0x4(%ebp),%eax
  3c:	66 89 14 c5 00 00 00 	mov    %dx,0x0(,%eax,8)
  43:	00 
  44:	8b 45 fc             	mov    -0x4(%ebp),%eax
  47:	66 c7 04 c5 02 00 00 	movw   $0x8,0x2(,%eax,8)
  4e:	00 08 00 
  51:	8b 45 fc             	mov    -0x4(%ebp),%eax
  54:	0f b6 14 c5 04 00 00 	movzbl 0x4(,%eax,8),%edx
  5b:	00 
  5c:	83 e2 e0             	and    $0xffffffe0,%edx
  5f:	88 14 c5 04 00 00 00 	mov    %dl,0x4(,%eax,8)
  66:	8b 45 fc             	mov    -0x4(%ebp),%eax
  69:	0f b6 14 c5 04 00 00 	movzbl 0x4(,%eax,8),%edx
  70:	00 
  71:	83 e2 1f             	and    $0x1f,%edx
  74:	88 14 c5 04 00 00 00 	mov    %dl,0x4(,%eax,8)
  7b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  7e:	0f b6 14 c5 05 00 00 	movzbl 0x5(,%eax,8),%edx
  85:	00 
  86:	83 e2 f0             	and    $0xfffffff0,%edx
  89:	83 ca 0e             	or     $0xe,%edx
  8c:	88 14 c5 05 00 00 00 	mov    %dl,0x5(,%eax,8)
  93:	8b 45 fc             	mov    -0x4(%ebp),%eax
  96:	0f b6 14 c5 05 00 00 	movzbl 0x5(,%eax,8),%edx
  9d:	00 
  9e:	83 e2 ef             	and    $0xffffffef,%edx
  a1:	88 14 c5 05 00 00 00 	mov    %dl,0x5(,%eax,8)
  a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
  ab:	0f b6 14 c5 05 00 00 	movzbl 0x5(,%eax,8),%edx
  b2:	00 
  b3:	83 e2 9f             	and    $0xffffff9f,%edx
  b6:	88 14 c5 05 00 00 00 	mov    %dl,0x5(,%eax,8)
  bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
  c0:	0f b6 14 c5 05 00 00 	movzbl 0x5(,%eax,8),%edx
  c7:	00 
  c8:	83 ca 80             	or     $0xffffff80,%edx
  cb:	88 14 c5 05 00 00 00 	mov    %dl,0x5(,%eax,8)
  d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  d5:	8b 04 85 00 00 00 00 	mov    0x0(,%eax,4),%eax
  dc:	c1 e8 10             	shr    $0x10,%eax
  df:	89 c2                	mov    %eax,%edx
  e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  e4:	66 89 14 c5 06 00 00 	mov    %dx,0x6(,%eax,8)
  eb:	00 
  ec:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
  f3:	3d ff 00 00 00       	cmp    $0xff,%eax
  f8:	0f 86 2f ff ff ff    	jbe    2d <idt_init+0x12>
  fe:	a1 e4 01 00 00       	mov    0x1e4,%eax
 103:	66 a3 c8 03 00 00    	mov    %ax,0x3c8
 109:	66 c7 05 ca 03 00 00 	movw   $0x8,0x3ca
 110:	08 00 
 112:	0f b6 05 cc 03 00 00 	movzbl 0x3cc,%eax
 119:	83 e0 e0             	and    $0xffffffe0,%eax
 11c:	a2 cc 03 00 00       	mov    %al,0x3cc
 121:	0f b6 05 cc 03 00 00 	movzbl 0x3cc,%eax
 128:	83 e0 1f             	and    $0x1f,%eax
 12b:	a2 cc 03 00 00       	mov    %al,0x3cc
 130:	0f b6 05 cd 03 00 00 	movzbl 0x3cd,%eax
 137:	83 e0 f0             	and    $0xfffffff0,%eax
 13a:	83 c8 0e             	or     $0xe,%eax
 13d:	a2 cd 03 00 00       	mov    %al,0x3cd
 142:	0f b6 05 cd 03 00 00 	movzbl 0x3cd,%eax
 149:	83 e0 ef             	and    $0xffffffef,%eax
 14c:	a2 cd 03 00 00       	mov    %al,0x3cd
 151:	0f b6 05 cd 03 00 00 	movzbl 0x3cd,%eax
 158:	83 c8 60             	or     $0x60,%eax
 15b:	a2 cd 03 00 00       	mov    %al,0x3cd
 160:	0f b6 05 cd 03 00 00 	movzbl 0x3cd,%eax
 167:	83 c8 80             	or     $0xffffff80,%eax
 16a:	a2 cd 03 00 00       	mov    %al,0x3cd
 16f:	a1 e4 01 00 00       	mov    0x1e4,%eax
 174:	c1 e8 10             	shr    $0x10,%eax
 177:	66 a3 ce 03 00 00    	mov    %ax,0x3ce
 17d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
 184:	8b 45 f8             	mov    -0x8(%ebp),%eax
 187:	0f 01 18             	lidtl  (%eax)
 18a:	90                   	nop
 18b:	c9                   	leave  
 18c:	c3                   	ret    

0000018d <trapname>:
 18d:	55                   	push   %ebp
 18e:	89 e5                	mov    %esp,%ebp
 190:	8b 45 08             	mov    0x8(%ebp),%eax
 193:	83 f8 13             	cmp    $0x13,%eax
 196:	77 0c                	ja     1a4 <trapname+0x17>
 198:	8b 45 08             	mov    0x8(%ebp),%eax
 19b:	8b 04 85 60 03 00 00 	mov    0x360(,%eax,4),%eax
 1a2:	eb 18                	jmp    1bc <trapname+0x2f>
 1a4:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
 1a8:	7e 0d                	jle    1b7 <trapname+0x2a>
 1aa:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
 1ae:	7f 07                	jg     1b7 <trapname+0x2a>
 1b0:	b8 0a 00 00 00       	mov    $0xa,%eax
 1b5:	eb 05                	jmp    1bc <trapname+0x2f>
 1b7:	b8 1d 00 00 00       	mov    $0x1d,%eax
 1bc:	5d                   	pop    %ebp
 1bd:	c3                   	ret    

000001be <trap_in_kernel>:
 1be:	55                   	push   %ebp
 1bf:	89 e5                	mov    %esp,%ebp
 1c1:	8b 45 08             	mov    0x8(%ebp),%eax
 1c4:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
 1c8:	66 83 f8 08          	cmp    $0x8,%ax
 1cc:	0f 94 c0             	sete   %al
 1cf:	0f b6 c0             	movzbl %al,%eax
 1d2:	5d                   	pop    %ebp
 1d3:	c3                   	ret    

000001d4 <print_trapframe>:
 1d4:	55                   	push   %ebp
 1d5:	89 e5                	mov    %esp,%ebp
 1d7:	83 ec 18             	sub    $0x18,%esp
 1da:	83 ec 08             	sub    $0x8,%esp
 1dd:	ff 75 08             	pushl  0x8(%ebp)
 1e0:	68 5e 00 00 00       	push   $0x5e
 1e5:	e8 fc ff ff ff       	call   1e6 <print_trapframe+0x12>
 1ea:	83 c4 10             	add    $0x10,%esp
 1ed:	8b 45 08             	mov    0x8(%ebp),%eax
 1f0:	83 ec 0c             	sub    $0xc,%esp
 1f3:	50                   	push   %eax
 1f4:	e8 fc ff ff ff       	call   1f5 <print_trapframe+0x21>
 1f9:	83 c4 10             	add    $0x10,%esp
 1fc:	8b 45 08             	mov    0x8(%ebp),%eax
 1ff:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
 203:	0f b7 c0             	movzwl %ax,%eax
 206:	83 ec 08             	sub    $0x8,%esp
 209:	50                   	push   %eax
 20a:	68 6f 00 00 00       	push   $0x6f
 20f:	e8 fc ff ff ff       	call   210 <print_trapframe+0x3c>
 214:	83 c4 10             	add    $0x10,%esp
 217:	8b 45 08             	mov    0x8(%ebp),%eax
 21a:	0f b7 40 28          	movzwl 0x28(%eax),%eax
 21e:	0f b7 c0             	movzwl %ax,%eax
 221:	83 ec 08             	sub    $0x8,%esp
 224:	50                   	push   %eax
 225:	68 82 00 00 00       	push   $0x82
 22a:	e8 fc ff ff ff       	call   22b <print_trapframe+0x57>
 22f:	83 c4 10             	add    $0x10,%esp
 232:	8b 45 08             	mov    0x8(%ebp),%eax
 235:	0f b7 40 24          	movzwl 0x24(%eax),%eax
 239:	0f b7 c0             	movzwl %ax,%eax
 23c:	83 ec 08             	sub    $0x8,%esp
 23f:	50                   	push   %eax
 240:	68 95 00 00 00       	push   $0x95
 245:	e8 fc ff ff ff       	call   246 <print_trapframe+0x72>
 24a:	83 c4 10             	add    $0x10,%esp
 24d:	8b 45 08             	mov    0x8(%ebp),%eax
 250:	0f b7 40 20          	movzwl 0x20(%eax),%eax
 254:	0f b7 c0             	movzwl %ax,%eax
 257:	83 ec 08             	sub    $0x8,%esp
 25a:	50                   	push   %eax
 25b:	68 a8 00 00 00       	push   $0xa8
 260:	e8 fc ff ff ff       	call   261 <print_trapframe+0x8d>
 265:	83 c4 10             	add    $0x10,%esp
 268:	8b 45 08             	mov    0x8(%ebp),%eax
 26b:	8b 40 30             	mov    0x30(%eax),%eax
 26e:	83 ec 0c             	sub    $0xc,%esp
 271:	50                   	push   %eax
 272:	e8 16 ff ff ff       	call   18d <trapname>
 277:	83 c4 10             	add    $0x10,%esp
 27a:	89 c2                	mov    %eax,%edx
 27c:	8b 45 08             	mov    0x8(%ebp),%eax
 27f:	8b 40 30             	mov    0x30(%eax),%eax
 282:	83 ec 04             	sub    $0x4,%esp
 285:	52                   	push   %edx
 286:	50                   	push   %eax
 287:	68 bb 00 00 00       	push   $0xbb
 28c:	e8 fc ff ff ff       	call   28d <print_trapframe+0xb9>
 291:	83 c4 10             	add    $0x10,%esp
 294:	8b 45 08             	mov    0x8(%ebp),%eax
 297:	8b 40 34             	mov    0x34(%eax),%eax
 29a:	83 ec 08             	sub    $0x8,%esp
 29d:	50                   	push   %eax
 29e:	68 cd 00 00 00       	push   $0xcd
 2a3:	e8 fc ff ff ff       	call   2a4 <print_trapframe+0xd0>
 2a8:	83 c4 10             	add    $0x10,%esp
 2ab:	8b 45 08             	mov    0x8(%ebp),%eax
 2ae:	8b 40 38             	mov    0x38(%eax),%eax
 2b1:	83 ec 08             	sub    $0x8,%esp
 2b4:	50                   	push   %eax
 2b5:	68 dc 00 00 00       	push   $0xdc
 2ba:	e8 fc ff ff ff       	call   2bb <print_trapframe+0xe7>
 2bf:	83 c4 10             	add    $0x10,%esp
 2c2:	8b 45 08             	mov    0x8(%ebp),%eax
 2c5:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
 2c9:	0f b7 c0             	movzwl %ax,%eax
 2cc:	83 ec 08             	sub    $0x8,%esp
 2cf:	50                   	push   %eax
 2d0:	68 eb 00 00 00       	push   $0xeb
 2d5:	e8 fc ff ff ff       	call   2d6 <print_trapframe+0x102>
 2da:	83 c4 10             	add    $0x10,%esp
 2dd:	8b 45 08             	mov    0x8(%ebp),%eax
 2e0:	8b 40 40             	mov    0x40(%eax),%eax
 2e3:	83 ec 08             	sub    $0x8,%esp
 2e6:	50                   	push   %eax
 2e7:	68 fe 00 00 00       	push   $0xfe
 2ec:	e8 fc ff ff ff       	call   2ed <print_trapframe+0x119>
 2f1:	83 c4 10             	add    $0x10,%esp
 2f4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2fb:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
 302:	eb 3f                	jmp    343 <print_trapframe+0x16f>
 304:	8b 45 08             	mov    0x8(%ebp),%eax
 307:	8b 50 40             	mov    0x40(%eax),%edx
 30a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 30d:	21 d0                	and    %edx,%eax
 30f:	85 c0                	test   %eax,%eax
 311:	74 29                	je     33c <print_trapframe+0x168>
 313:	8b 45 f4             	mov    -0xc(%ebp),%eax
 316:	8b 04 85 20 00 00 00 	mov    0x20(,%eax,4),%eax
 31d:	85 c0                	test   %eax,%eax
 31f:	74 1b                	je     33c <print_trapframe+0x168>
 321:	8b 45 f4             	mov    -0xc(%ebp),%eax
 324:	8b 04 85 20 00 00 00 	mov    0x20(,%eax,4),%eax
 32b:	83 ec 08             	sub    $0x8,%esp
 32e:	50                   	push   %eax
 32f:	68 0d 01 00 00       	push   $0x10d
 334:	e8 fc ff ff ff       	call   335 <print_trapframe+0x161>
 339:	83 c4 10             	add    $0x10,%esp
 33c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 340:	d1 65 f0             	shll   -0x10(%ebp)
 343:	8b 45 f4             	mov    -0xc(%ebp),%eax
 346:	83 f8 17             	cmp    $0x17,%eax
 349:	76 b9                	jbe    304 <print_trapframe+0x130>
 34b:	8b 45 08             	mov    0x8(%ebp),%eax
 34e:	8b 40 40             	mov    0x40(%eax),%eax
 351:	c1 e8 0c             	shr    $0xc,%eax
 354:	83 e0 03             	and    $0x3,%eax
 357:	83 ec 08             	sub    $0x8,%esp
 35a:	50                   	push   %eax
 35b:	68 11 01 00 00       	push   $0x111
 360:	e8 fc ff ff ff       	call   361 <print_trapframe+0x18d>
 365:	83 c4 10             	add    $0x10,%esp
 368:	83 ec 0c             	sub    $0xc,%esp
 36b:	ff 75 08             	pushl  0x8(%ebp)
 36e:	e8 fc ff ff ff       	call   36f <print_trapframe+0x19b>
 373:	83 c4 10             	add    $0x10,%esp
 376:	85 c0                	test   %eax,%eax
 378:	75 32                	jne    3ac <print_trapframe+0x1d8>
 37a:	8b 45 08             	mov    0x8(%ebp),%eax
 37d:	8b 40 44             	mov    0x44(%eax),%eax
 380:	83 ec 08             	sub    $0x8,%esp
 383:	50                   	push   %eax
 384:	68 1a 01 00 00       	push   $0x11a
 389:	e8 fc ff ff ff       	call   38a <print_trapframe+0x1b6>
 38e:	83 c4 10             	add    $0x10,%esp
 391:	8b 45 08             	mov    0x8(%ebp),%eax
 394:	0f b7 40 48          	movzwl 0x48(%eax),%eax
 398:	0f b7 c0             	movzwl %ax,%eax
 39b:	83 ec 08             	sub    $0x8,%esp
 39e:	50                   	push   %eax
 39f:	68 29 01 00 00       	push   $0x129
 3a4:	e8 fc ff ff ff       	call   3a5 <print_trapframe+0x1d1>
 3a9:	83 c4 10             	add    $0x10,%esp
 3ac:	90                   	nop
 3ad:	c9                   	leave  
 3ae:	c3                   	ret    

000003af <print_regs>:
 3af:	55                   	push   %ebp
 3b0:	89 e5                	mov    %esp,%ebp
 3b2:	83 ec 08             	sub    $0x8,%esp
 3b5:	8b 45 08             	mov    0x8(%ebp),%eax
 3b8:	8b 00                	mov    (%eax),%eax
 3ba:	83 ec 08             	sub    $0x8,%esp
 3bd:	50                   	push   %eax
 3be:	68 3c 01 00 00       	push   $0x13c
 3c3:	e8 fc ff ff ff       	call   3c4 <print_regs+0x15>
 3c8:	83 c4 10             	add    $0x10,%esp
 3cb:	8b 45 08             	mov    0x8(%ebp),%eax
 3ce:	8b 40 04             	mov    0x4(%eax),%eax
 3d1:	83 ec 08             	sub    $0x8,%esp
 3d4:	50                   	push   %eax
 3d5:	68 4b 01 00 00       	push   $0x14b
 3da:	e8 fc ff ff ff       	call   3db <print_regs+0x2c>
 3df:	83 c4 10             	add    $0x10,%esp
 3e2:	8b 45 08             	mov    0x8(%ebp),%eax
 3e5:	8b 40 08             	mov    0x8(%eax),%eax
 3e8:	83 ec 08             	sub    $0x8,%esp
 3eb:	50                   	push   %eax
 3ec:	68 5a 01 00 00       	push   $0x15a
 3f1:	e8 fc ff ff ff       	call   3f2 <print_regs+0x43>
 3f6:	83 c4 10             	add    $0x10,%esp
 3f9:	8b 45 08             	mov    0x8(%ebp),%eax
 3fc:	8b 40 0c             	mov    0xc(%eax),%eax
 3ff:	83 ec 08             	sub    $0x8,%esp
 402:	50                   	push   %eax
 403:	68 69 01 00 00       	push   $0x169
 408:	e8 fc ff ff ff       	call   409 <print_regs+0x5a>
 40d:	83 c4 10             	add    $0x10,%esp
 410:	8b 45 08             	mov    0x8(%ebp),%eax
 413:	8b 40 10             	mov    0x10(%eax),%eax
 416:	83 ec 08             	sub    $0x8,%esp
 419:	50                   	push   %eax
 41a:	68 78 01 00 00       	push   $0x178
 41f:	e8 fc ff ff ff       	call   420 <print_regs+0x71>
 424:	83 c4 10             	add    $0x10,%esp
 427:	8b 45 08             	mov    0x8(%ebp),%eax
 42a:	8b 40 14             	mov    0x14(%eax),%eax
 42d:	83 ec 08             	sub    $0x8,%esp
 430:	50                   	push   %eax
 431:	68 87 01 00 00       	push   $0x187
 436:	e8 fc ff ff ff       	call   437 <print_regs+0x88>
 43b:	83 c4 10             	add    $0x10,%esp
 43e:	8b 45 08             	mov    0x8(%ebp),%eax
 441:	8b 40 18             	mov    0x18(%eax),%eax
 444:	83 ec 08             	sub    $0x8,%esp
 447:	50                   	push   %eax
 448:	68 96 01 00 00       	push   $0x196
 44d:	e8 fc ff ff ff       	call   44e <print_regs+0x9f>
 452:	83 c4 10             	add    $0x10,%esp
 455:	8b 45 08             	mov    0x8(%ebp),%eax
 458:	8b 40 1c             	mov    0x1c(%eax),%eax
 45b:	83 ec 08             	sub    $0x8,%esp
 45e:	50                   	push   %eax
 45f:	68 a5 01 00 00       	push   $0x1a5
 464:	e8 fc ff ff ff       	call   465 <print_regs+0xb6>
 469:	83 c4 10             	add    $0x10,%esp
 46c:	90                   	nop
 46d:	c9                   	leave  
 46e:	c3                   	ret    

0000046f <trap_dispatch>:
 46f:	55                   	push   %ebp
 470:	89 e5                	mov    %esp,%ebp
 472:	57                   	push   %edi
 473:	56                   	push   %esi
 474:	53                   	push   %ebx
 475:	83 ec 1c             	sub    $0x1c,%esp
 478:	8b 45 08             	mov    0x8(%ebp),%eax
 47b:	8b 40 30             	mov    0x30(%eax),%eax
 47e:	83 f8 2f             	cmp    $0x2f,%eax
 481:	77 21                	ja     4a4 <trap_dispatch+0x35>
 483:	83 f8 2e             	cmp    $0x2e,%eax
 486:	0f 83 ff 01 00 00    	jae    68b <trap_dispatch+0x21c>
 48c:	83 f8 21             	cmp    $0x21,%eax
 48f:	0f 84 87 00 00 00    	je     51c <trap_dispatch+0xad>
 495:	83 f8 24             	cmp    $0x24,%eax
 498:	74 5b                	je     4f5 <trap_dispatch+0x86>
 49a:	83 f8 20             	cmp    $0x20,%eax
 49d:	74 1c                	je     4bb <trap_dispatch+0x4c>
 49f:	e9 b1 01 00 00       	jmp    655 <trap_dispatch+0x1e6>
 4a4:	83 f8 78             	cmp    $0x78,%eax
 4a7:	0f 84 96 00 00 00    	je     543 <trap_dispatch+0xd4>
 4ad:	83 f8 79             	cmp    $0x79,%eax
 4b0:	0f 84 29 01 00 00    	je     5df <trap_dispatch+0x170>
 4b6:	e9 9a 01 00 00       	jmp    655 <trap_dispatch+0x1e6>
 4bb:	a1 00 00 00 00       	mov    0x0,%eax
 4c0:	83 c0 01             	add    $0x1,%eax
 4c3:	a3 00 00 00 00       	mov    %eax,0x0
 4c8:	8b 0d 00 00 00 00    	mov    0x0,%ecx
 4ce:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
 4d3:	89 c8                	mov    %ecx,%eax
 4d5:	f7 e2                	mul    %edx
 4d7:	89 d0                	mov    %edx,%eax
 4d9:	c1 e8 05             	shr    $0x5,%eax
 4dc:	6b c0 64             	imul   $0x64,%eax,%eax
 4df:	29 c1                	sub    %eax,%ecx
 4e1:	89 c8                	mov    %ecx,%eax
 4e3:	85 c0                	test   %eax,%eax
 4e5:	0f 85 a3 01 00 00    	jne    68e <trap_dispatch+0x21f>
 4eb:	e8 10 fb ff ff       	call   0 <print_ticks>
 4f0:	e9 99 01 00 00       	jmp    68e <trap_dispatch+0x21f>
 4f5:	e8 fc ff ff ff       	call   4f6 <trap_dispatch+0x87>
 4fa:	88 45 e7             	mov    %al,-0x19(%ebp)
 4fd:	0f be 55 e7          	movsbl -0x19(%ebp),%edx
 501:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
 505:	83 ec 04             	sub    $0x4,%esp
 508:	52                   	push   %edx
 509:	50                   	push   %eax
 50a:	68 b4 01 00 00       	push   $0x1b4
 50f:	e8 fc ff ff ff       	call   510 <trap_dispatch+0xa1>
 514:	83 c4 10             	add    $0x10,%esp
 517:	e9 79 01 00 00       	jmp    695 <trap_dispatch+0x226>
 51c:	e8 fc ff ff ff       	call   51d <trap_dispatch+0xae>
 521:	88 45 e7             	mov    %al,-0x19(%ebp)
 524:	0f be 55 e7          	movsbl -0x19(%ebp),%edx
 528:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
 52c:	83 ec 04             	sub    $0x4,%esp
 52f:	52                   	push   %edx
 530:	50                   	push   %eax
 531:	68 c6 01 00 00       	push   $0x1c6
 536:	e8 fc ff ff ff       	call   537 <trap_dispatch+0xc8>
 53b:	83 c4 10             	add    $0x10,%esp
 53e:	e9 52 01 00 00       	jmp    695 <trap_dispatch+0x226>
 543:	8b 45 08             	mov    0x8(%ebp),%eax
 546:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
 54a:	66 83 f8 1b          	cmp    $0x1b,%ax
 54e:	0f 84 3d 01 00 00    	je     691 <trap_dispatch+0x222>
 554:	8b 55 08             	mov    0x8(%ebp),%edx
 557:	b8 00 00 00 00       	mov    $0x0,%eax
 55c:	89 d3                	mov    %edx,%ebx
 55e:	ba 4c 00 00 00       	mov    $0x4c,%edx
 563:	8b 0b                	mov    (%ebx),%ecx
 565:	89 08                	mov    %ecx,(%eax)
 567:	8b 4c 13 fc          	mov    -0x4(%ebx,%edx,1),%ecx
 56b:	89 4c 10 fc          	mov    %ecx,-0x4(%eax,%edx,1)
 56f:	8d 78 04             	lea    0x4(%eax),%edi
 572:	83 e7 fc             	and    $0xfffffffc,%edi
 575:	29 f8                	sub    %edi,%eax
 577:	29 c3                	sub    %eax,%ebx
 579:	01 c2                	add    %eax,%edx
 57b:	83 e2 fc             	and    $0xfffffffc,%edx
 57e:	89 d0                	mov    %edx,%eax
 580:	c1 e8 02             	shr    $0x2,%eax
 583:	89 de                	mov    %ebx,%esi
 585:	89 c1                	mov    %eax,%ecx
 587:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
 589:	66 c7 05 3c 00 00 00 	movw   $0x1b,0x3c
 590:	1b 00 
 592:	66 c7 05 48 00 00 00 	movw   $0x23,0x48
 599:	23 00 
 59b:	0f b7 05 48 00 00 00 	movzwl 0x48,%eax
 5a2:	66 a3 28 00 00 00    	mov    %ax,0x28
 5a8:	0f b7 05 28 00 00 00 	movzwl 0x28,%eax
 5af:	66 a3 2c 00 00 00    	mov    %ax,0x2c
 5b5:	8b 45 08             	mov    0x8(%ebp),%eax
 5b8:	83 c0 44             	add    $0x44,%eax
 5bb:	a3 44 00 00 00       	mov    %eax,0x44
 5c0:	a1 40 00 00 00       	mov    0x40,%eax
 5c5:	80 cc 30             	or     $0x30,%ah
 5c8:	a3 40 00 00 00       	mov    %eax,0x40
 5cd:	8b 45 08             	mov    0x8(%ebp),%eax
 5d0:	83 e8 04             	sub    $0x4,%eax
 5d3:	ba 00 00 00 00       	mov    $0x0,%edx
 5d8:	89 10                	mov    %edx,(%eax)
 5da:	e9 b2 00 00 00       	jmp    691 <trap_dispatch+0x222>
 5df:	8b 45 08             	mov    0x8(%ebp),%eax
 5e2:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
 5e6:	66 83 f8 08          	cmp    $0x8,%ax
 5ea:	0f 84 a4 00 00 00    	je     694 <trap_dispatch+0x225>
 5f0:	8b 45 08             	mov    0x8(%ebp),%eax
 5f3:	66 c7 40 3c 08 00    	movw   $0x8,0x3c(%eax)
 5f9:	8b 45 08             	mov    0x8(%ebp),%eax
 5fc:	66 c7 40 28 10 00    	movw   $0x10,0x28(%eax)
 602:	8b 45 08             	mov    0x8(%ebp),%eax
 605:	0f b7 50 28          	movzwl 0x28(%eax),%edx
 609:	8b 45 08             	mov    0x8(%ebp),%eax
 60c:	66 89 50 2c          	mov    %dx,0x2c(%eax)
 610:	8b 45 08             	mov    0x8(%ebp),%eax
 613:	8b 40 40             	mov    0x40(%eax),%eax
 616:	80 e4 cf             	and    $0xcf,%ah
 619:	89 c2                	mov    %eax,%edx
 61b:	8b 45 08             	mov    0x8(%ebp),%eax
 61e:	89 50 40             	mov    %edx,0x40(%eax)
 621:	8b 45 08             	mov    0x8(%ebp),%eax
 624:	8b 40 44             	mov    0x44(%eax),%eax
 627:	83 e8 44             	sub    $0x44,%eax
 62a:	a3 00 00 00 00       	mov    %eax,0x0
 62f:	a1 00 00 00 00       	mov    0x0,%eax
 634:	83 ec 04             	sub    $0x4,%esp
 637:	6a 44                	push   $0x44
 639:	ff 75 08             	pushl  0x8(%ebp)
 63c:	50                   	push   %eax
 63d:	e8 fc ff ff ff       	call   63e <trap_dispatch+0x1cf>
 642:	83 c4 10             	add    $0x10,%esp
 645:	8b 15 00 00 00 00    	mov    0x0,%edx
 64b:	8b 45 08             	mov    0x8(%ebp),%eax
 64e:	83 e8 04             	sub    $0x4,%eax
 651:	89 10                	mov    %edx,(%eax)
 653:	eb 3f                	jmp    694 <trap_dispatch+0x225>
 655:	8b 45 08             	mov    0x8(%ebp),%eax
 658:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
 65c:	0f b7 c0             	movzwl %ax,%eax
 65f:	83 e0 03             	and    $0x3,%eax
 662:	85 c0                	test   %eax,%eax
 664:	75 2f                	jne    695 <trap_dispatch+0x226>
 666:	83 ec 0c             	sub    $0xc,%esp
 669:	ff 75 08             	pushl  0x8(%ebp)
 66c:	e8 fc ff ff ff       	call   66d <trap_dispatch+0x1fe>
 671:	83 c4 10             	add    $0x10,%esp
 674:	83 ec 04             	sub    $0x4,%esp
 677:	68 d5 01 00 00       	push   $0x1d5
 67c:	68 d2 00 00 00       	push   $0xd2
 681:	68 f1 01 00 00       	push   $0x1f1
 686:	e8 fc ff ff ff       	call   687 <trap_dispatch+0x218>
 68b:	90                   	nop
 68c:	eb 07                	jmp    695 <trap_dispatch+0x226>
 68e:	90                   	nop
 68f:	eb 04                	jmp    695 <trap_dispatch+0x226>
 691:	90                   	nop
 692:	eb 01                	jmp    695 <trap_dispatch+0x226>
 694:	90                   	nop
 695:	90                   	nop
 696:	8d 65 f4             	lea    -0xc(%ebp),%esp
 699:	5b                   	pop    %ebx
 69a:	5e                   	pop    %esi
 69b:	5f                   	pop    %edi
 69c:	5d                   	pop    %ebp
 69d:	c3                   	ret    

0000069e <trap>:
 69e:	55                   	push   %ebp
 69f:	89 e5                	mov    %esp,%ebp
 6a1:	83 ec 08             	sub    $0x8,%esp
 6a4:	83 ec 0c             	sub    $0xc,%esp
 6a7:	ff 75 08             	pushl  0x8(%ebp)
 6aa:	e8 c0 fd ff ff       	call   46f <trap_dispatch>
 6af:	83 c4 10             	add    $0x10,%esp
 6b2:	90                   	nop
 6b3:	c9                   	leave  
 6b4:	c3                   	ret    
