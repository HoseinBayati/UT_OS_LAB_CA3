
_qRRTest2:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "stat.h"
#include "user.h"

int main()
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 14             	sub    $0x14,%esp
    for(uint i = 0; i < 100; i++)
  11:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  18:	eb 16                	jmp    30 <main+0x30>
    {
        printf(1, "2\n");
  1a:	83 ec 08             	sub    $0x8,%esp
  1d:	68 28 08 00 00       	push   $0x828
  22:	6a 01                	push   $0x1
  24:	e8 48 04 00 00       	call   471 <printf>
  29:	83 c4 10             	add    $0x10,%esp
    for(uint i = 0; i < 100; i++)
  2c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  30:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
  34:	76 e4                	jbe    1a <main+0x1a>
    }
    exit();
  36:	e8 b2 02 00 00       	call   2ed <exit>

0000003b <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  3b:	55                   	push   %ebp
  3c:	89 e5                	mov    %esp,%ebp
  3e:	57                   	push   %edi
  3f:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  40:	8b 4d 08             	mov    0x8(%ebp),%ecx
  43:	8b 55 10             	mov    0x10(%ebp),%edx
  46:	8b 45 0c             	mov    0xc(%ebp),%eax
  49:	89 cb                	mov    %ecx,%ebx
  4b:	89 df                	mov    %ebx,%edi
  4d:	89 d1                	mov    %edx,%ecx
  4f:	fc                   	cld    
  50:	f3 aa                	rep stos %al,%es:(%edi)
  52:	89 ca                	mov    %ecx,%edx
  54:	89 fb                	mov    %edi,%ebx
  56:	89 5d 08             	mov    %ebx,0x8(%ebp)
  59:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  5c:	90                   	nop
  5d:	5b                   	pop    %ebx
  5e:	5f                   	pop    %edi
  5f:	5d                   	pop    %ebp
  60:	c3                   	ret    

00000061 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  61:	55                   	push   %ebp
  62:	89 e5                	mov    %esp,%ebp
  64:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  67:	8b 45 08             	mov    0x8(%ebp),%eax
  6a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  6d:	90                   	nop
  6e:	8b 55 0c             	mov    0xc(%ebp),%edx
  71:	8d 42 01             	lea    0x1(%edx),%eax
  74:	89 45 0c             	mov    %eax,0xc(%ebp)
  77:	8b 45 08             	mov    0x8(%ebp),%eax
  7a:	8d 48 01             	lea    0x1(%eax),%ecx
  7d:	89 4d 08             	mov    %ecx,0x8(%ebp)
  80:	0f b6 12             	movzbl (%edx),%edx
  83:	88 10                	mov    %dl,(%eax)
  85:	0f b6 00             	movzbl (%eax),%eax
  88:	84 c0                	test   %al,%al
  8a:	75 e2                	jne    6e <strcpy+0xd>
    ;
  return os;
  8c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  8f:	c9                   	leave  
  90:	c3                   	ret    

00000091 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  91:	55                   	push   %ebp
  92:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  94:	eb 08                	jmp    9e <strcmp+0xd>
    p++, q++;
  96:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  9a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
  9e:	8b 45 08             	mov    0x8(%ebp),%eax
  a1:	0f b6 00             	movzbl (%eax),%eax
  a4:	84 c0                	test   %al,%al
  a6:	74 10                	je     b8 <strcmp+0x27>
  a8:	8b 45 08             	mov    0x8(%ebp),%eax
  ab:	0f b6 10             	movzbl (%eax),%edx
  ae:	8b 45 0c             	mov    0xc(%ebp),%eax
  b1:	0f b6 00             	movzbl (%eax),%eax
  b4:	38 c2                	cmp    %al,%dl
  b6:	74 de                	je     96 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
  b8:	8b 45 08             	mov    0x8(%ebp),%eax
  bb:	0f b6 00             	movzbl (%eax),%eax
  be:	0f b6 d0             	movzbl %al,%edx
  c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  c4:	0f b6 00             	movzbl (%eax),%eax
  c7:	0f b6 c8             	movzbl %al,%ecx
  ca:	89 d0                	mov    %edx,%eax
  cc:	29 c8                	sub    %ecx,%eax
}
  ce:	5d                   	pop    %ebp
  cf:	c3                   	ret    

000000d0 <strlen>:

uint
strlen(const char *s)
{
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  d6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  dd:	eb 04                	jmp    e3 <strlen+0x13>
  df:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  e3:	8b 55 fc             	mov    -0x4(%ebp),%edx
  e6:	8b 45 08             	mov    0x8(%ebp),%eax
  e9:	01 d0                	add    %edx,%eax
  eb:	0f b6 00             	movzbl (%eax),%eax
  ee:	84 c0                	test   %al,%al
  f0:	75 ed                	jne    df <strlen+0xf>
    ;
  return n;
  f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  f5:	c9                   	leave  
  f6:	c3                   	ret    

000000f7 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f7:	55                   	push   %ebp
  f8:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
  fa:	8b 45 10             	mov    0x10(%ebp),%eax
  fd:	50                   	push   %eax
  fe:	ff 75 0c             	push   0xc(%ebp)
 101:	ff 75 08             	push   0x8(%ebp)
 104:	e8 32 ff ff ff       	call   3b <stosb>
 109:	83 c4 0c             	add    $0xc,%esp
  return dst;
 10c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 10f:	c9                   	leave  
 110:	c3                   	ret    

00000111 <strchr>:

char*
strchr(const char *s, char c)
{
 111:	55                   	push   %ebp
 112:	89 e5                	mov    %esp,%ebp
 114:	83 ec 04             	sub    $0x4,%esp
 117:	8b 45 0c             	mov    0xc(%ebp),%eax
 11a:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 11d:	eb 14                	jmp    133 <strchr+0x22>
    if(*s == c)
 11f:	8b 45 08             	mov    0x8(%ebp),%eax
 122:	0f b6 00             	movzbl (%eax),%eax
 125:	38 45 fc             	cmp    %al,-0x4(%ebp)
 128:	75 05                	jne    12f <strchr+0x1e>
      return (char*)s;
 12a:	8b 45 08             	mov    0x8(%ebp),%eax
 12d:	eb 13                	jmp    142 <strchr+0x31>
  for(; *s; s++)
 12f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 133:	8b 45 08             	mov    0x8(%ebp),%eax
 136:	0f b6 00             	movzbl (%eax),%eax
 139:	84 c0                	test   %al,%al
 13b:	75 e2                	jne    11f <strchr+0xe>
  return 0;
 13d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 142:	c9                   	leave  
 143:	c3                   	ret    

00000144 <gets>:

char*
gets(char *buf, int max)
{
 144:	55                   	push   %ebp
 145:	89 e5                	mov    %esp,%ebp
 147:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 14a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 151:	eb 42                	jmp    195 <gets+0x51>
    cc = read(0, &c, 1);
 153:	83 ec 04             	sub    $0x4,%esp
 156:	6a 01                	push   $0x1
 158:	8d 45 ef             	lea    -0x11(%ebp),%eax
 15b:	50                   	push   %eax
 15c:	6a 00                	push   $0x0
 15e:	e8 a2 01 00 00       	call   305 <read>
 163:	83 c4 10             	add    $0x10,%esp
 166:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 169:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 16d:	7e 33                	jle    1a2 <gets+0x5e>
      break;
    buf[i++] = c;
 16f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 172:	8d 50 01             	lea    0x1(%eax),%edx
 175:	89 55 f4             	mov    %edx,-0xc(%ebp)
 178:	89 c2                	mov    %eax,%edx
 17a:	8b 45 08             	mov    0x8(%ebp),%eax
 17d:	01 c2                	add    %eax,%edx
 17f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 183:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 185:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 189:	3c 0a                	cmp    $0xa,%al
 18b:	74 16                	je     1a3 <gets+0x5f>
 18d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 191:	3c 0d                	cmp    $0xd,%al
 193:	74 0e                	je     1a3 <gets+0x5f>
  for(i=0; i+1 < max; ){
 195:	8b 45 f4             	mov    -0xc(%ebp),%eax
 198:	83 c0 01             	add    $0x1,%eax
 19b:	39 45 0c             	cmp    %eax,0xc(%ebp)
 19e:	7f b3                	jg     153 <gets+0xf>
 1a0:	eb 01                	jmp    1a3 <gets+0x5f>
      break;
 1a2:	90                   	nop
      break;
  }
  buf[i] = '\0';
 1a3:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1a6:	8b 45 08             	mov    0x8(%ebp),%eax
 1a9:	01 d0                	add    %edx,%eax
 1ab:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1ae:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1b1:	c9                   	leave  
 1b2:	c3                   	ret    

000001b3 <stat>:

int
stat(const char *n, struct stat *st)
{
 1b3:	55                   	push   %ebp
 1b4:	89 e5                	mov    %esp,%ebp
 1b6:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1b9:	83 ec 08             	sub    $0x8,%esp
 1bc:	6a 00                	push   $0x0
 1be:	ff 75 08             	push   0x8(%ebp)
 1c1:	e8 67 01 00 00       	call   32d <open>
 1c6:	83 c4 10             	add    $0x10,%esp
 1c9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1cc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1d0:	79 07                	jns    1d9 <stat+0x26>
    return -1;
 1d2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1d7:	eb 25                	jmp    1fe <stat+0x4b>
  r = fstat(fd, st);
 1d9:	83 ec 08             	sub    $0x8,%esp
 1dc:	ff 75 0c             	push   0xc(%ebp)
 1df:	ff 75 f4             	push   -0xc(%ebp)
 1e2:	e8 5e 01 00 00       	call   345 <fstat>
 1e7:	83 c4 10             	add    $0x10,%esp
 1ea:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1ed:	83 ec 0c             	sub    $0xc,%esp
 1f0:	ff 75 f4             	push   -0xc(%ebp)
 1f3:	e8 1d 01 00 00       	call   315 <close>
 1f8:	83 c4 10             	add    $0x10,%esp
  return r;
 1fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1fe:	c9                   	leave  
 1ff:	c3                   	ret    

00000200 <atoi>:

int
atoi(const char *s)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 206:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 20d:	eb 25                	jmp    234 <atoi+0x34>
    n = n*10 + *s++ - '0';
 20f:	8b 55 fc             	mov    -0x4(%ebp),%edx
 212:	89 d0                	mov    %edx,%eax
 214:	c1 e0 02             	shl    $0x2,%eax
 217:	01 d0                	add    %edx,%eax
 219:	01 c0                	add    %eax,%eax
 21b:	89 c1                	mov    %eax,%ecx
 21d:	8b 45 08             	mov    0x8(%ebp),%eax
 220:	8d 50 01             	lea    0x1(%eax),%edx
 223:	89 55 08             	mov    %edx,0x8(%ebp)
 226:	0f b6 00             	movzbl (%eax),%eax
 229:	0f be c0             	movsbl %al,%eax
 22c:	01 c8                	add    %ecx,%eax
 22e:	83 e8 30             	sub    $0x30,%eax
 231:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 234:	8b 45 08             	mov    0x8(%ebp),%eax
 237:	0f b6 00             	movzbl (%eax),%eax
 23a:	3c 2f                	cmp    $0x2f,%al
 23c:	7e 0a                	jle    248 <atoi+0x48>
 23e:	8b 45 08             	mov    0x8(%ebp),%eax
 241:	0f b6 00             	movzbl (%eax),%eax
 244:	3c 39                	cmp    $0x39,%al
 246:	7e c7                	jle    20f <atoi+0xf>
  return n;
 248:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 24b:	c9                   	leave  
 24c:	c3                   	ret    

0000024d <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 24d:	55                   	push   %ebp
 24e:	89 e5                	mov    %esp,%ebp
 250:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
 253:	8b 45 08             	mov    0x8(%ebp),%eax
 256:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 259:	8b 45 0c             	mov    0xc(%ebp),%eax
 25c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 25f:	eb 17                	jmp    278 <memmove+0x2b>
    *dst++ = *src++;
 261:	8b 55 f8             	mov    -0x8(%ebp),%edx
 264:	8d 42 01             	lea    0x1(%edx),%eax
 267:	89 45 f8             	mov    %eax,-0x8(%ebp)
 26a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 26d:	8d 48 01             	lea    0x1(%eax),%ecx
 270:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 273:	0f b6 12             	movzbl (%edx),%edx
 276:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 278:	8b 45 10             	mov    0x10(%ebp),%eax
 27b:	8d 50 ff             	lea    -0x1(%eax),%edx
 27e:	89 55 10             	mov    %edx,0x10(%ebp)
 281:	85 c0                	test   %eax,%eax
 283:	7f dc                	jg     261 <memmove+0x14>
  return vdst;
 285:	8b 45 08             	mov    0x8(%ebp),%eax
}
 288:	c9                   	leave  
 289:	c3                   	ret    

0000028a <calc>:

int calc(int num)
{
 28a:	55                   	push   %ebp
 28b:	89 e5                	mov    %esp,%ebp
 28d:	83 ec 10             	sub    $0x10,%esp
    int c = 0;
 290:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for(uint i = 0; i < num; i++)
 297:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
 29e:	eb 36                	jmp    2d6 <calc+0x4c>
    {
        for(uint j = 0; j < num; j++)
 2a0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2a7:	eb 21                	jmp    2ca <calc+0x40>
        {
            for(uint k = 0; k < num; j++)
 2a9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 2b0:	eb 0c                	jmp    2be <calc+0x34>
            {
                c >>= 10;
 2b2:	c1 7d fc 0a          	sarl   $0xa,-0x4(%ebp)
                c <<= 10;
 2b6:	c1 65 fc 0a          	shll   $0xa,-0x4(%ebp)
            for(uint k = 0; k < num; j++)
 2ba:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 2be:	8b 45 08             	mov    0x8(%ebp),%eax
 2c1:	39 45 f0             	cmp    %eax,-0x10(%ebp)
 2c4:	72 ec                	jb     2b2 <calc+0x28>
        for(uint j = 0; j < num; j++)
 2c6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 2ca:	8b 45 08             	mov    0x8(%ebp),%eax
 2cd:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 2d0:	72 d7                	jb     2a9 <calc+0x1f>
    for(uint i = 0; i < num; i++)
 2d2:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 2d6:	8b 45 08             	mov    0x8(%ebp),%eax
 2d9:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 2dc:	72 c2                	jb     2a0 <calc+0x16>
            }
        }
    }
    return 0;
 2de:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2e3:	c9                   	leave  
 2e4:	c3                   	ret    

000002e5 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2e5:	b8 01 00 00 00       	mov    $0x1,%eax
 2ea:	cd 40                	int    $0x40
 2ec:	c3                   	ret    

000002ed <exit>:
SYSCALL(exit)
 2ed:	b8 02 00 00 00       	mov    $0x2,%eax
 2f2:	cd 40                	int    $0x40
 2f4:	c3                   	ret    

000002f5 <wait>:
SYSCALL(wait)
 2f5:	b8 03 00 00 00       	mov    $0x3,%eax
 2fa:	cd 40                	int    $0x40
 2fc:	c3                   	ret    

000002fd <pipe>:
SYSCALL(pipe)
 2fd:	b8 04 00 00 00       	mov    $0x4,%eax
 302:	cd 40                	int    $0x40
 304:	c3                   	ret    

00000305 <read>:
SYSCALL(read)
 305:	b8 05 00 00 00       	mov    $0x5,%eax
 30a:	cd 40                	int    $0x40
 30c:	c3                   	ret    

0000030d <write>:
SYSCALL(write)
 30d:	b8 10 00 00 00       	mov    $0x10,%eax
 312:	cd 40                	int    $0x40
 314:	c3                   	ret    

00000315 <close>:
SYSCALL(close)
 315:	b8 15 00 00 00       	mov    $0x15,%eax
 31a:	cd 40                	int    $0x40
 31c:	c3                   	ret    

0000031d <kill>:
SYSCALL(kill)
 31d:	b8 06 00 00 00       	mov    $0x6,%eax
 322:	cd 40                	int    $0x40
 324:	c3                   	ret    

00000325 <exec>:
SYSCALL(exec)
 325:	b8 07 00 00 00       	mov    $0x7,%eax
 32a:	cd 40                	int    $0x40
 32c:	c3                   	ret    

0000032d <open>:
SYSCALL(open)
 32d:	b8 0f 00 00 00       	mov    $0xf,%eax
 332:	cd 40                	int    $0x40
 334:	c3                   	ret    

00000335 <mknod>:
SYSCALL(mknod)
 335:	b8 11 00 00 00       	mov    $0x11,%eax
 33a:	cd 40                	int    $0x40
 33c:	c3                   	ret    

0000033d <unlink>:
SYSCALL(unlink)
 33d:	b8 12 00 00 00       	mov    $0x12,%eax
 342:	cd 40                	int    $0x40
 344:	c3                   	ret    

00000345 <fstat>:
SYSCALL(fstat)
 345:	b8 08 00 00 00       	mov    $0x8,%eax
 34a:	cd 40                	int    $0x40
 34c:	c3                   	ret    

0000034d <link>:
SYSCALL(link)
 34d:	b8 13 00 00 00       	mov    $0x13,%eax
 352:	cd 40                	int    $0x40
 354:	c3                   	ret    

00000355 <mkdir>:
SYSCALL(mkdir)
 355:	b8 14 00 00 00       	mov    $0x14,%eax
 35a:	cd 40                	int    $0x40
 35c:	c3                   	ret    

0000035d <chdir>:
SYSCALL(chdir)
 35d:	b8 09 00 00 00       	mov    $0x9,%eax
 362:	cd 40                	int    $0x40
 364:	c3                   	ret    

00000365 <dup>:
SYSCALL(dup)
 365:	b8 0a 00 00 00       	mov    $0xa,%eax
 36a:	cd 40                	int    $0x40
 36c:	c3                   	ret    

0000036d <getpid>:
SYSCALL(getpid)
 36d:	b8 0b 00 00 00       	mov    $0xb,%eax
 372:	cd 40                	int    $0x40
 374:	c3                   	ret    

00000375 <sbrk>:
SYSCALL(sbrk)
 375:	b8 0c 00 00 00       	mov    $0xc,%eax
 37a:	cd 40                	int    $0x40
 37c:	c3                   	ret    

0000037d <sleep>:
SYSCALL(sleep)
 37d:	b8 0d 00 00 00       	mov    $0xd,%eax
 382:	cd 40                	int    $0x40
 384:	c3                   	ret    

00000385 <uptime>:
SYSCALL(uptime)
 385:	b8 0e 00 00 00       	mov    $0xe,%eax
 38a:	cd 40                	int    $0x40
 38c:	c3                   	ret    

0000038d <print_proc>:
SYSCALL(print_proc)
 38d:	b8 16 00 00 00       	mov    $0x16,%eax
 392:	cd 40                	int    $0x40
 394:	c3                   	ret    

00000395 <change_queue>:
 395:	b8 17 00 00 00       	mov    $0x17,%eax
 39a:	cd 40                	int    $0x40
 39c:	c3                   	ret    

0000039d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 39d:	55                   	push   %ebp
 39e:	89 e5                	mov    %esp,%ebp
 3a0:	83 ec 18             	sub    $0x18,%esp
 3a3:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a6:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3a9:	83 ec 04             	sub    $0x4,%esp
 3ac:	6a 01                	push   $0x1
 3ae:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3b1:	50                   	push   %eax
 3b2:	ff 75 08             	push   0x8(%ebp)
 3b5:	e8 53 ff ff ff       	call   30d <write>
 3ba:	83 c4 10             	add    $0x10,%esp
}
 3bd:	90                   	nop
 3be:	c9                   	leave  
 3bf:	c3                   	ret    

000003c0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3c6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3cd:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3d1:	74 17                	je     3ea <printint+0x2a>
 3d3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3d7:	79 11                	jns    3ea <printint+0x2a>
    neg = 1;
 3d9:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3e0:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e3:	f7 d8                	neg    %eax
 3e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3e8:	eb 06                	jmp    3f0 <printint+0x30>
  } else {
    x = xx;
 3ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3f0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3fd:	ba 00 00 00 00       	mov    $0x0,%edx
 402:	f7 f1                	div    %ecx
 404:	89 d1                	mov    %edx,%ecx
 406:	8b 45 f4             	mov    -0xc(%ebp),%eax
 409:	8d 50 01             	lea    0x1(%eax),%edx
 40c:	89 55 f4             	mov    %edx,-0xc(%ebp)
 40f:	0f b6 91 98 0a 00 00 	movzbl 0xa98(%ecx),%edx
 416:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 41a:	8b 4d 10             	mov    0x10(%ebp),%ecx
 41d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 420:	ba 00 00 00 00       	mov    $0x0,%edx
 425:	f7 f1                	div    %ecx
 427:	89 45 ec             	mov    %eax,-0x14(%ebp)
 42a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 42e:	75 c7                	jne    3f7 <printint+0x37>
  if(neg)
 430:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 434:	74 2d                	je     463 <printint+0xa3>
    buf[i++] = '-';
 436:	8b 45 f4             	mov    -0xc(%ebp),%eax
 439:	8d 50 01             	lea    0x1(%eax),%edx
 43c:	89 55 f4             	mov    %edx,-0xc(%ebp)
 43f:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 444:	eb 1d                	jmp    463 <printint+0xa3>
    putc(fd, buf[i]);
 446:	8d 55 dc             	lea    -0x24(%ebp),%edx
 449:	8b 45 f4             	mov    -0xc(%ebp),%eax
 44c:	01 d0                	add    %edx,%eax
 44e:	0f b6 00             	movzbl (%eax),%eax
 451:	0f be c0             	movsbl %al,%eax
 454:	83 ec 08             	sub    $0x8,%esp
 457:	50                   	push   %eax
 458:	ff 75 08             	push   0x8(%ebp)
 45b:	e8 3d ff ff ff       	call   39d <putc>
 460:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 463:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 467:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 46b:	79 d9                	jns    446 <printint+0x86>
}
 46d:	90                   	nop
 46e:	90                   	nop
 46f:	c9                   	leave  
 470:	c3                   	ret    

00000471 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 471:	55                   	push   %ebp
 472:	89 e5                	mov    %esp,%ebp
 474:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 477:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 47e:	8d 45 0c             	lea    0xc(%ebp),%eax
 481:	83 c0 04             	add    $0x4,%eax
 484:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 487:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 48e:	e9 59 01 00 00       	jmp    5ec <printf+0x17b>
    c = fmt[i] & 0xff;
 493:	8b 55 0c             	mov    0xc(%ebp),%edx
 496:	8b 45 f0             	mov    -0x10(%ebp),%eax
 499:	01 d0                	add    %edx,%eax
 49b:	0f b6 00             	movzbl (%eax),%eax
 49e:	0f be c0             	movsbl %al,%eax
 4a1:	25 ff 00 00 00       	and    $0xff,%eax
 4a6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4a9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4ad:	75 2c                	jne    4db <printf+0x6a>
      if(c == '%'){
 4af:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4b3:	75 0c                	jne    4c1 <printf+0x50>
        state = '%';
 4b5:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4bc:	e9 27 01 00 00       	jmp    5e8 <printf+0x177>
      } else {
        putc(fd, c);
 4c1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4c4:	0f be c0             	movsbl %al,%eax
 4c7:	83 ec 08             	sub    $0x8,%esp
 4ca:	50                   	push   %eax
 4cb:	ff 75 08             	push   0x8(%ebp)
 4ce:	e8 ca fe ff ff       	call   39d <putc>
 4d3:	83 c4 10             	add    $0x10,%esp
 4d6:	e9 0d 01 00 00       	jmp    5e8 <printf+0x177>
      }
    } else if(state == '%'){
 4db:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4df:	0f 85 03 01 00 00    	jne    5e8 <printf+0x177>
      if(c == 'd'){
 4e5:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4e9:	75 1e                	jne    509 <printf+0x98>
        printint(fd, *ap, 10, 1);
 4eb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4ee:	8b 00                	mov    (%eax),%eax
 4f0:	6a 01                	push   $0x1
 4f2:	6a 0a                	push   $0xa
 4f4:	50                   	push   %eax
 4f5:	ff 75 08             	push   0x8(%ebp)
 4f8:	e8 c3 fe ff ff       	call   3c0 <printint>
 4fd:	83 c4 10             	add    $0x10,%esp
        ap++;
 500:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 504:	e9 d8 00 00 00       	jmp    5e1 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 509:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 50d:	74 06                	je     515 <printf+0xa4>
 50f:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 513:	75 1e                	jne    533 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 515:	8b 45 e8             	mov    -0x18(%ebp),%eax
 518:	8b 00                	mov    (%eax),%eax
 51a:	6a 00                	push   $0x0
 51c:	6a 10                	push   $0x10
 51e:	50                   	push   %eax
 51f:	ff 75 08             	push   0x8(%ebp)
 522:	e8 99 fe ff ff       	call   3c0 <printint>
 527:	83 c4 10             	add    $0x10,%esp
        ap++;
 52a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 52e:	e9 ae 00 00 00       	jmp    5e1 <printf+0x170>
      } else if(c == 's'){
 533:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 537:	75 43                	jne    57c <printf+0x10b>
        s = (char*)*ap;
 539:	8b 45 e8             	mov    -0x18(%ebp),%eax
 53c:	8b 00                	mov    (%eax),%eax
 53e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 541:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 545:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 549:	75 25                	jne    570 <printf+0xff>
          s = "(null)";
 54b:	c7 45 f4 2b 08 00 00 	movl   $0x82b,-0xc(%ebp)
        while(*s != 0){
 552:	eb 1c                	jmp    570 <printf+0xff>
          putc(fd, *s);
 554:	8b 45 f4             	mov    -0xc(%ebp),%eax
 557:	0f b6 00             	movzbl (%eax),%eax
 55a:	0f be c0             	movsbl %al,%eax
 55d:	83 ec 08             	sub    $0x8,%esp
 560:	50                   	push   %eax
 561:	ff 75 08             	push   0x8(%ebp)
 564:	e8 34 fe ff ff       	call   39d <putc>
 569:	83 c4 10             	add    $0x10,%esp
          s++;
 56c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 570:	8b 45 f4             	mov    -0xc(%ebp),%eax
 573:	0f b6 00             	movzbl (%eax),%eax
 576:	84 c0                	test   %al,%al
 578:	75 da                	jne    554 <printf+0xe3>
 57a:	eb 65                	jmp    5e1 <printf+0x170>
        }
      } else if(c == 'c'){
 57c:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 580:	75 1d                	jne    59f <printf+0x12e>
        putc(fd, *ap);
 582:	8b 45 e8             	mov    -0x18(%ebp),%eax
 585:	8b 00                	mov    (%eax),%eax
 587:	0f be c0             	movsbl %al,%eax
 58a:	83 ec 08             	sub    $0x8,%esp
 58d:	50                   	push   %eax
 58e:	ff 75 08             	push   0x8(%ebp)
 591:	e8 07 fe ff ff       	call   39d <putc>
 596:	83 c4 10             	add    $0x10,%esp
        ap++;
 599:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 59d:	eb 42                	jmp    5e1 <printf+0x170>
      } else if(c == '%'){
 59f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5a3:	75 17                	jne    5bc <printf+0x14b>
        putc(fd, c);
 5a5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5a8:	0f be c0             	movsbl %al,%eax
 5ab:	83 ec 08             	sub    $0x8,%esp
 5ae:	50                   	push   %eax
 5af:	ff 75 08             	push   0x8(%ebp)
 5b2:	e8 e6 fd ff ff       	call   39d <putc>
 5b7:	83 c4 10             	add    $0x10,%esp
 5ba:	eb 25                	jmp    5e1 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5bc:	83 ec 08             	sub    $0x8,%esp
 5bf:	6a 25                	push   $0x25
 5c1:	ff 75 08             	push   0x8(%ebp)
 5c4:	e8 d4 fd ff ff       	call   39d <putc>
 5c9:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5cc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5cf:	0f be c0             	movsbl %al,%eax
 5d2:	83 ec 08             	sub    $0x8,%esp
 5d5:	50                   	push   %eax
 5d6:	ff 75 08             	push   0x8(%ebp)
 5d9:	e8 bf fd ff ff       	call   39d <putc>
 5de:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5e1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 5e8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5ec:	8b 55 0c             	mov    0xc(%ebp),%edx
 5ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5f2:	01 d0                	add    %edx,%eax
 5f4:	0f b6 00             	movzbl (%eax),%eax
 5f7:	84 c0                	test   %al,%al
 5f9:	0f 85 94 fe ff ff    	jne    493 <printf+0x22>
    }
  }
}
 5ff:	90                   	nop
 600:	90                   	nop
 601:	c9                   	leave  
 602:	c3                   	ret    

