
_echo:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "stat.h"
#include "user.h"

int
main(int argc, char *argv[])
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

  for(i = 1; i < argc; i++)
  14:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  1b:	eb 3c                	jmp    59 <main+0x59>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  1d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  20:	83 c0 01             	add    $0x1,%eax
  23:	39 03                	cmp    %eax,(%ebx)
  25:	7e 07                	jle    2e <main+0x2e>
  27:	ba 62 08 00 00       	mov    $0x862,%edx
  2c:	eb 05                	jmp    33 <main+0x33>
  2e:	ba 64 08 00 00       	mov    $0x864,%edx
  33:	8b 45 f4             	mov    -0xc(%ebp),%eax
  36:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  3d:	8b 43 04             	mov    0x4(%ebx),%eax
  40:	01 c8                	add    %ecx,%eax
  42:	8b 00                	mov    (%eax),%eax
  44:	52                   	push   %edx
  45:	50                   	push   %eax
  46:	68 66 08 00 00       	push   $0x866
  4b:	6a 01                	push   $0x1
  4d:	e8 59 04 00 00       	call   4ab <printf>
  52:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i < argc; i++)
  55:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  59:	8b 45 f4             	mov    -0xc(%ebp),%eax
  5c:	3b 03                	cmp    (%ebx),%eax
  5e:	7c bd                	jl     1d <main+0x1d>
  exit();
  60:	e8 b2 02 00 00       	call   317 <exit>

00000065 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  65:	55                   	push   %ebp
  66:	89 e5                	mov    %esp,%ebp
  68:	57                   	push   %edi
  69:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  6a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  6d:	8b 55 10             	mov    0x10(%ebp),%edx
  70:	8b 45 0c             	mov    0xc(%ebp),%eax
  73:	89 cb                	mov    %ecx,%ebx
  75:	89 df                	mov    %ebx,%edi
  77:	89 d1                	mov    %edx,%ecx
  79:	fc                   	cld    
  7a:	f3 aa                	rep stos %al,%es:(%edi)
  7c:	89 ca                	mov    %ecx,%edx
  7e:	89 fb                	mov    %edi,%ebx
  80:	89 5d 08             	mov    %ebx,0x8(%ebp)
  83:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  86:	90                   	nop
  87:	5b                   	pop    %ebx
  88:	5f                   	pop    %edi
  89:	5d                   	pop    %ebp
  8a:	c3                   	ret    

0000008b <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  8b:	55                   	push   %ebp
  8c:	89 e5                	mov    %esp,%ebp
  8e:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  91:	8b 45 08             	mov    0x8(%ebp),%eax
  94:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  97:	90                   	nop
  98:	8b 55 0c             	mov    0xc(%ebp),%edx
  9b:	8d 42 01             	lea    0x1(%edx),%eax
  9e:	89 45 0c             	mov    %eax,0xc(%ebp)
  a1:	8b 45 08             	mov    0x8(%ebp),%eax
  a4:	8d 48 01             	lea    0x1(%eax),%ecx
  a7:	89 4d 08             	mov    %ecx,0x8(%ebp)
  aa:	0f b6 12             	movzbl (%edx),%edx
  ad:	88 10                	mov    %dl,(%eax)
  af:	0f b6 00             	movzbl (%eax),%eax
  b2:	84 c0                	test   %al,%al
  b4:	75 e2                	jne    98 <strcpy+0xd>
    ;
  return os;
  b6:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  b9:	c9                   	leave  
  ba:	c3                   	ret    

000000bb <strcmp>:

int
strcmp(const char *p, const char *q)
{
  bb:	55                   	push   %ebp
  bc:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  be:	eb 08                	jmp    c8 <strcmp+0xd>
    p++, q++;
  c0:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  c4:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
  c8:	8b 45 08             	mov    0x8(%ebp),%eax
  cb:	0f b6 00             	movzbl (%eax),%eax
  ce:	84 c0                	test   %al,%al
  d0:	74 10                	je     e2 <strcmp+0x27>
  d2:	8b 45 08             	mov    0x8(%ebp),%eax
  d5:	0f b6 10             	movzbl (%eax),%edx
  d8:	8b 45 0c             	mov    0xc(%ebp),%eax
  db:	0f b6 00             	movzbl (%eax),%eax
  de:	38 c2                	cmp    %al,%dl
  e0:	74 de                	je     c0 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
  e2:	8b 45 08             	mov    0x8(%ebp),%eax
  e5:	0f b6 00             	movzbl (%eax),%eax
  e8:	0f b6 d0             	movzbl %al,%edx
  eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  ee:	0f b6 00             	movzbl (%eax),%eax
  f1:	0f b6 c8             	movzbl %al,%ecx
  f4:	89 d0                	mov    %edx,%eax
  f6:	29 c8                	sub    %ecx,%eax
}
  f8:	5d                   	pop    %ebp
  f9:	c3                   	ret    

