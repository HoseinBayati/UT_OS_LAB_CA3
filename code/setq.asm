
_setq:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"

int main(int argc, char *argv[]) 
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
  int pid = atoi(argv[1]);
  14:	8b 43 04             	mov    0x4(%ebx),%eax
  17:	83 c0 04             	add    $0x4,%eax
  1a:	8b 00                	mov    (%eax),%eax
  1c:	83 ec 0c             	sub    $0xc,%esp
  1f:	50                   	push   %eax
  20:	e8 f8 01 00 00       	call   21d <atoi>
  25:	83 c4 10             	add    $0x10,%esp
  28:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int newLevel = atoi(argv[2]);
  2b:	8b 43 04             	mov    0x4(%ebx),%eax
  2e:	83 c0 08             	add    $0x8,%eax
  31:	8b 00                	mov    (%eax),%eax
  33:	83 ec 0c             	sub    $0xc,%esp
  36:	50                   	push   %eax
  37:	e8 e1 01 00 00       	call   21d <atoi>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	89 45 f0             	mov    %eax,-0x10(%ebp)

  change_queue(pid, newLevel);
  42:	83 ec 08             	sub    $0x8,%esp
  45:	ff 75 f0             	push   -0x10(%ebp)
  48:	ff 75 f4             	push   -0xc(%ebp)
  4b:	e8 62 03 00 00       	call   3b2 <change_queue>
  50:	83 c4 10             	add    $0x10,%esp

  exit();
  53:	e8 b2 02 00 00       	call   30a <exit>

00000058 <stosb>:
  58:	55                   	push   %ebp
  59:	89 e5                	mov    %esp,%ebp
  5b:	57                   	push   %edi
  5c:	53                   	push   %ebx
  5d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  60:	8b 55 10             	mov    0x10(%ebp),%edx
  63:	8b 45 0c             	mov    0xc(%ebp),%eax
  66:	89 cb                	mov    %ecx,%ebx
  68:	89 df                	mov    %ebx,%edi
  6a:	89 d1                	mov    %edx,%ecx
  6c:	fc                   	cld    
  6d:	f3 aa                	rep stos %al,%es:(%edi)
  6f:	89 ca                	mov    %ecx,%edx
  71:	89 fb                	mov    %edi,%ebx
  73:	89 5d 08             	mov    %ebx,0x8(%ebp)
  76:	89 55 10             	mov    %edx,0x10(%ebp)
  79:	90                   	nop
  7a:	5b                   	pop    %ebx
  7b:	5f                   	pop    %edi
  7c:	5d                   	pop    %ebp
  7d:	c3                   	ret    

0000007e <strcpy>:
  7e:	55                   	push   %ebp
  7f:	89 e5                	mov    %esp,%ebp
  81:	83 ec 10             	sub    $0x10,%esp
  84:	8b 45 08             	mov    0x8(%ebp),%eax
  87:	89 45 fc             	mov    %eax,-0x4(%ebp)
  8a:	90                   	nop
  8b:	8b 55 0c             	mov    0xc(%ebp),%edx
  8e:	8d 42 01             	lea    0x1(%edx),%eax
  91:	89 45 0c             	mov    %eax,0xc(%ebp)
  94:	8b 45 08             	mov    0x8(%ebp),%eax
  97:	8d 48 01             	lea    0x1(%eax),%ecx
  9a:	89 4d 08             	mov    %ecx,0x8(%ebp)
  9d:	0f b6 12             	movzbl (%edx),%edx
  a0:	88 10                	mov    %dl,(%eax)
  a2:	0f b6 00             	movzbl (%eax),%eax
  a5:	84 c0                	test   %al,%al
  a7:	75 e2                	jne    8b <strcpy+0xd>
  a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
  ac:	c9                   	leave  
  ad:	c3                   	ret    

000000ae <strcmp>:
  ae:	55                   	push   %ebp
  af:	89 e5                	mov    %esp,%ebp
  b1:	eb 08                	jmp    bb <strcmp+0xd>
  b3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  b7:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  bb:	8b 45 08             	mov    0x8(%ebp),%eax
  be:	0f b6 00             	movzbl (%eax),%eax
  c1:	84 c0                	test   %al,%al
  c3:	74 10                	je     d5 <strcmp+0x27>
  c5:	8b 45 08             	mov    0x8(%ebp),%eax
  c8:	0f b6 10             	movzbl (%eax),%edx
  cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  ce:	0f b6 00             	movzbl (%eax),%eax
  d1:	38 c2                	cmp    %al,%dl
  d3:	74 de                	je     b3 <strcmp+0x5>
  d5:	8b 45 08             	mov    0x8(%ebp),%eax
  d8:	0f b6 00             	movzbl (%eax),%eax
  db:	0f b6 d0             	movzbl %al,%edx
  de:	8b 45 0c             	mov    0xc(%ebp),%eax
  e1:	0f b6 00             	movzbl (%eax),%eax
  e4:	0f b6 c8             	movzbl %al,%ecx
  e7:	89 d0                	mov    %edx,%eax
  e9:	29 c8                	sub    %ecx,%eax
  eb:	5d                   	pop    %ebp
  ec:	c3                   	ret    

