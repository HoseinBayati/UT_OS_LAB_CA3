
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 14             	sub    $0x14,%esp
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
  11:	83 ec 08             	sub    $0x8,%esp
  14:	6a 02                	push   $0x2
  16:	68 01 09 00 00       	push   $0x901
  1b:	e8 d3 03 00 00       	call   3f3 <open>
  20:	83 c4 10             	add    $0x10,%esp
  23:	85 c0                	test   %eax,%eax
  25:	79 26                	jns    4d <main+0x4d>
    mknod("console", 1, 1);
  27:	83 ec 04             	sub    $0x4,%esp
  2a:	6a 01                	push   $0x1
  2c:	6a 01                	push   $0x1
  2e:	68 01 09 00 00       	push   $0x901
  33:	e8 c3 03 00 00       	call   3fb <mknod>
  38:	83 c4 10             	add    $0x10,%esp
    open("console", O_RDWR);
  3b:	83 ec 08             	sub    $0x8,%esp
  3e:	6a 02                	push   $0x2
  40:	68 01 09 00 00       	push   $0x901
  45:	e8 a9 03 00 00       	call   3f3 <open>
  4a:	83 c4 10             	add    $0x10,%esp
  }
  dup(0);  // stdout
  4d:	83 ec 0c             	sub    $0xc,%esp
  50:	6a 00                	push   $0x0
  52:	e8 d4 03 00 00       	call   42b <dup>
  57:	83 c4 10             	add    $0x10,%esp
  dup(0);  // stderr
  5a:	83 ec 0c             	sub    $0xc,%esp
  5d:	6a 00                	push   $0x0
  5f:	e8 c7 03 00 00       	call   42b <dup>
  64:	83 c4 10             	add    $0x10,%esp

  for(;;){
    printf(1, "init: starting sh\n");
  67:	83 ec 08             	sub    $0x8,%esp
  6a:	68 09 09 00 00       	push   $0x909
  6f:	6a 01                	push   $0x1
  71:	e8 d1 04 00 00       	call   547 <printf>
  76:	83 c4 10             	add    $0x10,%esp
    pid = fork();
  79:	e8 2d 03 00 00       	call   3ab <fork>
  7e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(pid < 0){
  81:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  85:	79 17                	jns    9e <main+0x9e>
      printf(1, "init: fork failed\n");
  87:	83 ec 08             	sub    $0x8,%esp
  8a:	68 1c 09 00 00       	push   $0x91c
  8f:	6a 01                	push   $0x1
  91:	e8 b1 04 00 00       	call   547 <printf>
  96:	83 c4 10             	add    $0x10,%esp
      exit();
  99:	e8 15 03 00 00       	call   3b3 <exit>
    }
    if(pid == 0){
  9e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  a2:	75 3e                	jne    e2 <main+0xe2>
      exec("sh", argv);
  a4:	83 ec 08             	sub    $0x8,%esp
  a7:	68 bc 0b 00 00       	push   $0xbbc
  ac:	68 fe 08 00 00       	push   $0x8fe
  b1:	e8 35 03 00 00       	call   3eb <exec>
  b6:	83 c4 10             	add    $0x10,%esp
      printf(1, "init: exec sh failed\n");
  b9:	83 ec 08             	sub    $0x8,%esp
  bc:	68 2f 09 00 00       	push   $0x92f
  c1:	6a 01                	push   $0x1
  c3:	e8 7f 04 00 00       	call   547 <printf>
  c8:	83 c4 10             	add    $0x10,%esp
      exit();
  cb:	e8 e3 02 00 00       	call   3b3 <exit>
    }
    while((wpid=wait()) >= 0 && wpid != pid)
      printf(1, "zombie!\n");
  d0:	83 ec 08             	sub    $0x8,%esp
  d3:	68 45 09 00 00       	push   $0x945
  d8:	6a 01                	push   $0x1
  da:	e8 68 04 00 00       	call   547 <printf>
  df:	83 c4 10             	add    $0x10,%esp
    while((wpid=wait()) >= 0 && wpid != pid)
  e2:	e8 d4 02 00 00       	call   3bb <wait>
  e7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  ea:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  ee:	0f 88 73 ff ff ff    	js     67 <main+0x67>
  f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
  f7:	3b 45 f4             	cmp    -0xc(%ebp),%eax
  fa:	75 d4                	jne    d0 <main+0xd0>
    printf(1, "init: starting sh\n");
  fc:	e9 66 ff ff ff       	jmp    67 <main+0x67>

00000101 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 101:	55                   	push   %ebp
 102:	89 e5                	mov    %esp,%ebp
 104:	57                   	push   %edi
 105:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 106:	8b 4d 08             	mov    0x8(%ebp),%ecx
 109:	8b 55 10             	mov    0x10(%ebp),%edx
 10c:	8b 45 0c             	mov    0xc(%ebp),%eax
 10f:	89 cb                	mov    %ecx,%ebx
 111:	89 df                	mov    %ebx,%edi
 113:	89 d1                	mov    %edx,%ecx
 115:	fc                   	cld    
 116:	f3 aa                	rep stos %al,%es:(%edi)
 118:	89 ca                	mov    %ecx,%edx
 11a:	89 fb                	mov    %edi,%ebx
 11c:	89 5d 08             	mov    %ebx,0x8(%ebp)
 11f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 122:	90                   	nop
 123:	5b                   	pop    %ebx
 124:	5f                   	pop    %edi
 125:	5d                   	pop    %ebp
 126:	c3                   	ret    

00000127 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 127:	55                   	push   %ebp
 128:	89 e5                	mov    %esp,%ebp
 12a:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 12d:	8b 45 08             	mov    0x8(%ebp),%eax
 130:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 133:	90                   	nop
 134:	8b 55 0c             	mov    0xc(%ebp),%edx
 137:	8d 42 01             	lea    0x1(%edx),%eax
 13a:	89 45 0c             	mov    %eax,0xc(%ebp)
 13d:	8b 45 08             	mov    0x8(%ebp),%eax
 140:	8d 48 01             	lea    0x1(%eax),%ecx
 143:	89 4d 08             	mov    %ecx,0x8(%ebp)
 146:	0f b6 12             	movzbl (%edx),%edx
 149:	88 10                	mov    %dl,(%eax)
 14b:	0f b6 00             	movzbl (%eax),%eax
 14e:	84 c0                	test   %al,%al
 150:	75 e2                	jne    134 <strcpy+0xd>
    ;
  return os;
 152:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 155:	c9                   	leave  
 156:	c3                   	ret    

00000157 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 157:	55                   	push   %ebp
 158:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 15a:	eb 08                	jmp    164 <strcmp+0xd>
    p++, q++;
 15c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 160:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 164:	8b 45 08             	mov    0x8(%ebp),%eax
 167:	0f b6 00             	movzbl (%eax),%eax
 16a:	84 c0                	test   %al,%al
 16c:	74 10                	je     17e <strcmp+0x27>
 16e:	8b 45 08             	mov    0x8(%ebp),%eax
 171:	0f b6 10             	movzbl (%eax),%edx
 174:	8b 45 0c             	mov    0xc(%ebp),%eax
 177:	0f b6 00             	movzbl (%eax),%eax
 17a:	38 c2                	cmp    %al,%dl
 17c:	74 de                	je     15c <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 17e:	8b 45 08             	mov    0x8(%ebp),%eax
 181:	0f b6 00             	movzbl (%eax),%eax
 184:	0f b6 d0             	movzbl %al,%edx
 187:	8b 45 0c             	mov    0xc(%ebp),%eax
 18a:	0f b6 00             	movzbl (%eax),%eax
 18d:	0f b6 c8             	movzbl %al,%ecx
 190:	89 d0                	mov    %edx,%eax
 192:	29 c8                	sub    %ecx,%eax
}
 194:	5d                   	pop    %ebp
 195:	c3                   	ret    