000000fa <strlen>:

uint
strlen(const char *s)
{
  fa:	55                   	push   %ebp
  fb:	89 e5                	mov    %esp,%ebp
  fd:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 100:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 107:	eb 04                	jmp    10d <strlen+0x13>
 109:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 10d:	8b 55 fc             	mov    -0x4(%ebp),%edx
 110:	8b 45 08             	mov    0x8(%ebp),%eax
 113:	01 d0                	add    %edx,%eax
 115:	0f b6 00             	movzbl (%eax),%eax
 118:	84 c0                	test   %al,%al
 11a:	75 ed                	jne    109 <strlen+0xf>
    ;
  return n;
 11c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 11f:	c9                   	leave  
 120:	c3                   	ret    

00000121 <memset>:

void*
memset(void *dst, int c, uint n)
{
 121:	55                   	push   %ebp
 122:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 124:	8b 45 10             	mov    0x10(%ebp),%eax
 127:	50                   	push   %eax
 128:	ff 75 0c             	push   0xc(%ebp)
 12b:	ff 75 08             	push   0x8(%ebp)
 12e:	e8 32 ff ff ff       	call   65 <stosb>
 133:	83 c4 0c             	add    $0xc,%esp
  return dst;
 136:	8b 45 08             	mov    0x8(%ebp),%eax
}
 139:	c9                   	leave  
 13a:	c3                   	ret    

0000013b <strchr>:

char*
strchr(const char *s, char c)
{
 13b:	55                   	push   %ebp
 13c:	89 e5                	mov    %esp,%ebp
 13e:	83 ec 04             	sub    $0x4,%esp
 141:	8b 45 0c             	mov    0xc(%ebp),%eax
 144:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 147:	eb 14                	jmp    15d <strchr+0x22>
    if(*s == c)
 149:	8b 45 08             	mov    0x8(%ebp),%eax
 14c:	0f b6 00             	movzbl (%eax),%eax
 14f:	38 45 fc             	cmp    %al,-0x4(%ebp)
 152:	75 05                	jne    159 <strchr+0x1e>
      return (char*)s;
 154:	8b 45 08             	mov    0x8(%ebp),%eax
 157:	eb 13                	jmp    16c <strchr+0x31>
  for(; *s; s++)
 159:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 15d:	8b 45 08             	mov    0x8(%ebp),%eax
 160:	0f b6 00             	movzbl (%eax),%eax
 163:	84 c0                	test   %al,%al
 165:	75 e2                	jne    149 <strchr+0xe>
  return 0;
 167:	b8 00 00 00 00       	mov    $0x0,%eax
}
 16c:	c9                   	leave  
 16d:	c3                   	ret    

0000016e <gets>:

char*
gets(char *buf, int max)
{
 16e:	55                   	push   %ebp
 16f:	89 e5                	mov    %esp,%ebp
 171:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 174:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 17b:	eb 42                	jmp    1bf <gets+0x51>
    cc = read(0, &c, 1);
 17d:	83 ec 04             	sub    $0x4,%esp
 180:	6a 01                	push   $0x1
 182:	8d 45 ef             	lea    -0x11(%ebp),%eax
 185:	50                   	push   %eax
 186:	6a 00                	push   $0x0
 188:	e8 a2 01 00 00       	call   32f <read>
 18d:	83 c4 10             	add    $0x10,%esp
 190:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 193:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 197:	7e 33                	jle    1cc <gets+0x5e>
      break;
    buf[i++] = c;
 199:	8b 45 f4             	mov    -0xc(%ebp),%eax
 19c:	8d 50 01             	lea    0x1(%eax),%edx
 19f:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1a2:	89 c2                	mov    %eax,%edx
 1a4:	8b 45 08             	mov    0x8(%ebp),%eax
 1a7:	01 c2                	add    %eax,%edx
 1a9:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1ad:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1af:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1b3:	3c 0a                	cmp    $0xa,%al
 1b5:	74 16                	je     1cd <gets+0x5f>
 1b7:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1bb:	3c 0d                	cmp    $0xd,%al
 1bd:	74 0e                	je     1cd <gets+0x5f>
  for(i=0; i+1 < max; ){
 1bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c2:	83 c0 01             	add    $0x1,%eax
 1c5:	39 45 0c             	cmp    %eax,0xc(%ebp)
 1c8:	7f b3                	jg     17d <gets+0xf>
 1ca:	eb 01                	jmp    1cd <gets+0x5f>
      break;
 1cc:	90                   	nop
      break;
  }
  buf[i] = '\0';
 1cd:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1d0:	8b 45 08             	mov    0x8(%ebp),%eax
 1d3:	01 d0                	add    %edx,%eax
 1d5:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1d8:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1db:	c9                   	leave  
 1dc:	c3                   	ret    

000001dd <stat>:

int
stat(const char *n, struct stat *st)
{
 1dd:	55                   	push   %ebp
 1de:	89 e5                	mov    %esp,%ebp
 1e0:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1e3:	83 ec 08             	sub    $0x8,%esp
 1e6:	6a 00                	push   $0x0
 1e8:	ff 75 08             	push   0x8(%ebp)
 1eb:	e8 67 01 00 00       	call   357 <open>
 1f0:	83 c4 10             	add    $0x10,%esp
 1f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1fa:	79 07                	jns    203 <stat+0x26>
    return -1;
 1fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 201:	eb 25                	jmp    228 <stat+0x4b>
  r = fstat(fd, st);
 203:	83 ec 08             	sub    $0x8,%esp
 206:	ff 75 0c             	push   0xc(%ebp)
 209:	ff 75 f4             	push   -0xc(%ebp)
 20c:	e8 5e 01 00 00       	call   36f <fstat>
 211:	83 c4 10             	add    $0x10,%esp
 214:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 217:	83 ec 0c             	sub    $0xc,%esp
 21a:	ff 75 f4             	push   -0xc(%ebp)
 21d:	e8 1d 01 00 00       	call   33f <close>
 222:	83 c4 10             	add    $0x10,%esp
  return r;
 225:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 228:	c9                   	leave  
 229:	c3                   	ret    

0000022a <atoi>:

int
atoi(const char *s)
{
 22a:	55                   	push   %ebp
 22b:	89 e5                	mov    %esp,%ebp
 22d:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 230:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 237:	eb 25                	jmp    25e <atoi+0x34>
    n = n*10 + *s++ - '0';
 239:	8b 55 fc             	mov    -0x4(%ebp),%edx
 23c:	89 d0                	mov    %edx,%eax
 23e:	c1 e0 02             	shl    $0x2,%eax
 241:	01 d0                	add    %edx,%eax
 243:	01 c0                	add    %eax,%eax
 245:	89 c1                	mov    %eax,%ecx
 247:	8b 45 08             	mov    0x8(%ebp),%eax
 24a:	8d 50 01             	lea    0x1(%eax),%edx
 24d:	89 55 08             	mov    %edx,0x8(%ebp)
 250:	0f b6 00             	movzbl (%eax),%eax
 253:	0f be c0             	movsbl %al,%eax
 256:	01 c8                	add    %ecx,%eax
 258:	83 e8 30             	sub    $0x30,%eax
 25b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 25e:	8b 45 08             	mov    0x8(%ebp),%eax
 261:	0f b6 00             	movzbl (%eax),%eax
 264:	3c 2f                	cmp    $0x2f,%al
 266:	7e 0a                	jle    272 <atoi+0x48>
 268:	8b 45 08             	mov    0x8(%ebp),%eax
 26b:	0f b6 00             	movzbl (%eax),%eax
 26e:	3c 39                	cmp    $0x39,%al
 270:	7e c7                	jle    239 <atoi+0xf>
  return n;
 272:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 275:	c9                   	leave  
 276:	c3                   	ret    

00000277 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 277:	55                   	push   %ebp
 278:	89 e5                	mov    %esp,%ebp
 27a:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
 27d:	8b 45 08             	mov    0x8(%ebp),%eax
 280:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 283:	8b 45 0c             	mov    0xc(%ebp),%eax
 286:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 289:	eb 17                	jmp    2a2 <memmove+0x2b>
    *dst++ = *src++;
 28b:	8b 55 f8             	mov    -0x8(%ebp),%edx
 28e:	8d 42 01             	lea    0x1(%edx),%eax
 291:	89 45 f8             	mov    %eax,-0x8(%ebp)
 294:	8b 45 fc             	mov    -0x4(%ebp),%eax
 297:	8d 48 01             	lea    0x1(%eax),%ecx
 29a:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 29d:	0f b6 12             	movzbl (%edx),%edx
 2a0:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 2a2:	8b 45 10             	mov    0x10(%ebp),%eax
 2a5:	8d 50 ff             	lea    -0x1(%eax),%edx
 2a8:	89 55 10             	mov    %edx,0x10(%ebp)
 2ab:	85 c0                	test   %eax,%eax
 2ad:	7f dc                	jg     28b <memmove+0x14>
  return vdst;
 2af:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2b2:	c9                   	leave  
 2b3:	c3                   	ret    

000002b4 <calc>:

int calc(int num)
{
 2b4:	55                   	push   %ebp
 2b5:	89 e5                	mov    %esp,%ebp
 2b7:	83 ec 10             	sub    $0x10,%esp
    int c = 0;
 2ba:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for(uint i = 0; i < num; i++)
 2c1:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
 2c8:	eb 36                	jmp    300 <calc+0x4c>
    {
        for(uint j = 0; j < num; j++)
 2ca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2d1:	eb 21                	jmp    2f4 <calc+0x40>
        {
            for(uint k = 0; k < num; j++)
 2d3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 2da:	eb 0c                	jmp    2e8 <calc+0x34>
            {
                c >>= 10;
 2dc:	c1 7d fc 0a          	sarl   $0xa,-0x4(%ebp)
                c <<= 10;
 2e0:	c1 65 fc 0a          	shll   $0xa,-0x4(%ebp)
            for(uint k = 0; k < num; j++)
 2e4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 2e8:	8b 45 08             	mov    0x8(%ebp),%eax
 2eb:	39 45 f0             	cmp    %eax,-0x10(%ebp)
 2ee:	72 ec                	jb     2dc <calc+0x28>
        for(uint j = 0; j < num; j++)
 2f0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 2f4:	8b 45 08             	mov    0x8(%ebp),%eax
 2f7:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 2fa:	72 d7                	jb     2d3 <calc+0x1f>
    for(uint i = 0; i < num; i++)
 2fc:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 300:	8b 45 08             	mov    0x8(%ebp),%eax
 303:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 306:	72 c2                	jb     2ca <calc+0x16>
            }
        }
    }
    return 0;
 308:	b8 00 00 00 00       	mov    $0x0,%eax
}
 30d:	c9                   	leave  
 30e:	c3                   	ret    

0000030f <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 30f:	b8 01 00 00 00       	mov    $0x1,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <exit>:
SYSCALL(exit)
 317:	b8 02 00 00 00       	mov    $0x2,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <wait>:
SYSCALL(wait)
 31f:	b8 03 00 00 00       	mov    $0x3,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <pipe>:
SYSCALL(pipe)
 327:	b8 04 00 00 00       	mov    $0x4,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <read>:
SYSCALL(read)
 32f:	b8 05 00 00 00       	mov    $0x5,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <write>:
SYSCALL(write)
 337:	b8 10 00 00 00       	mov    $0x10,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <close>:
SYSCALL(close)
 33f:	b8 15 00 00 00       	mov    $0x15,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    

00000347 <kill>:
SYSCALL(kill)
 347:	b8 06 00 00 00       	mov    $0x6,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    

0000034f <exec>:
SYSCALL(exec)
 34f:	b8 07 00 00 00       	mov    $0x7,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret    

00000357 <open>:
SYSCALL(open)
 357:	b8 0f 00 00 00       	mov    $0xf,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret    

0000035f <mknod>:
SYSCALL(mknod)
 35f:	b8 11 00 00 00       	mov    $0x11,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret    

00000367 <unlink>:
SYSCALL(unlink)
 367:	b8 12 00 00 00       	mov    $0x12,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret    

0000036f <fstat>:
SYSCALL(fstat)
 36f:	b8 08 00 00 00       	mov    $0x8,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret    

00000377 <link>:
SYSCALL(link)
 377:	b8 13 00 00 00       	mov    $0x13,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret    

0000037f <mkdir>:
SYSCALL(mkdir)
 37f:	b8 14 00 00 00       	mov    $0x14,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret    

00000387 <chdir>:
SYSCALL(chdir)
 387:	b8 09 00 00 00       	mov    $0x9,%eax
 38c:	cd 40                	int    $0x40
 38e:	c3                   	ret    

0000038f <dup>:
SYSCALL(dup)
 38f:	b8 0a 00 00 00       	mov    $0xa,%eax
 394:	cd 40                	int    $0x40
 396:	c3                   	ret    

00000397 <getpid>:
SYSCALL(getpid)
 397:	b8 0b 00 00 00       	mov    $0xb,%eax
 39c:	cd 40                	int    $0x40
 39e:	c3                   	ret    

0000039f <sbrk>:
SYSCALL(sbrk)
 39f:	b8 0c 00 00 00       	mov    $0xc,%eax
 3a4:	cd 40                	int    $0x40
 3a6:	c3                   	ret    

000003a7 <sleep>:
SYSCALL(sleep)
 3a7:	b8 0d 00 00 00       	mov    $0xd,%eax
 3ac:	cd 40                	int    $0x40
 3ae:	c3                   	ret    

000003af <uptime>:
SYSCALL(uptime)
 3af:	b8 0e 00 00 00       	mov    $0xe,%eax
 3b4:	cd 40                	int    $0x40
 3b6:	c3                   	ret    

000003b7 <print_proc>:
SYSCALL(print_proc)
 3b7:	b8 16 00 00 00       	mov    $0x16,%eax
 3bc:	cd 40                	int    $0x40
 3be:	c3                   	ret    

000003bf <change_queue>:
SYSCALL(change_queue)
 3bf:	b8 17 00 00 00       	mov    $0x17,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret    

000003c7 <change_local_bjf>:
SYSCALL(change_local_bjf)
 3c7:	b8 18 00 00 00       	mov    $0x18,%eax
 3cc:	cd 40                	int    $0x40
 3ce:	c3                   	ret    

000003cf <change_global_bjf>:
SYSCALL(change_global_bjf)
 3cf:	b8 19 00 00 00       	mov    $0x19,%eax
 3d4:	cd 40                	int    $0x40
 3d6:	c3                   	ret    

000003d7 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3d7:	55                   	push   %ebp
 3d8:	89 e5                	mov    %esp,%ebp
 3da:	83 ec 18             	sub    $0x18,%esp
 3dd:	8b 45 0c             	mov    0xc(%ebp),%eax
 3e0:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3e3:	83 ec 04             	sub    $0x4,%esp
 3e6:	6a 01                	push   $0x1
 3e8:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3eb:	50                   	push   %eax
 3ec:	ff 75 08             	push   0x8(%ebp)
 3ef:	e8 43 ff ff ff       	call   337 <write>
 3f4:	83 c4 10             	add    $0x10,%esp
}
 3f7:	90                   	nop
 3f8:	c9                   	leave  
 3f9:	c3                   	ret    

000003fa <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3fa:	55                   	push   %ebp
 3fb:	89 e5                	mov    %esp,%ebp
 3fd:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 400:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 407:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 40b:	74 17                	je     424 <printint+0x2a>
 40d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 411:	79 11                	jns    424 <printint+0x2a>
    neg = 1;
 413:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 41a:	8b 45 0c             	mov    0xc(%ebp),%eax
 41d:	f7 d8                	neg    %eax
 41f:	89 45 ec             	mov    %eax,-0x14(%ebp)
 422:	eb 06                	jmp    42a <printint+0x30>
  } else {
    x = xx;
 424:	8b 45 0c             	mov    0xc(%ebp),%eax
 427:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 42a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 431:	8b 4d 10             	mov    0x10(%ebp),%ecx
 434:	8b 45 ec             	mov    -0x14(%ebp),%eax
 437:	ba 00 00 00 00       	mov    $0x0,%edx
 43c:	f7 f1                	div    %ecx
 43e:	89 d1                	mov    %edx,%ecx
 440:	8b 45 f4             	mov    -0xc(%ebp),%eax
 443:	8d 50 01             	lea    0x1(%eax),%edx
 446:	89 55 f4             	mov    %edx,-0xc(%ebp)
 449:	0f b6 91 dc 0a 00 00 	movzbl 0xadc(%ecx),%edx
 450:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 454:	8b 4d 10             	mov    0x10(%ebp),%ecx
 457:	8b 45 ec             	mov    -0x14(%ebp),%eax
 45a:	ba 00 00 00 00       	mov    $0x0,%edx
 45f:	f7 f1                	div    %ecx
 461:	89 45 ec             	mov    %eax,-0x14(%ebp)
 464:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 468:	75 c7                	jne    431 <printint+0x37>
  if(neg)
 46a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 46e:	74 2d                	je     49d <printint+0xa3>
    buf[i++] = '-';
 470:	8b 45 f4             	mov    -0xc(%ebp),%eax
 473:	8d 50 01             	lea    0x1(%eax),%edx
 476:	89 55 f4             	mov    %edx,-0xc(%ebp)
 479:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 47e:	eb 1d                	jmp    49d <printint+0xa3>
    putc(fd, buf[i]);
 480:	8d 55 dc             	lea    -0x24(%ebp),%edx
 483:	8b 45 f4             	mov    -0xc(%ebp),%eax
 486:	01 d0                	add    %edx,%eax
 488:	0f b6 00             	movzbl (%eax),%eax
 48b:	0f be c0             	movsbl %al,%eax
 48e:	83 ec 08             	sub    $0x8,%esp
 491:	50                   	push   %eax
 492:	ff 75 08             	push   0x8(%ebp)
 495:	e8 3d ff ff ff       	call   3d7 <putc>
 49a:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 49d:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4a5:	79 d9                	jns    480 <printint+0x86>
}
 4a7:	90                   	nop
 4a8:	90                   	nop
 4a9:	c9                   	leave  
 4aa:	c3                   	ret    

000004ab <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4ab:	55                   	push   %ebp
 4ac:	89 e5                	mov    %esp,%ebp
 4ae:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4b1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4b8:	8d 45 0c             	lea    0xc(%ebp),%eax
 4bb:	83 c0 04             	add    $0x4,%eax
 4be:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4c1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4c8:	e9 59 01 00 00       	jmp    626 <printf+0x17b>
    c = fmt[i] & 0xff;
 4cd:	8b 55 0c             	mov    0xc(%ebp),%edx
 4d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4d3:	01 d0                	add    %edx,%eax
 4d5:	0f b6 00             	movzbl (%eax),%eax
 4d8:	0f be c0             	movsbl %al,%eax
 4db:	25 ff 00 00 00       	and    $0xff,%eax
 4e0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4e3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4e7:	75 2c                	jne    515 <printf+0x6a>
      if(c == '%'){
 4e9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4ed:	75 0c                	jne    4fb <printf+0x50>
        state = '%';
 4ef:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4f6:	e9 27 01 00 00       	jmp    622 <printf+0x177>
      } else {
        putc(fd, c);
 4fb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4fe:	0f be c0             	movsbl %al,%eax
 501:	83 ec 08             	sub    $0x8,%esp
 504:	50                   	push   %eax
 505:	ff 75 08             	push   0x8(%ebp)
 508:	e8 ca fe ff ff       	call   3d7 <putc>
 50d:	83 c4 10             	add    $0x10,%esp
 510:	e9 0d 01 00 00       	jmp    622 <printf+0x177>
      }
    } else if(state == '%'){
 515:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 519:	0f 85 03 01 00 00    	jne    622 <printf+0x177>
      if(c == 'd'){
 51f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 523:	75 1e                	jne    543 <printf+0x98>
        printint(fd, *ap, 10, 1);
 525:	8b 45 e8             	mov    -0x18(%ebp),%eax
 528:	8b 00                	mov    (%eax),%eax
 52a:	6a 01                	push   $0x1
 52c:	6a 0a                	push   $0xa
 52e:	50                   	push   %eax
 52f:	ff 75 08             	push   0x8(%ebp)
 532:	e8 c3 fe ff ff       	call   3fa <printint>
 537:	83 c4 10             	add    $0x10,%esp
        ap++;
 53a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 53e:	e9 d8 00 00 00       	jmp    61b <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 543:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 547:	74 06                	je     54f <printf+0xa4>
 549:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 54d:	75 1e                	jne    56d <printf+0xc2>
        printint(fd, *ap, 16, 0);
 54f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 552:	8b 00                	mov    (%eax),%eax
 554:	6a 00                	push   $0x0
 556:	6a 10                	push   $0x10
 558:	50                   	push   %eax
 559:	ff 75 08             	push   0x8(%ebp)
 55c:	e8 99 fe ff ff       	call   3fa <printint>
 561:	83 c4 10             	add    $0x10,%esp
        ap++;
 564:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 568:	e9 ae 00 00 00       	jmp    61b <printf+0x170>
      } else if(c == 's'){
 56d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 571:	75 43                	jne    5b6 <printf+0x10b>
        s = (char*)*ap;
 573:	8b 45 e8             	mov    -0x18(%ebp),%eax
 576:	8b 00                	mov    (%eax),%eax
 578:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 57b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 57f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 583:	75 25                	jne    5aa <printf+0xff>
          s = "(null)";
 585:	c7 45 f4 6b 08 00 00 	movl   $0x86b,-0xc(%ebp)
        while(*s != 0){
 58c:	eb 1c                	jmp    5aa <printf+0xff>
          putc(fd, *s);
 58e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 591:	0f b6 00             	movzbl (%eax),%eax
 594:	0f be c0             	movsbl %al,%eax
 597:	83 ec 08             	sub    $0x8,%esp
 59a:	50                   	push   %eax
 59b:	ff 75 08             	push   0x8(%ebp)
 59e:	e8 34 fe ff ff       	call   3d7 <putc>
 5a3:	83 c4 10             	add    $0x10,%esp
          s++;
 5a6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 5aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5ad:	0f b6 00             	movzbl (%eax),%eax
 5b0:	84 c0                	test   %al,%al
 5b2:	75 da                	jne    58e <printf+0xe3>
 5b4:	eb 65                	jmp    61b <printf+0x170>
        }
      } else if(c == 'c'){
 5b6:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5ba:	75 1d                	jne    5d9 <printf+0x12e>
        putc(fd, *ap);
 5bc:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5bf:	8b 00                	mov    (%eax),%eax
 5c1:	0f be c0             	movsbl %al,%eax
 5c4:	83 ec 08             	sub    $0x8,%esp
 5c7:	50                   	push   %eax
 5c8:	ff 75 08             	push   0x8(%ebp)
 5cb:	e8 07 fe ff ff       	call   3d7 <putc>
 5d0:	83 c4 10             	add    $0x10,%esp
        ap++;
 5d3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5d7:	eb 42                	jmp    61b <printf+0x170>
      } else if(c == '%'){
 5d9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5dd:	75 17                	jne    5f6 <printf+0x14b>
        putc(fd, c);
 5df:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5e2:	0f be c0             	movsbl %al,%eax
 5e5:	83 ec 08             	sub    $0x8,%esp
 5e8:	50                   	push   %eax
 5e9:	ff 75 08             	push   0x8(%ebp)
 5ec:	e8 e6 fd ff ff       	call   3d7 <putc>
 5f1:	83 c4 10             	add    $0x10,%esp
 5f4:	eb 25                	jmp    61b <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5f6:	83 ec 08             	sub    $0x8,%esp
 5f9:	6a 25                	push   $0x25
 5fb:	ff 75 08             	push   0x8(%ebp)
 5fe:	e8 d4 fd ff ff       	call   3d7 <putc>
 603:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 606:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 609:	0f be c0             	movsbl %al,%eax
 60c:	83 ec 08             	sub    $0x8,%esp
 60f:	50                   	push   %eax
 610:	ff 75 08             	push   0x8(%ebp)
 613:	e8 bf fd ff ff       	call   3d7 <putc>
 618:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 61b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 622:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 626:	8b 55 0c             	mov    0xc(%ebp),%edx
 629:	8b 45 f0             	mov    -0x10(%ebp),%eax
 62c:	01 d0                	add    %edx,%eax
 62e:	0f b6 00             	movzbl (%eax),%eax
 631:	84 c0                	test   %al,%al
 633:	0f 85 94 fe ff ff    	jne    4cd <printf+0x22>
    }
  }
}
 639:	90                   	nop
 63a:	90                   	nop
 63b:	c9                   	leave  
 63c:	c3                   	ret    

