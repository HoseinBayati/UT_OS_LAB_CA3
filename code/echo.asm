
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
  27:	ba 52 08 00 00       	mov    $0x852,%edx
  2c:	eb 05                	jmp    33 <main+0x33>
  2e:	ba 54 08 00 00       	mov    $0x854,%edx
  33:	8b 45 f4             	mov    -0xc(%ebp),%eax
  36:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
  3d:	8b 43 04             	mov    0x4(%ebx),%eax
  40:	01 c8                	add    %ecx,%eax
  42:	8b 00                	mov    (%eax),%eax
  44:	52                   	push   %edx
  45:	50                   	push   %eax
  46:	68 56 08 00 00       	push   $0x856
  4b:	6a 01                	push   $0x1
  4d:	e8 49 04 00 00       	call   49b <printf>
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
 3bf:	b8 17 00 00 00       	mov    $0x17,%eax
 3c4:	cd 40                	int    $0x40
 3c6:	c3                   	ret    

000003c7 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3c7:	55                   	push   %ebp
 3c8:	89 e5                	mov    %esp,%ebp
 3ca:	83 ec 18             	sub    $0x18,%esp
 3cd:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d0:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3d3:	83 ec 04             	sub    $0x4,%esp
 3d6:	6a 01                	push   $0x1
 3d8:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3db:	50                   	push   %eax
 3dc:	ff 75 08             	push   0x8(%ebp)
 3df:	e8 53 ff ff ff       	call   337 <write>
 3e4:	83 c4 10             	add    $0x10,%esp
}
 3e7:	90                   	nop
 3e8:	c9                   	leave  
 3e9:	c3                   	ret    

000003ea <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3ea:	55                   	push   %ebp
 3eb:	89 e5                	mov    %esp,%ebp
 3ed:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3f0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3f7:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3fb:	74 17                	je     414 <printint+0x2a>
 3fd:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 401:	79 11                	jns    414 <printint+0x2a>
    neg = 1;
 403:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 40a:	8b 45 0c             	mov    0xc(%ebp),%eax
 40d:	f7 d8                	neg    %eax
 40f:	89 45 ec             	mov    %eax,-0x14(%ebp)
 412:	eb 06                	jmp    41a <printint+0x30>
  } else {
    x = xx;
 414:	8b 45 0c             	mov    0xc(%ebp),%eax
 417:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 41a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 421:	8b 4d 10             	mov    0x10(%ebp),%ecx
 424:	8b 45 ec             	mov    -0x14(%ebp),%eax
 427:	ba 00 00 00 00       	mov    $0x0,%edx
 42c:	f7 f1                	div    %ecx
 42e:	89 d1                	mov    %edx,%ecx
 430:	8b 45 f4             	mov    -0xc(%ebp),%eax
 433:	8d 50 01             	lea    0x1(%eax),%edx
 436:	89 55 f4             	mov    %edx,-0xc(%ebp)
 439:	0f b6 91 cc 0a 00 00 	movzbl 0xacc(%ecx),%edx
 440:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 444:	8b 4d 10             	mov    0x10(%ebp),%ecx
 447:	8b 45 ec             	mov    -0x14(%ebp),%eax
 44a:	ba 00 00 00 00       	mov    $0x0,%edx
 44f:	f7 f1                	div    %ecx
 451:	89 45 ec             	mov    %eax,-0x14(%ebp)
 454:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 458:	75 c7                	jne    421 <printint+0x37>
  if(neg)
 45a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 45e:	74 2d                	je     48d <printint+0xa3>
    buf[i++] = '-';
 460:	8b 45 f4             	mov    -0xc(%ebp),%eax
 463:	8d 50 01             	lea    0x1(%eax),%edx
 466:	89 55 f4             	mov    %edx,-0xc(%ebp)
 469:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 46e:	eb 1d                	jmp    48d <printint+0xa3>
    putc(fd, buf[i]);
 470:	8d 55 dc             	lea    -0x24(%ebp),%edx
 473:	8b 45 f4             	mov    -0xc(%ebp),%eax
 476:	01 d0                	add    %edx,%eax
 478:	0f b6 00             	movzbl (%eax),%eax
 47b:	0f be c0             	movsbl %al,%eax
 47e:	83 ec 08             	sub    $0x8,%esp
 481:	50                   	push   %eax
 482:	ff 75 08             	push   0x8(%ebp)
 485:	e8 3d ff ff ff       	call   3c7 <putc>
 48a:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 48d:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 491:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 495:	79 d9                	jns    470 <printint+0x86>
}
 497:	90                   	nop
 498:	90                   	nop
 499:	c9                   	leave  
 49a:	c3                   	ret    

