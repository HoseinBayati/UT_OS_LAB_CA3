
_ln:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
   f:	89 cb                	mov    %ecx,%ebx
  if(argc != 3){
  11:	83 3b 03             	cmpl   $0x3,(%ebx)
  14:	74 17                	je     2d <main+0x2d>
    printf(2, "Usage: ln old new\n");
  16:	83 ec 08             	sub    $0x8,%esp
  19:	68 61 08 00 00       	push   $0x861
  1e:	6a 02                	push   $0x2
  20:	e8 85 04 00 00       	call   4aa <printf>
  25:	83 c4 10             	add    $0x10,%esp
    exit();
  28:	e8 f9 02 00 00       	call   326 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  2d:	8b 43 04             	mov    0x4(%ebx),%eax
  30:	83 c0 08             	add    $0x8,%eax
  33:	8b 10                	mov    (%eax),%edx
  35:	8b 43 04             	mov    0x4(%ebx),%eax
  38:	83 c0 04             	add    $0x4,%eax
  3b:	8b 00                	mov    (%eax),%eax
  3d:	83 ec 08             	sub    $0x8,%esp
  40:	52                   	push   %edx
  41:	50                   	push   %eax
  42:	e8 3f 03 00 00       	call   386 <link>
  47:	83 c4 10             	add    $0x10,%esp
  4a:	85 c0                	test   %eax,%eax
  4c:	79 21                	jns    6f <main+0x6f>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  4e:	8b 43 04             	mov    0x4(%ebx),%eax
  51:	83 c0 08             	add    $0x8,%eax
  54:	8b 10                	mov    (%eax),%edx
  56:	8b 43 04             	mov    0x4(%ebx),%eax
  59:	83 c0 04             	add    $0x4,%eax
  5c:	8b 00                	mov    (%eax),%eax
  5e:	52                   	push   %edx
  5f:	50                   	push   %eax
  60:	68 74 08 00 00       	push   $0x874
  65:	6a 02                	push   $0x2
  67:	e8 3e 04 00 00       	call   4aa <printf>
  6c:	83 c4 10             	add    $0x10,%esp
  exit();
  6f:	e8 b2 02 00 00       	call   326 <exit>

00000074 <stosb>:
  74:	55                   	push   %ebp
  75:	89 e5                	mov    %esp,%ebp
  77:	57                   	push   %edi
  78:	53                   	push   %ebx
  79:	8b 4d 08             	mov    0x8(%ebp),%ecx
  7c:	8b 55 10             	mov    0x10(%ebp),%edx
  7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  82:	89 cb                	mov    %ecx,%ebx
  84:	89 df                	mov    %ebx,%edi
  86:	89 d1                	mov    %edx,%ecx
  88:	fc                   	cld    
  89:	f3 aa                	rep stos %al,%es:(%edi)
  8b:	89 ca                	mov    %ecx,%edx
  8d:	89 fb                	mov    %edi,%ebx
  8f:	89 5d 08             	mov    %ebx,0x8(%ebp)
  92:	89 55 10             	mov    %edx,0x10(%ebp)
  95:	90                   	nop
  96:	5b                   	pop    %ebx
  97:	5f                   	pop    %edi
  98:	5d                   	pop    %ebp
  99:	c3                   	ret    

0000009a <strcpy>:
  9a:	55                   	push   %ebp
  9b:	89 e5                	mov    %esp,%ebp
  9d:	83 ec 10             	sub    $0x10,%esp
  a0:	8b 45 08             	mov    0x8(%ebp),%eax
  a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  a6:	90                   	nop
  a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  aa:	8d 42 01             	lea    0x1(%edx),%eax
  ad:	89 45 0c             	mov    %eax,0xc(%ebp)
  b0:	8b 45 08             	mov    0x8(%ebp),%eax
  b3:	8d 48 01             	lea    0x1(%eax),%ecx
  b6:	89 4d 08             	mov    %ecx,0x8(%ebp)
  b9:	0f b6 12             	movzbl (%edx),%edx
  bc:	88 10                	mov    %dl,(%eax)
  be:	0f b6 00             	movzbl (%eax),%eax
  c1:	84 c0                	test   %al,%al
  c3:	75 e2                	jne    a7 <strcpy+0xd>
  c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
  c8:	c9                   	leave  
  c9:	c3                   	ret    

000000ca <strcmp>:
  ca:	55                   	push   %ebp
  cb:	89 e5                	mov    %esp,%ebp
  cd:	eb 08                	jmp    d7 <strcmp+0xd>
  cf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  d3:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  d7:	8b 45 08             	mov    0x8(%ebp),%eax
  da:	0f b6 00             	movzbl (%eax),%eax
  dd:	84 c0                	test   %al,%al
  df:	74 10                	je     f1 <strcmp+0x27>
  e1:	8b 45 08             	mov    0x8(%ebp),%eax
  e4:	0f b6 10             	movzbl (%eax),%edx
  e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  ea:	0f b6 00             	movzbl (%eax),%eax
  ed:	38 c2                	cmp    %al,%dl
  ef:	74 de                	je     cf <strcmp+0x5>
  f1:	8b 45 08             	mov    0x8(%ebp),%eax
  f4:	0f b6 00             	movzbl (%eax),%eax
  f7:	0f b6 d0             	movzbl %al,%edx
  fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  fd:	0f b6 00             	movzbl (%eax),%eax
 100:	0f b6 c8             	movzbl %al,%ecx
 103:	89 d0                	mov    %edx,%eax
 105:	29 c8                	sub    %ecx,%eax
 107:	5d                   	pop    %ebp
 108:	c3                   	ret    

00000109 <strlen>:
 109:	55                   	push   %ebp
 10a:	89 e5                	mov    %esp,%ebp
 10c:	83 ec 10             	sub    $0x10,%esp
 10f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 116:	eb 04                	jmp    11c <strlen+0x13>
 118:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 11c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 11f:	8b 45 08             	mov    0x8(%ebp),%eax
 122:	01 d0                	add    %edx,%eax
 124:	0f b6 00             	movzbl (%eax),%eax
 127:	84 c0                	test   %al,%al
 129:	75 ed                	jne    118 <strlen+0xf>
 12b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 12e:	c9                   	leave  
 12f:	c3                   	ret    

00000130 <memset>:
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	8b 45 10             	mov    0x10(%ebp),%eax
 136:	50                   	push   %eax
 137:	ff 75 0c             	push   0xc(%ebp)
 13a:	ff 75 08             	push   0x8(%ebp)
 13d:	e8 32 ff ff ff       	call   74 <stosb>
 142:	83 c4 0c             	add    $0xc,%esp
 145:	8b 45 08             	mov    0x8(%ebp),%eax
 148:	c9                   	leave  
 149:	c3                   	ret    

0000014a <strchr>:
 14a:	55                   	push   %ebp
 14b:	89 e5                	mov    %esp,%ebp
 14d:	83 ec 04             	sub    $0x4,%esp
 150:	8b 45 0c             	mov    0xc(%ebp),%eax
 153:	88 45 fc             	mov    %al,-0x4(%ebp)
 156:	eb 14                	jmp    16c <strchr+0x22>
 158:	8b 45 08             	mov    0x8(%ebp),%eax
 15b:	0f b6 00             	movzbl (%eax),%eax
 15e:	38 45 fc             	cmp    %al,-0x4(%ebp)
 161:	75 05                	jne    168 <strchr+0x1e>
 163:	8b 45 08             	mov    0x8(%ebp),%eax
 166:	eb 13                	jmp    17b <strchr+0x31>
 168:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 16c:	8b 45 08             	mov    0x8(%ebp),%eax
 16f:	0f b6 00             	movzbl (%eax),%eax
 172:	84 c0                	test   %al,%al
 174:	75 e2                	jne    158 <strchr+0xe>
 176:	b8 00 00 00 00       	mov    $0x0,%eax
 17b:	c9                   	leave  
 17c:	c3                   	ret    

0000017d <gets>:
 17d:	55                   	push   %ebp
 17e:	89 e5                	mov    %esp,%ebp
 180:	83 ec 18             	sub    $0x18,%esp
 183:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 18a:	eb 42                	jmp    1ce <gets+0x51>
 18c:	83 ec 04             	sub    $0x4,%esp
 18f:	6a 01                	push   $0x1
 191:	8d 45 ef             	lea    -0x11(%ebp),%eax
 194:	50                   	push   %eax
 195:	6a 00                	push   $0x0
 197:	e8 a2 01 00 00       	call   33e <read>
 19c:	83 c4 10             	add    $0x10,%esp
 19f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 1a2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1a6:	7e 33                	jle    1db <gets+0x5e>
 1a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ab:	8d 50 01             	lea    0x1(%eax),%edx
 1ae:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1b1:	89 c2                	mov    %eax,%edx
 1b3:	8b 45 08             	mov    0x8(%ebp),%eax
 1b6:	01 c2                	add    %eax,%edx
 1b8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1bc:	88 02                	mov    %al,(%edx)
 1be:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c2:	3c 0a                	cmp    $0xa,%al
 1c4:	74 16                	je     1dc <gets+0x5f>
 1c6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1ca:	3c 0d                	cmp    $0xd,%al
 1cc:	74 0e                	je     1dc <gets+0x5f>
 1ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d1:	83 c0 01             	add    $0x1,%eax
 1d4:	39 45 0c             	cmp    %eax,0xc(%ebp)
 1d7:	7f b3                	jg     18c <gets+0xf>
 1d9:	eb 01                	jmp    1dc <gets+0x5f>
 1db:	90                   	nop
 1dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1df:	8b 45 08             	mov    0x8(%ebp),%eax
 1e2:	01 d0                	add    %edx,%eax
 1e4:	c6 00 00             	movb   $0x0,(%eax)
 1e7:	8b 45 08             	mov    0x8(%ebp),%eax
 1ea:	c9                   	leave  
 1eb:	c3                   	ret    

000001ec <stat>:
 1ec:	55                   	push   %ebp
 1ed:	89 e5                	mov    %esp,%ebp
 1ef:	83 ec 18             	sub    $0x18,%esp
 1f2:	83 ec 08             	sub    $0x8,%esp
 1f5:	6a 00                	push   $0x0
 1f7:	ff 75 08             	push   0x8(%ebp)
 1fa:	e8 67 01 00 00       	call   366 <open>
 1ff:	83 c4 10             	add    $0x10,%esp
 202:	89 45 f4             	mov    %eax,-0xc(%ebp)
 205:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 209:	79 07                	jns    212 <stat+0x26>
 20b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 210:	eb 25                	jmp    237 <stat+0x4b>
 212:	83 ec 08             	sub    $0x8,%esp
 215:	ff 75 0c             	push   0xc(%ebp)
 218:	ff 75 f4             	push   -0xc(%ebp)
 21b:	e8 5e 01 00 00       	call   37e <fstat>
 220:	83 c4 10             	add    $0x10,%esp
 223:	89 45 f0             	mov    %eax,-0x10(%ebp)
 226:	83 ec 0c             	sub    $0xc,%esp
 229:	ff 75 f4             	push   -0xc(%ebp)
 22c:	e8 1d 01 00 00       	call   34e <close>
 231:	83 c4 10             	add    $0x10,%esp
 234:	8b 45 f0             	mov    -0x10(%ebp),%eax
 237:	c9                   	leave  
 238:	c3                   	ret    

00000239 <atoi>:
 239:	55                   	push   %ebp
 23a:	89 e5                	mov    %esp,%ebp
 23c:	83 ec 10             	sub    $0x10,%esp
 23f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 246:	eb 25                	jmp    26d <atoi+0x34>
 248:	8b 55 fc             	mov    -0x4(%ebp),%edx
 24b:	89 d0                	mov    %edx,%eax
 24d:	c1 e0 02             	shl    $0x2,%eax
 250:	01 d0                	add    %edx,%eax
 252:	01 c0                	add    %eax,%eax
 254:	89 c1                	mov    %eax,%ecx
 256:	8b 45 08             	mov    0x8(%ebp),%eax
 259:	8d 50 01             	lea    0x1(%eax),%edx
 25c:	89 55 08             	mov    %edx,0x8(%ebp)
 25f:	0f b6 00             	movzbl (%eax),%eax
 262:	0f be c0             	movsbl %al,%eax
 265:	01 c8                	add    %ecx,%eax
 267:	83 e8 30             	sub    $0x30,%eax
 26a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 26d:	8b 45 08             	mov    0x8(%ebp),%eax
 270:	0f b6 00             	movzbl (%eax),%eax
 273:	3c 2f                	cmp    $0x2f,%al
 275:	7e 0a                	jle    281 <atoi+0x48>
 277:	8b 45 08             	mov    0x8(%ebp),%eax
 27a:	0f b6 00             	movzbl (%eax),%eax
 27d:	3c 39                	cmp    $0x39,%al
 27f:	7e c7                	jle    248 <atoi+0xf>
 281:	8b 45 fc             	mov    -0x4(%ebp),%eax
 284:	c9                   	leave  
 285:	c3                   	ret    

00000286 <memmove>:
 286:	55                   	push   %ebp
 287:	89 e5                	mov    %esp,%ebp
 289:	83 ec 10             	sub    $0x10,%esp
 28c:	8b 45 08             	mov    0x8(%ebp),%eax
 28f:	89 45 fc             	mov    %eax,-0x4(%ebp)
 292:	8b 45 0c             	mov    0xc(%ebp),%eax
 295:	89 45 f8             	mov    %eax,-0x8(%ebp)
 298:	eb 17                	jmp    2b1 <memmove+0x2b>
 29a:	8b 55 f8             	mov    -0x8(%ebp),%edx
 29d:	8d 42 01             	lea    0x1(%edx),%eax
 2a0:	89 45 f8             	mov    %eax,-0x8(%ebp)
 2a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2a6:	8d 48 01             	lea    0x1(%eax),%ecx
 2a9:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 2ac:	0f b6 12             	movzbl (%edx),%edx
 2af:	88 10                	mov    %dl,(%eax)
 2b1:	8b 45 10             	mov    0x10(%ebp),%eax
 2b4:	8d 50 ff             	lea    -0x1(%eax),%edx
 2b7:	89 55 10             	mov    %edx,0x10(%ebp)
 2ba:	85 c0                	test   %eax,%eax
 2bc:	7f dc                	jg     29a <memmove+0x14>
 2be:	8b 45 08             	mov    0x8(%ebp),%eax
 2c1:	c9                   	leave  
 2c2:	c3                   	ret    

000002c3 <calc>:
 2c3:	55                   	push   %ebp
 2c4:	89 e5                	mov    %esp,%ebp
 2c6:	83 ec 10             	sub    $0x10,%esp
 2c9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 2d0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
 2d7:	eb 36                	jmp    30f <calc+0x4c>
 2d9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2e0:	eb 21                	jmp    303 <calc+0x40>
 2e2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 2e9:	eb 0c                	jmp    2f7 <calc+0x34>
 2eb:	c1 7d fc 0a          	sarl   $0xa,-0x4(%ebp)
 2ef:	c1 65 fc 0a          	shll   $0xa,-0x4(%ebp)
 2f3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 2f7:	8b 45 08             	mov    0x8(%ebp),%eax
 2fa:	39 45 f0             	cmp    %eax,-0x10(%ebp)
 2fd:	72 ec                	jb     2eb <calc+0x28>
 2ff:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 303:	8b 45 08             	mov    0x8(%ebp),%eax
 306:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 309:	72 d7                	jb     2e2 <calc+0x1f>
 30b:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 30f:	8b 45 08             	mov    0x8(%ebp),%eax
 312:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 315:	72 c2                	jb     2d9 <calc+0x16>
 317:	b8 00 00 00 00       	mov    $0x0,%eax
 31c:	c9                   	leave  
 31d:	c3                   	ret    

0000031e <fork>:
 31e:	b8 01 00 00 00       	mov    $0x1,%eax
 323:	cd 40                	int    $0x40
 325:	c3                   	ret    

00000326 <exit>:
 326:	b8 02 00 00 00       	mov    $0x2,%eax
 32b:	cd 40                	int    $0x40
 32d:	c3                   	ret    

0000032e <wait>:
 32e:	b8 03 00 00 00       	mov    $0x3,%eax
 333:	cd 40                	int    $0x40
 335:	c3                   	ret    

00000336 <pipe>:
 336:	b8 04 00 00 00       	mov    $0x4,%eax
 33b:	cd 40                	int    $0x40
 33d:	c3                   	ret    

0000033e <read>:
 33e:	b8 05 00 00 00       	mov    $0x5,%eax
 343:	cd 40                	int    $0x40
 345:	c3                   	ret    

00000346 <write>:
 346:	b8 10 00 00 00       	mov    $0x10,%eax
 34b:	cd 40                	int    $0x40
 34d:	c3                   	ret    

0000034e <close>:
 34e:	b8 15 00 00 00       	mov    $0x15,%eax
 353:	cd 40                	int    $0x40
 355:	c3                   	ret    

00000356 <kill>:
 356:	b8 06 00 00 00       	mov    $0x6,%eax
 35b:	cd 40                	int    $0x40
 35d:	c3                   	ret    

0000035e <exec>:
 35e:	b8 07 00 00 00       	mov    $0x7,%eax
 363:	cd 40                	int    $0x40
 365:	c3                   	ret    

00000366 <open>:
 366:	b8 0f 00 00 00       	mov    $0xf,%eax
 36b:	cd 40                	int    $0x40
 36d:	c3                   	ret    

0000036e <mknod>:
 36e:	b8 11 00 00 00       	mov    $0x11,%eax
 373:	cd 40                	int    $0x40
 375:	c3                   	ret    

00000376 <unlink>:
 376:	b8 12 00 00 00       	mov    $0x12,%eax
 37b:	cd 40                	int    $0x40
 37d:	c3                   	ret    

0000037e <fstat>:
 37e:	b8 08 00 00 00       	mov    $0x8,%eax
 383:	cd 40                	int    $0x40
 385:	c3                   	ret    

00000386 <link>:
 386:	b8 13 00 00 00       	mov    $0x13,%eax
 38b:	cd 40                	int    $0x40
 38d:	c3                   	ret    

0000038e <mkdir>:
 38e:	b8 14 00 00 00       	mov    $0x14,%eax
 393:	cd 40                	int    $0x40
 395:	c3                   	ret    

00000396 <chdir>:
 396:	b8 09 00 00 00       	mov    $0x9,%eax
 39b:	cd 40                	int    $0x40
 39d:	c3                   	ret    

0000039e <dup>:
 39e:	b8 0a 00 00 00       	mov    $0xa,%eax
 3a3:	cd 40                	int    $0x40
 3a5:	c3                   	ret    

000003a6 <getpid>:
 3a6:	b8 0b 00 00 00       	mov    $0xb,%eax
 3ab:	cd 40                	int    $0x40
 3ad:	c3                   	ret    

000003ae <sbrk>:
 3ae:	b8 0c 00 00 00       	mov    $0xc,%eax
 3b3:	cd 40                	int    $0x40
 3b5:	c3                   	ret    

000003b6 <sleep>:
 3b6:	b8 0d 00 00 00       	mov    $0xd,%eax
 3bb:	cd 40                	int    $0x40
 3bd:	c3                   	ret    

000003be <uptime>:
 3be:	b8 0e 00 00 00       	mov    $0xe,%eax
 3c3:	cd 40                	int    $0x40
 3c5:	c3                   	ret    

000003c6 <print_proc>:
 3c6:	b8 16 00 00 00       	mov    $0x16,%eax
 3cb:	cd 40                	int    $0x40
 3cd:	c3                   	ret    

000003ce <change_queue>:
 3ce:	b8 17 00 00 00       	mov    $0x17,%eax
 3d3:	cd 40                	int    $0x40
 3d5:	c3                   	ret    

000003d6 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3d6:	55                   	push   %ebp
 3d7:	89 e5                	mov    %esp,%ebp
 3d9:	83 ec 18             	sub    $0x18,%esp
 3dc:	8b 45 0c             	mov    0xc(%ebp),%eax
 3df:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3e2:	83 ec 04             	sub    $0x4,%esp
 3e5:	6a 01                	push   $0x1
 3e7:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3ea:	50                   	push   %eax
 3eb:	ff 75 08             	push   0x8(%ebp)
 3ee:	e8 53 ff ff ff       	call   346 <write>
 3f3:	83 c4 10             	add    $0x10,%esp
}
 3f6:	90                   	nop
 3f7:	c9                   	leave  
 3f8:	c3                   	ret    

