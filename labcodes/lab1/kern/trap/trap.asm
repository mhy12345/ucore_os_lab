
trap.o:     file format elf32-i386


Disassembly of section .text:

00000000 <print_ticks>:
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 08             	sub    $0x8,%esp
   6:	a1 00 00 00 00       	mov    0x0,%eax
   b:	8d 48 01             	lea    0x1(%eax),%ecx
   e:	89 0d 00 00 00 00    	mov    %ecx,0x0
  14:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
  19:	89 c8                	mov    %ecx,%eax
  1b:	f7 e2                	mul    %edx
  1d:	89 d0                	mov    %edx,%eax
  1f:	c1 e8 05             	shr    $0x5,%eax
  22:	6b c0 64             	imul   $0x64,%eax,%eax
  25:	29 c1                	sub    %eax,%ecx
  27:	89 c8                	mov    %ecx,%eax
  29:	85 c0                	test   %eax,%eax
  2b:	75 12                	jne    3f <print_ticks+0x3f>
  2d:	83 ec 08             	sub    $0x8,%esp
  30:	6a 64                	push   $0x64
  32:	68 00 00 00 00       	push   $0x0
  37:	e8 fc ff ff ff       	call   38 <print_ticks+0x38>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	90                   	nop
  40:	c9                   	leave  
  41:	c3                   	ret    

