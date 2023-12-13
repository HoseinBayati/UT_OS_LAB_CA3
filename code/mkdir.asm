
_mkdir:     file format elf32-i386


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
   f:	83 ec 10             	sub    $0x10,%esp
  12:	89 cb                	mov    %ecx,%ebx
  int i;

  if(argc < 2){
  14:	83 3b 01             	cmpl   $0x1,(%ebx)
  17:	7f 17                	jg     30 <main+0x30>
    printf(2, "Usage: mkdir files...\n");
  19:	83 ec 08             	sub    $0x8,%esp
  1c:	68 7d 08 00 00       	push   $0x87d
  21:	6a 02                	push   $0x2
  23:	e8 9e 04 00 00       	call   4c6 <printf>
  28:	83 c4 10             	add    $0x10,%esp
    exit();
  2b:	e8 12 03 00 00       	call   342 <exit>
  }

  for(i = 1; i < argc; i++){
  30:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  37:	eb 4b                	jmp    84 <main+0x84>
    if(mkdir(argv[i]) < 0){
  39:	8b 45 f4             	mov    -0xc(%ebp),%eax
  3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  43:	8b 43 04             	mov    0x4(%ebx),%eax
  46:	01 d0                	add    %edx,%eax
  48:	8b 00                	mov    (%eax),%eax
  4a:	83 ec 0c             	sub    $0xc,%esp
  4d:	50                   	push   %eax
  4e:	e8 57 03 00 00       	call   3aa <mkdir>
  53:	83 c4 10             	add    $0x10,%esp
  56:	85 c0                	test   %eax,%eax
  58:	79 26                	jns    80 <main+0x80>
      printf(2, "mkdir: %s failed to create\n", argv[i]);
  5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
  5d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  64:	8b 43 04             	mov    0x4(%ebx),%eax
  67:	01 d0                	add    %edx,%eax
  69:	8b 00                	mov    (%eax),%eax
  6b:	83 ec 04             	sub    $0x4,%esp
  6e:	50                   	push   %eax
  6f:	68 94 08 00 00       	push   $0x894
  74:	6a 02                	push   $0x2
  76:	e8 4b 04 00 00       	call   4c6 <printf>
  7b:	83 c4 10             	add    $0x10,%esp
      break;
  7e:	eb 0b                	jmp    8b <main+0x8b>
  for(i = 1; i < argc; i++){
  80:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  84:	8b 45 f4             	mov    -0xc(%ebp),%eax
  87:	3b 03                	cmp    (%ebx),%eax
  89:	7c ae                	jl     39 <main+0x39>
    }
  }

  exit();
  8b:	e8 b2 02 00 00       	call   342 <exit>

00000090 <stosb>:
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	57                   	push   %edi
  94:	53                   	push   %ebx
  95:	8b 4d 08             	mov    0x8(%ebp),%ecx
  98:	8b 55 10             	mov    0x10(%ebp),%edx
  9b:	8b 45 0c             	mov    0xc(%ebp),%eax
  9e:	89 cb                	mov    %ecx,%ebx
  a0:	89 df                	mov    %ebx,%edi
  a2:	89 d1                	mov    %edx,%ecx
  a4:	fc                   	cld    
  a5:	f3 aa                	rep stos %al,%es:(%edi)
  a7:	89 ca                	mov    %ecx,%edx
  a9:	89 fb                	mov    %edi,%ebx
  ab:	89 5d 08             	mov    %ebx,0x8(%ebp)
  ae:	89 55 10             	mov    %edx,0x10(%ebp)
  b1:	90                   	nop
  b2:	5b                   	pop    %ebx
  b3:	5f                   	pop    %edi
  b4:	5d                   	pop    %ebp
  b5:	c3                   	ret    

000000b6 <strcpy>:
  b6:	55                   	push   %ebp
  b7:	89 e5                	mov    %esp,%ebp
  b9:	83 ec 10             	sub    $0x10,%esp
  bc:	8b 45 08             	mov    0x8(%ebp),%eax
  bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
  c2:	90                   	nop
  c3:	8b 55 0c             	mov    0xc(%ebp),%edx
  c6:	8d 42 01             	lea    0x1(%edx),%eax
  c9:	89 45 0c             	mov    %eax,0xc(%ebp)
  cc:	8b 45 08             	mov    0x8(%ebp),%eax
  cf:	8d 48 01             	lea    0x1(%eax),%ecx
  d2:	89 4d 08             	mov    %ecx,0x8(%ebp)
  d5:	0f b6 12             	movzbl (%edx),%edx
  d8:	88 10                	mov    %dl,(%eax)
  da:	0f b6 00             	movzbl (%eax),%eax
  dd:	84 c0                	test   %al,%al
  df:	75 e2                	jne    c3 <strcpy+0xd>
  e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
  e4:	c9                   	leave  
  e5:	c3                   	ret    

000000e6 <strcmp>:
  e6:	55                   	push   %ebp
  e7:	89 e5                	mov    %esp,%ebp
  e9:	eb 08                	jmp    f3 <strcmp+0xd>
  eb:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  ef:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  f3:	8b 45 08             	mov    0x8(%ebp),%eax
  f6:	0f b6 00             	movzbl (%eax),%eax
  f9:	84 c0                	test   %al,%al
  fb:	74 10                	je     10d <strcmp+0x27>
  fd:	8b 45 08             	mov    0x8(%ebp),%eax
 100:	0f b6 10             	movzbl (%eax),%edx
 103:	8b 45 0c             	mov    0xc(%ebp),%eax
 106:	0f b6 00             	movzbl (%eax),%eax
 109:	38 c2                	cmp    %al,%dl
 10b:	74 de                	je     eb <strcmp+0x5>
 10d:	8b 45 08             	mov    0x8(%ebp),%eax
 110:	0f b6 00             	movzbl (%eax),%eax
 113:	0f b6 d0             	movzbl %al,%edx
 116:	8b 45 0c             	mov    0xc(%ebp),%eax
 119:	0f b6 00             	movzbl (%eax),%eax
 11c:	0f b6 c8             	movzbl %al,%ecx
 11f:	89 d0                	mov    %edx,%eax
 121:	29 c8                	sub    %ecx,%eax
 123:	5d                   	pop    %ebp
 124:	c3                   	ret    

00000125 <strlen>:
 125:	55                   	push   %ebp
 126:	89 e5                	mov    %esp,%ebp
 128:	83 ec 10             	sub    $0x10,%esp
 12b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 132:	eb 04                	jmp    138 <strlen+0x13>
 134:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 138:	8b 55 fc             	mov    -0x4(%ebp),%edx
 13b:	8b 45 08             	mov    0x8(%ebp),%eax
 13e:	01 d0                	add    %edx,%eax
 140:	0f b6 00             	movzbl (%eax),%eax
 143:	84 c0                	test   %al,%al
 145:	75 ed                	jne    134 <strlen+0xf>
 147:	8b 45 fc             	mov    -0x4(%ebp),%eax
 14a:	c9                   	leave  
 14b:	c3                   	ret    

0000014c <memset>:
 14c:	55                   	push   %ebp
 14d:	89 e5                	mov    %esp,%ebp
 14f:	8b 45 10             	mov    0x10(%ebp),%eax
 152:	50                   	push   %eax
 153:	ff 75 0c             	push   0xc(%ebp)
 156:	ff 75 08             	push   0x8(%ebp)
 159:	e8 32 ff ff ff       	call   90 <stosb>
 15e:	83 c4 0c             	add    $0xc,%esp
 161:	8b 45 08             	mov    0x8(%ebp),%eax
 164:	c9                   	leave  
 165:	c3                   	ret    

00000166 <strchr>:
 166:	55                   	push   %ebp
 167:	89 e5                	mov    %esp,%ebp
 169:	83 ec 04             	sub    $0x4,%esp
 16c:	8b 45 0c             	mov    0xc(%ebp),%eax
 16f:	88 45 fc             	mov    %al,-0x4(%ebp)
 172:	eb 14                	jmp    188 <strchr+0x22>
 174:	8b 45 08             	mov    0x8(%ebp),%eax
 177:	0f b6 00             	movzbl (%eax),%eax
 17a:	38 45 fc             	cmp    %al,-0x4(%ebp)
 17d:	75 05                	jne    184 <strchr+0x1e>
 17f:	8b 45 08             	mov    0x8(%ebp),%eax
 182:	eb 13                	jmp    197 <strchr+0x31>
 184:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 188:	8b 45 08             	mov    0x8(%ebp),%eax
 18b:	0f b6 00             	movzbl (%eax),%eax
 18e:	84 c0                	test   %al,%al
 190:	75 e2                	jne    174 <strchr+0xe>
 192:	b8 00 00 00 00       	mov    $0x0,%eax
 197:	c9                   	leave  
 198:	c3                   	ret    

00000199 <gets>:
 199:	55                   	push   %ebp
 19a:	89 e5                	mov    %esp,%ebp
 19c:	83 ec 18             	sub    $0x18,%esp
 19f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1a6:	eb 42                	jmp    1ea <gets+0x51>
 1a8:	83 ec 04             	sub    $0x4,%esp
 1ab:	6a 01                	push   $0x1
 1ad:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1b0:	50                   	push   %eax
 1b1:	6a 00                	push   $0x0
 1b3:	e8 a2 01 00 00       	call   35a <read>
 1b8:	83 c4 10             	add    $0x10,%esp
 1bb:	89 45 f0             	mov    %eax,-0x10(%ebp)
 1be:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1c2:	7e 33                	jle    1f7 <gets+0x5e>
 1c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c7:	8d 50 01             	lea    0x1(%eax),%edx
 1ca:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1cd:	89 c2                	mov    %eax,%edx
 1cf:	8b 45 08             	mov    0x8(%ebp),%eax
 1d2:	01 c2                	add    %eax,%edx
 1d4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d8:	88 02                	mov    %al,(%edx)
 1da:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1de:	3c 0a                	cmp    $0xa,%al
 1e0:	74 16                	je     1f8 <gets+0x5f>
 1e2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1e6:	3c 0d                	cmp    $0xd,%al
 1e8:	74 0e                	je     1f8 <gets+0x5f>
 1ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ed:	83 c0 01             	add    $0x1,%eax
 1f0:	39 45 0c             	cmp    %eax,0xc(%ebp)
 1f3:	7f b3                	jg     1a8 <gets+0xf>
 1f5:	eb 01                	jmp    1f8 <gets+0x5f>
 1f7:	90                   	nop
 1f8:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1fb:	8b 45 08             	mov    0x8(%ebp),%eax
 1fe:	01 d0                	add    %edx,%eax
 200:	c6 00 00             	movb   $0x0,(%eax)
 203:	8b 45 08             	mov    0x8(%ebp),%eax
 206:	c9                   	leave  
 207:	c3                   	ret    

00000208 <stat>:
 208:	55                   	push   %ebp
 209:	89 e5                	mov    %esp,%ebp
 20b:	83 ec 18             	sub    $0x18,%esp
 20e:	83 ec 08             	sub    $0x8,%esp
 211:	6a 00                	push   $0x0
 213:	ff 75 08             	push   0x8(%ebp)
 216:	e8 67 01 00 00       	call   382 <open>
 21b:	83 c4 10             	add    $0x10,%esp
 21e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 221:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 225:	79 07                	jns    22e <stat+0x26>
 227:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 22c:	eb 25                	jmp    253 <stat+0x4b>
 22e:	83 ec 08             	sub    $0x8,%esp
 231:	ff 75 0c             	push   0xc(%ebp)
 234:	ff 75 f4             	push   -0xc(%ebp)
 237:	e8 5e 01 00 00       	call   39a <fstat>
 23c:	83 c4 10             	add    $0x10,%esp
 23f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 242:	83 ec 0c             	sub    $0xc,%esp
 245:	ff 75 f4             	push   -0xc(%ebp)
 248:	e8 1d 01 00 00       	call   36a <close>
 24d:	83 c4 10             	add    $0x10,%esp
 250:	8b 45 f0             	mov    -0x10(%ebp),%eax
 253:	c9                   	leave  
 254:	c3                   	ret    

00000255 <atoi>:
 255:	55                   	push   %ebp
 256:	89 e5                	mov    %esp,%ebp
 258:	83 ec 10             	sub    $0x10,%esp
 25b:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 262:	eb 25                	jmp    289 <atoi+0x34>
 264:	8b 55 fc             	mov    -0x4(%ebp),%edx
 267:	89 d0                	mov    %edx,%eax
 269:	c1 e0 02             	shl    $0x2,%eax
 26c:	01 d0                	add    %edx,%eax
 26e:	01 c0                	add    %eax,%eax
 270:	89 c1                	mov    %eax,%ecx
 272:	8b 45 08             	mov    0x8(%ebp),%eax
 275:	8d 50 01             	lea    0x1(%eax),%edx
 278:	89 55 08             	mov    %edx,0x8(%ebp)
 27b:	0f b6 00             	movzbl (%eax),%eax
 27e:	0f be c0             	movsbl %al,%eax
 281:	01 c8                	add    %ecx,%eax
 283:	83 e8 30             	sub    $0x30,%eax
 286:	89 45 fc             	mov    %eax,-0x4(%ebp)
 289:	8b 45 08             	mov    0x8(%ebp),%eax
 28c:	0f b6 00             	movzbl (%eax),%eax
 28f:	3c 2f                	cmp    $0x2f,%al
 291:	7e 0a                	jle    29d <atoi+0x48>
 293:	8b 45 08             	mov    0x8(%ebp),%eax
 296:	0f b6 00             	movzbl (%eax),%eax
 299:	3c 39                	cmp    $0x39,%al
 29b:	7e c7                	jle    264 <atoi+0xf>
 29d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2a0:	c9                   	leave  
 2a1:	c3                   	ret    

000002a2 <memmove>:
 2a2:	55                   	push   %ebp
 2a3:	89 e5                	mov    %esp,%ebp
 2a5:	83 ec 10             	sub    $0x10,%esp
 2a8:	8b 45 08             	mov    0x8(%ebp),%eax
 2ab:	89 45 fc             	mov    %eax,-0x4(%ebp)
 2ae:	8b 45 0c             	mov    0xc(%ebp),%eax
 2b1:	89 45 f8             	mov    %eax,-0x8(%ebp)
 2b4:	eb 17                	jmp    2cd <memmove+0x2b>
 2b6:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2b9:	8d 42 01             	lea    0x1(%edx),%eax
 2bc:	89 45 f8             	mov    %eax,-0x8(%ebp)
 2bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2c2:	8d 48 01             	lea    0x1(%eax),%ecx
 2c5:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 2c8:	0f b6 12             	movzbl (%edx),%edx
 2cb:	88 10                	mov    %dl,(%eax)
 2cd:	8b 45 10             	mov    0x10(%ebp),%eax
 2d0:	8d 50 ff             	lea    -0x1(%eax),%edx
 2d3:	89 55 10             	mov    %edx,0x10(%ebp)
 2d6:	85 c0                	test   %eax,%eax
 2d8:	7f dc                	jg     2b6 <memmove+0x14>
 2da:	8b 45 08             	mov    0x8(%ebp),%eax
 2dd:	c9                   	leave  
 2de:	c3                   	ret    

000002df <calc>:
 2df:	55                   	push   %ebp
 2e0:	89 e5                	mov    %esp,%ebp
 2e2:	83 ec 10             	sub    $0x10,%esp
 2e5:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 2ec:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
 2f3:	eb 36                	jmp    32b <calc+0x4c>
 2f5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2fc:	eb 21                	jmp    31f <calc+0x40>
 2fe:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 305:	eb 0c                	jmp    313 <calc+0x34>
 307:	c1 7d fc 0a          	sarl   $0xa,-0x4(%ebp)
 30b:	c1 65 fc 0a          	shll   $0xa,-0x4(%ebp)
 30f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 313:	8b 45 08             	mov    0x8(%ebp),%eax
 316:	39 45 f0             	cmp    %eax,-0x10(%ebp)
 319:	72 ec                	jb     307 <calc+0x28>
 31b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 31f:	8b 45 08             	mov    0x8(%ebp),%eax
 322:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 325:	72 d7                	jb     2fe <calc+0x1f>
 327:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 32b:	8b 45 08             	mov    0x8(%ebp),%eax
 32e:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 331:	72 c2                	jb     2f5 <calc+0x16>
 333:	b8 00 00 00 00       	mov    $0x0,%eax
 338:	c9                   	leave  
 339:	c3                   	ret    

0000033a <fork>:
 33a:	b8 01 00 00 00       	mov    $0x1,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <exit>:
 342:	b8 02 00 00 00       	mov    $0x2,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <wait>:
 34a:	b8 03 00 00 00       	mov    $0x3,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <pipe>:
 352:	b8 04 00 00 00       	mov    $0x4,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <read>:
 35a:	b8 05 00 00 00       	mov    $0x5,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <write>:
 362:	b8 10 00 00 00       	mov    $0x10,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <close>:
 36a:	b8 15 00 00 00       	mov    $0x15,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <kill>:
 372:	b8 06 00 00 00       	mov    $0x6,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <exec>:
 37a:	b8 07 00 00 00       	mov    $0x7,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <open>:
 382:	b8 0f 00 00 00       	mov    $0xf,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <mknod>:
 38a:	b8 11 00 00 00       	mov    $0x11,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <unlink>:
 392:	b8 12 00 00 00       	mov    $0x12,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <fstat>:
 39a:	b8 08 00 00 00       	mov    $0x8,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <link>:
 3a2:	b8 13 00 00 00       	mov    $0x13,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <mkdir>:
 3aa:	b8 14 00 00 00       	mov    $0x14,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <chdir>:
 3b2:	b8 09 00 00 00       	mov    $0x9,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <dup>:
 3ba:	b8 0a 00 00 00       	mov    $0xa,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <getpid>:
 3c2:	b8 0b 00 00 00       	mov    $0xb,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <sbrk>:
 3ca:	b8 0c 00 00 00       	mov    $0xc,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <sleep>:
 3d2:	b8 0d 00 00 00       	mov    $0xd,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <uptime>:
 3da:	b8 0e 00 00 00       	mov    $0xe,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <print_proc>:
 3e2:	b8 16 00 00 00       	mov    $0x16,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <change_queue>:
 3ea:	b8 17 00 00 00       	mov    $0x17,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3f2:	55                   	push   %ebp
 3f3:	89 e5                	mov    %esp,%ebp
 3f5:	83 ec 18             	sub    $0x18,%esp
 3f8:	8b 45 0c             	mov    0xc(%ebp),%eax
 3fb:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3fe:	83 ec 04             	sub    $0x4,%esp
 401:	6a 01                	push   $0x1
 403:	8d 45 f4             	lea    -0xc(%ebp),%eax
 406:	50                   	push   %eax
 407:	ff 75 08             	push   0x8(%ebp)
 40a:	e8 53 ff ff ff       	call   362 <write>
 40f:	83 c4 10             	add    $0x10,%esp
}
 412:	90                   	nop
 413:	c9                   	leave  
 414:	c3                   	ret    

