
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
  11:	e8 c0 02 00 00       	call   2d6 <fork>
  16:	85 c0                	test   %eax,%eax
  18:	7e 0d                	jle    27 <main+0x27>
    sleep(5);  // Let child exit before parent.
  1a:	83 ec 0c             	sub    $0xc,%esp
  1d:	6a 05                	push   $0x5
  1f:	e8 4a 03 00 00       	call   36e <sleep>
  24:	83 c4 10             	add    $0x10,%esp
  exit();
  27:	e8 b2 02 00 00       	call   2de <exit>

0000002c <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  2c:	55                   	push   %ebp
  2d:	89 e5                	mov    %esp,%ebp
  2f:	57                   	push   %edi
  30:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  31:	8b 4d 08             	mov    0x8(%ebp),%ecx
  34:	8b 55 10             	mov    0x10(%ebp),%edx
  37:	8b 45 0c             	mov    0xc(%ebp),%eax
  3a:	89 cb                	mov    %ecx,%ebx
  3c:	89 df                	mov    %ebx,%edi
  3e:	89 d1                	mov    %edx,%ecx
  40:	fc                   	cld    
  41:	f3 aa                	rep stos %al,%es:(%edi)
  43:	89 ca                	mov    %ecx,%edx
  45:	89 fb                	mov    %edi,%ebx
  47:	89 5d 08             	mov    %ebx,0x8(%ebp)
  4a:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  4d:	90                   	nop
  4e:	5b                   	pop    %ebx
  4f:	5f                   	pop    %edi
  50:	5d                   	pop    %ebp
  51:	c3                   	ret    

00000052 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  52:	55                   	push   %ebp
  53:	89 e5                	mov    %esp,%ebp
  55:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  58:	8b 45 08             	mov    0x8(%ebp),%eax
  5b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  5e:	90                   	nop
  5f:	8b 55 0c             	mov    0xc(%ebp),%edx
  62:	8d 42 01             	lea    0x1(%edx),%eax
  65:	89 45 0c             	mov    %eax,0xc(%ebp)
  68:	8b 45 08             	mov    0x8(%ebp),%eax
  6b:	8d 48 01             	lea    0x1(%eax),%ecx
  6e:	89 4d 08             	mov    %ecx,0x8(%ebp)
  71:	0f b6 12             	movzbl (%edx),%edx
  74:	88 10                	mov    %dl,(%eax)
  76:	0f b6 00             	movzbl (%eax),%eax
  79:	84 c0                	test   %al,%al
  7b:	75 e2                	jne    5f <strcpy+0xd>
    ;
  return os;
  7d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  80:	c9                   	leave  
  81:	c3                   	ret    

00000082 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  82:	55                   	push   %ebp
  83:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  85:	eb 08                	jmp    8f <strcmp+0xd>
    p++, q++;
  87:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  8b:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
  8f:	8b 45 08             	mov    0x8(%ebp),%eax
  92:	0f b6 00             	movzbl (%eax),%eax
  95:	84 c0                	test   %al,%al
  97:	74 10                	je     a9 <strcmp+0x27>
  99:	8b 45 08             	mov    0x8(%ebp),%eax
  9c:	0f b6 10             	movzbl (%eax),%edx
  9f:	8b 45 0c             	mov    0xc(%ebp),%eax
  a2:	0f b6 00             	movzbl (%eax),%eax
  a5:	38 c2                	cmp    %al,%dl
  a7:	74 de                	je     87 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
  a9:	8b 45 08             	mov    0x8(%ebp),%eax
  ac:	0f b6 00             	movzbl (%eax),%eax
  af:	0f b6 d0             	movzbl %al,%edx
  b2:	8b 45 0c             	mov    0xc(%ebp),%eax
  b5:	0f b6 00             	movzbl (%eax),%eax
  b8:	0f b6 c8             	movzbl %al,%ecx
  bb:	89 d0                	mov    %edx,%eax
  bd:	29 c8                	sub    %ecx,%eax
}
  bf:	5d                   	pop    %ebp
  c0:	c3                   	ret    

000000c1 <strlen>:

uint
strlen(const char *s)
{
  c1:	55                   	push   %ebp
  c2:	89 e5                	mov    %esp,%ebp
  c4:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  c7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  ce:	eb 04                	jmp    d4 <strlen+0x13>
  d0:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  d4:	8b 55 fc             	mov    -0x4(%ebp),%edx
  d7:	8b 45 08             	mov    0x8(%ebp),%eax
  da:	01 d0                	add    %edx,%eax
  dc:	0f b6 00             	movzbl (%eax),%eax
  df:	84 c0                	test   %al,%al
  e1:	75 ed                	jne    d0 <strlen+0xf>
    ;
  return n;
  e3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  e6:	c9                   	leave  
  e7:	c3                   	ret    

000000e8 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e8:	55                   	push   %ebp
  e9:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
  eb:	8b 45 10             	mov    0x10(%ebp),%eax
  ee:	50                   	push   %eax
  ef:	ff 75 0c             	push   0xc(%ebp)
  f2:	ff 75 08             	push   0x8(%ebp)
  f5:	e8 32 ff ff ff       	call   2c <stosb>
  fa:	83 c4 0c             	add    $0xc,%esp
  return dst;
  fd:	8b 45 08             	mov    0x8(%ebp),%eax
}
 100:	c9                   	leave  
 101:	c3                   	ret    

