
_qRRTest:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"



int main()
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
   6:	83 ec 20             	sub    $0x20,%esp
    int pid = fork();
   9:	e8 28 03 00 00       	call   336 <fork>
   e:	89 44 24 0c          	mov    %eax,0xc(%esp)
    if(pid == 0)
  12:	83 7c 24 0c 00       	cmpl   $0x0,0xc(%esp)
  17:	75 37                	jne    50 <main+0x50>
    {
        for(uint i = 0; i < 99999999; i++)
  19:	c7 44 24 1c 00 00 00 	movl   $0x0,0x1c(%esp)
  20:	00 
  21:	eb 1e                	jmp    41 <main+0x41>
        {
            for(uint j = 0; j < 9999; j++)
  23:	c7 44 24 18 00 00 00 	movl   $0x0,0x18(%esp)
  2a:	00 
  2b:	eb 05                	jmp    32 <main+0x32>
  2d:	83 44 24 18 01       	addl   $0x1,0x18(%esp)
  32:	81 7c 24 18 0e 27 00 	cmpl   $0x270e,0x18(%esp)
  39:	00 
  3a:	76 f1                	jbe    2d <main+0x2d>
        for(uint i = 0; i < 99999999; i++)
  3c:	83 44 24 1c 01       	addl   $0x1,0x1c(%esp)
  41:	81 7c 24 1c fe e0 f5 	cmpl   $0x5f5e0fe,0x1c(%esp)
  48:	05 
  49:	76 d8                	jbe    23 <main+0x23>
            {
            }
        }
        exit();
  4b:	e8 ee 02 00 00       	call   33e <exit>
    }
    for(uint i = 0; i < 99999999; i++)
  50:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
  57:	00 
  58:	eb 1e                	jmp    78 <main+0x78>
    {
        for(uint j = 0; j < 9999; j++)
  5a:	c7 44 24 10 00 00 00 	movl   $0x0,0x10(%esp)
  61:	00 
  62:	eb 05                	jmp    69 <main+0x69>
  64:	83 44 24 10 01       	addl   $0x1,0x10(%esp)
  69:	81 7c 24 10 0e 27 00 	cmpl   $0x270e,0x10(%esp)
  70:	00 
  71:	76 f1                	jbe    64 <main+0x64>
    for(uint i = 0; i < 99999999; i++)
  73:	83 44 24 14 01       	addl   $0x1,0x14(%esp)
  78:	81 7c 24 14 fe e0 f5 	cmpl   $0x5f5e0fe,0x14(%esp)
  7f:	05 
  80:	76 d8                	jbe    5a <main+0x5a>
        {
        }
    }
    wait();
  82:	e8 bf 02 00 00       	call   346 <wait>
    exit();
  87:	e8 b2 02 00 00       	call   33e <exit>

0000008c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  8c:	55                   	push   %ebp
  8d:	89 e5                	mov    %esp,%ebp
  8f:	57                   	push   %edi
  90:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  91:	8b 4d 08             	mov    0x8(%ebp),%ecx
  94:	8b 55 10             	mov    0x10(%ebp),%edx
  97:	8b 45 0c             	mov    0xc(%ebp),%eax
  9a:	89 cb                	mov    %ecx,%ebx
  9c:	89 df                	mov    %ebx,%edi
  9e:	89 d1                	mov    %edx,%ecx
  a0:	fc                   	cld    
  a1:	f3 aa                	rep stos %al,%es:(%edi)
  a3:	89 ca                	mov    %ecx,%edx
  a5:	89 fb                	mov    %edi,%ebx
  a7:	89 5d 08             	mov    %ebx,0x8(%ebp)
  aa:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  ad:	90                   	nop
  ae:	5b                   	pop    %ebx
  af:	5f                   	pop    %edi
  b0:	5d                   	pop    %ebp
  b1:	c3                   	ret    

000000b2 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  b2:	55                   	push   %ebp
  b3:	89 e5                	mov    %esp,%ebp
  b5:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  b8:	8b 45 08             	mov    0x8(%ebp),%eax
  bb:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  be:	90                   	nop
  bf:	8b 55 0c             	mov    0xc(%ebp),%edx
  c2:	8d 42 01             	lea    0x1(%edx),%eax
  c5:	89 45 0c             	mov    %eax,0xc(%ebp)
  c8:	8b 45 08             	mov    0x8(%ebp),%eax
  cb:	8d 48 01             	lea    0x1(%eax),%ecx
  ce:	89 4d 08             	mov    %ecx,0x8(%ebp)
  d1:	0f b6 12             	movzbl (%edx),%edx
  d4:	88 10                	mov    %dl,(%eax)
  d6:	0f b6 00             	movzbl (%eax),%eax
  d9:	84 c0                	test   %al,%al
  db:	75 e2                	jne    bf <strcpy+0xd>
    ;
  return os;
  dd:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e0:	c9                   	leave  
  e1:	c3                   	ret    

