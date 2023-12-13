
_setq:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "types.h"
#include "user.h"

int main(int argc, char *argv[]) 
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
  int pid = atoi(argv[1]);
  14:	8b 43 04             	mov    0x4(%ebx),%eax
  17:	83 c0 04             	add    $0x4,%eax
  1a:	8b 00                	mov    (%eax),%eax
  1c:	83 ec 0c             	sub    $0xc,%esp
  1f:	50                   	push   %eax
  20:	e8 f8 01 00 00       	call   21d <atoi>
  25:	83 c4 10             	add    $0x10,%esp
  28:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int newLevel = atoi(argv[2]);
  2b:	8b 43 04             	mov    0x4(%ebx),%eax
  2e:	83 c0 08             	add    $0x8,%eax
  31:	8b 00                	mov    (%eax),%eax
  33:	83 ec 0c             	sub    $0xc,%esp
  36:	50                   	push   %eax
  37:	e8 e1 01 00 00       	call   21d <atoi>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	89 45 f0             	mov    %eax,-0x10(%ebp)

  change_queue(pid, newLevel);
  42:	83 ec 08             	sub    $0x8,%esp
  45:	ff 75 f0             	push   -0x10(%ebp)
  48:	ff 75 f4             	push   -0xc(%ebp)
  4b:	e8 62 03 00 00       	call   3b2 <change_queue>
  50:	83 c4 10             	add    $0x10,%esp

  exit();
  53:	e8 b2 02 00 00       	call   30a <exit>

00000058 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  58:	55                   	push   %ebp
  59:	89 e5                	mov    %esp,%ebp
  5b:	57                   	push   %edi
  5c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  5d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  60:	8b 55 10             	mov    0x10(%ebp),%edx
  63:	8b 45 0c             	mov    0xc(%ebp),%eax
  66:	89 cb                	mov    %ecx,%ebx
  68:	89 df                	mov    %ebx,%edi
  6a:	89 d1                	mov    %edx,%ecx
  6c:	fc                   	cld    
  6d:	f3 aa                	rep stos %al,%es:(%edi)
  6f:	89 ca                	mov    %ecx,%edx
  71:	89 fb                	mov    %edi,%ebx
  73:	89 5d 08             	mov    %ebx,0x8(%ebp)
  76:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  79:	90                   	nop
  7a:	5b                   	pop    %ebx
  7b:	5f                   	pop    %edi
  7c:	5d                   	pop    %ebp
  7d:	c3                   	ret    

0000007e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  7e:	55                   	push   %ebp
  7f:	89 e5                	mov    %esp,%ebp
  81:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  84:	8b 45 08             	mov    0x8(%ebp),%eax
  87:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  8a:	90                   	nop
  8b:	8b 55 0c             	mov    0xc(%ebp),%edx
  8e:	8d 42 01             	lea    0x1(%edx),%eax
  91:	89 45 0c             	mov    %eax,0xc(%ebp)
  94:	8b 45 08             	mov    0x8(%ebp),%eax
  97:	8d 48 01             	lea    0x1(%eax),%ecx
  9a:	89 4d 08             	mov    %ecx,0x8(%ebp)
  9d:	0f b6 12             	movzbl (%edx),%edx
  a0:	88 10                	mov    %dl,(%eax)
  a2:	0f b6 00             	movzbl (%eax),%eax
  a5:	84 c0                	test   %al,%al
  a7:	75 e2                	jne    8b <strcpy+0xd>
    ;
  return os;
  a9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  ac:	c9                   	leave  
  ad:	c3                   	ret    

000000ae <strcmp>:

int
strcmp(const char *p, const char *q)
{
  ae:	55                   	push   %ebp
  af:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  b1:	eb 08                	jmp    bb <strcmp+0xd>
    p++, q++;
  b3:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  b7:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
  bb:	8b 45 08             	mov    0x8(%ebp),%eax
  be:	0f b6 00             	movzbl (%eax),%eax
  c1:	84 c0                	test   %al,%al
  c3:	74 10                	je     d5 <strcmp+0x27>
  c5:	8b 45 08             	mov    0x8(%ebp),%eax
  c8:	0f b6 10             	movzbl (%eax),%edx
  cb:	8b 45 0c             	mov    0xc(%ebp),%eax
  ce:	0f b6 00             	movzbl (%eax),%eax
  d1:	38 c2                	cmp    %al,%dl
  d3:	74 de                	je     b3 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
  d5:	8b 45 08             	mov    0x8(%ebp),%eax
  d8:	0f b6 00             	movzbl (%eax),%eax
  db:	0f b6 d0             	movzbl %al,%edx
  de:	8b 45 0c             	mov    0xc(%ebp),%eax
  e1:	0f b6 00             	movzbl (%eax),%eax
  e4:	0f b6 c8             	movzbl %al,%ecx
  e7:	89 d0                	mov    %edx,%eax
  e9:	29 c8                	sub    %ecx,%eax
}
  eb:	5d                   	pop    %ebp
  ec:	c3                   	ret    

