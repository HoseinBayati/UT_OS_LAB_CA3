
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
SYSCALL(change_queue)
 36a:	b8 17 00 00 00       	mov    $0x17,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <change_local_bjf>:
SYSCALL(change_local_bjf)
 372:	b8 18 00 00 00       	mov    $0x18,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <change_global_bjf>:
SYSCALL(change_global_bjf)
 37a:	b8 19 00 00 00       	mov    $0x19,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 382:	55                   	push   %ebp
 383:	89 e5                	mov    %esp,%ebp
 385:	83 ec 18             	sub    $0x18,%esp
 388:	8b 45 0c             	mov    0xc(%ebp),%eax
 38b:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 38e:	83 ec 04             	sub    $0x4,%esp
 391:	6a 01                	push   $0x1
 393:	8d 45 f4             	lea    -0xc(%ebp),%eax
 396:	50                   	push   %eax
 397:	ff 75 08             	push   0x8(%ebp)
 39a:	e8 43 ff ff ff       	call   2e2 <write>
 39f:	83 c4 10             	add    $0x10,%esp
}
 3a2:	90                   	nop
 3a3:	c9                   	leave  
 3a4:	c3                   	ret    

000003a5 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3a5:	55                   	push   %ebp
 3a6:	89 e5                	mov    %esp,%ebp
 3a8:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3ab:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3b2:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3b6:	74 17                	je     3cf <printint+0x2a>
 3b8:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 3bc:	79 11                	jns    3cf <printint+0x2a>
    neg = 1;
 3be:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 3c5:	8b 45 0c             	mov    0xc(%ebp),%eax
 3c8:	f7 d8                	neg    %eax
 3ca:	89 45 ec             	mov    %eax,-0x14(%ebp)
 3cd:	eb 06                	jmp    3d5 <printint+0x30>
  } else {
    x = xx;
 3cf:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d2:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 3d5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 3dc:	8b 4d 10             	mov    0x10(%ebp),%ecx
 3df:	8b 45 ec             	mov    -0x14(%ebp),%eax
 3e2:	ba 00 00 00 00       	mov    $0x0,%edx
 3e7:	f7 f1                	div    %ecx
 3e9:	89 d1                	mov    %edx,%ecx
 3eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 3ee:	8d 50 01             	lea    0x1(%eax),%edx
 3f1:	89 55 f4             	mov    %edx,-0xc(%ebp)
 3f4:	0f b6 91 70 0a 00 00 	movzbl 0xa70(%ecx),%edx
 3fb:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 3ff:	8b 4d 10             	mov    0x10(%ebp),%ecx
 402:	8b 45 ec             	mov    -0x14(%ebp),%eax
 405:	ba 00 00 00 00       	mov    $0x0,%edx
 40a:	f7 f1                	div    %ecx
 40c:	89 45 ec             	mov    %eax,-0x14(%ebp)
 40f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 413:	75 c7                	jne    3dc <printint+0x37>
  if(neg)
 415:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 419:	74 2d                	je     448 <printint+0xa3>
    buf[i++] = '-';
 41b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 41e:	8d 50 01             	lea    0x1(%eax),%edx
 421:	89 55 f4             	mov    %edx,-0xc(%ebp)
 424:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 429:	eb 1d                	jmp    448 <printint+0xa3>
    putc(fd, buf[i]);
 42b:	8d 55 dc             	lea    -0x24(%ebp),%edx
 42e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 431:	01 d0                	add    %edx,%eax
 433:	0f b6 00             	movzbl (%eax),%eax
 436:	0f be c0             	movsbl %al,%eax
 439:	83 ec 08             	sub    $0x8,%esp
 43c:	50                   	push   %eax
 43d:	ff 75 08             	push   0x8(%ebp)
 440:	e8 3d ff ff ff       	call   382 <putc>
 445:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 448:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 44c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 450:	79 d9                	jns    42b <printint+0x86>
}
 452:	90                   	nop
 453:	90                   	nop
 454:	c9                   	leave  
 455:	c3                   	ret    