000000e2 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  e2:	55                   	push   %ebp
  e3:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  e5:	eb 08                	jmp    ef <strcmp+0xd>
    p++, q++;
  e7:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  eb:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
  ef:	8b 45 08             	mov    0x8(%ebp),%eax
  f2:	0f b6 00             	movzbl (%eax),%eax
  f5:	84 c0                	test   %al,%al
  f7:	74 10                	je     109 <strcmp+0x27>
  f9:	8b 45 08             	mov    0x8(%ebp),%eax
  fc:	0f b6 10             	movzbl (%eax),%edx
  ff:	8b 45 0c             	mov    0xc(%ebp),%eax
 102:	0f b6 00             	movzbl (%eax),%eax
 105:	38 c2                	cmp    %al,%dl
 107:	74 de                	je     e7 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 109:	8b 45 08             	mov    0x8(%ebp),%eax
 10c:	0f b6 00             	movzbl (%eax),%eax
 10f:	0f b6 d0             	movzbl %al,%edx
 112:	8b 45 0c             	mov    0xc(%ebp),%eax
 115:	0f b6 00             	movzbl (%eax),%eax
 118:	0f b6 c8             	movzbl %al,%ecx
 11b:	89 d0                	mov    %edx,%eax
 11d:	29 c8                	sub    %ecx,%eax
}
 11f:	5d                   	pop    %ebp
 120:	c3                   	ret    

00000121 <strlen>:

uint
strlen(const char *s)
{
 121:	55                   	push   %ebp
 122:	89 e5                	mov    %esp,%ebp
 124:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 127:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 12e:	eb 04                	jmp    134 <strlen+0x13>
 130:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 134:	8b 55 fc             	mov    -0x4(%ebp),%edx
 137:	8b 45 08             	mov    0x8(%ebp),%eax
 13a:	01 d0                	add    %edx,%eax
 13c:	0f b6 00             	movzbl (%eax),%eax
 13f:	84 c0                	test   %al,%al
 141:	75 ed                	jne    130 <strlen+0xf>
    ;
  return n;
 143:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 146:	c9                   	leave  
 147:	c3                   	ret    

00000148 <memset>:

void*
memset(void *dst, int c, uint n)
{
 148:	55                   	push   %ebp
 149:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 14b:	8b 45 10             	mov    0x10(%ebp),%eax
 14e:	50                   	push   %eax
 14f:	ff 75 0c             	push   0xc(%ebp)
 152:	ff 75 08             	push   0x8(%ebp)
 155:	e8 32 ff ff ff       	call   8c <stosb>
 15a:	83 c4 0c             	add    $0xc,%esp
  return dst;
 15d:	8b 45 08             	mov    0x8(%ebp),%eax
}
 160:	c9                   	leave  
 161:	c3                   	ret    

00000162 <strchr>:

char*
strchr(const char *s, char c)
{
 162:	55                   	push   %ebp
 163:	89 e5                	mov    %esp,%ebp
 165:	83 ec 04             	sub    $0x4,%esp
 168:	8b 45 0c             	mov    0xc(%ebp),%eax
 16b:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 16e:	eb 14                	jmp    184 <strchr+0x22>
    if(*s == c)
 170:	8b 45 08             	mov    0x8(%ebp),%eax
 173:	0f b6 00             	movzbl (%eax),%eax
 176:	38 45 fc             	cmp    %al,-0x4(%ebp)
 179:	75 05                	jne    180 <strchr+0x1e>
      return (char*)s;
 17b:	8b 45 08             	mov    0x8(%ebp),%eax
 17e:	eb 13                	jmp    193 <strchr+0x31>
  for(; *s; s++)
 180:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 184:	8b 45 08             	mov    0x8(%ebp),%eax
 187:	0f b6 00             	movzbl (%eax),%eax
 18a:	84 c0                	test   %al,%al
 18c:	75 e2                	jne    170 <strchr+0xe>
  return 0;
 18e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 193:	c9                   	leave  
 194:	c3                   	ret    

00000195 <gets>:

char*
gets(char *buf, int max)
{
 195:	55                   	push   %ebp
 196:	89 e5                	mov    %esp,%ebp
 198:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 19b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 1a2:	eb 42                	jmp    1e6 <gets+0x51>
    cc = read(0, &c, 1);
 1a4:	83 ec 04             	sub    $0x4,%esp
 1a7:	6a 01                	push   $0x1
 1a9:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1ac:	50                   	push   %eax
 1ad:	6a 00                	push   $0x0
 1af:	e8 a2 01 00 00       	call   356 <read>
 1b4:	83 c4 10             	add    $0x10,%esp
 1b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1ba:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1be:	7e 33                	jle    1f3 <gets+0x5e>
      break;
    buf[i++] = c;
 1c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c3:	8d 50 01             	lea    0x1(%eax),%edx
 1c6:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1c9:	89 c2                	mov    %eax,%edx
 1cb:	8b 45 08             	mov    0x8(%ebp),%eax
 1ce:	01 c2                	add    %eax,%edx
 1d0:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d4:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1d6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1da:	3c 0a                	cmp    $0xa,%al
 1dc:	74 16                	je     1f4 <gets+0x5f>
 1de:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1e2:	3c 0d                	cmp    $0xd,%al
 1e4:	74 0e                	je     1f4 <gets+0x5f>
  for(i=0; i+1 < max; ){
 1e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1e9:	83 c0 01             	add    $0x1,%eax
 1ec:	39 45 0c             	cmp    %eax,0xc(%ebp)
 1ef:	7f b3                	jg     1a4 <gets+0xf>
 1f1:	eb 01                	jmp    1f4 <gets+0x5f>
      break;
 1f3:	90                   	nop
      break;
  }
  buf[i] = '\0';
 1f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1f7:	8b 45 08             	mov    0x8(%ebp),%eax
 1fa:	01 d0                	add    %edx,%eax
 1fc:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1ff:	8b 45 08             	mov    0x8(%ebp),%eax
}
 202:	c9                   	leave  
 203:	c3                   	ret    

00000204 <stat>:

int
stat(const char *n, struct stat *st)
{
 204:	55                   	push   %ebp
 205:	89 e5                	mov    %esp,%ebp
 207:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 20a:	83 ec 08             	sub    $0x8,%esp
 20d:	6a 00                	push   $0x0
 20f:	ff 75 08             	push   0x8(%ebp)
 212:	e8 67 01 00 00       	call   37e <open>
 217:	83 c4 10             	add    $0x10,%esp
 21a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 21d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 221:	79 07                	jns    22a <stat+0x26>
    return -1;
 223:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 228:	eb 25                	jmp    24f <stat+0x4b>
  r = fstat(fd, st);
 22a:	83 ec 08             	sub    $0x8,%esp
 22d:	ff 75 0c             	push   0xc(%ebp)
 230:	ff 75 f4             	push   -0xc(%ebp)
 233:	e8 5e 01 00 00       	call   396 <fstat>
 238:	83 c4 10             	add    $0x10,%esp
 23b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 23e:	83 ec 0c             	sub    $0xc,%esp
 241:	ff 75 f4             	push   -0xc(%ebp)
 244:	e8 1d 01 00 00       	call   366 <close>
 249:	83 c4 10             	add    $0x10,%esp
  return r;
 24c:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 24f:	c9                   	leave  
 250:	c3                   	ret    

00000251 <atoi>:

int
atoi(const char *s)
{
 251:	55                   	push   %ebp
 252:	89 e5                	mov    %esp,%ebp
 254:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 257:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 25e:	eb 25                	jmp    285 <atoi+0x34>
    n = n*10 + *s++ - '0';
 260:	8b 55 fc             	mov    -0x4(%ebp),%edx
 263:	89 d0                	mov    %edx,%eax
 265:	c1 e0 02             	shl    $0x2,%eax
 268:	01 d0                	add    %edx,%eax
 26a:	01 c0                	add    %eax,%eax
 26c:	89 c1                	mov    %eax,%ecx
 26e:	8b 45 08             	mov    0x8(%ebp),%eax
 271:	8d 50 01             	lea    0x1(%eax),%edx
 274:	89 55 08             	mov    %edx,0x8(%ebp)
 277:	0f b6 00             	movzbl (%eax),%eax
 27a:	0f be c0             	movsbl %al,%eax
 27d:	01 c8                	add    %ecx,%eax
 27f:	83 e8 30             	sub    $0x30,%eax
 282:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 285:	8b 45 08             	mov    0x8(%ebp),%eax
 288:	0f b6 00             	movzbl (%eax),%eax
 28b:	3c 2f                	cmp    $0x2f,%al
 28d:	7e 0a                	jle    299 <atoi+0x48>
 28f:	8b 45 08             	mov    0x8(%ebp),%eax
 292:	0f b6 00             	movzbl (%eax),%eax
 295:	3c 39                	cmp    $0x39,%al
 297:	7e c7                	jle    260 <atoi+0xf>
  return n;
 299:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 29c:	c9                   	leave  
 29d:	c3                   	ret    

0000029e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 29e:	55                   	push   %ebp
 29f:	89 e5                	mov    %esp,%ebp
 2a1:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
 2a4:	8b 45 08             	mov    0x8(%ebp),%eax
 2a7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 2ad:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2b0:	eb 17                	jmp    2c9 <memmove+0x2b>
    *dst++ = *src++;
 2b2:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2b5:	8d 42 01             	lea    0x1(%edx),%eax
 2b8:	89 45 f8             	mov    %eax,-0x8(%ebp)
 2bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2be:	8d 48 01             	lea    0x1(%eax),%ecx
 2c1:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 2c4:	0f b6 12             	movzbl (%edx),%edx
 2c7:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 2c9:	8b 45 10             	mov    0x10(%ebp),%eax
 2cc:	8d 50 ff             	lea    -0x1(%eax),%edx
 2cf:	89 55 10             	mov    %edx,0x10(%ebp)
 2d2:	85 c0                	test   %eax,%eax
 2d4:	7f dc                	jg     2b2 <memmove+0x14>
  return vdst;
 2d6:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2d9:	c9                   	leave  
 2da:	c3                   	ret    

000002db <calc>:

int calc(int num)
{
 2db:	55                   	push   %ebp
 2dc:	89 e5                	mov    %esp,%ebp
 2de:	83 ec 10             	sub    $0x10,%esp
    int c = 0;
 2e1:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for(uint i = 0; i < num; i++)
 2e8:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
 2ef:	eb 36                	jmp    327 <calc+0x4c>
    {
        for(uint j = 0; j < num; j++)
 2f1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2f8:	eb 21                	jmp    31b <calc+0x40>
        {
            for(uint k = 0; k < num; j++)
 2fa:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 301:	eb 0c                	jmp    30f <calc+0x34>
            {
                c >>= 10;
 303:	c1 7d fc 0a          	sarl   $0xa,-0x4(%ebp)
                c <<= 10;
 307:	c1 65 fc 0a          	shll   $0xa,-0x4(%ebp)
            for(uint k = 0; k < num; j++)
 30b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 30f:	8b 45 08             	mov    0x8(%ebp),%eax
 312:	39 45 f0             	cmp    %eax,-0x10(%ebp)
 315:	72 ec                	jb     303 <calc+0x28>
        for(uint j = 0; j < num; j++)
 317:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 31b:	8b 45 08             	mov    0x8(%ebp),%eax
 31e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 321:	72 d7                	jb     2fa <calc+0x1f>
    for(uint i = 0; i < num; i++)
 323:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 327:	8b 45 08             	mov    0x8(%ebp),%eax
 32a:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 32d:	72 c2                	jb     2f1 <calc+0x16>
            }
        }
    }
    return 0;
 32f:	b8 00 00 00 00       	mov    $0x0,%eax
}
 334:	c9                   	leave  
 335:	c3                   	ret    

00000336 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 336:	b8 01 00 00 00       	mov    $0x1,%eax
 33b:	cd 40                	int    $0x40
 33d:	c3                   	ret    

0000033e <exit>:
SYSCALL(exit)
 33e:	b8 02 00 00 00       	mov    $0x2,%eax
 343:	cd 40                	int    $0x40
 345:	c3                   	ret    

00000346 <wait>:
SYSCALL(wait)
 346:	b8 03 00 00 00       	mov    $0x3,%eax
 34b:	cd 40                	int    $0x40
 34d:	c3                   	ret    

0000034e <pipe>:
SYSCALL(pipe)
 34e:	b8 04 00 00 00       	mov    $0x4,%eax
 353:	cd 40                	int    $0x40
 355:	c3                   	ret    

00000356 <read>:
SYSCALL(read)
 356:	b8 05 00 00 00       	mov    $0x5,%eax
 35b:	cd 40                	int    $0x40
 35d:	c3                   	ret    

0000035e <write>:
SYSCALL(write)
 35e:	b8 10 00 00 00       	mov    $0x10,%eax
 363:	cd 40                	int    $0x40
 365:	c3                   	ret    

00000366 <close>:
SYSCALL(close)
 366:	b8 15 00 00 00       	mov    $0x15,%eax
 36b:	cd 40                	int    $0x40
 36d:	c3                   	ret    

0000036e <kill>:
SYSCALL(kill)
 36e:	b8 06 00 00 00       	mov    $0x6,%eax
 373:	cd 40                	int    $0x40
 375:	c3                   	ret    

00000376 <exec>:
SYSCALL(exec)
 376:	b8 07 00 00 00       	mov    $0x7,%eax
 37b:	cd 40                	int    $0x40
 37d:	c3                   	ret    

0000037e <open>:
SYSCALL(open)
 37e:	b8 0f 00 00 00       	mov    $0xf,%eax
 383:	cd 40                	int    $0x40
 385:	c3                   	ret    

00000386 <mknod>:
SYSCALL(mknod)
 386:	b8 11 00 00 00       	mov    $0x11,%eax
 38b:	cd 40                	int    $0x40
 38d:	c3                   	ret    

0000038e <unlink>:
SYSCALL(unlink)
 38e:	b8 12 00 00 00       	mov    $0x12,%eax
 393:	cd 40                	int    $0x40
 395:	c3                   	ret    

00000396 <fstat>:
SYSCALL(fstat)
 396:	b8 08 00 00 00       	mov    $0x8,%eax
 39b:	cd 40                	int    $0x40
 39d:	c3                   	ret    

0000039e <link>:
SYSCALL(link)
 39e:	b8 13 00 00 00       	mov    $0x13,%eax
 3a3:	cd 40                	int    $0x40
 3a5:	c3                   	ret    

000003a6 <mkdir>:
SYSCALL(mkdir)
 3a6:	b8 14 00 00 00       	mov    $0x14,%eax
 3ab:	cd 40                	int    $0x40
 3ad:	c3                   	ret    

000003ae <chdir>:
SYSCALL(chdir)
 3ae:	b8 09 00 00 00       	mov    $0x9,%eax
 3b3:	cd 40                	int    $0x40
 3b5:	c3                   	ret    

000003b6 <dup>:
SYSCALL(dup)
 3b6:	b8 0a 00 00 00       	mov    $0xa,%eax
 3bb:	cd 40                	int    $0x40
 3bd:	c3                   	ret    

000003be <getpid>:
SYSCALL(getpid)
 3be:	b8 0b 00 00 00       	mov    $0xb,%eax
 3c3:	cd 40                	int    $0x40
 3c5:	c3                   	ret    

000003c6 <sbrk>:
SYSCALL(sbrk)
 3c6:	b8 0c 00 00 00       	mov    $0xc,%eax
 3cb:	cd 40                	int    $0x40
 3cd:	c3                   	ret    

000003ce <sleep>:
SYSCALL(sleep)
 3ce:	b8 0d 00 00 00       	mov    $0xd,%eax
 3d3:	cd 40                	int    $0x40
 3d5:	c3                   	ret    

000003d6 <uptime>:
SYSCALL(uptime)
 3d6:	b8 0e 00 00 00       	mov    $0xe,%eax
 3db:	cd 40                	int    $0x40
 3dd:	c3                   	ret    

000003de <print_proc>:
SYSCALL(print_proc)
 3de:	b8 16 00 00 00       	mov    $0x16,%eax
 3e3:	cd 40                	int    $0x40
 3e5:	c3                   	ret    

000003e6 <change_queue>:
SYSCALL(change_queue)
 3e6:	b8 17 00 00 00       	mov    $0x17,%eax
 3eb:	cd 40                	int    $0x40
 3ed:	c3                   	ret    

000003ee <change_local_bjf>:
SYSCALL(change_local_bjf)
 3ee:	b8 18 00 00 00       	mov    $0x18,%eax
 3f3:	cd 40                	int    $0x40
 3f5:	c3                   	ret    

000003f6 <change_global_bjf>:
SYSCALL(change_global_bjf)
 3f6:	b8 19 00 00 00       	mov    $0x19,%eax
 3fb:	cd 40                	int    $0x40
 3fd:	c3                   	ret    

000003fe <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3fe:	55                   	push   %ebp
 3ff:	89 e5                	mov    %esp,%ebp
 401:	83 ec 18             	sub    $0x18,%esp
 404:	8b 45 0c             	mov    0xc(%ebp),%eax
 407:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 40a:	83 ec 04             	sub    $0x4,%esp
 40d:	6a 01                	push   $0x1
 40f:	8d 45 f4             	lea    -0xc(%ebp),%eax
 412:	50                   	push   %eax
 413:	ff 75 08             	push   0x8(%ebp)
 416:	e8 43 ff ff ff       	call   35e <write>
 41b:	83 c4 10             	add    $0x10,%esp
}
 41e:	90                   	nop
 41f:	c9                   	leave  
 420:	c3                   	ret    

00000421 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 421:	55                   	push   %ebp
 422:	89 e5                	mov    %esp,%ebp
 424:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 427:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 42e:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 432:	74 17                	je     44b <printint+0x2a>
 434:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 438:	79 11                	jns    44b <printint+0x2a>
    neg = 1;
 43a:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 441:	8b 45 0c             	mov    0xc(%ebp),%eax
 444:	f7 d8                	neg    %eax
 446:	89 45 ec             	mov    %eax,-0x14(%ebp)
 449:	eb 06                	jmp    451 <printint+0x30>
  } else {
    x = xx;
 44b:	8b 45 0c             	mov    0xc(%ebp),%eax
 44e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 451:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 458:	8b 4d 10             	mov    0x10(%ebp),%ecx
 45b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 45e:	ba 00 00 00 00       	mov    $0x0,%edx
 463:	f7 f1                	div    %ecx
 465:	89 d1                	mov    %edx,%ecx
 467:	8b 45 f4             	mov    -0xc(%ebp),%eax
 46a:	8d 50 01             	lea    0x1(%eax),%edx
 46d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 470:	0f b6 91 ec 0a 00 00 	movzbl 0xaec(%ecx),%edx
 477:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 47b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 47e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 481:	ba 00 00 00 00       	mov    $0x0,%edx
 486:	f7 f1                	div    %ecx
 488:	89 45 ec             	mov    %eax,-0x14(%ebp)
 48b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 48f:	75 c7                	jne    458 <printint+0x37>
  if(neg)
 491:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 495:	74 2d                	je     4c4 <printint+0xa3>
    buf[i++] = '-';
 497:	8b 45 f4             	mov    -0xc(%ebp),%eax
 49a:	8d 50 01             	lea    0x1(%eax),%edx
 49d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4a0:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4a5:	eb 1d                	jmp    4c4 <printint+0xa3>
    putc(fd, buf[i]);
 4a7:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4ad:	01 d0                	add    %edx,%eax
 4af:	0f b6 00             	movzbl (%eax),%eax
 4b2:	0f be c0             	movsbl %al,%eax
 4b5:	83 ec 08             	sub    $0x8,%esp
 4b8:	50                   	push   %eax
 4b9:	ff 75 08             	push   0x8(%ebp)
 4bc:	e8 3d ff ff ff       	call   3fe <putc>
 4c1:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 4c4:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4c8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4cc:	79 d9                	jns    4a7 <printint+0x86>
}
 4ce:	90                   	nop
 4cf:	90                   	nop
 4d0:	c9                   	leave  
 4d1:	c3                   	ret    

000004d2 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4d2:	55                   	push   %ebp
 4d3:	89 e5                	mov    %esp,%ebp
 4d5:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4d8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4df:	8d 45 0c             	lea    0xc(%ebp),%eax
 4e2:	83 c0 04             	add    $0x4,%eax
 4e5:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4e8:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4ef:	e9 59 01 00 00       	jmp    64d <printf+0x17b>
    c = fmt[i] & 0xff;
 4f4:	8b 55 0c             	mov    0xc(%ebp),%edx
 4f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4fa:	01 d0                	add    %edx,%eax
 4fc:	0f b6 00             	movzbl (%eax),%eax
 4ff:	0f be c0             	movsbl %al,%eax
 502:	25 ff 00 00 00       	and    $0xff,%eax
 507:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 50a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 50e:	75 2c                	jne    53c <printf+0x6a>
      if(c == '%'){
 510:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 514:	75 0c                	jne    522 <printf+0x50>
        state = '%';
 516:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 51d:	e9 27 01 00 00       	jmp    649 <printf+0x177>
      } else {
        putc(fd, c);
 522:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 525:	0f be c0             	movsbl %al,%eax
 528:	83 ec 08             	sub    $0x8,%esp
 52b:	50                   	push   %eax
 52c:	ff 75 08             	push   0x8(%ebp)
 52f:	e8 ca fe ff ff       	call   3fe <putc>
 534:	83 c4 10             	add    $0x10,%esp
 537:	e9 0d 01 00 00       	jmp    649 <printf+0x177>
      }
    } else if(state == '%'){
 53c:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 540:	0f 85 03 01 00 00    	jne    649 <printf+0x177>
      if(c == 'd'){
 546:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 54a:	75 1e                	jne    56a <printf+0x98>
        printint(fd, *ap, 10, 1);
 54c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 54f:	8b 00                	mov    (%eax),%eax
 551:	6a 01                	push   $0x1
 553:	6a 0a                	push   $0xa
 555:	50                   	push   %eax
 556:	ff 75 08             	push   0x8(%ebp)
 559:	e8 c3 fe ff ff       	call   421 <printint>
 55e:	83 c4 10             	add    $0x10,%esp
        ap++;
 561:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 565:	e9 d8 00 00 00       	jmp    642 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 56a:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 56e:	74 06                	je     576 <printf+0xa4>
 570:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 574:	75 1e                	jne    594 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 576:	8b 45 e8             	mov    -0x18(%ebp),%eax
 579:	8b 00                	mov    (%eax),%eax
 57b:	6a 00                	push   $0x0
 57d:	6a 10                	push   $0x10
 57f:	50                   	push   %eax
 580:	ff 75 08             	push   0x8(%ebp)
 583:	e8 99 fe ff ff       	call   421 <printint>
 588:	83 c4 10             	add    $0x10,%esp
        ap++;
 58b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 58f:	e9 ae 00 00 00       	jmp    642 <printf+0x170>
      } else if(c == 's'){
 594:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 598:	75 43                	jne    5dd <printf+0x10b>
        s = (char*)*ap;
 59a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 59d:	8b 00                	mov    (%eax),%eax
 59f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 5a2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5a6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5aa:	75 25                	jne    5d1 <printf+0xff>
          s = "(null)";
 5ac:	c7 45 f4 89 08 00 00 	movl   $0x889,-0xc(%ebp)
        while(*s != 0){
 5b3:	eb 1c                	jmp    5d1 <printf+0xff>
          putc(fd, *s);
 5b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5b8:	0f b6 00             	movzbl (%eax),%eax
 5bb:	0f be c0             	movsbl %al,%eax
 5be:	83 ec 08             	sub    $0x8,%esp
 5c1:	50                   	push   %eax
 5c2:	ff 75 08             	push   0x8(%ebp)
 5c5:	e8 34 fe ff ff       	call   3fe <putc>
 5ca:	83 c4 10             	add    $0x10,%esp
          s++;
 5cd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 5d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5d4:	0f b6 00             	movzbl (%eax),%eax
 5d7:	84 c0                	test   %al,%al
 5d9:	75 da                	jne    5b5 <printf+0xe3>
 5db:	eb 65                	jmp    642 <printf+0x170>
        }
      } else if(c == 'c'){
 5dd:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5e1:	75 1d                	jne    600 <printf+0x12e>
        putc(fd, *ap);
 5e3:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5e6:	8b 00                	mov    (%eax),%eax
 5e8:	0f be c0             	movsbl %al,%eax
 5eb:	83 ec 08             	sub    $0x8,%esp
 5ee:	50                   	push   %eax
 5ef:	ff 75 08             	push   0x8(%ebp)
 5f2:	e8 07 fe ff ff       	call   3fe <putc>
 5f7:	83 c4 10             	add    $0x10,%esp
        ap++;
 5fa:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5fe:	eb 42                	jmp    642 <printf+0x170>
      } else if(c == '%'){
 600:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 604:	75 17                	jne    61d <printf+0x14b>
        putc(fd, c);
 606:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 609:	0f be c0             	movsbl %al,%eax
 60c:	83 ec 08             	sub    $0x8,%esp
 60f:	50                   	push   %eax
 610:	ff 75 08             	push   0x8(%ebp)
 613:	e8 e6 fd ff ff       	call   3fe <putc>
 618:	83 c4 10             	add    $0x10,%esp
 61b:	eb 25                	jmp    642 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 61d:	83 ec 08             	sub    $0x8,%esp
 620:	6a 25                	push   $0x25
 622:	ff 75 08             	push   0x8(%ebp)
 625:	e8 d4 fd ff ff       	call   3fe <putc>
 62a:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 62d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 630:	0f be c0             	movsbl %al,%eax
 633:	83 ec 08             	sub    $0x8,%esp
 636:	50                   	push   %eax
 637:	ff 75 08             	push   0x8(%ebp)
 63a:	e8 bf fd ff ff       	call   3fe <putc>
 63f:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 642:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 649:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 64d:	8b 55 0c             	mov    0xc(%ebp),%edx
 650:	8b 45 f0             	mov    -0x10(%ebp),%eax
 653:	01 d0                	add    %edx,%eax
 655:	0f b6 00             	movzbl (%eax),%eax
 658:	84 c0                	test   %al,%al
 65a:	0f 85 94 fe ff ff    	jne    4f4 <printf+0x22>
    }
  }
}
 660:	90                   	nop
 661:	90                   	nop
 662:	c9                   	leave  
 663:	c3                   	ret    