000000ed <strlen>:

uint
strlen(const char *s)
{
  ed:	55                   	push   %ebp
  ee:	89 e5                	mov    %esp,%ebp
  f0:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
  f3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  fa:	eb 04                	jmp    100 <strlen+0x13>
  fc:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 100:	8b 55 fc             	mov    -0x4(%ebp),%edx
 103:	8b 45 08             	mov    0x8(%ebp),%eax
 106:	01 d0                	add    %edx,%eax
 108:	0f b6 00             	movzbl (%eax),%eax
 10b:	84 c0                	test   %al,%al
 10d:	75 ed                	jne    fc <strlen+0xf>
    ;
  return n;
 10f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 112:	c9                   	leave  
 113:	c3                   	ret    

00000114 <memset>:

void*
memset(void *dst, int c, uint n)
{
 114:	55                   	push   %ebp
 115:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 117:	8b 45 10             	mov    0x10(%ebp),%eax
 11a:	50                   	push   %eax
 11b:	ff 75 0c             	push   0xc(%ebp)
 11e:	ff 75 08             	push   0x8(%ebp)
 121:	e8 32 ff ff ff       	call   58 <stosb>
 126:	83 c4 0c             	add    $0xc,%esp
  return dst;
 129:	8b 45 08             	mov    0x8(%ebp),%eax
}
 12c:	c9                   	leave  
 12d:	c3                   	ret    

0000012e <strchr>:

char*
strchr(const char *s, char c)
{
 12e:	55                   	push   %ebp
 12f:	89 e5                	mov    %esp,%ebp
 131:	83 ec 04             	sub    $0x4,%esp
 134:	8b 45 0c             	mov    0xc(%ebp),%eax
 137:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 13a:	eb 14                	jmp    150 <strchr+0x22>
    if(*s == c)
 13c:	8b 45 08             	mov    0x8(%ebp),%eax
 13f:	0f b6 00             	movzbl (%eax),%eax
 142:	38 45 fc             	cmp    %al,-0x4(%ebp)
 145:	75 05                	jne    14c <strchr+0x1e>
      return (char*)s;
 147:	8b 45 08             	mov    0x8(%ebp),%eax
 14a:	eb 13                	jmp    15f <strchr+0x31>
  for(; *s; s++)
 14c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 150:	8b 45 08             	mov    0x8(%ebp),%eax
 153:	0f b6 00             	movzbl (%eax),%eax
 156:	84 c0                	test   %al,%al
 158:	75 e2                	jne    13c <strchr+0xe>
  return 0;
 15a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 15f:	c9                   	leave  
 160:	c3                   	ret    

00000161 <gets>:

char*
gets(char *buf, int max)
{
 161:	55                   	push   %ebp
 162:	89 e5                	mov    %esp,%ebp
 164:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 167:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 16e:	eb 42                	jmp    1b2 <gets+0x51>
    cc = read(0, &c, 1);
 170:	83 ec 04             	sub    $0x4,%esp
 173:	6a 01                	push   $0x1
 175:	8d 45 ef             	lea    -0x11(%ebp),%eax
 178:	50                   	push   %eax
 179:	6a 00                	push   $0x0
 17b:	e8 a2 01 00 00       	call   322 <read>
 180:	83 c4 10             	add    $0x10,%esp
 183:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 186:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 18a:	7e 33                	jle    1bf <gets+0x5e>
      break;
    buf[i++] = c;
 18c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 18f:	8d 50 01             	lea    0x1(%eax),%edx
 192:	89 55 f4             	mov    %edx,-0xc(%ebp)
 195:	89 c2                	mov    %eax,%edx
 197:	8b 45 08             	mov    0x8(%ebp),%eax
 19a:	01 c2                	add    %eax,%edx
 19c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1a0:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1a2:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1a6:	3c 0a                	cmp    $0xa,%al
 1a8:	74 16                	je     1c0 <gets+0x5f>
 1aa:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1ae:	3c 0d                	cmp    $0xd,%al
 1b0:	74 0e                	je     1c0 <gets+0x5f>
  for(i=0; i+1 < max; ){
 1b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b5:	83 c0 01             	add    $0x1,%eax
 1b8:	39 45 0c             	cmp    %eax,0xc(%ebp)
 1bb:	7f b3                	jg     170 <gets+0xf>
 1bd:	eb 01                	jmp    1c0 <gets+0x5f>
      break;
 1bf:	90                   	nop
      break;
  }
  buf[i] = '\0';
 1c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1c3:	8b 45 08             	mov    0x8(%ebp),%eax
 1c6:	01 d0                	add    %edx,%eax
 1c8:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1cb:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1ce:	c9                   	leave  
 1cf:	c3                   	ret    

000001d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1d6:	83 ec 08             	sub    $0x8,%esp
 1d9:	6a 00                	push   $0x0
 1db:	ff 75 08             	push   0x8(%ebp)
 1de:	e8 67 01 00 00       	call   34a <open>
 1e3:	83 c4 10             	add    $0x10,%esp
 1e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 1e9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 1ed:	79 07                	jns    1f6 <stat+0x26>
    return -1;
 1ef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 1f4:	eb 25                	jmp    21b <stat+0x4b>
  r = fstat(fd, st);
 1f6:	83 ec 08             	sub    $0x8,%esp
 1f9:	ff 75 0c             	push   0xc(%ebp)
 1fc:	ff 75 f4             	push   -0xc(%ebp)
 1ff:	e8 5e 01 00 00       	call   362 <fstat>
 204:	83 c4 10             	add    $0x10,%esp
 207:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 20a:	83 ec 0c             	sub    $0xc,%esp
 20d:	ff 75 f4             	push   -0xc(%ebp)
 210:	e8 1d 01 00 00       	call   332 <close>
 215:	83 c4 10             	add    $0x10,%esp
  return r;
 218:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 21b:	c9                   	leave  
 21c:	c3                   	ret    

0000021d <atoi>:

int
atoi(const char *s)
{
 21d:	55                   	push   %ebp
 21e:	89 e5                	mov    %esp,%ebp
 220:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 223:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 22a:	eb 25                	jmp    251 <atoi+0x34>
    n = n*10 + *s++ - '0';
 22c:	8b 55 fc             	mov    -0x4(%ebp),%edx
 22f:	89 d0                	mov    %edx,%eax
 231:	c1 e0 02             	shl    $0x2,%eax
 234:	01 d0                	add    %edx,%eax
 236:	01 c0                	add    %eax,%eax
 238:	89 c1                	mov    %eax,%ecx
 23a:	8b 45 08             	mov    0x8(%ebp),%eax
 23d:	8d 50 01             	lea    0x1(%eax),%edx
 240:	89 55 08             	mov    %edx,0x8(%ebp)
 243:	0f b6 00             	movzbl (%eax),%eax
 246:	0f be c0             	movsbl %al,%eax
 249:	01 c8                	add    %ecx,%eax
 24b:	83 e8 30             	sub    $0x30,%eax
 24e:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 251:	8b 45 08             	mov    0x8(%ebp),%eax
 254:	0f b6 00             	movzbl (%eax),%eax
 257:	3c 2f                	cmp    $0x2f,%al
 259:	7e 0a                	jle    265 <atoi+0x48>
 25b:	8b 45 08             	mov    0x8(%ebp),%eax
 25e:	0f b6 00             	movzbl (%eax),%eax
 261:	3c 39                	cmp    $0x39,%al
 263:	7e c7                	jle    22c <atoi+0xf>
  return n;
 265:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 268:	c9                   	leave  
 269:	c3                   	ret    

0000026a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 26a:	55                   	push   %ebp
 26b:	89 e5                	mov    %esp,%ebp
 26d:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
 270:	8b 45 08             	mov    0x8(%ebp),%eax
 273:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 276:	8b 45 0c             	mov    0xc(%ebp),%eax
 279:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 27c:	eb 17                	jmp    295 <memmove+0x2b>
    *dst++ = *src++;
 27e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 281:	8d 42 01             	lea    0x1(%edx),%eax
 284:	89 45 f8             	mov    %eax,-0x8(%ebp)
 287:	8b 45 fc             	mov    -0x4(%ebp),%eax
 28a:	8d 48 01             	lea    0x1(%eax),%ecx
 28d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 290:	0f b6 12             	movzbl (%edx),%edx
 293:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 295:	8b 45 10             	mov    0x10(%ebp),%eax
 298:	8d 50 ff             	lea    -0x1(%eax),%edx
 29b:	89 55 10             	mov    %edx,0x10(%ebp)
 29e:	85 c0                	test   %eax,%eax
 2a0:	7f dc                	jg     27e <memmove+0x14>
  return vdst;
 2a2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2a5:	c9                   	leave  
 2a6:	c3                   	ret    

000002a7 <calc>:

int calc(int num)
{
 2a7:	55                   	push   %ebp
 2a8:	89 e5                	mov    %esp,%ebp
 2aa:	83 ec 10             	sub    $0x10,%esp
    int c = 0;
 2ad:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for(uint i = 0; i < num; i++)
 2b4:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
 2bb:	eb 36                	jmp    2f3 <calc+0x4c>
    {
        for(uint j = 0; j < num; j++)
 2bd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2c4:	eb 21                	jmp    2e7 <calc+0x40>
        {
            for(uint k = 0; k < num; j++)
 2c6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 2cd:	eb 0c                	jmp    2db <calc+0x34>
            {
                c >>= 10;
 2cf:	c1 7d fc 0a          	sarl   $0xa,-0x4(%ebp)
                c <<= 10;
 2d3:	c1 65 fc 0a          	shll   $0xa,-0x4(%ebp)
            for(uint k = 0; k < num; j++)
 2d7:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 2db:	8b 45 08             	mov    0x8(%ebp),%eax
 2de:	39 45 f0             	cmp    %eax,-0x10(%ebp)
 2e1:	72 ec                	jb     2cf <calc+0x28>
        for(uint j = 0; j < num; j++)
 2e3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 2e7:	8b 45 08             	mov    0x8(%ebp),%eax
 2ea:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 2ed:	72 d7                	jb     2c6 <calc+0x1f>
    for(uint i = 0; i < num; i++)
 2ef:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 2f3:	8b 45 08             	mov    0x8(%ebp),%eax
 2f6:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 2f9:	72 c2                	jb     2bd <calc+0x16>
            }
        }
    }
    return 0;
 2fb:	b8 00 00 00 00       	mov    $0x0,%eax
}
 300:	c9                   	leave  
 301:	c3                   	ret    

00000302 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 302:	b8 01 00 00 00       	mov    $0x1,%eax
 307:	cd 40                	int    $0x40
 309:	c3                   	ret    

0000030a <exit>:
SYSCALL(exit)
 30a:	b8 02 00 00 00       	mov    $0x2,%eax
 30f:	cd 40                	int    $0x40
 311:	c3                   	ret    

00000312 <wait>:
SYSCALL(wait)
 312:	b8 03 00 00 00       	mov    $0x3,%eax
 317:	cd 40                	int    $0x40
 319:	c3                   	ret    

0000031a <pipe>:
SYSCALL(pipe)
 31a:	b8 04 00 00 00       	mov    $0x4,%eax
 31f:	cd 40                	int    $0x40
 321:	c3                   	ret    

00000322 <read>:
SYSCALL(read)
 322:	b8 05 00 00 00       	mov    $0x5,%eax
 327:	cd 40                	int    $0x40
 329:	c3                   	ret    

0000032a <write>:
SYSCALL(write)
 32a:	b8 10 00 00 00       	mov    $0x10,%eax
 32f:	cd 40                	int    $0x40
 331:	c3                   	ret    

00000332 <close>:
SYSCALL(close)
 332:	b8 15 00 00 00       	mov    $0x15,%eax
 337:	cd 40                	int    $0x40
 339:	c3                   	ret    

0000033a <kill>:
SYSCALL(kill)
 33a:	b8 06 00 00 00       	mov    $0x6,%eax
 33f:	cd 40                	int    $0x40
 341:	c3                   	ret    

00000342 <exec>:
SYSCALL(exec)
 342:	b8 07 00 00 00       	mov    $0x7,%eax
 347:	cd 40                	int    $0x40
 349:	c3                   	ret    

0000034a <open>:
SYSCALL(open)
 34a:	b8 0f 00 00 00       	mov    $0xf,%eax
 34f:	cd 40                	int    $0x40
 351:	c3                   	ret    

00000352 <mknod>:
SYSCALL(mknod)
 352:	b8 11 00 00 00       	mov    $0x11,%eax
 357:	cd 40                	int    $0x40
 359:	c3                   	ret    

0000035a <unlink>:
SYSCALL(unlink)
 35a:	b8 12 00 00 00       	mov    $0x12,%eax
 35f:	cd 40                	int    $0x40
 361:	c3                   	ret    

00000362 <fstat>:
SYSCALL(fstat)
 362:	b8 08 00 00 00       	mov    $0x8,%eax
 367:	cd 40                	int    $0x40
 369:	c3                   	ret    

0000036a <link>:
SYSCALL(link)
 36a:	b8 13 00 00 00       	mov    $0x13,%eax
 36f:	cd 40                	int    $0x40
 371:	c3                   	ret    

00000372 <mkdir>:
SYSCALL(mkdir)
 372:	b8 14 00 00 00       	mov    $0x14,%eax
 377:	cd 40                	int    $0x40
 379:	c3                   	ret    

0000037a <chdir>:
SYSCALL(chdir)
 37a:	b8 09 00 00 00       	mov    $0x9,%eax
 37f:	cd 40                	int    $0x40
 381:	c3                   	ret    

00000382 <dup>:
SYSCALL(dup)
 382:	b8 0a 00 00 00       	mov    $0xa,%eax
 387:	cd 40                	int    $0x40
 389:	c3                   	ret    

0000038a <getpid>:
SYSCALL(getpid)
 38a:	b8 0b 00 00 00       	mov    $0xb,%eax
 38f:	cd 40                	int    $0x40
 391:	c3                   	ret    

00000392 <sbrk>:
SYSCALL(sbrk)
 392:	b8 0c 00 00 00       	mov    $0xc,%eax
 397:	cd 40                	int    $0x40
 399:	c3                   	ret    

0000039a <sleep>:
SYSCALL(sleep)
 39a:	b8 0d 00 00 00       	mov    $0xd,%eax
 39f:	cd 40                	int    $0x40
 3a1:	c3                   	ret    

000003a2 <uptime>:
SYSCALL(uptime)
 3a2:	b8 0e 00 00 00       	mov    $0xe,%eax
 3a7:	cd 40                	int    $0x40
 3a9:	c3                   	ret    

000003aa <print_proc>:
SYSCALL(print_proc)
 3aa:	b8 16 00 00 00       	mov    $0x16,%eax
 3af:	cd 40                	int    $0x40
 3b1:	c3                   	ret    

000003b2 <change_queue>:
SYSCALL(change_queue)
 3b2:	b8 17 00 00 00       	mov    $0x17,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <change_local_bjf>:
SYSCALL(change_local_bjf)
 3ba:	b8 18 00 00 00       	mov    $0x18,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <change_global_bjf>:
SYSCALL(change_global_bjf)
 3c2:	b8 19 00 00 00       	mov    $0x19,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3ca:	55                   	push   %ebp
 3cb:	89 e5                	mov    %esp,%ebp
 3cd:	83 ec 18             	sub    $0x18,%esp
 3d0:	8b 45 0c             	mov    0xc(%ebp),%eax
 3d3:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 3d6:	83 ec 04             	sub    $0x4,%esp
 3d9:	6a 01                	push   $0x1
 3db:	8d 45 f4             	lea    -0xc(%ebp),%eax
 3de:	50                   	push   %eax
 3df:	ff 75 08             	push   0x8(%ebp)
 3e2:	e8 43 ff ff ff       	call   32a <write>
 3e7:	83 c4 10             	add    $0x10,%esp
}
 3ea:	90                   	nop
 3eb:	c9                   	leave  
 3ec:	c3                   	ret    

000003ed <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 3ed:	55                   	push   %ebp
 3ee:	89 e5                	mov    %esp,%ebp
 3f0:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 3f3:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 3fa:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 3fe:	74 17                	je     417 <printint+0x2a>
 400:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 404:	79 11                	jns    417 <printint+0x2a>
    neg = 1;
 406:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 40d:	8b 45 0c             	mov    0xc(%ebp),%eax
 410:	f7 d8                	neg    %eax
 412:	89 45 ec             	mov    %eax,-0x14(%ebp)
 415:	eb 06                	jmp    41d <printint+0x30>
  } else {
    x = xx;
 417:	8b 45 0c             	mov    0xc(%ebp),%eax
 41a:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 41d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 424:	8b 4d 10             	mov    0x10(%ebp),%ecx
 427:	8b 45 ec             	mov    -0x14(%ebp),%eax
 42a:	ba 00 00 00 00       	mov    $0x0,%edx
 42f:	f7 f1                	div    %ecx
 431:	89 d1                	mov    %edx,%ecx
 433:	8b 45 f4             	mov    -0xc(%ebp),%eax
 436:	8d 50 01             	lea    0x1(%eax),%edx
 439:	89 55 f4             	mov    %edx,-0xc(%ebp)
 43c:	0f b6 91 c4 0a 00 00 	movzbl 0xac4(%ecx),%edx
 443:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 447:	8b 4d 10             	mov    0x10(%ebp),%ecx
 44a:	8b 45 ec             	mov    -0x14(%ebp),%eax
 44d:	ba 00 00 00 00       	mov    $0x0,%edx
 452:	f7 f1                	div    %ecx
 454:	89 45 ec             	mov    %eax,-0x14(%ebp)
 457:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 45b:	75 c7                	jne    424 <printint+0x37>
  if(neg)
 45d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 461:	74 2d                	je     490 <printint+0xa3>
    buf[i++] = '-';
 463:	8b 45 f4             	mov    -0xc(%ebp),%eax
 466:	8d 50 01             	lea    0x1(%eax),%edx
 469:	89 55 f4             	mov    %edx,-0xc(%ebp)
 46c:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 471:	eb 1d                	jmp    490 <printint+0xa3>
    putc(fd, buf[i]);
 473:	8d 55 dc             	lea    -0x24(%ebp),%edx
 476:	8b 45 f4             	mov    -0xc(%ebp),%eax
 479:	01 d0                	add    %edx,%eax
 47b:	0f b6 00             	movzbl (%eax),%eax
 47e:	0f be c0             	movsbl %al,%eax
 481:	83 ec 08             	sub    $0x8,%esp
 484:	50                   	push   %eax
 485:	ff 75 08             	push   0x8(%ebp)
 488:	e8 3d ff ff ff       	call   3ca <putc>
 48d:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 490:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 494:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 498:	79 d9                	jns    473 <printint+0x86>
}
 49a:	90                   	nop
 49b:	90                   	nop
 49c:	c9                   	leave  
 49d:	c3                   	ret    

0000049e <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 49e:	55                   	push   %ebp
 49f:	89 e5                	mov    %esp,%ebp
 4a1:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4a4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4ab:	8d 45 0c             	lea    0xc(%ebp),%eax
 4ae:	83 c0 04             	add    $0x4,%eax
 4b1:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4b4:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4bb:	e9 59 01 00 00       	jmp    619 <printf+0x17b>
    c = fmt[i] & 0xff;
 4c0:	8b 55 0c             	mov    0xc(%ebp),%edx
 4c3:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4c6:	01 d0                	add    %edx,%eax
 4c8:	0f b6 00             	movzbl (%eax),%eax
 4cb:	0f be c0             	movsbl %al,%eax
 4ce:	25 ff 00 00 00       	and    $0xff,%eax
 4d3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 4d6:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 4da:	75 2c                	jne    508 <printf+0x6a>
      if(c == '%'){
 4dc:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 4e0:	75 0c                	jne    4ee <printf+0x50>
        state = '%';
 4e2:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 4e9:	e9 27 01 00 00       	jmp    615 <printf+0x177>
      } else {
        putc(fd, c);
 4ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 4f1:	0f be c0             	movsbl %al,%eax
 4f4:	83 ec 08             	sub    $0x8,%esp
 4f7:	50                   	push   %eax
 4f8:	ff 75 08             	push   0x8(%ebp)
 4fb:	e8 ca fe ff ff       	call   3ca <putc>
 500:	83 c4 10             	add    $0x10,%esp
 503:	e9 0d 01 00 00       	jmp    615 <printf+0x177>
      }
    } else if(state == '%'){
 508:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 50c:	0f 85 03 01 00 00    	jne    615 <printf+0x177>
      if(c == 'd'){
 512:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 516:	75 1e                	jne    536 <printf+0x98>
        printint(fd, *ap, 10, 1);
 518:	8b 45 e8             	mov    -0x18(%ebp),%eax
 51b:	8b 00                	mov    (%eax),%eax
 51d:	6a 01                	push   $0x1
 51f:	6a 0a                	push   $0xa
 521:	50                   	push   %eax
 522:	ff 75 08             	push   0x8(%ebp)
 525:	e8 c3 fe ff ff       	call   3ed <printint>
 52a:	83 c4 10             	add    $0x10,%esp
        ap++;
 52d:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 531:	e9 d8 00 00 00       	jmp    60e <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 536:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 53a:	74 06                	je     542 <printf+0xa4>
 53c:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 540:	75 1e                	jne    560 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 542:	8b 45 e8             	mov    -0x18(%ebp),%eax
 545:	8b 00                	mov    (%eax),%eax
 547:	6a 00                	push   $0x0
 549:	6a 10                	push   $0x10
 54b:	50                   	push   %eax
 54c:	ff 75 08             	push   0x8(%ebp)
 54f:	e8 99 fe ff ff       	call   3ed <printint>
 554:	83 c4 10             	add    $0x10,%esp
        ap++;
 557:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 55b:	e9 ae 00 00 00       	jmp    60e <printf+0x170>
      } else if(c == 's'){
 560:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 564:	75 43                	jne    5a9 <printf+0x10b>
        s = (char*)*ap;
 566:	8b 45 e8             	mov    -0x18(%ebp),%eax
 569:	8b 00                	mov    (%eax),%eax
 56b:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 56e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 572:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 576:	75 25                	jne    59d <printf+0xff>
          s = "(null)";
 578:	c7 45 f4 55 08 00 00 	movl   $0x855,-0xc(%ebp)
        while(*s != 0){
 57f:	eb 1c                	jmp    59d <printf+0xff>
          putc(fd, *s);
 581:	8b 45 f4             	mov    -0xc(%ebp),%eax
 584:	0f b6 00             	movzbl (%eax),%eax
 587:	0f be c0             	movsbl %al,%eax
 58a:	83 ec 08             	sub    $0x8,%esp
 58d:	50                   	push   %eax
 58e:	ff 75 08             	push   0x8(%ebp)
 591:	e8 34 fe ff ff       	call   3ca <putc>
 596:	83 c4 10             	add    $0x10,%esp
          s++;
 599:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 59d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5a0:	0f b6 00             	movzbl (%eax),%eax
 5a3:	84 c0                	test   %al,%al
 5a5:	75 da                	jne    581 <printf+0xe3>
 5a7:	eb 65                	jmp    60e <printf+0x170>
        }
      } else if(c == 'c'){
 5a9:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5ad:	75 1d                	jne    5cc <printf+0x12e>
        putc(fd, *ap);
 5af:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5b2:	8b 00                	mov    (%eax),%eax
 5b4:	0f be c0             	movsbl %al,%eax
 5b7:	83 ec 08             	sub    $0x8,%esp
 5ba:	50                   	push   %eax
 5bb:	ff 75 08             	push   0x8(%ebp)
 5be:	e8 07 fe ff ff       	call   3ca <putc>
 5c3:	83 c4 10             	add    $0x10,%esp
        ap++;
 5c6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5ca:	eb 42                	jmp    60e <printf+0x170>
      } else if(c == '%'){
 5cc:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5d0:	75 17                	jne    5e9 <printf+0x14b>
        putc(fd, c);
 5d2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5d5:	0f be c0             	movsbl %al,%eax
 5d8:	83 ec 08             	sub    $0x8,%esp
 5db:	50                   	push   %eax
 5dc:	ff 75 08             	push   0x8(%ebp)
 5df:	e8 e6 fd ff ff       	call   3ca <putc>
 5e4:	83 c4 10             	add    $0x10,%esp
 5e7:	eb 25                	jmp    60e <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 5e9:	83 ec 08             	sub    $0x8,%esp
 5ec:	6a 25                	push   $0x25
 5ee:	ff 75 08             	push   0x8(%ebp)
 5f1:	e8 d4 fd ff ff       	call   3ca <putc>
 5f6:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 5f9:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5fc:	0f be c0             	movsbl %al,%eax
 5ff:	83 ec 08             	sub    $0x8,%esp
 602:	50                   	push   %eax
 603:	ff 75 08             	push   0x8(%ebp)
 606:	e8 bf fd ff ff       	call   3ca <putc>
 60b:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 60e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 615:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 619:	8b 55 0c             	mov    0xc(%ebp),%edx
 61c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 61f:	01 d0                	add    %edx,%eax
 621:	0f b6 00             	movzbl (%eax),%eax
 624:	84 c0                	test   %al,%al
 626:	0f 85 94 fe ff ff    	jne    4c0 <printf+0x22>
    }
  }
}
 62c:	90                   	nop
 62d:	90                   	nop
 62e:	c9                   	leave  
 62f:	c3                   	ret    

