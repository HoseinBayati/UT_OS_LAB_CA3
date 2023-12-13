
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
   6:	eb 31                	jmp    39 <cat+0x39>
    if (write(1, buf, n) != n) {
   8:	83 ec 04             	sub    $0x4,%esp
   b:	ff 75 f4             	push   -0xc(%ebp)
   e:	68 00 0c 00 00       	push   $0xc00
  13:	6a 01                	push   $0x1
  15:	e8 e3 03 00 00       	call   3fd <write>
  1a:	83 c4 10             	add    $0x10,%esp
  1d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  20:	74 17                	je     39 <cat+0x39>
      printf(1, "cat: write error\n");
  22:	83 ec 08             	sub    $0x8,%esp
  25:	68 18 09 00 00       	push   $0x918
  2a:	6a 01                	push   $0x1
  2c:	e8 30 05 00 00       	call   561 <printf>
  31:	83 c4 10             	add    $0x10,%esp
      exit();
  34:	e8 a4 03 00 00       	call   3dd <exit>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  39:	83 ec 04             	sub    $0x4,%esp
  3c:	68 00 02 00 00       	push   $0x200
  41:	68 00 0c 00 00       	push   $0xc00
  46:	ff 75 08             	push   0x8(%ebp)
  49:	e8 a7 03 00 00       	call   3f5 <read>
  4e:	83 c4 10             	add    $0x10,%esp
  51:	89 45 f4             	mov    %eax,-0xc(%ebp)
  54:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  58:	7f ae                	jg     8 <cat+0x8>
    }
  }
  if(n < 0){
  5a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  5e:	79 17                	jns    77 <cat+0x77>
    printf(1, "cat: read error\n");
  60:	83 ec 08             	sub    $0x8,%esp
  63:	68 2a 09 00 00       	push   $0x92a
  68:	6a 01                	push   $0x1
  6a:	e8 f2 04 00 00       	call   561 <printf>
  6f:	83 c4 10             	add    $0x10,%esp
    exit();
  72:	e8 66 03 00 00       	call   3dd <exit>
  }
}
  77:	90                   	nop
  78:	c9                   	leave  
  79:	c3                   	ret    

0000007a <main>:

int
main(int argc, char *argv[])
{
  7a:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  7e:	83 e4 f0             	and    $0xfffffff0,%esp
  81:	ff 71 fc             	push   -0x4(%ecx)
  84:	55                   	push   %ebp
  85:	89 e5                	mov    %esp,%ebp
  87:	53                   	push   %ebx
  88:	51                   	push   %ecx
  89:	83 ec 10             	sub    $0x10,%esp
  8c:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
  8e:	83 3b 01             	cmpl   $0x1,(%ebx)
  91:	7f 12                	jg     a5 <main+0x2b>
    cat(0);
  93:	83 ec 0c             	sub    $0xc,%esp
  96:	6a 00                	push   $0x0
  98:	e8 63 ff ff ff       	call   0 <cat>
  9d:	83 c4 10             	add    $0x10,%esp
    exit();
  a0:	e8 38 03 00 00       	call   3dd <exit>
  }

  for(i = 1; i < argc; i++){
  a5:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  ac:	eb 71                	jmp    11f <main+0xa5>
    if((fd = open(argv[i], 0)) < 0){
  ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  b1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  b8:	8b 43 04             	mov    0x4(%ebx),%eax
  bb:	01 d0                	add    %edx,%eax
  bd:	8b 00                	mov    (%eax),%eax
  bf:	83 ec 08             	sub    $0x8,%esp
  c2:	6a 00                	push   $0x0
  c4:	50                   	push   %eax
  c5:	e8 53 03 00 00       	call   41d <open>
  ca:	83 c4 10             	add    $0x10,%esp
  cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  d0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  d4:	79 29                	jns    ff <main+0x85>
      printf(1, "cat: cannot open %s\n", argv[i]);
  d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  d9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  e0:	8b 43 04             	mov    0x4(%ebx),%eax
  e3:	01 d0                	add    %edx,%eax
  e5:	8b 00                	mov    (%eax),%eax
  e7:	83 ec 04             	sub    $0x4,%esp
  ea:	50                   	push   %eax
  eb:	68 3b 09 00 00       	push   $0x93b
  f0:	6a 01                	push   $0x1
  f2:	e8 6a 04 00 00       	call   561 <printf>
  f7:	83 c4 10             	add    $0x10,%esp
      exit();
  fa:	e8 de 02 00 00       	call   3dd <exit>
    }
    cat(fd);
  ff:	83 ec 0c             	sub    $0xc,%esp
 102:	ff 75 f0             	push   -0x10(%ebp)
 105:	e8 f6 fe ff ff       	call   0 <cat>
 10a:	83 c4 10             	add    $0x10,%esp
    close(fd);
 10d:	83 ec 0c             	sub    $0xc,%esp
 110:	ff 75 f0             	push   -0x10(%ebp)
 113:	e8 ed 02 00 00       	call   405 <close>
 118:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i < argc; i++){
 11b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 11f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 122:	3b 03                	cmp    (%ebx),%eax
 124:	7c 88                	jl     ae <main+0x34>
  }
  exit();
 126:	e8 b2 02 00 00       	call   3dd <exit>