000003f9 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3f9:	55                   	push   %ebp
 3fa:	89 e5                	mov    %esp,%ebp
 3fc:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3ff:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 406:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 40a:	74 17                	je     423 <printint+0x2a>
 40c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 410:	79 11                	jns    423 <printint+0x2a>
    neg = 1;
 412:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 419:	8b 45 0c             	mov    0xc(%ebp),%eax
 41c:	f7 d8                	neg    %eax
 41e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 421:	eb 06                	jmp    429 <printint+0x30>
  } else {
    x = xx;
 423:	8b 45 0c             	mov    0xc(%ebp),%eax
 426:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 429:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 430:	8b 4d 10             	mov    0x10(%ebp),%ecx
 433:	8b 45 ec             	mov    -0x14(%ebp),%eax
 436:	ba 00 00 00 00       	mov    $0x0,%edx
 43b:	f7 f1                	div    %ecx
 43d:	89 d1                	mov    %edx,%ecx
 43f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 442:	8d 50 01             	lea    0x1(%eax),%edx
 445:	89 55 f4             	mov    %edx,-0xc(%ebp)
 448:	0f b6 91 f8 0a 00 00 	movzbl 0xaf8(%ecx),%edx
 44f:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 453:	8b 4d 10             	mov    0x10(%ebp),%ecx
 456:	8b 45 ec             	mov    -0x14(%ebp),%eax
 459:	ba 00 00 00 00       	mov    $0x0,%edx
 45e:	f7 f1                	div    %ecx
 460:	89 45 ec             	mov    %eax,-0x14(%ebp)
 463:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 467:	75 c7                	jne    430 <printint+0x37>
  if(neg)
 469:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 46d:	74 2d                	je     49c <printint+0xa3>
    buf[i++] = '-';
 46f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 472:	8d 50 01             	lea    0x1(%eax),%edx
 475:	89 55 f4             	mov    %edx,-0xc(%ebp)
 478:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 47d:	eb 1d                	jmp    49c <printint+0xa3>
    putc(fd, buf[i]);
 47f:	8d 55 dc             	lea    -0x24(%ebp),%edx
 482:	8b 45 f4             	mov    -0xc(%ebp),%eax
 485:	01 d0                	add    %edx,%eax
 487:	0f b6 00             	movzbl (%eax),%eax
 48a:	0f be c0             	movsbl %al,%eax
 48d:	83 ec 08             	sub    $0x8,%esp
 490:	50                   	push   %eax
 491:	ff 75 08             	push   0x8(%ebp)
 494:	e8 3d ff ff ff       	call   3d6 <putc>
 499:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 49c:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4a0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4a4:	79 d9                	jns    47f <printint+0x86>
}
 4a6:	90                   	nop
 4a7:	90                   	nop
 4a8:	c9                   	leave  
 4a9:	c3                   	ret    