00000630 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 630:	55                   	push   %ebp
 631:	89 e5                	mov    %esp,%ebp
 633:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 636:	8b 45 08             	mov    0x8(%ebp),%eax
 639:	83 e8 08             	sub    $0x8,%eax
 63c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 63f:	a1 e0 0a 00 00       	mov    0xae0,%eax
 644:	89 45 fc             	mov    %eax,-0x4(%ebp)
 647:	eb 24                	jmp    66d <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 649:	8b 45 fc             	mov    -0x4(%ebp),%eax
 64c:	8b 00                	mov    (%eax),%eax
 64e:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 651:	72 12                	jb     665 <free+0x35>
 653:	8b 45 f8             	mov    -0x8(%ebp),%eax
 656:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 659:	77 24                	ja     67f <free+0x4f>
 65b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 65e:	8b 00                	mov    (%eax),%eax
 660:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 663:	72 1a                	jb     67f <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 665:	8b 45 fc             	mov    -0x4(%ebp),%eax
 668:	8b 00                	mov    (%eax),%eax
 66a:	89 45 fc             	mov    %eax,-0x4(%ebp)
 66d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 670:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 673:	76 d4                	jbe    649 <free+0x19>
 675:	8b 45 fc             	mov    -0x4(%ebp),%eax
 678:	8b 00                	mov    (%eax),%eax
 67a:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 67d:	73 ca                	jae    649 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 67f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 682:	8b 40 04             	mov    0x4(%eax),%eax
 685:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 68c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 68f:	01 c2                	add    %eax,%edx
 691:	8b 45 fc             	mov    -0x4(%ebp),%eax
 694:	8b 00                	mov    (%eax),%eax
 696:	39 c2                	cmp    %eax,%edx
 698:	75 24                	jne    6be <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 69a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 69d:	8b 50 04             	mov    0x4(%eax),%edx
 6a0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a3:	8b 00                	mov    (%eax),%eax
 6a5:	8b 40 04             	mov    0x4(%eax),%eax
 6a8:	01 c2                	add    %eax,%edx
 6aa:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ad:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6b3:	8b 00                	mov    (%eax),%eax
 6b5:	8b 10                	mov    (%eax),%edx
 6b7:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ba:	89 10                	mov    %edx,(%eax)
 6bc:	eb 0a                	jmp    6c8 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6be:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c1:	8b 10                	mov    (%eax),%edx
 6c3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c6:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6cb:	8b 40 04             	mov    0x4(%eax),%eax
 6ce:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6d5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d8:	01 d0                	add    %edx,%eax
 6da:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 6dd:	75 20                	jne    6ff <free+0xcf>
    p->s.size += bp->s.size;
 6df:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e2:	8b 50 04             	mov    0x4(%eax),%edx
 6e5:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6e8:	8b 40 04             	mov    0x4(%eax),%eax
 6eb:	01 c2                	add    %eax,%edx
 6ed:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f0:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f6:	8b 10                	mov    (%eax),%edx
 6f8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fb:	89 10                	mov    %edx,(%eax)
 6fd:	eb 08                	jmp    707 <free+0xd7>
  } else
    p->s.ptr = bp;
 6ff:	8b 45 fc             	mov    -0x4(%ebp),%eax
 702:	8b 55 f8             	mov    -0x8(%ebp),%edx
 705:	89 10                	mov    %edx,(%eax)
  freep = p;
 707:	8b 45 fc             	mov    -0x4(%ebp),%eax
 70a:	a3 e0 0a 00 00       	mov    %eax,0xae0
}
 70f:	90                   	nop
 710:	c9                   	leave  
 711:	c3                   	ret    