000000ed <strlen>:
  ed:	55                   	push   %ebp
  ee:	89 e5                	mov    %esp,%ebp
  f0:	83 ec 10             	sub    $0x10,%esp
  f3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  fa:	eb 04                	jmp    100 <strlen+0x13>
  fc:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 100:	8b 55 fc             	mov    -0x4(%ebp),%edx
 103:	8b 45 08             	mov    0x8(%ebp),%eax
 106:	01 d0                	add    %edx,%eax
 108:	0f b6 00             	movzbl (%eax),%eax
 10b:	84 c0                	test   %al,%al
 10d:	75 ed                	jne    fc <strlen+0xf>
 10f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 112:	c9                   	leave  
 113:	c3                   	ret    

00000114 <memset>:
 114:	55                   	push   %ebp
 115:	89 e5                	mov    %esp,%ebp
 117:	8b 45 10             	mov    0x10(%ebp),%eax
 11a:	50                   	push   %eax
 11b:	ff 75 0c             	push   0xc(%ebp)
 11e:	ff 75 08             	push   0x8(%ebp)
 121:	e8 32 ff ff ff       	call   58 <stosb>
 126:	83 c4 0c             	add    $0xc,%esp
 129:	8b 45 08             	mov    0x8(%ebp),%eax
 12c:	c9                   	leave  
 12d:	c3                   	ret    

0000012e <strchr>:
 12e:	55                   	push   %ebp
 12f:	89 e5                	mov    %esp,%ebp
 131:	83 ec 04             	sub    $0x4,%esp
 134:	8b 45 0c             	mov    0xc(%ebp),%eax
 137:	88 45 fc             	mov    %al,-0x4(%ebp)
 13a:	eb 14                	jmp    150 <strchr+0x22>
 13c:	8b 45 08             	mov    0x8(%ebp),%eax
 13f:	0f b6 00             	movzbl (%eax),%eax
 142:	38 45 fc             	cmp    %al,-0x4(%ebp)
 145:	75 05                	jne    14c <strchr+0x1e>
 147:	8b 45 08             	mov    0x8(%ebp),%eax
 14a:	eb 13                	jmp    15f <strchr+0x31>
 14c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 150:	8b 45 08             	mov    0x8(%ebp),%eax
 153:	0f b6 00             	movzbl (%eax),%eax
 156:	84 c0                	test   %al,%al
 158:	75 e2                	jne    13c <strchr+0xe>
 15a:	b8 00 00 00 00       	mov    $0x0,%eax
 15f:	c9                   	leave  
 160:	c3                   	ret    

00000161 <gets>:
 161:	55                   	push   %ebp
 162:	89 e5                	mov    %esp,%ebp
 164:	83 ec 18             	sub    $0x18,%esp
 167:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 16e:	eb 42                	jmp    1b2 <gets+0x51>
 170:	83 ec 04             	sub    $0x4,%esp
 173:	6a 01                	push   $0x1
 175:	8d 45 ef             	lea    -0x11(%ebp),%eax
 178:	50                   	push   %eax
 179:	6a 00                	push   $0x0
 17b:	e8 a2 01 00 00       	call   322 <read>
 180:	83 c4 10             	add    $0x10,%esp
 183:	89 45 f0             	mov    %eax,-0x10(%ebp)
 186:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 18a:	7e 33                	jle    1bf <gets+0x5e>
 18c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 18f:	8d 50 01             	lea    0x1(%eax),%edx
 192:	89 55 f4             	mov    %edx,-0xc(%ebp)
 195:	89 c2                	mov    %eax,%edx
 197:	8b 45 08             	mov    0x8(%ebp),%eax
 19a:	01 c2                	add    %eax,%edx
 19c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1a0:	88 02                	mov    %al,(%edx)
 1a2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1a6:	3c 0a                	cmp    $0xa,%al
 1a8:	74 16                	je     1c0 <gets+0x5f>
 1aa:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1ae:	3c 0d                	cmp    $0xd,%al
 1b0:	74 0e                	je     1c0 <gets+0x5f>
 1b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b5:	83 c0 01             	add    $0x1,%eax
 1b8:	39 45 0c             	cmp    %eax,0xc(%ebp)
 1bb:	7f b3                	jg     170 <gets+0xf>
 1bd:	eb 01                	jmp    1c0 <gets+0x5f>
 1bf:	90                   	nop
 1c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1c3:	8b 45 08             	mov    0x8(%ebp),%eax
 1c6:	01 d0                	add    %edx,%eax
 1c8:	c6 00 00             	movb   $0x0,(%eax)
 1cb:	8b 45 08             	mov    0x8(%ebp),%eax
 1ce:	c9                   	leave  
 1cf:	c3                   	ret    