000004aa <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4aa:	55                   	push   %ebp
 4ab:	89 e5                	mov    %esp,%ebp
 4ad:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4b0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4b7:	8d 45 0c             	lea    0xc(%ebp),%eax
 4ba:	83 c0 04             	add    $0x4,%eax
 4bd:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4c0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4c7:	e9 59 01 00 00       	jmp    625 <printf+0x17b>
    c = fmt[i] & 0xff;
 4cc:	8b 55 0c             	mov    0xc(%ebp),%edx
 4cf:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4d2:	01 d0                	add    %edx,%eax
 4d4:	0f b6 00             	movzbl (%eax),%eax
 4d7:	0f be c0             	movsbl %al,%eax
 4da:	25 ff 00 00 00       	and    $0xff,%eax
 4df:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4e2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4e6:	75 2c                	jne    514 <printf+0x6a>
      if(c == '%'){
 4e8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4ec:	75 0c                	jne    4fa <printf+0x50>
        state = '%';
 4ee:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4f5:	e9 27 01 00 00       	jmp    621 <printf+0x177>
      } else {
        putc(fd, c);
 4fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4fd:	0f be c0             	movsbl %al,%eax
 500:	83 ec 08             	sub    $0x8,%esp
 503:	50                   	push   %eax
 504:	ff 75 08             	push   0x8(%ebp)
 507:	e8 ca fe ff ff       	call   3d6 <putc>
 50c:	83 c4 10             	add    $0x10,%esp
 50f:	e9 0d 01 00 00       	jmp    621 <printf+0x177>
      }
    } else if(state == '%'){
 514:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 518:	0f 85 03 01 00 00    	jne    621 <printf+0x177>
      if(c == 'd'){
 51e:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 522:	75 1e                	jne    542 <printf+0x98>
        printint(fd, *ap, 10, 1);
 524:	8b 45 e8             	mov    -0x18(%ebp),%eax
 527:	8b 00                	mov    (%eax),%eax
 529:	6a 01                	push   $0x1
 52b:	6a 0a                	push   $0xa
 52d:	50                   	push   %eax
 52e:	ff 75 08             	push   0x8(%ebp)
 531:	e8 c3 fe ff ff       	call   3f9 <printint>
 536:	83 c4 10             	add    $0x10,%esp
        ap++;
 539:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 53d:	e9 d8 00 00 00       	jmp    61a <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 542:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 546:	74 06                	je     54e <printf+0xa4>
 548:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 54c:	75 1e                	jne    56c <printf+0xc2>
        printint(fd, *ap, 16, 0);
 54e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 551:	8b 00                	mov    (%eax),%eax
 553:	6a 00                	push   $0x0
 555:	6a 10                	push   $0x10
 557:	50                   	push   %eax
 558:	ff 75 08             	push   0x8(%ebp)
 55b:	e8 99 fe ff ff       	call   3f9 <printint>
 560:	83 c4 10             	add    $0x10,%esp
        ap++;
 563:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 567:	e9 ae 00 00 00       	jmp    61a <printf+0x170>
      } else if(c == 's'){
 56c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 570:	75 43                	jne    5b5 <printf+0x10b>
        s = (char*)*ap;
 572:	8b 45 e8             	mov    -0x18(%ebp),%eax
 575:	8b 00                	mov    (%eax),%eax
 577:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 57a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 57e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 582:	75 25                	jne    5a9 <printf+0xff>
          s = "(null)";
 584:	c7 45 f4 88 08 00 00 	movl   $0x888,-0xc(%ebp)
        while(*s != 0){
 58b:	eb 1c                	jmp    5a9 <printf+0xff>
          putc(fd, *s);
 58d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 590:	0f b6 00             	movzbl (%eax),%eax
 593:	0f be c0             	movsbl %al,%eax
 596:	83 ec 08             	sub    $0x8,%esp
 599:	50                   	push   %eax
 59a:	ff 75 08             	push   0x8(%ebp)
 59d:	e8 34 fe ff ff       	call   3d6 <putc>
 5a2:	83 c4 10             	add    $0x10,%esp
          s++;
 5a5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 5a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5ac:	0f b6 00             	movzbl (%eax),%eax
 5af:	84 c0                	test   %al,%al
 5b1:	75 da                	jne    58d <printf+0xe3>
 5b3:	eb 65                	jmp    61a <printf+0x170>
        }
      } else if(c == 'c'){
 5b5:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5b9:	75 1d                	jne    5d8 <printf+0x12e>
        putc(fd, *ap);
 5bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5be:	8b 00                	mov    (%eax),%eax
 5c0:	0f be c0             	movsbl %al,%eax
 5c3:	83 ec 08             	sub    $0x8,%esp
 5c6:	50                   	push   %eax
 5c7:	ff 75 08             	push   0x8(%ebp)
 5ca:	e8 07 fe ff ff       	call   3d6 <putc>
 5cf:	83 c4 10             	add    $0x10,%esp
        ap++;
 5d2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5d6:	eb 42                	jmp    61a <printf+0x170>
      } else if(c == '%'){
 5d8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5dc:	75 17                	jne    5f5 <printf+0x14b>
        putc(fd, c);
 5de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5e1:	0f be c0             	movsbl %al,%eax
 5e4:	83 ec 08             	sub    $0x8,%esp
 5e7:	50                   	push   %eax
 5e8:	ff 75 08             	push   0x8(%ebp)
 5eb:	e8 e6 fd ff ff       	call   3d6 <putc>
 5f0:	83 c4 10             	add    $0x10,%esp
 5f3:	eb 25                	jmp    61a <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5f5:	83 ec 08             	sub    $0x8,%esp
 5f8:	6a 25                	push   $0x25
 5fa:	ff 75 08             	push   0x8(%ebp)
 5fd:	e8 d4 fd ff ff       	call   3d6 <putc>
 602:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 605:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 608:	0f be c0             	movsbl %al,%eax
 60b:	83 ec 08             	sub    $0x8,%esp
 60e:	50                   	push   %eax
 60f:	ff 75 08             	push   0x8(%ebp)
 612:	e8 bf fd ff ff       	call   3d6 <putc>
 617:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 61a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 621:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 625:	8b 55 0c             	mov    0xc(%ebp),%edx
 628:	8b 45 f0             	mov    -0x10(%ebp),%eax
 62b:	01 d0                	add    %edx,%eax
 62d:	0f b6 00             	movzbl (%eax),%eax
 630:	84 c0                	test   %al,%al
 632:	0f 85 94 fe ff ff    	jne    4cc <printf+0x22>
    }
  }
}
 638:	90                   	nop
 639:	90                   	nop
 63a:	c9                   	leave  
 63b:	c3                   	ret    

