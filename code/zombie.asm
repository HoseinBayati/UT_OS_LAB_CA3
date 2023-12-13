
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
SYSCALL(change_queue)
 386:	b8 17 00 00 00       	mov    $0x17,%eax
 38b:	cd 40                	int    $0x40
 38d:	c3                   	ret    

0000038e <change_local_bjf>:
SYSCALL(change_local_bjf)
 38e:	b8 18 00 00 00       	mov    $0x18,%eax
 393:	cd 40                	int    $0x40
 395:	c3                   	ret    

00000396 <change_global_bjf>:
SYSCALL(change_global_bjf)
 396:	b8 19 00 00 00       	mov    $0x19,%eax
 39b:	cd 40                	int    $0x40
 39d:	c3                   	ret    

0000039e <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 39e:	55                   	push   %ebp
 39f:	89 e5                	mov    %esp,%ebp
 3a1:	83 ec 18             	sub    $0x18,%esp
 3a4:	8b 45 0c             	mov    0xc(%ebp),%eax
 3a7:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3aa:	83 ec 04             	sub    $0x4,%esp
 3ad:	6a 01                	push   $0x1
 3af:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3b2:	50                   	push   %eax
 3b3:	ff 75 08             	push   0x8(%ebp)
 3b6:	e8 43 ff ff ff       	call   2fe <write>
 3bb:	83 c4 10             	add    $0x10,%esp
}
 3be:	90                   	nop
 3bf:	c9                   	leave  
 3c0:	c3                   	ret    

000003c1 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3c1:	55                   	push   %ebp
 3c2:	89 e5                	mov    %esp,%ebp
 3c4:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3c7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3ce:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3d2:	74 17                	je     3eb <printint+0x2a>
 3d4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3d8:	79 11                	jns    3eb <printint+0x2a>
    neg = 1;
 3da:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3e1:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e4:	f7 d8                	neg    %eax
 3e6:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3e9:	eb 06                	jmp    3f1 <printint+0x30>
  } else {
    x = xx;
 3eb:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ee:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3f1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3f8:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3fb:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3fe:	ba 00 00 00 00       	mov    $0x0,%edx
 403:	f7 f1                	div    %ecx
 405:	89 d1                	mov    %edx,%ecx
 407:	8b 45 f4             	mov    -0xc(%ebp),%eax
 40a:	8d 50 01             	lea    0x1(%eax),%edx
 40d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 410:	0f b6 91 94 0a 00 00 	movzbl 0xa94(%ecx),%edx
 417:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 41b:	8b 4d 10             	mov    0x10(%ebp),%ecx
 41e:	8b 45 ec             	mov    -0x14(%ebp),%eax
 421:	ba 00 00 00 00       	mov    $0x0,%edx
 426:	f7 f1                	div    %ecx
 428:	89 45 ec             	mov    %eax,-0x14(%ebp)
 42b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 42f:	75 c7                	jne    3f8 <printint+0x37>
  if(neg)
 431:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 435:	74 2d                	je     464 <printint+0xa3>
    buf[i++] = '-';
 437:	8b 45 f4             	mov    -0xc(%ebp),%eax
 43a:	8d 50 01             	lea    0x1(%eax),%edx
 43d:	89 55 f4             	mov    %edx,-0xc(%ebp)
 440:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 445:	eb 1d                	jmp    464 <printint+0xa3>
    putc(fd, buf[i]);
 447:	8d 55 dc             	lea    -0x24(%ebp),%edx
 44a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 44d:	01 d0                	add    %edx,%eax
 44f:	0f b6 00             	movzbl (%eax),%eax
 452:	0f be c0             	movsbl %al,%eax
 455:	83 ec 08             	sub    $0x8,%esp
 458:	50                   	push   %eax
 459:	ff 75 08             	push   0x8(%ebp)
 45c:	e8 3d ff ff ff       	call   39e <putc>
 461:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 464:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 468:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 46c:	79 d9                	jns    447 <printint+0x86>
}
 46e:	90                   	nop
 46f:	90                   	nop
 470:	c9                   	leave  
 471:	c3                   	ret    