00000415 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 415:	55                   	push   %ebp
 416:	89 e5                	mov    %esp,%ebp
 418:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 41b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 422:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 426:	74 17                	je     43f <printint+0x2a>
 428:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 42c:	79 11                	jns    43f <printint+0x2a>
    neg = 1;
 42e:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 435:	8b 45 0c             	mov    0xc(%ebp),%eax
 438:	f7 d8                	neg    %eax
 43a:	89 45 ec             	mov    %eax,-0x14(%ebp)
 43d:	eb 06                	jmp    445 <printint+0x30>
  } else {
    x = xx;
 43f:	8b 45 0c             	mov    0xc(%ebp),%eax
 442:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 445:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 44c:	8b 4d 10             	mov    0x10(%ebp),%ecx
 44f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 452:	ba 00 00 00 00       	mov    $0x0,%edx
 457:	f7 f1                	div    %ecx
 459:	89 d1                	mov    %edx,%ecx
 45b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 45e:	8d 50 01             	lea    0x1(%eax),%edx
 461:	89 55 f4             	mov    %edx,-0xc(%ebp)
 464:	0f b6 91 20 0b 00 00 	movzbl 0xb20(%ecx),%edx
 46b:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 46f:	8b 4d 10             	mov    0x10(%ebp),%ecx
 472:	8b 45 ec             	mov    -0x14(%ebp),%eax
 475:	ba 00 00 00 00       	mov    $0x0,%edx
 47a:	f7 f1                	div    %ecx
 47c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 47f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 483:	75 c7                	jne    44c <printint+0x37>
  if(neg)
 485:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 489:	74 2d                	je     4b8 <printint+0xa3>
    buf[i++] = '-';
 48b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 48e:	8d 50 01             	lea    0x1(%eax),%edx
 491:	89 55 f4             	mov    %edx,-0xc(%ebp)
 494:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 499:	eb 1d                	jmp    4b8 <printint+0xa3>
    putc(fd, buf[i]);
 49b:	8d 55 dc             	lea    -0x24(%ebp),%edx
 49e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4a1:	01 d0                	add    %edx,%eax
 4a3:	0f b6 00             	movzbl (%eax),%eax
 4a6:	0f be c0             	movsbl %al,%eax
 4a9:	83 ec 08             	sub    $0x8,%esp
 4ac:	50                   	push   %eax
 4ad:	ff 75 08             	push   0x8(%ebp)
 4b0:	e8 3d ff ff ff       	call   3f2 <putc>
 4b5:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 4b8:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4c0:	79 d9                	jns    49b <printint+0x86>
}
 4c2:	90                   	nop
 4c3:	90                   	nop
 4c4:	c9                   	leave  
 4c5:	c3                   	ret    