0000063d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 63d:	55                   	push   %ebp
 63e:	89 e5                	mov    %esp,%ebp
 640:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 643:	8b 45 08             	mov    0x8(%ebp),%eax
 646:	83 e8 08             	sub    $0x8,%eax
 649:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 64c:	a1 f8 0a 00 00       	mov    0xaf8,%eax
 651:	89 45 fc             	mov    %eax,-0x4(%ebp)
 654:	eb 24                	jmp    67a <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 656:	8b 45 fc             	mov    -0x4(%ebp),%eax
 659:	8b 00                	mov    (%eax),%eax
 65b:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 65e:	72 12                	jb     672 <free+0x35>
 660:	8b 45 f8             	mov    -0x8(%ebp),%eax
 663:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 666:	77 24                	ja     68c <free+0x4f>
 668:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66b:	8b 00                	mov    (%eax),%eax
 66d:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 670:	72 1a                	jb     68c <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 672:	8b 45 fc             	mov    -0x4(%ebp),%eax
 675:	8b 00                	mov    (%eax),%eax
 677:	89 45 fc             	mov    %eax,-0x4(%ebp)
 67a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 680:	76 d4                	jbe    656 <free+0x19>
 682:	8b 45 fc             	mov    -0x4(%ebp),%eax
 685:	8b 00                	mov    (%eax),%eax
 687:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 68a:	73 ca                	jae    656 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 68c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68f:	8b 40 04             	mov    0x4(%eax),%eax
 692:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 699:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69c:	01 c2                	add    %eax,%edx
 69e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a1:	8b 00                	mov    (%eax),%eax
 6a3:	39 c2                	cmp    %eax,%edx
 6a5:	75 24                	jne    6cb <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6aa:	8b 50 04             	mov    0x4(%eax),%edx
 6ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b0:	8b 00                	mov    (%eax),%eax
 6b2:	8b 40 04             	mov    0x4(%eax),%eax
 6b5:	01 c2                	add    %eax,%edx
 6b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ba:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6bd:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c0:	8b 00                	mov    (%eax),%eax
 6c2:	8b 10                	mov    (%eax),%edx
 6c4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c7:	89 10                	mov    %edx,(%eax)
 6c9:	eb 0a                	jmp    6d5 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ce:	8b 10                	mov    (%eax),%edx
 6d0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d3:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d8:	8b 40 04             	mov    0x4(%eax),%eax
 6db:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e5:	01 d0                	add    %edx,%eax
 6e7:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 6ea:	75 20                	jne    70c <free+0xcf>
    p->s.size += bp->s.size;
 6ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ef:	8b 50 04             	mov    0x4(%eax),%edx
 6f2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f5:	8b 40 04             	mov    0x4(%eax),%eax
 6f8:	01 c2                	add    %eax,%edx
 6fa:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fd:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 700:	8b 45 f8             	mov    -0x8(%ebp),%eax
 703:	8b 10                	mov    (%eax),%edx
 705:	8b 45 fc             	mov    -0x4(%ebp),%eax
 708:	89 10                	mov    %edx,(%eax)
 70a:	eb 08                	jmp    714 <free+0xd7>
  } else
    p->s.ptr = bp;
 70c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70f:	8b 55 f8             	mov    -0x8(%ebp),%edx
 712:	89 10                	mov    %edx,(%eax)
  freep = p;
 714:	8b 45 fc             	mov    -0x4(%ebp),%eax
 717:	a3 f8 0a 00 00       	mov    %eax,0xaf8
}
 71c:	90                   	nop
 71d:	c9                   	leave  
 71e:	c3                   	ret    

