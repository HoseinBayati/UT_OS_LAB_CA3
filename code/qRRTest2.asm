
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
  1d:	68 38 08 00 00       	push   $0x838
  22:	6a 01                	push   $0x1
  24:	e8 58 04 00 00       	call   481 <printf>
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
SYSCALL(change_queue)
 395:	b8 17 00 00 00       	mov    $0x17,%eax
 39a:	cd 40                	int    $0x40
 39c:	c3                   	ret    

0000039d <change_local_bjf>:
SYSCALL(change_local_bjf)
 39d:	b8 18 00 00 00       	mov    $0x18,%eax
 3a2:	cd 40                	int    $0x40
 3a4:	c3                   	ret    

000003a5 <change_global_bjf>:
SYSCALL(change_global_bjf)
 3a5:	b8 19 00 00 00       	mov    $0x19,%eax
 3aa:	cd 40                	int    $0x40
 3ac:	c3                   	ret    

000003ad <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3ad:	55                   	push   %ebp
 3ae:	89 e5                	mov    %esp,%ebp
 3b0:	83 ec 18             	sub    $0x18,%esp
 3b3:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b6:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3b9:	83 ec 04             	sub    $0x4,%esp
 3bc:	6a 01                	push   $0x1
 3be:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3c1:	50                   	push   %eax
 3c2:	ff 75 08             	push   0x8(%ebp)
 3c5:	e8 43 ff ff ff       	call   30d <write>
 3ca:	83 c4 10             	add    $0x10,%esp
}
 3cd:	90                   	nop
 3ce:	c9                   	leave  
 3cf:	c3                   	ret    

000003d0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3d6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3dd:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3e1:	74 17                	je     3fa <printint+0x2a>
 3e3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3e7:	79 11                	jns    3fa <printint+0x2a>
    neg = 1;
 3e9:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3f0:	8b 45 0c             	mov    0xc(%ebp),%eax
 3f3:	f7 d8                	neg    %eax
 3f5:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3f8:	eb 06                	jmp    400 <printint+0x30>
  } else {
    x = xx;
 3fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 3fd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 400:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 407:	8b 4d 10             	mov    0x10(%ebp),%ecx
 40a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 40d:	ba 00 00 00 00       	mov    $0x0,%edx
 412:	f7 f1                	div    %ecx
 414:	89 d1                	mov    %edx,%ecx
 416:	8b 45 f4             	mov    -0xc(%ebp),%eax
 419:	8d 50 01             	lea    0x1(%eax),%edx
 41c:	89 55 f4             	mov    %edx,-0xc(%ebp)
 41f:	0f b6 91 a8 0a 00 00 	movzbl 0xaa8(%ecx),%edx
 426:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 42a:	8b 4d 10             	mov    0x10(%ebp),%ecx
 42d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 430:	ba 00 00 00 00       	mov    $0x0,%edx
 435:	f7 f1                	div    %ecx
 437:	89 45 ec             	mov    %eax,-0x14(%ebp)
 43a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 43e:	75 c7                	jne    407 <printint+0x37>
  if(neg)
 440:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 444:	74 2d                	je     473 <printint+0xa3>
    buf[i++] = '-';
 446:	8b 45 f4             	mov    -0xc(%ebp),%eax
 449:	8d 50 01             	lea    0x1(%eax),%edx
 44c:	89 55 f4             	mov    %edx,-0xc(%ebp)
 44f:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 454:	eb 1d                	jmp    473 <printint+0xa3>
    putc(fd, buf[i]);
 456:	8d 55 dc             	lea    -0x24(%ebp),%edx
 459:	8b 45 f4             	mov    -0xc(%ebp),%eax
 45c:	01 d0                	add    %edx,%eax
 45e:	0f b6 00             	movzbl (%eax),%eax
 461:	0f be c0             	movsbl %al,%eax
 464:	83 ec 08             	sub    $0x8,%esp
 467:	50                   	push   %eax
 468:	ff 75 08             	push   0x8(%ebp)
 46b:	e8 3d ff ff ff       	call   3ad <putc>
 470:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 473:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 477:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 47b:	79 d9                	jns    456 <printint+0x86>
}
 47d:	90                   	nop
 47e:	90                   	nop
 47f:	c9                   	leave  
 480:	c3                   	ret    

