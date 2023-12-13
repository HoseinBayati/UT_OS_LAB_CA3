
_ln:     file format elf32-i386


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
   f:	89 cb                	mov    %ecx,%ebx
  if(argc != 3){
  11:	83 3b 03             	cmpl   $0x3,(%ebx)
  14:	74 17                	je     2d <main+0x2d>
    printf(2, "Usage: ln old new\n");
  16:	83 ec 08             	sub    $0x8,%esp
  19:	68 71 08 00 00       	push   $0x871
  1e:	6a 02                	push   $0x2
  20:	e8 95 04 00 00       	call   4ba <printf>
  25:	83 c4 10             	add    $0x10,%esp
    exit();
  28:	e8 f9 02 00 00       	call   326 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  2d:	8b 43 04             	mov    0x4(%ebx),%eax
  30:	83 c0 08             	add    $0x8,%eax
  33:	8b 10                	mov    (%eax),%edx
  35:	8b 43 04             	mov    0x4(%ebx),%eax
  38:	83 c0 04             	add    $0x4,%eax
  3b:	8b 00                	mov    (%eax),%eax
  3d:	83 ec 08             	sub    $0x8,%esp
  40:	52                   	push   %edx
  41:	50                   	push   %eax
  42:	e8 3f 03 00 00       	call   386 <link>
  47:	83 c4 10             	add    $0x10,%esp
  4a:	85 c0                	test   %eax,%eax
  4c:	79 21                	jns    6f <main+0x6f>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  4e:	8b 43 04             	mov    0x4(%ebx),%eax
  51:	83 c0 08             	add    $0x8,%eax
  54:	8b 10                	mov    (%eax),%edx
  56:	8b 43 04             	mov    0x4(%ebx),%eax
  59:	83 c0 04             	add    $0x4,%eax
  5c:	8b 00                	mov    (%eax),%eax
  5e:	52                   	push   %edx
  5f:	50                   	push   %eax
  60:	68 84 08 00 00       	push   $0x884
  65:	6a 02                	push   $0x2
  67:	e8 4e 04 00 00       	call   4ba <printf>
  6c:	83 c4 10             	add    $0x10,%esp
  exit();
  6f:	e8 b2 02 00 00       	call   326 <exit>

00000074 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  74:	55                   	push   %ebp
  75:	89 e5                	mov    %esp,%ebp
  77:	57                   	push   %edi
  78:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  79:	8b 4d 08             	mov    0x8(%ebp),%ecx
  7c:	8b 55 10             	mov    0x10(%ebp),%edx
  7f:	8b 45 0c             	mov    0xc(%ebp),%eax
  82:	89 cb                	mov    %ecx,%ebx
  84:	89 df                	mov    %ebx,%edi
  86:	89 d1                	mov    %edx,%ecx
  88:	fc                   	cld    
  89:	f3 aa                	rep stos %al,%es:(%edi)
  8b:	89 ca                	mov    %ecx,%edx
  8d:	89 fb                	mov    %edi,%ebx
  8f:	89 5d 08             	mov    %ebx,0x8(%ebp)
  92:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  95:	90                   	nop
  96:	5b                   	pop    %ebx
  97:	5f                   	pop    %edi
  98:	5d                   	pop    %ebp
  99:	c3                   	ret    

0000009a <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  9a:	55                   	push   %ebp
  9b:	89 e5                	mov    %esp,%ebp
  9d:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  a0:	8b 45 08             	mov    0x8(%ebp),%eax
  a3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  a6:	90                   	nop
  a7:	8b 55 0c             	mov    0xc(%ebp),%edx
  aa:	8d 42 01             	lea    0x1(%edx),%eax
  ad:	89 45 0c             	mov    %eax,0xc(%ebp)
  b0:	8b 45 08             	mov    0x8(%ebp),%eax
  b3:	8d 48 01             	lea    0x1(%eax),%ecx
  b6:	89 4d 08             	mov    %ecx,0x8(%ebp)
  b9:	0f b6 12             	movzbl (%edx),%edx
  bc:	88 10                	mov    %dl,(%eax)
  be:	0f b6 00             	movzbl (%eax),%eax
  c1:	84 c0                	test   %al,%al
  c3:	75 e2                	jne    a7 <strcpy+0xd>
    ;
  return os;
  c5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  c8:	c9                   	leave  
  c9:	c3                   	ret    

000000ca <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ca:	55                   	push   %ebp
  cb:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  cd:	eb 08                	jmp    d7 <strcmp+0xd>
    p++, q++;
  cf:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  d3:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
  d7:	8b 45 08             	mov    0x8(%ebp),%eax
  da:	0f b6 00             	movzbl (%eax),%eax
  dd:	84 c0                	test   %al,%al
  df:	74 10                	je     f1 <strcmp+0x27>
  e1:	8b 45 08             	mov    0x8(%ebp),%eax
  e4:	0f b6 10             	movzbl (%eax),%edx
  e7:	8b 45 0c             	mov    0xc(%ebp),%eax
  ea:	0f b6 00             	movzbl (%eax),%eax
  ed:	38 c2                	cmp    %al,%dl
  ef:	74 de                	je     cf <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
  f1:	8b 45 08             	mov    0x8(%ebp),%eax
  f4:	0f b6 00             	movzbl (%eax),%eax
  f7:	0f b6 d0             	movzbl %al,%edx
  fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  fd:	0f b6 00             	movzbl (%eax),%eax
 100:	0f b6 c8             	movzbl %al,%ecx
 103:	89 d0                	mov    %edx,%eax
 105:	29 c8                	sub    %ecx,%eax
}
 107:	5d                   	pop    %ebp
 108:	c3                   	ret    

