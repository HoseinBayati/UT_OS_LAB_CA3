
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char **argv)
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
    printf(2, "usage: kill pid...\n");
  19:	83 ec 08             	sub    $0x8,%esp
  1c:	68 5f 08 00 00       	push   $0x85f
  21:	6a 02                	push   $0x2
  23:	e8 80 04 00 00       	call   4a8 <printf>
  28:	83 c4 10             	add    $0x10,%esp
    exit();
  2b:	e8 f4 02 00 00       	call   324 <exit>
  }
  for(i=1; i<argc; i++)
  30:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  37:	eb 2d                	jmp    66 <main+0x66>
    kill(atoi(argv[i]));
  39:	8b 45 f4             	mov    -0xc(%ebp),%eax
  3c:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  43:	8b 43 04             	mov    0x4(%ebx),%eax
  46:	01 d0                	add    %edx,%eax
  48:	8b 00                	mov    (%eax),%eax
  4a:	83 ec 0c             	sub    $0xc,%esp
  4d:	50                   	push   %eax
  4e:	e8 e4 01 00 00       	call   237 <atoi>
  53:	83 c4 10             	add    $0x10,%esp
  56:	83 ec 0c             	sub    $0xc,%esp
  59:	50                   	push   %eax
  5a:	e8 f5 02 00 00       	call   354 <kill>
  5f:	83 c4 10             	add    $0x10,%esp
  for(i=1; i<argc; i++)
  62:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  66:	8b 45 f4             	mov    -0xc(%ebp),%eax
  69:	3b 03                	cmp    (%ebx),%eax
  6b:	7c cc                	jl     39 <main+0x39>
  exit();
  6d:	e8 b2 02 00 00       	call   324 <exit>

00000072 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  72:	55                   	push   %ebp
  73:	89 e5                	mov    %esp,%ebp
  75:	57                   	push   %edi
  76:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  77:	8b 4d 08             	mov    0x8(%ebp),%ecx
  7a:	8b 55 10             	mov    0x10(%ebp),%edx
  7d:	8b 45 0c             	mov    0xc(%ebp),%eax
  80:	89 cb                	mov    %ecx,%ebx
  82:	89 df                	mov    %ebx,%edi
  84:	89 d1                	mov    %edx,%ecx
  86:	fc                   	cld    
  87:	f3 aa                	rep stos %al,%es:(%edi)
  89:	89 ca                	mov    %ecx,%edx
  8b:	89 fb                	mov    %edi,%ebx
  8d:	89 5d 08             	mov    %ebx,0x8(%ebp)
  90:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  93:	90                   	nop
  94:	5b                   	pop    %ebx
  95:	5f                   	pop    %edi
  96:	5d                   	pop    %ebp
  97:	c3                   	ret    

00000098 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  98:	55                   	push   %ebp
  99:	89 e5                	mov    %esp,%ebp
  9b:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  9e:	8b 45 08             	mov    0x8(%ebp),%eax
  a1:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  a4:	90                   	nop
  a5:	8b 55 0c             	mov    0xc(%ebp),%edx
  a8:	8d 42 01             	lea    0x1(%edx),%eax
  ab:	89 45 0c             	mov    %eax,0xc(%ebp)
  ae:	8b 45 08             	mov    0x8(%ebp),%eax
  b1:	8d 48 01             	lea    0x1(%eax),%ecx
  b4:	89 4d 08             	mov    %ecx,0x8(%ebp)
  b7:	0f b6 12             	movzbl (%edx),%edx
  ba:	88 10                	mov    %dl,(%eax)
  bc:	0f b6 00             	movzbl (%eax),%eax
  bf:	84 c0                	test   %al,%al
  c1:	75 e2                	jne    a5 <strcpy+0xd>
    ;
  return os;
  c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  c6:	c9                   	leave  
  c7:	c3                   	ret    

000000c8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c8:	55                   	push   %ebp
  c9:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  cb:	eb 08                	jmp    d5 <strcmp+0xd>
    p++, q++;
  cd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  d1:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
  d5:	8b 45 08             	mov    0x8(%ebp),%eax
  d8:	0f b6 00             	movzbl (%eax),%eax
  db:	84 c0                	test   %al,%al
  dd:	74 10                	je     ef <strcmp+0x27>
  df:	8b 45 08             	mov    0x8(%ebp),%eax
  e2:	0f b6 10             	movzbl (%eax),%edx
  e5:	8b 45 0c             	mov    0xc(%ebp),%eax
  e8:	0f b6 00             	movzbl (%eax),%eax
  eb:	38 c2                	cmp    %al,%dl
  ed:	74 de                	je     cd <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
  ef:	8b 45 08             	mov    0x8(%ebp),%eax
  f2:	0f b6 00             	movzbl (%eax),%eax
  f5:	0f b6 d0             	movzbl %al,%edx
  f8:	8b 45 0c             	mov    0xc(%ebp),%eax
  fb:	0f b6 00             	movzbl (%eax),%eax
  fe:	0f b6 c8             	movzbl %al,%ecx
 101:	89 d0                	mov    %edx,%eax
 103:	29 c8                	sub    %ecx,%eax
}
 105:	5d                   	pop    %ebp
 106:	c3                   	ret    