00000712 <morecore>:

static Header*
morecore(uint nu)
{
 712:	55                   	push   %ebp
 713:	89 e5                	mov    %esp,%ebp
 715:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 718:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 71f:	77 07                	ja     728 <morecore+0x16>
    nu = 4096;
 721:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 728:	8b 45 08             	mov    0x8(%ebp),%eax
 72b:	c1 e0 03             	shl    $0x3,%eax
 72e:	83 ec 0c             	sub    $0xc,%esp
 731:	50                   	push   %eax
 732:	e8 5b fc ff ff       	call   392 <sbrk>
 737:	83 c4 10             	add    $0x10,%esp
 73a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 73d:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 741:	75 07                	jne    74a <morecore+0x38>
    return 0;
 743:	b8 00 00 00 00       	mov    $0x0,%eax
 748:	eb 26                	jmp    770 <morecore+0x5e>
  hp = (Header*)p;
 74a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 74d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 750:	8b 45 f0             	mov    -0x10(%ebp),%eax
 753:	8b 55 08             	mov    0x8(%ebp),%edx
 756:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 759:	8b 45 f0             	mov    -0x10(%ebp),%eax
 75c:	83 c0 08             	add    $0x8,%eax
 75f:	83 ec 0c             	sub    $0xc,%esp
 762:	50                   	push   %eax
 763:	e8 c8 fe ff ff       	call   630 <free>
 768:	83 c4 10             	add    $0x10,%esp
  return freep;
 76b:	a1 e0 0a 00 00       	mov    0xae0,%eax
}
 770:	c9                   	leave  
 771:	c3                   	ret    