00000664 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 664:	55                   	push   %ebp
 665:	89 e5                	mov    %esp,%ebp
 667:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 66a:	8b 45 08             	mov    0x8(%ebp),%eax
 66d:	83 e8 08             	sub    $0x8,%eax
 670:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 673:	a1 08 0b 00 00       	mov    0xb08,%eax
 678:	89 45 fc             	mov    %eax,-0x4(%ebp)
 67b:	eb 24                	jmp    6a1 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 67d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 680:	8b 00                	mov    (%eax),%eax
 682:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 685:	72 12                	jb     699 <free+0x35>
 687:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 68d:	77 24                	ja     6b3 <free+0x4f>
 68f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 692:	8b 00                	mov    (%eax),%eax
 694:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 697:	72 1a                	jb     6b3 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 699:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69c:	8b 00                	mov    (%eax),%eax
 69e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 6a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a4:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6a7:	76 d4                	jbe    67d <free+0x19>
 6a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ac:	8b 00                	mov    (%eax),%eax
 6ae:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 6b1:	73 ca                	jae    67d <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6b3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b6:	8b 40 04             	mov    0x4(%eax),%eax
 6b9:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c3:	01 c2                	add    %eax,%edx
 6c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c8:	8b 00                	mov    (%eax),%eax
 6ca:	39 c2                	cmp    %eax,%edx
 6cc:	75 24                	jne    6f2 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6ce:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d1:	8b 50 04             	mov    0x4(%eax),%edx
 6d4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d7:	8b 00                	mov    (%eax),%eax
 6d9:	8b 40 04             	mov    0x4(%eax),%eax
 6dc:	01 c2                	add    %eax,%edx
 6de:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e1:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e7:	8b 00                	mov    (%eax),%eax
 6e9:	8b 10                	mov    (%eax),%edx
 6eb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ee:	89 10                	mov    %edx,(%eax)
 6f0:	eb 0a                	jmp    6fc <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6f2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f5:	8b 10                	mov    (%eax),%edx
 6f7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6fa:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ff:	8b 40 04             	mov    0x4(%eax),%eax
 702:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 709:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70c:	01 d0                	add    %edx,%eax
 70e:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 711:	75 20                	jne    733 <free+0xcf>
    p->s.size += bp->s.size;
 713:	8b 45 fc             	mov    -0x4(%ebp),%eax
 716:	8b 50 04             	mov    0x4(%eax),%edx
 719:	8b 45 f8             	mov    -0x8(%ebp),%eax
 71c:	8b 40 04             	mov    0x4(%eax),%eax
 71f:	01 c2                	add    %eax,%edx
 721:	8b 45 fc             	mov    -0x4(%ebp),%eax
 724:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 727:	8b 45 f8             	mov    -0x8(%ebp),%eax
 72a:	8b 10                	mov    (%eax),%edx
 72c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72f:	89 10                	mov    %edx,(%eax)
 731:	eb 08                	jmp    73b <free+0xd7>
  } else
    p->s.ptr = bp;
 733:	8b 45 fc             	mov    -0x4(%ebp),%eax
 736:	8b 55 f8             	mov    -0x8(%ebp),%edx
 739:	89 10                	mov    %edx,(%eax)
  freep = p;
 73b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73e:	a3 08 0b 00 00       	mov    %eax,0xb08
}
 743:	90                   	nop
 744:	c9                   	leave  
 745:	c3                   	ret    