00000481 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 481:	55                   	push   %ebp
 482:	89 e5                	mov    %esp,%ebp
 484:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 487:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 48e:	8d 45 0c             	lea    0xc(%ebp),%eax
 491:	83 c0 04             	add    $0x4,%eax
 494:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 497:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 49e:	e9 59 01 00 00       	jmp    5fc <printf+0x17b>
    c = fmt[i] & 0xff;
 4a3:	8b 55 0c             	mov    0xc(%ebp),%edx
 4a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4a9:	01 d0                	add    %edx,%eax
 4ab:	0f b6 00             	movzbl (%eax),%eax
 4ae:	0f be c0             	movsbl %al,%eax
 4b1:	25 ff 00 00 00       	and    $0xff,%eax
 4b6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4b9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4bd:	75 2c                	jne    4eb <printf+0x6a>
      if(c == '%'){
 4bf:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4c3:	75 0c                	jne    4d1 <printf+0x50>
        state = '%';
 4c5:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4cc:	e9 27 01 00 00       	jmp    5f8 <printf+0x177>
      } else {
        putc(fd, c);
 4d1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4d4:	0f be c0             	movsbl %al,%eax
 4d7:	83 ec 08             	sub    $0x8,%esp
 4da:	50                   	push   %eax
 4db:	ff 75 08             	push   0x8(%ebp)
 4de:	e8 ca fe ff ff       	call   3ad <putc>
 4e3:	83 c4 10             	add    $0x10,%esp
 4e6:	e9 0d 01 00 00       	jmp    5f8 <printf+0x177>
      }
    } else if(state == '%'){
 4eb:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4ef:	0f 85 03 01 00 00    	jne    5f8 <printf+0x177>
      if(c == 'd'){
 4f5:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4f9:	75 1e                	jne    519 <printf+0x98>
        printint(fd, *ap, 10, 1);
 4fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4fe:	8b 00                	mov    (%eax),%eax
 500:	6a 01                	push   $0x1
 502:	6a 0a                	push   $0xa
 504:	50                   	push   %eax
 505:	ff 75 08             	push   0x8(%ebp)
 508:	e8 c3 fe ff ff       	call   3d0 <printint>
 50d:	83 c4 10             	add    $0x10,%esp
        ap++;
 510:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 514:	e9 d8 00 00 00       	jmp    5f1 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 519:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 51d:	74 06                	je     525 <printf+0xa4>
 51f:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 523:	75 1e                	jne    543 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 525:	8b 45 e8             	mov    -0x18(%ebp),%eax
 528:	8b 00                	mov    (%eax),%eax
 52a:	6a 00                	push   $0x0
 52c:	6a 10                	push   $0x10
 52e:	50                   	push   %eax
 52f:	ff 75 08             	push   0x8(%ebp)
 532:	e8 99 fe ff ff       	call   3d0 <printint>
 537:	83 c4 10             	add    $0x10,%esp
        ap++;
 53a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 53e:	e9 ae 00 00 00       	jmp    5f1 <printf+0x170>
      } else if(c == 's'){
 543:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 547:	75 43                	jne    58c <printf+0x10b>
        s = (char*)*ap;
 549:	8b 45 e8             	mov    -0x18(%ebp),%eax
 54c:	8b 00                	mov    (%eax),%eax
 54e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 551:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 555:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 559:	75 25                	jne    580 <printf+0xff>
          s = "(null)";
 55b:	c7 45 f4 3b 08 00 00 	movl   $0x83b,-0xc(%ebp)
        while(*s != 0){
 562:	eb 1c                	jmp    580 <printf+0xff>
          putc(fd, *s);
 564:	8b 45 f4             	mov    -0xc(%ebp),%eax
 567:	0f b6 00             	movzbl (%eax),%eax
 56a:	0f be c0             	movsbl %al,%eax
 56d:	83 ec 08             	sub    $0x8,%esp
 570:	50                   	push   %eax
 571:	ff 75 08             	push   0x8(%ebp)
 574:	e8 34 fe ff ff       	call   3ad <putc>
 579:	83 c4 10             	add    $0x10,%esp
          s++;
 57c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 580:	8b 45 f4             	mov    -0xc(%ebp),%eax
 583:	0f b6 00             	movzbl (%eax),%eax
 586:	84 c0                	test   %al,%al
 588:	75 da                	jne    564 <printf+0xe3>
 58a:	eb 65                	jmp    5f1 <printf+0x170>
        }
      } else if(c == 'c'){
 58c:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 590:	75 1d                	jne    5af <printf+0x12e>
        putc(fd, *ap);
 592:	8b 45 e8             	mov    -0x18(%ebp),%eax
 595:	8b 00                	mov    (%eax),%eax
 597:	0f be c0             	movsbl %al,%eax
 59a:	83 ec 08             	sub    $0x8,%esp
 59d:	50                   	push   %eax
 59e:	ff 75 08             	push   0x8(%ebp)
 5a1:	e8 07 fe ff ff       	call   3ad <putc>
 5a6:	83 c4 10             	add    $0x10,%esp
        ap++;
 5a9:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5ad:	eb 42                	jmp    5f1 <printf+0x170>
      } else if(c == '%'){
 5af:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5b3:	75 17                	jne    5cc <printf+0x14b>
        putc(fd, c);
 5b5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5b8:	0f be c0             	movsbl %al,%eax
 5bb:	83 ec 08             	sub    $0x8,%esp
 5be:	50                   	push   %eax
 5bf:	ff 75 08             	push   0x8(%ebp)
 5c2:	e8 e6 fd ff ff       	call   3ad <putc>
 5c7:	83 c4 10             	add    $0x10,%esp
 5ca:	eb 25                	jmp    5f1 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5cc:	83 ec 08             	sub    $0x8,%esp
 5cf:	6a 25                	push   $0x25
 5d1:	ff 75 08             	push   0x8(%ebp)
 5d4:	e8 d4 fd ff ff       	call   3ad <putc>
 5d9:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5dc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5df:	0f be c0             	movsbl %al,%eax
 5e2:	83 ec 08             	sub    $0x8,%esp
 5e5:	50                   	push   %eax
 5e6:	ff 75 08             	push   0x8(%ebp)
 5e9:	e8 bf fd ff ff       	call   3ad <putc>
 5ee:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5f1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 5f8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5fc:	8b 55 0c             	mov    0xc(%ebp),%edx
 5ff:	8b 45 f0             	mov    -0x10(%ebp),%eax
 602:	01 d0                	add    %edx,%eax
 604:	0f b6 00             	movzbl (%eax),%eax
 607:	84 c0                	test   %al,%al
 609:	0f 85 94 fe ff ff    	jne    4a3 <printf+0x22>
    }
  }
}
 60f:	90                   	nop
 610:	90                   	nop
 611:	c9                   	leave  
 612:	c3                   	ret    