0000063c <free>:
 63c:	55                   	push   %ebp
 63d:	89 e5                	mov    %esp,%ebp
 63f:	83 ec 10             	sub    $0x10,%esp
 642:	8b 45 08             	mov    0x8(%ebp),%eax
 645:	83 e8 08             	sub    $0x8,%eax
 648:	89 45 f8             	mov    %eax,-0x8(%ebp)
 64b:	a1 14 0b 00 00       	mov    0xb14,%eax
 650:	89 45 fc             	mov    %eax,-0x4(%ebp)
 653:	eb 24                	jmp    679 <free+0x3d>
 655:	8b 45 fc             	mov    -0x4(%ebp),%eax
 658:	8b 00                	mov    (%eax),%eax
 65a:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 65d:	72 12                	jb     671 <free+0x35>
 65f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 662:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 665:	77 24                	ja     68b <free+0x4f>
 667:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66a:	8b 00                	mov    (%eax),%eax
 66c:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 66f:	72 1a                	jb     68b <free+0x4f>
 671:	8b 45 fc             	mov    -0x4(%ebp),%eax
 674:	8b 00                	mov    (%eax),%eax
 676:	89 45 fc             	mov    %eax,-0x4(%ebp)
 679:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 67f:	76 d4                	jbe    655 <free+0x19>
 681:	8b 45 fc             	mov    -0x4(%ebp),%eax
 684:	8b 00                	mov    (%eax),%eax
 686:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 689:	73 ca                	jae    655 <free+0x19>
 68b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68e:	8b 40 04             	mov    0x4(%eax),%eax
 691:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 698:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69b:	01 c2                	add    %eax,%edx
 69d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a0:	8b 00                	mov    (%eax),%eax
 6a2:	39 c2                	cmp    %eax,%edx
 6a4:	75 24                	jne    6ca <free+0x8e>
 6a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a9:	8b 50 04             	mov    0x4(%eax),%edx
 6ac:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6af:	8b 00                	mov    (%eax),%eax
 6b1:	8b 40 04             	mov    0x4(%eax),%eax
 6b4:	01 c2                	add    %eax,%edx
 6b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b9:	89 50 04             	mov    %edx,0x4(%eax)
 6bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bf:	8b 00                	mov    (%eax),%eax
 6c1:	8b 10                	mov    (%eax),%edx
 6c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c6:	89 10                	mov    %edx,(%eax)
 6c8:	eb 0a                	jmp    6d4 <free+0x98>
 6ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cd:	8b 10                	mov    (%eax),%edx
 6cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d2:	89 10                	mov    %edx,(%eax)
 6d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d7:	8b 40 04             	mov    0x4(%eax),%eax
 6da:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e4:	01 d0                	add    %edx,%eax
 6e6:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 6e9:	75 20                	jne    70b <free+0xcf>
 6eb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ee:	8b 50 04             	mov    0x4(%eax),%edx
 6f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f4:	8b 40 04             	mov    0x4(%eax),%eax
 6f7:	01 c2                	add    %eax,%edx
 6f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fc:	89 50 04             	mov    %edx,0x4(%eax)
 6ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
 702:	8b 10                	mov    (%eax),%edx
 704:	8b 45 fc             	mov    -0x4(%ebp),%eax
 707:	89 10                	mov    %edx,(%eax)
 709:	eb 08                	jmp    713 <free+0xd7>
 70b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 711:	89 10                	mov    %edx,(%eax)
 713:	8b 45 fc             	mov    -0x4(%ebp),%eax
 716:	a3 14 0b 00 00       	mov    %eax,0xb14
 71b:	90                   	nop
 71c:	c9                   	leave  
 71d:	c3                   	ret    