000001d0 <stat>:
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	83 ec 18             	sub    $0x18,%esp
 1d6:	83 ec 08             	sub    $0x8,%esp
 1d9:	6a 00                	push   $0x0
 1db:	ff 75 08             	push   0x8(%ebp)
 1de:	e8 67 01 00 00       	call   34a <open>
 1e3:	83 c4 10             	add    $0x10,%esp
 1e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
 1e9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1ed:	79 07                	jns    1f6 <stat+0x26>
 1ef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1f4:	eb 25                	jmp    21b <stat+0x4b>
 1f6:	83 ec 08             	sub    $0x8,%esp
 1f9:	ff 75 0c             	push   0xc(%ebp)
 1fc:	ff 75 f4             	push   -0xc(%ebp)
 1ff:	e8 5e 01 00 00       	call   362 <fstat>
 204:	83 c4 10             	add    $0x10,%esp
 207:	89 45 f0             	mov    %eax,-0x10(%ebp)
 20a:	83 ec 0c             	sub    $0xc,%esp
 20d:	ff 75 f4             	push   -0xc(%ebp)
 210:	e8 1d 01 00 00       	call   332 <close>
 215:	83 c4 10             	add    $0x10,%esp
 218:	8b 45 f0             	mov    -0x10(%ebp),%eax
 21b:	c9                   	leave  
 21c:	c3                   	ret    

0000021d <atoi>:
 21d:	55                   	push   %ebp
 21e:	89 e5                	mov    %esp,%ebp
 220:	83 ec 10             	sub    $0x10,%esp
 223:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 22a:	eb 25                	jmp    251 <atoi+0x34>
 22c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 22f:	89 d0                	mov    %edx,%eax
 231:	c1 e0 02             	shl    $0x2,%eax
 234:	01 d0                	add    %edx,%eax
 236:	01 c0                	add    %eax,%eax
 238:	89 c1                	mov    %eax,%ecx
 23a:	8b 45 08             	mov    0x8(%ebp),%eax
 23d:	8d 50 01             	lea    0x1(%eax),%edx
 240:	89 55 08             	mov    %edx,0x8(%ebp)
 243:	0f b6 00             	movzbl (%eax),%eax
 246:	0f be c0             	movsbl %al,%eax
 249:	01 c8                	add    %ecx,%eax
 24b:	83 e8 30             	sub    $0x30,%eax
 24e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 251:	8b 45 08             	mov    0x8(%ebp),%eax
 254:	0f b6 00             	movzbl (%eax),%eax
 257:	3c 2f                	cmp    $0x2f,%al
 259:	7e 0a                	jle    265 <atoi+0x48>
 25b:	8b 45 08             	mov    0x8(%ebp),%eax
 25e:	0f b6 00             	movzbl (%eax),%eax
 261:	3c 39                	cmp    $0x39,%al
 263:	7e c7                	jle    22c <atoi+0xf>
 265:	8b 45 fc             	mov    -0x4(%ebp),%eax
 268:	c9                   	leave  
 269:	c3                   	ret    

0000026a <memmove>:
 26a:	55                   	push   %ebp
 26b:	89 e5                	mov    %esp,%ebp
 26d:	83 ec 10             	sub    $0x10,%esp
 270:	8b 45 08             	mov    0x8(%ebp),%eax
 273:	89 45 fc             	mov    %eax,-0x4(%ebp)
 276:	8b 45 0c             	mov    0xc(%ebp),%eax
 279:	89 45 f8             	mov    %eax,-0x8(%ebp)
 27c:	eb 17                	jmp    295 <memmove+0x2b>
 27e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 281:	8d 42 01             	lea    0x1(%edx),%eax
 284:	89 45 f8             	mov    %eax,-0x8(%ebp)
 287:	8b 45 fc             	mov    -0x4(%ebp),%eax
 28a:	8d 48 01             	lea    0x1(%eax),%ecx
 28d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 290:	0f b6 12             	movzbl (%edx),%edx
 293:	88 10                	mov    %dl,(%eax)
 295:	8b 45 10             	mov    0x10(%ebp),%eax
 298:	8d 50 ff             	lea    -0x1(%eax),%edx
 29b:	89 55 10             	mov    %edx,0x10(%ebp)
 29e:	85 c0                	test   %eax,%eax
 2a0:	7f dc                	jg     27e <memmove+0x14>
 2a2:	8b 45 08             	mov    0x8(%ebp),%eax
 2a5:	c9                   	leave  
 2a6:	c3                   	ret    