00000746 <morecore>:

static Header*
morecore(uint nu)
{
 746:	55                   	push   %ebp
 747:	89 e5                	mov    %esp,%ebp
 749:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 74c:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 753:	77 07                	ja     75c <morecore+0x16>
    nu = 4096;
 755:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 75c:	8b 45 08             	mov    0x8(%ebp),%eax
 75f:	c1 e0 03             	shl    $0x3,%eax
 762:	83 ec 0c             	sub    $0xc,%esp
 765:	50                   	push   %eax
 766:	e8 5b fc ff ff       	call   3c6 <sbrk>
 76b:	83 c4 10             	add    $0x10,%esp
 76e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 771:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 775:	75 07                	jne    77e <morecore+0x38>
    return 0;
 777:	b8 00 00 00 00       	mov    $0x0,%eax
 77c:	eb 26                	jmp    7a4 <morecore+0x5e>
  hp = (Header*)p;
 77e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 781:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 784:	8b 45 f0             	mov    -0x10(%ebp),%eax
 787:	8b 55 08             	mov    0x8(%ebp),%edx
 78a:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 78d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 790:	83 c0 08             	add    $0x8,%eax
 793:	83 ec 0c             	sub    $0xc,%esp
 796:	50                   	push   %eax
 797:	e8 c8 fe ff ff       	call   664 <free>
 79c:	83 c4 10             	add    $0x10,%esp
  return freep;
 79f:	a1 08 0b 00 00       	mov    0xb08,%eax
}
 7a4:	c9                   	leave  
 7a5:	c3                   	ret    