00000102 <strchr>:

char*
strchr(const char *s, char c)
{
 102:	55                   	push   %ebp
 103:	89 e5                	mov    %esp,%ebp
 105:	83 ec 04             	sub    $0x4,%esp
 108:	8b 45 0c             	mov    0xc(%ebp),%eax
 10b:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 10e:	eb 14                	jmp    124 <strchr+0x22>
    if(*s == c)
 110:	8b 45 08             	mov    0x8(%ebp),%eax
 113:	0f b6 00             	movzbl (%eax),%eax
 116:	38 45 fc             	cmp    %al,-0x4(%ebp)
 119:	75 05                	jne    120 <strchr+0x1e>
      return (char*)s;
 11b:	8b 45 08             	mov    0x8(%ebp),%eax
 11e:	eb 13                	jmp    133 <strchr+0x31>
  for(; *s; s++)
 120:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 124:	8b 45 08             	mov    0x8(%ebp),%eax
 127:	0f b6 00             	movzbl (%eax),%eax
 12a:	84 c0                	test   %al,%al
 12c:	75 e2                	jne    110 <strchr+0xe>
  return 0;
 12e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 133:	c9                   	leave  
 134:	c3                   	ret    

00000135 <gets>:

char*
gets(char *buf, int max)
{
 135:	55                   	push   %ebp
 136:	89 e5                	mov    %esp,%ebp
 138:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 13b:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 142:	eb 42                	jmp    186 <gets+0x51>
    cc = read(0, &c, 1);
 144:	83 ec 04             	sub    $0x4,%esp
 147:	6a 01                	push   $0x1
 149:	8d 45 ef             	lea    -0x11(%ebp),%eax
 14c:	50                   	push   %eax
 14d:	6a 00                	push   $0x0
 14f:	e8 a2 01 00 00       	call   2f6 <read>
 154:	83 c4 10             	add    $0x10,%esp
 157:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 15a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 15e:	7e 33                	jle    193 <gets+0x5e>
      break;
    buf[i++] = c;
 160:	8b 45 f4             	mov    -0xc(%ebp),%eax
 163:	8d 50 01             	lea    0x1(%eax),%edx
 166:	89 55 f4             	mov    %edx,-0xc(%ebp)
 169:	89 c2                	mov    %eax,%edx
 16b:	8b 45 08             	mov    0x8(%ebp),%eax
 16e:	01 c2                	add    %eax,%edx
 170:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 174:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 176:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 17a:	3c 0a                	cmp    $0xa,%al
 17c:	74 16                	je     194 <gets+0x5f>
 17e:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 182:	3c 0d                	cmp    $0xd,%al
 184:	74 0e                	je     194 <gets+0x5f>
  for(i=0; i+1 < max; ){
 186:	8b 45 f4             	mov    -0xc(%ebp),%eax
 189:	83 c0 01             	add    $0x1,%eax
 18c:	39 45 0c             	cmp    %eax,0xc(%ebp)
 18f:	7f b3                	jg     144 <gets+0xf>
 191:	eb 01                	jmp    194 <gets+0x5f>
      break;
 193:	90                   	nop
      break;
  }
  buf[i] = '\0';
 194:	8b 55 f4             	mov    -0xc(%ebp),%edx
 197:	8b 45 08             	mov    0x8(%ebp),%eax
 19a:	01 d0                	add    %edx,%eax
 19c:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 19f:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1a2:	c9                   	leave  
 1a3:	c3                   	ret    

000001a4 <stat>:

int
stat(const char *n, struct stat *st)
{
 1a4:	55                   	push   %ebp
 1a5:	89 e5                	mov    %esp,%ebp
 1a7:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1aa:	83 ec 08             	sub    $0x8,%esp
 1ad:	6a 00                	push   $0x0
 1af:	ff 75 08             	push   0x8(%ebp)
 1b2:	e8 67 01 00 00       	call   31e <open>
 1b7:	83 c4 10             	add    $0x10,%esp
 1ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1bd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1c1:	79 07                	jns    1ca <stat+0x26>
    return -1;
 1c3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1c8:	eb 25                	jmp    1ef <stat+0x4b>
  r = fstat(fd, st);
 1ca:	83 ec 08             	sub    $0x8,%esp
 1cd:	ff 75 0c             	push   0xc(%ebp)
 1d0:	ff 75 f4             	push   -0xc(%ebp)
 1d3:	e8 5e 01 00 00       	call   336 <fstat>
 1d8:	83 c4 10             	add    $0x10,%esp
 1db:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1de:	83 ec 0c             	sub    $0xc,%esp
 1e1:	ff 75 f4             	push   -0xc(%ebp)
 1e4:	e8 1d 01 00 00       	call   306 <close>
 1e9:	83 c4 10             	add    $0x10,%esp
  return r;
 1ec:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1ef:	c9                   	leave  
 1f0:	c3                   	ret    

000001f1 <atoi>:

int
atoi(const char *s)
{
 1f1:	55                   	push   %ebp
 1f2:	89 e5                	mov    %esp,%ebp
 1f4:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 1f7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 1fe:	eb 25                	jmp    225 <atoi+0x34>
    n = n*10 + *s++ - '0';
 200:	8b 55 fc             	mov    -0x4(%ebp),%edx
 203:	89 d0                	mov    %edx,%eax
 205:	c1 e0 02             	shl    $0x2,%eax
 208:	01 d0                	add    %edx,%eax
 20a:	01 c0                	add    %eax,%eax
 20c:	89 c1                	mov    %eax,%ecx
 20e:	8b 45 08             	mov    0x8(%ebp),%eax
 211:	8d 50 01             	lea    0x1(%eax),%edx
 214:	89 55 08             	mov    %edx,0x8(%ebp)
 217:	0f b6 00             	movzbl (%eax),%eax
 21a:	0f be c0             	movsbl %al,%eax
 21d:	01 c8                	add    %ecx,%eax
 21f:	83 e8 30             	sub    $0x30,%eax
 222:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 225:	8b 45 08             	mov    0x8(%ebp),%eax
 228:	0f b6 00             	movzbl (%eax),%eax
 22b:	3c 2f                	cmp    $0x2f,%al
 22d:	7e 0a                	jle    239 <atoi+0x48>
 22f:	8b 45 08             	mov    0x8(%ebp),%eax
 232:	0f b6 00             	movzbl (%eax),%eax
 235:	3c 39                	cmp    $0x39,%al
 237:	7e c7                	jle    200 <atoi+0xf>
  return n;
 239:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 23c:	c9                   	leave  
 23d:	c3                   	ret    

0000023e <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 23e:	55                   	push   %ebp
 23f:	89 e5                	mov    %esp,%ebp
 241:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
 244:	8b 45 08             	mov    0x8(%ebp),%eax
 247:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 24a:	8b 45 0c             	mov    0xc(%ebp),%eax
 24d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 250:	eb 17                	jmp    269 <memmove+0x2b>
    *dst++ = *src++;
 252:	8b 55 f8             	mov    -0x8(%ebp),%edx
 255:	8d 42 01             	lea    0x1(%edx),%eax
 258:	89 45 f8             	mov    %eax,-0x8(%ebp)
 25b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 25e:	8d 48 01             	lea    0x1(%eax),%ecx
 261:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 264:	0f b6 12             	movzbl (%edx),%edx
 267:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 269:	8b 45 10             	mov    0x10(%ebp),%eax
 26c:	8d 50 ff             	lea    -0x1(%eax),%edx
 26f:	89 55 10             	mov    %edx,0x10(%ebp)
 272:	85 c0                	test   %eax,%eax
 274:	7f dc                	jg     252 <memmove+0x14>
  return vdst;
 276:	8b 45 08             	mov    0x8(%ebp),%eax
}
 279:	c9                   	leave  
 27a:	c3                   	ret    

0000027b <calc>:

int calc(int num)
{
 27b:	55                   	push   %ebp
 27c:	89 e5                	mov    %esp,%ebp
 27e:	83 ec 10             	sub    $0x10,%esp
    int c = 0;
 281:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for(uint i = 0; i < num; i++)
 288:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
 28f:	eb 36                	jmp    2c7 <calc+0x4c>
    {
        for(uint j = 0; j < num; j++)
 291:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 298:	eb 21                	jmp    2bb <calc+0x40>
        {
            for(uint k = 0; k < num; j++)
 29a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 2a1:	eb 0c                	jmp    2af <calc+0x34>
            {
                c >>= 10;
 2a3:	c1 7d fc 0a          	sarl   $0xa,-0x4(%ebp)
                c <<= 10;
 2a7:	c1 65 fc 0a          	shll   $0xa,-0x4(%ebp)
            for(uint k = 0; k < num; j++)
 2ab:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 2af:	8b 45 08             	mov    0x8(%ebp),%eax
 2b2:	39 45 f0             	cmp    %eax,-0x10(%ebp)
 2b5:	72 ec                	jb     2a3 <calc+0x28>
        for(uint j = 0; j < num; j++)
 2b7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 2bb:	8b 45 08             	mov    0x8(%ebp),%eax
 2be:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 2c1:	72 d7                	jb     29a <calc+0x1f>
    for(uint i = 0; i < num; i++)
 2c3:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 2c7:	8b 45 08             	mov    0x8(%ebp),%eax
 2ca:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 2cd:	72 c2                	jb     291 <calc+0x16>
            }
        }
    }
    return 0;
 2cf:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2d4:	c9                   	leave  
 2d5:	c3                   	ret    

000002d6 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2d6:	b8 01 00 00 00       	mov    $0x1,%eax
 2db:	cd 40                	int    $0x40
 2dd:	c3                   	ret    

000002de <exit>:
SYSCALL(exit)
 2de:	b8 02 00 00 00       	mov    $0x2,%eax
 2e3:	cd 40                	int    $0x40
 2e5:	c3                   	ret    

000002e6 <wait>:
SYSCALL(wait)
 2e6:	b8 03 00 00 00       	mov    $0x3,%eax
 2eb:	cd 40                	int    $0x40
 2ed:	c3                   	ret    

000002ee <pipe>:
SYSCALL(pipe)
 2ee:	b8 04 00 00 00       	mov    $0x4,%eax
 2f3:	cd 40                	int    $0x40
 2f5:	c3                   	ret    

000002f6 <read>:
SYSCALL(read)
 2f6:	b8 05 00 00 00       	mov    $0x5,%eax
 2fb:	cd 40                	int    $0x40
 2fd:	c3                   	ret    

000002fe <write>:
SYSCALL(write)
 2fe:	b8 10 00 00 00       	mov    $0x10,%eax
 303:	cd 40                	int    $0x40
 305:	c3                   	ret    

00000306 <close>:
SYSCALL(close)
 306:	b8 15 00 00 00       	mov    $0x15,%eax
 30b:	cd 40                	int    $0x40
 30d:	c3                   	ret    

0000030e <kill>:
SYSCALL(kill)
 30e:	b8 06 00 00 00       	mov    $0x6,%eax
 313:	cd 40                	int    $0x40
 315:	c3                   	ret    

00000316 <exec>:
SYSCALL(exec)
 316:	b8 07 00 00 00       	mov    $0x7,%eax
 31b:	cd 40                	int    $0x40
 31d:	c3                   	ret    

0000031e <open>:
SYSCALL(open)
 31e:	b8 0f 00 00 00       	mov    $0xf,%eax
 323:	cd 40                	int    $0x40
 325:	c3                   	ret    

00000326 <mknod>:
SYSCALL(mknod)
 326:	b8 11 00 00 00       	mov    $0x11,%eax
 32b:	cd 40                	int    $0x40
 32d:	c3                   	ret    

0000032e <unlink>:
SYSCALL(unlink)
 32e:	b8 12 00 00 00       	mov    $0x12,%eax
 333:	cd 40                	int    $0x40
 335:	c3                   	ret    

00000336 <fstat>:
SYSCALL(fstat)
 336:	b8 08 00 00 00       	mov    $0x8,%eax
 33b:	cd 40                	int    $0x40
 33d:	c3                   	ret    

0000033e <link>:
SYSCALL(link)
 33e:	b8 13 00 00 00       	mov    $0x13,%eax
 343:	cd 40                	int    $0x40
 345:	c3                   	ret    

00000346 <mkdir>:
SYSCALL(mkdir)
 346:	b8 14 00 00 00       	mov    $0x14,%eax
 34b:	cd 40                	int    $0x40
 34d:	c3                   	ret    

0000034e <chdir>:
SYSCALL(chdir)
 34e:	b8 09 00 00 00       	mov    $0x9,%eax
 353:	cd 40                	int    $0x40
 355:	c3                   	ret    

00000356 <dup>:
SYSCALL(dup)
 356:	b8 0a 00 00 00       	mov    $0xa,%eax
 35b:	cd 40                	int    $0x40
 35d:	c3                   	ret    

0000035e <getpid>:
SYSCALL(getpid)
 35e:	b8 0b 00 00 00       	mov    $0xb,%eax
 363:	cd 40                	int    $0x40
 365:	c3                   	ret    

00000366 <sbrk>:
SYSCALL(sbrk)
 366:	b8 0c 00 00 00       	mov    $0xc,%eax
 36b:	cd 40                	int    $0x40
 36d:	c3                   	ret    

0000036e <sleep>:
SYSCALL(sleep)
 36e:	b8 0d 00 00 00       	mov    $0xd,%eax
 373:	cd 40                	int    $0x40
 375:	c3                   	ret    

00000376 <uptime>:
SYSCALL(uptime)
 376:	b8 0e 00 00 00       	mov    $0xe,%eax
 37b:	cd 40                	int    $0x40
 37d:	c3                   	ret    

0000037e <print_proc>:
SYSCALL(print_proc)
 37e:	b8 16 00 00 00       	mov    $0x16,%eax
 383:	cd 40                	int    $0x40
 385:	c3                   	ret    

00000386 <change_queue>:
 386:	b8 17 00 00 00       	mov    $0x17,%eax
 38b:	cd 40                	int    $0x40
 38d:	c3                   	ret    

0000038e <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 38e:	55                   	push   %ebp
 38f:	89 e5                	mov    %esp,%ebp
 391:	83 ec 18             	sub    $0x18,%esp
 394:	8b 45 0c             	mov    0xc(%ebp),%eax
 397:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 39a:	83 ec 04             	sub    $0x4,%esp
 39d:	6a 01                	push   $0x1
 39f:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3a2:	50                   	push   %eax
 3a3:	ff 75 08             	push   0x8(%ebp)
 3a6:	e8 53 ff ff ff       	call   2fe <write>
 3ab:	83 c4 10             	add    $0x10,%esp
}
 3ae:	90                   	nop
 3af:	c9                   	leave  
 3b0:	c3                   	ret    

000003b1 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3b1:	55                   	push   %ebp
 3b2:	89 e5                	mov    %esp,%ebp
 3b4:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3b7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3be:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3c2:	74 17                	je     3db <printint+0x2a>
 3c4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3c8:	79 11                	jns    3db <printint+0x2a>
    neg = 1;
 3ca:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3d1:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d4:	f7 d8                	neg    %eax
 3d6:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3d9:	eb 06                	jmp    3e1 <printint+0x30>
  } else {
    x = xx;
 3db:	8b 45 0c             	mov    0xc(%ebp),%eax
 3de:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3e1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3e8:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3eb:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3ee:	ba 00 00 00 00       	mov    $0x0,%edx
 3f3:	f7 f1                	div    %ecx
 3f5:	89 d1                	mov    %edx,%ecx
 3f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3fa:	8d 50 01             	lea    0x1(%eax),%edx
 3fd:	89 55 f4             	mov    %edx,-0xc(%ebp)
 400:	0f b6 91 84 0a 00 00 	movzbl 0xa84(%ecx),%edx
 407:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 40b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 40e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 411:	ba 00 00 00 00       	mov    $0x0,%edx
 416:	f7 f1                	div    %ecx
 418:	89 45 ec             	mov    %eax,-0x14(%ebp)
 41b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 41f:	75 c7                	jne    3e8 <printint+0x37>
  if(neg)
 421:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 425:	74 2d                	je     454 <printint+0xa3>
    buf[i++] = '-';
 427:	8b 45 f4             	mov    -0xc(%ebp),%eax
 42a:	8d 50 01             	lea    0x1(%eax),%edx
 42d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 430:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 435:	eb 1d                	jmp    454 <printint+0xa3>
    putc(fd, buf[i]);
 437:	8d 55 dc             	lea    -0x24(%ebp),%edx
 43a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 43d:	01 d0                	add    %edx,%eax
 43f:	0f b6 00             	movzbl (%eax),%eax
 442:	0f be c0             	movsbl %al,%eax
 445:	83 ec 08             	sub    $0x8,%esp
 448:	50                   	push   %eax
 449:	ff 75 08             	push   0x8(%ebp)
 44c:	e8 3d ff ff ff       	call   38e <putc>
 451:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 454:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 458:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 45c:	79 d9                	jns    437 <printint+0x86>
}
 45e:	90                   	nop
 45f:	90                   	nop
 460:	c9                   	leave  
 461:	c3                   	ret    

00000462 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 462:	55                   	push   %ebp
 463:	89 e5                	mov    %esp,%ebp
 465:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 468:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 46f:	8d 45 0c             	lea    0xc(%ebp),%eax
 472:	83 c0 04             	add    $0x4,%eax
 475:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 478:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 47f:	e9 59 01 00 00       	jmp    5dd <printf+0x17b>
    c = fmt[i] & 0xff;
 484:	8b 55 0c             	mov    0xc(%ebp),%edx
 487:	8b 45 f0             	mov    -0x10(%ebp),%eax
 48a:	01 d0                	add    %edx,%eax
 48c:	0f b6 00             	movzbl (%eax),%eax
 48f:	0f be c0             	movsbl %al,%eax
 492:	25 ff 00 00 00       	and    $0xff,%eax
 497:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 49a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 49e:	75 2c                	jne    4cc <printf+0x6a>
      if(c == '%'){
 4a0:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4a4:	75 0c                	jne    4b2 <printf+0x50>
        state = '%';
 4a6:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4ad:	e9 27 01 00 00       	jmp    5d9 <printf+0x177>
      } else {
        putc(fd, c);
 4b2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4b5:	0f be c0             	movsbl %al,%eax
 4b8:	83 ec 08             	sub    $0x8,%esp
 4bb:	50                   	push   %eax
 4bc:	ff 75 08             	push   0x8(%ebp)
 4bf:	e8 ca fe ff ff       	call   38e <putc>
 4c4:	83 c4 10             	add    $0x10,%esp
 4c7:	e9 0d 01 00 00       	jmp    5d9 <printf+0x177>
      }
    } else if(state == '%'){
 4cc:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4d0:	0f 85 03 01 00 00    	jne    5d9 <printf+0x177>
      if(c == 'd'){
 4d6:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4da:	75 1e                	jne    4fa <printf+0x98>
        printint(fd, *ap, 10, 1);
 4dc:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4df:	8b 00                	mov    (%eax),%eax
 4e1:	6a 01                	push   $0x1
 4e3:	6a 0a                	push   $0xa
 4e5:	50                   	push   %eax
 4e6:	ff 75 08             	push   0x8(%ebp)
 4e9:	e8 c3 fe ff ff       	call   3b1 <printint>
 4ee:	83 c4 10             	add    $0x10,%esp
        ap++;
 4f1:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4f5:	e9 d8 00 00 00       	jmp    5d2 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4fa:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4fe:	74 06                	je     506 <printf+0xa4>
 500:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 504:	75 1e                	jne    524 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 506:	8b 45 e8             	mov    -0x18(%ebp),%eax
 509:	8b 00                	mov    (%eax),%eax
 50b:	6a 00                	push   $0x0
 50d:	6a 10                	push   $0x10
 50f:	50                   	push   %eax
 510:	ff 75 08             	push   0x8(%ebp)
 513:	e8 99 fe ff ff       	call   3b1 <printint>
 518:	83 c4 10             	add    $0x10,%esp
        ap++;
 51b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 51f:	e9 ae 00 00 00       	jmp    5d2 <printf+0x170>
      } else if(c == 's'){
 524:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 528:	75 43                	jne    56d <printf+0x10b>
        s = (char*)*ap;
 52a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 52d:	8b 00                	mov    (%eax),%eax
 52f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 532:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 536:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 53a:	75 25                	jne    561 <printf+0xff>
          s = "(null)";
 53c:	c7 45 f4 19 08 00 00 	movl   $0x819,-0xc(%ebp)
        while(*s != 0){
 543:	eb 1c                	jmp    561 <printf+0xff>
          putc(fd, *s);
 545:	8b 45 f4             	mov    -0xc(%ebp),%eax
 548:	0f b6 00             	movzbl (%eax),%eax
 54b:	0f be c0             	movsbl %al,%eax
 54e:	83 ec 08             	sub    $0x8,%esp
 551:	50                   	push   %eax
 552:	ff 75 08             	push   0x8(%ebp)
 555:	e8 34 fe ff ff       	call   38e <putc>
 55a:	83 c4 10             	add    $0x10,%esp
          s++;
 55d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 561:	8b 45 f4             	mov    -0xc(%ebp),%eax
 564:	0f b6 00             	movzbl (%eax),%eax
 567:	84 c0                	test   %al,%al
 569:	75 da                	jne    545 <printf+0xe3>
 56b:	eb 65                	jmp    5d2 <printf+0x170>
        }
      } else if(c == 'c'){
 56d:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 571:	75 1d                	jne    590 <printf+0x12e>
        putc(fd, *ap);
 573:	8b 45 e8             	mov    -0x18(%ebp),%eax
 576:	8b 00                	mov    (%eax),%eax
 578:	0f be c0             	movsbl %al,%eax
 57b:	83 ec 08             	sub    $0x8,%esp
 57e:	50                   	push   %eax
 57f:	ff 75 08             	push   0x8(%ebp)
 582:	e8 07 fe ff ff       	call   38e <putc>
 587:	83 c4 10             	add    $0x10,%esp
        ap++;
 58a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 58e:	eb 42                	jmp    5d2 <printf+0x170>
      } else if(c == '%'){
 590:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 594:	75 17                	jne    5ad <printf+0x14b>
        putc(fd, c);
 596:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 599:	0f be c0             	movsbl %al,%eax
 59c:	83 ec 08             	sub    $0x8,%esp
 59f:	50                   	push   %eax
 5a0:	ff 75 08             	push   0x8(%ebp)
 5a3:	e8 e6 fd ff ff       	call   38e <putc>
 5a8:	83 c4 10             	add    $0x10,%esp
 5ab:	eb 25                	jmp    5d2 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5ad:	83 ec 08             	sub    $0x8,%esp
 5b0:	6a 25                	push   $0x25
 5b2:	ff 75 08             	push   0x8(%ebp)
 5b5:	e8 d4 fd ff ff       	call   38e <putc>
 5ba:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5bd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5c0:	0f be c0             	movsbl %al,%eax
 5c3:	83 ec 08             	sub    $0x8,%esp
 5c6:	50                   	push   %eax
 5c7:	ff 75 08             	push   0x8(%ebp)
 5ca:	e8 bf fd ff ff       	call   38e <putc>
 5cf:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5d2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 5d9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5dd:	8b 55 0c             	mov    0xc(%ebp),%edx
 5e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5e3:	01 d0                	add    %edx,%eax
 5e5:	0f b6 00             	movzbl (%eax),%eax
 5e8:	84 c0                	test   %al,%al
 5ea:	0f 85 94 fe ff ff    	jne    484 <printf+0x22>
    }
  }
}
 5f0:	90                   	nop
 5f1:	90                   	nop
 5f2:	c9                   	leave  
 5f3:	c3                   	ret    