0000071e <morecore>:
 71e:	55                   	push   %ebp
 71f:	89 e5                	mov    %esp,%ebp
 721:	83 ec 18             	sub    $0x18,%esp
 724:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 72b:	77 07                	ja     734 <morecore+0x16>
 72d:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
 734:	8b 45 08             	mov    0x8(%ebp),%eax
 737:	c1 e0 03             	shl    $0x3,%eax
 73a:	83 ec 0c             	sub    $0xc,%esp
 73d:	50                   	push   %eax
 73e:	e8 6b fc ff ff       	call   3ae <sbrk>
 743:	83 c4 10             	add    $0x10,%esp
 746:	89 45 f4             	mov    %eax,-0xc(%ebp)
 749:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 74d:	75 07                	jne    756 <morecore+0x38>
 74f:	b8 00 00 00 00       	mov    $0x0,%eax
 754:	eb 26                	jmp    77c <morecore+0x5e>
 756:	8b 45 f4             	mov    -0xc(%ebp),%eax
 759:	89 45 f0             	mov    %eax,-0x10(%ebp)
 75c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 75f:	8b 55 08             	mov    0x8(%ebp),%edx
 762:	89 50 04             	mov    %edx,0x4(%eax)
 765:	8b 45 f0             	mov    -0x10(%ebp),%eax
 768:	83 c0 08             	add    $0x8,%eax
 76b:	83 ec 0c             	sub    $0xc,%esp
 76e:	50                   	push   %eax
 76f:	e8 c8 fe ff ff       	call   63c <free>
 774:	83 c4 10             	add    $0x10,%esp
 777:	a1 14 0b 00 00       	mov    0xb14,%eax
 77c:	c9                   	leave  
 77d:	c3                   	ret    