00000196 <strlen>:

uint
strlen(const char *s)
{
 196:	55                   	push   %ebp
 197:	89 e5                	mov    %esp,%ebp
 199:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 19c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1a3:	eb 04                	jmp    1a9 <strlen+0x13>
 1a5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1a9:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1ac:	8b 45 08             	mov    0x8(%ebp),%eax
 1af:	01 d0                	add    %edx,%eax
 1b1:	0f b6 00             	movzbl (%eax),%eax
 1b4:	84 c0                	test   %al,%al
 1b6:	75 ed                	jne    1a5 <strlen+0xf>
    ;
  return n;
 1b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1bb:	c9                   	leave  
 1bc:	c3                   	ret    

000001bd <memset>:

void*
memset(void *dst, int c, uint n)
{
 1bd:	55                   	push   %ebp
 1be:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1c0:	8b 45 10             	mov    0x10(%ebp),%eax
 1c3:	50                   	push   %eax
 1c4:	ff 75 0c             	push   0xc(%ebp)
 1c7:	ff 75 08             	push   0x8(%ebp)
 1ca:	e8 32 ff ff ff       	call   101 <stosb>
 1cf:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1d2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1d5:	c9                   	leave  
 1d6:	c3                   	ret    

000001d7 <strchr>:

char*
strchr(const char *s, char c)
{
 1d7:	55                   	push   %ebp
 1d8:	89 e5                	mov    %esp,%ebp
 1da:	83 ec 04             	sub    $0x4,%esp
 1dd:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e0:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1e3:	eb 14                	jmp    1f9 <strchr+0x22>
    if(*s == c)
 1e5:	8b 45 08             	mov    0x8(%ebp),%eax
 1e8:	0f b6 00             	movzbl (%eax),%eax
 1eb:	38 45 fc             	cmp    %al,-0x4(%ebp)
 1ee:	75 05                	jne    1f5 <strchr+0x1e>
      return (char*)s;
 1f0:	8b 45 08             	mov    0x8(%ebp),%eax
 1f3:	eb 13                	jmp    208 <strchr+0x31>
  for(; *s; s++)
 1f5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1f9:	8b 45 08             	mov    0x8(%ebp),%eax
 1fc:	0f b6 00             	movzbl (%eax),%eax
 1ff:	84 c0                	test   %al,%al
 201:	75 e2                	jne    1e5 <strchr+0xe>
  return 0;
 203:	b8 00 00 00 00       	mov    $0x0,%eax
}
 208:	c9                   	leave  
 209:	c3                   	ret    

0000020a <gets>:

char*
gets(char *buf, int max)
{
 20a:	55                   	push   %ebp
 20b:	89 e5                	mov    %esp,%ebp
 20d:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 210:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 217:	eb 42                	jmp    25b <gets+0x51>
    cc = read(0, &c, 1);
 219:	83 ec 04             	sub    $0x4,%esp
 21c:	6a 01                	push   $0x1
 21e:	8d 45 ef             	lea    -0x11(%ebp),%eax
 221:	50                   	push   %eax
 222:	6a 00                	push   $0x0
 224:	e8 a2 01 00 00       	call   3cb <read>
 229:	83 c4 10             	add    $0x10,%esp
 22c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 22f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 233:	7e 33                	jle    268 <gets+0x5e>
      break;
    buf[i++] = c;
 235:	8b 45 f4             	mov    -0xc(%ebp),%eax
 238:	8d 50 01             	lea    0x1(%eax),%edx
 23b:	89 55 f4             	mov    %edx,-0xc(%ebp)
 23e:	89 c2                	mov    %eax,%edx
 240:	8b 45 08             	mov    0x8(%ebp),%eax
 243:	01 c2                	add    %eax,%edx
 245:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 249:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 24b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 24f:	3c 0a                	cmp    $0xa,%al
 251:	74 16                	je     269 <gets+0x5f>
 253:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 257:	3c 0d                	cmp    $0xd,%al
 259:	74 0e                	je     269 <gets+0x5f>
  for(i=0; i+1 < max; ){
 25b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 25e:	83 c0 01             	add    $0x1,%eax
 261:	39 45 0c             	cmp    %eax,0xc(%ebp)
 264:	7f b3                	jg     219 <gets+0xf>
 266:	eb 01                	jmp    269 <gets+0x5f>
      break;
 268:	90                   	nop
      break;
  }
  buf[i] = '\0';
 269:	8b 55 f4             	mov    -0xc(%ebp),%edx
 26c:	8b 45 08             	mov    0x8(%ebp),%eax
 26f:	01 d0                	add    %edx,%eax
 271:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 274:	8b 45 08             	mov    0x8(%ebp),%eax
}
 277:	c9                   	leave  
 278:	c3                   	ret    

00000279 <stat>:

int
stat(const char *n, struct stat *st)
{
 279:	55                   	push   %ebp
 27a:	89 e5                	mov    %esp,%ebp
 27c:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 27f:	83 ec 08             	sub    $0x8,%esp
 282:	6a 00                	push   $0x0
 284:	ff 75 08             	push   0x8(%ebp)
 287:	e8 67 01 00 00       	call   3f3 <open>
 28c:	83 c4 10             	add    $0x10,%esp
 28f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 292:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 296:	79 07                	jns    29f <stat+0x26>
    return -1;
 298:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 29d:	eb 25                	jmp    2c4 <stat+0x4b>
  r = fstat(fd, st);
 29f:	83 ec 08             	sub    $0x8,%esp
 2a2:	ff 75 0c             	push   0xc(%ebp)
 2a5:	ff 75 f4             	push   -0xc(%ebp)
 2a8:	e8 5e 01 00 00       	call   40b <fstat>
 2ad:	83 c4 10             	add    $0x10,%esp
 2b0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2b3:	83 ec 0c             	sub    $0xc,%esp
 2b6:	ff 75 f4             	push   -0xc(%ebp)
 2b9:	e8 1d 01 00 00       	call   3db <close>
 2be:	83 c4 10             	add    $0x10,%esp
  return r;
 2c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2c4:	c9                   	leave  
 2c5:	c3                   	ret    

000002c6 <atoi>:

int
atoi(const char *s)
{
 2c6:	55                   	push   %ebp
 2c7:	89 e5                	mov    %esp,%ebp
 2c9:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2cc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2d3:	eb 25                	jmp    2fa <atoi+0x34>
    n = n*10 + *s++ - '0';
 2d5:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2d8:	89 d0                	mov    %edx,%eax
 2da:	c1 e0 02             	shl    $0x2,%eax
 2dd:	01 d0                	add    %edx,%eax
 2df:	01 c0                	add    %eax,%eax
 2e1:	89 c1                	mov    %eax,%ecx
 2e3:	8b 45 08             	mov    0x8(%ebp),%eax
 2e6:	8d 50 01             	lea    0x1(%eax),%edx
 2e9:	89 55 08             	mov    %edx,0x8(%ebp)
 2ec:	0f b6 00             	movzbl (%eax),%eax
 2ef:	0f be c0             	movsbl %al,%eax
 2f2:	01 c8                	add    %ecx,%eax
 2f4:	83 e8 30             	sub    $0x30,%eax
 2f7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2fa:	8b 45 08             	mov    0x8(%ebp),%eax
 2fd:	0f b6 00             	movzbl (%eax),%eax
 300:	3c 2f                	cmp    $0x2f,%al
 302:	7e 0a                	jle    30e <atoi+0x48>
 304:	8b 45 08             	mov    0x8(%ebp),%eax
 307:	0f b6 00             	movzbl (%eax),%eax
 30a:	3c 39                	cmp    $0x39,%al
 30c:	7e c7                	jle    2d5 <atoi+0xf>
  return n;
 30e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 311:	c9                   	leave  
 312:	c3                   	ret    

00000313 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 313:	55                   	push   %ebp
 314:	89 e5                	mov    %esp,%ebp
 316:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
 319:	8b 45 08             	mov    0x8(%ebp),%eax
 31c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 31f:	8b 45 0c             	mov    0xc(%ebp),%eax
 322:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 325:	eb 17                	jmp    33e <memmove+0x2b>
    *dst++ = *src++;
 327:	8b 55 f8             	mov    -0x8(%ebp),%edx
 32a:	8d 42 01             	lea    0x1(%edx),%eax
 32d:	89 45 f8             	mov    %eax,-0x8(%ebp)
 330:	8b 45 fc             	mov    -0x4(%ebp),%eax
 333:	8d 48 01             	lea    0x1(%eax),%ecx
 336:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 339:	0f b6 12             	movzbl (%edx),%edx
 33c:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 33e:	8b 45 10             	mov    0x10(%ebp),%eax
 341:	8d 50 ff             	lea    -0x1(%eax),%edx
 344:	89 55 10             	mov    %edx,0x10(%ebp)
 347:	85 c0                	test   %eax,%eax
 349:	7f dc                	jg     327 <memmove+0x14>
  return vdst;
 34b:	8b 45 08             	mov    0x8(%ebp),%eax
}
 34e:	c9                   	leave  
 34f:	c3                   	ret    

00000350 <calc>:

int calc(int num)
{
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	83 ec 10             	sub    $0x10,%esp
    int c = 0;
 356:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for(uint i = 0; i < num; i++)
 35d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
 364:	eb 36                	jmp    39c <calc+0x4c>
    {
        for(uint j = 0; j < num; j++)
 366:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 36d:	eb 21                	jmp    390 <calc+0x40>
        {
            for(uint k = 0; k < num; j++)
 36f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 376:	eb 0c                	jmp    384 <calc+0x34>
            {
                c >>= 10;
 378:	c1 7d fc 0a          	sarl   $0xa,-0x4(%ebp)
                c <<= 10;
 37c:	c1 65 fc 0a          	shll   $0xa,-0x4(%ebp)
            for(uint k = 0; k < num; j++)
 380:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 384:	8b 45 08             	mov    0x8(%ebp),%eax
 387:	39 45 f0             	cmp    %eax,-0x10(%ebp)
 38a:	72 ec                	jb     378 <calc+0x28>
        for(uint j = 0; j < num; j++)
 38c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 390:	8b 45 08             	mov    0x8(%ebp),%eax
 393:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 396:	72 d7                	jb     36f <calc+0x1f>
    for(uint i = 0; i < num; i++)
 398:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 39c:	8b 45 08             	mov    0x8(%ebp),%eax
 39f:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 3a2:	72 c2                	jb     366 <calc+0x16>
            }
        }
    }
    return 0;
 3a4:	b8 00 00 00 00       	mov    $0x0,%eax
}
 3a9:	c9                   	leave  
 3aa:	c3                   	ret    

000003ab <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3ab:	b8 01 00 00 00       	mov    $0x1,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <exit>:
SYSCALL(exit)
 3b3:	b8 02 00 00 00       	mov    $0x2,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <wait>:
SYSCALL(wait)
 3bb:	b8 03 00 00 00       	mov    $0x3,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <pipe>:
SYSCALL(pipe)
 3c3:	b8 04 00 00 00       	mov    $0x4,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <read>:
SYSCALL(read)
 3cb:	b8 05 00 00 00       	mov    $0x5,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <write>:
SYSCALL(write)
 3d3:	b8 10 00 00 00       	mov    $0x10,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <close>:
SYSCALL(close)
 3db:	b8 15 00 00 00       	mov    $0x15,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <kill>:
SYSCALL(kill)
 3e3:	b8 06 00 00 00       	mov    $0x6,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <exec>:
SYSCALL(exec)
 3eb:	b8 07 00 00 00       	mov    $0x7,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <open>:
SYSCALL(open)
 3f3:	b8 0f 00 00 00       	mov    $0xf,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <mknod>:
SYSCALL(mknod)
 3fb:	b8 11 00 00 00       	mov    $0x11,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <unlink>:
SYSCALL(unlink)
 403:	b8 12 00 00 00       	mov    $0x12,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <fstat>:
SYSCALL(fstat)
 40b:	b8 08 00 00 00       	mov    $0x8,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <link>:
SYSCALL(link)
 413:	b8 13 00 00 00       	mov    $0x13,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <mkdir>:
SYSCALL(mkdir)
 41b:	b8 14 00 00 00       	mov    $0x14,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <chdir>:
SYSCALL(chdir)
 423:	b8 09 00 00 00       	mov    $0x9,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <dup>:
SYSCALL(dup)
 42b:	b8 0a 00 00 00       	mov    $0xa,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <getpid>:
SYSCALL(getpid)
 433:	b8 0b 00 00 00       	mov    $0xb,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <sbrk>:
SYSCALL(sbrk)
 43b:	b8 0c 00 00 00       	mov    $0xc,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <sleep>:
SYSCALL(sleep)
 443:	b8 0d 00 00 00       	mov    $0xd,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <uptime>:
SYSCALL(uptime)
 44b:	b8 0e 00 00 00       	mov    $0xe,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <print_proc>:
SYSCALL(print_proc)
 453:	b8 16 00 00 00       	mov    $0x16,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <change_queue>:
SYSCALL(change_queue)
 45b:	b8 17 00 00 00       	mov    $0x17,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <change_local_bjf>:
SYSCALL(change_local_bjf)
 463:	b8 18 00 00 00       	mov    $0x18,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <change_global_bjf>:
SYSCALL(change_global_bjf)
 46b:	b8 19 00 00 00       	mov    $0x19,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 473:	55                   	push   %ebp
 474:	89 e5                	mov    %esp,%ebp
 476:	83 ec 18             	sub    $0x18,%esp
 479:	8b 45 0c             	mov    0xc(%ebp),%eax
 47c:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 47f:	83 ec 04             	sub    $0x4,%esp
 482:	6a 01                	push   $0x1
 484:	8d 45 f4             	lea    -0xc(%ebp),%eax
 487:	50                   	push   %eax
 488:	ff 75 08             	push   0x8(%ebp)
 48b:	e8 43 ff ff ff       	call   3d3 <write>
 490:	83 c4 10             	add    $0x10,%esp
}
 493:	90                   	nop
 494:	c9                   	leave  
 495:	c3                   	ret    

00000496 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 496:	55                   	push   %ebp
 497:	89 e5                	mov    %esp,%ebp
 499:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 49c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4a3:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4a7:	74 17                	je     4c0 <printint+0x2a>
 4a9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4ad:	79 11                	jns    4c0 <printint+0x2a>
    neg = 1;
 4af:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4b6:	8b 45 0c             	mov    0xc(%ebp),%eax
 4b9:	f7 d8                	neg    %eax
 4bb:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4be:	eb 06                	jmp    4c6 <printint+0x30>
  } else {
    x = xx;
 4c0:	8b 45 0c             	mov    0xc(%ebp),%eax
 4c3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4c6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4cd:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4d0:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4d3:	ba 00 00 00 00       	mov    $0x0,%edx
 4d8:	f7 f1                	div    %ecx
 4da:	89 d1                	mov    %edx,%ecx
 4dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4df:	8d 50 01             	lea    0x1(%eax),%edx
 4e2:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4e5:	0f b6 91 c4 0b 00 00 	movzbl 0xbc4(%ecx),%edx
 4ec:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 4f0:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4f3:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4f6:	ba 00 00 00 00       	mov    $0x0,%edx
 4fb:	f7 f1                	div    %ecx
 4fd:	89 45 ec             	mov    %eax,-0x14(%ebp)
 500:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 504:	75 c7                	jne    4cd <printint+0x37>
  if(neg)
 506:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 50a:	74 2d                	je     539 <printint+0xa3>
    buf[i++] = '-';
 50c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 50f:	8d 50 01             	lea    0x1(%eax),%edx
 512:	89 55 f4             	mov    %edx,-0xc(%ebp)
 515:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 51a:	eb 1d                	jmp    539 <printint+0xa3>
    putc(fd, buf[i]);
 51c:	8d 55 dc             	lea    -0x24(%ebp),%edx
 51f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 522:	01 d0                	add    %edx,%eax
 524:	0f b6 00             	movzbl (%eax),%eax
 527:	0f be c0             	movsbl %al,%eax
 52a:	83 ec 08             	sub    $0x8,%esp
 52d:	50                   	push   %eax
 52e:	ff 75 08             	push   0x8(%ebp)
 531:	e8 3d ff ff ff       	call   473 <putc>
 536:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 539:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 53d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 541:	79 d9                	jns    51c <printint+0x86>
}
 543:	90                   	nop
 544:	90                   	nop
 545:	c9                   	leave  
 546:	c3                   	ret    

00000547 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 547:	55                   	push   %ebp
 548:	89 e5                	mov    %esp,%ebp
 54a:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 54d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 554:	8d 45 0c             	lea    0xc(%ebp),%eax
 557:	83 c0 04             	add    $0x4,%eax
 55a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 55d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 564:	e9 59 01 00 00       	jmp    6c2 <printf+0x17b>
    c = fmt[i] & 0xff;
 569:	8b 55 0c             	mov    0xc(%ebp),%edx
 56c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 56f:	01 d0                	add    %edx,%eax
 571:	0f b6 00             	movzbl (%eax),%eax
 574:	0f be c0             	movsbl %al,%eax
 577:	25 ff 00 00 00       	and    $0xff,%eax
 57c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 57f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 583:	75 2c                	jne    5b1 <printf+0x6a>
      if(c == '%'){
 585:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 589:	75 0c                	jne    597 <printf+0x50>
        state = '%';
 58b:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 592:	e9 27 01 00 00       	jmp    6be <printf+0x177>
      } else {
        putc(fd, c);
 597:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 59a:	0f be c0             	movsbl %al,%eax
 59d:	83 ec 08             	sub    $0x8,%esp
 5a0:	50                   	push   %eax
 5a1:	ff 75 08             	push   0x8(%ebp)
 5a4:	e8 ca fe ff ff       	call   473 <putc>
 5a9:	83 c4 10             	add    $0x10,%esp
 5ac:	e9 0d 01 00 00       	jmp    6be <printf+0x177>
      }
    } else if(state == '%'){
 5b1:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5b5:	0f 85 03 01 00 00    	jne    6be <printf+0x177>
      if(c == 'd'){
 5bb:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5bf:	75 1e                	jne    5df <printf+0x98>
        printint(fd, *ap, 10, 1);
 5c1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5c4:	8b 00                	mov    (%eax),%eax
 5c6:	6a 01                	push   $0x1
 5c8:	6a 0a                	push   $0xa
 5ca:	50                   	push   %eax
 5cb:	ff 75 08             	push   0x8(%ebp)
 5ce:	e8 c3 fe ff ff       	call   496 <printint>
 5d3:	83 c4 10             	add    $0x10,%esp
        ap++;
 5d6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5da:	e9 d8 00 00 00       	jmp    6b7 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 5df:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5e3:	74 06                	je     5eb <printf+0xa4>
 5e5:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5e9:	75 1e                	jne    609 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 5eb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5ee:	8b 00                	mov    (%eax),%eax
 5f0:	6a 00                	push   $0x0
 5f2:	6a 10                	push   $0x10
 5f4:	50                   	push   %eax
 5f5:	ff 75 08             	push   0x8(%ebp)
 5f8:	e8 99 fe ff ff       	call   496 <printint>
 5fd:	83 c4 10             	add    $0x10,%esp
        ap++;
 600:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 604:	e9 ae 00 00 00       	jmp    6b7 <printf+0x170>
      } else if(c == 's'){
 609:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 60d:	75 43                	jne    652 <printf+0x10b>
        s = (char*)*ap;
 60f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 612:	8b 00                	mov    (%eax),%eax
 614:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 617:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 61b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 61f:	75 25                	jne    646 <printf+0xff>
          s = "(null)";
 621:	c7 45 f4 4e 09 00 00 	movl   $0x94e,-0xc(%ebp)
        while(*s != 0){
 628:	eb 1c                	jmp    646 <printf+0xff>
          putc(fd, *s);
 62a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 62d:	0f b6 00             	movzbl (%eax),%eax
 630:	0f be c0             	movsbl %al,%eax
 633:	83 ec 08             	sub    $0x8,%esp
 636:	50                   	push   %eax
 637:	ff 75 08             	push   0x8(%ebp)
 63a:	e8 34 fe ff ff       	call   473 <putc>
 63f:	83 c4 10             	add    $0x10,%esp
          s++;
 642:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 646:	8b 45 f4             	mov    -0xc(%ebp),%eax
 649:	0f b6 00             	movzbl (%eax),%eax
 64c:	84 c0                	test   %al,%al
 64e:	75 da                	jne    62a <printf+0xe3>
 650:	eb 65                	jmp    6b7 <printf+0x170>
        }
      } else if(c == 'c'){
 652:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 656:	75 1d                	jne    675 <printf+0x12e>
        putc(fd, *ap);
 658:	8b 45 e8             	mov    -0x18(%ebp),%eax
 65b:	8b 00                	mov    (%eax),%eax
 65d:	0f be c0             	movsbl %al,%eax
 660:	83 ec 08             	sub    $0x8,%esp
 663:	50                   	push   %eax
 664:	ff 75 08             	push   0x8(%ebp)
 667:	e8 07 fe ff ff       	call   473 <putc>
 66c:	83 c4 10             	add    $0x10,%esp
        ap++;
 66f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 673:	eb 42                	jmp    6b7 <printf+0x170>
      } else if(c == '%'){
 675:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 679:	75 17                	jne    692 <printf+0x14b>
        putc(fd, c);
 67b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 67e:	0f be c0             	movsbl %al,%eax
 681:	83 ec 08             	sub    $0x8,%esp
 684:	50                   	push   %eax
 685:	ff 75 08             	push   0x8(%ebp)
 688:	e8 e6 fd ff ff       	call   473 <putc>
 68d:	83 c4 10             	add    $0x10,%esp
 690:	eb 25                	jmp    6b7 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 692:	83 ec 08             	sub    $0x8,%esp
 695:	6a 25                	push   $0x25
 697:	ff 75 08             	push   0x8(%ebp)
 69a:	e8 d4 fd ff ff       	call   473 <putc>
 69f:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 6a2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6a5:	0f be c0             	movsbl %al,%eax
 6a8:	83 ec 08             	sub    $0x8,%esp
 6ab:	50                   	push   %eax
 6ac:	ff 75 08             	push   0x8(%ebp)
 6af:	e8 bf fd ff ff       	call   473 <putc>
 6b4:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 6b7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 6be:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6c2:	8b 55 0c             	mov    0xc(%ebp),%edx
 6c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6c8:	01 d0                	add    %edx,%eax
 6ca:	0f b6 00             	movzbl (%eax),%eax
 6cd:	84 c0                	test   %al,%al
 6cf:	0f 85 94 fe ff ff    	jne    569 <printf+0x22>
    }
  }
}
 6d5:	90                   	nop
 6d6:	90                   	nop
 6d7:	c9                   	leave  
 6d8:	c3                   	ret    

