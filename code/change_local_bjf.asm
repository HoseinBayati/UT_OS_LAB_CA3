
_change_local_bjf:     file format elf32-i386


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
  20:	e8 29 02 00 00       	call   24e <atoi>
  25:	83 c4 10             	add    $0x10,%esp
  28:	89 45 f4             	mov    %eax,-0xc(%ebp)
    int pRatio = atoi(argv[2]);
  2b:	8b 43 04             	mov    0x4(%ebx),%eax
  2e:	83 c0 08             	add    $0x8,%eax
  31:	8b 00                	mov    (%eax),%eax
  33:	83 ec 0c             	sub    $0xc,%esp
  36:	50                   	push   %eax
  37:	e8 12 02 00 00       	call   24e <atoi>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    int aRatio = atoi(argv[3]);
  42:	8b 43 04             	mov    0x4(%ebx),%eax
  45:	83 c0 0c             	add    $0xc,%eax
  48:	8b 00                	mov    (%eax),%eax
  4a:	83 ec 0c             	sub    $0xc,%esp
  4d:	50                   	push   %eax
  4e:	e8 fb 01 00 00       	call   24e <atoi>
  53:	83 c4 10             	add    $0x10,%esp
  56:	89 45 ec             	mov    %eax,-0x14(%ebp)
    int eRatio = atoi(argv[4]);
  59:	8b 43 04             	mov    0x4(%ebx),%eax
  5c:	83 c0 10             	add    $0x10,%eax
  5f:	8b 00                	mov    (%eax),%eax
  61:	83 ec 0c             	sub    $0xc,%esp
  64:	50                   	push   %eax
  65:	e8 e4 01 00 00       	call   24e <atoi>
  6a:	83 c4 10             	add    $0x10,%esp
  6d:	89 45 e8             	mov    %eax,-0x18(%ebp)
    change_local_bjf(pid, pRatio, aRatio, eRatio);
  70:	ff 75 e8             	push   -0x18(%ebp)
  73:	ff 75 ec             	push   -0x14(%ebp)
  76:	ff 75 f0             	push   -0x10(%ebp)
  79:	ff 75 f4             	push   -0xc(%ebp)
  7c:	e8 6a 03 00 00       	call   3eb <change_local_bjf>
  81:	83 c4 10             	add    $0x10,%esp
 
  
  exit();
  84:	e8 b2 02 00 00       	call   33b <exit>

00000089 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
  89:	55                   	push   %ebp
  8a:	89 e5                	mov    %esp,%ebp
  8c:	57                   	push   %edi
  8d:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
  8e:	8b 4d 08             	mov    0x8(%ebp),%ecx
  91:	8b 55 10             	mov    0x10(%ebp),%edx
  94:	8b 45 0c             	mov    0xc(%ebp),%eax
  97:	89 cb                	mov    %ecx,%ebx
  99:	89 df                	mov    %ebx,%edi
  9b:	89 d1                	mov    %edx,%ecx
  9d:	fc                   	cld    
  9e:	f3 aa                	rep stos %al,%es:(%edi)
  a0:	89 ca                	mov    %ecx,%edx
  a2:	89 fb                	mov    %edi,%ebx
  a4:	89 5d 08             	mov    %ebx,0x8(%ebp)
  a7:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
  aa:	90                   	nop
  ab:	5b                   	pop    %ebx
  ac:	5f                   	pop    %edi
  ad:	5d                   	pop    %ebp
  ae:	c3                   	ret    

000000af <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  af:	55                   	push   %ebp
  b0:	89 e5                	mov    %esp,%ebp
  b2:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
  b5:	8b 45 08             	mov    0x8(%ebp),%eax
  b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
  bb:	90                   	nop
  bc:	8b 55 0c             	mov    0xc(%ebp),%edx
  bf:	8d 42 01             	lea    0x1(%edx),%eax
  c2:	89 45 0c             	mov    %eax,0xc(%ebp)
  c5:	8b 45 08             	mov    0x8(%ebp),%eax
  c8:	8d 48 01             	lea    0x1(%eax),%ecx
  cb:	89 4d 08             	mov    %ecx,0x8(%ebp)
  ce:	0f b6 12             	movzbl (%edx),%edx
  d1:	88 10                	mov    %dl,(%eax)
  d3:	0f b6 00             	movzbl (%eax),%eax
  d6:	84 c0                	test   %al,%al
  d8:	75 e2                	jne    bc <strcpy+0xd>
    ;
  return os;
  da:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
  dd:	c9                   	leave  
  de:	c3                   	ret    

000000df <strcmp>:

int
strcmp(const char *p, const char *q)
{
  df:	55                   	push   %ebp
  e0:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
  e2:	eb 08                	jmp    ec <strcmp+0xd>
    p++, q++;
  e4:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  e8:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
  ec:	8b 45 08             	mov    0x8(%ebp),%eax
  ef:	0f b6 00             	movzbl (%eax),%eax
  f2:	84 c0                	test   %al,%al
  f4:	74 10                	je     106 <strcmp+0x27>
  f6:	8b 45 08             	mov    0x8(%ebp),%eax
  f9:	0f b6 10             	movzbl (%eax),%edx
  fc:	8b 45 0c             	mov    0xc(%ebp),%eax
  ff:	0f b6 00             	movzbl (%eax),%eax
 102:	38 c2                	cmp    %al,%dl
 104:	74 de                	je     e4 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 106:	8b 45 08             	mov    0x8(%ebp),%eax
 109:	0f b6 00             	movzbl (%eax),%eax
 10c:	0f b6 d0             	movzbl %al,%edx
 10f:	8b 45 0c             	mov    0xc(%ebp),%eax
 112:	0f b6 00             	movzbl (%eax),%eax
 115:	0f b6 c8             	movzbl %al,%ecx
 118:	89 d0                	mov    %edx,%eax
 11a:	29 c8                	sub    %ecx,%eax
}
 11c:	5d                   	pop    %ebp
 11d:	c3                   	ret    

0000011e <strlen>:

uint
strlen(const char *s)
{
 11e:	55                   	push   %ebp
 11f:	89 e5                	mov    %esp,%ebp
 121:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 124:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 12b:	eb 04                	jmp    131 <strlen+0x13>
 12d:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 131:	8b 55 fc             	mov    -0x4(%ebp),%edx
 134:	8b 45 08             	mov    0x8(%ebp),%eax
 137:	01 d0                	add    %edx,%eax
 139:	0f b6 00             	movzbl (%eax),%eax
 13c:	84 c0                	test   %al,%al
 13e:	75 ed                	jne    12d <strlen+0xf>
    ;
  return n;
 140:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 143:	c9                   	leave  
 144:	c3                   	ret    

00000145 <memset>:

void*
memset(void *dst, int c, uint n)
{
 145:	55                   	push   %ebp
 146:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 148:	8b 45 10             	mov    0x10(%ebp),%eax
 14b:	50                   	push   %eax
 14c:	ff 75 0c             	push   0xc(%ebp)
 14f:	ff 75 08             	push   0x8(%ebp)
 152:	e8 32 ff ff ff       	call   89 <stosb>
 157:	83 c4 0c             	add    $0xc,%esp
  return dst;
 15a:	8b 45 08             	mov    0x8(%ebp),%eax
}
 15d:	c9                   	leave  
 15e:	c3                   	ret    

0000015f <strchr>:

char*
strchr(const char *s, char c)
{
 15f:	55                   	push   %ebp
 160:	89 e5                	mov    %esp,%ebp
 162:	83 ec 04             	sub    $0x4,%esp
 165:	8b 45 0c             	mov    0xc(%ebp),%eax
 168:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 16b:	eb 14                	jmp    181 <strchr+0x22>
    if(*s == c)
 16d:	8b 45 08             	mov    0x8(%ebp),%eax
 170:	0f b6 00             	movzbl (%eax),%eax
 173:	38 45 fc             	cmp    %al,-0x4(%ebp)
 176:	75 05                	jne    17d <strchr+0x1e>
      return (char*)s;
 178:	8b 45 08             	mov    0x8(%ebp),%eax
 17b:	eb 13                	jmp    190 <strchr+0x31>
  for(; *s; s++)
 17d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 181:	8b 45 08             	mov    0x8(%ebp),%eax
 184:	0f b6 00             	movzbl (%eax),%eax
 187:	84 c0                	test   %al,%al
 189:	75 e2                	jne    16d <strchr+0xe>
  return 0;
 18b:	b8 00 00 00 00       	mov    $0x0,%eax
}
 190:	c9                   	leave  
 191:	c3                   	ret    

00000192 <gets>:

char*
gets(char *buf, int max)
{
 192:	55                   	push   %ebp
 193:	89 e5                	mov    %esp,%ebp
 195:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 198:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 19f:	eb 42                	jmp    1e3 <gets+0x51>
    cc = read(0, &c, 1);
 1a1:	83 ec 04             	sub    $0x4,%esp
 1a4:	6a 01                	push   $0x1
 1a6:	8d 45 ef             	lea    -0x11(%ebp),%eax
 1a9:	50                   	push   %eax
 1aa:	6a 00                	push   $0x0
 1ac:	e8 a2 01 00 00       	call   353 <read>
 1b1:	83 c4 10             	add    $0x10,%esp
 1b4:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 1b7:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 1bb:	7e 33                	jle    1f0 <gets+0x5e>
      break;
    buf[i++] = c;
 1bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1c0:	8d 50 01             	lea    0x1(%eax),%edx
 1c3:	89 55 f4             	mov    %edx,-0xc(%ebp)
 1c6:	89 c2                	mov    %eax,%edx
 1c8:	8b 45 08             	mov    0x8(%ebp),%eax
 1cb:	01 c2                	add    %eax,%edx
 1cd:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d1:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 1d3:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1d7:	3c 0a                	cmp    $0xa,%al
 1d9:	74 16                	je     1f1 <gets+0x5f>
 1db:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 1df:	3c 0d                	cmp    $0xd,%al
 1e1:	74 0e                	je     1f1 <gets+0x5f>
  for(i=0; i+1 < max; ){
 1e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1e6:	83 c0 01             	add    $0x1,%eax
 1e9:	39 45 0c             	cmp    %eax,0xc(%ebp)
 1ec:	7f b3                	jg     1a1 <gets+0xf>
 1ee:	eb 01                	jmp    1f1 <gets+0x5f>
      break;
 1f0:	90                   	nop
      break;
  }
  buf[i] = '\0';
 1f1:	8b 55 f4             	mov    -0xc(%ebp),%edx
 1f4:	8b 45 08             	mov    0x8(%ebp),%eax
 1f7:	01 d0                	add    %edx,%eax
 1f9:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 1fc:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1ff:	c9                   	leave  
 200:	c3                   	ret    

00000201 <stat>:

int
stat(const char *n, struct stat *st)
{
 201:	55                   	push   %ebp
 202:	89 e5                	mov    %esp,%ebp
 204:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 207:	83 ec 08             	sub    $0x8,%esp
 20a:	6a 00                	push   $0x0
 20c:	ff 75 08             	push   0x8(%ebp)
 20f:	e8 67 01 00 00       	call   37b <open>
 214:	83 c4 10             	add    $0x10,%esp
 217:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 21a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 21e:	79 07                	jns    227 <stat+0x26>
    return -1;
 220:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 225:	eb 25                	jmp    24c <stat+0x4b>
  r = fstat(fd, st);
 227:	83 ec 08             	sub    $0x8,%esp
 22a:	ff 75 0c             	push   0xc(%ebp)
 22d:	ff 75 f4             	push   -0xc(%ebp)
 230:	e8 5e 01 00 00       	call   393 <fstat>
 235:	83 c4 10             	add    $0x10,%esp
 238:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 23b:	83 ec 0c             	sub    $0xc,%esp
 23e:	ff 75 f4             	push   -0xc(%ebp)
 241:	e8 1d 01 00 00       	call   363 <close>
 246:	83 c4 10             	add    $0x10,%esp
  return r;
 249:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 24c:	c9                   	leave  
 24d:	c3                   	ret    

0000024e <atoi>:

int
atoi(const char *s)
{
 24e:	55                   	push   %ebp
 24f:	89 e5                	mov    %esp,%ebp
 251:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 254:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 25b:	eb 25                	jmp    282 <atoi+0x34>
    n = n*10 + *s++ - '0';
 25d:	8b 55 fc             	mov    -0x4(%ebp),%edx
 260:	89 d0                	mov    %edx,%eax
 262:	c1 e0 02             	shl    $0x2,%eax
 265:	01 d0                	add    %edx,%eax
 267:	01 c0                	add    %eax,%eax
 269:	89 c1                	mov    %eax,%ecx
 26b:	8b 45 08             	mov    0x8(%ebp),%eax
 26e:	8d 50 01             	lea    0x1(%eax),%edx
 271:	89 55 08             	mov    %edx,0x8(%ebp)
 274:	0f b6 00             	movzbl (%eax),%eax
 277:	0f be c0             	movsbl %al,%eax
 27a:	01 c8                	add    %ecx,%eax
 27c:	83 e8 30             	sub    $0x30,%eax
 27f:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 282:	8b 45 08             	mov    0x8(%ebp),%eax
 285:	0f b6 00             	movzbl (%eax),%eax
 288:	3c 2f                	cmp    $0x2f,%al
 28a:	7e 0a                	jle    296 <atoi+0x48>
 28c:	8b 45 08             	mov    0x8(%ebp),%eax
 28f:	0f b6 00             	movzbl (%eax),%eax
 292:	3c 39                	cmp    $0x39,%al
 294:	7e c7                	jle    25d <atoi+0xf>
  return n;
 296:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 299:	c9                   	leave  
 29a:	c3                   	ret    

0000029b <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 29b:	55                   	push   %ebp
 29c:	89 e5                	mov    %esp,%ebp
 29e:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
 2a1:	8b 45 08             	mov    0x8(%ebp),%eax
 2a4:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 2a7:	8b 45 0c             	mov    0xc(%ebp),%eax
 2aa:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 2ad:	eb 17                	jmp    2c6 <memmove+0x2b>
    *dst++ = *src++;
 2af:	8b 55 f8             	mov    -0x8(%ebp),%edx
 2b2:	8d 42 01             	lea    0x1(%edx),%eax
 2b5:	89 45 f8             	mov    %eax,-0x8(%ebp)
 2b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 2bb:	8d 48 01             	lea    0x1(%eax),%ecx
 2be:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 2c1:	0f b6 12             	movzbl (%edx),%edx
 2c4:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 2c6:	8b 45 10             	mov    0x10(%ebp),%eax
 2c9:	8d 50 ff             	lea    -0x1(%eax),%edx
 2cc:	89 55 10             	mov    %edx,0x10(%ebp)
 2cf:	85 c0                	test   %eax,%eax
 2d1:	7f dc                	jg     2af <memmove+0x14>
  return vdst;
 2d3:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2d6:	c9                   	leave  
 2d7:	c3                   	ret    

000002d8 <calc>:

int calc(int num)
{
 2d8:	55                   	push   %ebp
 2d9:	89 e5                	mov    %esp,%ebp
 2db:	83 ec 10             	sub    $0x10,%esp
    int c = 0;
 2de:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for(uint i = 0; i < num; i++)
 2e5:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
 2ec:	eb 36                	jmp    324 <calc+0x4c>
    {
        for(uint j = 0; j < num; j++)
 2ee:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2f5:	eb 21                	jmp    318 <calc+0x40>
        {
            for(uint k = 0; k < num; j++)
 2f7:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 2fe:	eb 0c                	jmp    30c <calc+0x34>
            {
                c >>= 10;
 300:	c1 7d fc 0a          	sarl   $0xa,-0x4(%ebp)
                c <<= 10;
 304:	c1 65 fc 0a          	shll   $0xa,-0x4(%ebp)
            for(uint k = 0; k < num; j++)
 308:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 30c:	8b 45 08             	mov    0x8(%ebp),%eax
 30f:	39 45 f0             	cmp    %eax,-0x10(%ebp)
 312:	72 ec                	jb     300 <calc+0x28>
        for(uint j = 0; j < num; j++)
 314:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 318:	8b 45 08             	mov    0x8(%ebp),%eax
 31b:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 31e:	72 d7                	jb     2f7 <calc+0x1f>
    for(uint i = 0; i < num; i++)
 320:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 324:	8b 45 08             	mov    0x8(%ebp),%eax
 327:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 32a:	72 c2                	jb     2ee <calc+0x16>
            }
        }
    }
    return 0;
 32c:	b8 00 00 00 00       	mov    $0x0,%eax
}
 331:	c9                   	leave  
 332:	c3                   	ret    

00000333 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 333:	b8 01 00 00 00       	mov    $0x1,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <exit>:
SYSCALL(exit)
 33b:	b8 02 00 00 00       	mov    $0x2,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <wait>:
SYSCALL(wait)
 343:	b8 03 00 00 00       	mov    $0x3,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <pipe>:
SYSCALL(pipe)
 34b:	b8 04 00 00 00       	mov    $0x4,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <read>:
SYSCALL(read)
 353:	b8 05 00 00 00       	mov    $0x5,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <write>:
SYSCALL(write)
 35b:	b8 10 00 00 00       	mov    $0x10,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <close>:
SYSCALL(close)
 363:	b8 15 00 00 00       	mov    $0x15,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <kill>:
SYSCALL(kill)
 36b:	b8 06 00 00 00       	mov    $0x6,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <exec>:
SYSCALL(exec)
 373:	b8 07 00 00 00       	mov    $0x7,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <open>:
SYSCALL(open)
 37b:	b8 0f 00 00 00       	mov    $0xf,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <mknod>:
SYSCALL(mknod)
 383:	b8 11 00 00 00       	mov    $0x11,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <unlink>:
SYSCALL(unlink)
 38b:	b8 12 00 00 00       	mov    $0x12,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <fstat>:
SYSCALL(fstat)
 393:	b8 08 00 00 00       	mov    $0x8,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <link>:
SYSCALL(link)
 39b:	b8 13 00 00 00       	mov    $0x13,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <mkdir>:
SYSCALL(mkdir)
 3a3:	b8 14 00 00 00       	mov    $0x14,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <chdir>:
SYSCALL(chdir)
 3ab:	b8 09 00 00 00       	mov    $0x9,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <dup>:
SYSCALL(dup)
 3b3:	b8 0a 00 00 00       	mov    $0xa,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <getpid>:
SYSCALL(getpid)
 3bb:	b8 0b 00 00 00       	mov    $0xb,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <sbrk>:
SYSCALL(sbrk)
 3c3:	b8 0c 00 00 00       	mov    $0xc,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <sleep>:
SYSCALL(sleep)
 3cb:	b8 0d 00 00 00       	mov    $0xd,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <uptime>:
SYSCALL(uptime)
 3d3:	b8 0e 00 00 00       	mov    $0xe,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <print_proc>:
SYSCALL(print_proc)
 3db:	b8 16 00 00 00       	mov    $0x16,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <change_queue>:
SYSCALL(change_queue)
 3e3:	b8 17 00 00 00       	mov    $0x17,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <change_local_bjf>:
SYSCALL(change_local_bjf)
 3eb:	b8 18 00 00 00       	mov    $0x18,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <change_global_bjf>:
SYSCALL(change_global_bjf)
 3f3:	b8 19 00 00 00       	mov    $0x19,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 3fb:	55                   	push   %ebp
 3fc:	89 e5                	mov    %esp,%ebp
 3fe:	83 ec 18             	sub    $0x18,%esp
 401:	8b 45 0c             	mov    0xc(%ebp),%eax
 404:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 407:	83 ec 04             	sub    $0x4,%esp
 40a:	6a 01                	push   $0x1
 40c:	8d 45 f4             	lea    -0xc(%ebp),%eax
 40f:	50                   	push   %eax
 410:	ff 75 08             	push   0x8(%ebp)
 413:	e8 43 ff ff ff       	call   35b <write>
 418:	83 c4 10             	add    $0x10,%esp
}
 41b:	90                   	nop
 41c:	c9                   	leave  
 41d:	c3                   	ret    

0000041e <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 41e:	55                   	push   %ebp
 41f:	89 e5                	mov    %esp,%ebp
 421:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 424:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 42b:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 42f:	74 17                	je     448 <printint+0x2a>
 431:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 435:	79 11                	jns    448 <printint+0x2a>
    neg = 1;
 437:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 43e:	8b 45 0c             	mov    0xc(%ebp),%eax
 441:	f7 d8                	neg    %eax
 443:	89 45 ec             	mov    %eax,-0x14(%ebp)
 446:	eb 06                	jmp    44e <printint+0x30>
  } else {
    x = xx;
 448:	8b 45 0c             	mov    0xc(%ebp),%eax
 44b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 44e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 455:	8b 4d 10             	mov    0x10(%ebp),%ecx
 458:	8b 45 ec             	mov    -0x14(%ebp),%eax
 45b:	ba 00 00 00 00       	mov    $0x0,%edx
 460:	f7 f1                	div    %ecx
 462:	89 d1                	mov    %edx,%ecx
 464:	8b 45 f4             	mov    -0xc(%ebp),%eax
 467:	8d 50 01             	lea    0x1(%eax),%edx
 46a:	89 55 f4             	mov    %edx,-0xc(%ebp)
 46d:	0f b6 91 f8 0a 00 00 	movzbl 0xaf8(%ecx),%edx
 474:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 478:	8b 4d 10             	mov    0x10(%ebp),%ecx
 47b:	8b 45 ec             	mov    -0x14(%ebp),%eax
 47e:	ba 00 00 00 00       	mov    $0x0,%edx
 483:	f7 f1                	div    %ecx
 485:	89 45 ec             	mov    %eax,-0x14(%ebp)
 488:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 48c:	75 c7                	jne    455 <printint+0x37>
  if(neg)
 48e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 492:	74 2d                	je     4c1 <printint+0xa3>
    buf[i++] = '-';
 494:	8b 45 f4             	mov    -0xc(%ebp),%eax
 497:	8d 50 01             	lea    0x1(%eax),%edx
 49a:	89 55 f4             	mov    %edx,-0xc(%ebp)
 49d:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 4a2:	eb 1d                	jmp    4c1 <printint+0xa3>
    putc(fd, buf[i]);
 4a4:	8d 55 dc             	lea    -0x24(%ebp),%edx
 4a7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4aa:	01 d0                	add    %edx,%eax
 4ac:	0f b6 00             	movzbl (%eax),%eax
 4af:	0f be c0             	movsbl %al,%eax
 4b2:	83 ec 08             	sub    $0x8,%esp
 4b5:	50                   	push   %eax
 4b6:	ff 75 08             	push   0x8(%ebp)
 4b9:	e8 3d ff ff ff       	call   3fb <putc>
 4be:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 4c1:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 4c5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4c9:	79 d9                	jns    4a4 <printint+0x86>
}
 4cb:	90                   	nop
 4cc:	90                   	nop
 4cd:	c9                   	leave  
 4ce:	c3                   	ret    

000004cf <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 4cf:	55                   	push   %ebp
 4d0:	89 e5                	mov    %esp,%ebp
 4d2:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 4d5:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 4dc:	8d 45 0c             	lea    0xc(%ebp),%eax
 4df:	83 c0 04             	add    $0x4,%eax
 4e2:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 4e5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 4ec:	e9 59 01 00 00       	jmp    64a <printf+0x17b>
    c = fmt[i] & 0xff;
 4f1:	8b 55 0c             	mov    0xc(%ebp),%edx
 4f4:	8b 45 f0             	mov    -0x10(%ebp),%eax
 4f7:	01 d0                	add    %edx,%eax
 4f9:	0f b6 00             	movzbl (%eax),%eax
 4fc:	0f be c0             	movsbl %al,%eax
 4ff:	25 ff 00 00 00       	and    $0xff,%eax
 504:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 507:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 50b:	75 2c                	jne    539 <printf+0x6a>
      if(c == '%'){
 50d:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 511:	75 0c                	jne    51f <printf+0x50>
        state = '%';
 513:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 51a:	e9 27 01 00 00       	jmp    646 <printf+0x177>
      } else {
        putc(fd, c);
 51f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 522:	0f be c0             	movsbl %al,%eax
 525:	83 ec 08             	sub    $0x8,%esp
 528:	50                   	push   %eax
 529:	ff 75 08             	push   0x8(%ebp)
 52c:	e8 ca fe ff ff       	call   3fb <putc>
 531:	83 c4 10             	add    $0x10,%esp
 534:	e9 0d 01 00 00       	jmp    646 <printf+0x177>
      }
    } else if(state == '%'){
 539:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 53d:	0f 85 03 01 00 00    	jne    646 <printf+0x177>
      if(c == 'd'){
 543:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 547:	75 1e                	jne    567 <printf+0x98>
        printint(fd, *ap, 10, 1);
 549:	8b 45 e8             	mov    -0x18(%ebp),%eax
 54c:	8b 00                	mov    (%eax),%eax
 54e:	6a 01                	push   $0x1
 550:	6a 0a                	push   $0xa
 552:	50                   	push   %eax
 553:	ff 75 08             	push   0x8(%ebp)
 556:	e8 c3 fe ff ff       	call   41e <printint>
 55b:	83 c4 10             	add    $0x10,%esp
        ap++;
 55e:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 562:	e9 d8 00 00 00       	jmp    63f <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 567:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 56b:	74 06                	je     573 <printf+0xa4>
 56d:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 571:	75 1e                	jne    591 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 573:	8b 45 e8             	mov    -0x18(%ebp),%eax
 576:	8b 00                	mov    (%eax),%eax
 578:	6a 00                	push   $0x0
 57a:	6a 10                	push   $0x10
 57c:	50                   	push   %eax
 57d:	ff 75 08             	push   0x8(%ebp)
 580:	e8 99 fe ff ff       	call   41e <printint>
 585:	83 c4 10             	add    $0x10,%esp
        ap++;
 588:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 58c:	e9 ae 00 00 00       	jmp    63f <printf+0x170>
      } else if(c == 's'){
 591:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 595:	75 43                	jne    5da <printf+0x10b>
        s = (char*)*ap;
 597:	8b 45 e8             	mov    -0x18(%ebp),%eax
 59a:	8b 00                	mov    (%eax),%eax
 59c:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 59f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 5a3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5a7:	75 25                	jne    5ce <printf+0xff>
          s = "(null)";
 5a9:	c7 45 f4 86 08 00 00 	movl   $0x886,-0xc(%ebp)
        while(*s != 0){
 5b0:	eb 1c                	jmp    5ce <printf+0xff>
          putc(fd, *s);
 5b2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5b5:	0f b6 00             	movzbl (%eax),%eax
 5b8:	0f be c0             	movsbl %al,%eax
 5bb:	83 ec 08             	sub    $0x8,%esp
 5be:	50                   	push   %eax
 5bf:	ff 75 08             	push   0x8(%ebp)
 5c2:	e8 34 fe ff ff       	call   3fb <putc>
 5c7:	83 c4 10             	add    $0x10,%esp
          s++;
 5ca:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 5ce:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5d1:	0f b6 00             	movzbl (%eax),%eax
 5d4:	84 c0                	test   %al,%al
 5d6:	75 da                	jne    5b2 <printf+0xe3>
 5d8:	eb 65                	jmp    63f <printf+0x170>
        }
      } else if(c == 'c'){
 5da:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 5de:	75 1d                	jne    5fd <printf+0x12e>
        putc(fd, *ap);
 5e0:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5e3:	8b 00                	mov    (%eax),%eax
 5e5:	0f be c0             	movsbl %al,%eax
 5e8:	83 ec 08             	sub    $0x8,%esp
 5eb:	50                   	push   %eax
 5ec:	ff 75 08             	push   0x8(%ebp)
 5ef:	e8 07 fe ff ff       	call   3fb <putc>
 5f4:	83 c4 10             	add    $0x10,%esp
        ap++;
 5f7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5fb:	eb 42                	jmp    63f <printf+0x170>
      } else if(c == '%'){
 5fd:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 601:	75 17                	jne    61a <printf+0x14b>
        putc(fd, c);
 603:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 606:	0f be c0             	movsbl %al,%eax
 609:	83 ec 08             	sub    $0x8,%esp
 60c:	50                   	push   %eax
 60d:	ff 75 08             	push   0x8(%ebp)
 610:	e8 e6 fd ff ff       	call   3fb <putc>
 615:	83 c4 10             	add    $0x10,%esp
 618:	eb 25                	jmp    63f <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 61a:	83 ec 08             	sub    $0x8,%esp
 61d:	6a 25                	push   $0x25
 61f:	ff 75 08             	push   0x8(%ebp)
 622:	e8 d4 fd ff ff       	call   3fb <putc>
 627:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 62a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 62d:	0f be c0             	movsbl %al,%eax
 630:	83 ec 08             	sub    $0x8,%esp
 633:	50                   	push   %eax
 634:	ff 75 08             	push   0x8(%ebp)
 637:	e8 bf fd ff ff       	call   3fb <putc>
 63c:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 63f:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 646:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 64a:	8b 55 0c             	mov    0xc(%ebp),%edx
 64d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 650:	01 d0                	add    %edx,%eax
 652:	0f b6 00             	movzbl (%eax),%eax
 655:	84 c0                	test   %al,%al
 657:	0f 85 94 fe ff ff    	jne    4f1 <printf+0x22>
    }
  }
}
 65d:	90                   	nop
 65e:	90                   	nop
 65f:	c9                   	leave  
 660:	c3                   	ret    