0000012b <stosb>:
 12b:	55                   	push   %ebp
 12c:	89 e5                	mov    %esp,%ebp
 12e:	57                   	push   %edi
 12f:	53                   	push   %ebx
 130:	8b 4d 08             	mov    0x8(%ebp),%ecx
 133:	8b 55 10             	mov    0x10(%ebp),%edx
 136:	8b 45 0c             	mov    0xc(%ebp),%eax
 139:	89 cb                	mov    %ecx,%ebx
 13b:	89 df                	mov    %ebx,%edi
 13d:	89 d1                	mov    %edx,%ecx
 13f:	fc                   	cld    
 140:	f3 aa                	rep stos %al,%es:(%edi)
 142:	89 ca                	mov    %ecx,%edx
 144:	89 fb                	mov    %edi,%ebx
 146:	89 5d 08             	mov    %ebx,0x8(%ebp)
 149:	89 55 10             	mov    %edx,0x10(%ebp)
 14c:	90                   	nop
 14d:	5b                   	pop    %ebx
 14e:	5f                   	pop    %edi
 14f:	5d                   	pop    %ebp
 150:	c3                   	ret    

00000151 <strcpy>:
 151:	55                   	push   %ebp
 152:	89 e5                	mov    %esp,%ebp
 154:	83 ec 10             	sub    $0x10,%esp
 157:	8b 45 08             	mov    0x8(%ebp),%eax
 15a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 15d:	90                   	nop
 15e:	8b 55 0c             	mov    0xc(%ebp),%edx
 161:	8d 42 01             	lea    0x1(%edx),%eax
 164:	89 45 0c             	mov    %eax,0xc(%ebp)
 167:	8b 45 08             	mov    0x8(%ebp),%eax
 16a:	8d 48 01             	lea    0x1(%eax),%ecx
 16d:	89 4d 08             	mov    %ecx,0x8(%ebp)
 170:	0f b6 12             	movzbl (%edx),%edx
 173:	88 10                	mov    %dl,(%eax)
 175:	0f b6 00             	movzbl (%eax),%eax
 178:	84 c0                	test   %al,%al
 17a:	75 e2                	jne    15e <strcpy+0xd>
 17c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 17f:	c9                   	leave  
 180:	c3                   	ret    

00000181 <strcmp>:
 181:	55                   	push   %ebp
 182:	89 e5                	mov    %esp,%ebp
 184:	eb 08                	jmp    18e <strcmp+0xd>
 186:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 18a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 18e:	8b 45 08             	mov    0x8(%ebp),%eax
 191:	0f b6 00             	movzbl (%eax),%eax
 194:	84 c0                	test   %al,%al
 196:	74 10                	je     1a8 <strcmp+0x27>
 198:	8b 45 08             	mov    0x8(%ebp),%eax
 19b:	0f b6 10             	movzbl (%eax),%edx
 19e:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a1:	0f b6 00             	movzbl (%eax),%eax
 1a4:	38 c2                	cmp    %al,%dl
 1a6:	74 de                	je     186 <strcmp+0x5>
 1a8:	8b 45 08             	mov    0x8(%ebp),%eax
 1ab:	0f b6 00             	movzbl (%eax),%eax
 1ae:	0f b6 d0             	movzbl %al,%edx
 1b1:	8b 45 0c             	mov    0xc(%ebp),%eax
 1b4:	0f b6 00             	movzbl (%eax),%eax
 1b7:	0f b6 c8             	movzbl %al,%ecx
 1ba:	89 d0                	mov    %edx,%eax
 1bc:	29 c8                	sub    %ecx,%eax
 1be:	5d                   	pop    %ebp
 1bf:	c3                   	ret    

000001c0 <strlen>:
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	83 ec 10             	sub    $0x10,%esp
 1c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1cd:	eb 04                	jmp    1d3 <strlen+0x13>
 1cf:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1d3:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1d6:	8b 45 08             	mov    0x8(%ebp),%eax
 1d9:	01 d0                	add    %edx,%eax
 1db:	0f b6 00             	movzbl (%eax),%eax
 1de:	84 c0                	test   %al,%al
 1e0:	75 ed                	jne    1cf <strlen+0xf>
 1e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 1e5:	c9                   	leave  
 1e6:	c3                   	ret    

000001e7 <memset>:
 1e7:	55                   	push   %ebp
 1e8:	89 e5                	mov    %esp,%ebp
 1ea:	8b 45 10             	mov    0x10(%ebp),%eax
 1ed:	50                   	push   %eax
 1ee:	ff 75 0c             	push   0xc(%ebp)
 1f1:	ff 75 08             	push   0x8(%ebp)
 1f4:	e8 32 ff ff ff       	call   12b <stosb>
 1f9:	83 c4 0c             	add    $0xc,%esp
 1fc:	8b 45 08             	mov    0x8(%ebp),%eax
 1ff:	c9                   	leave  
 200:	c3                   	ret    

00000201 <strchr>:
 201:	55                   	push   %ebp
 202:	89 e5                	mov    %esp,%ebp
 204:	83 ec 04             	sub    $0x4,%esp
 207:	8b 45 0c             	mov    0xc(%ebp),%eax
 20a:	88 45 fc             	mov    %al,-0x4(%ebp)
 20d:	eb 14                	jmp    223 <strchr+0x22>
 20f:	8b 45 08             	mov    0x8(%ebp),%eax
 212:	0f b6 00             	movzbl (%eax),%eax
 215:	38 45 fc             	cmp    %al,-0x4(%ebp)
 218:	75 05                	jne    21f <strchr+0x1e>
 21a:	8b 45 08             	mov    0x8(%ebp),%eax
 21d:	eb 13                	jmp    232 <strchr+0x31>
 21f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 223:	8b 45 08             	mov    0x8(%ebp),%eax
 226:	0f b6 00             	movzbl (%eax),%eax
 229:	84 c0                	test   %al,%al
 22b:	75 e2                	jne    20f <strchr+0xe>
 22d:	b8 00 00 00 00       	mov    $0x0,%eax
 232:	c9                   	leave  
 233:	c3                   	ret    