00000107 <strlen>:

uint
strlen(const char *s)
{
 107:	55                   	push   %ebp
 108:	89 e5                	mov    %esp,%ebp
 10a:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 10d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 114:	eb 04                	jmp    11a <strlen+0x13>
 116:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 11a:	8b 55 fc             	mov    -0x4(%ebp),%edx
 11d:	8b 45 08             	mov    0x8(%ebp),%eax
 120:	01 d0                	add    %edx,%eax
 122:	0f b6 00             	movzbl (%eax),%eax
 125:	84 c0                	test   %al,%al
 127:	75 ed                	jne    116 <strlen+0xf>
    ;
  return n;
 129:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 12c:	c9                   	leave  
 12d:	c3                   	ret    

0000012e <memset>:

void*
memset(void *dst, int c, uint n)
{
 12e:	55                   	push   %ebp
 12f:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 131:	8b 45 10             	mov    0x10(%ebp),%eax
 134:	50                   	push   %eax
 135:	ff 75 0c             	push   0xc(%ebp)
 138:	ff 75 08             	push   0x8(%ebp)
 13b:	e8 32 ff ff ff       	call   72 <stosb>
 140:	83 c4 0c             	add    $0xc,%esp
  return dst;
 143:	8b 45 08             	mov    0x8(%ebp),%eax
}
 146:	c9                   	leave  
 147:	c3                   	ret    

00000148 <strchr>:

char*
strchr(const char *s, char c)
{
 148:	55                   	push   %ebp
 149:	89 e5                	mov    %esp,%ebp
 14b:	83 ec 04             	sub    $0x4,%esp
 14e:	8b 45 0c             	mov    0xc(%ebp),%eax
 151:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 154:	eb 14                	jmp    16a <strchr+0x22>
    if(*s == c)
 156:	8b 45 08             	mov    0x8(%ebp),%eax
 159:	0f b6 00             	movzbl (%eax),%eax
 15c:	38 45 fc             	cmp    %al,-0x4(%ebp)
 15f:	75 05                	jne    166 <strchr+0x1e>
      return (char*)s;
 161:	8b 45 08             	mov    0x8(%ebp),%eax
 164:	eb 13                	jmp    179 <strchr+0x31>
  for(; *s; s++)
 166:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 16a:	8b 45 08             	mov    0x8(%ebp),%eax
 16d:	0f b6 00             	movzbl (%eax),%eax
 170:	84 c0                	test   %al,%al
 172:	75 e2                	jne    156 <strchr+0xe>
  return 0;
 174:	b8 00 00 00 00       	mov    $0x0,%eax
}
 179:	c9                   	leave  
 17a:	c3                   	ret    

0000017b <gets>:

char*
gets(char *buf, int max)
{
 17b:	55                   	push   %ebp
 17c:	89 e5                	mov    %esp,%ebp
 17e:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 181:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 188:	eb 42                	jmp    1cc <gets+0x51>
    cc = read(0, &c, 1);
 18a:	83 ec 04             	sub    $0x4,%esp
 18d:	6a 01                	push   $0x1
 18f:	8d 45 ef             	lea    -0x11(%ebp),%eax
 192:	50                   	push   %eax
 193:	6a 00                	push   $0x0
 195:	e8 a2 01 00 00       	call   33c <read>
 19a:	83 c4 10             	add    $0x10,%esp
 19d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1a0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1a4:	7e 33                	jle    1d9 <gets+0x5e>
      break;
    buf[i++] = c;
 1a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1a9:	8d 50 01             	lea    0x1(%eax),%edx
 1ac:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1af:	89 c2                	mov    %eax,%edx
 1b1:	8b 45 08             	mov    0x8(%ebp),%eax
 1b4:	01 c2                	add    %eax,%edx
 1b6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1ba:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1bc:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c0:	3c 0a                	cmp    $0xa,%al
 1c2:	74 16                	je     1da <gets+0x5f>
 1c4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c8:	3c 0d                	cmp    $0xd,%al
 1ca:	74 0e                	je     1da <gets+0x5f>
  for(i=0; i+1 < max; ){
 1cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1cf:	83 c0 01             	add    $0x1,%eax
 1d2:	39 45 0c             	cmp    %eax,0xc(%ebp)
 1d5:	7f b3                	jg     18a <gets+0xf>
 1d7:	eb 01                	jmp    1da <gets+0x5f>
      break;
 1d9:	90                   	nop
      break;
  }
  buf[i] = '\0';
 1da:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1dd:	8b 45 08             	mov    0x8(%ebp),%eax
 1e0:	01 d0                	add    %edx,%eax
 1e2:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1e5:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1e8:	c9                   	leave  
 1e9:	c3                   	ret    

000001ea <stat>:

int
stat(const char *n, struct stat *st)
{
 1ea:	55                   	push   %ebp
 1eb:	89 e5                	mov    %esp,%ebp
 1ed:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f0:	83 ec 08             	sub    $0x8,%esp
 1f3:	6a 00                	push   $0x0
 1f5:	ff 75 08             	push   0x8(%ebp)
 1f8:	e8 67 01 00 00       	call   364 <open>
 1fd:	83 c4 10             	add    $0x10,%esp
 200:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 203:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 207:	79 07                	jns    210 <stat+0x26>
    return -1;
 209:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 20e:	eb 25                	jmp    235 <stat+0x4b>
  r = fstat(fd, st);
 210:	83 ec 08             	sub    $0x8,%esp
 213:	ff 75 0c             	push   0xc(%ebp)
 216:	ff 75 f4             	push   -0xc(%ebp)
 219:	e8 5e 01 00 00       	call   37c <fstat>
 21e:	83 c4 10             	add    $0x10,%esp
 221:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 224:	83 ec 0c             	sub    $0xc,%esp
 227:	ff 75 f4             	push   -0xc(%ebp)
 22a:	e8 1d 01 00 00       	call   34c <close>
 22f:	83 c4 10             	add    $0x10,%esp
  return r;
 232:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 235:	c9                   	leave  
 236:	c3                   	ret    

00000237 <atoi>:

int
atoi(const char *s)
{
 237:	55                   	push   %ebp
 238:	89 e5                	mov    %esp,%ebp
 23a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 23d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 244:	eb 25                	jmp    26b <atoi+0x34>
    n = n*10 + *s++ - '0';
 246:	8b 55 fc             	mov    -0x4(%ebp),%edx
 249:	89 d0                	mov    %edx,%eax
 24b:	c1 e0 02             	shl    $0x2,%eax
 24e:	01 d0                	add    %edx,%eax
 250:	01 c0                	add    %eax,%eax
 252:	89 c1                	mov    %eax,%ecx
 254:	8b 45 08             	mov    0x8(%ebp),%eax
 257:	8d 50 01             	lea    0x1(%eax),%edx
 25a:	89 55 08             	mov    %edx,0x8(%ebp)
 25d:	0f b6 00             	movzbl (%eax),%eax
 260:	0f be c0             	movsbl %al,%eax
 263:	01 c8                	add    %ecx,%eax
 265:	83 e8 30             	sub    $0x30,%eax
 268:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 26b:	8b 45 08             	mov    0x8(%ebp),%eax
 26e:	0f b6 00             	movzbl (%eax),%eax
 271:	3c 2f                	cmp    $0x2f,%al
 273:	7e 0a                	jle    27f <atoi+0x48>
 275:	8b 45 08             	mov    0x8(%ebp),%eax
 278:	0f b6 00             	movzbl (%eax),%eax
 27b:	3c 39                	cmp    $0x39,%al
 27d:	7e c7                	jle    246 <atoi+0xf>
  return n;
 27f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 282:	c9                   	leave  
 283:	c3                   	ret    

00000284 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 284:	55                   	push   %ebp
 285:	89 e5                	mov    %esp,%ebp
 287:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
 28a:	8b 45 08             	mov    0x8(%ebp),%eax
 28d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 290:	8b 45 0c             	mov    0xc(%ebp),%eax
 293:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 296:	eb 17                	jmp    2af <memmove+0x2b>
    *dst++ = *src++;
 298:	8b 55 f8             	mov    -0x8(%ebp),%edx
 29b:	8d 42 01             	lea    0x1(%edx),%eax
 29e:	89 45 f8             	mov    %eax,-0x8(%ebp)
 2a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2a4:	8d 48 01             	lea    0x1(%eax),%ecx
 2a7:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 2aa:	0f b6 12             	movzbl (%edx),%edx
 2ad:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 2af:	8b 45 10             	mov    0x10(%ebp),%eax
 2b2:	8d 50 ff             	lea    -0x1(%eax),%edx
 2b5:	89 55 10             	mov    %edx,0x10(%ebp)
 2b8:	85 c0                	test   %eax,%eax
 2ba:	7f dc                	jg     298 <memmove+0x14>
  return vdst;
 2bc:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2bf:	c9                   	leave  
 2c0:	c3                   	ret    

000002c1 <calc>:

int calc(int num)
{
 2c1:	55                   	push   %ebp
 2c2:	89 e5                	mov    %esp,%ebp
 2c4:	83 ec 10             	sub    $0x10,%esp
    int c = 0;
 2c7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for(uint i = 0; i < num; i++)
 2ce:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
 2d5:	eb 36                	jmp    30d <calc+0x4c>
    {
        for(uint j = 0; j < num; j++)
 2d7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2de:	eb 21                	jmp    301 <calc+0x40>
        {
            for(uint k = 0; k < num; j++)
 2e0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 2e7:	eb 0c                	jmp    2f5 <calc+0x34>
            {
                c >>= 10;
 2e9:	c1 7d fc 0a          	sarl   $0xa,-0x4(%ebp)
                c <<= 10;
 2ed:	c1 65 fc 0a          	shll   $0xa,-0x4(%ebp)
            for(uint k = 0; k < num; j++)
 2f1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 2f5:	8b 45 08             	mov    0x8(%ebp),%eax
 2f8:	39 45 f0             	cmp    %eax,-0x10(%ebp)
 2fb:	72 ec                	jb     2e9 <calc+0x28>
        for(uint j = 0; j < num; j++)
 2fd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 301:	8b 45 08             	mov    0x8(%ebp),%eax
 304:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 307:	72 d7                	jb     2e0 <calc+0x1f>
    for(uint i = 0; i < num; i++)
 309:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 30d:	8b 45 08             	mov    0x8(%ebp),%eax
 310:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 313:	72 c2                	jb     2d7 <calc+0x16>
            }
        }
    }
    return 0;
 315:	b8 00 00 00 00       	mov    $0x0,%eax
}
 31a:	c9                   	leave  
 31b:	c3                   	ret    

0000031c <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 31c:	b8 01 00 00 00       	mov    $0x1,%eax
 321:	cd 40                	int    $0x40
 323:	c3                   	ret    

00000324 <exit>:
SYSCALL(exit)
 324:	b8 02 00 00 00       	mov    $0x2,%eax
 329:	cd 40                	int    $0x40
 32b:	c3                   	ret    

0000032c <wait>:
SYSCALL(wait)
 32c:	b8 03 00 00 00       	mov    $0x3,%eax
 331:	cd 40                	int    $0x40
 333:	c3                   	ret    

00000334 <pipe>:
SYSCALL(pipe)
 334:	b8 04 00 00 00       	mov    $0x4,%eax
 339:	cd 40                	int    $0x40
 33b:	c3                   	ret    

0000033c <read>:
SYSCALL(read)
 33c:	b8 05 00 00 00       	mov    $0x5,%eax
 341:	cd 40                	int    $0x40
 343:	c3                   	ret    

00000344 <write>:
SYSCALL(write)
 344:	b8 10 00 00 00       	mov    $0x10,%eax
 349:	cd 40                	int    $0x40
 34b:	c3                   	ret    

0000034c <close>:
SYSCALL(close)
 34c:	b8 15 00 00 00       	mov    $0x15,%eax
 351:	cd 40                	int    $0x40
 353:	c3                   	ret    

00000354 <kill>:
SYSCALL(kill)
 354:	b8 06 00 00 00       	mov    $0x6,%eax
 359:	cd 40                	int    $0x40
 35b:	c3                   	ret    

0000035c <exec>:
SYSCALL(exec)
 35c:	b8 07 00 00 00       	mov    $0x7,%eax
 361:	cd 40                	int    $0x40
 363:	c3                   	ret    

00000364 <open>:
SYSCALL(open)
 364:	b8 0f 00 00 00       	mov    $0xf,%eax
 369:	cd 40                	int    $0x40
 36b:	c3                   	ret    

0000036c <mknod>:
SYSCALL(mknod)
 36c:	b8 11 00 00 00       	mov    $0x11,%eax
 371:	cd 40                	int    $0x40
 373:	c3                   	ret    

00000374 <unlink>:
SYSCALL(unlink)
 374:	b8 12 00 00 00       	mov    $0x12,%eax
 379:	cd 40                	int    $0x40
 37b:	c3                   	ret    

0000037c <fstat>:
SYSCALL(fstat)
 37c:	b8 08 00 00 00       	mov    $0x8,%eax
 381:	cd 40                	int    $0x40
 383:	c3                   	ret    

00000384 <link>:
SYSCALL(link)
 384:	b8 13 00 00 00       	mov    $0x13,%eax
 389:	cd 40                	int    $0x40
 38b:	c3                   	ret    

0000038c <mkdir>:
SYSCALL(mkdir)
 38c:	b8 14 00 00 00       	mov    $0x14,%eax
 391:	cd 40                	int    $0x40
 393:	c3                   	ret    

00000394 <chdir>:
SYSCALL(chdir)
 394:	b8 09 00 00 00       	mov    $0x9,%eax
 399:	cd 40                	int    $0x40
 39b:	c3                   	ret    

0000039c <dup>:
SYSCALL(dup)
 39c:	b8 0a 00 00 00       	mov    $0xa,%eax
 3a1:	cd 40                	int    $0x40
 3a3:	c3                   	ret    

000003a4 <getpid>:
SYSCALL(getpid)
 3a4:	b8 0b 00 00 00       	mov    $0xb,%eax
 3a9:	cd 40                	int    $0x40
 3ab:	c3                   	ret    

000003ac <sbrk>:
SYSCALL(sbrk)
 3ac:	b8 0c 00 00 00       	mov    $0xc,%eax
 3b1:	cd 40                	int    $0x40
 3b3:	c3                   	ret    

000003b4 <sleep>:
SYSCALL(sleep)
 3b4:	b8 0d 00 00 00       	mov    $0xd,%eax
 3b9:	cd 40                	int    $0x40
 3bb:	c3                   	ret    

000003bc <uptime>:
SYSCALL(uptime)
 3bc:	b8 0e 00 00 00       	mov    $0xe,%eax
 3c1:	cd 40                	int    $0x40
 3c3:	c3                   	ret    

000003c4 <print_proc>:
SYSCALL(print_proc)
 3c4:	b8 16 00 00 00       	mov    $0x16,%eax
 3c9:	cd 40                	int    $0x40
 3cb:	c3                   	ret    

000003cc <change_queue>:
 3cc:	b8 17 00 00 00       	mov    $0x17,%eax
 3d1:	cd 40                	int    $0x40
 3d3:	c3                   	ret    

000003d4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3d4:	55                   	push   %ebp
 3d5:	89 e5                	mov    %esp,%ebp
 3d7:	83 ec 18             	sub    $0x18,%esp
 3da:	8b 45 0c             	mov    0xc(%ebp),%eax
 3dd:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3e0:	83 ec 04             	sub    $0x4,%esp
 3e3:	6a 01                	push   $0x1
 3e5:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3e8:	50                   	push   %eax
 3e9:	ff 75 08             	push   0x8(%ebp)
 3ec:	e8 53 ff ff ff       	call   344 <write>
 3f1:	83 c4 10             	add    $0x10,%esp
}
 3f4:	90                   	nop
 3f5:	c9                   	leave  
 3f6:	c3                   	ret    

000003f7 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3f7:	55                   	push   %ebp
 3f8:	89 e5                	mov    %esp,%ebp
 3fa:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3fd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 404:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 408:	74 17                	je     421 <printint+0x2a>
 40a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 40e:	79 11                	jns    421 <printint+0x2a>
    neg = 1;
 410:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 417:	8b 45 0c             	mov    0xc(%ebp),%eax
 41a:	f7 d8                	neg    %eax
 41c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 41f:	eb 06                	jmp    427 <printint+0x30>
  } else {
    x = xx;
 421:	8b 45 0c             	mov    0xc(%ebp),%eax
 424:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 427:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 42e:	8b 4d 10             	mov    0x10(%ebp),%ecx
 431:	8b 45 ec             	mov    -0x14(%ebp),%eax
 434:	ba 00 00 00 00       	mov    $0x0,%edx
 439:	f7 f1                	div    %ecx
 43b:	89 d1                	mov    %edx,%ecx
 43d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 440:	8d 50 01             	lea    0x1(%eax),%edx
 443:	89 55 f4             	mov    %edx,-0xc(%ebp)
 446:	0f b6 91 e4 0a 00 00 	movzbl 0xae4(%ecx),%edx
 44d:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 451:	8b 4d 10             	mov    0x10(%ebp),%ecx
 454:	8b 45 ec             	mov    -0x14(%ebp),%eax
 457:	ba 00 00 00 00       	mov    $0x0,%edx
 45c:	f7 f1                	div    %ecx
 45e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 461:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 465:	75 c7                	jne    42e <printint+0x37>
  if(neg)
 467:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 46b:	74 2d                	je     49a <printint+0xa3>
    buf[i++] = '-';
 46d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 470:	8d 50 01             	lea    0x1(%eax),%edx
 473:	89 55 f4             	mov    %edx,-0xc(%ebp)
 476:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 47b:	eb 1d                	jmp    49a <printint+0xa3>
    putc(fd, buf[i]);
 47d:	8d 55 dc             	lea    -0x24(%ebp),%edx
 480:	8b 45 f4             	mov    -0xc(%ebp),%eax
 483:	01 d0                	add    %edx,%eax
 485:	0f b6 00             	movzbl (%eax),%eax
 488:	0f be c0             	movsbl %al,%eax
 48b:	83 ec 08             	sub    $0x8,%esp
 48e:	50                   	push   %eax
 48f:	ff 75 08             	push   0x8(%ebp)
 492:	e8 3d ff ff ff       	call   3d4 <putc>
 497:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 49a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 49e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4a2:	79 d9                	jns    47d <printint+0x86>
}
 4a4:	90                   	nop
 4a5:	90                   	nop
 4a6:	c9                   	leave  
 4a7:	c3                   	ret    

000004a8 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4a8:	55                   	push   %ebp
 4a9:	89 e5                	mov    %esp,%ebp
 4ab:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4ae:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4b5:	8d 45 0c             	lea    0xc(%ebp),%eax
 4b8:	83 c0 04             	add    $0x4,%eax
 4bb:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4be:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4c5:	e9 59 01 00 00       	jmp    623 <printf+0x17b>
    c = fmt[i] & 0xff;
 4ca:	8b 55 0c             	mov    0xc(%ebp),%edx
 4cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4d0:	01 d0                	add    %edx,%eax
 4d2:	0f b6 00             	movzbl (%eax),%eax
 4d5:	0f be c0             	movsbl %al,%eax
 4d8:	25 ff 00 00 00       	and    $0xff,%eax
 4dd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4e0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4e4:	75 2c                	jne    512 <printf+0x6a>
      if(c == '%'){
 4e6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4ea:	75 0c                	jne    4f8 <printf+0x50>
        state = '%';
 4ec:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4f3:	e9 27 01 00 00       	jmp    61f <printf+0x177>
      } else {
        putc(fd, c);
 4f8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4fb:	0f be c0             	movsbl %al,%eax
 4fe:	83 ec 08             	sub    $0x8,%esp
 501:	50                   	push   %eax
 502:	ff 75 08             	push   0x8(%ebp)
 505:	e8 ca fe ff ff       	call   3d4 <putc>
 50a:	83 c4 10             	add    $0x10,%esp
 50d:	e9 0d 01 00 00       	jmp    61f <printf+0x177>
      }
    } else if(state == '%'){
 512:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 516:	0f 85 03 01 00 00    	jne    61f <printf+0x177>
      if(c == 'd'){
 51c:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 520:	75 1e                	jne    540 <printf+0x98>
        printint(fd, *ap, 10, 1);
 522:	8b 45 e8             	mov    -0x18(%ebp),%eax
 525:	8b 00                	mov    (%eax),%eax
 527:	6a 01                	push   $0x1
 529:	6a 0a                	push   $0xa
 52b:	50                   	push   %eax
 52c:	ff 75 08             	push   0x8(%ebp)
 52f:	e8 c3 fe ff ff       	call   3f7 <printint>
 534:	83 c4 10             	add    $0x10,%esp
        ap++;
 537:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 53b:	e9 d8 00 00 00       	jmp    618 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 540:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 544:	74 06                	je     54c <printf+0xa4>
 546:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 54a:	75 1e                	jne    56a <printf+0xc2>
        printint(fd, *ap, 16, 0);
 54c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 54f:	8b 00                	mov    (%eax),%eax
 551:	6a 00                	push   $0x0
 553:	6a 10                	push   $0x10
 555:	50                   	push   %eax
 556:	ff 75 08             	push   0x8(%ebp)
 559:	e8 99 fe ff ff       	call   3f7 <printint>
 55e:	83 c4 10             	add    $0x10,%esp
        ap++;
 561:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 565:	e9 ae 00 00 00       	jmp    618 <printf+0x170>
      } else if(c == 's'){
 56a:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 56e:	75 43                	jne    5b3 <printf+0x10b>
        s = (char*)*ap;
 570:	8b 45 e8             	mov    -0x18(%ebp),%eax
 573:	8b 00                	mov    (%eax),%eax
 575:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 578:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 57c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 580:	75 25                	jne    5a7 <printf+0xff>
          s = "(null)";
 582:	c7 45 f4 73 08 00 00 	movl   $0x873,-0xc(%ebp)
        while(*s != 0){
 589:	eb 1c                	jmp    5a7 <printf+0xff>
          putc(fd, *s);
 58b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 58e:	0f b6 00             	movzbl (%eax),%eax
 591:	0f be c0             	movsbl %al,%eax
 594:	83 ec 08             	sub    $0x8,%esp
 597:	50                   	push   %eax
 598:	ff 75 08             	push   0x8(%ebp)
 59b:	e8 34 fe ff ff       	call   3d4 <putc>
 5a0:	83 c4 10             	add    $0x10,%esp
          s++;
 5a3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 5a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5aa:	0f b6 00             	movzbl (%eax),%eax
 5ad:	84 c0                	test   %al,%al
 5af:	75 da                	jne    58b <printf+0xe3>
 5b1:	eb 65                	jmp    618 <printf+0x170>
        }
      } else if(c == 'c'){
 5b3:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5b7:	75 1d                	jne    5d6 <printf+0x12e>
        putc(fd, *ap);
 5b9:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5bc:	8b 00                	mov    (%eax),%eax
 5be:	0f be c0             	movsbl %al,%eax
 5c1:	83 ec 08             	sub    $0x8,%esp
 5c4:	50                   	push   %eax
 5c5:	ff 75 08             	push   0x8(%ebp)
 5c8:	e8 07 fe ff ff       	call   3d4 <putc>
 5cd:	83 c4 10             	add    $0x10,%esp
        ap++;
 5d0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5d4:	eb 42                	jmp    618 <printf+0x170>
      } else if(c == '%'){
 5d6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5da:	75 17                	jne    5f3 <printf+0x14b>
        putc(fd, c);
 5dc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5df:	0f be c0             	movsbl %al,%eax
 5e2:	83 ec 08             	sub    $0x8,%esp
 5e5:	50                   	push   %eax
 5e6:	ff 75 08             	push   0x8(%ebp)
 5e9:	e8 e6 fd ff ff       	call   3d4 <putc>
 5ee:	83 c4 10             	add    $0x10,%esp
 5f1:	eb 25                	jmp    618 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5f3:	83 ec 08             	sub    $0x8,%esp
 5f6:	6a 25                	push   $0x25
 5f8:	ff 75 08             	push   0x8(%ebp)
 5fb:	e8 d4 fd ff ff       	call   3d4 <putc>
 600:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 603:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 606:	0f be c0             	movsbl %al,%eax
 609:	83 ec 08             	sub    $0x8,%esp
 60c:	50                   	push   %eax
 60d:	ff 75 08             	push   0x8(%ebp)
 610:	e8 bf fd ff ff       	call   3d4 <putc>
 615:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 618:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 61f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 623:	8b 55 0c             	mov    0xc(%ebp),%edx
 626:	8b 45 f0             	mov    -0x10(%ebp),%eax
 629:	01 d0                	add    %edx,%eax
 62b:	0f b6 00             	movzbl (%eax),%eax
 62e:	84 c0                	test   %al,%al
 630:	0f 85 94 fe ff ff    	jne    4ca <printf+0x22>
    }
  }
}
 636:	90                   	nop
 637:	90                   	nop
 638:	c9                   	leave  
 639:	c3                   	ret    