000005f4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5f4:	55                   	push   %ebp
 5f5:	89 e5                	mov    %esp,%ebp
 5f7:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5fa:	8b 45 08             	mov    0x8(%ebp),%eax
 5fd:	83 e8 08             	sub    $0x8,%eax
 600:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 603:	a1 a0 0a 00 00       	mov    0xaa0,%eax
 608:	89 45 fc             	mov    %eax,-0x4(%ebp)
 60b:	eb 24                	jmp    631 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 60d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 610:	8b 00                	mov    (%eax),%eax
 612:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 615:	72 12                	jb     629 <free+0x35>
 617:	8b 45 f8             	mov    -0x8(%ebp),%eax
 61a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 61d:	77 24                	ja     643 <free+0x4f>
 61f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 622:	8b 00                	mov    (%eax),%eax
 624:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 627:	72 1a                	jb     643 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 629:	8b 45 fc             	mov    -0x4(%ebp),%eax
 62c:	8b 00                	mov    (%eax),%eax
 62e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 631:	8b 45 f8             	mov    -0x8(%ebp),%eax
 634:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 637:	76 d4                	jbe    60d <free+0x19>
 639:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63c:	8b 00                	mov    (%eax),%eax
 63e:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 641:	73 ca                	jae    60d <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 643:	8b 45 f8             	mov    -0x8(%ebp),%eax
 646:	8b 40 04             	mov    0x4(%eax),%eax
 649:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 650:	8b 45 f8             	mov    -0x8(%ebp),%eax
 653:	01 c2                	add    %eax,%edx
 655:	8b 45 fc             	mov    -0x4(%ebp),%eax
 658:	8b 00                	mov    (%eax),%eax
 65a:	39 c2                	cmp    %eax,%edx
 65c:	75 24                	jne    682 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 65e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 661:	8b 50 04             	mov    0x4(%eax),%edx
 664:	8b 45 fc             	mov    -0x4(%ebp),%eax
 667:	8b 00                	mov    (%eax),%eax
 669:	8b 40 04             	mov    0x4(%eax),%eax
 66c:	01 c2                	add    %eax,%edx
 66e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 671:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 674:	8b 45 fc             	mov    -0x4(%ebp),%eax
 677:	8b 00                	mov    (%eax),%eax
 679:	8b 10                	mov    (%eax),%edx
 67b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67e:	89 10                	mov    %edx,(%eax)
 680:	eb 0a                	jmp    68c <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 682:	8b 45 fc             	mov    -0x4(%ebp),%eax
 685:	8b 10                	mov    (%eax),%edx
 687:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 68c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68f:	8b 40 04             	mov    0x4(%eax),%eax
 692:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 699:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69c:	01 d0                	add    %edx,%eax
 69e:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 6a1:	75 20                	jne    6c3 <free+0xcf>
    p->s.size += bp->s.size;
 6a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a6:	8b 50 04             	mov    0x4(%eax),%edx
 6a9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ac:	8b 40 04             	mov    0x4(%eax),%eax
 6af:	01 c2                	add    %eax,%edx
 6b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b4:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ba:	8b 10                	mov    (%eax),%edx
 6bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bf:	89 10                	mov    %edx,(%eax)
 6c1:	eb 08                	jmp    6cb <free+0xd7>
  } else
    p->s.ptr = bp;
 6c3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c6:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6c9:	89 10                	mov    %edx,(%eax)
  freep = p;
 6cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ce:	a3 a0 0a 00 00       	mov    %eax,0xaa0
}
 6d3:	90                   	nop
 6d4:	c9                   	leave  
 6d5:	c3                   	ret    