00000613 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 613:	55                   	push   %ebp
 614:	89 e5                	mov    %esp,%ebp
 616:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 619:	8b 45 08             	mov    0x8(%ebp),%eax
 61c:	83 e8 08             	sub    $0x8,%eax
 61f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 622:	a1 c4 0a 00 00       	mov    0xac4,%eax
 627:	89 45 fc             	mov    %eax,-0x4(%ebp)
 62a:	eb 24                	jmp    650 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 62c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 62f:	8b 00                	mov    (%eax),%eax
 631:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 634:	72 12                	jb     648 <free+0x35>
 636:	8b 45 f8             	mov    -0x8(%ebp),%eax
 639:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 63c:	77 24                	ja     662 <free+0x4f>
 63e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 641:	8b 00                	mov    (%eax),%eax
 643:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 646:	72 1a                	jb     662 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 648:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64b:	8b 00                	mov    (%eax),%eax
 64d:	89 45 fc             	mov    %eax,-0x4(%ebp)
 650:	8b 45 f8             	mov    -0x8(%ebp),%eax
 653:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 656:	76 d4                	jbe    62c <free+0x19>
 658:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65b:	8b 00                	mov    (%eax),%eax
 65d:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 660:	73 ca                	jae    62c <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 662:	8b 45 f8             	mov    -0x8(%ebp),%eax
 665:	8b 40 04             	mov    0x4(%eax),%eax
 668:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 66f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 672:	01 c2                	add    %eax,%edx
 674:	8b 45 fc             	mov    -0x4(%ebp),%eax
 677:	8b 00                	mov    (%eax),%eax
 679:	39 c2                	cmp    %eax,%edx
 67b:	75 24                	jne    6a1 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 67d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 680:	8b 50 04             	mov    0x4(%eax),%edx
 683:	8b 45 fc             	mov    -0x4(%ebp),%eax
 686:	8b 00                	mov    (%eax),%eax
 688:	8b 40 04             	mov    0x4(%eax),%eax
 68b:	01 c2                	add    %eax,%edx
 68d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 690:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 693:	8b 45 fc             	mov    -0x4(%ebp),%eax
 696:	8b 00                	mov    (%eax),%eax
 698:	8b 10                	mov    (%eax),%edx
 69a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69d:	89 10                	mov    %edx,(%eax)
 69f:	eb 0a                	jmp    6ab <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6a1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a4:	8b 10                	mov    (%eax),%edx
 6a6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a9:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ae:	8b 40 04             	mov    0x4(%eax),%eax
 6b1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bb:	01 d0                	add    %edx,%eax
 6bd:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 6c0:	75 20                	jne    6e2 <free+0xcf>
    p->s.size += bp->s.size;
 6c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c5:	8b 50 04             	mov    0x4(%eax),%edx
 6c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6cb:	8b 40 04             	mov    0x4(%eax),%eax
 6ce:	01 c2                	add    %eax,%edx
 6d0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d3:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6d6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d9:	8b 10                	mov    (%eax),%edx
 6db:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6de:	89 10                	mov    %edx,(%eax)
 6e0:	eb 08                	jmp    6ea <free+0xd7>
  } else
    p->s.ptr = bp;
 6e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e5:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6e8:	89 10                	mov    %edx,(%eax)
  freep = p;
 6ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ed:	a3 c4 0a 00 00       	mov    %eax,0xac4
}
 6f2:	90                   	nop
 6f3:	c9                   	leave  
 6f4:	c3                   	ret    