0000077e <malloc>:
 77e:	55                   	push   %ebp
 77f:	89 e5                	mov    %esp,%ebp
 781:	83 ec 18             	sub    $0x18,%esp
 784:	8b 45 08             	mov    0x8(%ebp),%eax
 787:	83 c0 07             	add    $0x7,%eax
 78a:	c1 e8 03             	shr    $0x3,%eax
 78d:	83 c0 01             	add    $0x1,%eax
 790:	89 45 ec             	mov    %eax,-0x14(%ebp)
 793:	a1 14 0b 00 00       	mov    0xb14,%eax
 798:	89 45 f0             	mov    %eax,-0x10(%ebp)
 79b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 79f:	75 23                	jne    7c4 <malloc+0x46>
 7a1:	c7 45 f0 0c 0b 00 00 	movl   $0xb0c,-0x10(%ebp)
 7a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ab:	a3 14 0b 00 00       	mov    %eax,0xb14
 7b0:	a1 14 0b 00 00       	mov    0xb14,%eax
 7b5:	a3 0c 0b 00 00       	mov    %eax,0xb0c
 7ba:	c7 05 10 0b 00 00 00 	movl   $0x0,0xb10
 7c1:	00 00 00 
 7c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c7:	8b 00                	mov    (%eax),%eax
 7c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7cf:	8b 40 04             	mov    0x4(%eax),%eax
 7d2:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7d5:	77 4d                	ja     824 <malloc+0xa6>
 7d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7da:	8b 40 04             	mov    0x4(%eax),%eax
 7dd:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7e0:	75 0c                	jne    7ee <malloc+0x70>
 7e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e5:	8b 10                	mov    (%eax),%edx
 7e7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ea:	89 10                	mov    %edx,(%eax)
 7ec:	eb 26                	jmp    814 <malloc+0x96>
 7ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f1:	8b 40 04             	mov    0x4(%eax),%eax
 7f4:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7f7:	89 c2                	mov    %eax,%edx
 7f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fc:	89 50 04             	mov    %edx,0x4(%eax)
 7ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 802:	8b 40 04             	mov    0x4(%eax),%eax
 805:	c1 e0 03             	shl    $0x3,%eax
 808:	01 45 f4             	add    %eax,-0xc(%ebp)
 80b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80e:	8b 55 ec             	mov    -0x14(%ebp),%edx
 811:	89 50 04             	mov    %edx,0x4(%eax)
 814:	8b 45 f0             	mov    -0x10(%ebp),%eax
 817:	a3 14 0b 00 00       	mov    %eax,0xb14
 81c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81f:	83 c0 08             	add    $0x8,%eax
 822:	eb 3b                	jmp    85f <malloc+0xe1>
 824:	a1 14 0b 00 00       	mov    0xb14,%eax
 829:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 82c:	75 1e                	jne    84c <malloc+0xce>
 82e:	83 ec 0c             	sub    $0xc,%esp
 831:	ff 75 ec             	push   -0x14(%ebp)
 834:	e8 e5 fe ff ff       	call   71e <morecore>
 839:	83 c4 10             	add    $0x10,%esp
 83c:	89 45 f4             	mov    %eax,-0xc(%ebp)
 83f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 843:	75 07                	jne    84c <malloc+0xce>
 845:	b8 00 00 00 00       	mov    $0x0,%eax
 84a:	eb 13                	jmp    85f <malloc+0xe1>
 84c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 852:	8b 45 f4             	mov    -0xc(%ebp),%eax
 855:	8b 00                	mov    (%eax),%eax
 857:	89 45 f4             	mov    %eax,-0xc(%ebp)
 85a:	e9 6d ff ff ff       	jmp    7cc <malloc+0x4e>
 85f:	c9                   	leave  
 860:	c3                   	ret    