0000071f <morecore>:

static Header*
morecore(uint nu)
{
 71f:	55                   	push   %ebp
 720:	89 e5                	mov    %esp,%ebp
 722:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 725:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 72c:	77 07                	ja     735 <morecore+0x16>
    nu = 4096;
 72e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 735:	8b 45 08             	mov    0x8(%ebp),%eax
 738:	c1 e0 03             	shl    $0x3,%eax
 73b:	83 ec 0c             	sub    $0xc,%esp
 73e:	50                   	push   %eax
 73f:	e8 5b fc ff ff       	call   39f <sbrk>
 744:	83 c4 10             	add    $0x10,%esp
 747:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 74a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 74e:	75 07                	jne    757 <morecore+0x38>
    return 0;
 750:	b8 00 00 00 00       	mov    $0x0,%eax
 755:	eb 26                	jmp    77d <morecore+0x5e>
  hp = (Header*)p;
 757:	8b 45 f4             	mov    -0xc(%ebp),%eax
 75a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 75d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 760:	8b 55 08             	mov    0x8(%ebp),%edx
 763:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 766:	8b 45 f0             	mov    -0x10(%ebp),%eax
 769:	83 c0 08             	add    $0x8,%eax
 76c:	83 ec 0c             	sub    $0xc,%esp
 76f:	50                   	push   %eax
 770:	e8 c8 fe ff ff       	call   63d <free>
 775:	83 c4 10             	add    $0x10,%esp
  return freep;
 778:	a1 f8 0a 00 00       	mov    0xaf8,%eax
}
 77d:	c9                   	leave  
 77e:	c3                   	ret    

