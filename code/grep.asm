
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <grep>:
char buf[1024];
int match(char*, char*);

void
grep(char *pattern, int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  int n, m;
  char *p, *q;

  m = 0;
   6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
   d:	e9 ae 00 00 00       	jmp    c0 <grep+0xc0>
    m += n;
  12:	8b 45 ec             	mov    -0x14(%ebp),%eax
  15:	01 45 f4             	add    %eax,-0xc(%ebp)
    buf[m] = '\0';
  18:	8b 45 f4             	mov    -0xc(%ebp),%eax
  1b:	05 60 0e 00 00       	add    $0xe60,%eax
  20:	c6 00 00             	movb   $0x0,(%eax)
    p = buf;
  23:	c7 45 f0 60 0e 00 00 	movl   $0xe60,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
  2a:	eb 44                	jmp    70 <grep+0x70>
      *q = 0;
  2c:	8b 45 e8             	mov    -0x18(%ebp),%eax
  2f:	c6 00 00             	movb   $0x0,(%eax)
      if(match(pattern, p)){
  32:	83 ec 08             	sub    $0x8,%esp
  35:	ff 75 f0             	push   -0x10(%ebp)
  38:	ff 75 08             	push   0x8(%ebp)
  3b:	e8 91 01 00 00       	call   1d1 <match>
  40:	83 c4 10             	add    $0x10,%esp
  43:	85 c0                	test   %eax,%eax
  45:	74 20                	je     67 <grep+0x67>
        *q = '\n';
  47:	8b 45 e8             	mov    -0x18(%ebp),%eax
  4a:	c6 00 0a             	movb   $0xa,(%eax)
        write(1, p, q+1 - p);
  4d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  50:	83 c0 01             	add    $0x1,%eax
  53:	2b 45 f0             	sub    -0x10(%ebp),%eax
  56:	83 ec 04             	sub    $0x4,%esp
  59:	50                   	push   %eax
  5a:	ff 75 f0             	push   -0x10(%ebp)
  5d:	6a 01                	push   $0x1
  5f:	e8 9b 05 00 00       	call   5ff <write>
  64:	83 c4 10             	add    $0x10,%esp
      }
      p = q+1;
  67:	8b 45 e8             	mov    -0x18(%ebp),%eax
  6a:	83 c0 01             	add    $0x1,%eax
  6d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    while((q = strchr(p, '\n')) != 0){
  70:	83 ec 08             	sub    $0x8,%esp
  73:	6a 0a                	push   $0xa
  75:	ff 75 f0             	push   -0x10(%ebp)
  78:	e8 86 03 00 00       	call   403 <strchr>
  7d:	83 c4 10             	add    $0x10,%esp
  80:	89 45 e8             	mov    %eax,-0x18(%ebp)
  83:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
  87:	75 a3                	jne    2c <grep+0x2c>
    }
    if(p == buf)
  89:	81 7d f0 60 0e 00 00 	cmpl   $0xe60,-0x10(%ebp)
  90:	75 07                	jne    99 <grep+0x99>
      m = 0;
  92:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(m > 0){
  99:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  9d:	7e 21                	jle    c0 <grep+0xc0>
      m -= p - buf;
  9f:	8b 45 f0             	mov    -0x10(%ebp),%eax
  a2:	2d 60 0e 00 00       	sub    $0xe60,%eax
  a7:	29 45 f4             	sub    %eax,-0xc(%ebp)
      memmove(buf, p, m);
  aa:	83 ec 04             	sub    $0x4,%esp
  ad:	ff 75 f4             	push   -0xc(%ebp)
  b0:	ff 75 f0             	push   -0x10(%ebp)
  b3:	68 60 0e 00 00       	push   $0xe60
  b8:	e8 82 04 00 00       	call   53f <memmove>
  bd:	83 c4 10             	add    $0x10,%esp
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
  c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
  c3:	b8 ff 03 00 00       	mov    $0x3ff,%eax
  c8:	29 d0                	sub    %edx,%eax
  ca:	89 c2                	mov    %eax,%edx
  cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
  cf:	05 60 0e 00 00       	add    $0xe60,%eax
  d4:	83 ec 04             	sub    $0x4,%esp
  d7:	52                   	push   %edx
  d8:	50                   	push   %eax
  d9:	ff 75 0c             	push   0xc(%ebp)
  dc:	e8 16 05 00 00       	call   5f7 <read>
  e1:	83 c4 10             	add    $0x10,%esp
  e4:	89 45 ec             	mov    %eax,-0x14(%ebp)
  e7:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
  eb:	0f 8f 21 ff ff ff    	jg     12 <grep+0x12>
    }
  }
}
  f1:	90                   	nop
  f2:	90                   	nop
  f3:	c9                   	leave  
  f4:	c3                   	ret    

000000f5 <main>:

int
main(int argc, char *argv[])
{
  f5:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  f9:	83 e4 f0             	and    $0xfffffff0,%esp
  fc:	ff 71 fc             	push   -0x4(%ecx)
  ff:	55                   	push   %ebp
 100:	89 e5                	mov    %esp,%ebp
 102:	53                   	push   %ebx
 103:	51                   	push   %ecx
 104:	83 ec 10             	sub    $0x10,%esp
 107:	89 cb                	mov    %ecx,%ebx
  int fd, i;
  char *pattern;

  if(argc <= 1){
 109:	83 3b 01             	cmpl   $0x1,(%ebx)
 10c:	7f 17                	jg     125 <main+0x30>
    printf(2, "usage: grep pattern [file ...]\n");
 10e:	83 ec 08             	sub    $0x8,%esp
 111:	68 1c 0b 00 00       	push   $0xb1c
 116:	6a 02                	push   $0x2
 118:	e8 46 06 00 00       	call   763 <printf>
 11d:	83 c4 10             	add    $0x10,%esp
    exit();
 120:	e8 ba 04 00 00       	call   5df <exit>
  }
  pattern = argv[1];
 125:	8b 43 04             	mov    0x4(%ebx),%eax
 128:	8b 40 04             	mov    0x4(%eax),%eax
 12b:	89 45 f0             	mov    %eax,-0x10(%ebp)

  if(argc <= 2){
 12e:	83 3b 02             	cmpl   $0x2,(%ebx)
 131:	7f 15                	jg     148 <main+0x53>
    grep(pattern, 0);
 133:	83 ec 08             	sub    $0x8,%esp
 136:	6a 00                	push   $0x0
 138:	ff 75 f0             	push   -0x10(%ebp)
 13b:	e8 c0 fe ff ff       	call   0 <grep>
 140:	83 c4 10             	add    $0x10,%esp
    exit();
 143:	e8 97 04 00 00       	call   5df <exit>
  }

  for(i = 2; i < argc; i++){
 148:	c7 45 f4 02 00 00 00 	movl   $0x2,-0xc(%ebp)
 14f:	eb 74                	jmp    1c5 <main+0xd0>
    if((fd = open(argv[i], 0)) < 0){
 151:	8b 45 f4             	mov    -0xc(%ebp),%eax
 154:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 15b:	8b 43 04             	mov    0x4(%ebx),%eax
 15e:	01 d0                	add    %edx,%eax
 160:	8b 00                	mov    (%eax),%eax
 162:	83 ec 08             	sub    $0x8,%esp
 165:	6a 00                	push   $0x0
 167:	50                   	push   %eax
 168:	e8 b2 04 00 00       	call   61f <open>
 16d:	83 c4 10             	add    $0x10,%esp
 170:	89 45 ec             	mov    %eax,-0x14(%ebp)
 173:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 177:	79 29                	jns    1a2 <main+0xad>
      printf(1, "grep: cannot open %s\n", argv[i]);
 179:	8b 45 f4             	mov    -0xc(%ebp),%eax
 17c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 183:	8b 43 04             	mov    0x4(%ebx),%eax
 186:	01 d0                	add    %edx,%eax
 188:	8b 00                	mov    (%eax),%eax
 18a:	83 ec 04             	sub    $0x4,%esp
 18d:	50                   	push   %eax
 18e:	68 3c 0b 00 00       	push   $0xb3c
 193:	6a 01                	push   $0x1
 195:	e8 c9 05 00 00       	call   763 <printf>
 19a:	83 c4 10             	add    $0x10,%esp
      exit();
 19d:	e8 3d 04 00 00       	call   5df <exit>
    }
    grep(pattern, fd);
 1a2:	83 ec 08             	sub    $0x8,%esp
 1a5:	ff 75 ec             	push   -0x14(%ebp)
 1a8:	ff 75 f0             	push   -0x10(%ebp)
 1ab:	e8 50 fe ff ff       	call   0 <grep>
 1b0:	83 c4 10             	add    $0x10,%esp
    close(fd);
 1b3:	83 ec 0c             	sub    $0xc,%esp
 1b6:	ff 75 ec             	push   -0x14(%ebp)
 1b9:	e8 49 04 00 00       	call   607 <close>
 1be:	83 c4 10             	add    $0x10,%esp
  for(i = 2; i < argc; i++){
 1c1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 1c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c8:	3b 03                	cmp    (%ebx),%eax
 1ca:	7c 85                	jl     151 <main+0x5c>
  }
  exit();
 1cc:	e8 0e 04 00 00       	call   5df <exit>

000001d1 <match>:
int matchhere(char*, char*);
int matchstar(int, char*, char*);

int
match(char *re, char *text)
{
 1d1:	55                   	push   %ebp
 1d2:	89 e5                	mov    %esp,%ebp
 1d4:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '^')
 1d7:	8b 45 08             	mov    0x8(%ebp),%eax
 1da:	0f b6 00             	movzbl (%eax),%eax
 1dd:	3c 5e                	cmp    $0x5e,%al
 1df:	75 17                	jne    1f8 <match+0x27>
    return matchhere(re+1, text);
 1e1:	8b 45 08             	mov    0x8(%ebp),%eax
 1e4:	83 c0 01             	add    $0x1,%eax
 1e7:	83 ec 08             	sub    $0x8,%esp
 1ea:	ff 75 0c             	push   0xc(%ebp)
 1ed:	50                   	push   %eax
 1ee:	e8 38 00 00 00       	call   22b <matchhere>
 1f3:	83 c4 10             	add    $0x10,%esp
 1f6:	eb 31                	jmp    229 <match+0x58>
  do{  // must look at empty string
    if(matchhere(re, text))
 1f8:	83 ec 08             	sub    $0x8,%esp
 1fb:	ff 75 0c             	push   0xc(%ebp)
 1fe:	ff 75 08             	push   0x8(%ebp)
 201:	e8 25 00 00 00       	call   22b <matchhere>
 206:	83 c4 10             	add    $0x10,%esp
 209:	85 c0                	test   %eax,%eax
 20b:	74 07                	je     214 <match+0x43>
      return 1;
 20d:	b8 01 00 00 00       	mov    $0x1,%eax
 212:	eb 15                	jmp    229 <match+0x58>
  }while(*text++ != '\0');
 214:	8b 45 0c             	mov    0xc(%ebp),%eax
 217:	8d 50 01             	lea    0x1(%eax),%edx
 21a:	89 55 0c             	mov    %edx,0xc(%ebp)
 21d:	0f b6 00             	movzbl (%eax),%eax
 220:	84 c0                	test   %al,%al
 222:	75 d4                	jne    1f8 <match+0x27>
  return 0;
 224:	b8 00 00 00 00       	mov    $0x0,%eax
}
 229:	c9                   	leave  
 22a:	c3                   	ret    

0000022b <matchhere>:

// matchhere: search for re at beginning of text
int matchhere(char *re, char *text)
{
 22b:	55                   	push   %ebp
 22c:	89 e5                	mov    %esp,%ebp
 22e:	83 ec 08             	sub    $0x8,%esp
  if(re[0] == '\0')
 231:	8b 45 08             	mov    0x8(%ebp),%eax
 234:	0f b6 00             	movzbl (%eax),%eax
 237:	84 c0                	test   %al,%al
 239:	75 0a                	jne    245 <matchhere+0x1a>
    return 1;
 23b:	b8 01 00 00 00       	mov    $0x1,%eax
 240:	e9 99 00 00 00       	jmp    2de <matchhere+0xb3>
  if(re[1] == '*')
 245:	8b 45 08             	mov    0x8(%ebp),%eax
 248:	83 c0 01             	add    $0x1,%eax
 24b:	0f b6 00             	movzbl (%eax),%eax
 24e:	3c 2a                	cmp    $0x2a,%al
 250:	75 21                	jne    273 <matchhere+0x48>
    return matchstar(re[0], re+2, text);
 252:	8b 45 08             	mov    0x8(%ebp),%eax
 255:	8d 50 02             	lea    0x2(%eax),%edx
 258:	8b 45 08             	mov    0x8(%ebp),%eax
 25b:	0f b6 00             	movzbl (%eax),%eax
 25e:	0f be c0             	movsbl %al,%eax
 261:	83 ec 04             	sub    $0x4,%esp
 264:	ff 75 0c             	push   0xc(%ebp)
 267:	52                   	push   %edx
 268:	50                   	push   %eax
 269:	e8 72 00 00 00       	call   2e0 <matchstar>
 26e:	83 c4 10             	add    $0x10,%esp
 271:	eb 6b                	jmp    2de <matchhere+0xb3>
  if(re[0] == '$' && re[1] == '\0')
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	0f b6 00             	movzbl (%eax),%eax
 279:	3c 24                	cmp    $0x24,%al
 27b:	75 1d                	jne    29a <matchhere+0x6f>
 27d:	8b 45 08             	mov    0x8(%ebp),%eax
 280:	83 c0 01             	add    $0x1,%eax
 283:	0f b6 00             	movzbl (%eax),%eax
 286:	84 c0                	test   %al,%al
 288:	75 10                	jne    29a <matchhere+0x6f>
    return *text == '\0';
 28a:	8b 45 0c             	mov    0xc(%ebp),%eax
 28d:	0f b6 00             	movzbl (%eax),%eax
 290:	84 c0                	test   %al,%al
 292:	0f 94 c0             	sete   %al
 295:	0f b6 c0             	movzbl %al,%eax
 298:	eb 44                	jmp    2de <matchhere+0xb3>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
 29a:	8b 45 0c             	mov    0xc(%ebp),%eax
 29d:	0f b6 00             	movzbl (%eax),%eax
 2a0:	84 c0                	test   %al,%al
 2a2:	74 35                	je     2d9 <matchhere+0xae>
 2a4:	8b 45 08             	mov    0x8(%ebp),%eax
 2a7:	0f b6 00             	movzbl (%eax),%eax
 2aa:	3c 2e                	cmp    $0x2e,%al
 2ac:	74 10                	je     2be <matchhere+0x93>
 2ae:	8b 45 08             	mov    0x8(%ebp),%eax
 2b1:	0f b6 10             	movzbl (%eax),%edx
 2b4:	8b 45 0c             	mov    0xc(%ebp),%eax
 2b7:	0f b6 00             	movzbl (%eax),%eax
 2ba:	38 c2                	cmp    %al,%dl
 2bc:	75 1b                	jne    2d9 <matchhere+0xae>
    return matchhere(re+1, text+1);
 2be:	8b 45 0c             	mov    0xc(%ebp),%eax
 2c1:	8d 50 01             	lea    0x1(%eax),%edx
 2c4:	8b 45 08             	mov    0x8(%ebp),%eax
 2c7:	83 c0 01             	add    $0x1,%eax
 2ca:	83 ec 08             	sub    $0x8,%esp
 2cd:	52                   	push   %edx
 2ce:	50                   	push   %eax
 2cf:	e8 57 ff ff ff       	call   22b <matchhere>
 2d4:	83 c4 10             	add    $0x10,%esp
 2d7:	eb 05                	jmp    2de <matchhere+0xb3>
  return 0;
 2d9:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2de:	c9                   	leave  
 2df:	c3                   	ret    

000002e0 <matchstar>:

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	83 ec 08             	sub    $0x8,%esp
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
 2e6:	83 ec 08             	sub    $0x8,%esp
 2e9:	ff 75 10             	push   0x10(%ebp)
 2ec:	ff 75 0c             	push   0xc(%ebp)
 2ef:	e8 37 ff ff ff       	call   22b <matchhere>
 2f4:	83 c4 10             	add    $0x10,%esp
 2f7:	85 c0                	test   %eax,%eax
 2f9:	74 07                	je     302 <matchstar+0x22>
      return 1;
 2fb:	b8 01 00 00 00       	mov    $0x1,%eax
 300:	eb 29                	jmp    32b <matchstar+0x4b>
  }while(*text!='\0' && (*text++==c || c=='.'));
 302:	8b 45 10             	mov    0x10(%ebp),%eax
 305:	0f b6 00             	movzbl (%eax),%eax
 308:	84 c0                	test   %al,%al
 30a:	74 1a                	je     326 <matchstar+0x46>
 30c:	8b 45 10             	mov    0x10(%ebp),%eax
 30f:	8d 50 01             	lea    0x1(%eax),%edx
 312:	89 55 10             	mov    %edx,0x10(%ebp)
 315:	0f b6 00             	movzbl (%eax),%eax
 318:	0f be c0             	movsbl %al,%eax
 31b:	39 45 08             	cmp    %eax,0x8(%ebp)
 31e:	74 c6                	je     2e6 <matchstar+0x6>
 320:	83 7d 08 2e          	cmpl   $0x2e,0x8(%ebp)
 324:	74 c0                	je     2e6 <matchstar+0x6>
  return 0;
 326:	b8 00 00 00 00       	mov    $0x0,%eax
}
 32b:	c9                   	leave  
 32c:	c3                   	ret    