00000661 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 661:	55                   	push   %ebp
 662:	89 e5                	mov    %esp,%ebp
 664:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 667:	8b 45 08             	mov    0x8(%ebp),%eax
 66a:	83 e8 08             	sub    $0x8,%eax
 66d:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 670:	a1 14 0b 00 00       	mov    0xb14,%eax
 675:	89 45 fc             	mov    %eax,-0x4(%ebp)
 678:	eb 24                	jmp    69e <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 67a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 67d:	8b 00                	mov    (%eax),%eax
 67f:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 682:	72 12                	jb     696 <free+0x35>
 684:	8b 45 f8             	mov    -0x8(%ebp),%eax
 687:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 68a:	77 24                	ja     6b0 <free+0x4f>
 68c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 68f:	8b 00                	mov    (%eax),%eax
 691:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 694:	72 1a                	jb     6b0 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 696:	8b 45 fc             	mov    -0x4(%ebp),%eax
 699:	8b 00                	mov    (%eax),%eax
 69b:	89 45 fc             	mov    %eax,-0x4(%ebp)
 69e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6a1:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 6a4:	76 d4                	jbe    67a <free+0x19>
 6a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6a9:	8b 00                	mov    (%eax),%eax
 6ab:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 6ae:	73 ca                	jae    67a <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 6b0:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6b3:	8b 40 04             	mov    0x4(%eax),%eax
 6b6:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 6bd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6c0:	01 c2                	add    %eax,%edx
 6c2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6c5:	8b 00                	mov    (%eax),%eax
 6c7:	39 c2                	cmp    %eax,%edx
 6c9:	75 24                	jne    6ef <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 6cb:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6ce:	8b 50 04             	mov    0x4(%eax),%edx
 6d1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6d4:	8b 00                	mov    (%eax),%eax
 6d6:	8b 40 04             	mov    0x4(%eax),%eax
 6d9:	01 c2                	add    %eax,%edx
 6db:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6de:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 6e1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6e4:	8b 00                	mov    (%eax),%eax
 6e6:	8b 10                	mov    (%eax),%edx
 6e8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6eb:	89 10                	mov    %edx,(%eax)
 6ed:	eb 0a                	jmp    6f9 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 6ef:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6f2:	8b 10                	mov    (%eax),%edx
 6f4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 6f7:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 6f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 6fc:	8b 40 04             	mov    0x4(%eax),%eax
 6ff:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 706:	8b 45 fc             	mov    -0x4(%ebp),%eax
 709:	01 d0                	add    %edx,%eax
 70b:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 70e:	75 20                	jne    730 <free+0xcf>
    p->s.size += bp->s.size;
 710:	8b 45 fc             	mov    -0x4(%ebp),%eax
 713:	8b 50 04             	mov    0x4(%eax),%edx
 716:	8b 45 f8             	mov    -0x8(%ebp),%eax
 719:	8b 40 04             	mov    0x4(%eax),%eax
 71c:	01 c2                	add    %eax,%edx
 71e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 721:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 724:	8b 45 f8             	mov    -0x8(%ebp),%eax
 727:	8b 10                	mov    (%eax),%edx
 729:	8b 45 fc             	mov    -0x4(%ebp),%eax
 72c:	89 10                	mov    %edx,(%eax)
 72e:	eb 08                	jmp    738 <free+0xd7>
  } else
    p->s.ptr = bp;
 730:	8b 45 fc             	mov    -0x4(%ebp),%eax
 733:	8b 55 f8             	mov    -0x8(%ebp),%edx
 736:	89 10                	mov    %edx,(%eax)
  freep = p;
 738:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73b:	a3 14 0b 00 00       	mov    %eax,0xb14
}
 740:	90                   	nop
 741:	c9                   	leave  
 742:	c3                   	ret    