00000109 <strlen>:

uint
strlen(const char *s)
{
 109:	55                   	push   %ebp
 10a:	89 e5                	mov    %esp,%ebp
 10c:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 10f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 116:	eb 04                	jmp    11c <strlen+0x13>
 118:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 11c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 11f:	8b 45 08             	mov    0x8(%ebp),%eax
 122:	01 d0                	add    %edx,%eax
 124:	0f b6 00             	movzbl (%eax),%eax
 127:	84 c0                	test   %al,%al
 129:	75 ed                	jne    118 <strlen+0xf>
    ;
  return n;
 12b:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 12e:	c9                   	leave  
 12f:	c3                   	ret    

00000130 <memset>:

void*
memset(void *dst, int c, uint n)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 133:	8b 45 10             	mov    0x10(%ebp),%eax
 136:	50                   	push   %eax
 137:	ff 75 0c             	push   0xc(%ebp)
 13a:	ff 75 08             	push   0x8(%ebp)
 13d:	e8 32 ff ff ff       	call   74 <stosb>
 142:	83 c4 0c             	add    $0xc,%esp
  return dst;
 145:	8b 45 08             	mov    0x8(%ebp),%eax
}
 148:	c9                   	leave  
 149:	c3                   	ret    

0000014a <strchr>:

char*
strchr(const char *s, char c)
{
 14a:	55                   	push   %ebp
 14b:	89 e5                	mov    %esp,%ebp
 14d:	83 ec 04             	sub    $0x4,%esp
 150:	8b 45 0c             	mov    0xc(%ebp),%eax
 153:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 156:	eb 14                	jmp    16c <strchr+0x22>
    if(*s == c)
 158:	8b 45 08             	mov    0x8(%ebp),%eax
 15b:	0f b6 00             	movzbl (%eax),%eax
 15e:	38 45 fc             	cmp    %al,-0x4(%ebp)
 161:	75 05                	jne    168 <strchr+0x1e>
      return (char*)s;
 163:	8b 45 08             	mov    0x8(%ebp),%eax
 166:	eb 13                	jmp    17b <strchr+0x31>
  for(; *s; s++)
 168:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 16c:	8b 45 08             	mov    0x8(%ebp),%eax
 16f:	0f b6 00             	movzbl (%eax),%eax
 172:	84 c0                	test   %al,%al
 174:	75 e2                	jne    158 <strchr+0xe>
  return 0;
 176:	b8 00 00 00 00       	mov    $0x0,%eax
}
 17b:	c9                   	leave  
 17c:	c3                   	ret    

0000017d <gets>:

char*
gets(char *buf, int max)
{
 17d:	55                   	push   %ebp
 17e:	89 e5                	mov    %esp,%ebp
 180:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 183:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 18a:	eb 42                	jmp    1ce <gets+0x51>
    cc = read(0, &c, 1);
 18c:	83 ec 04             	sub    $0x4,%esp
 18f:	6a 01                	push   $0x1
 191:	8d 45 ef             	lea    -0x11(%ebp),%eax
 194:	50                   	push   %eax
 195:	6a 00                	push   $0x0
 197:	e8 a2 01 00 00       	call   33e <read>
 19c:	83 c4 10             	add    $0x10,%esp
 19f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1a2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1a6:	7e 33                	jle    1db <gets+0x5e>
      break;
    buf[i++] = c;
 1a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1ab:	8d 50 01             	lea    0x1(%eax),%edx
 1ae:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1b1:	89 c2                	mov    %eax,%edx
 1b3:	8b 45 08             	mov    0x8(%ebp),%eax
 1b6:	01 c2                	add    %eax,%edx
 1b8:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1bc:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1be:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1c2:	3c 0a                	cmp    $0xa,%al
 1c4:	74 16                	je     1dc <gets+0x5f>
 1c6:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1ca:	3c 0d                	cmp    $0xd,%al
 1cc:	74 0e                	je     1dc <gets+0x5f>
  for(i=0; i+1 < max; ){
 1ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1d1:	83 c0 01             	add    $0x1,%eax
 1d4:	39 45 0c             	cmp    %eax,0xc(%ebp)
 1d7:	7f b3                	jg     18c <gets+0xf>
 1d9:	eb 01                	jmp    1dc <gets+0x5f>
      break;
 1db:	90                   	nop
      break;
  }
  buf[i] = '\0';
 1dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1df:	8b 45 08             	mov    0x8(%ebp),%eax
 1e2:	01 d0                	add    %edx,%eax
 1e4:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1e7:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1ea:	c9                   	leave  
 1eb:	c3                   	ret    

000001ec <stat>:

int
stat(const char *n, struct stat *st)
{
 1ec:	55                   	push   %ebp
 1ed:	89 e5                	mov    %esp,%ebp
 1ef:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f2:	83 ec 08             	sub    $0x8,%esp
 1f5:	6a 00                	push   $0x0
 1f7:	ff 75 08             	push   0x8(%ebp)
 1fa:	e8 67 01 00 00       	call   366 <open>
 1ff:	83 c4 10             	add    $0x10,%esp
 202:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 205:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 209:	79 07                	jns    212 <stat+0x26>
    return -1;
 20b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 210:	eb 25                	jmp    237 <stat+0x4b>
  r = fstat(fd, st);
 212:	83 ec 08             	sub    $0x8,%esp
 215:	ff 75 0c             	push   0xc(%ebp)
 218:	ff 75 f4             	push   -0xc(%ebp)
 21b:	e8 5e 01 00 00       	call   37e <fstat>
 220:	83 c4 10             	add    $0x10,%esp
 223:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 226:	83 ec 0c             	sub    $0xc,%esp
 229:	ff 75 f4             	push   -0xc(%ebp)
 22c:	e8 1d 01 00 00       	call   34e <close>
 231:	83 c4 10             	add    $0x10,%esp
  return r;
 234:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 237:	c9                   	leave  
 238:	c3                   	ret    

00000239 <atoi>:

int
atoi(const char *s)
{
 239:	55                   	push   %ebp
 23a:	89 e5                	mov    %esp,%ebp
 23c:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 23f:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 246:	eb 25                	jmp    26d <atoi+0x34>
    n = n*10 + *s++ - '0';
 248:	8b 55 fc             	mov    -0x4(%ebp),%edx
 24b:	89 d0                	mov    %edx,%eax
 24d:	c1 e0 02             	shl    $0x2,%eax
 250:	01 d0                	add    %edx,%eax
 252:	01 c0                	add    %eax,%eax
 254:	89 c1                	mov    %eax,%ecx
 256:	8b 45 08             	mov    0x8(%ebp),%eax
 259:	8d 50 01             	lea    0x1(%eax),%edx
 25c:	89 55 08             	mov    %edx,0x8(%ebp)
 25f:	0f b6 00             	movzbl (%eax),%eax
 262:	0f be c0             	movsbl %al,%eax
 265:	01 c8                	add    %ecx,%eax
 267:	83 e8 30             	sub    $0x30,%eax
 26a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 26d:	8b 45 08             	mov    0x8(%ebp),%eax
 270:	0f b6 00             	movzbl (%eax),%eax
 273:	3c 2f                	cmp    $0x2f,%al
 275:	7e 0a                	jle    281 <atoi+0x48>
 277:	8b 45 08             	mov    0x8(%ebp),%eax
 27a:	0f b6 00             	movzbl (%eax),%eax
 27d:	3c 39                	cmp    $0x39,%al
 27f:	7e c7                	jle    248 <atoi+0xf>
  return n;
 281:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 284:	c9                   	leave  
 285:	c3                   	ret    

00000286 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 286:	55                   	push   %ebp
 287:	89 e5                	mov    %esp,%ebp
 289:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
 28c:	8b 45 08             	mov    0x8(%ebp),%eax
 28f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 292:	8b 45 0c             	mov    0xc(%ebp),%eax
 295:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 298:	eb 17                	jmp    2b1 <memmove+0x2b>
    *dst++ = *src++;
 29a:	8b 55 f8             	mov    -0x8(%ebp),%edx
 29d:	8d 42 01             	lea    0x1(%edx),%eax
 2a0:	89 45 f8             	mov    %eax,-0x8(%ebp)
 2a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2a6:	8d 48 01             	lea    0x1(%eax),%ecx
 2a9:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 2ac:	0f b6 12             	movzbl (%edx),%edx
 2af:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 2b1:	8b 45 10             	mov    0x10(%ebp),%eax
 2b4:	8d 50 ff             	lea    -0x1(%eax),%edx
 2b7:	89 55 10             	mov    %edx,0x10(%ebp)
 2ba:	85 c0                	test   %eax,%eax
 2bc:	7f dc                	jg     29a <memmove+0x14>
  return vdst;
 2be:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2c1:	c9                   	leave  
 2c2:	c3                   	ret    

000002c3 <calc>:

int calc(int num)
{
 2c3:	55                   	push   %ebp
 2c4:	89 e5                	mov    %esp,%ebp
 2c6:	83 ec 10             	sub    $0x10,%esp
    int c = 0;
 2c9:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for(uint i = 0; i < num; i++)
 2d0:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
 2d7:	eb 36                	jmp    30f <calc+0x4c>
    {
        for(uint j = 0; j < num; j++)
 2d9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2e0:	eb 21                	jmp    303 <calc+0x40>
        {
            for(uint k = 0; k < num; j++)
 2e2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 2e9:	eb 0c                	jmp    2f7 <calc+0x34>
            {
                c >>= 10;
 2eb:	c1 7d fc 0a          	sarl   $0xa,-0x4(%ebp)
                c <<= 10;
 2ef:	c1 65 fc 0a          	shll   $0xa,-0x4(%ebp)
            for(uint k = 0; k < num; j++)
 2f3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 2f7:	8b 45 08             	mov    0x8(%ebp),%eax
 2fa:	39 45 f0             	cmp    %eax,-0x10(%ebp)
 2fd:	72 ec                	jb     2eb <calc+0x28>
        for(uint j = 0; j < num; j++)
 2ff:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 303:	8b 45 08             	mov    0x8(%ebp),%eax
 306:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 309:	72 d7                	jb     2e2 <calc+0x1f>
    for(uint i = 0; i < num; i++)
 30b:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 30f:	8b 45 08             	mov    0x8(%ebp),%eax
 312:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 315:	72 c2                	jb     2d9 <calc+0x16>
            }
        }
    }
    return 0;
 317:	b8 00 00 00 00       	mov    $0x0,%eax
}
 31c:	c9                   	leave  
 31d:	c3                   	ret    

0000031e <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 31e:	b8 01 00 00 00       	mov    $0x1,%eax
 323:	cd 40                	int    $0x40
 325:	c3                   	ret    

00000326 <exit>:
SYSCALL(exit)
 326:	b8 02 00 00 00       	mov    $0x2,%eax
 32b:	cd 40                	int    $0x40
 32d:	c3                   	ret    

0000032e <wait>:
SYSCALL(wait)
 32e:	b8 03 00 00 00       	mov    $0x3,%eax
 333:	cd 40                	int    $0x40
 335:	c3                   	ret    

00000336 <pipe>:
SYSCALL(pipe)
 336:	b8 04 00 00 00       	mov    $0x4,%eax
 33b:	cd 40                	int    $0x40
 33d:	c3                   	ret    

0000033e <read>:
SYSCALL(read)
 33e:	b8 05 00 00 00       	mov    $0x5,%eax
 343:	cd 40                	int    $0x40
 345:	c3                   	ret    

00000346 <write>:
SYSCALL(write)
 346:	b8 10 00 00 00       	mov    $0x10,%eax
 34b:	cd 40                	int    $0x40
 34d:	c3                   	ret    

0000034e <close>:
SYSCALL(close)
 34e:	b8 15 00 00 00       	mov    $0x15,%eax
 353:	cd 40                	int    $0x40
 355:	c3                   	ret    

00000356 <kill>:
SYSCALL(kill)
 356:	b8 06 00 00 00       	mov    $0x6,%eax
 35b:	cd 40                	int    $0x40
 35d:	c3                   	ret    

0000035e <exec>:
SYSCALL(exec)
 35e:	b8 07 00 00 00       	mov    $0x7,%eax
 363:	cd 40                	int    $0x40
 365:	c3                   	ret    

00000366 <open>:
SYSCALL(open)
 366:	b8 0f 00 00 00       	mov    $0xf,%eax
 36b:	cd 40                	int    $0x40
 36d:	c3                   	ret    

0000036e <mknod>:
SYSCALL(mknod)
 36e:	b8 11 00 00 00       	mov    $0x11,%eax
 373:	cd 40                	int    $0x40
 375:	c3                   	ret    

00000376 <unlink>:
SYSCALL(unlink)
 376:	b8 12 00 00 00       	mov    $0x12,%eax
 37b:	cd 40                	int    $0x40
 37d:	c3                   	ret    

0000037e <fstat>:
SYSCALL(fstat)
 37e:	b8 08 00 00 00       	mov    $0x8,%eax
 383:	cd 40                	int    $0x40
 385:	c3                   	ret    

00000386 <link>:
SYSCALL(link)
 386:	b8 13 00 00 00       	mov    $0x13,%eax
 38b:	cd 40                	int    $0x40
 38d:	c3                   	ret    

0000038e <mkdir>:
SYSCALL(mkdir)
 38e:	b8 14 00 00 00       	mov    $0x14,%eax
 393:	cd 40                	int    $0x40
 395:	c3                   	ret    

00000396 <chdir>:
SYSCALL(chdir)
 396:	b8 09 00 00 00       	mov    $0x9,%eax
 39b:	cd 40                	int    $0x40
 39d:	c3                   	ret    

0000039e <dup>:
SYSCALL(dup)
 39e:	b8 0a 00 00 00       	mov    $0xa,%eax
 3a3:	cd 40                	int    $0x40
 3a5:	c3                   	ret    

000003a6 <getpid>:
SYSCALL(getpid)
 3a6:	b8 0b 00 00 00       	mov    $0xb,%eax
 3ab:	cd 40                	int    $0x40
 3ad:	c3                   	ret    

000003ae <sbrk>:
SYSCALL(sbrk)
 3ae:	b8 0c 00 00 00       	mov    $0xc,%eax
 3b3:	cd 40                	int    $0x40
 3b5:	c3                   	ret    

000003b6 <sleep>:
SYSCALL(sleep)
 3b6:	b8 0d 00 00 00       	mov    $0xd,%eax
 3bb:	cd 40                	int    $0x40
 3bd:	c3                   	ret    

000003be <uptime>:
SYSCALL(uptime)
 3be:	b8 0e 00 00 00       	mov    $0xe,%eax
 3c3:	cd 40                	int    $0x40
 3c5:	c3                   	ret    

000003c6 <print_proc>:
SYSCALL(print_proc)
 3c6:	b8 16 00 00 00       	mov    $0x16,%eax
 3cb:	cd 40                	int    $0x40
 3cd:	c3                   	ret    

000003ce <change_queue>:
SYSCALL(change_queue)
 3ce:	b8 17 00 00 00       	mov    $0x17,%eax
 3d3:	cd 40                	int    $0x40
 3d5:	c3                   	ret    

000003d6 <change_local_bjf>:
SYSCALL(change_local_bjf)
 3d6:	b8 18 00 00 00       	mov    $0x18,%eax
 3db:	cd 40                	int    $0x40
 3dd:	c3                   	ret    

000003de <change_global_bjf>:
SYSCALL(change_global_bjf)
 3de:	b8 19 00 00 00       	mov    $0x19,%eax
 3e3:	cd 40                	int    $0x40
 3e5:	c3                   	ret    

000003e6 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3e6:	55                   	push   %ebp
 3e7:	89 e5                	mov    %esp,%ebp
 3e9:	83 ec 18             	sub    $0x18,%esp
 3ec:	8b 45 0c             	mov    0xc(%ebp),%eax
 3ef:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3f2:	83 ec 04             	sub    $0x4,%esp
 3f5:	6a 01                	push   $0x1
 3f7:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3fa:	50                   	push   %eax
 3fb:	ff 75 08             	push   0x8(%ebp)
 3fe:	e8 43 ff ff ff       	call   346 <write>
 403:	83 c4 10             	add    $0x10,%esp
}
 406:	90                   	nop
 407:	c9                   	leave  
 408:	c3                   	ret    

00000409 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 409:	55                   	push   %ebp
 40a:	89 e5                	mov    %esp,%ebp
 40c:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 40f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 416:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 41a:	74 17                	je     433 <printint+0x2a>
 41c:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 420:	79 11                	jns    433 <printint+0x2a>
    neg = 1;
 422:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 429:	8b 45 0c             	mov    0xc(%ebp),%eax
 42c:	f7 d8                	neg    %eax
 42e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 431:	eb 06                	jmp    439 <printint+0x30>
  } else {
    x = xx;
 433:	8b 45 0c             	mov    0xc(%ebp),%eax
 436:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 439:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 440:	8b 4d 10             	mov    0x10(%ebp),%ecx
 443:	8b 45 ec             	mov    -0x14(%ebp),%eax
 446:	ba 00 00 00 00       	mov    $0x0,%edx
 44b:	f7 f1                	div    %ecx
 44d:	89 d1                	mov    %edx,%ecx
 44f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 452:	8d 50 01             	lea    0x1(%eax),%edx
 455:	89 55 f4             	mov    %edx,-0xc(%ebp)
 458:	0f b6 91 08 0b 00 00 	movzbl 0xb08(%ecx),%edx
 45f:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 463:	8b 4d 10             	mov    0x10(%ebp),%ecx
 466:	8b 45 ec             	mov    -0x14(%ebp),%eax
 469:	ba 00 00 00 00       	mov    $0x0,%edx
 46e:	f7 f1                	div    %ecx
 470:	89 45 ec             	mov    %eax,-0x14(%ebp)
 473:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 477:	75 c7                	jne    440 <printint+0x37>
  if(neg)
 479:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 47d:	74 2d                	je     4ac <printint+0xa3>
    buf[i++] = '-';
 47f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 482:	8d 50 01             	lea    0x1(%eax),%edx
 485:	89 55 f4             	mov    %edx,-0xc(%ebp)
 488:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 48d:	eb 1d                	jmp    4ac <printint+0xa3>
    putc(fd, buf[i]);
 48f:	8d 55 dc             	lea    -0x24(%ebp),%edx
 492:	8b 45 f4             	mov    -0xc(%ebp),%eax
 495:	01 d0                	add    %edx,%eax
 497:	0f b6 00             	movzbl (%eax),%eax
 49a:	0f be c0             	movsbl %al,%eax
 49d:	83 ec 08             	sub    $0x8,%esp
 4a0:	50                   	push   %eax
 4a1:	ff 75 08             	push   0x8(%ebp)
 4a4:	e8 3d ff ff ff       	call   3e6 <putc>
 4a9:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 4ac:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4b0:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4b4:	79 d9                	jns    48f <printint+0x86>
}
 4b6:	90                   	nop
 4b7:	90                   	nop
 4b8:	c9                   	leave  
 4b9:	c3                   	ret    

000004ba <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4ba:	55                   	push   %ebp
 4bb:	89 e5                	mov    %esp,%ebp
 4bd:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4c0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4c7:	8d 45 0c             	lea    0xc(%ebp),%eax
 4ca:	83 c0 04             	add    $0x4,%eax
 4cd:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4d0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4d7:	e9 59 01 00 00       	jmp    635 <printf+0x17b>
    c = fmt[i] & 0xff;
 4dc:	8b 55 0c             	mov    0xc(%ebp),%edx
 4df:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4e2:	01 d0                	add    %edx,%eax
 4e4:	0f b6 00             	movzbl (%eax),%eax
 4e7:	0f be c0             	movsbl %al,%eax
 4ea:	25 ff 00 00 00       	and    $0xff,%eax
 4ef:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4f2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4f6:	75 2c                	jne    524 <printf+0x6a>
      if(c == '%'){
 4f8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4fc:	75 0c                	jne    50a <printf+0x50>
        state = '%';
 4fe:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 505:	e9 27 01 00 00       	jmp    631 <printf+0x177>
      } else {
        putc(fd, c);
 50a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 50d:	0f be c0             	movsbl %al,%eax
 510:	83 ec 08             	sub    $0x8,%esp
 513:	50                   	push   %eax
 514:	ff 75 08             	push   0x8(%ebp)
 517:	e8 ca fe ff ff       	call   3e6 <putc>
 51c:	83 c4 10             	add    $0x10,%esp
 51f:	e9 0d 01 00 00       	jmp    631 <printf+0x177>
      }
    } else if(state == '%'){
 524:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 528:	0f 85 03 01 00 00    	jne    631 <printf+0x177>
      if(c == 'd'){
 52e:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 532:	75 1e                	jne    552 <printf+0x98>
        printint(fd, *ap, 10, 1);
 534:	8b 45 e8             	mov    -0x18(%ebp),%eax
 537:	8b 00                	mov    (%eax),%eax
 539:	6a 01                	push   $0x1
 53b:	6a 0a                	push   $0xa
 53d:	50                   	push   %eax
 53e:	ff 75 08             	push   0x8(%ebp)
 541:	e8 c3 fe ff ff       	call   409 <printint>
 546:	83 c4 10             	add    $0x10,%esp
        ap++;
 549:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 54d:	e9 d8 00 00 00       	jmp    62a <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 552:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 556:	74 06                	je     55e <printf+0xa4>
 558:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 55c:	75 1e                	jne    57c <printf+0xc2>
        printint(fd, *ap, 16, 0);
 55e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 561:	8b 00                	mov    (%eax),%eax
 563:	6a 00                	push   $0x0
 565:	6a 10                	push   $0x10
 567:	50                   	push   %eax
 568:	ff 75 08             	push   0x8(%ebp)
 56b:	e8 99 fe ff ff       	call   409 <printint>
 570:	83 c4 10             	add    $0x10,%esp
        ap++;
 573:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 577:	e9 ae 00 00 00       	jmp    62a <printf+0x170>
      } else if(c == 's'){
 57c:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 580:	75 43                	jne    5c5 <printf+0x10b>
        s = (char*)*ap;
 582:	8b 45 e8             	mov    -0x18(%ebp),%eax
 585:	8b 00                	mov    (%eax),%eax
 587:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 58a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 58e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 592:	75 25                	jne    5b9 <printf+0xff>
          s = "(null)";
 594:	c7 45 f4 98 08 00 00 	movl   $0x898,-0xc(%ebp)
        while(*s != 0){
 59b:	eb 1c                	jmp    5b9 <printf+0xff>
          putc(fd, *s);
 59d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5a0:	0f b6 00             	movzbl (%eax),%eax
 5a3:	0f be c0             	movsbl %al,%eax
 5a6:	83 ec 08             	sub    $0x8,%esp
 5a9:	50                   	push   %eax
 5aa:	ff 75 08             	push   0x8(%ebp)
 5ad:	e8 34 fe ff ff       	call   3e6 <putc>
 5b2:	83 c4 10             	add    $0x10,%esp
          s++;
 5b5:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 5b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5bc:	0f b6 00             	movzbl (%eax),%eax
 5bf:	84 c0                	test   %al,%al
 5c1:	75 da                	jne    59d <printf+0xe3>
 5c3:	eb 65                	jmp    62a <printf+0x170>
        }
      } else if(c == 'c'){
 5c5:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5c9:	75 1d                	jne    5e8 <printf+0x12e>
        putc(fd, *ap);
 5cb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5ce:	8b 00                	mov    (%eax),%eax
 5d0:	0f be c0             	movsbl %al,%eax
 5d3:	83 ec 08             	sub    $0x8,%esp
 5d6:	50                   	push   %eax
 5d7:	ff 75 08             	push   0x8(%ebp)
 5da:	e8 07 fe ff ff       	call   3e6 <putc>
 5df:	83 c4 10             	add    $0x10,%esp
        ap++;
 5e2:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5e6:	eb 42                	jmp    62a <printf+0x170>
      } else if(c == '%'){
 5e8:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5ec:	75 17                	jne    605 <printf+0x14b>
        putc(fd, c);
 5ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5f1:	0f be c0             	movsbl %al,%eax
 5f4:	83 ec 08             	sub    $0x8,%esp
 5f7:	50                   	push   %eax
 5f8:	ff 75 08             	push   0x8(%ebp)
 5fb:	e8 e6 fd ff ff       	call   3e6 <putc>
 600:	83 c4 10             	add    $0x10,%esp
 603:	eb 25                	jmp    62a <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 605:	83 ec 08             	sub    $0x8,%esp
 608:	6a 25                	push   $0x25
 60a:	ff 75 08             	push   0x8(%ebp)
 60d:	e8 d4 fd ff ff       	call   3e6 <putc>
 612:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 615:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 618:	0f be c0             	movsbl %al,%eax
 61b:	83 ec 08             	sub    $0x8,%esp
 61e:	50                   	push   %eax
 61f:	ff 75 08             	push   0x8(%ebp)
 622:	e8 bf fd ff ff       	call   3e6 <putc>
 627:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 62a:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 631:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 635:	8b 55 0c             	mov    0xc(%ebp),%edx
 638:	8b 45 f0             	mov    -0x10(%ebp),%eax
 63b:	01 d0                	add    %edx,%eax
 63d:	0f b6 00             	movzbl (%eax),%eax
 640:	84 c0                	test   %al,%al
 642:	0f 85 94 fe ff ff    	jne    4dc <printf+0x22>
    }
  }
}
 648:	90                   	nop
 649:	90                   	nop
 64a:	c9                   	leave  
 64b:	c3                   	ret    