00000042 <idt_init>:
  42:	55                   	push   %ebp
  43:	89 e5                	mov    %esp,%ebp
  45:	83 ec 10             	sub    $0x10,%esp
  48:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  4f:	e9 c3 00 00 00       	jmp    117 <idt_init+0xd5>
  54:	8b 45 fc             	mov    -0x4(%ebp),%eax
  57:	8b 04 85 00 00 00 00 	mov    0x0(,%eax,4),%eax
  5e:	89 c2                	mov    %eax,%edx
  60:	8b 45 fc             	mov    -0x4(%ebp),%eax
  63:	66 89 14 c5 00 00 00 	mov    %dx,0x0(,%eax,8)
  6a:	00 
  6b:	8b 45 fc             	mov    -0x4(%ebp),%eax
  6e:	66 c7 04 c5 02 00 00 	movw   $0x8,0x2(,%eax,8)
  75:	00 08 00 
  78:	8b 45 fc             	mov    -0x4(%ebp),%eax
  7b:	0f b6 14 c5 04 00 00 	movzbl 0x4(,%eax,8),%edx
  82:	00 
  83:	83 e2 e0             	and    $0xffffffe0,%edx
  86:	88 14 c5 04 00 00 00 	mov    %dl,0x4(,%eax,8)
  8d:	8b 45 fc             	mov    -0x4(%ebp),%eax
  90:	0f b6 14 c5 04 00 00 	movzbl 0x4(,%eax,8),%edx
  97:	00 
  98:	83 e2 1f             	and    $0x1f,%edx
  9b:	88 14 c5 04 00 00 00 	mov    %dl,0x4(,%eax,8)
  a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
  a5:	0f b6 14 c5 05 00 00 	movzbl 0x5(,%eax,8),%edx
  ac:	00 
  ad:	83 e2 f0             	and    $0xfffffff0,%edx
  b0:	83 ca 0e             	or     $0xe,%edx
  b3:	88 14 c5 05 00 00 00 	mov    %dl,0x5(,%eax,8)
  ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
  bd:	0f b6 14 c5 05 00 00 	movzbl 0x5(,%eax,8),%edx
  c4:	00 
  c5:	83 e2 ef             	and    $0xffffffef,%edx
  c8:	88 14 c5 05 00 00 00 	mov    %dl,0x5(,%eax,8)
  cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
  d2:	0f b6 14 c5 05 00 00 	movzbl 0x5(,%eax,8),%edx
  d9:	00 
  da:	83 ca 60             	or     $0x60,%edx
  dd:	88 14 c5 05 00 00 00 	mov    %dl,0x5(,%eax,8)
  e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
  e7:	0f b6 14 c5 05 00 00 	movzbl 0x5(,%eax,8),%edx
  ee:	00 
  ef:	83 ca 80             	or     $0xffffff80,%edx
  f2:	88 14 c5 05 00 00 00 	mov    %dl,0x5(,%eax,8)
  f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  fc:	8b 04 85 00 00 00 00 	mov    0x0(,%eax,4),%eax
 103:	c1 e8 10             	shr    $0x10,%eax
 106:	89 c2                	mov    %eax,%edx
 108:	8b 45 fc             	mov    -0x4(%ebp),%eax
 10b:	66 89 14 c5 06 00 00 	mov    %dx,0x6(,%eax,8)
 112:	00 
 113:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 117:	8b 45 fc             	mov    -0x4(%ebp),%eax
 11a:	3d ff 00 00 00       	cmp    $0xff,%eax
 11f:	0f 86 2f ff ff ff    	jbe    54 <idt_init+0x12>
 125:	a1 e4 01 00 00       	mov    0x1e4,%eax
 12a:	66 a3 c8 03 00 00    	mov    %ax,0x3c8
 130:	66 c7 05 ca 03 00 00 	movw   $0x8,0x3ca
 137:	08 00 
 139:	0f b6 05 cc 03 00 00 	movzbl 0x3cc,%eax
 140:	83 e0 e0             	and    $0xffffffe0,%eax
 143:	a2 cc 03 00 00       	mov    %al,0x3cc
 148:	0f b6 05 cc 03 00 00 	movzbl 0x3cc,%eax
 14f:	83 e0 1f             	and    $0x1f,%eax
 152:	a2 cc 03 00 00       	mov    %al,0x3cc
 157:	0f b6 05 cd 03 00 00 	movzbl 0x3cd,%eax
 15e:	83 c8 0f             	or     $0xf,%eax
 161:	a2 cd 03 00 00       	mov    %al,0x3cd
 166:	0f b6 05 cd 03 00 00 	movzbl 0x3cd,%eax
 16d:	83 e0 ef             	and    $0xffffffef,%eax
 170:	a2 cd 03 00 00       	mov    %al,0x3cd
 175:	0f b6 05 cd 03 00 00 	movzbl 0x3cd,%eax
 17c:	83 c8 60             	or     $0x60,%eax
 17f:	a2 cd 03 00 00       	mov    %al,0x3cd
 184:	0f b6 05 cd 03 00 00 	movzbl 0x3cd,%eax
 18b:	83 c8 80             	or     $0xffffff80,%eax
 18e:	a2 cd 03 00 00       	mov    %al,0x3cd
 193:	a1 e4 01 00 00       	mov    0x1e4,%eax
 198:	c1 e8 10             	shr    $0x10,%eax
 19b:	66 a3 ce 03 00 00    	mov    %ax,0x3ce
 1a1:	0f 01 1d 00 00 00 00 	lidtl  0x0
 1a8:	90                   	nop
 1a9:	c9                   	leave  
 1aa:	c3                   	ret    

000001ab <trapname>:
 1ab:	55                   	push   %ebp
 1ac:	89 e5                	mov    %esp,%ebp
 1ae:	8b 45 08             	mov    0x8(%ebp),%eax
 1b1:	83 f8 13             	cmp    $0x13,%eax
 1b4:	77 0c                	ja     1c2 <trapname+0x17>
 1b6:	8b 45 08             	mov    0x8(%ebp),%eax
 1b9:	8b 04 85 60 03 00 00 	mov    0x360(,%eax,4),%eax
 1c0:	eb 18                	jmp    1da <trapname+0x2f>
 1c2:	83 7d 08 1f          	cmpl   $0x1f,0x8(%ebp)
 1c6:	7e 0d                	jle    1d5 <trapname+0x2a>
 1c8:	83 7d 08 2f          	cmpl   $0x2f,0x8(%ebp)
 1cc:	7f 07                	jg     1d5 <trapname+0x2a>
 1ce:	b8 0a 00 00 00       	mov    $0xa,%eax
 1d3:	eb 05                	jmp    1da <trapname+0x2f>
 1d5:	b8 1d 00 00 00       	mov    $0x1d,%eax
 1da:	5d                   	pop    %ebp
 1db:	c3                   	ret    