000004c6 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4c6:	55                   	push   %ebp
 4c7:	89 e5                	mov    %esp,%ebp
 4c9:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4cc:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4d3:	8d 45 0c             	lea    0xc(%ebp),%eax
 4d6:	83 c0 04             	add    $0x4,%eax
 4d9:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4dc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4e3:	e9 59 01 00 00       	jmp    641 <printf+0x17b>
    c = fmt[i] & 0xff;
 4e8:	8b 55 0c             	mov    0xc(%ebp),%edx
 4eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4ee:	01 d0                	add    %edx,%eax
 4f0:	0f b6 00             	movzbl (%eax),%eax
 4f3:	0f be c0             	movsbl %al,%eax
 4f6:	25 ff 00 00 00       	and    $0xff,%eax
 4fb:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4fe:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 502:	75 2c                	jne    530 <printf+0x6a>
      if(c == '%'){
 504:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 508:	75 0c                	jne    516 <printf+0x50>
        state = '%';
 50a:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 511:	e9 27 01 00 00       	jmp    63d <printf+0x177>
      } else {
        putc(fd, c);
 516:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 519:	0f be c0             	movsbl %al,%eax
 51c:	83 ec 08             	sub    $0x8,%esp
 51f:	50                   	push   %eax
 520:	ff 75 08             	push   0x8(%ebp)
 523:	e8 ca fe ff ff       	call   3f2 <putc>
 528:	83 c4 10             	add    $0x10,%esp
 52b:	e9 0d 01 00 00       	jmp    63d <printf+0x177>
      }
    } else if(state == '%'){
 530:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 534:	0f 85 03 01 00 00    	jne    63d <printf+0x177>
      if(c == 'd'){
 53a:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 53e:	75 1e                	jne    55e <printf+0x98>
        printint(fd, *ap, 10, 1);
 540:	8b 45 e8             	mov    -0x18(%ebp),%eax
 543:	8b 00                	mov    (%eax),%eax
 545:	6a 01                	push   $0x1
 547:	6a 0a                	push   $0xa
 549:	50                   	push   %eax
 54a:	ff 75 08             	push   0x8(%ebp)
 54d:	e8 c3 fe ff ff       	call   415 <printint>
 552:	83 c4 10             	add    $0x10,%esp
        ap++;
 555:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 559:	e9 d8 00 00 00       	jmp    636 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 55e:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 562:	74 06                	je     56a <printf+0xa4>
 564:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 568:	75 1e                	jne    588 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 56a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 56d:	8b 00                	mov    (%eax),%eax
 56f:	6a 00                	push   $0x0
 571:	6a 10                	push   $0x10
 573:	50                   	push   %eax
 574:	ff 75 08             	push   0x8(%ebp)
 577:	e8 99 fe ff ff       	call   415 <printint>
 57c:	83 c4 10             	add    $0x10,%esp
        ap++;
 57f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 583:	e9 ae 00 00 00       	jmp    636 <printf+0x170>
      } else if(c == 's'){
 588:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 58c:	75 43                	jne    5d1 <printf+0x10b>
        s = (char*)*ap;
 58e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 591:	8b 00                	mov    (%eax),%eax
 593:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 596:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 59a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 59e:	75 25                	jne    5c5 <printf+0xff>
          s = "(null)";
 5a0:	c7 45 f4 b0 08 00 00 	movl   $0x8b0,-0xc(%ebp)
        while(*s != 0){
 5a7:	eb 1c                	jmp    5c5 <printf+0xff>
          putc(fd, *s);
 5a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5ac:	0f b6 00             	movzbl (%eax),%eax
 5af:	0f be c0             	movsbl %al,%eax
 5b2:	83 ec 08             	sub    $0x8,%esp
 5b5:	50                   	push   %eax
 5b6:	ff 75 08             	push   0x8(%ebp)
 5b9:	e8 34 fe ff ff       	call   3f2 <putc>
 5be:	83 c4 10             	add    $0x10,%esp
          s++;
 5c1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 5c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5c8:	0f b6 00             	movzbl (%eax),%eax
 5cb:	84 c0                	test   %al,%al
 5cd:	75 da                	jne    5a9 <printf+0xe3>
 5cf:	eb 65                	jmp    636 <printf+0x170>
        }
      } else if(c == 'c'){
 5d1:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5d5:	75 1d                	jne    5f4 <printf+0x12e>
        putc(fd, *ap);
 5d7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5da:	8b 00                	mov    (%eax),%eax
 5dc:	0f be c0             	movsbl %al,%eax
 5df:	83 ec 08             	sub    $0x8,%esp
 5e2:	50                   	push   %eax
 5e3:	ff 75 08             	push   0x8(%ebp)
 5e6:	e8 07 fe ff ff       	call   3f2 <putc>
 5eb:	83 c4 10             	add    $0x10,%esp
        ap++;
 5ee:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5f2:	eb 42                	jmp    636 <printf+0x170>
      } else if(c == '%'){
 5f4:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5f8:	75 17                	jne    611 <printf+0x14b>
        putc(fd, c);
 5fa:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5fd:	0f be c0             	movsbl %al,%eax
 600:	83 ec 08             	sub    $0x8,%esp
 603:	50                   	push   %eax
 604:	ff 75 08             	push   0x8(%ebp)
 607:	e8 e6 fd ff ff       	call   3f2 <putc>
 60c:	83 c4 10             	add    $0x10,%esp
 60f:	eb 25                	jmp    636 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 611:	83 ec 08             	sub    $0x8,%esp
 614:	6a 25                	push   $0x25
 616:	ff 75 08             	push   0x8(%ebp)
 619:	e8 d4 fd ff ff       	call   3f2 <putc>
 61e:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 621:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 624:	0f be c0             	movsbl %al,%eax
 627:	83 ec 08             	sub    $0x8,%esp
 62a:	50                   	push   %eax
 62b:	ff 75 08             	push   0x8(%ebp)
 62e:	e8 bf fd ff ff       	call   3f2 <putc>
 633:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 636:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 63d:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 641:	8b 55 0c             	mov    0xc(%ebp),%edx
 644:	8b 45 f0             	mov    -0x10(%ebp),%eax
 647:	01 d0                	add    %edx,%eax
 649:	0f b6 00             	movzbl (%eax),%eax
 64c:	84 c0                	test   %al,%al
 64e:	0f 85 94 fe ff ff    	jne    4e8 <printf+0x22>
    }
  }
}
 654:	90                   	nop
 655:	90                   	nop
 656:	c9                   	leave  
 657:	c3                   	ret    