000006f5 <morecore>:

static Header*
morecore(uint nu)
{
 6f5:	55                   	push   %ebp
 6f6:	89 e5                	mov    %esp,%ebp
 6f8:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6fb:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 702:	77 07                	ja     70b <morecore+0x16>
    nu = 4096;
 704:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 70b:	8b 45 08             	mov    0x8(%ebp),%eax
 70e:	c1 e0 03             	shl    $0x3,%eax
 711:	83 ec 0c             	sub    $0xc,%esp
 714:	50                   	push   %eax
 715:	e8 5b fc ff ff       	call   375 <sbrk>
 71a:	83 c4 10             	add    $0x10,%esp
 71d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 720:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 724:	75 07                	jne    72d <morecore+0x38>
    return 0;
 726:	b8 00 00 00 00       	mov    $0x0,%eax
 72b:	eb 26                	jmp    753 <morecore+0x5e>
  hp = (Header*)p;
 72d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 730:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 733:	8b 45 f0             	mov    -0x10(%ebp),%eax
 736:	8b 55 08             	mov    0x8(%ebp),%edx
 739:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 73c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 73f:	83 c0 08             	add    $0x8,%eax
 742:	83 ec 0c             	sub    $0xc,%esp
 745:	50                   	push   %eax
 746:	e8 c8 fe ff ff       	call   613 <free>
 74b:	83 c4 10             	add    $0x10,%esp
  return freep;
 74e:	a1 c4 0a 00 00       	mov    0xac4,%eax
}
 753:	c9                   	leave  
 754:	c3                   	ret    