000001dc <trap_in_kernel>:
 1dc:	55                   	push   %ebp
 1dd:	89 e5                	mov    %esp,%ebp
 1df:	8b 45 08             	mov    0x8(%ebp),%eax
 1e2:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
 1e6:	66 83 f8 08          	cmp    $0x8,%ax
 1ea:	0f 94 c0             	sete   %al
 1ed:	0f b6 c0             	movzbl %al,%eax
 1f0:	5d                   	pop    %ebp
 1f1:	c3                   	ret    

000001f2 <print_trapframe>:
 1f2:	55                   	push   %ebp
 1f3:	89 e5                	mov    %esp,%ebp
 1f5:	83 ec 18             	sub    $0x18,%esp
 1f8:	83 ec 08             	sub    $0x8,%esp
 1fb:	ff 75 08             	pushl  0x8(%ebp)
 1fe:	68 5e 00 00 00       	push   $0x5e
 203:	e8 fc ff ff ff       	call   204 <print_trapframe+0x12>
 208:	83 c4 10             	add    $0x10,%esp
 20b:	8b 45 08             	mov    0x8(%ebp),%eax
 20e:	83 ec 0c             	sub    $0xc,%esp
 211:	50                   	push   %eax
 212:	e8 fc ff ff ff       	call   213 <print_trapframe+0x21>
 217:	83 c4 10             	add    $0x10,%esp
 21a:	8b 45 08             	mov    0x8(%ebp),%eax
 21d:	0f b7 40 2c          	movzwl 0x2c(%eax),%eax
 221:	0f b7 c0             	movzwl %ax,%eax
 224:	83 ec 08             	sub    $0x8,%esp
 227:	50                   	push   %eax
 228:	68 6f 00 00 00       	push   $0x6f
 22d:	e8 fc ff ff ff       	call   22e <print_trapframe+0x3c>
 232:	83 c4 10             	add    $0x10,%esp
 235:	8b 45 08             	mov    0x8(%ebp),%eax
 238:	0f b7 40 28          	movzwl 0x28(%eax),%eax
 23c:	0f b7 c0             	movzwl %ax,%eax
 23f:	83 ec 08             	sub    $0x8,%esp
 242:	50                   	push   %eax
 243:	68 82 00 00 00       	push   $0x82
 248:	e8 fc ff ff ff       	call   249 <print_trapframe+0x57>
 24d:	83 c4 10             	add    $0x10,%esp
 250:	8b 45 08             	mov    0x8(%ebp),%eax
 253:	0f b7 40 24          	movzwl 0x24(%eax),%eax
 257:	0f b7 c0             	movzwl %ax,%eax
 25a:	83 ec 08             	sub    $0x8,%esp
 25d:	50                   	push   %eax
 25e:	68 95 00 00 00       	push   $0x95
 263:	e8 fc ff ff ff       	call   264 <print_trapframe+0x72>
 268:	83 c4 10             	add    $0x10,%esp
 26b:	8b 45 08             	mov    0x8(%ebp),%eax
 26e:	0f b7 40 20          	movzwl 0x20(%eax),%eax
 272:	0f b7 c0             	movzwl %ax,%eax
 275:	83 ec 08             	sub    $0x8,%esp
 278:	50                   	push   %eax
 279:	68 a8 00 00 00       	push   $0xa8
 27e:	e8 fc ff ff ff       	call   27f <print_trapframe+0x8d>
 283:	83 c4 10             	add    $0x10,%esp
 286:	8b 45 08             	mov    0x8(%ebp),%eax
 289:	8b 40 30             	mov    0x30(%eax),%eax
 28c:	83 ec 0c             	sub    $0xc,%esp
 28f:	50                   	push   %eax
 290:	e8 16 ff ff ff       	call   1ab <trapname>
 295:	83 c4 10             	add    $0x10,%esp
 298:	89 c2                	mov    %eax,%edx
 29a:	8b 45 08             	mov    0x8(%ebp),%eax
 29d:	8b 40 30             	mov    0x30(%eax),%eax
 2a0:	83 ec 04             	sub    $0x4,%esp
 2a3:	52                   	push   %edx
 2a4:	50                   	push   %eax
 2a5:	68 bb 00 00 00       	push   $0xbb
 2aa:	e8 fc ff ff ff       	call   2ab <print_trapframe+0xb9>
 2af:	83 c4 10             	add    $0x10,%esp
 2b2:	8b 45 08             	mov    0x8(%ebp),%eax
 2b5:	8b 40 34             	mov    0x34(%eax),%eax
 2b8:	83 ec 08             	sub    $0x8,%esp
 2bb:	50                   	push   %eax
 2bc:	68 cd 00 00 00       	push   $0xcd
 2c1:	e8 fc ff ff ff       	call   2c2 <print_trapframe+0xd0>
 2c6:	83 c4 10             	add    $0x10,%esp
 2c9:	8b 45 08             	mov    0x8(%ebp),%eax
 2cc:	8b 40 38             	mov    0x38(%eax),%eax
 2cf:	83 ec 08             	sub    $0x8,%esp
 2d2:	50                   	push   %eax
 2d3:	68 dc 00 00 00       	push   $0xdc
 2d8:	e8 fc ff ff ff       	call   2d9 <print_trapframe+0xe7>
 2dd:	83 c4 10             	add    $0x10,%esp
 2e0:	8b 45 08             	mov    0x8(%ebp),%eax
 2e3:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
 2e7:	0f b7 c0             	movzwl %ax,%eax
 2ea:	83 ec 08             	sub    $0x8,%esp
 2ed:	50                   	push   %eax
 2ee:	68 eb 00 00 00       	push   $0xeb
 2f3:	e8 fc ff ff ff       	call   2f4 <print_trapframe+0x102>
 2f8:	83 c4 10             	add    $0x10,%esp
 2fb:	8b 45 08             	mov    0x8(%ebp),%eax
 2fe:	8b 40 40             	mov    0x40(%eax),%eax
 301:	83 ec 08             	sub    $0x8,%esp
 304:	50                   	push   %eax
 305:	68 fe 00 00 00       	push   $0xfe
 30a:	e8 fc ff ff ff       	call   30b <print_trapframe+0x119>
 30f:	83 c4 10             	add    $0x10,%esp
 312:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 319:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
 320:	eb 3f                	jmp    361 <print_trapframe+0x16f>
 322:	8b 45 08             	mov    0x8(%ebp),%eax
 325:	8b 50 40             	mov    0x40(%eax),%edx
 328:	8b 45 f0             	mov    -0x10(%ebp),%eax
 32b:	21 d0                	and    %edx,%eax
 32d:	85 c0                	test   %eax,%eax
 32f:	74 29                	je     35a <print_trapframe+0x168>
 331:	8b 45 f4             	mov    -0xc(%ebp),%eax
 334:	8b 04 85 20 00 00 00 	mov    0x20(,%eax,4),%eax
 33b:	85 c0                	test   %eax,%eax
 33d:	74 1b                	je     35a <print_trapframe+0x168>
 33f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 342:	8b 04 85 20 00 00 00 	mov    0x20(,%eax,4),%eax
 349:	83 ec 08             	sub    $0x8,%esp
 34c:	50                   	push   %eax
 34d:	68 0d 01 00 00       	push   $0x10d
 352:	e8 fc ff ff ff       	call   353 <print_trapframe+0x161>
 357:	83 c4 10             	add    $0x10,%esp
 35a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 35e:	d1 65 f0             	shll   -0x10(%ebp)
 361:	8b 45 f4             	mov    -0xc(%ebp),%eax
 364:	83 f8 17             	cmp    $0x17,%eax
 367:	76 b9                	jbe    322 <print_trapframe+0x130>
 369:	8b 45 08             	mov    0x8(%ebp),%eax
 36c:	8b 40 40             	mov    0x40(%eax),%eax
 36f:	c1 e8 0c             	shr    $0xc,%eax
 372:	83 e0 03             	and    $0x3,%eax
 375:	83 ec 08             	sub    $0x8,%esp
 378:	50                   	push   %eax
 379:	68 11 01 00 00       	push   $0x111
 37e:	e8 fc ff ff ff       	call   37f <print_trapframe+0x18d>
 383:	83 c4 10             	add    $0x10,%esp
 386:	83 ec 0c             	sub    $0xc,%esp
 389:	ff 75 08             	pushl  0x8(%ebp)
 38c:	e8 fc ff ff ff       	call   38d <print_trapframe+0x19b>
 391:	83 c4 10             	add    $0x10,%esp
 394:	85 c0                	test   %eax,%eax
 396:	75 32                	jne    3ca <print_trapframe+0x1d8>
 398:	8b 45 08             	mov    0x8(%ebp),%eax
 39b:	8b 40 44             	mov    0x44(%eax),%eax
 39e:	83 ec 08             	sub    $0x8,%esp
 3a1:	50                   	push   %eax
 3a2:	68 1a 01 00 00       	push   $0x11a
 3a7:	e8 fc ff ff ff       	call   3a8 <print_trapframe+0x1b6>
 3ac:	83 c4 10             	add    $0x10,%esp
 3af:	8b 45 08             	mov    0x8(%ebp),%eax
 3b2:	0f b7 40 48          	movzwl 0x48(%eax),%eax
 3b6:	0f b7 c0             	movzwl %ax,%eax
 3b9:	83 ec 08             	sub    $0x8,%esp
 3bc:	50                   	push   %eax
 3bd:	68 29 01 00 00       	push   $0x129
 3c2:	e8 fc ff ff ff       	call   3c3 <print_trapframe+0x1d1>
 3c7:	83 c4 10             	add    $0x10,%esp
 3ca:	90                   	nop
 3cb:	c9                   	leave  
 3cc:	c3                   	ret    