00000658 <free>:
 658:	55                   	push   %ebp
 659:	89 e5                	mov    %esp,%ebp
 65b:	83 ec 10             	sub    $0x10,%esp
 65e:	8b 45 08             	mov    0x8(%ebp),%eax
 661:	83 e8 08             	sub    $0x8,%eax
 664:	89 45 f8             	mov    %eax,-0x8(%ebp)
 667:	a1 3c 0b 00 00       	mov    0xb3c,%eax
 66c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 66f:	eb 24                	jmp    695 <free+0x3d>
 671:	8b 45 fc             	mov    -0x4(%ebp),%eax
 674:	8b 00                	mov    (%eax),%eax
 676:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 679:	72 12                	jb     68d <free+0x35>
 67b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 681:	77 24                	ja     6a7 <free+0x4f>
 683:	8b 45 fc             	mov    -0x4(%ebp),%eax
 686:	8b 00                	mov    (%eax),%eax
 688:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 68b:	72 1a                	jb     6a7 <free+0x4f>
 68d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 690:	8b 00                	mov    (%eax),%eax
 692:	89 45 fc             	mov    %eax,-0x4(%ebp)
 695:	8b 45 f8             	mov    -0x8(%ebp),%eax
 698:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 69b:	76 d4                	jbe    671 <free+0x19>
 69d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a0:	8b 00                	mov    (%eax),%eax
 6a2:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 6a5:	73 ca                	jae    671 <free+0x19>
 6a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6aa:	8b 40 04             	mov    0x4(%eax),%eax
 6ad:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b7:	01 c2                	add    %eax,%edx
 6b9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bc:	8b 00                	mov    (%eax),%eax
 6be:	39 c2                	cmp    %eax,%edx
 6c0:	75 24                	jne    6e6 <free+0x8e>
 6c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c5:	8b 50 04             	mov    0x4(%eax),%edx
 6c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cb:	8b 00                	mov    (%eax),%eax
 6cd:	8b 40 04             	mov    0x4(%eax),%eax
 6d0:	01 c2                	add    %eax,%edx
 6d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d5:	89 50 04             	mov    %edx,0x4(%eax)
 6d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6db:	8b 00                	mov    (%eax),%eax
 6dd:	8b 10                	mov    (%eax),%edx
 6df:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e2:	89 10                	mov    %edx,(%eax)
 6e4:	eb 0a                	jmp    6f0 <free+0x98>
 6e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e9:	8b 10                	mov    (%eax),%edx
 6eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ee:	89 10                	mov    %edx,(%eax)
 6f0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f3:	8b 40 04             	mov    0x4(%eax),%eax
 6f6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6fd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 700:	01 d0                	add    %edx,%eax
 702:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 705:	75 20                	jne    727 <free+0xcf>
 707:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70a:	8b 50 04             	mov    0x4(%eax),%edx
 70d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 710:	8b 40 04             	mov    0x4(%eax),%eax
 713:	01 c2                	add    %eax,%edx
 715:	8b 45 fc             	mov    -0x4(%ebp),%eax
 718:	89 50 04             	mov    %edx,0x4(%eax)
 71b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71e:	8b 10                	mov    (%eax),%edx
 720:	8b 45 fc             	mov    -0x4(%ebp),%eax
 723:	89 10                	mov    %edx,(%eax)
 725:	eb 08                	jmp    72f <free+0xd7>
 727:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72a:	8b 55 f8             	mov    -0x8(%ebp),%edx
 72d:	89 10                	mov    %edx,(%eax)
 72f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 732:	a3 3c 0b 00 00       	mov    %eax,0xb3c
 737:	90                   	nop
 738:	c9                   	leave  
 739:	c3                   	ret    