000006d9 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6d9:	55                   	push   %ebp
 6da:	89 e5                	mov    %esp,%ebp
 6dc:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6df:	8b 45 08             	mov    0x8(%ebp),%eax
 6e2:	83 e8 08             	sub    $0x8,%eax
 6e5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6e8:	a1 e0 0b 00 00       	mov    0xbe0,%eax
 6ed:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6f0:	eb 24                	jmp    716 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 6f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f5:	8b 00                	mov    (%eax),%eax
 6f7:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 6fa:	72 12                	jb     70e <free+0x35>
 6fc:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ff:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 702:	77 24                	ja     728 <free+0x4f>
 704:	8b 45 fc             	mov    -0x4(%ebp),%eax
 707:	8b 00                	mov    (%eax),%eax
 709:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 70c:	72 1a                	jb     728 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 70e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 711:	8b 00                	mov    (%eax),%eax
 713:	89 45 fc             	mov    %eax,-0x4(%ebp)
 716:	8b 45 f8             	mov    -0x8(%ebp),%eax
 719:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 71c:	76 d4                	jbe    6f2 <free+0x19>
 71e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 721:	8b 00                	mov    (%eax),%eax
 723:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 726:	73 ca                	jae    6f2 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 728:	8b 45 f8             	mov    -0x8(%ebp),%eax
 72b:	8b 40 04             	mov    0x4(%eax),%eax
 72e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 735:	8b 45 f8             	mov    -0x8(%ebp),%eax
 738:	01 c2                	add    %eax,%edx
 73a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73d:	8b 00                	mov    (%eax),%eax
 73f:	39 c2                	cmp    %eax,%edx
 741:	75 24                	jne    767 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 743:	8b 45 f8             	mov    -0x8(%ebp),%eax
 746:	8b 50 04             	mov    0x4(%eax),%edx
 749:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74c:	8b 00                	mov    (%eax),%eax
 74e:	8b 40 04             	mov    0x4(%eax),%eax
 751:	01 c2                	add    %eax,%edx
 753:	8b 45 f8             	mov    -0x8(%ebp),%eax
 756:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 759:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75c:	8b 00                	mov    (%eax),%eax
 75e:	8b 10                	mov    (%eax),%edx
 760:	8b 45 f8             	mov    -0x8(%ebp),%eax
 763:	89 10                	mov    %edx,(%eax)
 765:	eb 0a                	jmp    771 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 767:	8b 45 fc             	mov    -0x4(%ebp),%eax
 76a:	8b 10                	mov    (%eax),%edx
 76c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 76f:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 771:	8b 45 fc             	mov    -0x4(%ebp),%eax
 774:	8b 40 04             	mov    0x4(%eax),%eax
 777:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 77e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 781:	01 d0                	add    %edx,%eax
 783:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 786:	75 20                	jne    7a8 <free+0xcf>
    p->s.size += bp->s.size;
 788:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78b:	8b 50 04             	mov    0x4(%eax),%edx
 78e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 791:	8b 40 04             	mov    0x4(%eax),%eax
 794:	01 c2                	add    %eax,%edx
 796:	8b 45 fc             	mov    -0x4(%ebp),%eax
 799:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 79c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 79f:	8b 10                	mov    (%eax),%edx
 7a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a4:	89 10                	mov    %edx,(%eax)
 7a6:	eb 08                	jmp    7b0 <free+0xd7>
  } else
    p->s.ptr = bp;
 7a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ab:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7ae:	89 10                	mov    %edx,(%eax)
  freep = p;
 7b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b3:	a3 e0 0b 00 00       	mov    %eax,0xbe0
}
 7b8:	90                   	nop
 7b9:	c9                   	leave  
 7ba:	c3                   	ret    