0000049b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 49b:	55                   	push   %ebp
 49c:	89 e5                	mov    %esp,%ebp
 49e:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4a1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4a8:	8d 45 0c             	lea    0xc(%ebp),%eax
 4ab:	83 c0 04             	add    $0x4,%eax
 4ae:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4b1:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4b8:	e9 59 01 00 00       	jmp    616 <printf+0x17b>
    c = fmt[i] & 0xff;
 4bd:	8b 55 0c             	mov    0xc(%ebp),%edx
 4c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4c3:	01 d0                	add    %edx,%eax
 4c5:	0f b6 00             	movzbl (%eax),%eax
 4c8:	0f be c0             	movsbl %al,%eax
 4cb:	25 ff 00 00 00       	and    $0xff,%eax
 4d0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4d3:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4d7:	75 2c                	jne    505 <printf+0x6a>
      if(c == '%'){
 4d9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4dd:	75 0c                	jne    4eb <printf+0x50>
        state = '%';
 4df:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4e6:	e9 27 01 00 00       	jmp    612 <printf+0x177>
      } else {
        putc(fd, c);
 4eb:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4ee:	0f be c0             	movsbl %al,%eax
 4f1:	83 ec 08             	sub    $0x8,%esp
 4f4:	50                   	push   %eax
 4f5:	ff 75 08             	push   0x8(%ebp)
 4f8:	e8 ca fe ff ff       	call   3c7 <putc>
 4fd:	83 c4 10             	add    $0x10,%esp
 500:	e9 0d 01 00 00       	jmp    612 <printf+0x177>
      }
    } else if(state == '%'){
 505:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 509:	0f 85 03 01 00 00    	jne    612 <printf+0x177>
      if(c == 'd'){
 50f:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 513:	75 1e                	jne    533 <printf+0x98>
        printint(fd, *ap, 10, 1);
 515:	8b 45 e8             	mov    -0x18(%ebp),%eax
 518:	8b 00                	mov    (%eax),%eax
 51a:	6a 01                	push   $0x1
 51c:	6a 0a                	push   $0xa
 51e:	50                   	push   %eax
 51f:	ff 75 08             	push   0x8(%ebp)
 522:	e8 c3 fe ff ff       	call   3ea <printint>
 527:	83 c4 10             	add    $0x10,%esp
        ap++;
 52a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 52e:	e9 d8 00 00 00       	jmp    60b <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 533:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 537:	74 06                	je     53f <printf+0xa4>
 539:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 53d:	75 1e                	jne    55d <printf+0xc2>
        printint(fd, *ap, 16, 0);
 53f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 542:	8b 00                	mov    (%eax),%eax
 544:	6a 00                	push   $0x0
 546:	6a 10                	push   $0x10
 548:	50                   	push   %eax
 549:	ff 75 08             	push   0x8(%ebp)
 54c:	e8 99 fe ff ff       	call   3ea <printint>
 551:	83 c4 10             	add    $0x10,%esp
        ap++;
 554:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 558:	e9 ae 00 00 00       	jmp    60b <printf+0x170>
      } else if(c == 's'){
 55d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 561:	75 43                	jne    5a6 <printf+0x10b>
        s = (char*)*ap;
 563:	8b 45 e8             	mov    -0x18(%ebp),%eax
 566:	8b 00                	mov    (%eax),%eax
 568:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 56b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 56f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 573:	75 25                	jne    59a <printf+0xff>
          s = "(null)";
 575:	c7 45 f4 5b 08 00 00 	movl   $0x85b,-0xc(%ebp)
        while(*s != 0){
 57c:	eb 1c                	jmp    59a <printf+0xff>
          putc(fd, *s);
 57e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 581:	0f b6 00             	movzbl (%eax),%eax
 584:	0f be c0             	movsbl %al,%eax
 587:	83 ec 08             	sub    $0x8,%esp
 58a:	50                   	push   %eax
 58b:	ff 75 08             	push   0x8(%ebp)
 58e:	e8 34 fe ff ff       	call   3c7 <putc>
 593:	83 c4 10             	add    $0x10,%esp
          s++;
 596:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 59a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 59d:	0f b6 00             	movzbl (%eax),%eax
 5a0:	84 c0                	test   %al,%al
 5a2:	75 da                	jne    57e <printf+0xe3>
 5a4:	eb 65                	jmp    60b <printf+0x170>
        }
      } else if(c == 'c'){
 5a6:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5aa:	75 1d                	jne    5c9 <printf+0x12e>
        putc(fd, *ap);
 5ac:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5af:	8b 00                	mov    (%eax),%eax
 5b1:	0f be c0             	movsbl %al,%eax
 5b4:	83 ec 08             	sub    $0x8,%esp
 5b7:	50                   	push   %eax
 5b8:	ff 75 08             	push   0x8(%ebp)
 5bb:	e8 07 fe ff ff       	call   3c7 <putc>
 5c0:	83 c4 10             	add    $0x10,%esp
        ap++;
 5c3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5c7:	eb 42                	jmp    60b <printf+0x170>
      } else if(c == '%'){
 5c9:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5cd:	75 17                	jne    5e6 <printf+0x14b>
        putc(fd, c);
 5cf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5d2:	0f be c0             	movsbl %al,%eax
 5d5:	83 ec 08             	sub    $0x8,%esp
 5d8:	50                   	push   %eax
 5d9:	ff 75 08             	push   0x8(%ebp)
 5dc:	e8 e6 fd ff ff       	call   3c7 <putc>
 5e1:	83 c4 10             	add    $0x10,%esp
 5e4:	eb 25                	jmp    60b <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5e6:	83 ec 08             	sub    $0x8,%esp
 5e9:	6a 25                	push   $0x25
 5eb:	ff 75 08             	push   0x8(%ebp)
 5ee:	e8 d4 fd ff ff       	call   3c7 <putc>
 5f3:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5f6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5f9:	0f be c0             	movsbl %al,%eax
 5fc:	83 ec 08             	sub    $0x8,%esp
 5ff:	50                   	push   %eax
 600:	ff 75 08             	push   0x8(%ebp)
 603:	e8 bf fd ff ff       	call   3c7 <putc>
 608:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 60b:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 612:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 616:	8b 55 0c             	mov    0xc(%ebp),%edx
 619:	8b 45 f0             	mov    -0x10(%ebp),%eax
 61c:	01 d0                	add    %edx,%eax
 61e:	0f b6 00             	movzbl (%eax),%eax
 621:	84 c0                	test   %al,%al
 623:	0f 85 94 fe ff ff    	jne    4bd <printf+0x22>
    }
  }
}
 629:	90                   	nop
 62a:	90                   	nop
 62b:	c9                   	leave  
 62c:	c3                   	ret    