00000234 <gets>:
 234:	55                   	push   %ebp
 235:	89 e5                	mov    %esp,%ebp
 237:	83 ec 18             	sub    $0x18,%esp
 23a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 241:	eb 42                	jmp    285 <gets+0x51>
 243:	83 ec 04             	sub    $0x4,%esp
 246:	6a 01                	push   $0x1
 248:	8d 45 ef             	lea    -0x11(%ebp),%eax
 24b:	50                   	push   %eax
 24c:	6a 00                	push   $0x0
 24e:	e8 a2 01 00 00       	call   3f5 <read>
 253:	83 c4 10             	add    $0x10,%esp
 256:	89 45 f0             	mov    %eax,-0x10(%ebp)
 259:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 25d:	7e 33                	jle    292 <gets+0x5e>
 25f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 262:	8d 50 01             	lea    0x1(%eax),%edx
 265:	89 55 f4             	mov    %edx,-0xc(%ebp)
 268:	89 c2                	mov    %eax,%edx
 26a:	8b 45 08             	mov    0x8(%ebp),%eax
 26d:	01 c2                	add    %eax,%edx
 26f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 273:	88 02                	mov    %al,(%edx)
 275:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 279:	3c 0a                	cmp    $0xa,%al
 27b:	74 16                	je     293 <gets+0x5f>
 27d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 281:	3c 0d                	cmp    $0xd,%al
 283:	74 0e                	je     293 <gets+0x5f>
 285:	8b 45 f4             	mov    -0xc(%ebp),%eax
 288:	83 c0 01             	add    $0x1,%eax
 28b:	39 45 0c             	cmp    %eax,0xc(%ebp)
 28e:	7f b3                	jg     243 <gets+0xf>
 290:	eb 01                	jmp    293 <gets+0x5f>
 292:	90                   	nop
 293:	8b 55 f4             	mov    -0xc(%ebp),%edx
 296:	8b 45 08             	mov    0x8(%ebp),%eax
 299:	01 d0                	add    %edx,%eax
 29b:	c6 00 00             	movb   $0x0,(%eax)
 29e:	8b 45 08             	mov    0x8(%ebp),%eax
 2a1:	c9                   	leave  
 2a2:	c3                   	ret    

000002a3 <stat>:
 2a3:	55                   	push   %ebp
 2a4:	89 e5                	mov    %esp,%ebp
 2a6:	83 ec 18             	sub    $0x18,%esp
 2a9:	83 ec 08             	sub    $0x8,%esp
 2ac:	6a 00                	push   $0x0
 2ae:	ff 75 08             	push   0x8(%ebp)
 2b1:	e8 67 01 00 00       	call   41d <open>
 2b6:	83 c4 10             	add    $0x10,%esp
 2b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
 2bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2c0:	79 07                	jns    2c9 <stat+0x26>
 2c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2c7:	eb 25                	jmp    2ee <stat+0x4b>
 2c9:	83 ec 08             	sub    $0x8,%esp
 2cc:	ff 75 0c             	push   0xc(%ebp)
 2cf:	ff 75 f4             	push   -0xc(%ebp)
 2d2:	e8 5e 01 00 00       	call   435 <fstat>
 2d7:	83 c4 10             	add    $0x10,%esp
 2da:	89 45 f0             	mov    %eax,-0x10(%ebp)
 2dd:	83 ec 0c             	sub    $0xc,%esp
 2e0:	ff 75 f4             	push   -0xc(%ebp)
 2e3:	e8 1d 01 00 00       	call   405 <close>
 2e8:	83 c4 10             	add    $0x10,%esp
 2eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 2ee:	c9                   	leave  
 2ef:	c3                   	ret    

000002f0 <atoi>:
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	83 ec 10             	sub    $0x10,%esp
 2f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 2fd:	eb 25                	jmp    324 <atoi+0x34>
 2ff:	8b 55 fc             	mov    -0x4(%ebp),%edx
 302:	89 d0                	mov    %edx,%eax
 304:	c1 e0 02             	shl    $0x2,%eax
 307:	01 d0                	add    %edx,%eax
 309:	01 c0                	add    %eax,%eax
 30b:	89 c1                	mov    %eax,%ecx
 30d:	8b 45 08             	mov    0x8(%ebp),%eax
 310:	8d 50 01             	lea    0x1(%eax),%edx
 313:	89 55 08             	mov    %edx,0x8(%ebp)
 316:	0f b6 00             	movzbl (%eax),%eax
 319:	0f be c0             	movsbl %al,%eax
 31c:	01 c8                	add    %ecx,%eax
 31e:	83 e8 30             	sub    $0x30,%eax
 321:	89 45 fc             	mov    %eax,-0x4(%ebp)
 324:	8b 45 08             	mov    0x8(%ebp),%eax
 327:	0f b6 00             	movzbl (%eax),%eax
 32a:	3c 2f                	cmp    $0x2f,%al
 32c:	7e 0a                	jle    338 <atoi+0x48>
 32e:	8b 45 08             	mov    0x8(%ebp),%eax
 331:	0f b6 00             	movzbl (%eax),%eax
 334:	3c 39                	cmp    $0x39,%al
 336:	7e c7                	jle    2ff <atoi+0xf>
 338:	8b 45 fc             	mov    -0x4(%ebp),%eax
 33b:	c9                   	leave  
 33c:	c3                   	ret    