0000063a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 63a:	55                   	push   %ebp
 63b:	89 e5                	mov    %esp,%ebp
 63d:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 640:	8b 45 08             	mov    0x8(%ebp),%eax
 643:	83 e8 08             	sub    $0x8,%eax
 646:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 649:	a1 00 0b 00 00       	mov    0xb00,%eax
 64e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 651:	eb 24                	jmp    677 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 653:	8b 45 fc             	mov    -0x4(%ebp),%eax
 656:	8b 00                	mov    (%eax),%eax
 658:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 65b:	72 12                	jb     66f <free+0x35>
 65d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 660:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 663:	77 24                	ja     689 <free+0x4f>
 665:	8b 45 fc             	mov    -0x4(%ebp),%eax
 668:	8b 00                	mov    (%eax),%eax
 66a:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 66d:	72 1a                	jb     689 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 66f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 672:	8b 00                	mov    (%eax),%eax
 674:	89 45 fc             	mov    %eax,-0x4(%ebp)
 677:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 67d:	76 d4                	jbe    653 <free+0x19>
 67f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 682:	8b 00                	mov    (%eax),%eax
 684:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 687:	73 ca                	jae    653 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 689:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68c:	8b 40 04             	mov    0x4(%eax),%eax
 68f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 696:	8b 45 f8             	mov    -0x8(%ebp),%eax
 699:	01 c2                	add    %eax,%edx
 69b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69e:	8b 00                	mov    (%eax),%eax
 6a0:	39 c2                	cmp    %eax,%edx
 6a2:	75 24                	jne    6c8 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6a4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a7:	8b 50 04             	mov    0x4(%eax),%edx
 6aa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ad:	8b 00                	mov    (%eax),%eax
 6af:	8b 40 04             	mov    0x4(%eax),%eax
 6b2:	01 c2                	add    %eax,%edx
 6b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b7:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bd:	8b 00                	mov    (%eax),%eax
 6bf:	8b 10                	mov    (%eax),%edx
 6c1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c4:	89 10                	mov    %edx,(%eax)
 6c6:	eb 0a                	jmp    6d2 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cb:	8b 10                	mov    (%eax),%edx
 6cd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d0:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d5:	8b 40 04             	mov    0x4(%eax),%eax
 6d8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6df:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e2:	01 d0                	add    %edx,%eax
 6e4:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 6e7:	75 20                	jne    709 <free+0xcf>
    p->s.size += bp->s.size;
 6e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ec:	8b 50 04             	mov    0x4(%eax),%edx
 6ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f2:	8b 40 04             	mov    0x4(%eax),%eax
 6f5:	01 c2                	add    %eax,%edx
 6f7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fa:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6fd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 700:	8b 10                	mov    (%eax),%edx
 702:	8b 45 fc             	mov    -0x4(%ebp),%eax
 705:	89 10                	mov    %edx,(%eax)
 707:	eb 08                	jmp    711 <free+0xd7>
  } else
    p->s.ptr = bp;
 709:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70c:	8b 55 f8             	mov    -0x8(%ebp),%edx
 70f:	89 10                	mov    %edx,(%eax)
  freep = p;
 711:	8b 45 fc             	mov    -0x4(%ebp),%eax
 714:	a3 00 0b 00 00       	mov    %eax,0xb00
}
 719:	90                   	nop
 71a:	c9                   	leave  
 71b:	c3                   	ret    