00000472 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 472:	55                   	push   %ebp
 473:	89 e5                	mov    %esp,%ebp
 475:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 478:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 47f:	8d 45 0c             	lea    0xc(%ebp),%eax
 482:	83 c0 04             	add    $0x4,%eax
 485:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 488:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 48f:	e9 59 01 00 00       	jmp    5ed <printf+0x17b>
    c = fmt[i] & 0xff;
 494:	8b 55 0c             	mov    0xc(%ebp),%edx
 497:	8b 45 f0             	mov    -0x10(%ebp),%eax
 49a:	01 d0                	add    %edx,%eax
 49c:	0f b6 00             	movzbl (%eax),%eax
 49f:	0f be c0             	movsbl %al,%eax
 4a2:	25 ff 00 00 00       	and    $0xff,%eax
 4a7:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4aa:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4ae:	75 2c                	jne    4dc <printf+0x6a>
      if(c == '%'){
 4b0:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4b4:	75 0c                	jne    4c2 <printf+0x50>
        state = '%';
 4b6:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4bd:	e9 27 01 00 00       	jmp    5e9 <printf+0x177>
      } else {
        putc(fd, c);
 4c2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4c5:	0f be c0             	movsbl %al,%eax
 4c8:	83 ec 08             	sub    $0x8,%esp
 4cb:	50                   	push   %eax
 4cc:	ff 75 08             	push   0x8(%ebp)
 4cf:	e8 ca fe ff ff       	call   39e <putc>
 4d4:	83 c4 10             	add    $0x10,%esp
 4d7:	e9 0d 01 00 00       	jmp    5e9 <printf+0x177>
      }
    } else if(state == '%'){
 4dc:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4e0:	0f 85 03 01 00 00    	jne    5e9 <printf+0x177>
      if(c == 'd'){
 4e6:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4ea:	75 1e                	jne    50a <printf+0x98>
        printint(fd, *ap, 10, 1);
 4ec:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4ef:	8b 00                	mov    (%eax),%eax
 4f1:	6a 01                	push   $0x1
 4f3:	6a 0a                	push   $0xa
 4f5:	50                   	push   %eax
 4f6:	ff 75 08             	push   0x8(%ebp)
 4f9:	e8 c3 fe ff ff       	call   3c1 <printint>
 4fe:	83 c4 10             	add    $0x10,%esp
        ap++;
 501:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 505:	e9 d8 00 00 00       	jmp    5e2 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 50a:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 50e:	74 06                	je     516 <printf+0xa4>
 510:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 514:	75 1e                	jne    534 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 516:	8b 45 e8             	mov    -0x18(%ebp),%eax
 519:	8b 00                	mov    (%eax),%eax
 51b:	6a 00                	push   $0x0
 51d:	6a 10                	push   $0x10
 51f:	50                   	push   %eax
 520:	ff 75 08             	push   0x8(%ebp)
 523:	e8 99 fe ff ff       	call   3c1 <printint>
 528:	83 c4 10             	add    $0x10,%esp
        ap++;
 52b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 52f:	e9 ae 00 00 00       	jmp    5e2 <printf+0x170>
      } else if(c == 's'){
 534:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 538:	75 43                	jne    57d <printf+0x10b>
        s = (char*)*ap;
 53a:	8b 45 e8             	mov    -0x18(%ebp),%eax
 53d:	8b 00                	mov    (%eax),%eax
 53f:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 542:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 546:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 54a:	75 25                	jne    571 <printf+0xff>
          s = "(null)";
 54c:	c7 45 f4 29 08 00 00 	movl   $0x829,-0xc(%ebp)
        while(*s != 0){
 553:	eb 1c                	jmp    571 <printf+0xff>
          putc(fd, *s);
 555:	8b 45 f4             	mov    -0xc(%ebp),%eax
 558:	0f b6 00             	movzbl (%eax),%eax
 55b:	0f be c0             	movsbl %al,%eax
 55e:	83 ec 08             	sub    $0x8,%esp
 561:	50                   	push   %eax
 562:	ff 75 08             	push   0x8(%ebp)
 565:	e8 34 fe ff ff       	call   39e <putc>
 56a:	83 c4 10             	add    $0x10,%esp
          s++;
 56d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 571:	8b 45 f4             	mov    -0xc(%ebp),%eax
 574:	0f b6 00             	movzbl (%eax),%eax
 577:	84 c0                	test   %al,%al
 579:	75 da                	jne    555 <printf+0xe3>
 57b:	eb 65                	jmp    5e2 <printf+0x170>
        }
      } else if(c == 'c'){
 57d:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 581:	75 1d                	jne    5a0 <printf+0x12e>
        putc(fd, *ap);
 583:	8b 45 e8             	mov    -0x18(%ebp),%eax
 586:	8b 00                	mov    (%eax),%eax
 588:	0f be c0             	movsbl %al,%eax
 58b:	83 ec 08             	sub    $0x8,%esp
 58e:	50                   	push   %eax
 58f:	ff 75 08             	push   0x8(%ebp)
 592:	e8 07 fe ff ff       	call   39e <putc>
 597:	83 c4 10             	add    $0x10,%esp
        ap++;
 59a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 59e:	eb 42                	jmp    5e2 <printf+0x170>
      } else if(c == '%'){
 5a0:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5a4:	75 17                	jne    5bd <printf+0x14b>
        putc(fd, c);
 5a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5a9:	0f be c0             	movsbl %al,%eax
 5ac:	83 ec 08             	sub    $0x8,%esp
 5af:	50                   	push   %eax
 5b0:	ff 75 08             	push   0x8(%ebp)
 5b3:	e8 e6 fd ff ff       	call   39e <putc>
 5b8:	83 c4 10             	add    $0x10,%esp
 5bb:	eb 25                	jmp    5e2 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5bd:	83 ec 08             	sub    $0x8,%esp
 5c0:	6a 25                	push   $0x25
 5c2:	ff 75 08             	push   0x8(%ebp)
 5c5:	e8 d4 fd ff ff       	call   39e <putc>
 5ca:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5cd:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5d0:	0f be c0             	movsbl %al,%eax
 5d3:	83 ec 08             	sub    $0x8,%esp
 5d6:	50                   	push   %eax
 5d7:	ff 75 08             	push   0x8(%ebp)
 5da:	e8 bf fd ff ff       	call   39e <putc>
 5df:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5e2:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 5e9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5ed:	8b 55 0c             	mov    0xc(%ebp),%edx
 5f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5f3:	01 d0                	add    %edx,%eax
 5f5:	0f b6 00             	movzbl (%eax),%eax
 5f8:	84 c0                	test   %al,%al
 5fa:	0f 85 94 fe ff ff    	jne    494 <printf+0x22>
    }
  }
}
 600:	90                   	nop
 601:	90                   	nop
 602:	c9                   	leave  
 603:	c3                   	ret    

