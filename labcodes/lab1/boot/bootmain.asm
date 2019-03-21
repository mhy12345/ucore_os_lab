
bootmain.o:     file format elf32-i386


Disassembly of section .text:

00000000 <readseg>:
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	57                   	push   %edi
   4:	8d 3c 10             	lea    (%eax,%edx,1),%edi
   7:	89 ca                	mov    %ecx,%edx
   9:	c1 e9 09             	shr    $0x9,%ecx
   c:	56                   	push   %esi
   d:	81 e2 ff 01 00 00    	and    $0x1ff,%edx
  13:	8d 71 01             	lea    0x1(%ecx),%esi
  16:	53                   	push   %ebx
  17:	29 d0                	sub    %edx,%eax
  19:	53                   	push   %ebx
  1a:	89 7d f0             	mov    %edi,-0x10(%ebp)
  1d:	89 c3                	mov    %eax,%ebx
  1f:	3b 5d f0             	cmp    -0x10(%ebp),%ebx
  22:	73 71                	jae    95 <readseg+0x95>
  24:	ba f7 01 00 00       	mov    $0x1f7,%edx
  29:	ec                   	in     (%dx),%al
  2a:	83 e0 c0             	and    $0xffffffc0,%eax
  2d:	3c 40                	cmp    $0x40,%al
  2f:	75 f3                	jne    24 <readseg+0x24>
  31:	ba f2 01 00 00       	mov    $0x1f2,%edx
  36:	b0 01                	mov    $0x1,%al
  38:	ee                   	out    %al,(%dx)
  39:	ba f3 01 00 00       	mov    $0x1f3,%edx
  3e:	89 f0                	mov    %esi,%eax
  40:	ee                   	out    %al,(%dx)
  41:	89 f0                	mov    %esi,%eax
  43:	ba f4 01 00 00       	mov    $0x1f4,%edx
  48:	c1 e8 08             	shr    $0x8,%eax
  4b:	ee                   	out    %al,(%dx)
  4c:	89 f0                	mov    %esi,%eax
  4e:	ba f5 01 00 00       	mov    $0x1f5,%edx
  53:	c1 e8 10             	shr    $0x10,%eax
  56:	ee                   	out    %al,(%dx)
  57:	89 f0                	mov    %esi,%eax
  59:	ba f6 01 00 00       	mov    $0x1f6,%edx
  5e:	c1 e8 18             	shr    $0x18,%eax
  61:	83 e0 0f             	and    $0xf,%eax
  64:	83 c8 e0             	or     $0xffffffe0,%eax
  67:	ee                   	out    %al,(%dx)
  68:	b0 20                	mov    $0x20,%al
  6a:	ba f7 01 00 00       	mov    $0x1f7,%edx
  6f:	ee                   	out    %al,(%dx)
  70:	ba f7 01 00 00       	mov    $0x1f7,%edx
  75:	ec                   	in     (%dx),%al
  76:	83 e0 c0             	and    $0xffffffc0,%eax
  79:	3c 40                	cmp    $0x40,%al
  7b:	75 f3                	jne    70 <readseg+0x70>
  7d:	89 df                	mov    %ebx,%edi
  7f:	b9 80 00 00 00       	mov    $0x80,%ecx
  84:	ba f0 01 00 00       	mov    $0x1f0,%edx
  89:	fc                   	cld    
  8a:	f2 6d                	repnz insl (%dx),%es:(%edi)
  8c:	81 c3 00 02 00 00    	add    $0x200,%ebx
  92:	46                   	inc    %esi
  93:	eb 8a                	jmp    1f <readseg+0x1f>
  95:	58                   	pop    %eax
  96:	5b                   	pop    %ebx
  97:	5e                   	pop    %esi
  98:	5f                   	pop    %edi
  99:	5d                   	pop    %ebp
  9a:	c3                   	ret    

0000009b <bootmain>:
  9b:	55                   	push   %ebp
  9c:	31 c9                	xor    %ecx,%ecx
  9e:	ba 00 10 00 00       	mov    $0x1000,%edx
  a3:	b8 00 00 01 00       	mov    $0x10000,%eax
  a8:	89 e5                	mov    %esp,%ebp
  aa:	56                   	push   %esi
  ab:	53                   	push   %ebx
  ac:	e8 4f ff ff ff       	call   0 <readseg>
  b1:	81 3d 00 00 01 00 7f 	cmpl   $0x464c457f,0x10000
  b8:	45 4c 46 
  bb:	75 3f                	jne    fc <bootmain+0x61>
  bd:	a1 1c 00 01 00       	mov    0x1001c,%eax
  c2:	0f b7 35 2c 00 01 00 	movzwl 0x1002c,%esi
  c9:	8d 98 00 00 01 00    	lea    0x10000(%eax),%ebx
  cf:	c1 e6 05             	shl    $0x5,%esi
  d2:	01 de                	add    %ebx,%esi
  d4:	39 f3                	cmp    %esi,%ebx
  d6:	73 18                	jae    f0 <bootmain+0x55>
  d8:	8b 43 08             	mov    0x8(%ebx),%eax
  db:	8b 4b 04             	mov    0x4(%ebx),%ecx
  de:	83 c3 20             	add    $0x20,%ebx
  e1:	8b 53 f4             	mov    -0xc(%ebx),%edx
  e4:	25 ff ff ff 00       	and    $0xffffff,%eax
  e9:	e8 12 ff ff ff       	call   0 <readseg>
  ee:	eb e4                	jmp    d4 <bootmain+0x39>
  f0:	a1 18 00 01 00       	mov    0x10018,%eax
  f5:	25 ff ff ff 00       	and    $0xffffff,%eax
  fa:	ff d0                	call   *%eax
  fc:	ba 00 8a ff ff       	mov    $0xffff8a00,%edx
 101:	89 d0                	mov    %edx,%eax
 103:	66 ef                	out    %ax,(%dx)
 105:	b8 00 8e ff ff       	mov    $0xffff8e00,%eax
 10a:	66 ef                	out    %ax,(%dx)
 10c:	eb fe                	jmp    10c <bootmain+0x71>