0000032d <stosb>:
 32d:	55                   	push   %ebp
 32e:	89 e5                	mov    %esp,%ebp
 330:	57                   	push   %edi
 331:	53                   	push   %ebx
 332:	8b 4d 08             	mov    0x8(%ebp),%ecx
 335:	8b 55 10             	mov    0x10(%ebp),%edx
 338:	8b 45 0c             	mov    0xc(%ebp),%eax
 33b:	89 cb                	mov    %ecx,%ebx
 33d:	89 df                	mov    %ebx,%edi
 33f:	89 d1                	mov    %edx,%ecx
 341:	fc                   	cld    
 342:	f3 aa                	rep stos %al,%es:(%edi)
 344:	89 ca                	mov    %ecx,%edx
 346:	89 fb                	mov    %edi,%ebx
 348:	89 5d 08             	mov    %ebx,0x8(%ebp)
 34b:	89 55 10             	mov    %edx,0x10(%ebp)
 34e:	90                   	nop
 34f:	5b                   	pop    %ebx
 350:	5f                   	pop    %edi
 351:	5d                   	pop    %ebp
 352:	c3                   	ret    

00000353 <strcpy>:
 353:	55                   	push   %ebp
 354:	89 e5                	mov    %esp,%ebp
 356:	83 ec 10             	sub    $0x10,%esp
 359:	8b 45 08             	mov    0x8(%ebp),%eax
 35c:	89 45 fc             	mov    %eax,-0x4(%ebp)
 35f:	90                   	nop
 360:	8b 55 0c             	mov    0xc(%ebp),%edx
 363:	8d 42 01             	lea    0x1(%edx),%eax
 366:	89 45 0c             	mov    %eax,0xc(%ebp)
 369:	8b 45 08             	mov    0x8(%ebp),%eax
 36c:	8d 48 01             	lea    0x1(%eax),%ecx
 36f:	89 4d 08             	mov    %ecx,0x8(%ebp)
 372:	0f b6 12             	movzbl (%edx),%edx
 375:	88 10                	mov    %dl,(%eax)
 377:	0f b6 00             	movzbl (%eax),%eax
 37a:	84 c0                	test   %al,%al
 37c:	75 e2                	jne    360 <strcpy+0xd>
 37e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 381:	c9                   	leave  
 382:	c3                   	ret    

00000383 <strcmp>:
 383:	55                   	push   %ebp
 384:	89 e5                	mov    %esp,%ebp
 386:	eb 08                	jmp    390 <strcmp+0xd>
 388:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 38c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
 390:	8b 45 08             	mov    0x8(%ebp),%eax
 393:	0f b6 00             	movzbl (%eax),%eax
 396:	84 c0                	test   %al,%al
 398:	74 10                	je     3aa <strcmp+0x27>
 39a:	8b 45 08             	mov    0x8(%ebp),%eax
 39d:	0f b6 10             	movzbl (%eax),%edx
 3a0:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a3:	0f b6 00             	movzbl (%eax),%eax
 3a6:	38 c2                	cmp    %al,%dl
 3a8:	74 de                	je     388 <strcmp+0x5>
 3aa:	8b 45 08             	mov    0x8(%ebp),%eax
 3ad:	0f b6 00             	movzbl (%eax),%eax
 3b0:	0f b6 d0             	movzbl %al,%edx
 3b3:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b6:	0f b6 00             	movzbl (%eax),%eax
 3b9:	0f b6 c8             	movzbl %al,%ecx
 3bc:	89 d0                	mov    %edx,%eax
 3be:	29 c8                	sub    %ecx,%eax
 3c0:	5d                   	pop    %ebp
 3c1:	c3                   	ret    