000002a7 <calc>:
 2a7:	55                   	push   %ebp
 2a8:	89 e5                	mov    %esp,%ebp
 2aa:	83 ec 10             	sub    $0x10,%esp
 2ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 2b4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
 2bb:	eb 36                	jmp    2f3 <calc+0x4c>
 2bd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2c4:	eb 21                	jmp    2e7 <calc+0x40>
 2c6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 2cd:	eb 0c                	jmp    2db <calc+0x34>
 2cf:	c1 7d fc 0a          	sarl   $0xa,-0x4(%ebp)
 2d3:	c1 65 fc 0a          	shll   $0xa,-0x4(%ebp)
 2d7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 2db:	8b 45 08             	mov    0x8(%ebp),%eax
 2de:	39 45 f0             	cmp    %eax,-0x10(%ebp)
 2e1:	72 ec                	jb     2cf <calc+0x28>
 2e3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 2e7:	8b 45 08             	mov    0x8(%ebp),%eax
 2ea:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 2ed:	72 d7                	jb     2c6 <calc+0x1f>
 2ef:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 2f3:	8b 45 08             	mov    0x8(%ebp),%eax
 2f6:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 2f9:	72 c2                	jb     2bd <calc+0x16>
 2fb:	b8 00 00 00 00       	mov    $0x0,%eax
 300:	c9                   	leave  
 301:	c3                   	ret    

00000302 <fork>:
 302:	b8 01 00 00 00       	mov    $0x1,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <exit>:
 30a:	b8 02 00 00 00       	mov    $0x2,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <wait>:
 312:	b8 03 00 00 00       	mov    $0x3,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <pipe>:
 31a:	b8 04 00 00 00       	mov    $0x4,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <read>:
 322:	b8 05 00 00 00       	mov    $0x5,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <write>:
 32a:	b8 10 00 00 00       	mov    $0x10,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <close>:
 332:	b8 15 00 00 00       	mov    $0x15,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <kill>:
 33a:	b8 06 00 00 00       	mov    $0x6,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <exec>:
 342:	b8 07 00 00 00       	mov    $0x7,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <open>:
 34a:	b8 0f 00 00 00       	mov    $0xf,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <mknod>:
 352:	b8 11 00 00 00       	mov    $0x11,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <unlink>:
 35a:	b8 12 00 00 00       	mov    $0x12,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <fstat>:
 362:	b8 08 00 00 00       	mov    $0x8,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <link>:
 36a:	b8 13 00 00 00       	mov    $0x13,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <mkdir>:
 372:	b8 14 00 00 00       	mov    $0x14,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <chdir>:
 37a:	b8 09 00 00 00       	mov    $0x9,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <dup>:
 382:	b8 0a 00 00 00       	mov    $0xa,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <getpid>:
 38a:	b8 0b 00 00 00       	mov    $0xb,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <sbrk>:
 392:	b8 0c 00 00 00       	mov    $0xc,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <sleep>:
 39a:	b8 0d 00 00 00       	mov    $0xd,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <uptime>:
 3a2:	b8 0e 00 00 00       	mov    $0xe,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <print_proc>:
 3aa:	b8 16 00 00 00       	mov    $0x16,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <change_queue>:
 3b2:	b8 17 00 00 00       	mov    $0x17,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3ba:	55                   	push   %ebp
 3bb:	89 e5                	mov    %esp,%ebp
 3bd:	83 ec 18             	sub    $0x18,%esp
 3c0:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c3:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3c6:	83 ec 04             	sub    $0x4,%esp
 3c9:	6a 01                	push   $0x1
 3cb:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3ce:	50                   	push   %eax
 3cf:	ff 75 08             	push   0x8(%ebp)
 3d2:	e8 53 ff ff ff       	call   32a <write>
 3d7:	83 c4 10             	add    $0x10,%esp
}
 3da:	90                   	nop
 3db:	c9                   	leave  
 3dc:	c3                   	ret    