000006d6 <morecore>:

static Header*
morecore(uint nu)
{
 6d6:	55                   	push   %ebp
 6d7:	89 e5                	mov    %esp,%ebp
 6d9:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6dc:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6e3:	77 07                	ja     6ec <morecore+0x16>
    nu = 4096;
 6e5:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6ec:	8b 45 08             	mov    0x8(%ebp),%eax
 6ef:	c1 e0 03             	shl    $0x3,%eax
 6f2:	83 ec 0c             	sub    $0xc,%esp
 6f5:	50                   	push   %eax
 6f6:	e8 6b fc ff ff       	call   366 <sbrk>
 6fb:	83 c4 10             	add    $0x10,%esp
 6fe:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 701:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 705:	75 07                	jne    70e <morecore+0x38>
    return 0;
 707:	b8 00 00 00 00       	mov    $0x0,%eax
 70c:	eb 26                	jmp    734 <morecore+0x5e>
  hp = (Header*)p;
 70e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 711:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 714:	8b 45 f0             	mov    -0x10(%ebp),%eax
 717:	8b 55 08             	mov    0x8(%ebp),%edx
 71a:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 71d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 720:	83 c0 08             	add    $0x8,%eax
 723:	83 ec 0c             	sub    $0xc,%esp
 726:	50                   	push   %eax
 727:	e8 c8 fe ff ff       	call   5f4 <free>
 72c:	83 c4 10             	add    $0x10,%esp
  return freep;
 72f:	a1 a0 0a 00 00       	mov    0xaa0,%eax
}
 734:	c9                   	leave  
 735:	c3                   	ret    