000003c2 <strlen>:
 3c2:	55                   	push   %ebp
 3c3:	89 e5                	mov    %esp,%ebp
 3c5:	83 ec 10             	sub    $0x10,%esp
 3c8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 3cf:	eb 04                	jmp    3d5 <strlen+0x13>
 3d1:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 3d5:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3d8:	8b 45 08             	mov    0x8(%ebp),%eax
 3db:	01 d0                	add    %edx,%eax
 3dd:	0f b6 00             	movzbl (%eax),%eax
 3e0:	84 c0                	test   %al,%al
 3e2:	75 ed                	jne    3d1 <strlen+0xf>
 3e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3e7:	c9                   	leave  
 3e8:	c3                   	ret    

000003e9 <memset>:
 3e9:	55                   	push   %ebp
 3ea:	89 e5                	mov    %esp,%ebp
 3ec:	8b 45 10             	mov    0x10(%ebp),%eax
 3ef:	50                   	push   %eax
 3f0:	ff 75 0c             	push   0xc(%ebp)
 3f3:	ff 75 08             	push   0x8(%ebp)
 3f6:	e8 32 ff ff ff       	call   32d <stosb>
 3fb:	83 c4 0c             	add    $0xc,%esp
 3fe:	8b 45 08             	mov    0x8(%ebp),%eax
 401:	c9                   	leave  
 402:	c3                   	ret    

00000403 <strchr>:
 403:	55                   	push   %ebp
 404:	89 e5                	mov    %esp,%ebp
 406:	83 ec 04             	sub    $0x4,%esp
 409:	8b 45 0c             	mov    0xc(%ebp),%eax
 40c:	88 45 fc             	mov    %al,-0x4(%ebp)
 40f:	eb 14                	jmp    425 <strchr+0x22>
 411:	8b 45 08             	mov    0x8(%ebp),%eax
 414:	0f b6 00             	movzbl (%eax),%eax
 417:	38 45 fc             	cmp    %al,-0x4(%ebp)
 41a:	75 05                	jne    421 <strchr+0x1e>
 41c:	8b 45 08             	mov    0x8(%ebp),%eax
 41f:	eb 13                	jmp    434 <strchr+0x31>
 421:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 425:	8b 45 08             	mov    0x8(%ebp),%eax
 428:	0f b6 00             	movzbl (%eax),%eax
 42b:	84 c0                	test   %al,%al
 42d:	75 e2                	jne    411 <strchr+0xe>
 42f:	b8 00 00 00 00       	mov    $0x0,%eax
 434:	c9                   	leave  
 435:	c3                   	ret    

00000436 <gets>:
 436:	55                   	push   %ebp
 437:	89 e5                	mov    %esp,%ebp
 439:	83 ec 18             	sub    $0x18,%esp
 43c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 443:	eb 42                	jmp    487 <gets+0x51>
 445:	83 ec 04             	sub    $0x4,%esp
 448:	6a 01                	push   $0x1
 44a:	8d 45 ef             	lea    -0x11(%ebp),%eax
 44d:	50                   	push   %eax
 44e:	6a 00                	push   $0x0
 450:	e8 a2 01 00 00       	call   5f7 <read>
 455:	83 c4 10             	add    $0x10,%esp
 458:	89 45 f0             	mov    %eax,-0x10(%ebp)
 45b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 45f:	7e 33                	jle    494 <gets+0x5e>
 461:	8b 45 f4             	mov    -0xc(%ebp),%eax
 464:	8d 50 01             	lea    0x1(%eax),%edx
 467:	89 55 f4             	mov    %edx,-0xc(%ebp)
 46a:	89 c2                	mov    %eax,%edx
 46c:	8b 45 08             	mov    0x8(%ebp),%eax
 46f:	01 c2                	add    %eax,%edx
 471:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 475:	88 02                	mov    %al,(%edx)
 477:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 47b:	3c 0a                	cmp    $0xa,%al
 47d:	74 16                	je     495 <gets+0x5f>
 47f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 483:	3c 0d                	cmp    $0xd,%al
 485:	74 0e                	je     495 <gets+0x5f>
 487:	8b 45 f4             	mov    -0xc(%ebp),%eax
 48a:	83 c0 01             	add    $0x1,%eax
 48d:	39 45 0c             	cmp    %eax,0xc(%ebp)
 490:	7f b3                	jg     445 <gets+0xf>
 492:	eb 01                	jmp    495 <gets+0x5f>
 494:	90                   	nop
 495:	8b 55 f4             	mov    -0xc(%ebp),%edx
 498:	8b 45 08             	mov    0x8(%ebp),%eax
 49b:	01 d0                	add    %edx,%eax
 49d:	c6 00 00             	movb   $0x0,(%eax)
 4a0:	8b 45 08             	mov    0x8(%ebp),%eax
 4a3:	c9                   	leave  
 4a4:	c3                   	ret    

000004a5 <stat>:
 4a5:	55                   	push   %ebp
 4a6:	89 e5                	mov    %esp,%ebp
 4a8:	83 ec 18             	sub    $0x18,%esp
 4ab:	83 ec 08             	sub    $0x8,%esp
 4ae:	6a 00                	push   $0x0
 4b0:	ff 75 08             	push   0x8(%ebp)
 4b3:	e8 67 01 00 00       	call   61f <open>
 4b8:	83 c4 10             	add    $0x10,%esp
 4bb:	89 45 f4             	mov    %eax,-0xc(%ebp)
 4be:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4c2:	79 07                	jns    4cb <stat+0x26>
 4c4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4c9:	eb 25                	jmp    4f0 <stat+0x4b>
 4cb:	83 ec 08             	sub    $0x8,%esp
 4ce:	ff 75 0c             	push   0xc(%ebp)
 4d1:	ff 75 f4             	push   -0xc(%ebp)
 4d4:	e8 5e 01 00 00       	call   637 <fstat>
 4d9:	83 c4 10             	add    $0x10,%esp
 4dc:	89 45 f0             	mov    %eax,-0x10(%ebp)
 4df:	83 ec 0c             	sub    $0xc,%esp
 4e2:	ff 75 f4             	push   -0xc(%ebp)
 4e5:	e8 1d 01 00 00       	call   607 <close>
 4ea:	83 c4 10             	add    $0x10,%esp
 4ed:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4f0:	c9                   	leave  
 4f1:	c3                   	ret    