000003dd <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3dd:	55                   	push   %ebp
 3de:	89 e5                	mov    %esp,%ebp
 3e0:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3e3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3ea:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3ee:	74 17                	je     407 <printint+0x2a>
 3f0:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3f4:	79 11                	jns    407 <printint+0x2a>
    neg = 1;
 3f6:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3fd:	8b 45 0c             	mov    0xc(%ebp),%eax
 400:	f7 d8                	neg    %eax
 402:	89 45 ec             	mov    %eax,-0x14(%ebp)
 405:	eb 06                	jmp    40d <printint+0x30>
  } else {
    x = xx;
 407:	8b 45 0c             	mov    0xc(%ebp),%eax
 40a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 40d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 414:	8b 4d 10             	mov    0x10(%ebp),%ecx
 417:	8b 45 ec             	mov    -0x14(%ebp),%eax
 41a:	ba 00 00 00 00       	mov    $0x0,%edx
 41f:	f7 f1                	div    %ecx
 421:	89 d1                	mov    %edx,%ecx
 423:	8b 45 f4             	mov    -0xc(%ebp),%eax
 426:	8d 50 01             	lea    0x1(%eax),%edx
 429:	89 55 f4             	mov    %edx,-0xc(%ebp)
 42c:	0f b6 91 b4 0a 00 00 	movzbl 0xab4(%ecx),%edx
 433:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 437:	8b 4d 10             	mov    0x10(%ebp),%ecx
 43a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 43d:	ba 00 00 00 00       	mov    $0x0,%edx
 442:	f7 f1                	div    %ecx
 444:	89 45 ec             	mov    %eax,-0x14(%ebp)
 447:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 44b:	75 c7                	jne    414 <printint+0x37>
  if(neg)
 44d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 451:	74 2d                	je     480 <printint+0xa3>
    buf[i++] = '-';
 453:	8b 45 f4             	mov    -0xc(%ebp),%eax
 456:	8d 50 01             	lea    0x1(%eax),%edx
 459:	89 55 f4             	mov    %edx,-0xc(%ebp)
 45c:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 461:	eb 1d                	jmp    480 <printint+0xa3>
    putc(fd, buf[i]);
 463:	8d 55 dc             	lea    -0x24(%ebp),%edx
 466:	8b 45 f4             	mov    -0xc(%ebp),%eax
 469:	01 d0                	add    %edx,%eax
 46b:	0f b6 00             	movzbl (%eax),%eax
 46e:	0f be c0             	movsbl %al,%eax
 471:	83 ec 08             	sub    $0x8,%esp
 474:	50                   	push   %eax
 475:	ff 75 08             	push   0x8(%ebp)
 478:	e8 3d ff ff ff       	call   3ba <putc>
 47d:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 480:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 484:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 488:	79 d9                	jns    463 <printint+0x86>
}
 48a:	90                   	nop
 48b:	90                   	nop
 48c:	c9                   	leave  
 48d:	c3                   	ret    