0000064c <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 64c:	55                   	push   %ebp
 64d:	89 e5                	mov    %esp,%ebp
 64f:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 652:	8b 45 08             	mov    0x8(%ebp),%eax
 655:	83 e8 08             	sub    $0x8,%eax
 658:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 65b:	a1 24 0b 00 00       	mov    0xb24,%eax
 660:	89 45 fc             	mov    %eax,-0x4(%ebp)
 663:	eb 24                	jmp    689 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 665:	8b 45 fc             	mov    -0x4(%ebp),%eax
 668:	8b 00                	mov    (%eax),%eax
 66a:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 66d:	72 12                	jb     681 <free+0x35>
 66f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 672:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 675:	77 24                	ja     69b <free+0x4f>
 677:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67a:	8b 00                	mov    (%eax),%eax
 67c:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 67f:	72 1a                	jb     69b <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 681:	8b 45 fc             	mov    -0x4(%ebp),%eax
 684:	8b 00                	mov    (%eax),%eax
 686:	89 45 fc             	mov    %eax,-0x4(%ebp)
 689:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68c:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 68f:	76 d4                	jbe    665 <free+0x19>
 691:	8b 45 fc             	mov    -0x4(%ebp),%eax
 694:	8b 00                	mov    (%eax),%eax
 696:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 699:	73 ca                	jae    665 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 69b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69e:	8b 40 04             	mov    0x4(%eax),%eax
 6a1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ab:	01 c2                	add    %eax,%edx
 6ad:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b0:	8b 00                	mov    (%eax),%eax
 6b2:	39 c2                	cmp    %eax,%edx
 6b4:	75 24                	jne    6da <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b9:	8b 50 04             	mov    0x4(%eax),%edx
 6bc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6bf:	8b 00                	mov    (%eax),%eax
 6c1:	8b 40 04             	mov    0x4(%eax),%eax
 6c4:	01 c2                	add    %eax,%edx
 6c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c9:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6cc:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cf:	8b 00                	mov    (%eax),%eax
 6d1:	8b 10                	mov    (%eax),%edx
 6d3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6d6:	89 10                	mov    %edx,(%eax)
 6d8:	eb 0a                	jmp    6e4 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6da:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6dd:	8b 10                	mov    (%eax),%edx
 6df:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e2:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6e4:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e7:	8b 40 04             	mov    0x4(%eax),%eax
 6ea:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f4:	01 d0                	add    %edx,%eax
 6f6:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 6f9:	75 20                	jne    71b <free+0xcf>
    p->s.size += bp->s.size;
 6fb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fe:	8b 50 04             	mov    0x4(%eax),%edx
 701:	8b 45 f8             	mov    -0x8(%ebp),%eax
 704:	8b 40 04             	mov    0x4(%eax),%eax
 707:	01 c2                	add    %eax,%edx
 709:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70c:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 70f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 712:	8b 10                	mov    (%eax),%edx
 714:	8b 45 fc             	mov    -0x4(%ebp),%eax
 717:	89 10                	mov    %edx,(%eax)
 719:	eb 08                	jmp    723 <free+0xd7>
  } else
    p->s.ptr = bp;
 71b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 721:	89 10                	mov    %edx,(%eax)
  freep = p;
 723:	8b 45 fc             	mov    -0x4(%ebp),%eax
 726:	a3 24 0b 00 00       	mov    %eax,0xb24
}
 72b:	90                   	nop
 72c:	c9                   	leave  
 72d:	c3                   	ret    