00000604 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 604:	55                   	push   %ebp
 605:	89 e5                	mov    %esp,%ebp
 607:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 60a:	8b 45 08             	mov    0x8(%ebp),%eax
 60d:	83 e8 08             	sub    $0x8,%eax
 610:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 613:	a1 b0 0a 00 00       	mov    0xab0,%eax
 618:	89 45 fc             	mov    %eax,-0x4(%ebp)
 61b:	eb 24                	jmp    641 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 61d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 620:	8b 00                	mov    (%eax),%eax
 622:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 625:	72 12                	jb     639 <free+0x35>
 627:	8b 45 f8             	mov    -0x8(%ebp),%eax
 62a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 62d:	77 24                	ja     653 <free+0x4f>
 62f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 632:	8b 00                	mov    (%eax),%eax
 634:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 637:	72 1a                	jb     653 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 639:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63c:	8b 00                	mov    (%eax),%eax
 63e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 641:	8b 45 f8             	mov    -0x8(%ebp),%eax
 644:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 647:	76 d4                	jbe    61d <free+0x19>
 649:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64c:	8b 00                	mov    (%eax),%eax
 64e:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 651:	73 ca                	jae    61d <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 653:	8b 45 f8             	mov    -0x8(%ebp),%eax
 656:	8b 40 04             	mov    0x4(%eax),%eax
 659:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 660:	8b 45 f8             	mov    -0x8(%ebp),%eax
 663:	01 c2                	add    %eax,%edx
 665:	8b 45 fc             	mov    -0x4(%ebp),%eax
 668:	8b 00                	mov    (%eax),%eax
 66a:	39 c2                	cmp    %eax,%edx
 66c:	75 24                	jne    692 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 66e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 671:	8b 50 04             	mov    0x4(%eax),%edx
 674:	8b 45 fc             	mov    -0x4(%ebp),%eax
 677:	8b 00                	mov    (%eax),%eax
 679:	8b 40 04             	mov    0x4(%eax),%eax
 67c:	01 c2                	add    %eax,%edx
 67e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 681:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 684:	8b 45 fc             	mov    -0x4(%ebp),%eax
 687:	8b 00                	mov    (%eax),%eax
 689:	8b 10                	mov    (%eax),%edx
 68b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68e:	89 10                	mov    %edx,(%eax)
 690:	eb 0a                	jmp    69c <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 692:	8b 45 fc             	mov    -0x4(%ebp),%eax
 695:	8b 10                	mov    (%eax),%edx
 697:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69a:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 69c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69f:	8b 40 04             	mov    0x4(%eax),%eax
 6a2:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ac:	01 d0                	add    %edx,%eax
 6ae:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 6b1:	75 20                	jne    6d3 <free+0xcf>
    p->s.size += bp->s.size;
 6b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b6:	8b 50 04             	mov    0x4(%eax),%edx
 6b9:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6bc:	8b 40 04             	mov    0x4(%eax),%eax
 6bf:	01 c2                	add    %eax,%edx
 6c1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c4:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ca:	8b 10                	mov    (%eax),%edx
 6cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cf:	89 10                	mov    %edx,(%eax)
 6d1:	eb 08                	jmp    6db <free+0xd7>
  } else
    p->s.ptr = bp;
 6d3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d6:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6d9:	89 10                	mov    %edx,(%eax)
  freep = p;
 6db:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6de:	a3 b0 0a 00 00       	mov    %eax,0xab0
}
 6e3:	90                   	nop
 6e4:	c9                   	leave  
 6e5:	c3                   	ret    