0000048e <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 48e:	55                   	push   %ebp
 48f:	89 e5                	mov    %esp,%ebp
 491:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 494:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 49b:	8d 45 0c             	lea    0xc(%ebp),%eax
 49e:	83 c0 04             	add    $0x4,%eax
 4a1:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4a4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4ab:	e9 59 01 00 00       	jmp    609 <printf+0x17b>
    c = fmt[i] & 0xff;
 4b0:	8b 55 0c             	mov    0xc(%ebp),%edx
 4b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4b6:	01 d0                	add    %edx,%eax
 4b8:	0f b6 00             	movzbl (%eax),%eax
 4bb:	0f be c0             	movsbl %al,%eax
 4be:	25 ff 00 00 00       	and    $0xff,%eax
 4c3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4c6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4ca:	75 2c                	jne    4f8 <printf+0x6a>
      if(c == '%'){
 4cc:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4d0:	75 0c                	jne    4de <printf+0x50>
        state = '%';
 4d2:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4d9:	e9 27 01 00 00       	jmp    605 <printf+0x177>
      } else {
        putc(fd, c);
 4de:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4e1:	0f be c0             	movsbl %al,%eax
 4e4:	83 ec 08             	sub    $0x8,%esp
 4e7:	50                   	push   %eax
 4e8:	ff 75 08             	push   0x8(%ebp)
 4eb:	e8 ca fe ff ff       	call   3ba <putc>
 4f0:	83 c4 10             	add    $0x10,%esp
 4f3:	e9 0d 01 00 00       	jmp    605 <printf+0x177>
      }
    } else if(state == '%'){
 4f8:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4fc:	0f 85 03 01 00 00    	jne    605 <printf+0x177>
      if(c == 'd'){
 502:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 506:	75 1e                	jne    526 <printf+0x98>
        printint(fd, *ap, 10, 1);
 508:	8b 45 e8             	mov    -0x18(%ebp),%eax
 50b:	8b 00                	mov    (%eax),%eax
 50d:	6a 01                	push   $0x1
 50f:	6a 0a                	push   $0xa
 511:	50                   	push   %eax
 512:	ff 75 08             	push   0x8(%ebp)
 515:	e8 c3 fe ff ff       	call   3dd <printint>
 51a:	83 c4 10             	add    $0x10,%esp
        ap++;
 51d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 521:	e9 d8 00 00 00       	jmp    5fe <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 526:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 52a:	74 06                	je     532 <printf+0xa4>
 52c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 530:	75 1e                	jne    550 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 532:	8b 45 e8             	mov    -0x18(%ebp),%eax
 535:	8b 00                	mov    (%eax),%eax
 537:	6a 00                	push   $0x0
 539:	6a 10                	push   $0x10
 53b:	50                   	push   %eax
 53c:	ff 75 08             	push   0x8(%ebp)
 53f:	e8 99 fe ff ff       	call   3dd <printint>
 544:	83 c4 10             	add    $0x10,%esp
        ap++;
 547:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 54b:	e9 ae 00 00 00       	jmp    5fe <printf+0x170>
      } else if(c == 's'){
 550:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 554:	75 43                	jne    599 <printf+0x10b>
        s = (char*)*ap;
 556:	8b 45 e8             	mov    -0x18(%ebp),%eax
 559:	8b 00                	mov    (%eax),%eax
 55b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 55e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 562:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 566:	75 25                	jne    58d <printf+0xff>
          s = "(null)";
 568:	c7 45 f4 45 08 00 00 	movl   $0x845,-0xc(%ebp)
        while(*s != 0){
 56f:	eb 1c                	jmp    58d <printf+0xff>
          putc(fd, *s);
 571:	8b 45 f4             	mov    -0xc(%ebp),%eax
 574:	0f b6 00             	movzbl (%eax),%eax
 577:	0f be c0             	movsbl %al,%eax
 57a:	83 ec 08             	sub    $0x8,%esp
 57d:	50                   	push   %eax
 57e:	ff 75 08             	push   0x8(%ebp)
 581:	e8 34 fe ff ff       	call   3ba <putc>
 586:	83 c4 10             	add    $0x10,%esp
          s++;
 589:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 58d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 590:	0f b6 00             	movzbl (%eax),%eax
 593:	84 c0                	test   %al,%al
 595:	75 da                	jne    571 <printf+0xe3>
 597:	eb 65                	jmp    5fe <printf+0x170>
        }
      } else if(c == 'c'){
 599:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 59d:	75 1d                	jne    5bc <printf+0x12e>
        putc(fd, *ap);
 59f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5a2:	8b 00                	mov    (%eax),%eax
 5a4:	0f be c0             	movsbl %al,%eax
 5a7:	83 ec 08             	sub    $0x8,%esp
 5aa:	50                   	push   %eax
 5ab:	ff 75 08             	push   0x8(%ebp)
 5ae:	e8 07 fe ff ff       	call   3ba <putc>
 5b3:	83 c4 10             	add    $0x10,%esp
        ap++;
 5b6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5ba:	eb 42                	jmp    5fe <printf+0x170>
      } else if(c == '%'){
 5bc:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5c0:	75 17                	jne    5d9 <printf+0x14b>
        putc(fd, c);
 5c2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5c5:	0f be c0             	movsbl %al,%eax
 5c8:	83 ec 08             	sub    $0x8,%esp
 5cb:	50                   	push   %eax
 5cc:	ff 75 08             	push   0x8(%ebp)
 5cf:	e8 e6 fd ff ff       	call   3ba <putc>
 5d4:	83 c4 10             	add    $0x10,%esp
 5d7:	eb 25                	jmp    5fe <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5d9:	83 ec 08             	sub    $0x8,%esp
 5dc:	6a 25                	push   $0x25
 5de:	ff 75 08             	push   0x8(%ebp)
 5e1:	e8 d4 fd ff ff       	call   3ba <putc>
 5e6:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5e9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5ec:	0f be c0             	movsbl %al,%eax
 5ef:	83 ec 08             	sub    $0x8,%esp
 5f2:	50                   	push   %eax
 5f3:	ff 75 08             	push   0x8(%ebp)
 5f6:	e8 bf fd ff ff       	call   3ba <putc>
 5fb:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5fe:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 605:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 609:	8b 55 0c             	mov    0xc(%ebp),%edx
 60c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 60f:	01 d0                	add    %edx,%eax
 611:	0f b6 00             	movzbl (%eax),%eax
 614:	84 c0                	test   %al,%al
 616:	0f 85 94 fe ff ff    	jne    4b0 <printf+0x22>
    }
  }
}
 61c:	90                   	nop
 61d:	90                   	nop
 61e:	c9                   	leave  
 61f:	c3                   	ret    

