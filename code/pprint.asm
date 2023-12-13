
_pprint:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"

int main(void) 
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 e4 f0             	and    $0xfffffff0,%esp
  print_proc();
   6:	e8 57 03 00 00       	call   362 <print_proc>
  exit();
   b:	e8 b2 02 00 00       	call   2c2 <exit>

00000010 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  10:	55                   	push   %ebp
  11:	89 e5                	mov    %esp,%ebp
  13:	57                   	push   %edi
  14:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  15:	8b 4d 08             	mov    0x8(%ebp),%ecx
  18:	8b 55 10             	mov    0x10(%ebp),%edx
  1b:	8b 45 0c             	mov    0xc(%ebp),%eax
  1e:	89 cb                	mov    %ecx,%ebx
  20:	89 df                	mov    %ebx,%edi
  22:	89 d1                	mov    %edx,%ecx
  24:	fc                   	cld    
  25:	f3 aa                	rep stos %al,%es:(%edi)
  27:	89 ca                	mov    %ecx,%edx
  29:	89 fb                	mov    %edi,%ebx
  2b:	89 5d 08             	mov    %ebx,0x8(%ebp)
  2e:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  31:	90                   	nop
  32:	5b                   	pop    %ebx
  33:	5f                   	pop    %edi
  34:	5d                   	pop    %ebp
  35:	c3                   	ret    

00000036 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  36:	55                   	push   %ebp
  37:	89 e5                	mov    %esp,%ebp
  39:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  3c:	8b 45 08             	mov    0x8(%ebp),%eax
  3f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  42:	90                   	nop
  43:	8b 55 0c             	mov    0xc(%ebp),%edx
  46:	8d 42 01             	lea    0x1(%edx),%eax
  49:	89 45 0c             	mov    %eax,0xc(%ebp)
  4c:	8b 45 08             	mov    0x8(%ebp),%eax
  4f:	8d 48 01             	lea    0x1(%eax),%ecx
  52:	89 4d 08             	mov    %ecx,0x8(%ebp)
  55:	0f b6 12             	movzbl (%edx),%edx
  58:	88 10                	mov    %dl,(%eax)
  5a:	0f b6 00             	movzbl (%eax),%eax
  5d:	84 c0                	test   %al,%al
  5f:	75 e2                	jne    43 <strcpy+0xd>
    ;
  return os;
  61:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  64:	c9                   	leave  
  65:	c3                   	ret    

00000066 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  66:	55                   	push   %ebp
  67:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  69:	eb 08                	jmp    73 <strcmp+0xd>
    p++, q++;
  6b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  6f:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
  73:	8b 45 08             	mov    0x8(%ebp),%eax
  76:	0f b6 00             	movzbl (%eax),%eax
  79:	84 c0                	test   %al,%al
  7b:	74 10                	je     8d <strcmp+0x27>
  7d:	8b 45 08             	mov    0x8(%ebp),%eax
  80:	0f b6 10             	movzbl (%eax),%edx
  83:	8b 45 0c             	mov    0xc(%ebp),%eax
  86:	0f b6 00             	movzbl (%eax),%eax
  89:	38 c2                	cmp    %al,%dl
  8b:	74 de                	je     6b <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
  8d:	8b 45 08             	mov    0x8(%ebp),%eax
  90:	0f b6 00             	movzbl (%eax),%eax
  93:	0f b6 d0             	movzbl %al,%edx
  96:	8b 45 0c             	mov    0xc(%ebp),%eax
  99:	0f b6 00             	movzbl (%eax),%eax
  9c:	0f b6 c8             	movzbl %al,%ecx
  9f:	89 d0                	mov    %edx,%eax
  a1:	29 c8                	sub    %ecx,%eax
}
  a3:	5d                   	pop    %ebp
  a4:	c3                   	ret    

000000a5 <strlen>:

uint
strlen(const char *s)
{
  a5:	55                   	push   %ebp
  a6:	89 e5                	mov    %esp,%ebp
  a8:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  ab:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  b2:	eb 04                	jmp    b8 <strlen+0x13>
  b4:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
  b8:	8b 55 fc             	mov    -0x4(%ebp),%edx
  bb:	8b 45 08             	mov    0x8(%ebp),%eax
  be:	01 d0                	add    %edx,%eax
  c0:	0f b6 00             	movzbl (%eax),%eax
  c3:	84 c0                	test   %al,%al
  c5:	75 ed                	jne    b4 <strlen+0xf>
    ;
  return n;
  c7:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  ca:	c9                   	leave  
  cb:	c3                   	ret    

000000cc <memset>:

void*
memset(void *dst, int c, uint n)
{
  cc:	55                   	push   %ebp
  cd:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
  cf:	8b 45 10             	mov    0x10(%ebp),%eax
  d2:	50                   	push   %eax
  d3:	ff 75 0c             	push   0xc(%ebp)
  d6:	ff 75 08             	push   0x8(%ebp)
  d9:	e8 32 ff ff ff       	call   10 <stosb>
  de:	83 c4 0c             	add    $0xc,%esp
  return dst;
  e1:	8b 45 08             	mov    0x8(%ebp),%eax
}
  e4:	c9                   	leave  
  e5:	c3                   	ret    

000000e6 <strchr>:

char*
strchr(const char *s, char c)
{
  e6:	55                   	push   %ebp
  e7:	89 e5                	mov    %esp,%ebp
  e9:	83 ec 04             	sub    $0x4,%esp
  ec:	8b 45 0c             	mov    0xc(%ebp),%eax
  ef:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
  f2:	eb 14                	jmp    108 <strchr+0x22>
    if(*s == c)
  f4:	8b 45 08             	mov    0x8(%ebp),%eax
  f7:	0f b6 00             	movzbl (%eax),%eax
  fa:	38 45 fc             	cmp    %al,-0x4(%ebp)
  fd:	75 05                	jne    104 <strchr+0x1e>
      return (char*)s;
  ff:	8b 45 08             	mov    0x8(%ebp),%eax
 102:	eb 13                	jmp    117 <strchr+0x31>
  for(; *s; s++)
 104:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 108:	8b 45 08             	mov    0x8(%ebp),%eax
 10b:	0f b6 00             	movzbl (%eax),%eax
 10e:	84 c0                	test   %al,%al
 110:	75 e2                	jne    f4 <strchr+0xe>
  return 0;
 112:	b8 00 00 00 00       	mov    $0x0,%eax
}
 117:	c9                   	leave  
 118:	c3                   	ret    

00000119 <gets>:

char*
gets(char *buf, int max)
{
 119:	55                   	push   %ebp
 11a:	89 e5                	mov    %esp,%ebp
 11c:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 11f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 126:	eb 42                	jmp    16a <gets+0x51>
    cc = read(0, &c, 1);
 128:	83 ec 04             	sub    $0x4,%esp
 12b:	6a 01                	push   $0x1
 12d:	8d 45 ef             	lea    -0x11(%ebp),%eax
 130:	50                   	push   %eax
 131:	6a 00                	push   $0x0
 133:	e8 a2 01 00 00       	call   2da <read>
 138:	83 c4 10             	add    $0x10,%esp
 13b:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 13e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 142:	7e 33                	jle    177 <gets+0x5e>
      break;
    buf[i++] = c;
 144:	8b 45 f4             	mov    -0xc(%ebp),%eax
 147:	8d 50 01             	lea    0x1(%eax),%edx
 14a:	89 55 f4             	mov    %edx,-0xc(%ebp)
 14d:	89 c2                	mov    %eax,%edx
 14f:	8b 45 08             	mov    0x8(%ebp),%eax
 152:	01 c2                	add    %eax,%edx
 154:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 158:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 15a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 15e:	3c 0a                	cmp    $0xa,%al
 160:	74 16                	je     178 <gets+0x5f>
 162:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 166:	3c 0d                	cmp    $0xd,%al
 168:	74 0e                	je     178 <gets+0x5f>
  for(i=0; i+1 < max; ){
 16a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 16d:	83 c0 01             	add    $0x1,%eax
 170:	39 45 0c             	cmp    %eax,0xc(%ebp)
 173:	7f b3                	jg     128 <gets+0xf>
 175:	eb 01                	jmp    178 <gets+0x5f>
      break;
 177:	90                   	nop
      break;
  }
  buf[i] = '\0';
 178:	8b 55 f4             	mov    -0xc(%ebp),%edx
 17b:	8b 45 08             	mov    0x8(%ebp),%eax
 17e:	01 d0                	add    %edx,%eax
 180:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 183:	8b 45 08             	mov    0x8(%ebp),%eax
}
 186:	c9                   	leave  
 187:	c3                   	ret    

00000188 <stat>:

int
stat(const char *n, struct stat *st)
{
 188:	55                   	push   %ebp
 189:	89 e5                	mov    %esp,%ebp
 18b:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 18e:	83 ec 08             	sub    $0x8,%esp
 191:	6a 00                	push   $0x0
 193:	ff 75 08             	push   0x8(%ebp)
 196:	e8 67 01 00 00       	call   302 <open>
 19b:	83 c4 10             	add    $0x10,%esp
 19e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1a5:	79 07                	jns    1ae <stat+0x26>
    return -1;
 1a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1ac:	eb 25                	jmp    1d3 <stat+0x4b>
  r = fstat(fd, st);
 1ae:	83 ec 08             	sub    $0x8,%esp
 1b1:	ff 75 0c             	push   0xc(%ebp)
 1b4:	ff 75 f4             	push   -0xc(%ebp)
 1b7:	e8 5e 01 00 00       	call   31a <fstat>
 1bc:	83 c4 10             	add    $0x10,%esp
 1bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 1c2:	83 ec 0c             	sub    $0xc,%esp
 1c5:	ff 75 f4             	push   -0xc(%ebp)
 1c8:	e8 1d 01 00 00       	call   2ea <close>
 1cd:	83 c4 10             	add    $0x10,%esp
  return r;
 1d0:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 1d3:	c9                   	leave  
 1d4:	c3                   	ret    

000001d5 <atoi>:

int
atoi(const char *s)
{
 1d5:	55                   	push   %ebp
 1d6:	89 e5                	mov    %esp,%ebp
 1d8:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 1db:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 1e2:	eb 25                	jmp    209 <atoi+0x34>
    n = n*10 + *s++ - '0';
 1e4:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1e7:	89 d0                	mov    %edx,%eax
 1e9:	c1 e0 02             	shl    $0x2,%eax
 1ec:	01 d0                	add    %edx,%eax
 1ee:	01 c0                	add    %eax,%eax
 1f0:	89 c1                	mov    %eax,%ecx
 1f2:	8b 45 08             	mov    0x8(%ebp),%eax
 1f5:	8d 50 01             	lea    0x1(%eax),%edx
 1f8:	89 55 08             	mov    %edx,0x8(%ebp)
 1fb:	0f b6 00             	movzbl (%eax),%eax
 1fe:	0f be c0             	movsbl %al,%eax
 201:	01 c8                	add    %ecx,%eax
 203:	83 e8 30             	sub    $0x30,%eax
 206:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 209:	8b 45 08             	mov    0x8(%ebp),%eax
 20c:	0f b6 00             	movzbl (%eax),%eax
 20f:	3c 2f                	cmp    $0x2f,%al
 211:	7e 0a                	jle    21d <atoi+0x48>
 213:	8b 45 08             	mov    0x8(%ebp),%eax
 216:	0f b6 00             	movzbl (%eax),%eax
 219:	3c 39                	cmp    $0x39,%al
 21b:	7e c7                	jle    1e4 <atoi+0xf>
  return n;
 21d:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 220:	c9                   	leave  
 221:	c3                   	ret    

00000222 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 222:	55                   	push   %ebp
 223:	89 e5                	mov    %esp,%ebp
 225:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
 228:	8b 45 08             	mov    0x8(%ebp),%eax
 22b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 22e:	8b 45 0c             	mov    0xc(%ebp),%eax
 231:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 234:	eb 17                	jmp    24d <memmove+0x2b>
    *dst++ = *src++;
 236:	8b 55 f8             	mov    -0x8(%ebp),%edx
 239:	8d 42 01             	lea    0x1(%edx),%eax
 23c:	89 45 f8             	mov    %eax,-0x8(%ebp)
 23f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 242:	8d 48 01             	lea    0x1(%eax),%ecx
 245:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 248:	0f b6 12             	movzbl (%edx),%edx
 24b:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 24d:	8b 45 10             	mov    0x10(%ebp),%eax
 250:	8d 50 ff             	lea    -0x1(%eax),%edx
 253:	89 55 10             	mov    %edx,0x10(%ebp)
 256:	85 c0                	test   %eax,%eax
 258:	7f dc                	jg     236 <memmove+0x14>
  return vdst;
 25a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 25d:	c9                   	leave  
 25e:	c3                   	ret    

0000025f <calc>:

int calc(int num)
{
 25f:	55                   	push   %ebp
 260:	89 e5                	mov    %esp,%ebp
 262:	83 ec 10             	sub    $0x10,%esp
    int c = 0;
 265:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for(uint i = 0; i < num; i++)
 26c:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
 273:	eb 36                	jmp    2ab <calc+0x4c>
    {
        for(uint j = 0; j < num; j++)
 275:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 27c:	eb 21                	jmp    29f <calc+0x40>
        {
            for(uint k = 0; k < num; j++)
 27e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 285:	eb 0c                	jmp    293 <calc+0x34>
            {
                c >>= 10;
 287:	c1 7d fc 0a          	sarl   $0xa,-0x4(%ebp)
                c <<= 10;
 28b:	c1 65 fc 0a          	shll   $0xa,-0x4(%ebp)
            for(uint k = 0; k < num; j++)
 28f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 293:	8b 45 08             	mov    0x8(%ebp),%eax
 296:	39 45 f0             	cmp    %eax,-0x10(%ebp)
 299:	72 ec                	jb     287 <calc+0x28>
        for(uint j = 0; j < num; j++)
 29b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 29f:	8b 45 08             	mov    0x8(%ebp),%eax
 2a2:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 2a5:	72 d7                	jb     27e <calc+0x1f>
    for(uint i = 0; i < num; i++)
 2a7:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 2ab:	8b 45 08             	mov    0x8(%ebp),%eax
 2ae:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 2b1:	72 c2                	jb     275 <calc+0x16>
            }
        }
    }
    return 0;
 2b3:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2b8:	c9                   	leave  
 2b9:	c3                   	ret    

000002ba <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2ba:	b8 01 00 00 00       	mov    $0x1,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <exit>:
SYSCALL(exit)
 2c2:	b8 02 00 00 00       	mov    $0x2,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <wait>:
SYSCALL(wait)
 2ca:	b8 03 00 00 00       	mov    $0x3,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <pipe>:
SYSCALL(pipe)
 2d2:	b8 04 00 00 00       	mov    $0x4,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <read>:
SYSCALL(read)
 2da:	b8 05 00 00 00       	mov    $0x5,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <write>:
SYSCALL(write)
 2e2:	b8 10 00 00 00       	mov    $0x10,%eax
 2e7:	cd 40                	int    $0x40
 2e9:	c3                   	ret    

000002ea <close>:
SYSCALL(close)
 2ea:	b8 15 00 00 00       	mov    $0x15,%eax
 2ef:	cd 40                	int    $0x40
 2f1:	c3                   	ret    

000002f2 <kill>:
SYSCALL(kill)
 2f2:	b8 06 00 00 00       	mov    $0x6,%eax
 2f7:	cd 40                	int    $0x40
 2f9:	c3                   	ret    

000002fa <exec>:
SYSCALL(exec)
 2fa:	b8 07 00 00 00       	mov    $0x7,%eax
 2ff:	cd 40                	int    $0x40
 301:	c3                   	ret    

00000302 <open>:
SYSCALL(open)
 302:	b8 0f 00 00 00       	mov    $0xf,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <mknod>:
SYSCALL(mknod)
 30a:	b8 11 00 00 00       	mov    $0x11,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <unlink>:
SYSCALL(unlink)
 312:	b8 12 00 00 00       	mov    $0x12,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <fstat>:
SYSCALL(fstat)
 31a:	b8 08 00 00 00       	mov    $0x8,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <link>:
SYSCALL(link)
 322:	b8 13 00 00 00       	mov    $0x13,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <mkdir>:
SYSCALL(mkdir)
 32a:	b8 14 00 00 00       	mov    $0x14,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <chdir>:
SYSCALL(chdir)
 332:	b8 09 00 00 00       	mov    $0x9,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <dup>:
SYSCALL(dup)
 33a:	b8 0a 00 00 00       	mov    $0xa,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <getpid>:
SYSCALL(getpid)
 342:	b8 0b 00 00 00       	mov    $0xb,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <sbrk>:
SYSCALL(sbrk)
 34a:	b8 0c 00 00 00       	mov    $0xc,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <sleep>:
SYSCALL(sleep)
 352:	b8 0d 00 00 00       	mov    $0xd,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <uptime>:
SYSCALL(uptime)
 35a:	b8 0e 00 00 00       	mov    $0xe,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <print_proc>:
SYSCALL(print_proc)
 362:	b8 16 00 00 00       	mov    $0x16,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <change_queue>:
 36a:	b8 17 00 00 00       	mov    $0x17,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 372:	55                   	push   %ebp
 373:	89 e5                	mov    %esp,%ebp
 375:	83 ec 18             	sub    $0x18,%esp
 378:	8b 45 0c             	mov    0xc(%ebp),%eax
 37b:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 37e:	83 ec 04             	sub    $0x4,%esp
 381:	6a 01                	push   $0x1
 383:	8d 45 f4             	lea    -0xc(%ebp),%eax
 386:	50                   	push   %eax
 387:	ff 75 08             	push   0x8(%ebp)
 38a:	e8 53 ff ff ff       	call   2e2 <write>
 38f:	83 c4 10             	add    $0x10,%esp
}
 392:	90                   	nop
 393:	c9                   	leave  
 394:	c3                   	ret    

00000395 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 395:	55                   	push   %ebp
 396:	89 e5                	mov    %esp,%ebp
 398:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 39b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3a2:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3a6:	74 17                	je     3bf <printint+0x2a>
 3a8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3ac:	79 11                	jns    3bf <printint+0x2a>
    neg = 1;
 3ae:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3b5:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b8:	f7 d8                	neg    %eax
 3ba:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3bd:	eb 06                	jmp    3c5 <printint+0x30>
  } else {
    x = xx;
 3bf:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3c5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3cc:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3cf:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3d2:	ba 00 00 00 00       	mov    $0x0,%edx
 3d7:	f7 f1                	div    %ecx
 3d9:	89 d1                	mov    %edx,%ecx
 3db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3de:	8d 50 01             	lea    0x1(%eax),%edx
 3e1:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3e4:	0f b6 91 60 0a 00 00 	movzbl 0xa60(%ecx),%edx
 3eb:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 3ef:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3f2:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3f5:	ba 00 00 00 00       	mov    $0x0,%edx
 3fa:	f7 f1                	div    %ecx
 3fc:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3ff:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 403:	75 c7                	jne    3cc <printint+0x37>
  if(neg)
 405:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 409:	74 2d                	je     438 <printint+0xa3>
    buf[i++] = '-';
 40b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 40e:	8d 50 01             	lea    0x1(%eax),%edx
 411:	89 55 f4             	mov    %edx,-0xc(%ebp)
 414:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 419:	eb 1d                	jmp    438 <printint+0xa3>
    putc(fd, buf[i]);
 41b:	8d 55 dc             	lea    -0x24(%ebp),%edx
 41e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 421:	01 d0                	add    %edx,%eax
 423:	0f b6 00             	movzbl (%eax),%eax
 426:	0f be c0             	movsbl %al,%eax
 429:	83 ec 08             	sub    $0x8,%esp
 42c:	50                   	push   %eax
 42d:	ff 75 08             	push   0x8(%ebp)
 430:	e8 3d ff ff ff       	call   372 <putc>
 435:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 438:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 43c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 440:	79 d9                	jns    41b <printint+0x86>
}
 442:	90                   	nop
 443:	90                   	nop
 444:	c9                   	leave  
 445:	c3                   	ret    

00000446 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 446:	55                   	push   %ebp
 447:	89 e5                	mov    %esp,%ebp
 449:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 44c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 453:	8d 45 0c             	lea    0xc(%ebp),%eax
 456:	83 c0 04             	add    $0x4,%eax
 459:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 45c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 463:	e9 59 01 00 00       	jmp    5c1 <printf+0x17b>
    c = fmt[i] & 0xff;
 468:	8b 55 0c             	mov    0xc(%ebp),%edx
 46b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 46e:	01 d0                	add    %edx,%eax
 470:	0f b6 00             	movzbl (%eax),%eax
 473:	0f be c0             	movsbl %al,%eax
 476:	25 ff 00 00 00       	and    $0xff,%eax
 47b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 47e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 482:	75 2c                	jne    4b0 <printf+0x6a>
      if(c == '%'){
 484:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 488:	75 0c                	jne    496 <printf+0x50>
        state = '%';
 48a:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 491:	e9 27 01 00 00       	jmp    5bd <printf+0x177>
      } else {
        putc(fd, c);
 496:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 499:	0f be c0             	movsbl %al,%eax
 49c:	83 ec 08             	sub    $0x8,%esp
 49f:	50                   	push   %eax
 4a0:	ff 75 08             	push   0x8(%ebp)
 4a3:	e8 ca fe ff ff       	call   372 <putc>
 4a8:	83 c4 10             	add    $0x10,%esp
 4ab:	e9 0d 01 00 00       	jmp    5bd <printf+0x177>
      }
    } else if(state == '%'){
 4b0:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4b4:	0f 85 03 01 00 00    	jne    5bd <printf+0x177>
      if(c == 'd'){
 4ba:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4be:	75 1e                	jne    4de <printf+0x98>
        printint(fd, *ap, 10, 1);
 4c0:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4c3:	8b 00                	mov    (%eax),%eax
 4c5:	6a 01                	push   $0x1
 4c7:	6a 0a                	push   $0xa
 4c9:	50                   	push   %eax
 4ca:	ff 75 08             	push   0x8(%ebp)
 4cd:	e8 c3 fe ff ff       	call   395 <printint>
 4d2:	83 c4 10             	add    $0x10,%esp
        ap++;
 4d5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4d9:	e9 d8 00 00 00       	jmp    5b6 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4de:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4e2:	74 06                	je     4ea <printf+0xa4>
 4e4:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4e8:	75 1e                	jne    508 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 4ea:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4ed:	8b 00                	mov    (%eax),%eax
 4ef:	6a 00                	push   $0x0
 4f1:	6a 10                	push   $0x10
 4f3:	50                   	push   %eax
 4f4:	ff 75 08             	push   0x8(%ebp)
 4f7:	e8 99 fe ff ff       	call   395 <printint>
 4fc:	83 c4 10             	add    $0x10,%esp
        ap++;
 4ff:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 503:	e9 ae 00 00 00       	jmp    5b6 <printf+0x170>
      } else if(c == 's'){
 508:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 50c:	75 43                	jne    551 <printf+0x10b>
        s = (char*)*ap;
 50e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 511:	8b 00                	mov    (%eax),%eax
 513:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 516:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 51a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 51e:	75 25                	jne    545 <printf+0xff>
          s = "(null)";
 520:	c7 45 f4 fd 07 00 00 	movl   $0x7fd,-0xc(%ebp)
        while(*s != 0){
 527:	eb 1c                	jmp    545 <printf+0xff>
          putc(fd, *s);
 529:	8b 45 f4             	mov    -0xc(%ebp),%eax
 52c:	0f b6 00             	movzbl (%eax),%eax
 52f:	0f be c0             	movsbl %al,%eax
 532:	83 ec 08             	sub    $0x8,%esp
 535:	50                   	push   %eax
 536:	ff 75 08             	push   0x8(%ebp)
 539:	e8 34 fe ff ff       	call   372 <putc>
 53e:	83 c4 10             	add    $0x10,%esp
          s++;
 541:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 545:	8b 45 f4             	mov    -0xc(%ebp),%eax
 548:	0f b6 00             	movzbl (%eax),%eax
 54b:	84 c0                	test   %al,%al
 54d:	75 da                	jne    529 <printf+0xe3>
 54f:	eb 65                	jmp    5b6 <printf+0x170>
        }
      } else if(c == 'c'){
 551:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 555:	75 1d                	jne    574 <printf+0x12e>
        putc(fd, *ap);
 557:	8b 45 e8             	mov    -0x18(%ebp),%eax
 55a:	8b 00                	mov    (%eax),%eax
 55c:	0f be c0             	movsbl %al,%eax
 55f:	83 ec 08             	sub    $0x8,%esp
 562:	50                   	push   %eax
 563:	ff 75 08             	push   0x8(%ebp)
 566:	e8 07 fe ff ff       	call   372 <putc>
 56b:	83 c4 10             	add    $0x10,%esp
        ap++;
 56e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 572:	eb 42                	jmp    5b6 <printf+0x170>
      } else if(c == '%'){
 574:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 578:	75 17                	jne    591 <printf+0x14b>
        putc(fd, c);
 57a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 57d:	0f be c0             	movsbl %al,%eax
 580:	83 ec 08             	sub    $0x8,%esp
 583:	50                   	push   %eax
 584:	ff 75 08             	push   0x8(%ebp)
 587:	e8 e6 fd ff ff       	call   372 <putc>
 58c:	83 c4 10             	add    $0x10,%esp
 58f:	eb 25                	jmp    5b6 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 591:	83 ec 08             	sub    $0x8,%esp
 594:	6a 25                	push   $0x25
 596:	ff 75 08             	push   0x8(%ebp)
 599:	e8 d4 fd ff ff       	call   372 <putc>
 59e:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5a1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5a4:	0f be c0             	movsbl %al,%eax
 5a7:	83 ec 08             	sub    $0x8,%esp
 5aa:	50                   	push   %eax
 5ab:	ff 75 08             	push   0x8(%ebp)
 5ae:	e8 bf fd ff ff       	call   372 <putc>
 5b3:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5b6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 5bd:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5c1:	8b 55 0c             	mov    0xc(%ebp),%edx
 5c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5c7:	01 d0                	add    %edx,%eax
 5c9:	0f b6 00             	movzbl (%eax),%eax
 5cc:	84 c0                	test   %al,%al
 5ce:	0f 85 94 fe ff ff    	jne    468 <printf+0x22>
    }
  }
}
 5d4:	90                   	nop
 5d5:	90                   	nop
 5d6:	c9                   	leave  
 5d7:	c3                   	ret    