00000456 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 456:	55                   	push   %ebp
 457:	89 e5                	mov    %esp,%ebp
 459:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 45c:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 463:	8d 45 0c             	lea    0xc(%ebp),%eax
 466:	83 c0 04             	add    $0x4,%eax
 469:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 46c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 473:	e9 59 01 00 00       	jmp    5d1 <printf+0x17b>
    c = fmt[i] & 0xff;
 478:	8b 55 0c             	mov    0xc(%ebp),%edx
 47b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 47e:	01 d0                	add    %edx,%eax
 480:	0f b6 00             	movzbl (%eax),%eax
 483:	0f be c0             	movsbl %al,%eax
 486:	25 ff 00 00 00       	and    $0xff,%eax
 48b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 48e:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 492:	75 2c                	jne    4c0 <printf+0x6a>
      if(c == '%'){
 494:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 498:	75 0c                	jne    4a6 <printf+0x50>
        state = '%';
 49a:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4a1:	e9 27 01 00 00       	jmp    5cd <printf+0x177>
      } else {
        putc(fd, c);
 4a6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4a9:	0f be c0             	movsbl %al,%eax
 4ac:	83 ec 08             	sub    $0x8,%esp
 4af:	50                   	push   %eax
 4b0:	ff 75 08             	push   0x8(%ebp)
 4b3:	e8 ca fe ff ff       	call   382 <putc>
 4b8:	83 c4 10             	add    $0x10,%esp
 4bb:	e9 0d 01 00 00       	jmp    5cd <printf+0x177>
      }
    } else if(state == '%'){
 4c0:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 4c4:	0f 85 03 01 00 00    	jne    5cd <printf+0x177>
      if(c == 'd'){
 4ca:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 4ce:	75 1e                	jne    4ee <printf+0x98>
        printint(fd, *ap, 10, 1);
 4d0:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4d3:	8b 00                	mov    (%eax),%eax
 4d5:	6a 01                	push   $0x1
 4d7:	6a 0a                	push   $0xa
 4d9:	50                   	push   %eax
 4da:	ff 75 08             	push   0x8(%ebp)
 4dd:	e8 c3 fe ff ff       	call   3a5 <printint>
 4e2:	83 c4 10             	add    $0x10,%esp
        ap++;
 4e5:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 4e9:	e9 d8 00 00 00       	jmp    5c6 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 4ee:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 4f2:	74 06                	je     4fa <printf+0xa4>
 4f4:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 4f8:	75 1e                	jne    518 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 4fa:	8b 45 e8             	mov    -0x18(%ebp),%eax
 4fd:	8b 00                	mov    (%eax),%eax
 4ff:	6a 00                	push   $0x0
 501:	6a 10                	push   $0x10
 503:	50                   	push   %eax
 504:	ff 75 08             	push   0x8(%ebp)
 507:	e8 99 fe ff ff       	call   3a5 <printint>
 50c:	83 c4 10             	add    $0x10,%esp
        ap++;
 50f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 513:	e9 ae 00 00 00       	jmp    5c6 <printf+0x170>
      } else if(c == 's'){
 518:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 51c:	75 43                	jne    561 <printf+0x10b>
        s = (char*)*ap;
 51e:	8b 45 e8             	mov    -0x18(%ebp),%eax
 521:	8b 00                	mov    (%eax),%eax
 523:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 526:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 52a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 52e:	75 25                	jne    555 <printf+0xff>
          s = "(null)";
 530:	c7 45 f4 0d 08 00 00 	movl   $0x80d,-0xc(%ebp)
        while(*s != 0){
 537:	eb 1c                	jmp    555 <printf+0xff>
          putc(fd, *s);
 539:	8b 45 f4             	mov    -0xc(%ebp),%eax
 53c:	0f b6 00             	movzbl (%eax),%eax
 53f:	0f be c0             	movsbl %al,%eax
 542:	83 ec 08             	sub    $0x8,%esp
 545:	50                   	push   %eax
 546:	ff 75 08             	push   0x8(%ebp)
 549:	e8 34 fe ff ff       	call   382 <putc>
 54e:	83 c4 10             	add    $0x10,%esp
          s++;
 551:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 555:	8b 45 f4             	mov    -0xc(%ebp),%eax
 558:	0f b6 00             	movzbl (%eax),%eax
 55b:	84 c0                	test   %al,%al
 55d:	75 da                	jne    539 <printf+0xe3>
 55f:	eb 65                	jmp    5c6 <printf+0x170>
        }
      } else if(c == 'c'){
 561:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 565:	75 1d                	jne    584 <printf+0x12e>
        putc(fd, *ap);
 567:	8b 45 e8             	mov    -0x18(%ebp),%eax
 56a:	8b 00                	mov    (%eax),%eax
 56c:	0f be c0             	movsbl %al,%eax
 56f:	83 ec 08             	sub    $0x8,%esp
 572:	50                   	push   %eax
 573:	ff 75 08             	push   0x8(%ebp)
 576:	e8 07 fe ff ff       	call   382 <putc>
 57b:	83 c4 10             	add    $0x10,%esp
        ap++;
 57e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 582:	eb 42                	jmp    5c6 <printf+0x170>
      } else if(c == '%'){
 584:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 588:	75 17                	jne    5a1 <printf+0x14b>
        putc(fd, c);
 58a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 58d:	0f be c0             	movsbl %al,%eax
 590:	83 ec 08             	sub    $0x8,%esp
 593:	50                   	push   %eax
 594:	ff 75 08             	push   0x8(%ebp)
 597:	e8 e6 fd ff ff       	call   382 <putc>
 59c:	83 c4 10             	add    $0x10,%esp
 59f:	eb 25                	jmp    5c6 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5a1:	83 ec 08             	sub    $0x8,%esp
 5a4:	6a 25                	push   $0x25
 5a6:	ff 75 08             	push   0x8(%ebp)
 5a9:	e8 d4 fd ff ff       	call   382 <putc>
 5ae:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5b1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5b4:	0f be c0             	movsbl %al,%eax
 5b7:	83 ec 08             	sub    $0x8,%esp
 5ba:	50                   	push   %eax
 5bb:	ff 75 08             	push   0x8(%ebp)
 5be:	e8 bf fd ff ff       	call   382 <putc>
 5c3:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 5c6:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 5cd:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 5d1:	8b 55 0c             	mov    0xc(%ebp),%edx
 5d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5d7:	01 d0                	add    %edx,%eax
 5d9:	0f b6 00             	movzbl (%eax),%eax
 5dc:	84 c0                	test   %al,%al
 5de:	0f 85 94 fe ff ff    	jne    478 <printf+0x22>
    }
  }
}
 5e4:	90                   	nop
 5e5:	90                   	nop
 5e6:	c9                   	leave  
 5e7:	c3                   	ret    