000004f2 <atoi>:
 4f2:	55                   	push   %ebp
 4f3:	89 e5                	mov    %esp,%ebp
 4f5:	83 ec 10             	sub    $0x10,%esp
 4f8:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 4ff:	eb 25                	jmp    526 <atoi+0x34>
 501:	8b 55 fc             	mov    -0x4(%ebp),%edx
 504:	89 d0                	mov    %edx,%eax
 506:	c1 e0 02             	shl    $0x2,%eax
 509:	01 d0                	add    %edx,%eax
 50b:	01 c0                	add    %eax,%eax
 50d:	89 c1                	mov    %eax,%ecx
 50f:	8b 45 08             	mov    0x8(%ebp),%eax
 512:	8d 50 01             	lea    0x1(%eax),%edx
 515:	89 55 08             	mov    %edx,0x8(%ebp)
 518:	0f b6 00             	movzbl (%eax),%eax
 51b:	0f be c0             	movsbl %al,%eax
 51e:	01 c8                	add    %ecx,%eax
 520:	83 e8 30             	sub    $0x30,%eax
 523:	89 45 fc             	mov    %eax,-0x4(%ebp)
 526:	8b 45 08             	mov    0x8(%ebp),%eax
 529:	0f b6 00             	movzbl (%eax),%eax
 52c:	3c 2f                	cmp    $0x2f,%al
 52e:	7e 0a                	jle    53a <atoi+0x48>
 530:	8b 45 08             	mov    0x8(%ebp),%eax
 533:	0f b6 00             	movzbl (%eax),%eax
 536:	3c 39                	cmp    $0x39,%al
 538:	7e c7                	jle    501 <atoi+0xf>
 53a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 53d:	c9                   	leave  
 53e:	c3                   	ret    

0000053f <memmove>:
 53f:	55                   	push   %ebp
 540:	89 e5                	mov    %esp,%ebp
 542:	83 ec 10             	sub    $0x10,%esp
 545:	8b 45 08             	mov    0x8(%ebp),%eax
 548:	89 45 fc             	mov    %eax,-0x4(%ebp)
 54b:	8b 45 0c             	mov    0xc(%ebp),%eax
 54e:	89 45 f8             	mov    %eax,-0x8(%ebp)
 551:	eb 17                	jmp    56a <memmove+0x2b>
 553:	8b 55 f8             	mov    -0x8(%ebp),%edx
 556:	8d 42 01             	lea    0x1(%edx),%eax
 559:	89 45 f8             	mov    %eax,-0x8(%ebp)
 55c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 55f:	8d 48 01             	lea    0x1(%eax),%ecx
 562:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 565:	0f b6 12             	movzbl (%edx),%edx
 568:	88 10                	mov    %dl,(%eax)
 56a:	8b 45 10             	mov    0x10(%ebp),%eax
 56d:	8d 50 ff             	lea    -0x1(%eax),%edx
 570:	89 55 10             	mov    %edx,0x10(%ebp)
 573:	85 c0                	test   %eax,%eax
 575:	7f dc                	jg     553 <memmove+0x14>
 577:	8b 45 08             	mov    0x8(%ebp),%eax
 57a:	c9                   	leave  
 57b:	c3                   	ret    

0000057c <calc>:
 57c:	55                   	push   %ebp
 57d:	89 e5                	mov    %esp,%ebp
 57f:	83 ec 10             	sub    $0x10,%esp
 582:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 589:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
 590:	eb 36                	jmp    5c8 <calc+0x4c>
 592:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 599:	eb 21                	jmp    5bc <calc+0x40>
 59b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5a2:	eb 0c                	jmp    5b0 <calc+0x34>
 5a4:	c1 7d fc 0a          	sarl   $0xa,-0x4(%ebp)
 5a8:	c1 65 fc 0a          	shll   $0xa,-0x4(%ebp)
 5ac:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 5b0:	8b 45 08             	mov    0x8(%ebp),%eax
 5b3:	39 45 f0             	cmp    %eax,-0x10(%ebp)
 5b6:	72 ec                	jb     5a4 <calc+0x28>
 5b8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 5bc:	8b 45 08             	mov    0x8(%ebp),%eax
 5bf:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 5c2:	72 d7                	jb     59b <calc+0x1f>
 5c4:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 5c8:	8b 45 08             	mov    0x8(%ebp),%eax
 5cb:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 5ce:	72 c2                	jb     592 <calc+0x16>
 5d0:	b8 00 00 00 00       	mov    $0x0,%eax
 5d5:	c9                   	leave  
 5d6:	c3                   	ret    

000005d7 <fork>:
 5d7:	b8 01 00 00 00       	mov    $0x1,%eax
 5dc:	cd 40                	int    $0x40
 5de:	c3                   	ret    

000005df <exit>:
 5df:	b8 02 00 00 00       	mov    $0x2,%eax
 5e4:	cd 40                	int    $0x40
 5e6:	c3                   	ret    

000005e7 <wait>:
 5e7:	b8 03 00 00 00       	mov    $0x3,%eax
 5ec:	cd 40                	int    $0x40
 5ee:	c3                   	ret    

000005ef <pipe>:
 5ef:	b8 04 00 00 00       	mov    $0x4,%eax
 5f4:	cd 40                	int    $0x40
 5f6:	c3                   	ret    

000005f7 <read>:
 5f7:	b8 05 00 00 00       	mov    $0x5,%eax
 5fc:	cd 40                	int    $0x40
 5fe:	c3                   	ret    

000005ff <write>:
 5ff:	b8 10 00 00 00       	mov    $0x10,%eax
 604:	cd 40                	int    $0x40
 606:	c3                   	ret    

00000607 <close>:
 607:	b8 15 00 00 00       	mov    $0x15,%eax
 60c:	cd 40                	int    $0x40
 60e:	c3                   	ret    

0000060f <kill>:
 60f:	b8 06 00 00 00       	mov    $0x6,%eax
 614:	cd 40                	int    $0x40
 616:	c3                   	ret    

00000617 <exec>:
 617:	b8 07 00 00 00       	mov    $0x7,%eax
 61c:	cd 40                	int    $0x40
 61e:	c3                   	ret    

0000061f <open>:
 61f:	b8 0f 00 00 00       	mov    $0xf,%eax
 624:	cd 40                	int    $0x40
 626:	c3                   	ret    

00000627 <mknod>:
 627:	b8 11 00 00 00       	mov    $0x11,%eax
 62c:	cd 40                	int    $0x40
 62e:	c3                   	ret    

0000062f <unlink>:
 62f:	b8 12 00 00 00       	mov    $0x12,%eax
 634:	cd 40                	int    $0x40
 636:	c3                   	ret    

00000637 <fstat>:
 637:	b8 08 00 00 00       	mov    $0x8,%eax
 63c:	cd 40                	int    $0x40
 63e:	c3                   	ret    

0000063f <link>:
 63f:	b8 13 00 00 00       	mov    $0x13,%eax
 644:	cd 40                	int    $0x40
 646:	c3                   	ret    

00000647 <mkdir>:
 647:	b8 14 00 00 00       	mov    $0x14,%eax
 64c:	cd 40                	int    $0x40
 64e:	c3                   	ret    

0000064f <chdir>:
 64f:	b8 09 00 00 00       	mov    $0x9,%eax
 654:	cd 40                	int    $0x40
 656:	c3                   	ret    