0000033d <memmove>:
 33d:	55                   	push   %ebp
 33e:	89 e5                	mov    %esp,%ebp
 340:	83 ec 10             	sub    $0x10,%esp
 343:	8b 45 08             	mov    0x8(%ebp),%eax
 346:	89 45 fc             	mov    %eax,-0x4(%ebp)
 349:	8b 45 0c             	mov    0xc(%ebp),%eax
 34c:	89 45 f8             	mov    %eax,-0x8(%ebp)
 34f:	eb 17                	jmp    368 <memmove+0x2b>
 351:	8b 55 f8             	mov    -0x8(%ebp),%edx
 354:	8d 42 01             	lea    0x1(%edx),%eax
 357:	89 45 f8             	mov    %eax,-0x8(%ebp)
 35a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 35d:	8d 48 01             	lea    0x1(%eax),%ecx
 360:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 363:	0f b6 12             	movzbl (%edx),%edx
 366:	88 10                	mov    %dl,(%eax)
 368:	8b 45 10             	mov    0x10(%ebp),%eax
 36b:	8d 50 ff             	lea    -0x1(%eax),%edx
 36e:	89 55 10             	mov    %edx,0x10(%ebp)
 371:	85 c0                	test   %eax,%eax
 373:	7f dc                	jg     351 <memmove+0x14>
 375:	8b 45 08             	mov    0x8(%ebp),%eax
 378:	c9                   	leave  
 379:	c3                   	ret    

0000037a <calc>:
 37a:	55                   	push   %ebp
 37b:	89 e5                	mov    %esp,%ebp
 37d:	83 ec 10             	sub    $0x10,%esp
 380:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 387:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
 38e:	eb 36                	jmp    3c6 <calc+0x4c>
 390:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 397:	eb 21                	jmp    3ba <calc+0x40>
 399:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 3a0:	eb 0c                	jmp    3ae <calc+0x34>
 3a2:	c1 7d fc 0a          	sarl   $0xa,-0x4(%ebp)
 3a6:	c1 65 fc 0a          	shll   $0xa,-0x4(%ebp)
 3aa:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 3ae:	8b 45 08             	mov    0x8(%ebp),%eax
 3b1:	39 45 f0             	cmp    %eax,-0x10(%ebp)
 3b4:	72 ec                	jb     3a2 <calc+0x28>
 3b6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 3ba:	8b 45 08             	mov    0x8(%ebp),%eax
 3bd:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 3c0:	72 d7                	jb     399 <calc+0x1f>
 3c2:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 3c6:	8b 45 08             	mov    0x8(%ebp),%eax
 3c9:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 3cc:	72 c2                	jb     390 <calc+0x16>
 3ce:	b8 00 00 00 00       	mov    $0x0,%eax
 3d3:	c9                   	leave  
 3d4:	c3                   	ret    

000003d5 <fork>:
 3d5:	b8 01 00 00 00       	mov    $0x1,%eax
 3da:	cd 40                	int    $0x40
 3dc:	c3                   	ret    

000003dd <exit>:
 3dd:	b8 02 00 00 00       	mov    $0x2,%eax
 3e2:	cd 40                	int    $0x40
 3e4:	c3                   	ret    

000003e5 <wait>:
 3e5:	b8 03 00 00 00       	mov    $0x3,%eax
 3ea:	cd 40                	int    $0x40
 3ec:	c3                   	ret    

000003ed <pipe>:
 3ed:	b8 04 00 00 00       	mov    $0x4,%eax
 3f2:	cd 40                	int    $0x40
 3f4:	c3                   	ret    

000003f5 <read>:
 3f5:	b8 05 00 00 00       	mov    $0x5,%eax
 3fa:	cd 40                	int    $0x40
 3fc:	c3                   	ret    

000003fd <write>:
 3fd:	b8 10 00 00 00       	mov    $0x10,%eax
 402:	cd 40                	int    $0x40
 404:	c3                   	ret    

00000405 <close>:
 405:	b8 15 00 00 00       	mov    $0x15,%eax
 40a:	cd 40                	int    $0x40
 40c:	c3                   	ret    

0000040d <kill>:
 40d:	b8 06 00 00 00       	mov    $0x6,%eax
 412:	cd 40                	int    $0x40
 414:	c3                   	ret    

00000415 <exec>:
 415:	b8 07 00 00 00       	mov    $0x7,%eax
 41a:	cd 40                	int    $0x40
 41c:	c3                   	ret    

0000041d <open>:
 41d:	b8 0f 00 00 00       	mov    $0xf,%eax
 422:	cd 40                	int    $0x40
 424:	c3                   	ret    

00000425 <mknod>:
 425:	b8 11 00 00 00       	mov    $0x11,%eax
 42a:	cd 40                	int    $0x40
 42c:	c3                   	ret    

0000042d <unlink>:
 42d:	b8 12 00 00 00       	mov    $0x12,%eax
 432:	cd 40                	int    $0x40
 434:	c3                   	ret    