000005e8 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5e8:	55                   	push   %ebp
 5e9:	89 e5                	mov    %esp,%ebp
 5eb:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5ee:	8b 45 08             	mov    0x8(%ebp),%eax
 5f1:	83 e8 08             	sub    $0x8,%eax
 5f4:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f7:	a1 8c 0a 00 00       	mov    0xa8c,%eax
 5fc:	89 45 fc             	mov    %eax,-0x4(%ebp)
 5ff:	eb 24                	jmp    625 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 601:	8b 45 fc             	mov    -0x4(%ebp),%eax
 604:	8b 00                	mov    (%eax),%eax
 606:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 609:	72 12                	jb     61d <free+0x35>
 60b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 60e:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 611:	77 24                	ja     637 <free+0x4f>
 613:	8b 45 fc             	mov    -0x4(%ebp),%eax
 616:	8b 00                	mov    (%eax),%eax
 618:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 61b:	72 1a                	jb     637 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 61d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 620:	8b 00                	mov    (%eax),%eax
 622:	89 45 fc             	mov    %eax,-0x4(%ebp)
 625:	8b 45 f8             	mov    -0x8(%ebp),%eax
 628:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 62b:	76 d4                	jbe    601 <free+0x19>
 62d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 630:	8b 00                	mov    (%eax),%eax
 632:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 635:	73 ca                	jae    601 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 637:	8b 45 f8             	mov    -0x8(%ebp),%eax
 63a:	8b 40 04             	mov    0x4(%eax),%eax
 63d:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 644:	8b 45 f8             	mov    -0x8(%ebp),%eax
 647:	01 c2                	add    %eax,%edx
 649:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64c:	8b 00                	mov    (%eax),%eax
 64e:	39 c2                	cmp    %eax,%edx
 650:	75 24                	jne    676 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 652:	8b 45 f8             	mov    -0x8(%ebp),%eax
 655:	8b 50 04             	mov    0x4(%eax),%edx
 658:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65b:	8b 00                	mov    (%eax),%eax
 65d:	8b 40 04             	mov    0x4(%eax),%eax
 660:	01 c2                	add    %eax,%edx
 662:	8b 45 f8             	mov    -0x8(%ebp),%eax
 665:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 668:	8b 45 fc             	mov    -0x4(%ebp),%eax
 66b:	8b 00                	mov    (%eax),%eax
 66d:	8b 10                	mov    (%eax),%edx
 66f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 672:	89 10                	mov    %edx,(%eax)
 674:	eb 0a                	jmp    680 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 676:	8b 45 fc             	mov    -0x4(%ebp),%eax
 679:	8b 10                	mov    (%eax),%edx
 67b:	8b 45 f8             	mov    -0x8(%ebp),%eax
 67e:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 680:	8b 45 fc             	mov    -0x4(%ebp),%eax
 683:	8b 40 04             	mov    0x4(%eax),%eax
 686:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 68d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 690:	01 d0                	add    %edx,%eax
 692:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 695:	75 20                	jne    6b7 <free+0xcf>
    p->s.size += bp->s.size;
 697:	8b 45 fc             	mov    -0x4(%ebp),%eax
 69a:	8b 50 04             	mov    0x4(%eax),%edx
 69d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a0:	8b 40 04             	mov    0x4(%eax),%eax
 6a3:	01 c2                	add    %eax,%edx
 6a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a8:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6ab:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ae:	8b 10                	mov    (%eax),%edx
 6b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b3:	89 10                	mov    %edx,(%eax)
 6b5:	eb 08                	jmp    6bf <free+0xd7>
  } else
    p->s.ptr = bp;
 6b7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6ba:	8b 55 f8             	mov    -0x8(%ebp),%edx
 6bd:	89 10                	mov    %edx,(%eax)
  freep = p;
 6bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c2:	a3 8c 0a 00 00       	mov    %eax,0xa8c
}
 6c7:	90                   	nop
 6c8:	c9                   	leave  
 6c9:	c3                   	ret    