0000071c <morecore>:

static Header*
morecore(uint nu)
{
 71c:	55                   	push   %ebp
 71d:	89 e5                	mov    %esp,%ebp
 71f:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 722:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 729:	77 07                	ja     732 <morecore+0x16>
    nu = 4096;
 72b:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 732:	8b 45 08             	mov    0x8(%ebp),%eax
 735:	c1 e0 03             	shl    $0x3,%eax
 738:	83 ec 0c             	sub    $0xc,%esp
 73b:	50                   	push   %eax
 73c:	e8 6b fc ff ff       	call   3ac <sbrk>
 741:	83 c4 10             	add    $0x10,%esp
 744:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 747:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 74b:	75 07                	jne    754 <morecore+0x38>
    return 0;
 74d:	b8 00 00 00 00       	mov    $0x0,%eax
 752:	eb 26                	jmp    77a <morecore+0x5e>
  hp = (Header*)p;
 754:	8b 45 f4             	mov    -0xc(%ebp),%eax
 757:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 75a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 75d:	8b 55 08             	mov    0x8(%ebp),%edx
 760:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 763:	8b 45 f0             	mov    -0x10(%ebp),%eax
 766:	83 c0 08             	add    $0x8,%eax
 769:	83 ec 0c             	sub    $0xc,%esp
 76c:	50                   	push   %eax
 76d:	e8 c8 fe ff ff       	call   63a <free>
 772:	83 c4 10             	add    $0x10,%esp
  return freep;
 775:	a1 00 0b 00 00       	mov    0xb00,%eax
}
 77a:	c9                   	leave  
 77b:	c3                   	ret    

