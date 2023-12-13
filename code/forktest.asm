
_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <printf>:

#define N  1000

void
printf(int fd, const char *s, ...)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 08             	sub    $0x8,%esp
  write(fd, s, strlen(s));
   6:	83 ec 0c             	sub    $0xc,%esp
   9:	ff 75 0c             	push   0xc(%ebp)
   c:	e8 8c 01 00 00       	call   19d <strlen>
  11:	83 c4 10             	add    $0x10,%esp
  14:	83 ec 04             	sub    $0x4,%esp
  17:	50                   	push   %eax
  18:	ff 75 0c             	push   0xc(%ebp)
  1b:	ff 75 08             	push   0x8(%ebp)
  1e:	e8 b7 03 00 00       	call   3da <write>
  23:	83 c4 10             	add    $0x10,%esp
}
  26:	90                   	nop
  27:	c9                   	leave  
  28:	c3                   	ret    

00000029 <forktest>:

void
forktest(void)
{
  29:	55                   	push   %ebp
  2a:	89 e5                	mov    %esp,%ebp
  2c:	83 ec 18             	sub    $0x18,%esp
  int n, pid;

  printf(1, "fork test\n");
  2f:	83 ec 08             	sub    $0x8,%esp
  32:	68 7c 04 00 00       	push   $0x47c
  37:	6a 01                	push   $0x1
  39:	e8 c2 ff ff ff       	call   0 <printf>
  3e:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<N; n++){
  41:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  48:	eb 1d                	jmp    67 <forktest+0x3e>
    pid = fork();
  4a:	e8 63 03 00 00       	call   3b2 <fork>
  4f:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0)
  52:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  56:	78 1a                	js     72 <forktest+0x49>
      break;
    if(pid == 0)
  58:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  5c:	75 05                	jne    63 <forktest+0x3a>
      exit();
  5e:	e8 57 03 00 00       	call   3ba <exit>
  for(n=0; n<N; n++){
  63:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  67:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
  6e:	7e da                	jle    4a <forktest+0x21>
  70:	eb 01                	jmp    73 <forktest+0x4a>
      break;
  72:	90                   	nop
  }

  if(n == N){
  73:	81 7d f4 e8 03 00 00 	cmpl   $0x3e8,-0xc(%ebp)
  7a:	75 40                	jne    bc <forktest+0x93>
    printf(1, "fork claimed to work N times!\n", N);
  7c:	83 ec 04             	sub    $0x4,%esp
  7f:	68 e8 03 00 00       	push   $0x3e8
  84:	68 88 04 00 00       	push   $0x488
  89:	6a 01                	push   $0x1
  8b:	e8 70 ff ff ff       	call   0 <printf>
  90:	83 c4 10             	add    $0x10,%esp
    exit();
  93:	e8 22 03 00 00       	call   3ba <exit>
  }

  for(; n > 0; n--){
    if(wait() < 0){
  98:	e8 25 03 00 00       	call   3c2 <wait>
  9d:	85 c0                	test   %eax,%eax
  9f:	79 17                	jns    b8 <forktest+0x8f>
      printf(1, "wait stopped early\n");
  a1:	83 ec 08             	sub    $0x8,%esp
  a4:	68 a7 04 00 00       	push   $0x4a7
  a9:	6a 01                	push   $0x1
  ab:	e8 50 ff ff ff       	call   0 <printf>
  b0:	83 c4 10             	add    $0x10,%esp
      exit();
  b3:	e8 02 03 00 00       	call   3ba <exit>
  for(; n > 0; n--){
  b8:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  c0:	7f d6                	jg     98 <forktest+0x6f>
    }
  }

  if(wait() != -1){
  c2:	e8 fb 02 00 00       	call   3c2 <wait>
  c7:	83 f8 ff             	cmp    $0xffffffff,%eax
  ca:	74 17                	je     e3 <forktest+0xba>
    printf(1, "wait got too many\n");
  cc:	83 ec 08             	sub    $0x8,%esp
  cf:	68 bb 04 00 00       	push   $0x4bb
  d4:	6a 01                	push   $0x1
  d6:	e8 25 ff ff ff       	call   0 <printf>
  db:	83 c4 10             	add    $0x10,%esp
    exit();
  de:	e8 d7 02 00 00       	call   3ba <exit>
  }

  printf(1, "fork test OK\n");
  e3:	83 ec 08             	sub    $0x8,%esp
  e6:	68 ce 04 00 00       	push   $0x4ce
  eb:	6a 01                	push   $0x1
  ed:	e8 0e ff ff ff       	call   0 <printf>
  f2:	83 c4 10             	add    $0x10,%esp
}
  f5:	90                   	nop
  f6:	c9                   	leave  
  f7:	c3                   	ret    