000005d8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5d8:	55                   	push   %ebp
 5d9:	89 e5                	mov    %esp,%ebp
 5db:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5de:	8b 45 08             	mov    0x8(%ebp),%eax
 5e1:	83 e8 08             	sub    $0x8,%eax
 5e4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5e7:	a1 7c 0a 00 00       	mov    0xa7c,%eax
 5ec:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5ef:	eb 24                	jmp    615 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 5f4:	8b 00                	mov    (%eax),%eax
 5f6:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 5f9:	72 12                	jb     60d <free+0x35>
 5fb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 5fe:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 601:	77 24                	ja     627 <free+0x4f>
 603:	8b 45 fc             	mov    -0x4(%ebp),%eax
 606:	8b 00                	mov    (%eax),%eax
 608:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 60b:	72 1a                	jb     627 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 60d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 610:	8b 00                	mov    (%eax),%eax
 612:	89 45 fc             	mov    %eax,-0x4(%ebp)
 615:	8b 45 f8             	mov    -0x8(%ebp),%eax
 618:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 61b:	76 d4                	jbe    5f1 <free+0x19>
 61d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 620:	8b 00                	mov    (%eax),%eax
 622:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 625:	73 ca                	jae    5f1 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 627:	8b 45 f8             	mov    -0x8(%ebp),%eax
 62a:	8b 40 04             	mov    0x4(%eax),%eax
 62d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 634:	8b 45 f8             	mov    -0x8(%ebp),%eax
 637:	01 c2                	add    %eax,%edx
 639:	8b 45 fc             	mov    -0x4(%ebp),%eax
 63c:	8b 00                	mov    (%eax),%eax
 63e:	39 c2                	cmp    %eax,%edx
 640:	75 24                	jne    666 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 642:	8b 45 f8             	mov    -0x8(%ebp),%eax
 645:	8b 50 04             	mov    0x4(%eax),%edx
 648:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64b:	8b 00                	mov    (%eax),%eax
 64d:	8b 40 04             	mov    0x4(%eax),%eax
 650:	01 c2                	add    %eax,%edx
 652:	8b 45 f8             	mov    -0x8(%ebp),%eax
 655:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 658:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65b:	8b 00                	mov    (%eax),%eax
 65d:	8b 10                	mov    (%eax),%edx
 65f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 662:	89 10                	mov    %edx,(%eax)
 664:	eb 0a                	jmp    670 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 666:	8b 45 fc             	mov    -0x4(%ebp),%eax
 669:	8b 10                	mov    (%eax),%edx
 66b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 66e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 670:	8b 45 fc             	mov    -0x4(%ebp),%eax
 673:	8b 40 04             	mov    0x4(%eax),%eax
 676:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 67d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 680:	01 d0                	add    %edx,%eax
 682:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 685:	75 20                	jne    6a7 <free+0xcf>
    p->s.size += bp->s.size;
 687:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68a:	8b 50 04             	mov    0x4(%eax),%edx
 68d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 690:	8b 40 04             	mov    0x4(%eax),%eax
 693:	01 c2                	add    %eax,%edx
 695:	8b 45 fc             	mov    -0x4(%ebp),%eax
 698:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 69b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69e:	8b 10                	mov    (%eax),%edx
 6a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a3:	89 10                	mov    %edx,(%eax)
 6a5:	eb 08                	jmp    6af <free+0xd7>
  } else
    p->s.ptr = bp;
 6a7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6aa:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6ad:	89 10                	mov    %edx,(%eax)
  freep = p;
 6af:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b2:	a3 7c 0a 00 00       	mov    %eax,0xa7c
}
 6b7:	90                   	nop
 6b8:	c9                   	leave  
 6b9:	c3                   	ret    