00000743 <morecore>:

static Header*
morecore(uint nu)
{
 743:	55                   	push   %ebp
 744:	89 e5                	mov    %esp,%ebp
 746:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 749:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 750:	77 07                	ja     759 <morecore+0x16>
    nu = 4096;
 752:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 759:	8b 45 08             	mov    0x8(%ebp),%eax
 75c:	c1 e0 03             	shl    $0x3,%eax
 75f:	83 ec 0c             	sub    $0xc,%esp
 762:	50                   	push   %eax
 763:	e8 5b fc ff ff       	call   3c3 <sbrk>
 768:	83 c4 10             	add    $0x10,%esp
 76b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 76e:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 772:	75 07                	jne    77b <morecore+0x38>
    return 0;
 774:	b8 00 00 00 00       	mov    $0x0,%eax
 779:	eb 26                	jmp    7a1 <morecore+0x5e>
  hp = (Header*)p;
 77b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 77e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 781:	8b 45 f0             	mov    -0x10(%ebp),%eax
 784:	8b 55 08             	mov    0x8(%ebp),%edx
 787:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 78a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 78d:	83 c0 08             	add    $0x8,%eax
 790:	83 ec 0c             	sub    $0xc,%esp
 793:	50                   	push   %eax
 794:	e8 c8 fe ff ff       	call   661 <free>
 799:	83 c4 10             	add    $0x10,%esp
  return freep;
 79c:	a1 14 0b 00 00       	mov    0xb14,%eax
}
 7a1:	c9                   	leave  
 7a2:	c3                   	ret    