000007bb <morecore>:

static Header*
morecore(uint nu)
{
 7bb:	55                   	push   %ebp
 7bc:	89 e5                	mov    %esp,%ebp
 7be:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7c1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7c8:	77 07                	ja     7d1 <morecore+0x16>
    nu = 4096;
 7ca:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7d1:	8b 45 08             	mov    0x8(%ebp),%eax
 7d4:	c1 e0 03             	shl    $0x3,%eax
 7d7:	83 ec 0c             	sub    $0xc,%esp
 7da:	50                   	push   %eax
 7db:	e8 5b fc ff ff       	call   43b <sbrk>
 7e0:	83 c4 10             	add    $0x10,%esp
 7e3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7e6:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7ea:	75 07                	jne    7f3 <morecore+0x38>
    return 0;
 7ec:	b8 00 00 00 00       	mov    $0x0,%eax
 7f1:	eb 26                	jmp    819 <morecore+0x5e>
  hp = (Header*)p;
 7f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 7f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7fc:	8b 55 08             	mov    0x8(%ebp),%edx
 7ff:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 802:	8b 45 f0             	mov    -0x10(%ebp),%eax
 805:	83 c0 08             	add    $0x8,%eax
 808:	83 ec 0c             	sub    $0xc,%esp
 80b:	50                   	push   %eax
 80c:	e8 c8 fe ff ff       	call   6d9 <free>
 811:	83 c4 10             	add    $0x10,%esp
  return freep;
 814:	a1 e0 0b 00 00       	mov    0xbe0,%eax
}
 819:	c9                   	leave  
 81a:	c3                   	ret    