000003cd <print_regs>:
 3cd:	55                   	push   %ebp
 3ce:	89 e5                	mov    %esp,%ebp
 3d0:	83 ec 08             	sub    $0x8,%esp
 3d3:	8b 45 08             	mov    0x8(%ebp),%eax
 3d6:	8b 00                	mov    (%eax),%eax
 3d8:	83 ec 08             	sub    $0x8,%esp
 3db:	50                   	push   %eax
 3dc:	68 3c 01 00 00       	push   $0x13c
 3e1:	e8 fc ff ff ff       	call   3e2 <print_regs+0x15>
 3e6:	83 c4 10             	add    $0x10,%esp
 3e9:	8b 45 08             	mov    0x8(%ebp),%eax
 3ec:	8b 40 04             	mov    0x4(%eax),%eax
 3ef:	83 ec 08             	sub    $0x8,%esp
 3f2:	50                   	push   %eax
 3f3:	68 4b 01 00 00       	push   $0x14b
 3f8:	e8 fc ff ff ff       	call   3f9 <print_regs+0x2c>
 3fd:	83 c4 10             	add    $0x10,%esp
 400:	8b 45 08             	mov    0x8(%ebp),%eax
 403:	8b 40 08             	mov    0x8(%eax),%eax
 406:	83 ec 08             	sub    $0x8,%esp
 409:	50                   	push   %eax
 40a:	68 5a 01 00 00       	push   $0x15a
 40f:	e8 fc ff ff ff       	call   410 <print_regs+0x43>
 414:	83 c4 10             	add    $0x10,%esp
 417:	8b 45 08             	mov    0x8(%ebp),%eax
 41a:	8b 40 0c             	mov    0xc(%eax),%eax
 41d:	83 ec 08             	sub    $0x8,%esp
 420:	50                   	push   %eax
 421:	68 69 01 00 00       	push   $0x169
 426:	e8 fc ff ff ff       	call   427 <print_regs+0x5a>
 42b:	83 c4 10             	add    $0x10,%esp
 42e:	8b 45 08             	mov    0x8(%ebp),%eax
 431:	8b 40 10             	mov    0x10(%eax),%eax
 434:	83 ec 08             	sub    $0x8,%esp
 437:	50                   	push   %eax
 438:	68 78 01 00 00       	push   $0x178
 43d:	e8 fc ff ff ff       	call   43e <print_regs+0x71>
 442:	83 c4 10             	add    $0x10,%esp
 445:	8b 45 08             	mov    0x8(%ebp),%eax
 448:	8b 40 14             	mov    0x14(%eax),%eax
 44b:	83 ec 08             	sub    $0x8,%esp
 44e:	50                   	push   %eax
 44f:	68 87 01 00 00       	push   $0x187
 454:	e8 fc ff ff ff       	call   455 <print_regs+0x88>
 459:	83 c4 10             	add    $0x10,%esp
 45c:	8b 45 08             	mov    0x8(%ebp),%eax
 45f:	8b 40 18             	mov    0x18(%eax),%eax
 462:	83 ec 08             	sub    $0x8,%esp
 465:	50                   	push   %eax
 466:	68 96 01 00 00       	push   $0x196
 46b:	e8 fc ff ff ff       	call   46c <print_regs+0x9f>
 470:	83 c4 10             	add    $0x10,%esp
 473:	8b 45 08             	mov    0x8(%ebp),%eax
 476:	8b 40 1c             	mov    0x1c(%eax),%eax
 479:	83 ec 08             	sub    $0x8,%esp
 47c:	50                   	push   %eax
 47d:	68 a5 01 00 00       	push   $0x1a5
 482:	e8 fc ff ff ff       	call   483 <print_regs+0xb6>
 487:	83 c4 10             	add    $0x10,%esp
 48a:	90                   	nop
 48b:	c9                   	leave  
 48c:	c3                   	ret    