0000077c <malloc>:

void*
malloc(uint nbytes)
{
 77c:	55                   	push   %ebp
 77d:	89 e5                	mov    %esp,%ebp
 77f:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 782:	8b 45 08             	mov    0x8(%ebp),%eax
 785:	83 c0 07             	add    $0x7,%eax
 788:	c1 e8 03             	shr    $0x3,%eax
 78b:	83 c0 01             	add    $0x1,%eax
 78e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 791:	a1 00 0b 00 00       	mov    0xb00,%eax
 796:	89 45 f0             	mov    %eax,-0x10(%ebp)
 799:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 79d:	75 23                	jne    7c2 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 79f:	c7 45 f0 f8 0a 00 00 	movl   $0xaf8,-0x10(%ebp)
 7a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a9:	a3 00 0b 00 00       	mov    %eax,0xb00
 7ae:	a1 00 0b 00 00       	mov    0xb00,%eax
 7b3:	a3 f8 0a 00 00       	mov    %eax,0xaf8
    base.s.size = 0;
 7b8:	c7 05 fc 0a 00 00 00 	movl   $0x0,0xafc
 7bf:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c5:	8b 00                	mov    (%eax),%eax
 7c7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7cd:	8b 40 04             	mov    0x4(%eax),%eax
 7d0:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7d3:	77 4d                	ja     822 <malloc+0xa6>
      if(p->s.size == nunits)
 7d5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d8:	8b 40 04             	mov    0x4(%eax),%eax
 7db:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7de:	75 0c                	jne    7ec <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e3:	8b 10                	mov    (%eax),%edx
 7e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7e8:	89 10                	mov    %edx,(%eax)
 7ea:	eb 26                	jmp    812 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ef:	8b 40 04             	mov    0x4(%eax),%eax
 7f2:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7f5:	89 c2                	mov    %eax,%edx
 7f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fa:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7fd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 800:	8b 40 04             	mov    0x4(%eax),%eax
 803:	c1 e0 03             	shl    $0x3,%eax
 806:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 809:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80c:	8b 55 ec             	mov    -0x14(%ebp),%edx
 80f:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 812:	8b 45 f0             	mov    -0x10(%ebp),%eax
 815:	a3 00 0b 00 00       	mov    %eax,0xb00
      return (void*)(p + 1);
 81a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81d:	83 c0 08             	add    $0x8,%eax
 820:	eb 3b                	jmp    85d <malloc+0xe1>
    }
    if(p == freep)
 822:	a1 00 0b 00 00       	mov    0xb00,%eax
 827:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 82a:	75 1e                	jne    84a <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 82c:	83 ec 0c             	sub    $0xc,%esp
 82f:	ff 75 ec             	push   -0x14(%ebp)
 832:	e8 e5 fe ff ff       	call   71c <morecore>
 837:	83 c4 10             	add    $0x10,%esp
 83a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 83d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 841:	75 07                	jne    84a <malloc+0xce>
        return 0;
 843:	b8 00 00 00 00       	mov    $0x0,%eax
 848:	eb 13                	jmp    85d <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 84a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 84d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 850:	8b 45 f4             	mov    -0xc(%ebp),%eax
 853:	8b 00                	mov    (%eax),%eax
 855:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 858:	e9 6d ff ff ff       	jmp    7ca <malloc+0x4e>
  }
}
 85d:	c9                   	leave  
 85e:	c3                   	ret    