000006ca <morecore>:

static Header*
morecore(uint nu)
{
 6ca:	55                   	push   %ebp
 6cb:	89 e5                	mov    %esp,%ebp
 6cd:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 6d0:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 6d7:	77 07                	ja     6e0 <morecore+0x16>
    nu = 4096;
 6d9:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 6e0:	8b 45 08             	mov    0x8(%ebp),%eax
 6e3:	c1 e0 03             	shl    $0x3,%eax
 6e6:	83 ec 0c             	sub    $0xc,%esp
 6e9:	50                   	push   %eax
 6ea:	e8 5b fc ff ff       	call   34a <sbrk>
 6ef:	83 c4 10             	add    $0x10,%esp
 6f2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 6f5:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 6f9:	75 07                	jne    702 <morecore+0x38>
    return 0;
 6fb:	b8 00 00 00 00       	mov    $0x0,%eax
 700:	eb 26                	jmp    728 <morecore+0x5e>
  hp = (Header*)p;
 702:	8b 45 f4             	mov    -0xc(%ebp),%eax
 705:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 708:	8b 45 f0             	mov    -0x10(%ebp),%eax
 70b:	8b 55 08             	mov    0x8(%ebp),%edx
 70e:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 711:	8b 45 f0             	mov    -0x10(%ebp),%eax
 714:	83 c0 08             	add    $0x8,%eax
 717:	83 ec 0c             	sub    $0xc,%esp
 71a:	50                   	push   %eax
 71b:	e8 c8 fe ff ff       	call   5e8 <free>
 720:	83 c4 10             	add    $0x10,%esp
  return freep;
 723:	a1 8c 0a 00 00       	mov    0xa8c,%eax
}
 728:	c9                   	leave  
 729:	c3                   	ret    