00000435 <fstat>:
 435:	b8 08 00 00 00       	mov    $0x8,%eax
 43a:	cd 40                	int    $0x40
 43c:	c3                   	ret    

0000043d <link>:
 43d:	b8 13 00 00 00       	mov    $0x13,%eax
 442:	cd 40                	int    $0x40
 444:	c3                   	ret    

00000445 <mkdir>:
 445:	b8 14 00 00 00       	mov    $0x14,%eax
 44a:	cd 40                	int    $0x40
 44c:	c3                   	ret    

0000044d <chdir>:
 44d:	b8 09 00 00 00       	mov    $0x9,%eax
 452:	cd 40                	int    $0x40
 454:	c3                   	ret    

00000455 <dup>:
 455:	b8 0a 00 00 00       	mov    $0xa,%eax
 45a:	cd 40                	int    $0x40
 45c:	c3                   	ret    

0000045d <getpid>:
 45d:	b8 0b 00 00 00       	mov    $0xb,%eax
 462:	cd 40                	int    $0x40
 464:	c3                   	ret    

00000465 <sbrk>:
 465:	b8 0c 00 00 00       	mov    $0xc,%eax
 46a:	cd 40                	int    $0x40
 46c:	c3                   	ret    

0000046d <sleep>:
 46d:	b8 0d 00 00 00       	mov    $0xd,%eax
 472:	cd 40                	int    $0x40
 474:	c3                   	ret    

00000475 <uptime>:
 475:	b8 0e 00 00 00       	mov    $0xe,%eax
 47a:	cd 40                	int    $0x40
 47c:	c3                   	ret    

0000047d <print_proc>:
 47d:	b8 16 00 00 00       	mov    $0x16,%eax
 482:	cd 40                	int    $0x40
 484:	c3                   	ret    

00000485 <change_queue>:
 485:	b8 17 00 00 00       	mov    $0x17,%eax
 48a:	cd 40                	int    $0x40
 48c:	c3                   	ret    

0000048d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 48d:	55                   	push   %ebp
 48e:	89 e5                	mov    %esp,%ebp
 490:	83 ec 18             	sub    $0x18,%esp
 493:	8b 45 0c             	mov    0xc(%ebp),%eax
 496:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 499:	83 ec 04             	sub    $0x4,%esp
 49c:	6a 01                	push   $0x1
 49e:	8d 45 f4             	lea    -0xc(%ebp),%eax
 4a1:	50                   	push   %eax
 4a2:	ff 75 08             	push   0x8(%ebp)
 4a5:	e8 53 ff ff ff       	call   3fd <write>
 4aa:	83 c4 10             	add    $0x10,%esp
}
 4ad:	90                   	nop
 4ae:	c9                   	leave  
 4af:	c3                   	ret    

000004b0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4b6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4bd:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4c1:	74 17                	je     4da <printint+0x2a>
 4c3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4c7:	79 11                	jns    4da <printint+0x2a>
    neg = 1;
 4c9:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4d0:	8b 45 0c             	mov    0xc(%ebp),%eax
 4d3:	f7 d8                	neg    %eax
 4d5:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4d8:	eb 06                	jmp    4e0 <printint+0x30>
  } else {
    x = xx;
 4da:	8b 45 0c             	mov    0xc(%ebp),%eax
 4dd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4e0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4ea:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4ed:	ba 00 00 00 00       	mov    $0x0,%edx
 4f2:	f7 f1                	div    %ecx
 4f4:	89 d1                	mov    %edx,%ecx
 4f6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4f9:	8d 50 01             	lea    0x1(%eax),%edx
 4fc:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4ff:	0f b6 91 e0 0b 00 00 	movzbl 0xbe0(%ecx),%edx
 506:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 50a:	8b 4d 10             	mov    0x10(%ebp),%ecx
 50d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 510:	ba 00 00 00 00       	mov    $0x0,%edx
 515:	f7 f1                	div    %ecx
 517:	89 45 ec             	mov    %eax,-0x14(%ebp)
 51a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 51e:	75 c7                	jne    4e7 <printint+0x37>
  if(neg)
 520:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 524:	74 2d                	je     553 <printint+0xa3>
    buf[i++] = '-';
 526:	8b 45 f4             	mov    -0xc(%ebp),%eax
 529:	8d 50 01             	lea    0x1(%eax),%edx
 52c:	89 55 f4             	mov    %edx,-0xc(%ebp)
 52f:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 534:	eb 1d                	jmp    553 <printint+0xa3>
    putc(fd, buf[i]);
 536:	8d 55 dc             	lea    -0x24(%ebp),%edx
 539:	8b 45 f4             	mov    -0xc(%ebp),%eax
 53c:	01 d0                	add    %edx,%eax
 53e:	0f b6 00             	movzbl (%eax),%eax
 541:	0f be c0             	movsbl %al,%eax
 544:	83 ec 08             	sub    $0x8,%esp
 547:	50                   	push   %eax
 548:	ff 75 08             	push   0x8(%ebp)
 54b:	e8 3d ff ff ff       	call   48d <putc>
 550:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 553:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 557:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 55b:	79 d9                	jns    536 <printint+0x86>
}
 55d:	90                   	nop
 55e:	90                   	nop
 55f:	c9                   	leave  
 560:	c3                   	ret    