000006e6 <morecore>:

static Header*
morecore(uint nu)
{
 6e6:	55                   	push   %ebp
 6e7:	89 e5                	mov    %esp,%ebp
 6e9:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6ec:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6f3:	77 07                	ja     6fc <morecore+0x16>
    nu = 4096;
 6f5:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6fc:	8b 45 08             	mov    0x8(%ebp),%eax
 6ff:	c1 e0 03             	shl    $0x3,%eax
 702:	83 ec 0c             	sub    $0xc,%esp
 705:	50                   	push   %eax
 706:	e8 5b fc ff ff       	call   366 <sbrk>
 70b:	83 c4 10             	add    $0x10,%esp
 70e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 711:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 715:	75 07                	jne    71e <morecore+0x38>
    return 0;
 717:	b8 00 00 00 00       	mov    $0x0,%eax
 71c:	eb 26                	jmp    744 <morecore+0x5e>
  hp = (Header*)p;
 71e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 721:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 724:	8b 45 f0             	mov    -0x10(%ebp),%eax
 727:	8b 55 08             	mov    0x8(%ebp),%edx
 72a:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 72d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 730:	83 c0 08             	add    $0x8,%eax
 733:	83 ec 0c             	sub    $0xc,%esp
 736:	50                   	push   %eax
 737:	e8 c8 fe ff ff       	call   604 <free>
 73c:	83 c4 10             	add    $0x10,%esp
  return freep;
 73f:	a1 b0 0a 00 00       	mov    0xab0,%eax
}
 744:	c9                   	leave  
 745:	c3                   	ret    