00000736 <malloc>:

void*
malloc(uint nbytes)
{
 736:	55                   	push   %ebp
 737:	89 e5                	mov    %esp,%ebp
 739:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 73c:	8b 45 08             	mov    0x8(%ebp),%eax
 73f:	83 c0 07             	add    $0x7,%eax
 742:	c1 e8 03             	shr    $0x3,%eax
 745:	83 c0 01             	add    $0x1,%eax
 748:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 74b:	a1 a0 0a 00 00       	mov    0xaa0,%eax
 750:	89 45 f0             	mov    %eax,-0x10(%ebp)
 753:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 757:	75 23                	jne    77c <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 759:	c7 45 f0 98 0a 00 00 	movl   $0xa98,-0x10(%ebp)
 760:	8b 45 f0             	mov    -0x10(%ebp),%eax
 763:	a3 a0 0a 00 00       	mov    %eax,0xaa0
 768:	a1 a0 0a 00 00       	mov    0xaa0,%eax
 76d:	a3 98 0a 00 00       	mov    %eax,0xa98
    base.s.size = 0;
 772:	c7 05 9c 0a 00 00 00 	movl   $0x0,0xa9c
 779:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 77c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 77f:	8b 00                	mov    (%eax),%eax
 781:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 784:	8b 45 f4             	mov    -0xc(%ebp),%eax
 787:	8b 40 04             	mov    0x4(%eax),%eax
 78a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 78d:	77 4d                	ja     7dc <malloc+0xa6>
      if(p->s.size == nunits)
 78f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 792:	8b 40 04             	mov    0x4(%eax),%eax
 795:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 798:	75 0c                	jne    7a6 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 79a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79d:	8b 10                	mov    (%eax),%edx
 79f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7a2:	89 10                	mov    %edx,(%eax)
 7a4:	eb 26                	jmp    7cc <malloc+0x96>
      else {
        p->s.size -= nunits;
 7a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a9:	8b 40 04             	mov    0x4(%eax),%eax
 7ac:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7af:	89 c2                	mov    %eax,%edx
 7b1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b4:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ba:	8b 40 04             	mov    0x4(%eax),%eax
 7bd:	c1 e0 03             	shl    $0x3,%eax
 7c0:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c6:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7c9:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7cf:	a3 a0 0a 00 00       	mov    %eax,0xaa0
      return (void*)(p + 1);
 7d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d7:	83 c0 08             	add    $0x8,%eax
 7da:	eb 3b                	jmp    817 <malloc+0xe1>
    }
    if(p == freep)
 7dc:	a1 a0 0a 00 00       	mov    0xaa0,%eax
 7e1:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7e4:	75 1e                	jne    804 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7e6:	83 ec 0c             	sub    $0xc,%esp
 7e9:	ff 75 ec             	push   -0x14(%ebp)
 7ec:	e8 e5 fe ff ff       	call   6d6 <morecore>
 7f1:	83 c4 10             	add    $0x10,%esp
 7f4:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7f7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7fb:	75 07                	jne    804 <malloc+0xce>
        return 0;
 7fd:	b8 00 00 00 00       	mov    $0x0,%eax
 802:	eb 13                	jmp    817 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 804:	8b 45 f4             	mov    -0xc(%ebp),%eax
 807:	89 45 f0             	mov    %eax,-0x10(%ebp)
 80a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80d:	8b 00                	mov    (%eax),%eax
 80f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 812:	e9 6d ff ff ff       	jmp    784 <malloc+0x4e>
  }
}
 817:	c9                   	leave  
 818:	c3                   	ret    