00000657 <dup>:
 657:	b8 0a 00 00 00       	mov    $0xa,%eax
 65c:	cd 40                	int    $0x40
 65e:	c3                   	ret    

0000065f <getpid>:
 65f:	b8 0b 00 00 00       	mov    $0xb,%eax
 664:	cd 40                	int    $0x40
 666:	c3                   	ret    

00000667 <sbrk>:
 667:	b8 0c 00 00 00       	mov    $0xc,%eax
 66c:	cd 40                	int    $0x40
 66e:	c3                   	ret    

0000066f <sleep>:
 66f:	b8 0d 00 00 00       	mov    $0xd,%eax
 674:	cd 40                	int    $0x40
 676:	c3                   	ret    

00000677 <uptime>:
 677:	b8 0e 00 00 00       	mov    $0xe,%eax
 67c:	cd 40                	int    $0x40
 67e:	c3                   	ret    

0000067f <print_proc>:
 67f:	b8 16 00 00 00       	mov    $0x16,%eax
 684:	cd 40                	int    $0x40
 686:	c3                   	ret    

00000687 <change_queue>:
 687:	b8 17 00 00 00       	mov    $0x17,%eax
 68c:	cd 40                	int    $0x40
 68e:	c3                   	ret    

0000068f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 68f:	55                   	push   %ebp
 690:	89 e5                	mov    %esp,%ebp
 692:	83 ec 18             	sub    $0x18,%esp
 695:	8b 45 0c             	mov    0xc(%ebp),%eax
 698:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 69b:	83 ec 04             	sub    $0x4,%esp
 69e:	6a 01                	push   $0x1
 6a0:	8d 45 f4             	lea    -0xc(%ebp),%eax
 6a3:	50                   	push   %eax
 6a4:	ff 75 08             	push   0x8(%ebp)
 6a7:	e8 53 ff ff ff       	call   5ff <write>
 6ac:	83 c4 10             	add    $0x10,%esp
}
 6af:	90                   	nop
 6b0:	c9                   	leave  
 6b1:	c3                   	ret    

000006b2 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6b2:	55                   	push   %ebp
 6b3:	89 e5                	mov    %esp,%ebp
 6b5:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6b8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 6bf:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 6c3:	74 17                	je     6dc <printint+0x2a>
 6c5:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 6c9:	79 11                	jns    6dc <printint+0x2a>
    neg = 1;
 6cb:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 6d2:	8b 45 0c             	mov    0xc(%ebp),%eax
 6d5:	f7 d8                	neg    %eax
 6d7:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6da:	eb 06                	jmp    6e2 <printint+0x30>
  } else {
    x = xx;
 6dc:	8b 45 0c             	mov    0xc(%ebp),%eax
 6df:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 6e2:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 6e9:	8b 4d 10             	mov    0x10(%ebp),%ecx
 6ec:	8b 45 ec             	mov    -0x14(%ebp),%eax
 6ef:	ba 00 00 00 00       	mov    $0x0,%edx
 6f4:	f7 f1                	div    %ecx
 6f6:	89 d1                	mov    %edx,%ecx
 6f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6fb:	8d 50 01             	lea    0x1(%eax),%edx
 6fe:	89 55 f4             	mov    %edx,-0xc(%ebp)
 701:	0f b6 91 44 0e 00 00 	movzbl 0xe44(%ecx),%edx
 708:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 70c:	8b 4d 10             	mov    0x10(%ebp),%ecx
 70f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 712:	ba 00 00 00 00       	mov    $0x0,%edx
 717:	f7 f1                	div    %ecx
 719:	89 45 ec             	mov    %eax,-0x14(%ebp)
 71c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 720:	75 c7                	jne    6e9 <printint+0x37>
  if(neg)
 722:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 726:	74 2d                	je     755 <printint+0xa3>
    buf[i++] = '-';
 728:	8b 45 f4             	mov    -0xc(%ebp),%eax
 72b:	8d 50 01             	lea    0x1(%eax),%edx
 72e:	89 55 f4             	mov    %edx,-0xc(%ebp)
 731:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 736:	eb 1d                	jmp    755 <printint+0xa3>
    putc(fd, buf[i]);
 738:	8d 55 dc             	lea    -0x24(%ebp),%edx
 73b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 73e:	01 d0                	add    %edx,%eax
 740:	0f b6 00             	movzbl (%eax),%eax
 743:	0f be c0             	movsbl %al,%eax
 746:	83 ec 08             	sub    $0x8,%esp
 749:	50                   	push   %eax
 74a:	ff 75 08             	push   0x8(%ebp)
 74d:	e8 3d ff ff ff       	call   68f <putc>
 752:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 755:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 759:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 75d:	79 d9                	jns    738 <printint+0x86>
}
 75f:	90                   	nop
 760:	90                   	nop
 761:	c9                   	leave  
 762:	c3                   	ret    