00000620 <free>:
 620:	55                   	push   %ebp
 621:	89 e5                	mov    %esp,%ebp
 623:	83 ec 10             	sub    $0x10,%esp
 626:	8b 45 08             	mov    0x8(%ebp),%eax
 629:	83 e8 08             	sub    $0x8,%eax
 62c:	89 45 f8             	mov    %eax,-0x8(%ebp)
 62f:	a1 d0 0a 00 00       	mov    0xad0,%eax
 634:	89 45 fc             	mov    %eax,-0x4(%ebp)
 637:	eb 24                	jmp    65d <free+0x3d>
 639:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63c:	8b 00                	mov    (%eax),%eax
 63e:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 641:	72 12                	jb     655 <free+0x35>
 643:	8b 45 f8             	mov    -0x8(%ebp),%eax
 646:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 649:	77 24                	ja     66f <free+0x4f>
 64b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64e:	8b 00                	mov    (%eax),%eax
 650:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 653:	72 1a                	jb     66f <free+0x4f>
 655:	8b 45 fc             	mov    -0x4(%ebp),%eax
 658:	8b 00                	mov    (%eax),%eax
 65a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 65d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 660:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 663:	76 d4                	jbe    639 <free+0x19>
 665:	8b 45 fc             	mov    -0x4(%ebp),%eax
 668:	8b 00                	mov    (%eax),%eax
 66a:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 66d:	73 ca                	jae    639 <free+0x19>
 66f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 672:	8b 40 04             	mov    0x4(%eax),%eax
 675:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 67c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67f:	01 c2                	add    %eax,%edx
 681:	8b 45 fc             	mov    -0x4(%ebp),%eax
 684:	8b 00                	mov    (%eax),%eax
 686:	39 c2                	cmp    %eax,%edx
 688:	75 24                	jne    6ae <free+0x8e>
 68a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68d:	8b 50 04             	mov    0x4(%eax),%edx
 690:	8b 45 fc             	mov    -0x4(%ebp),%eax
 693:	8b 00                	mov    (%eax),%eax
 695:	8b 40 04             	mov    0x4(%eax),%eax
 698:	01 c2                	add    %eax,%edx
 69a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69d:	89 50 04             	mov    %edx,0x4(%eax)
 6a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a3:	8b 00                	mov    (%eax),%eax
 6a5:	8b 10                	mov    (%eax),%edx
 6a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6aa:	89 10                	mov    %edx,(%eax)
 6ac:	eb 0a                	jmp    6b8 <free+0x98>
 6ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b1:	8b 10                	mov    (%eax),%edx
 6b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b6:	89 10                	mov    %edx,(%eax)
 6b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bb:	8b 40 04             	mov    0x4(%eax),%eax
 6be:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c8:	01 d0                	add    %edx,%eax
 6ca:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 6cd:	75 20                	jne    6ef <free+0xcf>
 6cf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d2:	8b 50 04             	mov    0x4(%eax),%edx
 6d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d8:	8b 40 04             	mov    0x4(%eax),%eax
 6db:	01 c2                	add    %eax,%edx
 6dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e0:	89 50 04             	mov    %edx,0x4(%eax)
 6e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e6:	8b 10                	mov    (%eax),%edx
 6e8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6eb:	89 10                	mov    %edx,(%eax)
 6ed:	eb 08                	jmp    6f7 <free+0xd7>
 6ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f2:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6f5:	89 10                	mov    %edx,(%eax)
 6f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fa:	a3 d0 0a 00 00       	mov    %eax,0xad0
 6ff:	90                   	nop
 700:	c9                   	leave  
 701:	c3                   	ret    

00000702 <morecore>:
 702:	55                   	push   %ebp
 703:	89 e5                	mov    %esp,%ebp
 705:	83 ec 18             	sub    $0x18,%esp
 708:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 70f:	77 07                	ja     718 <morecore+0x16>
 711:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
 718:	8b 45 08             	mov    0x8(%ebp),%eax
 71b:	c1 e0 03             	shl    $0x3,%eax
 71e:	83 ec 0c             	sub    $0xc,%esp
 721:	50                   	push   %eax
 722:	e8 6b fc ff ff       	call   392 <sbrk>
 727:	83 c4 10             	add    $0x10,%esp
 72a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 72d:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 731:	75 07                	jne    73a <morecore+0x38>
 733:	b8 00 00 00 00       	mov    $0x0,%eax
 738:	eb 26                	jmp    760 <morecore+0x5e>
 73a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 73d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 740:	8b 45 f0             	mov    -0x10(%ebp),%eax
 743:	8b 55 08             	mov    0x8(%ebp),%edx
 746:	89 50 04             	mov    %edx,0x4(%eax)
 749:	8b 45 f0             	mov    -0x10(%ebp),%eax
 74c:	83 c0 08             	add    $0x8,%eax
 74f:	83 ec 0c             	sub    $0xc,%esp
 752:	50                   	push   %eax
 753:	e8 c8 fe ff ff       	call   620 <free>
 758:	83 c4 10             	add    $0x10,%esp
 75b:	a1 d0 0a 00 00       	mov    0xad0,%eax
 760:	c9                   	leave  
 761:	c3                   	ret    