00000603 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 603:	55                   	push   %ebp
 604:	89 e5                	mov    %esp,%ebp
 606:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 609:	8b 45 08             	mov    0x8(%ebp),%eax
 60c:	83 e8 08             	sub    $0x8,%eax
 60f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 612:	a1 b4 0a 00 00       	mov    0xab4,%eax
 617:	89 45 fc             	mov    %eax,-0x4(%ebp)
 61a:	eb 24                	jmp    640 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 61c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 61f:	8b 00                	mov    (%eax),%eax
 621:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 624:	72 12                	jb     638 <free+0x35>
 626:	8b 45 f8             	mov    -0x8(%ebp),%eax
 629:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 62c:	77 24                	ja     652 <free+0x4f>
 62e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 631:	8b 00                	mov    (%eax),%eax
 633:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 636:	72 1a                	jb     652 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 638:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63b:	8b 00                	mov    (%eax),%eax
 63d:	89 45 fc             	mov    %eax,-0x4(%ebp)
 640:	8b 45 f8             	mov    -0x8(%ebp),%eax
 643:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 646:	76 d4                	jbe    61c <free+0x19>
 648:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64b:	8b 00                	mov    (%eax),%eax
 64d:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 650:	73 ca                	jae    61c <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 652:	8b 45 f8             	mov    -0x8(%ebp),%eax
 655:	8b 40 04             	mov    0x4(%eax),%eax
 658:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 65f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 662:	01 c2                	add    %eax,%edx
 664:	8b 45 fc             	mov    -0x4(%ebp),%eax
 667:	8b 00                	mov    (%eax),%eax
 669:	39 c2                	cmp    %eax,%edx
 66b:	75 24                	jne    691 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 66d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 670:	8b 50 04             	mov    0x4(%eax),%edx
 673:	8b 45 fc             	mov    -0x4(%ebp),%eax
 676:	8b 00                	mov    (%eax),%eax
 678:	8b 40 04             	mov    0x4(%eax),%eax
 67b:	01 c2                	add    %eax,%edx
 67d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 680:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 683:	8b 45 fc             	mov    -0x4(%ebp),%eax
 686:	8b 00                	mov    (%eax),%eax
 688:	8b 10                	mov    (%eax),%edx
 68a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68d:	89 10                	mov    %edx,(%eax)
 68f:	eb 0a                	jmp    69b <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 691:	8b 45 fc             	mov    -0x4(%ebp),%eax
 694:	8b 10                	mov    (%eax),%edx
 696:	8b 45 f8             	mov    -0x8(%ebp),%eax
 699:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 69b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69e:	8b 40 04             	mov    0x4(%eax),%eax
 6a1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ab:	01 d0                	add    %edx,%eax
 6ad:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 6b0:	75 20                	jne    6d2 <free+0xcf>
    p->s.size += bp->s.size;
 6b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b5:	8b 50 04             	mov    0x4(%eax),%edx
 6b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6bb:	8b 40 04             	mov    0x4(%eax),%eax
 6be:	01 c2                	add    %eax,%edx
 6c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c3:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c9:	8b 10                	mov    (%eax),%edx
 6cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ce:	89 10                	mov    %edx,(%eax)
 6d0:	eb 08                	jmp    6da <free+0xd7>
  } else
    p->s.ptr = bp;
 6d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d5:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6d8:	89 10                	mov    %edx,(%eax)
  freep = p;
 6da:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6dd:	a3 b4 0a 00 00       	mov    %eax,0xab4
}
 6e2:	90                   	nop
 6e3:	c9                   	leave  
 6e4:	c3                   	ret    