0000072e <morecore>:

static Header*
morecore(uint nu)
{
 72e:	55                   	push   %ebp
 72f:	89 e5                	mov    %esp,%ebp
 731:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 734:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 73b:	77 07                	ja     744 <morecore+0x16>
    nu = 4096;
 73d:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 744:	8b 45 08             	mov    0x8(%ebp),%eax
 747:	c1 e0 03             	shl    $0x3,%eax
 74a:	83 ec 0c             	sub    $0xc,%esp
 74d:	50                   	push   %eax
 74e:	e8 5b fc ff ff       	call   3ae <sbrk>
 753:	83 c4 10             	add    $0x10,%esp
 756:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 759:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 75d:	75 07                	jne    766 <morecore+0x38>
    return 0;
 75f:	b8 00 00 00 00       	mov    $0x0,%eax
 764:	eb 26                	jmp    78c <morecore+0x5e>
  hp = (Header*)p;
 766:	8b 45 f4             	mov    -0xc(%ebp),%eax
 769:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 76c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 76f:	8b 55 08             	mov    0x8(%ebp),%edx
 772:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 775:	8b 45 f0             	mov    -0x10(%ebp),%eax
 778:	83 c0 08             	add    $0x8,%eax
 77b:	83 ec 0c             	sub    $0xc,%esp
 77e:	50                   	push   %eax
 77f:	e8 c8 fe ff ff       	call   64c <free>
 784:	83 c4 10             	add    $0x10,%esp
  return freep;
 787:	a1 24 0b 00 00       	mov    0xb24,%eax
}
 78c:	c9                   	leave  
 78d:	c3                   	ret    