000007a3 <malloc>:

void*
malloc(uint nbytes)
{
 7a3:	55                   	push   %ebp
 7a4:	89 e5                	mov    %esp,%ebp
 7a6:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 7a9:	8b 45 08             	mov    0x8(%ebp),%eax
 7ac:	83 c0 07             	add    $0x7,%eax
 7af:	c1 e8 03             	shr    $0x3,%eax
 7b2:	83 c0 01             	add    $0x1,%eax
 7b5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 7b8:	a1 14 0b 00 00       	mov    0xb14,%eax
 7bd:	89 45 f0             	mov    %eax,-0x10(%ebp)
 7c0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 7c4:	75 23                	jne    7e9 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 7c6:	c7 45 f0 0c 0b 00 00 	movl   $0xb0c,-0x10(%ebp)
 7cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7d0:	a3 14 0b 00 00       	mov    %eax,0xb14
 7d5:	a1 14 0b 00 00       	mov    0xb14,%eax
 7da:	a3 0c 0b 00 00       	mov    %eax,0xb0c
    base.s.size = 0;
 7df:	c7 05 10 0b 00 00 00 	movl   $0x0,0xb10
 7e6:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 7e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7ec:	8b 00                	mov    (%eax),%eax
 7ee:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 7f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7f4:	8b 40 04             	mov    0x4(%eax),%eax
 7f7:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 7fa:	77 4d                	ja     849 <malloc+0xa6>
      if(p->s.size == nunits)
 7fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 7ff:	8b 40 04             	mov    0x4(%eax),%eax
 802:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 805:	75 0c                	jne    813 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 807:	8b 45 f4             	mov    -0xc(%ebp),%eax
 80a:	8b 10                	mov    (%eax),%edx
 80c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 80f:	89 10                	mov    %edx,(%eax)
 811:	eb 26                	jmp    839 <malloc+0x96>
      else {
        p->s.size -= nunits;
 813:	8b 45 f4             	mov    -0xc(%ebp),%eax
 816:	8b 40 04             	mov    0x4(%eax),%eax
 819:	2b 45 ec             	sub    -0x14(%ebp),%eax
 81c:	89 c2                	mov    %eax,%edx
 81e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 821:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 824:	8b 45 f4             	mov    -0xc(%ebp),%eax
 827:	8b 40 04             	mov    0x4(%eax),%eax
 82a:	c1 e0 03             	shl    $0x3,%eax
 82d:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 830:	8b 45 f4             	mov    -0xc(%ebp),%eax
 833:	8b 55 ec             	mov    -0x14(%ebp),%edx
 836:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 839:	8b 45 f0             	mov    -0x10(%ebp),%eax
 83c:	a3 14 0b 00 00       	mov    %eax,0xb14
      return (void*)(p + 1);
 841:	8b 45 f4             	mov    -0xc(%ebp),%eax
 844:	83 c0 08             	add    $0x8,%eax
 847:	eb 3b                	jmp    884 <malloc+0xe1>
    }
    if(p == freep)
 849:	a1 14 0b 00 00       	mov    0xb14,%eax
 84e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 851:	75 1e                	jne    871 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 853:	83 ec 0c             	sub    $0xc,%esp
 856:	ff 75 ec             	push   -0x14(%ebp)
 859:	e8 e5 fe ff ff       	call   743 <morecore>
 85e:	83 c4 10             	add    $0x10,%esp
 861:	89 45 f4             	mov    %eax,-0xc(%ebp)
 864:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 868:	75 07                	jne    871 <malloc+0xce>
        return 0;
 86a:	b8 00 00 00 00       	mov    $0x0,%eax
 86f:	eb 13                	jmp    884 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 871:	8b 45 f4             	mov    -0xc(%ebp),%eax
 874:	89 45 f0             	mov    %eax,-0x10(%ebp)
 877:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87a:	8b 00                	mov    (%eax),%eax
 87c:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 87f:	e9 6d ff ff ff       	jmp    7f1 <malloc+0x4e>
  }
}
 884:	c9                   	leave  
 885:	c3                   	ret    