00000746 <malloc>:

void*
malloc(uint nbytes)
{
 746:	55                   	push   %ebp
 747:	89 e5                	mov    %esp,%ebp
 749:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 74c:	8b 45 08             	mov    0x8(%ebp),%eax
 74f:	83 c0 07             	add    $0x7,%eax
 752:	c1 e8 03             	shr    $0x3,%eax
 755:	83 c0 01             	add    $0x1,%eax
 758:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 75b:	a1 b0 0a 00 00       	mov    0xab0,%eax
 760:	89 45 f0             	mov    %eax,-0x10(%ebp)
 763:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 767:	75 23                	jne    78c <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 769:	c7 45 f0 a8 0a 00 00 	movl   $0xaa8,-0x10(%ebp)
 770:	8b 45 f0             	mov    -0x10(%ebp),%eax
 773:	a3 b0 0a 00 00       	mov    %eax,0xab0
 778:	a1 b0 0a 00 00       	mov    0xab0,%eax
 77d:	a3 a8 0a 00 00       	mov    %eax,0xaa8
    base.s.size = 0;
 782:	c7 05 ac 0a 00 00 00 	movl   $0x0,0xaac
 789:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 78c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 78f:	8b 00                	mov    (%eax),%eax
 791:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 794:	8b 45 f4             	mov    -0xc(%ebp),%eax
 797:	8b 40 04             	mov    0x4(%eax),%eax
 79a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 79d:	77 4d                	ja     7ec <malloc+0xa6>
      if(p->s.size == nunits)
 79f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a2:	8b 40 04             	mov    0x4(%eax),%eax
 7a5:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7a8:	75 0c                	jne    7b6 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ad:	8b 10                	mov    (%eax),%edx
 7af:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b2:	89 10                	mov    %edx,(%eax)
 7b4:	eb 26                	jmp    7dc <malloc+0x96>
      else {
        p->s.size -= nunits;
 7b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7b9:	8b 40 04             	mov    0x4(%eax),%eax
 7bc:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7bf:	89 c2                	mov    %eax,%edx
 7c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c4:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7c7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ca:	8b 40 04             	mov    0x4(%eax),%eax
 7cd:	c1 e0 03             	shl    $0x3,%eax
 7d0:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d6:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7d9:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7dc:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7df:	a3 b0 0a 00 00       	mov    %eax,0xab0
      return (void*)(p + 1);
 7e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e7:	83 c0 08             	add    $0x8,%eax
 7ea:	eb 3b                	jmp    827 <malloc+0xe1>
    }
    if(p == freep)
 7ec:	a1 b0 0a 00 00       	mov    0xab0,%eax
 7f1:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7f4:	75 1e                	jne    814 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7f6:	83 ec 0c             	sub    $0xc,%esp
 7f9:	ff 75 ec             	push   -0x14(%ebp)
 7fc:	e8 e5 fe ff ff       	call   6e6 <morecore>
 801:	83 c4 10             	add    $0x10,%esp
 804:	89 45 f4             	mov    %eax,-0xc(%ebp)
 807:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 80b:	75 07                	jne    814 <malloc+0xce>
        return 0;
 80d:	b8 00 00 00 00       	mov    $0x0,%eax
 812:	eb 13                	jmp    827 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 814:	8b 45 f4             	mov    -0xc(%ebp),%eax
 817:	89 45 f0             	mov    %eax,-0x10(%ebp)
 81a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81d:	8b 00                	mov    (%eax),%eax
 81f:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 822:	e9 6d ff ff ff       	jmp    794 <malloc+0x4e>
  }
}
 827:	c9                   	leave  
 828:	c3                   	ret    