0000077f <malloc>:

void*
malloc(uint nbytes)
{
 77f:	55                   	push   %ebp
 780:	89 e5                	mov    %esp,%ebp
 782:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 785:	8b 45 08             	mov    0x8(%ebp),%eax
 788:	83 c0 07             	add    $0x7,%eax
 78b:	c1 e8 03             	shr    $0x3,%eax
 78e:	83 c0 01             	add    $0x1,%eax
 791:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 794:	a1 f8 0a 00 00       	mov    0xaf8,%eax
 799:	89 45 f0             	mov    %eax,-0x10(%ebp)
 79c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7a0:	75 23                	jne    7c5 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7a2:	c7 45 f0 f0 0a 00 00 	movl   $0xaf0,-0x10(%ebp)
 7a9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ac:	a3 f8 0a 00 00       	mov    %eax,0xaf8
 7b1:	a1 f8 0a 00 00       	mov    0xaf8,%eax
 7b6:	a3 f0 0a 00 00       	mov    %eax,0xaf0
    base.s.size = 0;
 7bb:	c7 05 f4 0a 00 00 00 	movl   $0x0,0xaf4
 7c2:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c8:	8b 00                	mov    (%eax),%eax
 7ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d0:	8b 40 04             	mov    0x4(%eax),%eax
 7d3:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7d6:	77 4d                	ja     825 <malloc+0xa6>
      if(p->s.size == nunits)
 7d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7db:	8b 40 04             	mov    0x4(%eax),%eax
 7de:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7e1:	75 0c                	jne    7ef <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e6:	8b 10                	mov    (%eax),%edx
 7e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7eb:	89 10                	mov    %edx,(%eax)
 7ed:	eb 26                	jmp    815 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f2:	8b 40 04             	mov    0x4(%eax),%eax
 7f5:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7f8:	89 c2                	mov    %eax,%edx
 7fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fd:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 800:	8b 45 f4             	mov    -0xc(%ebp),%eax
 803:	8b 40 04             	mov    0x4(%eax),%eax
 806:	c1 e0 03             	shl    $0x3,%eax
 809:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 80c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80f:	8b 55 ec             	mov    -0x14(%ebp),%edx
 812:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 815:	8b 45 f0             	mov    -0x10(%ebp),%eax
 818:	a3 f8 0a 00 00       	mov    %eax,0xaf8
      return (void*)(p + 1);
 81d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 820:	83 c0 08             	add    $0x8,%eax
 823:	eb 3b                	jmp    860 <malloc+0xe1>
    }
    if(p == freep)
 825:	a1 f8 0a 00 00       	mov    0xaf8,%eax
 82a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 82d:	75 1e                	jne    84d <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 82f:	83 ec 0c             	sub    $0xc,%esp
 832:	ff 75 ec             	push   -0x14(%ebp)
 835:	e8 e5 fe ff ff       	call   71f <morecore>
 83a:	83 c4 10             	add    $0x10,%esp
 83d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 840:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 844:	75 07                	jne    84d <malloc+0xce>
        return 0;
 846:	b8 00 00 00 00       	mov    $0x0,%eax
 84b:	eb 13                	jmp    860 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 84d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 850:	89 45 f0             	mov    %eax,-0x10(%ebp)
 853:	8b 45 f4             	mov    -0xc(%ebp),%eax
 856:	8b 00                	mov    (%eax),%eax
 858:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 85b:	e9 6d ff ff ff       	jmp    7cd <malloc+0x4e>
  }
}
 860:	c9                   	leave  
 861:	c3                   	ret    