00000772 <malloc>:

void*
malloc(uint nbytes)
{
 772:	55                   	push   %ebp
 773:	89 e5                	mov    %esp,%ebp
 775:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 778:	8b 45 08             	mov    0x8(%ebp),%eax
 77b:	83 c0 07             	add    $0x7,%eax
 77e:	c1 e8 03             	shr    $0x3,%eax
 781:	83 c0 01             	add    $0x1,%eax
 784:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 787:	a1 e0 0a 00 00       	mov    0xae0,%eax
 78c:	89 45 f0             	mov    %eax,-0x10(%ebp)
 78f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 793:	75 23                	jne    7b8 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 795:	c7 45 f0 d8 0a 00 00 	movl   $0xad8,-0x10(%ebp)
 79c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 79f:	a3 e0 0a 00 00       	mov    %eax,0xae0
 7a4:	a1 e0 0a 00 00       	mov    0xae0,%eax
 7a9:	a3 d8 0a 00 00       	mov    %eax,0xad8
    base.s.size = 0;
 7ae:	c7 05 dc 0a 00 00 00 	movl   $0x0,0xadc
 7b5:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7bb:	8b 00                	mov    (%eax),%eax
 7bd:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7c3:	8b 40 04             	mov    0x4(%eax),%eax
 7c6:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7c9:	77 4d                	ja     818 <malloc+0xa6>
      if(p->s.size == nunits)
 7cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ce:	8b 40 04             	mov    0x4(%eax),%eax
 7d1:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7d4:	75 0c                	jne    7e2 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 7d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7d9:	8b 10                	mov    (%eax),%edx
 7db:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7de:	89 10                	mov    %edx,(%eax)
 7e0:	eb 26                	jmp    808 <malloc+0x96>
      else {
        p->s.size -= nunits;
 7e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7e5:	8b 40 04             	mov    0x4(%eax),%eax
 7e8:	2b 45 ec             	sub    -0x14(%ebp),%eax
 7eb:	89 c2                	mov    %eax,%edx
 7ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f0:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 7f3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f6:	8b 40 04             	mov    0x4(%eax),%eax
 7f9:	c1 e0 03             	shl    $0x3,%eax
 7fc:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 7ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 802:	8b 55 ec             	mov    -0x14(%ebp),%edx
 805:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 808:	8b 45 f0             	mov    -0x10(%ebp),%eax
 80b:	a3 e0 0a 00 00       	mov    %eax,0xae0
      return (void*)(p + 1);
 810:	8b 45 f4             	mov    -0xc(%ebp),%eax
 813:	83 c0 08             	add    $0x8,%eax
 816:	eb 3b                	jmp    853 <malloc+0xe1>
    }
    if(p == freep)
 818:	a1 e0 0a 00 00       	mov    0xae0,%eax
 81d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 820:	75 1e                	jne    840 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 822:	83 ec 0c             	sub    $0xc,%esp
 825:	ff 75 ec             	push   -0x14(%ebp)
 828:	e8 e5 fe ff ff       	call   712 <morecore>
 82d:	83 c4 10             	add    $0x10,%esp
 830:	89 45 f4             	mov    %eax,-0xc(%ebp)
 833:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 837:	75 07                	jne    840 <malloc+0xce>
        return 0;
 839:	b8 00 00 00 00       	mov    $0x0,%eax
 83e:	eb 13                	jmp    853 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 840:	8b 45 f4             	mov    -0xc(%ebp),%eax
 843:	89 45 f0             	mov    %eax,-0x10(%ebp)
 846:	8b 45 f4             	mov    -0xc(%ebp),%eax
 849:	8b 00                	mov    (%eax),%eax
 84b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 84e:	e9 6d ff ff ff       	jmp    7c0 <malloc+0x4e>
  }
}
 853:	c9                   	leave  
 854:	c3                   	ret    