0000062d <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 62d:	55                   	push   %ebp
 62e:	89 e5                	mov    %esp,%ebp
 630:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 633:	8b 45 08             	mov    0x8(%ebp),%eax
 636:	83 e8 08             	sub    $0x8,%eax
 639:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 63c:	a1 e8 0a 00 00       	mov    0xae8,%eax
 641:	89 45 fc             	mov    %eax,-0x4(%ebp)
 644:	eb 24                	jmp    66a <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 646:	8b 45 fc             	mov    -0x4(%ebp),%eax
 649:	8b 00                	mov    (%eax),%eax
 64b:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 64e:	72 12                	jb     662 <free+0x35>
 650:	8b 45 f8             	mov    -0x8(%ebp),%eax
 653:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 656:	77 24                	ja     67c <free+0x4f>
 658:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65b:	8b 00                	mov    (%eax),%eax
 65d:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 660:	72 1a                	jb     67c <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 662:	8b 45 fc             	mov    -0x4(%ebp),%eax
 665:	8b 00                	mov    (%eax),%eax
 667:	89 45 fc             	mov    %eax,-0x4(%ebp)
 66a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 66d:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 670:	76 d4                	jbe    646 <free+0x19>
 672:	8b 45 fc             	mov    -0x4(%ebp),%eax
 675:	8b 00                	mov    (%eax),%eax
 677:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 67a:	73 ca                	jae    646 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 67c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67f:	8b 40 04             	mov    0x4(%eax),%eax
 682:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 689:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68c:	01 c2                	add    %eax,%edx
 68e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 691:	8b 00                	mov    (%eax),%eax
 693:	39 c2                	cmp    %eax,%edx
 695:	75 24                	jne    6bb <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 697:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69a:	8b 50 04             	mov    0x4(%eax),%edx
 69d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a0:	8b 00                	mov    (%eax),%eax
 6a2:	8b 40 04             	mov    0x4(%eax),%eax
 6a5:	01 c2                	add    %eax,%edx
 6a7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6aa:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b0:	8b 00                	mov    (%eax),%eax
 6b2:	8b 10                	mov    (%eax),%edx
 6b4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b7:	89 10                	mov    %edx,(%eax)
 6b9:	eb 0a                	jmp    6c5 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6bb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6be:	8b 10                	mov    (%eax),%edx
 6c0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c3:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c8:	8b 40 04             	mov    0x4(%eax),%eax
 6cb:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d5:	01 d0                	add    %edx,%eax
 6d7:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 6da:	75 20                	jne    6fc <free+0xcf>
    p->s.size += bp->s.size;
 6dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6df:	8b 50 04             	mov    0x4(%eax),%edx
 6e2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e5:	8b 40 04             	mov    0x4(%eax),%eax
 6e8:	01 c2                	add    %eax,%edx
 6ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ed:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6f0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f3:	8b 10                	mov    (%eax),%edx
 6f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f8:	89 10                	mov    %edx,(%eax)
 6fa:	eb 08                	jmp    704 <free+0xd7>
  } else
    p->s.ptr = bp;
 6fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ff:	8b 55 f8             	mov    -0x8(%ebp),%edx
 702:	89 10                	mov    %edx,(%eax)
  freep = p;
 704:	8b 45 fc             	mov    -0x4(%ebp),%eax
 707:	a3 e8 0a 00 00       	mov    %eax,0xae8
}
 70c:	90                   	nop
 70d:	c9                   	leave  
 70e:	c3                   	ret    