00000561 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 561:	55                   	push   %ebp
 562:	89 e5                	mov    %esp,%ebp
 564:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 567:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 56e:	8d 45 0c             	lea    0xc(%ebp),%eax
 571:	83 c0 04             	add    $0x4,%eax
 574:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 577:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 57e:	e9 59 01 00 00       	jmp    6dc <printf+0x17b>
    c = fmt[i] & 0xff;
 583:	8b 55 0c             	mov    0xc(%ebp),%edx
 586:	8b 45 f0             	mov    -0x10(%ebp),%eax
 589:	01 d0                	add    %edx,%eax
 58b:	0f b6 00             	movzbl (%eax),%eax
 58e:	0f be c0             	movsbl %al,%eax
 591:	25 ff 00 00 00       	and    $0xff,%eax
 596:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 599:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 59d:	75 2c                	jne    5cb <printf+0x6a>
      if(c == '%'){
 59f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5a3:	75 0c                	jne    5b1 <printf+0x50>
        state = '%';
 5a5:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5ac:	e9 27 01 00 00       	jmp    6d8 <printf+0x177>
      } else {
        putc(fd, c);
 5b1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5b4:	0f be c0             	movsbl %al,%eax
 5b7:	83 ec 08             	sub    $0x8,%esp
 5ba:	50                   	push   %eax
 5bb:	ff 75 08             	push   0x8(%ebp)
 5be:	e8 ca fe ff ff       	call   48d <putc>
 5c3:	83 c4 10             	add    $0x10,%esp
 5c6:	e9 0d 01 00 00       	jmp    6d8 <printf+0x177>
      }
    } else if(state == '%'){
 5cb:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5cf:	0f 85 03 01 00 00    	jne    6d8 <printf+0x177>
      if(c == 'd'){
 5d5:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5d9:	75 1e                	jne    5f9 <printf+0x98>
        printint(fd, *ap, 10, 1);
 5db:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5de:	8b 00                	mov    (%eax),%eax
 5e0:	6a 01                	push   $0x1
 5e2:	6a 0a                	push   $0xa
 5e4:	50                   	push   %eax
 5e5:	ff 75 08             	push   0x8(%ebp)
 5e8:	e8 c3 fe ff ff       	call   4b0 <printint>
 5ed:	83 c4 10             	add    $0x10,%esp
        ap++;
 5f0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5f4:	e9 d8 00 00 00       	jmp    6d1 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 5f9:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5fd:	74 06                	je     605 <printf+0xa4>
 5ff:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 603:	75 1e                	jne    623 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 605:	8b 45 e8             	mov    -0x18(%ebp),%eax
 608:	8b 00                	mov    (%eax),%eax
 60a:	6a 00                	push   $0x0
 60c:	6a 10                	push   $0x10
 60e:	50                   	push   %eax
 60f:	ff 75 08             	push   0x8(%ebp)
 612:	e8 99 fe ff ff       	call   4b0 <printint>
 617:	83 c4 10             	add    $0x10,%esp
        ap++;
 61a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 61e:	e9 ae 00 00 00       	jmp    6d1 <printf+0x170>
      } else if(c == 's'){
 623:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 627:	75 43                	jne    66c <printf+0x10b>
        s = (char*)*ap;
 629:	8b 45 e8             	mov    -0x18(%ebp),%eax
 62c:	8b 00                	mov    (%eax),%eax
 62e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 631:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 635:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 639:	75 25                	jne    660 <printf+0xff>
          s = "(null)";
 63b:	c7 45 f4 50 09 00 00 	movl   $0x950,-0xc(%ebp)
        while(*s != 0){
 642:	eb 1c                	jmp    660 <printf+0xff>
          putc(fd, *s);
 644:	8b 45 f4             	mov    -0xc(%ebp),%eax
 647:	0f b6 00             	movzbl (%eax),%eax
 64a:	0f be c0             	movsbl %al,%eax
 64d:	83 ec 08             	sub    $0x8,%esp
 650:	50                   	push   %eax
 651:	ff 75 08             	push   0x8(%ebp)
 654:	e8 34 fe ff ff       	call   48d <putc>
 659:	83 c4 10             	add    $0x10,%esp
          s++;
 65c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 660:	8b 45 f4             	mov    -0xc(%ebp),%eax
 663:	0f b6 00             	movzbl (%eax),%eax
 666:	84 c0                	test   %al,%al
 668:	75 da                	jne    644 <printf+0xe3>
 66a:	eb 65                	jmp    6d1 <printf+0x170>
        }
      } else if(c == 'c'){
 66c:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 670:	75 1d                	jne    68f <printf+0x12e>
        putc(fd, *ap);
 672:	8b 45 e8             	mov    -0x18(%ebp),%eax
 675:	8b 00                	mov    (%eax),%eax
 677:	0f be c0             	movsbl %al,%eax
 67a:	83 ec 08             	sub    $0x8,%esp
 67d:	50                   	push   %eax
 67e:	ff 75 08             	push   0x8(%ebp)
 681:	e8 07 fe ff ff       	call   48d <putc>
 686:	83 c4 10             	add    $0x10,%esp
        ap++;
 689:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 68d:	eb 42                	jmp    6d1 <printf+0x170>
      } else if(c == '%'){
 68f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 693:	75 17                	jne    6ac <printf+0x14b>
        putc(fd, c);
 695:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 698:	0f be c0             	movsbl %al,%eax
 69b:	83 ec 08             	sub    $0x8,%esp
 69e:	50                   	push   %eax
 69f:	ff 75 08             	push   0x8(%ebp)
 6a2:	e8 e6 fd ff ff       	call   48d <putc>
 6a7:	83 c4 10             	add    $0x10,%esp
 6aa:	eb 25                	jmp    6d1 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6ac:	83 ec 08             	sub    $0x8,%esp
 6af:	6a 25                	push   $0x25
 6b1:	ff 75 08             	push   0x8(%ebp)
 6b4:	e8 d4 fd ff ff       	call   48d <putc>
 6b9:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 6bc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6bf:	0f be c0             	movsbl %al,%eax
 6c2:	83 ec 08             	sub    $0x8,%esp
 6c5:	50                   	push   %eax
 6c6:	ff 75 08             	push   0x8(%ebp)
 6c9:	e8 bf fd ff ff       	call   48d <putc>
 6ce:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 6d1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 6d8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6dc:	8b 55 0c             	mov    0xc(%ebp),%edx
 6df:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6e2:	01 d0                	add    %edx,%eax
 6e4:	0f b6 00             	movzbl (%eax),%eax
 6e7:	84 c0                	test   %al,%al
 6e9:	0f 85 94 fe ff ff    	jne    583 <printf+0x22>
    }
  }
}
 6ef:	90                   	nop
 6f0:	90                   	nop
 6f1:	c9                   	leave  
 6f2:	c3                   	ret    