000006ba <morecore>:

static Header*
morecore(uint nu)
{
 6ba:	55                   	push   %ebp
 6bb:	89 e5                	mov    %esp,%ebp
 6bd:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6c0:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6c7:	77 07                	ja     6d0 <morecore+0x16>
    nu = 4096;
 6c9:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6d0:	8b 45 08             	mov    0x8(%ebp),%eax
 6d3:	c1 e0 03             	shl    $0x3,%eax
 6d6:	83 ec 0c             	sub    $0xc,%esp
 6d9:	50                   	push   %eax
 6da:	e8 6b fc ff ff       	call   34a <sbrk>
 6df:	83 c4 10             	add    $0x10,%esp
 6e2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6e5:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6e9:	75 07                	jne    6f2 <morecore+0x38>
    return 0;
 6eb:	b8 00 00 00 00       	mov    $0x0,%eax
 6f0:	eb 26                	jmp    718 <morecore+0x5e>
  hp = (Header*)p;
 6f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 6f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6fb:	8b 55 08             	mov    0x8(%ebp),%edx
 6fe:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 701:	8b 45 f0             	mov    -0x10(%ebp),%eax
 704:	83 c0 08             	add    $0x8,%eax
 707:	83 ec 0c             	sub    $0xc,%esp
 70a:	50                   	push   %eax
 70b:	e8 c8 fe ff ff       	call   5d8 <free>
 710:	83 c4 10             	add    $0x10,%esp
  return freep;
 713:	a1 7c 0a 00 00       	mov    0xa7c,%eax
}
 718:	c9                   	leave  
 719:	c3                   	ret    