0000070f <morecore>:

static Header*
morecore(uint nu)
{
 70f:	55                   	push   %ebp
 710:	89 e5                	mov    %esp,%ebp
 712:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 715:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 71c:	77 07                	ja     725 <morecore+0x16>
    nu = 4096;
 71e:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 725:	8b 45 08             	mov    0x8(%ebp),%eax
 728:	c1 e0 03             	shl    $0x3,%eax
 72b:	83 ec 0c             	sub    $0xc,%esp
 72e:	50                   	push   %eax
 72f:	e8 6b fc ff ff       	call   39f <sbrk>
 734:	83 c4 10             	add    $0x10,%esp
 737:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 73a:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 73e:	75 07                	jne    747 <morecore+0x38>
    return 0;
 740:	b8 00 00 00 00       	mov    $0x0,%eax
 745:	eb 26                	jmp    76d <morecore+0x5e>
  hp = (Header*)p;
 747:	8b 45 f4             	mov    -0xc(%ebp),%eax
 74a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 74d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 750:	8b 55 08             	mov    0x8(%ebp),%edx
 753:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 756:	8b 45 f0             	mov    -0x10(%ebp),%eax
 759:	83 c0 08             	add    $0x8,%eax
 75c:	83 ec 0c             	sub    $0xc,%esp
 75f:	50                   	push   %eax
 760:	e8 c8 fe ff ff       	call   62d <free>
 765:	83 c4 10             	add    $0x10,%esp
  return freep;
 768:	a1 e8 0a 00 00       	mov    0xae8,%eax
}
 76d:	c9                   	leave  
 76e:	c3                   	ret    