00000762 <malloc>:
 762:	55                   	push   %ebp
 763:	89 e5                	mov    %esp,%ebp
 765:	83 ec 18             	sub    $0x18,%esp
 768:	8b 45 08             	mov    0x8(%ebp),%eax
 76b:	83 c0 07             	add    $0x7,%eax
 76e:	c1 e8 03             	shr    $0x3,%eax
 771:	83 c0 01             	add    $0x1,%eax
 774:	89 45 ec             	mov    %eax,-0x14(%ebp)
 777:	a1 d0 0a 00 00       	mov    0xad0,%eax
 77c:	89 45 f0             	mov    %eax,-0x10(%ebp)
 77f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 783:	75 23                	jne    7a8 <malloc+0x46>
 785:	c7 45 f0 c8 0a 00 00 	movl   $0xac8,-0x10(%ebp)
 78c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 78f:	a3 d0 0a 00 00       	mov    %eax,0xad0
 794:	a1 d0 0a 00 00       	mov    0xad0,%eax
 799:	a3 c8 0a 00 00       	mov    %eax,0xac8
 79e:	c7 05 cc 0a 00 00 00 	movl   $0x0,0xacc
 7a5:	00 00 00 
 7a8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ab:	8b 00                	mov    (%eax),%eax
 7ad:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b3:	8b 40 04             	mov    0x4(%eax),%eax
 7b6:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7b9:	77 4d                	ja     808 <malloc+0xa6>
 7bb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7be:	8b 40 04             	mov    0x4(%eax),%eax
 7c1:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7c4:	75 0c                	jne    7d2 <malloc+0x70>
 7c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c9:	8b 10                	mov    (%eax),%edx
 7cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ce:	89 10                	mov    %edx,(%eax)
 7d0:	eb 26                	jmp    7f8 <malloc+0x96>
 7d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d5:	8b 40 04             	mov    0x4(%eax),%eax
 7d8:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7db:	89 c2                	mov    %eax,%edx
 7dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e0:	89 50 04             	mov    %edx,0x4(%eax)
 7e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e6:	8b 40 04             	mov    0x4(%eax),%eax
 7e9:	c1 e0 03             	shl    $0x3,%eax
 7ec:	01 45 f4             	add    %eax,-0xc(%ebp)
 7ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f2:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7f5:	89 50 04             	mov    %edx,0x4(%eax)
 7f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7fb:	a3 d0 0a 00 00       	mov    %eax,0xad0
 800:	8b 45 f4             	mov    -0xc(%ebp),%eax
 803:	83 c0 08             	add    $0x8,%eax
 806:	eb 3b                	jmp    843 <malloc+0xe1>
 808:	a1 d0 0a 00 00       	mov    0xad0,%eax
 80d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 810:	75 1e                	jne    830 <malloc+0xce>
 812:	83 ec 0c             	sub    $0xc,%esp
 815:	ff 75 ec             	push   -0x14(%ebp)
 818:	e8 e5 fe ff ff       	call   702 <morecore>
 81d:	83 c4 10             	add    $0x10,%esp
 820:	89 45 f4             	mov    %eax,-0xc(%ebp)
 823:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 827:	75 07                	jne    830 <malloc+0xce>
 829:	b8 00 00 00 00       	mov    $0x0,%eax
 82e:	eb 13                	jmp    843 <malloc+0xe1>
 830:	8b 45 f4             	mov    -0xc(%ebp),%eax
 833:	89 45 f0             	mov    %eax,-0x10(%ebp)
 836:	8b 45 f4             	mov    -0xc(%ebp),%eax
 839:	8b 00                	mov    (%eax),%eax
 83b:	89 45 f4             	mov    %eax,-0xc(%ebp)
 83e:	e9 6d ff ff ff       	jmp    7b0 <malloc+0x4e>
 843:	c9                   	leave  
 844:	c3                   	ret    