0000081b <malloc>:

void*
malloc(uint nbytes)
{
 81b:	55                   	push   %ebp
 81c:	89 e5                	mov    %esp,%ebp
 81e:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 821:	8b 45 08             	mov    0x8(%ebp),%eax
 824:	83 c0 07             	add    $0x7,%eax
 827:	c1 e8 03             	shr    $0x3,%eax
 82a:	83 c0 01             	add    $0x1,%eax
 82d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 830:	a1 e0 0b 00 00       	mov    0xbe0,%eax
 835:	89 45 f0             	mov    %eax,-0x10(%ebp)
 838:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 83c:	75 23                	jne    861 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 83e:	c7 45 f0 d8 0b 00 00 	movl   $0xbd8,-0x10(%ebp)
 845:	8b 45 f0             	mov    -0x10(%ebp),%eax
 848:	a3 e0 0b 00 00       	mov    %eax,0xbe0
 84d:	a1 e0 0b 00 00       	mov    0xbe0,%eax
 852:	a3 d8 0b 00 00       	mov    %eax,0xbd8
    base.s.size = 0;
 857:	c7 05 dc 0b 00 00 00 	movl   $0x0,0xbdc
 85e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 861:	8b 45 f0             	mov    -0x10(%ebp),%eax
 864:	8b 00                	mov    (%eax),%eax
 866:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 869:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86c:	8b 40 04             	mov    0x4(%eax),%eax
 86f:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 872:	77 4d                	ja     8c1 <malloc+0xa6>
      if(p->s.size == nunits)
 874:	8b 45 f4             	mov    -0xc(%ebp),%eax
 877:	8b 40 04             	mov    0x4(%eax),%eax
 87a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 87d:	75 0c                	jne    88b <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 87f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 882:	8b 10                	mov    (%eax),%edx
 884:	8b 45 f0             	mov    -0x10(%ebp),%eax
 887:	89 10                	mov    %edx,(%eax)
 889:	eb 26                	jmp    8b1 <malloc+0x96>
      else {
        p->s.size -= nunits;
 88b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88e:	8b 40 04             	mov    0x4(%eax),%eax
 891:	2b 45 ec             	sub    -0x14(%ebp),%eax
 894:	89 c2                	mov    %eax,%edx
 896:	8b 45 f4             	mov    -0xc(%ebp),%eax
 899:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 89c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89f:	8b 40 04             	mov    0x4(%eax),%eax
 8a2:	c1 e0 03             	shl    $0x3,%eax
 8a5:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ab:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8ae:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8b4:	a3 e0 0b 00 00       	mov    %eax,0xbe0
      return (void*)(p + 1);
 8b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8bc:	83 c0 08             	add    $0x8,%eax
 8bf:	eb 3b                	jmp    8fc <malloc+0xe1>
    }
    if(p == freep)
 8c1:	a1 e0 0b 00 00       	mov    0xbe0,%eax
 8c6:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8c9:	75 1e                	jne    8e9 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 8cb:	83 ec 0c             	sub    $0xc,%esp
 8ce:	ff 75 ec             	push   -0x14(%ebp)
 8d1:	e8 e5 fe ff ff       	call   7bb <morecore>
 8d6:	83 c4 10             	add    $0x10,%esp
 8d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8dc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8e0:	75 07                	jne    8e9 <malloc+0xce>
        return 0;
 8e2:	b8 00 00 00 00       	mov    $0x0,%eax
 8e7:	eb 13                	jmp    8fc <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ec:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8f2:	8b 00                	mov    (%eax),%eax
 8f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8f7:	e9 6d ff ff ff       	jmp    869 <malloc+0x4e>
  }
}
 8fc:	c9                   	leave  
 8fd:	c3                   	ret    