00000763 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 763:	55                   	push   %ebp
 764:	89 e5                	mov    %esp,%ebp
 766:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 769:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 770:	8d 45 0c             	lea    0xc(%ebp),%eax
 773:	83 c0 04             	add    $0x4,%eax
 776:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 779:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 780:	e9 59 01 00 00       	jmp    8de <printf+0x17b>
    c = fmt[i] & 0xff;
 785:	8b 55 0c             	mov    0xc(%ebp),%edx
 788:	8b 45 f0             	mov    -0x10(%ebp),%eax
 78b:	01 d0                	add    %edx,%eax
 78d:	0f b6 00             	movzbl (%eax),%eax
 790:	0f be c0             	movsbl %al,%eax
 793:	25 ff 00 00 00       	and    $0xff,%eax
 798:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 79b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 79f:	75 2c                	jne    7cd <printf+0x6a>
      if(c == '%'){
 7a1:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7a5:	75 0c                	jne    7b3 <printf+0x50>
        state = '%';
 7a7:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 7ae:	e9 27 01 00 00       	jmp    8da <printf+0x177>
      } else {
        putc(fd, c);
 7b3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7b6:	0f be c0             	movsbl %al,%eax
 7b9:	83 ec 08             	sub    $0x8,%esp
 7bc:	50                   	push   %eax
 7bd:	ff 75 08             	push   0x8(%ebp)
 7c0:	e8 ca fe ff ff       	call   68f <putc>
 7c5:	83 c4 10             	add    $0x10,%esp
 7c8:	e9 0d 01 00 00       	jmp    8da <printf+0x177>
      }
    } else if(state == '%'){
 7cd:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 7d1:	0f 85 03 01 00 00    	jne    8da <printf+0x177>
      if(c == 'd'){
 7d7:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 7db:	75 1e                	jne    7fb <printf+0x98>
        printint(fd, *ap, 10, 1);
 7dd:	8b 45 e8             	mov    -0x18(%ebp),%eax
 7e0:	8b 00                	mov    (%eax),%eax
 7e2:	6a 01                	push   $0x1
 7e4:	6a 0a                	push   $0xa
 7e6:	50                   	push   %eax
 7e7:	ff 75 08             	push   0x8(%ebp)
 7ea:	e8 c3 fe ff ff       	call   6b2 <printint>
 7ef:	83 c4 10             	add    $0x10,%esp
        ap++;
 7f2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 7f6:	e9 d8 00 00 00       	jmp    8d3 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 7fb:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 7ff:	74 06                	je     807 <printf+0xa4>
 801:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 805:	75 1e                	jne    825 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 807:	8b 45 e8             	mov    -0x18(%ebp),%eax
 80a:	8b 00                	mov    (%eax),%eax
 80c:	6a 00                	push   $0x0
 80e:	6a 10                	push   $0x10
 810:	50                   	push   %eax
 811:	ff 75 08             	push   0x8(%ebp)
 814:	e8 99 fe ff ff       	call   6b2 <printint>
 819:	83 c4 10             	add    $0x10,%esp
        ap++;
 81c:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 820:	e9 ae 00 00 00       	jmp    8d3 <printf+0x170>
      } else if(c == 's'){
 825:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 829:	75 43                	jne    86e <printf+0x10b>
        s = (char*)*ap;
 82b:	8b 45 e8             	mov    -0x18(%ebp),%eax
 82e:	8b 00                	mov    (%eax),%eax
 830:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 833:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 837:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 83b:	75 25                	jne    862 <printf+0xff>
          s = "(null)";
 83d:	c7 45 f4 52 0b 00 00 	movl   $0xb52,-0xc(%ebp)
        while(*s != 0){
 844:	eb 1c                	jmp    862 <printf+0xff>
          putc(fd, *s);
 846:	8b 45 f4             	mov    -0xc(%ebp),%eax
 849:	0f b6 00             	movzbl (%eax),%eax
 84c:	0f be c0             	movsbl %al,%eax
 84f:	83 ec 08             	sub    $0x8,%esp
 852:	50                   	push   %eax
 853:	ff 75 08             	push   0x8(%ebp)
 856:	e8 34 fe ff ff       	call   68f <putc>
 85b:	83 c4 10             	add    $0x10,%esp
          s++;
 85e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 862:	8b 45 f4             	mov    -0xc(%ebp),%eax
 865:	0f b6 00             	movzbl (%eax),%eax
 868:	84 c0                	test   %al,%al
 86a:	75 da                	jne    846 <printf+0xe3>
 86c:	eb 65                	jmp    8d3 <printf+0x170>
        }
      } else if(c == 'c'){
 86e:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 872:	75 1d                	jne    891 <printf+0x12e>
        putc(fd, *ap);
 874:	8b 45 e8             	mov    -0x18(%ebp),%eax
 877:	8b 00                	mov    (%eax),%eax
 879:	0f be c0             	movsbl %al,%eax
 87c:	83 ec 08             	sub    $0x8,%esp
 87f:	50                   	push   %eax
 880:	ff 75 08             	push   0x8(%ebp)
 883:	e8 07 fe ff ff       	call   68f <putc>
 888:	83 c4 10             	add    $0x10,%esp
        ap++;
 88b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 88f:	eb 42                	jmp    8d3 <printf+0x170>
      } else if(c == '%'){
 891:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 895:	75 17                	jne    8ae <printf+0x14b>
        putc(fd, c);
 897:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 89a:	0f be c0             	movsbl %al,%eax
 89d:	83 ec 08             	sub    $0x8,%esp
 8a0:	50                   	push   %eax
 8a1:	ff 75 08             	push   0x8(%ebp)
 8a4:	e8 e6 fd ff ff       	call   68f <putc>
 8a9:	83 c4 10             	add    $0x10,%esp
 8ac:	eb 25                	jmp    8d3 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8ae:	83 ec 08             	sub    $0x8,%esp
 8b1:	6a 25                	push   $0x25
 8b3:	ff 75 08             	push   0x8(%ebp)
 8b6:	e8 d4 fd ff ff       	call   68f <putc>
 8bb:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 8be:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8c1:	0f be c0             	movsbl %al,%eax
 8c4:	83 ec 08             	sub    $0x8,%esp
 8c7:	50                   	push   %eax
 8c8:	ff 75 08             	push   0x8(%ebp)
 8cb:	e8 bf fd ff ff       	call   68f <putc>
 8d0:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 8d3:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 8da:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 8de:	8b 55 0c             	mov    0xc(%ebp),%edx
 8e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8e4:	01 d0                	add    %edx,%eax
 8e6:	0f b6 00             	movzbl (%eax),%eax
 8e9:	84 c0                	test   %al,%al
 8eb:	0f 85 94 fe ff ff    	jne    785 <printf+0x22>
    }
  }
}
 8f1:	90                   	nop
 8f2:	90                   	nop
 8f3:	c9                   	leave  
 8f4:	c3                   	ret    

000008f5 <free>:
 8f5:	55                   	push   %ebp
 8f6:	89 e5                	mov    %esp,%ebp
 8f8:	83 ec 10             	sub    $0x10,%esp
 8fb:	8b 45 08             	mov    0x8(%ebp),%eax
 8fe:	83 e8 08             	sub    $0x8,%eax
 901:	89 45 f8             	mov    %eax,-0x8(%ebp)
 904:	a1 68 12 00 00       	mov    0x1268,%eax
 909:	89 45 fc             	mov    %eax,-0x4(%ebp)
 90c:	eb 24                	jmp    932 <free+0x3d>
 90e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 911:	8b 00                	mov    (%eax),%eax
 913:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 916:	72 12                	jb     92a <free+0x35>
 918:	8b 45 f8             	mov    -0x8(%ebp),%eax
 91b:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 91e:	77 24                	ja     944 <free+0x4f>
 920:	8b 45 fc             	mov    -0x4(%ebp),%eax
 923:	8b 00                	mov    (%eax),%eax
 925:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 928:	72 1a                	jb     944 <free+0x4f>
 92a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 92d:	8b 00                	mov    (%eax),%eax
 92f:	89 45 fc             	mov    %eax,-0x4(%ebp)
 932:	8b 45 f8             	mov    -0x8(%ebp),%eax
 935:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 938:	76 d4                	jbe    90e <free+0x19>
 93a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 93d:	8b 00                	mov    (%eax),%eax
 93f:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 942:	73 ca                	jae    90e <free+0x19>
 944:	8b 45 f8             	mov    -0x8(%ebp),%eax
 947:	8b 40 04             	mov    0x4(%eax),%eax
 94a:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 951:	8b 45 f8             	mov    -0x8(%ebp),%eax
 954:	01 c2                	add    %eax,%edx
 956:	8b 45 fc             	mov    -0x4(%ebp),%eax
 959:	8b 00                	mov    (%eax),%eax
 95b:	39 c2                	cmp    %eax,%edx
 95d:	75 24                	jne    983 <free+0x8e>
 95f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 962:	8b 50 04             	mov    0x4(%eax),%edx
 965:	8b 45 fc             	mov    -0x4(%ebp),%eax
 968:	8b 00                	mov    (%eax),%eax
 96a:	8b 40 04             	mov    0x4(%eax),%eax
 96d:	01 c2                	add    %eax,%edx
 96f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 972:	89 50 04             	mov    %edx,0x4(%eax)
 975:	8b 45 fc             	mov    -0x4(%ebp),%eax
 978:	8b 00                	mov    (%eax),%eax
 97a:	8b 10                	mov    (%eax),%edx
 97c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 97f:	89 10                	mov    %edx,(%eax)
 981:	eb 0a                	jmp    98d <free+0x98>
 983:	8b 45 fc             	mov    -0x4(%ebp),%eax
 986:	8b 10                	mov    (%eax),%edx
 988:	8b 45 f8             	mov    -0x8(%ebp),%eax
 98b:	89 10                	mov    %edx,(%eax)
 98d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 990:	8b 40 04             	mov    0x4(%eax),%eax
 993:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 99a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 99d:	01 d0                	add    %edx,%eax
 99f:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 9a2:	75 20                	jne    9c4 <free+0xcf>
 9a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9a7:	8b 50 04             	mov    0x4(%eax),%edx
 9aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9ad:	8b 40 04             	mov    0x4(%eax),%eax
 9b0:	01 c2                	add    %eax,%edx
 9b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9b5:	89 50 04             	mov    %edx,0x4(%eax)
 9b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9bb:	8b 10                	mov    (%eax),%edx
 9bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9c0:	89 10                	mov    %edx,(%eax)
 9c2:	eb 08                	jmp    9cc <free+0xd7>
 9c4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9c7:	8b 55 f8             	mov    -0x8(%ebp),%edx
 9ca:	89 10                	mov    %edx,(%eax)
 9cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9cf:	a3 68 12 00 00       	mov    %eax,0x1268
 9d4:	90                   	nop
 9d5:	c9                   	leave  
 9d6:	c3                   	ret    