0000073a <morecore>:
 73a:	55                   	push   %ebp
 73b:	89 e5                	mov    %esp,%ebp
 73d:	83 ec 18             	sub    $0x18,%esp
 740:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 747:	77 07                	ja     750 <morecore+0x16>
 749:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
 750:	8b 45 08             	mov    0x8(%ebp),%eax
 753:	c1 e0 03             	shl    $0x3,%eax
 756:	83 ec 0c             	sub    $0xc,%esp
 759:	50                   	push   %eax
 75a:	e8 6b fc ff ff       	call   3ca <sbrk>
 75f:	83 c4 10             	add    $0x10,%esp
 762:	89 45 f4             	mov    %eax,-0xc(%ebp)
 765:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 769:	75 07                	jne    772 <morecore+0x38>
 76b:	b8 00 00 00 00       	mov    $0x0,%eax
 770:	eb 26                	jmp    798 <morecore+0x5e>
 772:	8b 45 f4             	mov    -0xc(%ebp),%eax
 775:	89 45 f0             	mov    %eax,-0x10(%ebp)
 778:	8b 45 f0             	mov    -0x10(%ebp),%eax
 77b:	8b 55 08             	mov    0x8(%ebp),%edx
 77e:	89 50 04             	mov    %edx,0x4(%eax)
 781:	8b 45 f0             	mov    -0x10(%ebp),%eax
 784:	83 c0 08             	add    $0x8,%eax
 787:	83 ec 0c             	sub    $0xc,%esp
 78a:	50                   	push   %eax
 78b:	e8 c8 fe ff ff       	call   658 <free>
 790:	83 c4 10             	add    $0x10,%esp
 793:	a1 3c 0b 00 00       	mov    0xb3c,%eax
 798:	c9                   	leave  
 799:	c3                   	ret    