000006e5 <morecore>:

static Header*
morecore(uint nu)
{
 6e5:	55                   	push   %ebp
 6e6:	89 e5                	mov    %esp,%ebp
 6e8:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6eb:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6f2:	77 07                	ja     6fb <morecore+0x16>
    nu = 4096;
 6f4:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6fb:	8b 45 08             	mov    0x8(%ebp),%eax
 6fe:	c1 e0 03             	shl    $0x3,%eax
 701:	83 ec 0c             	sub    $0xc,%esp
 704:	50                   	push   %eax
 705:	e8 6b fc ff ff       	call   375 <sbrk>
 70a:	83 c4 10             	add    $0x10,%esp
 70d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 710:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 714:	75 07                	jne    71d <morecore+0x38>
    return 0;
 716:	b8 00 00 00 00       	mov    $0x0,%eax
 71b:	eb 26                	jmp    743 <morecore+0x5e>
  hp = (Header*)p;
 71d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 720:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 723:	8b 45 f0             	mov    -0x10(%ebp),%eax
 726:	8b 55 08             	mov    0x8(%ebp),%edx
 729:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 72c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 72f:	83 c0 08             	add    $0x8,%eax
 732:	83 ec 0c             	sub    $0xc,%esp
 735:	50                   	push   %eax
 736:	e8 c8 fe ff ff       	call   603 <free>
 73b:	83 c4 10             	add    $0x10,%esp
  return freep;
 73e:	a1 b4 0a 00 00       	mov    0xab4,%eax
}
 743:	c9                   	leave  
 744:	c3                   	ret    