0000071a <malloc>:

void*
malloc(uint nbytes)
{
 71a:	55                   	push   %ebp
 71b:	89 e5                	mov    %esp,%ebp
 71d:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 720:	8b 45 08             	mov    0x8(%ebp),%eax
 723:	83 c0 07             	add    $0x7,%eax
 726:	c1 e8 03             	shr    $0x3,%eax
 729:	83 c0 01             	add    $0x1,%eax
 72c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 72f:	a1 7c 0a 00 00       	mov    0xa7c,%eax
 734:	89 45 f0             	mov    %eax,-0x10(%ebp)
 737:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 73b:	75 23                	jne    760 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 73d:	c7 45 f0 74 0a 00 00 	movl   $0xa74,-0x10(%ebp)
 744:	8b 45 f0             	mov    -0x10(%ebp),%eax
 747:	a3 7c 0a 00 00       	mov    %eax,0xa7c
 74c:	a1 7c 0a 00 00       	mov    0xa7c,%eax
 751:	a3 74 0a 00 00       	mov    %eax,0xa74
    base.s.size = 0;
 756:	c7 05 78 0a 00 00 00 	movl   $0x0,0xa78
 75d:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 760:	8b 45 f0             	mov    -0x10(%ebp),%eax
 763:	8b 00                	mov    (%eax),%eax
 765:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 768:	8b 45 f4             	mov    -0xc(%ebp),%eax
 76b:	8b 40 04             	mov    0x4(%eax),%eax
 76e:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 771:	77 4d                	ja     7c0 <malloc+0xa6>
      if(p->s.size == nunits)
 773:	8b 45 f4             	mov    -0xc(%ebp),%eax
 776:	8b 40 04             	mov    0x4(%eax),%eax
 779:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 77c:	75 0c                	jne    78a <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 77e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 781:	8b 10                	mov    (%eax),%edx
 783:	8b 45 f0             	mov    -0x10(%ebp),%eax
 786:	89 10                	mov    %edx,(%eax)
 788:	eb 26                	jmp    7b0 <malloc+0x96>
      else {
        p->s.size -= nunits;
 78a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 78d:	8b 40 04             	mov    0x4(%eax),%eax
 790:	2b 45 ec             	sub    -0x14(%ebp),%eax
 793:	89 c2                	mov    %eax,%edx
 795:	8b 45 f4             	mov    -0xc(%ebp),%eax
 798:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 79b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79e:	8b 40 04             	mov    0x4(%eax),%eax
 7a1:	c1 e0 03             	shl    $0x3,%eax
 7a4:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7aa:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7ad:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b3:	a3 7c 0a 00 00       	mov    %eax,0xa7c
      return (void*)(p + 1);
 7b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7bb:	83 c0 08             	add    $0x8,%eax
 7be:	eb 3b                	jmp    7fb <malloc+0xe1>
    }
    if(p == freep)
 7c0:	a1 7c 0a 00 00       	mov    0xa7c,%eax
 7c5:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7c8:	75 1e                	jne    7e8 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7ca:	83 ec 0c             	sub    $0xc,%esp
 7cd:	ff 75 ec             	push   -0x14(%ebp)
 7d0:	e8 e5 fe ff ff       	call   6ba <morecore>
 7d5:	83 c4 10             	add    $0x10,%esp
 7d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7db:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7df:	75 07                	jne    7e8 <malloc+0xce>
        return 0;
 7e1:	b8 00 00 00 00       	mov    $0x0,%eax
 7e6:	eb 13                	jmp    7fb <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7eb:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f1:	8b 00                	mov    (%eax),%eax
 7f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7f6:	e9 6d ff ff ff       	jmp    768 <malloc+0x4e>
  }
}
 7fb:	c9                   	leave  
 7fc:	c3                   	ret    