000000f8 <main>:

int
main(void)
{
  f8:	55                   	push   %ebp
  f9:	89 e5                	mov    %esp,%ebp
  fb:	83 e4 f0             	and    $0xfffffff0,%esp
  forktest();
  fe:	e8 26 ff ff ff       	call   29 <forktest>
  exit();
 103:	e8 b2 02 00 00       	call   3ba <exit>

00000108 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 108:	55                   	push   %ebp
 109:	89 e5                	mov    %esp,%ebp
 10b:	57                   	push   %edi
 10c:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 10d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 110:	8b 55 10             	mov    0x10(%ebp),%edx
 113:	8b 45 0c             	mov    0xc(%ebp),%eax
 116:	89 cb                	mov    %ecx,%ebx
 118:	89 df                	mov    %ebx,%edi
 11a:	89 d1                	mov    %edx,%ecx
 11c:	fc                   	cld    
 11d:	f3 aa                	rep stos %al,%es:(%edi)
 11f:	89 ca                	mov    %ecx,%edx
 121:	89 fb                	mov    %edi,%ebx
 123:	89 5d 08             	mov    %ebx,0x8(%ebp)
 126:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 129:	90                   	nop
 12a:	5b                   	pop    %ebx
 12b:	5f                   	pop    %edi
 12c:	5d                   	pop    %ebp
 12d:	c3                   	ret    

0000012e <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 12e:	55                   	push   %ebp
 12f:	89 e5                	mov    %esp,%ebp
 131:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 134:	8b 45 08             	mov    0x8(%ebp),%eax
 137:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 13a:	90                   	nop
 13b:	8b 55 0c             	mov    0xc(%ebp),%edx
 13e:	8d 42 01             	lea    0x1(%edx),%eax
 141:	89 45 0c             	mov    %eax,0xc(%ebp)
 144:	8b 45 08             	mov    0x8(%ebp),%eax
 147:	8d 48 01             	lea    0x1(%eax),%ecx
 14a:	89 4d 08             	mov    %ecx,0x8(%ebp)
 14d:	0f b6 12             	movzbl (%edx),%edx
 150:	88 10                	mov    %dl,(%eax)
 152:	0f b6 00             	movzbl (%eax),%eax
 155:	84 c0                	test   %al,%al
 157:	75 e2                	jne    13b <strcpy+0xd>
    ;
  return os;
 159:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 15c:	c9                   	leave  
 15d:	c3                   	ret    

0000015e <strcmp>:

int
strcmp(const char *p, const char *q)
{
 15e:	55                   	push   %ebp
 15f:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 161:	eb 08                	jmp    16b <strcmp+0xd>
    p++, q++;
 163:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 167:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 16b:	8b 45 08             	mov    0x8(%ebp),%eax
 16e:	0f b6 00             	movzbl (%eax),%eax
 171:	84 c0                	test   %al,%al
 173:	74 10                	je     185 <strcmp+0x27>
 175:	8b 45 08             	mov    0x8(%ebp),%eax
 178:	0f b6 10             	movzbl (%eax),%edx
 17b:	8b 45 0c             	mov    0xc(%ebp),%eax
 17e:	0f b6 00             	movzbl (%eax),%eax
 181:	38 c2                	cmp    %al,%dl
 183:	74 de                	je     163 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 185:	8b 45 08             	mov    0x8(%ebp),%eax
 188:	0f b6 00             	movzbl (%eax),%eax
 18b:	0f b6 d0             	movzbl %al,%edx
 18e:	8b 45 0c             	mov    0xc(%ebp),%eax
 191:	0f b6 00             	movzbl (%eax),%eax
 194:	0f b6 c8             	movzbl %al,%ecx
 197:	89 d0                	mov    %edx,%eax
 199:	29 c8                	sub    %ecx,%eax
}
 19b:	5d                   	pop    %ebp
 19c:	c3                   	ret    

0000019d <strlen>:

uint
strlen(const char *s)
{
 19d:	55                   	push   %ebp
 19e:	89 e5                	mov    %esp,%ebp
 1a0:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1a3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1aa:	eb 04                	jmp    1b0 <strlen+0x13>
 1ac:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1b0:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1b3:	8b 45 08             	mov    0x8(%ebp),%eax
 1b6:	01 d0                	add    %edx,%eax
 1b8:	0f b6 00             	movzbl (%eax),%eax
 1bb:	84 c0                	test   %al,%al
 1bd:	75 ed                	jne    1ac <strlen+0xf>
    ;
  return n;
 1bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1c2:	c9                   	leave  
 1c3:	c3                   	ret    

000001c4 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1c4:	55                   	push   %ebp
 1c5:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1c7:	8b 45 10             	mov    0x10(%ebp),%eax
 1ca:	50                   	push   %eax
 1cb:	ff 75 0c             	push   0xc(%ebp)
 1ce:	ff 75 08             	push   0x8(%ebp)
 1d1:	e8 32 ff ff ff       	call   108 <stosb>
 1d6:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1d9:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1dc:	c9                   	leave  
 1dd:	c3                   	ret    

000001de <strchr>:

char*
strchr(const char *s, char c)
{
 1de:	55                   	push   %ebp
 1df:	89 e5                	mov    %esp,%ebp
 1e1:	83 ec 04             	sub    $0x4,%esp
 1e4:	8b 45 0c             	mov    0xc(%ebp),%eax
 1e7:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 1ea:	eb 14                	jmp    200 <strchr+0x22>
    if(*s == c)
 1ec:	8b 45 08             	mov    0x8(%ebp),%eax
 1ef:	0f b6 00             	movzbl (%eax),%eax
 1f2:	38 45 fc             	cmp    %al,-0x4(%ebp)
 1f5:	75 05                	jne    1fc <strchr+0x1e>
      return (char*)s;
 1f7:	8b 45 08             	mov    0x8(%ebp),%eax
 1fa:	eb 13                	jmp    20f <strchr+0x31>
  for(; *s; s++)
 1fc:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 200:	8b 45 08             	mov    0x8(%ebp),%eax
 203:	0f b6 00             	movzbl (%eax),%eax
 206:	84 c0                	test   %al,%al
 208:	75 e2                	jne    1ec <strchr+0xe>
  return 0;
 20a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 20f:	c9                   	leave  
 210:	c3                   	ret    

00000211 <gets>:

char*
gets(char *buf, int max)
{
 211:	55                   	push   %ebp
 212:	89 e5                	mov    %esp,%ebp
 214:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 217:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 21e:	eb 42                	jmp    262 <gets+0x51>
    cc = read(0, &c, 1);
 220:	83 ec 04             	sub    $0x4,%esp
 223:	6a 01                	push   $0x1
 225:	8d 45 ef             	lea    -0x11(%ebp),%eax
 228:	50                   	push   %eax
 229:	6a 00                	push   $0x0
 22b:	e8 a2 01 00 00       	call   3d2 <read>
 230:	83 c4 10             	add    $0x10,%esp
 233:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 236:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 23a:	7e 33                	jle    26f <gets+0x5e>
      break;
    buf[i++] = c;
 23c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 23f:	8d 50 01             	lea    0x1(%eax),%edx
 242:	89 55 f4             	mov    %edx,-0xc(%ebp)
 245:	89 c2                	mov    %eax,%edx
 247:	8b 45 08             	mov    0x8(%ebp),%eax
 24a:	01 c2                	add    %eax,%edx
 24c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 250:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 252:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 256:	3c 0a                	cmp    $0xa,%al
 258:	74 16                	je     270 <gets+0x5f>
 25a:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 25e:	3c 0d                	cmp    $0xd,%al
 260:	74 0e                	je     270 <gets+0x5f>
  for(i=0; i+1 < max; ){
 262:	8b 45 f4             	mov    -0xc(%ebp),%eax
 265:	83 c0 01             	add    $0x1,%eax
 268:	39 45 0c             	cmp    %eax,0xc(%ebp)
 26b:	7f b3                	jg     220 <gets+0xf>
 26d:	eb 01                	jmp    270 <gets+0x5f>
      break;
 26f:	90                   	nop
      break;
  }
  buf[i] = '\0';
 270:	8b 55 f4             	mov    -0xc(%ebp),%edx
 273:	8b 45 08             	mov    0x8(%ebp),%eax
 276:	01 d0                	add    %edx,%eax
 278:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 27b:	8b 45 08             	mov    0x8(%ebp),%eax
}
 27e:	c9                   	leave  
 27f:	c3                   	ret    

00000280 <stat>:

int
stat(const char *n, struct stat *st)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 286:	83 ec 08             	sub    $0x8,%esp
 289:	6a 00                	push   $0x0
 28b:	ff 75 08             	push   0x8(%ebp)
 28e:	e8 67 01 00 00       	call   3fa <open>
 293:	83 c4 10             	add    $0x10,%esp
 296:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 299:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 29d:	79 07                	jns    2a6 <stat+0x26>
    return -1;
 29f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2a4:	eb 25                	jmp    2cb <stat+0x4b>
  r = fstat(fd, st);
 2a6:	83 ec 08             	sub    $0x8,%esp
 2a9:	ff 75 0c             	push   0xc(%ebp)
 2ac:	ff 75 f4             	push   -0xc(%ebp)
 2af:	e8 5e 01 00 00       	call   412 <fstat>
 2b4:	83 c4 10             	add    $0x10,%esp
 2b7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2ba:	83 ec 0c             	sub    $0xc,%esp
 2bd:	ff 75 f4             	push   -0xc(%ebp)
 2c0:	e8 1d 01 00 00       	call   3e2 <close>
 2c5:	83 c4 10             	add    $0x10,%esp
  return r;
 2c8:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2cb:	c9                   	leave  
 2cc:	c3                   	ret    

000002cd <atoi>:

int
atoi(const char *s)
{
 2cd:	55                   	push   %ebp
 2ce:	89 e5                	mov    %esp,%ebp
 2d0:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2d3:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2da:	eb 25                	jmp    301 <atoi+0x34>
    n = n*10 + *s++ - '0';
 2dc:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2df:	89 d0                	mov    %edx,%eax
 2e1:	c1 e0 02             	shl    $0x2,%eax
 2e4:	01 d0                	add    %edx,%eax
 2e6:	01 c0                	add    %eax,%eax
 2e8:	89 c1                	mov    %eax,%ecx
 2ea:	8b 45 08             	mov    0x8(%ebp),%eax
 2ed:	8d 50 01             	lea    0x1(%eax),%edx
 2f0:	89 55 08             	mov    %edx,0x8(%ebp)
 2f3:	0f b6 00             	movzbl (%eax),%eax
 2f6:	0f be c0             	movsbl %al,%eax
 2f9:	01 c8                	add    %ecx,%eax
 2fb:	83 e8 30             	sub    $0x30,%eax
 2fe:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 301:	8b 45 08             	mov    0x8(%ebp),%eax
 304:	0f b6 00             	movzbl (%eax),%eax
 307:	3c 2f                	cmp    $0x2f,%al
 309:	7e 0a                	jle    315 <atoi+0x48>
 30b:	8b 45 08             	mov    0x8(%ebp),%eax
 30e:	0f b6 00             	movzbl (%eax),%eax
 311:	3c 39                	cmp    $0x39,%al
 313:	7e c7                	jle    2dc <atoi+0xf>
  return n;
 315:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 318:	c9                   	leave  
 319:	c3                   	ret    

0000031a <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 31a:	55                   	push   %ebp
 31b:	89 e5                	mov    %esp,%ebp
 31d:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
 320:	8b 45 08             	mov    0x8(%ebp),%eax
 323:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 326:	8b 45 0c             	mov    0xc(%ebp),%eax
 329:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 32c:	eb 17                	jmp    345 <memmove+0x2b>
    *dst++ = *src++;
 32e:	8b 55 f8             	mov    -0x8(%ebp),%edx
 331:	8d 42 01             	lea    0x1(%edx),%eax
 334:	89 45 f8             	mov    %eax,-0x8(%ebp)
 337:	8b 45 fc             	mov    -0x4(%ebp),%eax
 33a:	8d 48 01             	lea    0x1(%eax),%ecx
 33d:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 340:	0f b6 12             	movzbl (%edx),%edx
 343:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 345:	8b 45 10             	mov    0x10(%ebp),%eax
 348:	8d 50 ff             	lea    -0x1(%eax),%edx
 34b:	89 55 10             	mov    %edx,0x10(%ebp)
 34e:	85 c0                	test   %eax,%eax
 350:	7f dc                	jg     32e <memmove+0x14>
  return vdst;
 352:	8b 45 08             	mov    0x8(%ebp),%eax
}
 355:	c9                   	leave  
 356:	c3                   	ret    

00000357 <calc>:

int calc(int num)
{
 357:	55                   	push   %ebp
 358:	89 e5                	mov    %esp,%ebp
 35a:	83 ec 10             	sub    $0x10,%esp
    int c = 0;
 35d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for(uint i = 0; i < num; i++)
 364:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
 36b:	eb 36                	jmp    3a3 <calc+0x4c>
    {
        for(uint j = 0; j < num; j++)
 36d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 374:	eb 21                	jmp    397 <calc+0x40>
        {
            for(uint k = 0; k < num; j++)
 376:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 37d:	eb 0c                	jmp    38b <calc+0x34>
            {
                c >>= 10;
 37f:	c1 7d fc 0a          	sarl   $0xa,-0x4(%ebp)
                c <<= 10;
 383:	c1 65 fc 0a          	shll   $0xa,-0x4(%ebp)
            for(uint k = 0; k < num; j++)
 387:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 38b:	8b 45 08             	mov    0x8(%ebp),%eax
 38e:	39 45 f0             	cmp    %eax,-0x10(%ebp)
 391:	72 ec                	jb     37f <calc+0x28>
        for(uint j = 0; j < num; j++)
 393:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 397:	8b 45 08             	mov    0x8(%ebp),%eax
 39a:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 39d:	72 d7                	jb     376 <calc+0x1f>
    for(uint i = 0; i < num; i++)
 39f:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 3a3:	8b 45 08             	mov    0x8(%ebp),%eax
 3a6:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 3a9:	72 c2                	jb     36d <calc+0x16>
            }
        }
    }
    return 0;
 3ab:	b8 00 00 00 00       	mov    $0x0,%eax
}
 3b0:	c9                   	leave  
 3b1:	c3                   	ret    

000003b2 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3b2:	b8 01 00 00 00       	mov    $0x1,%eax
 3b7:	cd 40                	int    $0x40
 3b9:	c3                   	ret    

000003ba <exit>:
SYSCALL(exit)
 3ba:	b8 02 00 00 00       	mov    $0x2,%eax
 3bf:	cd 40                	int    $0x40
 3c1:	c3                   	ret    

000003c2 <wait>:
SYSCALL(wait)
 3c2:	b8 03 00 00 00       	mov    $0x3,%eax
 3c7:	cd 40                	int    $0x40
 3c9:	c3                   	ret    

000003ca <pipe>:
SYSCALL(pipe)
 3ca:	b8 04 00 00 00       	mov    $0x4,%eax
 3cf:	cd 40                	int    $0x40
 3d1:	c3                   	ret    

000003d2 <read>:
SYSCALL(read)
 3d2:	b8 05 00 00 00       	mov    $0x5,%eax
 3d7:	cd 40                	int    $0x40
 3d9:	c3                   	ret    

000003da <write>:
SYSCALL(write)
 3da:	b8 10 00 00 00       	mov    $0x10,%eax
 3df:	cd 40                	int    $0x40
 3e1:	c3                   	ret    

000003e2 <close>:
SYSCALL(close)
 3e2:	b8 15 00 00 00       	mov    $0x15,%eax
 3e7:	cd 40                	int    $0x40
 3e9:	c3                   	ret    

000003ea <kill>:
SYSCALL(kill)
 3ea:	b8 06 00 00 00       	mov    $0x6,%eax
 3ef:	cd 40                	int    $0x40
 3f1:	c3                   	ret    

000003f2 <exec>:
SYSCALL(exec)
 3f2:	b8 07 00 00 00       	mov    $0x7,%eax
 3f7:	cd 40                	int    $0x40
 3f9:	c3                   	ret    

000003fa <open>:
SYSCALL(open)
 3fa:	b8 0f 00 00 00       	mov    $0xf,%eax
 3ff:	cd 40                	int    $0x40
 401:	c3                   	ret    

00000402 <mknod>:
SYSCALL(mknod)
 402:	b8 11 00 00 00       	mov    $0x11,%eax
 407:	cd 40                	int    $0x40
 409:	c3                   	ret    

0000040a <unlink>:
SYSCALL(unlink)
 40a:	b8 12 00 00 00       	mov    $0x12,%eax
 40f:	cd 40                	int    $0x40
 411:	c3                   	ret    

00000412 <fstat>:
SYSCALL(fstat)
 412:	b8 08 00 00 00       	mov    $0x8,%eax
 417:	cd 40                	int    $0x40
 419:	c3                   	ret    

0000041a <link>:
SYSCALL(link)
 41a:	b8 13 00 00 00       	mov    $0x13,%eax
 41f:	cd 40                	int    $0x40
 421:	c3                   	ret    

00000422 <mkdir>:
SYSCALL(mkdir)
 422:	b8 14 00 00 00       	mov    $0x14,%eax
 427:	cd 40                	int    $0x40
 429:	c3                   	ret    

0000042a <chdir>:
SYSCALL(chdir)
 42a:	b8 09 00 00 00       	mov    $0x9,%eax
 42f:	cd 40                	int    $0x40
 431:	c3                   	ret    

00000432 <dup>:
SYSCALL(dup)
 432:	b8 0a 00 00 00       	mov    $0xa,%eax
 437:	cd 40                	int    $0x40
 439:	c3                   	ret    

0000043a <getpid>:
SYSCALL(getpid)
 43a:	b8 0b 00 00 00       	mov    $0xb,%eax
 43f:	cd 40                	int    $0x40
 441:	c3                   	ret    

00000442 <sbrk>:
SYSCALL(sbrk)
 442:	b8 0c 00 00 00       	mov    $0xc,%eax
 447:	cd 40                	int    $0x40
 449:	c3                   	ret    

0000044a <sleep>:
SYSCALL(sleep)
 44a:	b8 0d 00 00 00       	mov    $0xd,%eax
 44f:	cd 40                	int    $0x40
 451:	c3                   	ret    

00000452 <uptime>:
SYSCALL(uptime)
 452:	b8 0e 00 00 00       	mov    $0xe,%eax
 457:	cd 40                	int    $0x40
 459:	c3                   	ret    

0000045a <print_proc>:
SYSCALL(print_proc)
 45a:	b8 16 00 00 00       	mov    $0x16,%eax
 45f:	cd 40                	int    $0x40
 461:	c3                   	ret    

00000462 <change_queue>:
SYSCALL(change_queue)
 462:	b8 17 00 00 00       	mov    $0x17,%eax
 467:	cd 40                	int    $0x40
 469:	c3                   	ret    

0000046a <change_local_bjf>:
SYSCALL(change_local_bjf)
 46a:	b8 18 00 00 00       	mov    $0x18,%eax
 46f:	cd 40                	int    $0x40
 471:	c3                   	ret    

00000472 <change_global_bjf>:
SYSCALL(change_global_bjf)
 472:	b8 19 00 00 00       	mov    $0x19,%eax
 477:	cd 40                	int    $0x40
 479:	c3                   	ret    