0000048d <trap_dispatch>:
 48d:	55                   	push   %ebp
 48e:	89 e5                	mov    %esp,%ebp
 490:	57                   	push   %edi
 491:	56                   	push   %esi
 492:	53                   	push   %ebx
 493:	83 ec 5c             	sub    $0x5c,%esp
 496:	8b 45 08             	mov    0x8(%ebp),%eax
 499:	8b 40 30             	mov    0x30(%eax),%eax
 49c:	83 f8 2f             	cmp    $0x2f,%eax
 49f:	77 1d                	ja     4be <trap_dispatch+0x31>
 4a1:	83 f8 2e             	cmp    $0x2e,%eax
 4a4:	0f 83 c5 01 00 00    	jae    66f <trap_dispatch+0x1e2>
 4aa:	83 f8 21             	cmp    $0x21,%eax
 4ad:	74 53                	je     502 <trap_dispatch+0x75>
 4af:	83 f8 24             	cmp    $0x24,%eax
 4b2:	74 27                	je     4db <trap_dispatch+0x4e>
 4b4:	83 f8 20             	cmp    $0x20,%eax
 4b7:	74 18                	je     4d1 <trap_dispatch+0x44>
 4b9:	e9 7b 01 00 00       	jmp    639 <trap_dispatch+0x1ac>
 4be:	83 f8 78             	cmp    $0x78,%eax
 4c1:	74 66                	je     529 <trap_dispatch+0x9c>
 4c3:	83 f8 79             	cmp    $0x79,%eax
 4c6:	0f 84 e2 00 00 00    	je     5ae <trap_dispatch+0x121>
 4cc:	e9 68 01 00 00       	jmp    639 <trap_dispatch+0x1ac>
 4d1:	e8 2a fb ff ff       	call   0 <print_ticks>
 4d6:	e9 98 01 00 00       	jmp    673 <trap_dispatch+0x1e6>
 4db:	e8 fc ff ff ff       	call   4dc <trap_dispatch+0x4f>
 4e0:	88 45 e7             	mov    %al,-0x19(%ebp)
 4e3:	0f be 55 e7          	movsbl -0x19(%ebp),%edx
 4e7:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
 4eb:	83 ec 04             	sub    $0x4,%esp
 4ee:	52                   	push   %edx
 4ef:	50                   	push   %eax
 4f0:	68 b4 01 00 00       	push   $0x1b4
 4f5:	e8 fc ff ff ff       	call   4f6 <trap_dispatch+0x69>
 4fa:	83 c4 10             	add    $0x10,%esp
 4fd:	e9 71 01 00 00       	jmp    673 <trap_dispatch+0x1e6>
 502:	e8 fc ff ff ff       	call   503 <trap_dispatch+0x76>
 507:	88 45 e7             	mov    %al,-0x19(%ebp)
 50a:	0f be 55 e7          	movsbl -0x19(%ebp),%edx
 50e:	0f be 45 e7          	movsbl -0x19(%ebp),%eax
 512:	83 ec 04             	sub    $0x4,%esp
 515:	52                   	push   %edx
 516:	50                   	push   %eax
 517:	68 c6 01 00 00       	push   $0x1c6
 51c:	e8 fc ff ff ff       	call   51d <trap_dispatch+0x90>
 521:	83 c4 10             	add    $0x10,%esp
 524:	e9 4a 01 00 00       	jmp    673 <trap_dispatch+0x1e6>
 529:	8b 45 08             	mov    0x8(%ebp),%eax
 52c:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
 530:	66 83 f8 08          	cmp    $0x8,%ax
 534:	75 78                	jne    5ae <trap_dispatch+0x121>
 536:	83 ec 0c             	sub    $0xc,%esp
 539:	68 d5 01 00 00       	push   $0x1d5
 53e:	e8 fc ff ff ff       	call   53f <trap_dispatch+0xb2>
 543:	83 c4 10             	add    $0x10,%esp
 546:	8b 55 08             	mov    0x8(%ebp),%edx
 549:	8d 45 9b             	lea    -0x65(%ebp),%eax
 54c:	89 d3                	mov    %edx,%ebx
 54e:	ba 4c 00 00 00       	mov    $0x4c,%edx
 553:	8b 0b                	mov    (%ebx),%ecx
 555:	89 08                	mov    %ecx,(%eax)
 557:	8b 4c 13 fc          	mov    -0x4(%ebx,%edx,1),%ecx
 55b:	89 4c 10 fc          	mov    %ecx,-0x4(%eax,%edx,1)
 55f:	8d 78 04             	lea    0x4(%eax),%edi
 562:	83 e7 fc             	and    $0xfffffffc,%edi
 565:	29 f8                	sub    %edi,%eax
 567:	29 c3                	sub    %eax,%ebx
 569:	01 c2                	add    %eax,%edx
 56b:	83 e2 fc             	and    $0xfffffffc,%edx
 56e:	89 d0                	mov    %edx,%eax
 570:	c1 e8 02             	shr    $0x2,%eax
 573:	89 de                	mov    %ebx,%esi
 575:	89 c1                	mov    %eax,%ecx
 577:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
 579:	66 c7 45 d7 1b 00    	movw   $0x1b,-0x29(%ebp)
 57f:	66 c7 45 c7 23 00    	movw   $0x23,-0x39(%ebp)
 585:	66 c7 45 c3 23 00    	movw   $0x23,-0x3d(%ebp)
 58b:	66 c7 45 e3 23 00    	movw   $0x23,-0x1d(%ebp)
 591:	8b 45 db             	mov    -0x25(%ebp),%eax
 594:	80 cc 30             	or     $0x30,%ah
 597:	89 45 db             	mov    %eax,-0x25(%ebp)
 59a:	8b 45 08             	mov    0x8(%ebp),%eax
 59d:	83 c0 44             	add    $0x44,%eax
 5a0:	89 45 df             	mov    %eax,-0x21(%ebp)
 5a3:	8b 45 08             	mov    0x8(%ebp),%eax
 5a6:	8d 50 fc             	lea    -0x4(%eax),%edx
 5a9:	8d 45 9b             	lea    -0x65(%ebp),%eax
 5ac:	89 02                	mov    %eax,(%edx)
 5ae:	8b 45 08             	mov    0x8(%ebp),%eax
 5b1:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
 5b5:	66 83 f8 1b          	cmp    $0x1b,%ax
 5b9:	0f 85 b3 00 00 00    	jne    672 <trap_dispatch+0x1e5>
 5bf:	83 ec 0c             	sub    $0xc,%esp
 5c2:	68 e2 01 00 00       	push   $0x1e2
 5c7:	e8 fc ff ff ff       	call   5c8 <trap_dispatch+0x13b>
 5cc:	83 c4 10             	add    $0x10,%esp
 5cf:	8b 55 08             	mov    0x8(%ebp),%edx
 5d2:	8d 45 9b             	lea    -0x65(%ebp),%eax
 5d5:	89 d3                	mov    %edx,%ebx
 5d7:	ba 4c 00 00 00       	mov    $0x4c,%edx
 5dc:	8b 0b                	mov    (%ebx),%ecx
 5de:	89 08                	mov    %ecx,(%eax)
 5e0:	8b 4c 13 fc          	mov    -0x4(%ebx,%edx,1),%ecx
 5e4:	89 4c 10 fc          	mov    %ecx,-0x4(%eax,%edx,1)
 5e8:	8d 78 04             	lea    0x4(%eax),%edi
 5eb:	83 e7 fc             	and    $0xfffffffc,%edi
 5ee:	29 f8                	sub    %edi,%eax
 5f0:	29 c3                	sub    %eax,%ebx
 5f2:	01 c2                	add    %eax,%edx
 5f4:	83 e2 fc             	and    $0xfffffffc,%edx
 5f7:	89 d0                	mov    %edx,%eax
 5f9:	c1 e8 02             	shr    $0x2,%eax
 5fc:	89 de                	mov    %ebx,%esi
 5fe:	89 c1                	mov    %eax,%ecx
 600:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)
 602:	66 c7 45 d7 08 00    	movw   $0x8,-0x29(%ebp)
 608:	66 c7 45 c7 10 00    	movw   $0x10,-0x39(%ebp)
 60e:	66 c7 45 c3 10 00    	movw   $0x10,-0x3d(%ebp)
 614:	66 c7 45 e3 10 00    	movw   $0x10,-0x1d(%ebp)
 61a:	8b 45 db             	mov    -0x25(%ebp),%eax
 61d:	80 e4 cf             	and    $0xcf,%ah
 620:	89 45 db             	mov    %eax,-0x25(%ebp)
 623:	8b 45 08             	mov    0x8(%ebp),%eax
 626:	83 e8 44             	sub    $0x44,%eax
 629:	89 45 df             	mov    %eax,-0x21(%ebp)
 62c:	8b 45 08             	mov    0x8(%ebp),%eax
 62f:	8d 50 fc             	lea    -0x4(%eax),%edx
 632:	8d 45 9b             	lea    -0x65(%ebp),%eax
 635:	89 02                	mov    %eax,(%edx)
 637:	eb 39                	jmp    672 <trap_dispatch+0x1e5>
 639:	8b 45 08             	mov    0x8(%ebp),%eax
 63c:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
 640:	0f b7 c0             	movzwl %ax,%eax
 643:	83 e0 03             	and    $0x3,%eax
 646:	85 c0                	test   %eax,%eax
 648:	75 29                	jne    673 <trap_dispatch+0x1e6>
 64a:	83 ec 0c             	sub    $0xc,%esp
 64d:	ff 75 08             	pushl  0x8(%ebp)
 650:	e8 fc ff ff ff       	call   651 <trap_dispatch+0x1c4>
 655:	83 c4 10             	add    $0x10,%esp
 658:	83 ec 04             	sub    $0x4,%esp
 65b:	68 ef 01 00 00       	push   $0x1ef
 660:	68 cc 00 00 00       	push   $0xcc
 665:	68 0b 02 00 00       	push   $0x20b
 66a:	e8 fc ff ff ff       	call   66b <trap_dispatch+0x1de>
 66f:	90                   	nop
 670:	eb 01                	jmp    673 <trap_dispatch+0x1e6>
 672:	90                   	nop
 673:	90                   	nop
 674:	8d 65 f4             	lea    -0xc(%ebp),%esp
 677:	5b                   	pop    %ebx
 678:	5e                   	pop    %esi
 679:	5f                   	pop    %edi
 67a:	5d                   	pop    %ebp
 67b:	c3                   	ret    

0000067c <trap>:
 67c:	55                   	push   %ebp
 67d:	89 e5                	mov    %esp,%ebp
 67f:	83 ec 08             	sub    $0x8,%esp
 682:	83 ec 0c             	sub    $0xc,%esp
 685:	ff 75 08             	pushl  0x8(%ebp)
 688:	e8 00 fe ff ff       	call   48d <trap_dispatch>
 68d:	83 c4 10             	add    $0x10,%esp
 690:	90                   	nop
 691:	c9                   	leave  
 692:	c3                   	ret    