00000755 <malloc>:

void*
malloc(uint nbytes)
{
 755:	55                   	push   %ebp
 756:	89 e5                	mov    %esp,%ebp
 758:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 75b:	8b 45 08             	mov    0x8(%ebp),%eax
 75e:	83 c0 07             	add    $0x7,%eax
 761:	c1 e8 03             	shr    $0x3,%eax
 764:	83 c0 01             	add    $0x1,%eax
 767:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 76a:	a1 c4 0a 00 00       	mov    0xac4,%eax
 76f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 772:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 776:	75 23                	jne    79b <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 778:	c7 45 f0 bc 0a 00 00 	movl   $0xabc,-0x10(%ebp)
 77f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 782:	a3 c4 0a 00 00       	mov    %eax,0xac4
 787:	a1 c4 0a 00 00       	mov    0xac4,%eax
 78c:	a3 bc 0a 00 00       	mov    %eax,0xabc
    base.s.size = 0;
 791:	c7 05 c0 0a 00 00 00 	movl   $0x0,0xac0
 798:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 79b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 79e:	8b 00                	mov    (%eax),%eax
 7a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7a3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a6:	8b 40 04             	mov    0x4(%eax),%eax
 7a9:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7ac:	77 4d                	ja     7fb <malloc+0xa6>
      if(p->s.size == nunits)
 7ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b1:	8b 40 04             	mov    0x4(%eax),%eax
 7b4:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7b7:	75 0c                	jne    7c5 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7bc:	8b 10                	mov    (%eax),%edx
 7be:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c1:	89 10                	mov    %edx,(%eax)
 7c3:	eb 26                	jmp    7eb <malloc+0x96>
      else {
        p->s.size -= nunits;
 7c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c8:	8b 40 04             	mov    0x4(%eax),%eax
 7cb:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7ce:	89 c2                	mov    %eax,%edx
 7d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d3:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d9:	8b 40 04             	mov    0x4(%eax),%eax
 7dc:	c1 e0 03             	shl    $0x3,%eax
 7df:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e5:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7e8:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ee:	a3 c4 0a 00 00       	mov    %eax,0xac4
      return (void*)(p + 1);
 7f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f6:	83 c0 08             	add    $0x8,%eax
 7f9:	eb 3b                	jmp    836 <malloc+0xe1>
    }
    if(p == freep)
 7fb:	a1 c4 0a 00 00       	mov    0xac4,%eax
 800:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 803:	75 1e                	jne    823 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 805:	83 ec 0c             	sub    $0xc,%esp
 808:	ff 75 ec             	push   -0x14(%ebp)
 80b:	e8 e5 fe ff ff       	call   6f5 <morecore>
 810:	83 c4 10             	add    $0x10,%esp
 813:	89 45 f4             	mov    %eax,-0xc(%ebp)
 816:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 81a:	75 07                	jne    823 <malloc+0xce>
        return 0;
 81c:	b8 00 00 00 00       	mov    $0x0,%eax
 821:	eb 13                	jmp    836 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 823:	8b 45 f4             	mov    -0xc(%ebp),%eax
 826:	89 45 f0             	mov    %eax,-0x10(%ebp)
 829:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82c:	8b 00                	mov    (%eax),%eax
 82e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 831:	e9 6d ff ff ff       	jmp    7a3 <malloc+0x4e>
  }
}
 836:	c9                   	leave  
 837:	c3                   	ret    