00000745 <malloc>:

void*
malloc(uint nbytes)
{
 745:	55                   	push   %ebp
 746:	89 e5                	mov    %esp,%ebp
 748:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 74b:	8b 45 08             	mov    0x8(%ebp),%eax
 74e:	83 c0 07             	add    $0x7,%eax
 751:	c1 e8 03             	shr    $0x3,%eax
 754:	83 c0 01             	add    $0x1,%eax
 757:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 75a:	a1 b4 0a 00 00       	mov    0xab4,%eax
 75f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 762:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 766:	75 23                	jne    78b <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 768:	c7 45 f0 ac 0a 00 00 	movl   $0xaac,-0x10(%ebp)
 76f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 772:	a3 b4 0a 00 00       	mov    %eax,0xab4
 777:	a1 b4 0a 00 00       	mov    0xab4,%eax
 77c:	a3 ac 0a 00 00       	mov    %eax,0xaac
    base.s.size = 0;
 781:	c7 05 b0 0a 00 00 00 	movl   $0x0,0xab0
 788:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 78b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 78e:	8b 00                	mov    (%eax),%eax
 790:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 793:	8b 45 f4             	mov    -0xc(%ebp),%eax
 796:	8b 40 04             	mov    0x4(%eax),%eax
 799:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 79c:	77 4d                	ja     7eb <malloc+0xa6>
      if(p->s.size == nunits)
 79e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a1:	8b 40 04             	mov    0x4(%eax),%eax
 7a4:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7a7:	75 0c                	jne    7b5 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ac:	8b 10                	mov    (%eax),%edx
 7ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b1:	89 10                	mov    %edx,(%eax)
 7b3:	eb 26                	jmp    7db <malloc+0x96>
      else {
        p->s.size -= nunits;
 7b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b8:	8b 40 04             	mov    0x4(%eax),%eax
 7bb:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7be:	89 c2                	mov    %eax,%edx
 7c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c3:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c9:	8b 40 04             	mov    0x4(%eax),%eax
 7cc:	c1 e0 03             	shl    $0x3,%eax
 7cf:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d5:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7d8:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7db:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7de:	a3 b4 0a 00 00       	mov    %eax,0xab4
      return (void*)(p + 1);
 7e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e6:	83 c0 08             	add    $0x8,%eax
 7e9:	eb 3b                	jmp    826 <malloc+0xe1>
    }
    if(p == freep)
 7eb:	a1 b4 0a 00 00       	mov    0xab4,%eax
 7f0:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7f3:	75 1e                	jne    813 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7f5:	83 ec 0c             	sub    $0xc,%esp
 7f8:	ff 75 ec             	push   -0x14(%ebp)
 7fb:	e8 e5 fe ff ff       	call   6e5 <morecore>
 800:	83 c4 10             	add    $0x10,%esp
 803:	89 45 f4             	mov    %eax,-0xc(%ebp)
 806:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 80a:	75 07                	jne    813 <malloc+0xce>
        return 0;
 80c:	b8 00 00 00 00       	mov    $0x0,%eax
 811:	eb 13                	jmp    826 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 813:	8b 45 f4             	mov    -0xc(%ebp),%eax
 816:	89 45 f0             	mov    %eax,-0x10(%ebp)
 819:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81c:	8b 00                	mov    (%eax),%eax
 81e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 821:	e9 6d ff ff ff       	jmp    793 <malloc+0x4e>
  }
}
 826:	c9                   	leave  
 827:	c3                   	ret    