0000072a <malloc>:

void*
malloc(uint nbytes)
{
 72a:	55                   	push   %ebp
 72b:	89 e5                	mov    %esp,%ebp
 72d:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 730:	8b 45 08             	mov    0x8(%ebp),%eax
 733:	83 c0 07             	add    $0x7,%eax
 736:	c1 e8 03             	shr    $0x3,%eax
 739:	83 c0 01             	add    $0x1,%eax
 73c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 73f:	a1 8c 0a 00 00       	mov    0xa8c,%eax
 744:	89 45 f0             	mov    %eax,-0x10(%ebp)
 747:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 74b:	75 23                	jne    770 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 74d:	c7 45 f0 84 0a 00 00 	movl   $0xa84,-0x10(%ebp)
 754:	8b 45 f0             	mov    -0x10(%ebp),%eax
 757:	a3 8c 0a 00 00       	mov    %eax,0xa8c
 75c:	a1 8c 0a 00 00       	mov    0xa8c,%eax
 761:	a3 84 0a 00 00       	mov    %eax,0xa84
    base.s.size = 0;
 766:	c7 05 88 0a 00 00 00 	movl   $0x0,0xa88
 76d:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 770:	8b 45 f0             	mov    -0x10(%ebp),%eax
 773:	8b 00                	mov    (%eax),%eax
 775:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 778:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77b:	8b 40 04             	mov    0x4(%eax),%eax
 77e:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 781:	77 4d                	ja     7d0 <malloc+0xa6>
      if(p->s.size == nunits)
 783:	8b 45 f4             	mov    -0xc(%ebp),%eax
 786:	8b 40 04             	mov    0x4(%eax),%eax
 789:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 78c:	75 0c                	jne    79a <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 78e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 791:	8b 10                	mov    (%eax),%edx
 793:	8b 45 f0             	mov    -0x10(%ebp),%eax
 796:	89 10                	mov    %edx,(%eax)
 798:	eb 26                	jmp    7c0 <malloc+0x96>
      else {
        p->s.size -= nunits;
 79a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 79d:	8b 40 04             	mov    0x4(%eax),%eax
 7a0:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7a3:	89 c2                	mov    %eax,%edx
 7a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7a8:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ae:	8b 40 04             	mov    0x4(%eax),%eax
 7b1:	c1 e0 03             	shl    $0x3,%eax
 7b4:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ba:	8b 55 ec             	mov    -0x14(%ebp),%edx
 7bd:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 7c0:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7c3:	a3 8c 0a 00 00       	mov    %eax,0xa8c
      return (void*)(p + 1);
 7c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7cb:	83 c0 08             	add    $0x8,%eax
 7ce:	eb 3b                	jmp    80b <malloc+0xe1>
    }
    if(p == freep)
 7d0:	a1 8c 0a 00 00       	mov    0xa8c,%eax
 7d5:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 7d8:	75 1e                	jne    7f8 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 7da:	83 ec 0c             	sub    $0xc,%esp
 7dd:	ff 75 ec             	push   -0x14(%ebp)
 7e0:	e8 e5 fe ff ff       	call   6ca <morecore>
 7e5:	83 c4 10             	add    $0x10,%esp
 7e8:	89 45 f4             	mov    %eax,-0xc(%ebp)
 7eb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 7ef:	75 07                	jne    7f8 <malloc+0xce>
        return 0;
 7f1:	b8 00 00 00 00       	mov    $0x0,%eax
 7f6:	eb 13                	jmp    80b <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7fb:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7fe:	8b 45 f4             	mov    -0xc(%ebp),%eax
 801:	8b 00                	mov    (%eax),%eax
 803:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 806:	e9 6d ff ff ff       	jmp    778 <malloc+0x4e>
  }
}
 80b:	c9                   	leave  
 80c:	c3                   	ret    