0000079a <malloc>:
 79a:	55                   	push   %ebp
 79b:	89 e5                	mov    %esp,%ebp
 79d:	83 ec 18             	sub    $0x18,%esp
 7a0:	8b 45 08             	mov    0x8(%ebp),%eax
 7a3:	83 c0 07             	add    $0x7,%eax
 7a6:	c1 e8 03             	shr    $0x3,%eax
 7a9:	83 c0 01             	add    $0x1,%eax
 7ac:	89 45 ec             	mov    %eax,-0x14(%ebp)
 7af:	a1 3c 0b 00 00       	mov    0xb3c,%eax
 7b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7b7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7bb:	75 23                	jne    7e0 <malloc+0x46>
 7bd:	c7 45 f0 34 0b 00 00 	movl   $0xb34,-0x10(%ebp)
 7c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c7:	a3 3c 0b 00 00       	mov    %eax,0xb3c
 7cc:	a1 3c 0b 00 00       	mov    0xb3c,%eax
 7d1:	a3 34 0b 00 00       	mov    %eax,0xb34
 7d6:	c7 05 38 0b 00 00 00 	movl   $0x0,0xb38
 7dd:	00 00 00 
 7e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e3:	8b 00                	mov    (%eax),%eax
 7e5:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7eb:	8b 40 04             	mov    0x4(%eax),%eax
 7ee:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7f1:	77 4d                	ja     840 <malloc+0xa6>
 7f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f6:	8b 40 04             	mov    0x4(%eax),%eax
 7f9:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7fc:	75 0c                	jne    80a <malloc+0x70>
 7fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 801:	8b 10                	mov    (%eax),%edx
 803:	8b 45 f0             	mov    -0x10(%ebp),%eax
 806:	89 10                	mov    %edx,(%eax)
 808:	eb 26                	jmp    830 <malloc+0x96>
 80a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80d:	8b 40 04             	mov    0x4(%eax),%eax
 810:	2b 45 ec             	sub    -0x14(%ebp),%eax
 813:	89 c2                	mov    %eax,%edx
 815:	8b 45 f4             	mov    -0xc(%ebp),%eax
 818:	89 50 04             	mov    %edx,0x4(%eax)
 81b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81e:	8b 40 04             	mov    0x4(%eax),%eax
 821:	c1 e0 03             	shl    $0x3,%eax
 824:	01 45 f4             	add    %eax,-0xc(%ebp)
 827:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82a:	8b 55 ec             	mov    -0x14(%ebp),%edx
 82d:	89 50 04             	mov    %edx,0x4(%eax)
 830:	8b 45 f0             	mov    -0x10(%ebp),%eax
 833:	a3 3c 0b 00 00       	mov    %eax,0xb3c
 838:	8b 45 f4             	mov    -0xc(%ebp),%eax
 83b:	83 c0 08             	add    $0x8,%eax
 83e:	eb 3b                	jmp    87b <malloc+0xe1>
 840:	a1 3c 0b 00 00       	mov    0xb3c,%eax
 845:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 848:	75 1e                	jne    868 <malloc+0xce>
 84a:	83 ec 0c             	sub    $0xc,%esp
 84d:	ff 75 ec             	push   -0x14(%ebp)
 850:	e8 e5 fe ff ff       	call   73a <morecore>
 855:	83 c4 10             	add    $0x10,%esp
 858:	89 45 f4             	mov    %eax,-0xc(%ebp)
 85b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 85f:	75 07                	jne    868 <malloc+0xce>
 861:	b8 00 00 00 00       	mov    $0x0,%eax
 866:	eb 13                	jmp    87b <malloc+0xe1>
 868:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86b:	89 45 f0             	mov    %eax,-0x10(%ebp)
 86e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 871:	8b 00                	mov    (%eax),%eax
 873:	89 45 f4             	mov    %eax,-0xc(%ebp)
 876:	e9 6d ff ff ff       	jmp    7e8 <malloc+0x4e>
 87b:	c9                   	leave  
 87c:	c3                   	ret    