0000078e <malloc>:

void*
malloc(uint nbytes)
{
 78e:	55                   	push   %ebp
 78f:	89 e5                	mov    %esp,%ebp
 791:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 794:	8b 45 08             	mov    0x8(%ebp),%eax
 797:	83 c0 07             	add    $0x7,%eax
 79a:	c1 e8 03             	shr    $0x3,%eax
 79d:	83 c0 01             	add    $0x1,%eax
 7a0:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7a3:	a1 24 0b 00 00       	mov    0xb24,%eax
 7a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7ab:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7af:	75 23                	jne    7d4 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7b1:	c7 45 f0 1c 0b 00 00 	movl   $0xb1c,-0x10(%ebp)
 7b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7bb:	a3 24 0b 00 00       	mov    %eax,0xb24
 7c0:	a1 24 0b 00 00       	mov    0xb24,%eax
 7c5:	a3 1c 0b 00 00       	mov    %eax,0xb1c
    base.s.size = 0;
 7ca:	c7 05 20 0b 00 00 00 	movl   $0x0,0xb20
 7d1:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d7:	8b 00                	mov    (%eax),%eax
 7d9:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7df:	8b 40 04             	mov    0x4(%eax),%eax
 7e2:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7e5:	77 4d                	ja     834 <malloc+0xa6>
      if(p->s.size == nunits)
 7e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ea:	8b 40 04             	mov    0x4(%eax),%eax
 7ed:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7f0:	75 0c                	jne    7fe <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f5:	8b 10                	mov    (%eax),%edx
 7f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7fa:	89 10                	mov    %edx,(%eax)
 7fc:	eb 26                	jmp    824 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 801:	8b 40 04             	mov    0x4(%eax),%eax
 804:	2b 45 ec             	sub    -0x14(%ebp),%eax
 807:	89 c2                	mov    %eax,%edx
 809:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80c:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 80f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 812:	8b 40 04             	mov    0x4(%eax),%eax
 815:	c1 e0 03             	shl    $0x3,%eax
 818:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 81b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 81e:	8b 55 ec             	mov    -0x14(%ebp),%edx
 821:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 824:	8b 45 f0             	mov    -0x10(%ebp),%eax
 827:	a3 24 0b 00 00       	mov    %eax,0xb24
      return (void*)(p + 1);
 82c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 82f:	83 c0 08             	add    $0x8,%eax
 832:	eb 3b                	jmp    86f <malloc+0xe1>
    }
    if(p == freep)
 834:	a1 24 0b 00 00       	mov    0xb24,%eax
 839:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 83c:	75 1e                	jne    85c <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 83e:	83 ec 0c             	sub    $0xc,%esp
 841:	ff 75 ec             	push   -0x14(%ebp)
 844:	e8 e5 fe ff ff       	call   72e <morecore>
 849:	83 c4 10             	add    $0x10,%esp
 84c:	89 45 f4             	mov    %eax,-0xc(%ebp)
 84f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 853:	75 07                	jne    85c <malloc+0xce>
        return 0;
 855:	b8 00 00 00 00       	mov    $0x0,%eax
 85a:	eb 13                	jmp    86f <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 85c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 85f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 862:	8b 45 f4             	mov    -0xc(%ebp),%eax
 865:	8b 00                	mov    (%eax),%eax
 867:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 86a:	e9 6d ff ff ff       	jmp    7dc <malloc+0x4e>
  }
}
 86f:	c9                   	leave  
 870:	c3                   	ret    