000006f3 <free>:
 6f3:	55                   	push   %ebp
 6f4:	89 e5                	mov    %esp,%ebp
 6f6:	83 ec 10             	sub    $0x10,%esp
 6f9:	8b 45 08             	mov    0x8(%ebp),%eax
 6fc:	83 e8 08             	sub    $0x8,%eax
 6ff:	89 45 f8             	mov    %eax,-0x8(%ebp)
 702:	a1 08 0e 00 00       	mov    0xe08,%eax
 707:	89 45 fc             	mov    %eax,-0x4(%ebp)
 70a:	eb 24                	jmp    730 <free+0x3d>
 70c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70f:	8b 00                	mov    (%eax),%eax
 711:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 714:	72 12                	jb     728 <free+0x35>
 716:	8b 45 f8             	mov    -0x8(%ebp),%eax
 719:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 71c:	77 24                	ja     742 <free+0x4f>
 71e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 721:	8b 00                	mov    (%eax),%eax
 723:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 726:	72 1a                	jb     742 <free+0x4f>
 728:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72b:	8b 00                	mov    (%eax),%eax
 72d:	89 45 fc             	mov    %eax,-0x4(%ebp)
 730:	8b 45 f8             	mov    -0x8(%ebp),%eax
 733:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 736:	76 d4                	jbe    70c <free+0x19>
 738:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73b:	8b 00                	mov    (%eax),%eax
 73d:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 740:	73 ca                	jae    70c <free+0x19>
 742:	8b 45 f8             	mov    -0x8(%ebp),%eax
 745:	8b 40 04             	mov    0x4(%eax),%eax
 748:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 74f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 752:	01 c2                	add    %eax,%edx
 754:	8b 45 fc             	mov    -0x4(%ebp),%eax
 757:	8b 00                	mov    (%eax),%eax
 759:	39 c2                	cmp    %eax,%edx
 75b:	75 24                	jne    781 <free+0x8e>
 75d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 760:	8b 50 04             	mov    0x4(%eax),%edx
 763:	8b 45 fc             	mov    -0x4(%ebp),%eax
 766:	8b 00                	mov    (%eax),%eax
 768:	8b 40 04             	mov    0x4(%eax),%eax
 76b:	01 c2                	add    %eax,%edx
 76d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 770:	89 50 04             	mov    %edx,0x4(%eax)
 773:	8b 45 fc             	mov    -0x4(%ebp),%eax
 776:	8b 00                	mov    (%eax),%eax
 778:	8b 10                	mov    (%eax),%edx
 77a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 77d:	89 10                	mov    %edx,(%eax)
 77f:	eb 0a                	jmp    78b <free+0x98>
 781:	8b 45 fc             	mov    -0x4(%ebp),%eax
 784:	8b 10                	mov    (%eax),%edx
 786:	8b 45 f8             	mov    -0x8(%ebp),%eax
 789:	89 10                	mov    %edx,(%eax)
 78b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78e:	8b 40 04             	mov    0x4(%eax),%eax
 791:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 798:	8b 45 fc             	mov    -0x4(%ebp),%eax
 79b:	01 d0                	add    %edx,%eax
 79d:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 7a0:	75 20                	jne    7c2 <free+0xcf>
 7a2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a5:	8b 50 04             	mov    0x4(%eax),%edx
 7a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ab:	8b 40 04             	mov    0x4(%eax),%eax
 7ae:	01 c2                	add    %eax,%edx
 7b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b3:	89 50 04             	mov    %edx,0x4(%eax)
 7b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b9:	8b 10                	mov    (%eax),%edx
 7bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7be:	89 10                	mov    %edx,(%eax)
 7c0:	eb 08                	jmp    7ca <free+0xd7>
 7c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c5:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7c8:	89 10                	mov    %edx,(%eax)
 7ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7cd:	a3 08 0e 00 00       	mov    %eax,0xe08
 7d2:	90                   	nop
 7d3:	c9                   	leave  
 7d4:	c3                   	ret    