000009d7 <morecore>:
 9d7:	55                   	push   %ebp
 9d8:	89 e5                	mov    %esp,%ebp
 9da:	83 ec 18             	sub    $0x18,%esp
 9dd:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 9e4:	77 07                	ja     9ed <morecore+0x16>
 9e6:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
 9ed:	8b 45 08             	mov    0x8(%ebp),%eax
 9f0:	c1 e0 03             	shl    $0x3,%eax
 9f3:	83 ec 0c             	sub    $0xc,%esp
 9f6:	50                   	push   %eax
 9f7:	e8 6b fc ff ff       	call   667 <sbrk>
 9fc:	83 c4 10             	add    $0x10,%esp
 9ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a02:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 a06:	75 07                	jne    a0f <morecore+0x38>
 a08:	b8 00 00 00 00       	mov    $0x0,%eax
 a0d:	eb 26                	jmp    a35 <morecore+0x5e>
 a0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a12:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a15:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a18:	8b 55 08             	mov    0x8(%ebp),%edx
 a1b:	89 50 04             	mov    %edx,0x4(%eax)
 a1e:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a21:	83 c0 08             	add    $0x8,%eax
 a24:	83 ec 0c             	sub    $0xc,%esp
 a27:	50                   	push   %eax
 a28:	e8 c8 fe ff ff       	call   8f5 <free>
 a2d:	83 c4 10             	add    $0x10,%esp
 a30:	a1 68 12 00 00       	mov    0x1268,%eax
 a35:	c9                   	leave  
 a36:	c3                   	ret    

00000a37 <malloc>:
 a37:	55                   	push   %ebp
 a38:	89 e5                	mov    %esp,%ebp
 a3a:	83 ec 18             	sub    $0x18,%esp
 a3d:	8b 45 08             	mov    0x8(%ebp),%eax
 a40:	83 c0 07             	add    $0x7,%eax
 a43:	c1 e8 03             	shr    $0x3,%eax
 a46:	83 c0 01             	add    $0x1,%eax
 a49:	89 45 ec             	mov    %eax,-0x14(%ebp)
 a4c:	a1 68 12 00 00       	mov    0x1268,%eax
 a51:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a54:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 a58:	75 23                	jne    a7d <malloc+0x46>
 a5a:	c7 45 f0 60 12 00 00 	movl   $0x1260,-0x10(%ebp)
 a61:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a64:	a3 68 12 00 00       	mov    %eax,0x1268
 a69:	a1 68 12 00 00       	mov    0x1268,%eax
 a6e:	a3 60 12 00 00       	mov    %eax,0x1260
 a73:	c7 05 64 12 00 00 00 	movl   $0x0,0x1264
 a7a:	00 00 00 
 a7d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a80:	8b 00                	mov    (%eax),%eax
 a82:	89 45 f4             	mov    %eax,-0xc(%ebp)
 a85:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a88:	8b 40 04             	mov    0x4(%eax),%eax
 a8b:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 a8e:	77 4d                	ja     add <malloc+0xa6>
 a90:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a93:	8b 40 04             	mov    0x4(%eax),%eax
 a96:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 a99:	75 0c                	jne    aa7 <malloc+0x70>
 a9b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a9e:	8b 10                	mov    (%eax),%edx
 aa0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 aa3:	89 10                	mov    %edx,(%eax)
 aa5:	eb 26                	jmp    acd <malloc+0x96>
 aa7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aaa:	8b 40 04             	mov    0x4(%eax),%eax
 aad:	2b 45 ec             	sub    -0x14(%ebp),%eax
 ab0:	89 c2                	mov    %eax,%edx
 ab2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ab5:	89 50 04             	mov    %edx,0x4(%eax)
 ab8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 abb:	8b 40 04             	mov    0x4(%eax),%eax
 abe:	c1 e0 03             	shl    $0x3,%eax
 ac1:	01 45 f4             	add    %eax,-0xc(%ebp)
 ac4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ac7:	8b 55 ec             	mov    -0x14(%ebp),%edx
 aca:	89 50 04             	mov    %edx,0x4(%eax)
 acd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ad0:	a3 68 12 00 00       	mov    %eax,0x1268
 ad5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ad8:	83 c0 08             	add    $0x8,%eax
 adb:	eb 3b                	jmp    b18 <malloc+0xe1>
 add:	a1 68 12 00 00       	mov    0x1268,%eax
 ae2:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 ae5:	75 1e                	jne    b05 <malloc+0xce>
 ae7:	83 ec 0c             	sub    $0xc,%esp
 aea:	ff 75 ec             	push   -0x14(%ebp)
 aed:	e8 e5 fe ff ff       	call   9d7 <morecore>
 af2:	83 c4 10             	add    $0x10,%esp
 af5:	89 45 f4             	mov    %eax,-0xc(%ebp)
 af8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 afc:	75 07                	jne    b05 <malloc+0xce>
 afe:	b8 00 00 00 00       	mov    $0x0,%eax
 b03:	eb 13                	jmp    b18 <malloc+0xe1>
 b05:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b08:	89 45 f0             	mov    %eax,-0x10(%ebp)
 b0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b0e:	8b 00                	mov    (%eax),%eax
 b10:	89 45 f4             	mov    %eax,-0xc(%ebp)
 b13:	e9 6d ff ff ff       	jmp    a85 <malloc+0x4e>
 b18:	c9                   	leave  
 b19:	c3                   	ret    