0000076f <malloc>:

void*
malloc(uint nbytes)
{
 76f:	55                   	push   %ebp
 770:	89 e5                	mov    %esp,%ebp
 772:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 775:	8b 45 08             	mov    0x8(%ebp),%eax
 778:	83 c0 07             	add    $0x7,%eax
 77b:	c1 e8 03             	shr    $0x3,%eax
 77e:	83 c0 01             	add    $0x1,%eax
 781:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 784:	a1 e8 0a 00 00       	mov    0xae8,%eax
 789:	89 45 f0             	mov    %eax,-0x10(%ebp)
 78c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 790:	75 23                	jne    7b5 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 792:	c7 45 f0 e0 0a 00 00 	movl   $0xae0,-0x10(%ebp)
 799:	8b 45 f0             	mov    -0x10(%ebp),%eax
 79c:	a3 e8 0a 00 00       	mov    %eax,0xae8
 7a1:	a1 e8 0a 00 00       	mov    0xae8,%eax
 7a6:	a3 e0 0a 00 00       	mov    %eax,0xae0
    base.s.size = 0;
 7ab:	c7 05 e4 0a 00 00 00 	movl   $0x0,0xae4
 7b2:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b8:	8b 00                	mov    (%eax),%eax
 7ba:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c0:	8b 40 04             	mov    0x4(%eax),%eax
 7c3:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7c6:	77 4d                	ja     815 <malloc+0xa6>
      if(p->s.size == nunits)
 7c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7cb:	8b 40 04             	mov    0x4(%eax),%eax
 7ce:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7d1:	75 0c                	jne    7df <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d6:	8b 10                	mov    (%eax),%edx
 7d8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7db:	89 10                	mov    %edx,(%eax)
 7dd:	eb 26                	jmp    805 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7df:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e2:	8b 40 04             	mov    0x4(%eax),%eax
 7e5:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7e8:	89 c2                	mov    %eax,%edx
 7ea:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ed:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f3:	8b 40 04             	mov    0x4(%eax),%eax
 7f6:	c1 e0 03             	shl    $0x3,%eax
 7f9:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ff:	8b 55 ec             	mov    -0x14(%ebp),%edx
 802:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 805:	8b 45 f0             	mov    -0x10(%ebp),%eax
 808:	a3 e8 0a 00 00       	mov    %eax,0xae8
      return (void*)(p + 1);
 80d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 810:	83 c0 08             	add    $0x8,%eax
 813:	eb 3b                	jmp    850 <malloc+0xe1>
    }
    if(p == freep)
 815:	a1 e8 0a 00 00       	mov    0xae8,%eax
 81a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 81d:	75 1e                	jne    83d <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 81f:	83 ec 0c             	sub    $0xc,%esp
 822:	ff 75 ec             	push   -0x14(%ebp)
 825:	e8 e5 fe ff ff       	call   70f <morecore>
 82a:	83 c4 10             	add    $0x10,%esp
 82d:	89 45 f4             	mov    %eax,-0xc(%ebp)
 830:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 834:	75 07                	jne    83d <malloc+0xce>
        return 0;
 836:	b8 00 00 00 00       	mov    $0x0,%eax
 83b:	eb 13                	jmp    850 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 83d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 840:	89 45 f0             	mov    %eax,-0x10(%ebp)
 843:	8b 45 f4             	mov    -0xc(%ebp),%eax
 846:	8b 00                	mov    (%eax),%eax
 848:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 84b:	e9 6d ff ff ff       	jmp    7bd <malloc+0x4e>
  }
}
 850:	c9                   	leave  
 851:	c3                   	ret    