000007d5 <morecore>:
 7d5:	55                   	push   %ebp
 7d6:	89 e5                	mov    %esp,%ebp
 7d8:	83 ec 18             	sub    $0x18,%esp
 7db:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7e2:	77 07                	ja     7eb <morecore+0x16>
 7e4:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
 7eb:	8b 45 08             	mov    0x8(%ebp),%eax
 7ee:	c1 e0 03             	shl    $0x3,%eax
 7f1:	83 ec 0c             	sub    $0xc,%esp
 7f4:	50                   	push   %eax
 7f5:	e8 6b fc ff ff       	call   465 <sbrk>
 7fa:	83 c4 10             	add    $0x10,%esp
 7fd:	89 45 f4             	mov    %eax,-0xc(%ebp)
 800:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 804:	75 07                	jne    80d <morecore+0x38>
 806:	b8 00 00 00 00       	mov    $0x0,%eax
 80b:	eb 26                	jmp    833 <morecore+0x5e>
 80d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 810:	89 45 f0             	mov    %eax,-0x10(%ebp)
 813:	8b 45 f0             	mov    -0x10(%ebp),%eax
 816:	8b 55 08             	mov    0x8(%ebp),%edx
 819:	89 50 04             	mov    %edx,0x4(%eax)
 81c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 81f:	83 c0 08             	add    $0x8,%eax
 822:	83 ec 0c             	sub    $0xc,%esp
 825:	50                   	push   %eax
 826:	e8 c8 fe ff ff       	call   6f3 <free>
 82b:	83 c4 10             	add    $0x10,%esp
 82e:	a1 08 0e 00 00       	mov    0xe08,%eax
 833:	c9                   	leave  
 834:	c3                   	ret    

00000835 <malloc>:
 835:	55                   	push   %ebp
 836:	89 e5                	mov    %esp,%ebp
 838:	83 ec 18             	sub    $0x18,%esp
 83b:	8b 45 08             	mov    0x8(%ebp),%eax
 83e:	83 c0 07             	add    $0x7,%eax
 841:	c1 e8 03             	shr    $0x3,%eax
 844:	83 c0 01             	add    $0x1,%eax
 847:	89 45 ec             	mov    %eax,-0x14(%ebp)
 84a:	a1 08 0e 00 00       	mov    0xe08,%eax
 84f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 852:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 856:	75 23                	jne    87b <malloc+0x46>
 858:	c7 45 f0 00 0e 00 00 	movl   $0xe00,-0x10(%ebp)
 85f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 862:	a3 08 0e 00 00       	mov    %eax,0xe08
 867:	a1 08 0e 00 00       	mov    0xe08,%eax
 86c:	a3 00 0e 00 00       	mov    %eax,0xe00
 871:	c7 05 04 0e 00 00 00 	movl   $0x0,0xe04
 878:	00 00 00 
 87b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 87e:	8b 00                	mov    (%eax),%eax
 880:	89 45 f4             	mov    %eax,-0xc(%ebp)
 883:	8b 45 f4             	mov    -0xc(%ebp),%eax
 886:	8b 40 04             	mov    0x4(%eax),%eax
 889:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 88c:	77 4d                	ja     8db <malloc+0xa6>
 88e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 891:	8b 40 04             	mov    0x4(%eax),%eax
 894:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 897:	75 0c                	jne    8a5 <malloc+0x70>
 899:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89c:	8b 10                	mov    (%eax),%edx
 89e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8a1:	89 10                	mov    %edx,(%eax)
 8a3:	eb 26                	jmp    8cb <malloc+0x96>
 8a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a8:	8b 40 04             	mov    0x4(%eax),%eax
 8ab:	2b 45 ec             	sub    -0x14(%ebp),%eax
 8ae:	89 c2                	mov    %eax,%edx
 8b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b3:	89 50 04             	mov    %edx,0x4(%eax)
 8b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b9:	8b 40 04             	mov    0x4(%eax),%eax
 8bc:	c1 e0 03             	shl    $0x3,%eax
 8bf:	01 45 f4             	add    %eax,-0xc(%ebp)
 8c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c5:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8c8:	89 50 04             	mov    %edx,0x4(%eax)
 8cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8ce:	a3 08 0e 00 00       	mov    %eax,0xe08
 8d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d6:	83 c0 08             	add    $0x8,%eax
 8d9:	eb 3b                	jmp    916 <malloc+0xe1>
 8db:	a1 08 0e 00 00       	mov    0xe08,%eax
 8e0:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8e3:	75 1e                	jne    903 <malloc+0xce>
 8e5:	83 ec 0c             	sub    $0xc,%esp
 8e8:	ff 75 ec             	push   -0x14(%ebp)
 8eb:	e8 e5 fe ff ff       	call   7d5 <morecore>
 8f0:	83 c4 10             	add    $0x10,%esp
 8f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8fa:	75 07                	jne    903 <malloc+0xce>
 8fc:	b8 00 00 00 00       	mov    $0x0,%eax
 901:	eb 13                	jmp    916 <malloc+0xe1>
 903:	8b 45 f4             	mov    -0xc(%ebp),%eax
 906:	89 45 f0             	mov    %eax,-0x10(%ebp)
 909:	8b 45 f4             	mov    -0xc(%ebp),%eax
 90c:	8b 00                	mov    (%eax),%eax
 90e:	89 45 f4             	mov    %eax,-0xc(%ebp)
 911:	e9 6d ff ff ff       	jmp    883 <malloc+0x4e>
 916:	c9                   	leave  
 917:	c3                   	ret    