000007a6 <malloc>:

void*
malloc(uint nbytes)
{
 7a6:	55                   	push   %ebp
 7a7:	89 e5                	mov    %esp,%ebp
 7a9:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7ac:	8b 45 08             	mov    0x8(%ebp),%eax
 7af:	83 c0 07             	add    $0x7,%eax
 7b2:	c1 e8 03             	shr    $0x3,%eax
 7b5:	83 c0 01             	add    $0x1,%eax
 7b8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7bb:	a1 08 0b 00 00       	mov    0xb08,%eax
 7c0:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7c3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7c7:	75 23                	jne    7ec <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7c9:	c7 45 f0 00 0b 00 00 	movl   $0xb00,-0x10(%ebp)
 7d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d3:	a3 08 0b 00 00       	mov    %eax,0xb08
 7d8:	a1 08 0b 00 00       	mov    0xb08,%eax
 7dd:	a3 00 0b 00 00       	mov    %eax,0xb00
    base.s.size = 0;
 7e2:	c7 05 04 0b 00 00 00 	movl   $0x0,0xb04
 7e9:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ef:	8b 00                	mov    (%eax),%eax
 7f1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f7:	8b 40 04             	mov    0x4(%eax),%eax
 7fa:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7fd:	77 4d                	ja     84c <malloc+0xa6>
      if(p->s.size == nunits)
 7ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 802:	8b 40 04             	mov    0x4(%eax),%eax
 805:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 808:	75 0c                	jne    816 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 80a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80d:	8b 10                	mov    (%eax),%edx
 80f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 812:	89 10                	mov    %edx,(%eax)
 814:	eb 26                	jmp    83c <malloc+0x96>
      else {
        p->s.size -= nunits;
 816:	8b 45 f4             	mov    -0xc(%ebp),%eax
 819:	8b 40 04             	mov    0x4(%eax),%eax
 81c:	2b 45 ec             	sub    -0x14(%ebp),%eax
 81f:	89 c2                	mov    %eax,%edx
 821:	8b 45 f4             	mov    -0xc(%ebp),%eax
 824:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 827:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82a:	8b 40 04             	mov    0x4(%eax),%eax
 82d:	c1 e0 03             	shl    $0x3,%eax
 830:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 833:	8b 45 f4             	mov    -0xc(%ebp),%eax
 836:	8b 55 ec             	mov    -0x14(%ebp),%edx
 839:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 83c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 83f:	a3 08 0b 00 00       	mov    %eax,0xb08
      return (void*)(p + 1);
 844:	8b 45 f4             	mov    -0xc(%ebp),%eax
 847:	83 c0 08             	add    $0x8,%eax
 84a:	eb 3b                	jmp    887 <malloc+0xe1>
    }
    if(p == freep)
 84c:	a1 08 0b 00 00       	mov    0xb08,%eax
 851:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 854:	75 1e                	jne    874 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 856:	83 ec 0c             	sub    $0xc,%esp
 859:	ff 75 ec             	push   -0x14(%ebp)
 85c:	e8 e5 fe ff ff       	call   746 <morecore>
 861:	83 c4 10             	add    $0x10,%esp
 864:	89 45 f4             	mov    %eax,-0xc(%ebp)
 867:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 86b:	75 07                	jne    874 <malloc+0xce>
        return 0;
 86d:	b8 00 00 00 00       	mov    $0x0,%eax
 872:	eb 13                	jmp    887 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 874:	8b 45 f4             	mov    -0xc(%ebp),%eax
 877:	89 45 f0             	mov    %eax,-0x10(%ebp)
 87a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87d:	8b 00                	mov    (%eax),%eax
 87f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 882:	e9 6d ff ff ff       	jmp    7f4 <malloc+0x4e>
  }
}
 887:	c9                   	leave  
 888:	c3                   	ret    
