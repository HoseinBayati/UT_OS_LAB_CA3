
_foo:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

#define HIGH 100000


int main()
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 04             	sub    $0x4,%esp
    if(!fork())
  11:	e8 b5 03 00 00       	call   3cb <fork>
  16:	85 c0                	test   %eax,%eax
  18:	75 15                	jne    2f <main+0x2f>
    {
        calc(HIGH);
  1a:	83 ec 0c             	sub    $0xc,%esp
  1d:	68 a0 86 01 00       	push   $0x186a0
  22:	e8 49 03 00 00       	call   370 <calc>
  27:	83 c4 10             	add    $0x10,%esp
        exit();
  2a:	e8 a4 03 00 00       	call   3d3 <exit>
    }
    else if(!fork())
  2f:	e8 97 03 00 00       	call   3cb <fork>
  34:	85 c0                	test   %eax,%eax
  36:	75 15                	jne    4d <main+0x4d>
    {
        calc(HIGH);
  38:	83 ec 0c             	sub    $0xc,%esp
  3b:	68 a0 86 01 00       	push   $0x186a0
  40:	e8 2b 03 00 00       	call   370 <calc>
  45:	83 c4 10             	add    $0x10,%esp
        exit();
  48:	e8 86 03 00 00       	call   3d3 <exit>
    }
    else if(!fork())
  4d:	e8 79 03 00 00       	call   3cb <fork>
  52:	85 c0                	test   %eax,%eax
  54:	75 15                	jne    6b <main+0x6b>
    {
        calc(HIGH);
  56:	83 ec 0c             	sub    $0xc,%esp
  59:	68 a0 86 01 00       	push   $0x186a0
  5e:	e8 0d 03 00 00       	call   370 <calc>
  63:	83 c4 10             	add    $0x10,%esp
        exit();
  66:	e8 68 03 00 00       	call   3d3 <exit>
    }
    else if(!fork())
  6b:	e8 5b 03 00 00       	call   3cb <fork>
  70:	85 c0                	test   %eax,%eax
  72:	75 15                	jne    89 <main+0x89>
    {
        calc(HIGH);
  74:	83 ec 0c             	sub    $0xc,%esp
  77:	68 a0 86 01 00       	push   $0x186a0
  7c:	e8 ef 02 00 00       	call   370 <calc>
  81:	83 c4 10             	add    $0x10,%esp
        exit();
  84:	e8 4a 03 00 00       	call   3d3 <exit>
    }
    else if(!fork())
  89:	e8 3d 03 00 00       	call   3cb <fork>
  8e:	85 c0                	test   %eax,%eax
  90:	75 15                	jne    a7 <main+0xa7>
    {
        calc(HIGH);
  92:	83 ec 0c             	sub    $0xc,%esp
  95:	68 a0 86 01 00       	push   $0x186a0
  9a:	e8 d1 02 00 00       	call   370 <calc>
  9f:	83 c4 10             	add    $0x10,%esp
        exit();
  a2:	e8 2c 03 00 00       	call   3d3 <exit>
    }
    else if(!fork())
  a7:	e8 1f 03 00 00       	call   3cb <fork>
  ac:	85 c0                	test   %eax,%eax
  ae:	75 15                	jne    c5 <main+0xc5>
    {
        calc(HIGH);
  b0:	83 ec 0c             	sub    $0xc,%esp
  b3:	68 a0 86 01 00       	push   $0x186a0
  b8:	e8 b3 02 00 00       	call   370 <calc>
  bd:	83 c4 10             	add    $0x10,%esp
        exit();
  c0:	e8 0e 03 00 00       	call   3d3 <exit>
    }
    else if(!fork())
  c5:	e8 01 03 00 00       	call   3cb <fork>
  ca:	85 c0                	test   %eax,%eax
  cc:	75 15                	jne    e3 <main+0xe3>
    {
        calc(HIGH);
  ce:	83 ec 0c             	sub    $0xc,%esp
  d1:	68 a0 86 01 00       	push   $0x186a0
  d6:	e8 95 02 00 00       	call   370 <calc>
  db:	83 c4 10             	add    $0x10,%esp
        exit();
  de:	e8 f0 02 00 00       	call   3d3 <exit>
    }
    else if(!fork())
  e3:	e8 e3 02 00 00       	call   3cb <fork>
  e8:	85 c0                	test   %eax,%eax
  ea:	75 15                	jne    101 <main+0x101>
    {
        calc(HIGH);
  ec:	83 ec 0c             	sub    $0xc,%esp
  ef:	68 a0 86 01 00       	push   $0x186a0
  f4:	e8 77 02 00 00       	call   370 <calc>
  f9:	83 c4 10             	add    $0x10,%esp
        exit();
  fc:	e8 d2 02 00 00       	call   3d3 <exit>
    }
    else
    {
        calc(HIGH);
 101:	83 ec 0c             	sub    $0xc,%esp
 104:	68 a0 86 01 00       	push   $0x186a0
 109:	e8 62 02 00 00       	call   370 <calc>
 10e:	83 c4 10             	add    $0x10,%esp
        while(wait() != -1);
 111:	90                   	nop
 112:	e8 c4 02 00 00       	call   3db <wait>
 117:	83 f8 ff             	cmp    $0xffffffff,%eax
 11a:	75 f6                	jne    112 <main+0x112>
    }
    exit();
 11c:	e8 b2 02 00 00       	call   3d3 <exit>

00000121 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 121:	55                   	push   %ebp
 122:	89 e5                	mov    %esp,%ebp
 124:	57                   	push   %edi
 125:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 126:	8b 4d 08             	mov    0x8(%ebp),%ecx
 129:	8b 55 10             	mov    0x10(%ebp),%edx
 12c:	8b 45 0c             	mov    0xc(%ebp),%eax
 12f:	89 cb                	mov    %ecx,%ebx
 131:	89 df                	mov    %ebx,%edi
 133:	89 d1                	mov    %edx,%ecx
 135:	fc                   	cld    
 136:	f3 aa                	rep stos %al,%es:(%edi)
 138:	89 ca                	mov    %ecx,%edx
 13a:	89 fb                	mov    %edi,%ebx
 13c:	89 5d 08             	mov    %ebx,0x8(%ebp)
 13f:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 142:	90                   	nop
 143:	5b                   	pop    %ebx
 144:	5f                   	pop    %edi
 145:	5d                   	pop    %ebp
 146:	c3                   	ret    

00000147 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 147:	55                   	push   %ebp
 148:	89 e5                	mov    %esp,%ebp
 14a:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 14d:	8b 45 08             	mov    0x8(%ebp),%eax
 150:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 153:	90                   	nop
 154:	8b 55 0c             	mov    0xc(%ebp),%edx
 157:	8d 42 01             	lea    0x1(%edx),%eax
 15a:	89 45 0c             	mov    %eax,0xc(%ebp)
 15d:	8b 45 08             	mov    0x8(%ebp),%eax
 160:	8d 48 01             	lea    0x1(%eax),%ecx
 163:	89 4d 08             	mov    %ecx,0x8(%ebp)
 166:	0f b6 12             	movzbl (%edx),%edx
 169:	88 10                	mov    %dl,(%eax)
 16b:	0f b6 00             	movzbl (%eax),%eax
 16e:	84 c0                	test   %al,%al
 170:	75 e2                	jne    154 <strcpy+0xd>
    ;
  return os;
 172:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 175:	c9                   	leave  
 176:	c3                   	ret    

00000177 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 177:	55                   	push   %ebp
 178:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 17a:	eb 08                	jmp    184 <strcmp+0xd>
    p++, q++;
 17c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 180:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 184:	8b 45 08             	mov    0x8(%ebp),%eax
 187:	0f b6 00             	movzbl (%eax),%eax
 18a:	84 c0                	test   %al,%al
 18c:	74 10                	je     19e <strcmp+0x27>
 18e:	8b 45 08             	mov    0x8(%ebp),%eax
 191:	0f b6 10             	movzbl (%eax),%edx
 194:	8b 45 0c             	mov    0xc(%ebp),%eax
 197:	0f b6 00             	movzbl (%eax),%eax
 19a:	38 c2                	cmp    %al,%dl
 19c:	74 de                	je     17c <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 19e:	8b 45 08             	mov    0x8(%ebp),%eax
 1a1:	0f b6 00             	movzbl (%eax),%eax
 1a4:	0f b6 d0             	movzbl %al,%edx
 1a7:	8b 45 0c             	mov    0xc(%ebp),%eax
 1aa:	0f b6 00             	movzbl (%eax),%eax
 1ad:	0f b6 c8             	movzbl %al,%ecx
 1b0:	89 d0                	mov    %edx,%eax
 1b2:	29 c8                	sub    %ecx,%eax
}
 1b4:	5d                   	pop    %ebp
 1b5:	c3                   	ret    

000001b6 <strlen>:

uint
strlen(const char *s)
{
 1b6:	55                   	push   %ebp
 1b7:	89 e5                	mov    %esp,%ebp
 1b9:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1bc:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1c3:	eb 04                	jmp    1c9 <strlen+0x13>
 1c5:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1c9:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1cc:	8b 45 08             	mov    0x8(%ebp),%eax
 1cf:	01 d0                	add    %edx,%eax
 1d1:	0f b6 00             	movzbl (%eax),%eax
 1d4:	84 c0                	test   %al,%al
 1d6:	75 ed                	jne    1c5 <strlen+0xf>
    ;
  return n;
 1d8:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1db:	c9                   	leave  
 1dc:	c3                   	ret    

000001dd <memset>:

void*
memset(void *dst, int c, uint n)
{
 1dd:	55                   	push   %ebp
 1de:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1e0:	8b 45 10             	mov    0x10(%ebp),%eax
 1e3:	50                   	push   %eax
 1e4:	ff 75 0c             	push   0xc(%ebp)
 1e7:	ff 75 08             	push   0x8(%ebp)
 1ea:	e8 32 ff ff ff       	call   121 <stosb>
 1ef:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1f2:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1f5:	c9                   	leave  
 1f6:	c3                   	ret    

000001f7 <strchr>:

char*
strchr(const char *s, char c)
{
 1f7:	55                   	push   %ebp
 1f8:	89 e5                	mov    %esp,%ebp
 1fa:	83 ec 04             	sub    $0x4,%esp
 1fd:	8b 45 0c             	mov    0xc(%ebp),%eax
 200:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 203:	eb 14                	jmp    219 <strchr+0x22>
    if(*s == c)
 205:	8b 45 08             	mov    0x8(%ebp),%eax
 208:	0f b6 00             	movzbl (%eax),%eax
 20b:	38 45 fc             	cmp    %al,-0x4(%ebp)
 20e:	75 05                	jne    215 <strchr+0x1e>
      return (char*)s;
 210:	8b 45 08             	mov    0x8(%ebp),%eax
 213:	eb 13                	jmp    228 <strchr+0x31>
  for(; *s; s++)
 215:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 219:	8b 45 08             	mov    0x8(%ebp),%eax
 21c:	0f b6 00             	movzbl (%eax),%eax
 21f:	84 c0                	test   %al,%al
 221:	75 e2                	jne    205 <strchr+0xe>
  return 0;
 223:	b8 00 00 00 00       	mov    $0x0,%eax
}
 228:	c9                   	leave  
 229:	c3                   	ret    

0000022a <gets>:

char*
gets(char *buf, int max)
{
 22a:	55                   	push   %ebp
 22b:	89 e5                	mov    %esp,%ebp
 22d:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 230:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 237:	eb 42                	jmp    27b <gets+0x51>
    cc = read(0, &c, 1);
 239:	83 ec 04             	sub    $0x4,%esp
 23c:	6a 01                	push   $0x1
 23e:	8d 45 ef             	lea    -0x11(%ebp),%eax
 241:	50                   	push   %eax
 242:	6a 00                	push   $0x0
 244:	e8 a2 01 00 00       	call   3eb <read>
 249:	83 c4 10             	add    $0x10,%esp
 24c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 24f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 253:	7e 33                	jle    288 <gets+0x5e>
      break;
    buf[i++] = c;
 255:	8b 45 f4             	mov    -0xc(%ebp),%eax
 258:	8d 50 01             	lea    0x1(%eax),%edx
 25b:	89 55 f4             	mov    %edx,-0xc(%ebp)
 25e:	89 c2                	mov    %eax,%edx
 260:	8b 45 08             	mov    0x8(%ebp),%eax
 263:	01 c2                	add    %eax,%edx
 265:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 269:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 26b:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 26f:	3c 0a                	cmp    $0xa,%al
 271:	74 16                	je     289 <gets+0x5f>
 273:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 277:	3c 0d                	cmp    $0xd,%al
 279:	74 0e                	je     289 <gets+0x5f>
  for(i=0; i+1 < max; ){
 27b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 27e:	83 c0 01             	add    $0x1,%eax
 281:	39 45 0c             	cmp    %eax,0xc(%ebp)
 284:	7f b3                	jg     239 <gets+0xf>
 286:	eb 01                	jmp    289 <gets+0x5f>
      break;
 288:	90                   	nop
      break;
  }
  buf[i] = '\0';
 289:	8b 55 f4             	mov    -0xc(%ebp),%edx
 28c:	8b 45 08             	mov    0x8(%ebp),%eax
 28f:	01 d0                	add    %edx,%eax
 291:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 294:	8b 45 08             	mov    0x8(%ebp),%eax
}
 297:	c9                   	leave  
 298:	c3                   	ret    

00000299 <stat>:

int
stat(const char *n, struct stat *st)
{
 299:	55                   	push   %ebp
 29a:	89 e5                	mov    %esp,%ebp
 29c:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 29f:	83 ec 08             	sub    $0x8,%esp
 2a2:	6a 00                	push   $0x0
 2a4:	ff 75 08             	push   0x8(%ebp)
 2a7:	e8 67 01 00 00       	call   413 <open>
 2ac:	83 c4 10             	add    $0x10,%esp
 2af:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2b2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2b6:	79 07                	jns    2bf <stat+0x26>
    return -1;
 2b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2bd:	eb 25                	jmp    2e4 <stat+0x4b>
  r = fstat(fd, st);
 2bf:	83 ec 08             	sub    $0x8,%esp
 2c2:	ff 75 0c             	push   0xc(%ebp)
 2c5:	ff 75 f4             	push   -0xc(%ebp)
 2c8:	e8 5e 01 00 00       	call   42b <fstat>
 2cd:	83 c4 10             	add    $0x10,%esp
 2d0:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2d3:	83 ec 0c             	sub    $0xc,%esp
 2d6:	ff 75 f4             	push   -0xc(%ebp)
 2d9:	e8 1d 01 00 00       	call   3fb <close>
 2de:	83 c4 10             	add    $0x10,%esp
  return r;
 2e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2e4:	c9                   	leave  
 2e5:	c3                   	ret    

000002e6 <atoi>:

int
atoi(const char *s)
{
 2e6:	55                   	push   %ebp
 2e7:	89 e5                	mov    %esp,%ebp
 2e9:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2ec:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2f3:	eb 25                	jmp    31a <atoi+0x34>
    n = n*10 + *s++ - '0';
 2f5:	8b 55 fc             	mov    -0x4(%ebp),%edx
 2f8:	89 d0                	mov    %edx,%eax
 2fa:	c1 e0 02             	shl    $0x2,%eax
 2fd:	01 d0                	add    %edx,%eax
 2ff:	01 c0                	add    %eax,%eax
 301:	89 c1                	mov    %eax,%ecx
 303:	8b 45 08             	mov    0x8(%ebp),%eax
 306:	8d 50 01             	lea    0x1(%eax),%edx
 309:	89 55 08             	mov    %edx,0x8(%ebp)
 30c:	0f b6 00             	movzbl (%eax),%eax
 30f:	0f be c0             	movsbl %al,%eax
 312:	01 c8                	add    %ecx,%eax
 314:	83 e8 30             	sub    $0x30,%eax
 317:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 31a:	8b 45 08             	mov    0x8(%ebp),%eax
 31d:	0f b6 00             	movzbl (%eax),%eax
 320:	3c 2f                	cmp    $0x2f,%al
 322:	7e 0a                	jle    32e <atoi+0x48>
 324:	8b 45 08             	mov    0x8(%ebp),%eax
 327:	0f b6 00             	movzbl (%eax),%eax
 32a:	3c 39                	cmp    $0x39,%al
 32c:	7e c7                	jle    2f5 <atoi+0xf>
  return n;
 32e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 331:	c9                   	leave  
 332:	c3                   	ret    

00000333 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 333:	55                   	push   %ebp
 334:	89 e5                	mov    %esp,%ebp
 336:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
 339:	8b 45 08             	mov    0x8(%ebp),%eax
 33c:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 33f:	8b 45 0c             	mov    0xc(%ebp),%eax
 342:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 345:	eb 17                	jmp    35e <memmove+0x2b>
    *dst++ = *src++;
 347:	8b 55 f8             	mov    -0x8(%ebp),%edx
 34a:	8d 42 01             	lea    0x1(%edx),%eax
 34d:	89 45 f8             	mov    %eax,-0x8(%ebp)
 350:	8b 45 fc             	mov    -0x4(%ebp),%eax
 353:	8d 48 01             	lea    0x1(%eax),%ecx
 356:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 359:	0f b6 12             	movzbl (%edx),%edx
 35c:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 35e:	8b 45 10             	mov    0x10(%ebp),%eax
 361:	8d 50 ff             	lea    -0x1(%eax),%edx
 364:	89 55 10             	mov    %edx,0x10(%ebp)
 367:	85 c0                	test   %eax,%eax
 369:	7f dc                	jg     347 <memmove+0x14>
  return vdst;
 36b:	8b 45 08             	mov    0x8(%ebp),%eax
}
 36e:	c9                   	leave  
 36f:	c3                   	ret    

00000370 <calc>:

int calc(int num)
{
 370:	55                   	push   %ebp
 371:	89 e5                	mov    %esp,%ebp
 373:	83 ec 10             	sub    $0x10,%esp
    int c = 0;
 376:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for(uint i = 0; i < num; i++)
 37d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
 384:	eb 36                	jmp    3bc <calc+0x4c>
    {
        for(uint j = 0; j < num; j++)
 386:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 38d:	eb 21                	jmp    3b0 <calc+0x40>
        {
            for(uint k = 0; k < num; j++)
 38f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 396:	eb 0c                	jmp    3a4 <calc+0x34>
            {
                c >>= 10;
 398:	c1 7d fc 0a          	sarl   $0xa,-0x4(%ebp)
                c <<= 10;
 39c:	c1 65 fc 0a          	shll   $0xa,-0x4(%ebp)
            for(uint k = 0; k < num; j++)
 3a0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 3a4:	8b 45 08             	mov    0x8(%ebp),%eax
 3a7:	39 45 f0             	cmp    %eax,-0x10(%ebp)
 3aa:	72 ec                	jb     398 <calc+0x28>
        for(uint j = 0; j < num; j++)
 3ac:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 3b0:	8b 45 08             	mov    0x8(%ebp),%eax
 3b3:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 3b6:	72 d7                	jb     38f <calc+0x1f>
    for(uint i = 0; i < num; i++)
 3b8:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 3bc:	8b 45 08             	mov    0x8(%ebp),%eax
 3bf:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 3c2:	72 c2                	jb     386 <calc+0x16>
            }
        }
    }
    return 0;
 3c4:	b8 00 00 00 00       	mov    $0x0,%eax
}
 3c9:	c9                   	leave  
 3ca:	c3                   	ret    

000003cb <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3cb:	b8 01 00 00 00       	mov    $0x1,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <exit>:
SYSCALL(exit)
 3d3:	b8 02 00 00 00       	mov    $0x2,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <wait>:
SYSCALL(wait)
 3db:	b8 03 00 00 00       	mov    $0x3,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <pipe>:
SYSCALL(pipe)
 3e3:	b8 04 00 00 00       	mov    $0x4,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <read>:
SYSCALL(read)
 3eb:	b8 05 00 00 00       	mov    $0x5,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <write>:
SYSCALL(write)
 3f3:	b8 10 00 00 00       	mov    $0x10,%eax
 3f8:	cd 40                	int    $0x40
 3fa:	c3                   	ret    

000003fb <close>:
SYSCALL(close)
 3fb:	b8 15 00 00 00       	mov    $0x15,%eax
 400:	cd 40                	int    $0x40
 402:	c3                   	ret    

00000403 <kill>:
SYSCALL(kill)
 403:	b8 06 00 00 00       	mov    $0x6,%eax
 408:	cd 40                	int    $0x40
 40a:	c3                   	ret    

0000040b <exec>:
SYSCALL(exec)
 40b:	b8 07 00 00 00       	mov    $0x7,%eax
 410:	cd 40                	int    $0x40
 412:	c3                   	ret    

00000413 <open>:
SYSCALL(open)
 413:	b8 0f 00 00 00       	mov    $0xf,%eax
 418:	cd 40                	int    $0x40
 41a:	c3                   	ret    

0000041b <mknod>:
SYSCALL(mknod)
 41b:	b8 11 00 00 00       	mov    $0x11,%eax
 420:	cd 40                	int    $0x40
 422:	c3                   	ret    

00000423 <unlink>:
SYSCALL(unlink)
 423:	b8 12 00 00 00       	mov    $0x12,%eax
 428:	cd 40                	int    $0x40
 42a:	c3                   	ret    

0000042b <fstat>:
SYSCALL(fstat)
 42b:	b8 08 00 00 00       	mov    $0x8,%eax
 430:	cd 40                	int    $0x40
 432:	c3                   	ret    

00000433 <link>:
SYSCALL(link)
 433:	b8 13 00 00 00       	mov    $0x13,%eax
 438:	cd 40                	int    $0x40
 43a:	c3                   	ret    

0000043b <mkdir>:
SYSCALL(mkdir)
 43b:	b8 14 00 00 00       	mov    $0x14,%eax
 440:	cd 40                	int    $0x40
 442:	c3                   	ret    

00000443 <chdir>:
SYSCALL(chdir)
 443:	b8 09 00 00 00       	mov    $0x9,%eax
 448:	cd 40                	int    $0x40
 44a:	c3                   	ret    

0000044b <dup>:
SYSCALL(dup)
 44b:	b8 0a 00 00 00       	mov    $0xa,%eax
 450:	cd 40                	int    $0x40
 452:	c3                   	ret    

00000453 <getpid>:
SYSCALL(getpid)
 453:	b8 0b 00 00 00       	mov    $0xb,%eax
 458:	cd 40                	int    $0x40
 45a:	c3                   	ret    

0000045b <sbrk>:
SYSCALL(sbrk)
 45b:	b8 0c 00 00 00       	mov    $0xc,%eax
 460:	cd 40                	int    $0x40
 462:	c3                   	ret    

00000463 <sleep>:
SYSCALL(sleep)
 463:	b8 0d 00 00 00       	mov    $0xd,%eax
 468:	cd 40                	int    $0x40
 46a:	c3                   	ret    

0000046b <uptime>:
SYSCALL(uptime)
 46b:	b8 0e 00 00 00       	mov    $0xe,%eax
 470:	cd 40                	int    $0x40
 472:	c3                   	ret    

00000473 <print_proc>:
SYSCALL(print_proc)
 473:	b8 16 00 00 00       	mov    $0x16,%eax
 478:	cd 40                	int    $0x40
 47a:	c3                   	ret    

0000047b <change_queue>:
 47b:	b8 17 00 00 00       	mov    $0x17,%eax
 480:	cd 40                	int    $0x40
 482:	c3                   	ret    

00000483 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 483:	55                   	push   %ebp
 484:	89 e5                	mov    %esp,%ebp
 486:	83 ec 18             	sub    $0x18,%esp
 489:	8b 45 0c             	mov    0xc(%ebp),%eax
 48c:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 48f:	83 ec 04             	sub    $0x4,%esp
 492:	6a 01                	push   $0x1
 494:	8d 45 f4             	lea    -0xc(%ebp),%eax
 497:	50                   	push   %eax
 498:	ff 75 08             	push   0x8(%ebp)
 49b:	e8 53 ff ff ff       	call   3f3 <write>
 4a0:	83 c4 10             	add    $0x10,%esp
}
 4a3:	90                   	nop
 4a4:	c9                   	leave  
 4a5:	c3                   	ret    

000004a6 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4a6:	55                   	push   %ebp
 4a7:	89 e5                	mov    %esp,%ebp
 4a9:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4ac:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4b3:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4b7:	74 17                	je     4d0 <printint+0x2a>
 4b9:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4bd:	79 11                	jns    4d0 <printint+0x2a>
    neg = 1;
 4bf:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4c6:	8b 45 0c             	mov    0xc(%ebp),%eax
 4c9:	f7 d8                	neg    %eax
 4cb:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4ce:	eb 06                	jmp    4d6 <printint+0x30>
  } else {
    x = xx;
 4d0:	8b 45 0c             	mov    0xc(%ebp),%eax
 4d3:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4d6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4dd:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4e0:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4e3:	ba 00 00 00 00       	mov    $0x0,%edx
 4e8:	f7 f1                	div    %ecx
 4ea:	89 d1                	mov    %edx,%ecx
 4ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
 4ef:	8d 50 01             	lea    0x1(%eax),%edx
 4f2:	89 55 f4             	mov    %edx,-0xc(%ebp)
 4f5:	0f b6 91 7c 0b 00 00 	movzbl 0xb7c(%ecx),%edx
 4fc:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 500:	8b 4d 10             	mov    0x10(%ebp),%ecx
 503:	8b 45 ec             	mov    -0x14(%ebp),%eax
 506:	ba 00 00 00 00       	mov    $0x0,%edx
 50b:	f7 f1                	div    %ecx
 50d:	89 45 ec             	mov    %eax,-0x14(%ebp)
 510:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 514:	75 c7                	jne    4dd <printint+0x37>
  if(neg)
 516:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 51a:	74 2d                	je     549 <printint+0xa3>
    buf[i++] = '-';
 51c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 51f:	8d 50 01             	lea    0x1(%eax),%edx
 522:	89 55 f4             	mov    %edx,-0xc(%ebp)
 525:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 52a:	eb 1d                	jmp    549 <printint+0xa3>
    putc(fd, buf[i]);
 52c:	8d 55 dc             	lea    -0x24(%ebp),%edx
 52f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 532:	01 d0                	add    %edx,%eax
 534:	0f b6 00             	movzbl (%eax),%eax
 537:	0f be c0             	movsbl %al,%eax
 53a:	83 ec 08             	sub    $0x8,%esp
 53d:	50                   	push   %eax
 53e:	ff 75 08             	push   0x8(%ebp)
 541:	e8 3d ff ff ff       	call   483 <putc>
 546:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 549:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 54d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 551:	79 d9                	jns    52c <printint+0x86>
}
 553:	90                   	nop
 554:	90                   	nop
 555:	c9                   	leave  
 556:	c3                   	ret    

00000557 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 557:	55                   	push   %ebp
 558:	89 e5                	mov    %esp,%ebp
 55a:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 55d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 564:	8d 45 0c             	lea    0xc(%ebp),%eax
 567:	83 c0 04             	add    $0x4,%eax
 56a:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 56d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 574:	e9 59 01 00 00       	jmp    6d2 <printf+0x17b>
    c = fmt[i] & 0xff;
 579:	8b 55 0c             	mov    0xc(%ebp),%edx
 57c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 57f:	01 d0                	add    %edx,%eax
 581:	0f b6 00             	movzbl (%eax),%eax
 584:	0f be c0             	movsbl %al,%eax
 587:	25 ff 00 00 00       	and    $0xff,%eax
 58c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 58f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 593:	75 2c                	jne    5c1 <printf+0x6a>
      if(c == '%'){
 595:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 599:	75 0c                	jne    5a7 <printf+0x50>
        state = '%';
 59b:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5a2:	e9 27 01 00 00       	jmp    6ce <printf+0x177>
      } else {
        putc(fd, c);
 5a7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5aa:	0f be c0             	movsbl %al,%eax
 5ad:	83 ec 08             	sub    $0x8,%esp
 5b0:	50                   	push   %eax
 5b1:	ff 75 08             	push   0x8(%ebp)
 5b4:	e8 ca fe ff ff       	call   483 <putc>
 5b9:	83 c4 10             	add    $0x10,%esp
 5bc:	e9 0d 01 00 00       	jmp    6ce <printf+0x177>
      }
    } else if(state == '%'){
 5c1:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5c5:	0f 85 03 01 00 00    	jne    6ce <printf+0x177>
      if(c == 'd'){
 5cb:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5cf:	75 1e                	jne    5ef <printf+0x98>
        printint(fd, *ap, 10, 1);
 5d1:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5d4:	8b 00                	mov    (%eax),%eax
 5d6:	6a 01                	push   $0x1
 5d8:	6a 0a                	push   $0xa
 5da:	50                   	push   %eax
 5db:	ff 75 08             	push   0x8(%ebp)
 5de:	e8 c3 fe ff ff       	call   4a6 <printint>
 5e3:	83 c4 10             	add    $0x10,%esp
        ap++;
 5e6:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 5ea:	e9 d8 00 00 00       	jmp    6c7 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 5ef:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 5f3:	74 06                	je     5fb <printf+0xa4>
 5f5:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 5f9:	75 1e                	jne    619 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 5fb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5fe:	8b 00                	mov    (%eax),%eax
 600:	6a 00                	push   $0x0
 602:	6a 10                	push   $0x10
 604:	50                   	push   %eax
 605:	ff 75 08             	push   0x8(%ebp)
 608:	e8 99 fe ff ff       	call   4a6 <printint>
 60d:	83 c4 10             	add    $0x10,%esp
        ap++;
 610:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 614:	e9 ae 00 00 00       	jmp    6c7 <printf+0x170>
      } else if(c == 's'){
 619:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 61d:	75 43                	jne    662 <printf+0x10b>
        s = (char*)*ap;
 61f:	8b 45 e8             	mov    -0x18(%ebp),%eax
 622:	8b 00                	mov    (%eax),%eax
 624:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 627:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 62b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 62f:	75 25                	jne    656 <printf+0xff>
          s = "(null)";
 631:	c7 45 f4 0e 09 00 00 	movl   $0x90e,-0xc(%ebp)
        while(*s != 0){
 638:	eb 1c                	jmp    656 <printf+0xff>
          putc(fd, *s);
 63a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 63d:	0f b6 00             	movzbl (%eax),%eax
 640:	0f be c0             	movsbl %al,%eax
 643:	83 ec 08             	sub    $0x8,%esp
 646:	50                   	push   %eax
 647:	ff 75 08             	push   0x8(%ebp)
 64a:	e8 34 fe ff ff       	call   483 <putc>
 64f:	83 c4 10             	add    $0x10,%esp
          s++;
 652:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 656:	8b 45 f4             	mov    -0xc(%ebp),%eax
 659:	0f b6 00             	movzbl (%eax),%eax
 65c:	84 c0                	test   %al,%al
 65e:	75 da                	jne    63a <printf+0xe3>
 660:	eb 65                	jmp    6c7 <printf+0x170>
        }
      } else if(c == 'c'){
 662:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 666:	75 1d                	jne    685 <printf+0x12e>
        putc(fd, *ap);
 668:	8b 45 e8             	mov    -0x18(%ebp),%eax
 66b:	8b 00                	mov    (%eax),%eax
 66d:	0f be c0             	movsbl %al,%eax
 670:	83 ec 08             	sub    $0x8,%esp
 673:	50                   	push   %eax
 674:	ff 75 08             	push   0x8(%ebp)
 677:	e8 07 fe ff ff       	call   483 <putc>
 67c:	83 c4 10             	add    $0x10,%esp
        ap++;
 67f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 683:	eb 42                	jmp    6c7 <printf+0x170>
      } else if(c == '%'){
 685:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 689:	75 17                	jne    6a2 <printf+0x14b>
        putc(fd, c);
 68b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 68e:	0f be c0             	movsbl %al,%eax
 691:	83 ec 08             	sub    $0x8,%esp
 694:	50                   	push   %eax
 695:	ff 75 08             	push   0x8(%ebp)
 698:	e8 e6 fd ff ff       	call   483 <putc>
 69d:	83 c4 10             	add    $0x10,%esp
 6a0:	eb 25                	jmp    6c7 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6a2:	83 ec 08             	sub    $0x8,%esp
 6a5:	6a 25                	push   $0x25
 6a7:	ff 75 08             	push   0x8(%ebp)
 6aa:	e8 d4 fd ff ff       	call   483 <putc>
 6af:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 6b2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6b5:	0f be c0             	movsbl %al,%eax
 6b8:	83 ec 08             	sub    $0x8,%esp
 6bb:	50                   	push   %eax
 6bc:	ff 75 08             	push   0x8(%ebp)
 6bf:	e8 bf fd ff ff       	call   483 <putc>
 6c4:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 6c7:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 6ce:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6d2:	8b 55 0c             	mov    0xc(%ebp),%edx
 6d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6d8:	01 d0                	add    %edx,%eax
 6da:	0f b6 00             	movzbl (%eax),%eax
 6dd:	84 c0                	test   %al,%al
 6df:	0f 85 94 fe ff ff    	jne    579 <printf+0x22>
    }
  }
}
 6e5:	90                   	nop
 6e6:	90                   	nop
 6e7:	c9                   	leave  
 6e8:	c3                   	ret    

000006e9 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 6e9:	55                   	push   %ebp
 6ea:	89 e5                	mov    %esp,%ebp
 6ec:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 6ef:	8b 45 08             	mov    0x8(%ebp),%eax
 6f2:	83 e8 08             	sub    $0x8,%eax
 6f5:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 6f8:	a1 98 0b 00 00       	mov    0xb98,%eax
 6fd:	89 45 fc             	mov    %eax,-0x4(%ebp)
 700:	eb 24                	jmp    726 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 702:	8b 45 fc             	mov    -0x4(%ebp),%eax
 705:	8b 00                	mov    (%eax),%eax
 707:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 70a:	72 12                	jb     71e <free+0x35>
 70c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 70f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 712:	77 24                	ja     738 <free+0x4f>
 714:	8b 45 fc             	mov    -0x4(%ebp),%eax
 717:	8b 00                	mov    (%eax),%eax
 719:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 71c:	72 1a                	jb     738 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 71e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 721:	8b 00                	mov    (%eax),%eax
 723:	89 45 fc             	mov    %eax,-0x4(%ebp)
 726:	8b 45 f8             	mov    -0x8(%ebp),%eax
 729:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 72c:	76 d4                	jbe    702 <free+0x19>
 72e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 731:	8b 00                	mov    (%eax),%eax
 733:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 736:	73 ca                	jae    702 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 738:	8b 45 f8             	mov    -0x8(%ebp),%eax
 73b:	8b 40 04             	mov    0x4(%eax),%eax
 73e:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 745:	8b 45 f8             	mov    -0x8(%ebp),%eax
 748:	01 c2                	add    %eax,%edx
 74a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74d:	8b 00                	mov    (%eax),%eax
 74f:	39 c2                	cmp    %eax,%edx
 751:	75 24                	jne    777 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 753:	8b 45 f8             	mov    -0x8(%ebp),%eax
 756:	8b 50 04             	mov    0x4(%eax),%edx
 759:	8b 45 fc             	mov    -0x4(%ebp),%eax
 75c:	8b 00                	mov    (%eax),%eax
 75e:	8b 40 04             	mov    0x4(%eax),%eax
 761:	01 c2                	add    %eax,%edx
 763:	8b 45 f8             	mov    -0x8(%ebp),%eax
 766:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 769:	8b 45 fc             	mov    -0x4(%ebp),%eax
 76c:	8b 00                	mov    (%eax),%eax
 76e:	8b 10                	mov    (%eax),%edx
 770:	8b 45 f8             	mov    -0x8(%ebp),%eax
 773:	89 10                	mov    %edx,(%eax)
 775:	eb 0a                	jmp    781 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 777:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77a:	8b 10                	mov    (%eax),%edx
 77c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 77f:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 781:	8b 45 fc             	mov    -0x4(%ebp),%eax
 784:	8b 40 04             	mov    0x4(%eax),%eax
 787:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 78e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 791:	01 d0                	add    %edx,%eax
 793:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 796:	75 20                	jne    7b8 <free+0xcf>
    p->s.size += bp->s.size;
 798:	8b 45 fc             	mov    -0x4(%ebp),%eax
 79b:	8b 50 04             	mov    0x4(%eax),%edx
 79e:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7a1:	8b 40 04             	mov    0x4(%eax),%eax
 7a4:	01 c2                	add    %eax,%edx
 7a6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a9:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7ac:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7af:	8b 10                	mov    (%eax),%edx
 7b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b4:	89 10                	mov    %edx,(%eax)
 7b6:	eb 08                	jmp    7c0 <free+0xd7>
  } else
    p->s.ptr = bp;
 7b8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7bb:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7be:	89 10                	mov    %edx,(%eax)
  freep = p;
 7c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c3:	a3 98 0b 00 00       	mov    %eax,0xb98
}
 7c8:	90                   	nop
 7c9:	c9                   	leave  
 7ca:	c3                   	ret    

000007cb <morecore>:

static Header*
morecore(uint nu)
{
 7cb:	55                   	push   %ebp
 7cc:	89 e5                	mov    %esp,%ebp
 7ce:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7d1:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7d8:	77 07                	ja     7e1 <morecore+0x16>
    nu = 4096;
 7da:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7e1:	8b 45 08             	mov    0x8(%ebp),%eax
 7e4:	c1 e0 03             	shl    $0x3,%eax
 7e7:	83 ec 0c             	sub    $0xc,%esp
 7ea:	50                   	push   %eax
 7eb:	e8 6b fc ff ff       	call   45b <sbrk>
 7f0:	83 c4 10             	add    $0x10,%esp
 7f3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 7f6:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 7fa:	75 07                	jne    803 <morecore+0x38>
    return 0;
 7fc:	b8 00 00 00 00       	mov    $0x0,%eax
 801:	eb 26                	jmp    829 <morecore+0x5e>
  hp = (Header*)p;
 803:	8b 45 f4             	mov    -0xc(%ebp),%eax
 806:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 809:	8b 45 f0             	mov    -0x10(%ebp),%eax
 80c:	8b 55 08             	mov    0x8(%ebp),%edx
 80f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 812:	8b 45 f0             	mov    -0x10(%ebp),%eax
 815:	83 c0 08             	add    $0x8,%eax
 818:	83 ec 0c             	sub    $0xc,%esp
 81b:	50                   	push   %eax
 81c:	e8 c8 fe ff ff       	call   6e9 <free>
 821:	83 c4 10             	add    $0x10,%esp
  return freep;
 824:	a1 98 0b 00 00       	mov    0xb98,%eax
}
 829:	c9                   	leave  
 82a:	c3                   	ret    

0000082b <malloc>:

void*
malloc(uint nbytes)
{
 82b:	55                   	push   %ebp
 82c:	89 e5                	mov    %esp,%ebp
 82e:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 831:	8b 45 08             	mov    0x8(%ebp),%eax
 834:	83 c0 07             	add    $0x7,%eax
 837:	c1 e8 03             	shr    $0x3,%eax
 83a:	83 c0 01             	add    $0x1,%eax
 83d:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 840:	a1 98 0b 00 00       	mov    0xb98,%eax
 845:	89 45 f0             	mov    %eax,-0x10(%ebp)
 848:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 84c:	75 23                	jne    871 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 84e:	c7 45 f0 90 0b 00 00 	movl   $0xb90,-0x10(%ebp)
 855:	8b 45 f0             	mov    -0x10(%ebp),%eax
 858:	a3 98 0b 00 00       	mov    %eax,0xb98
 85d:	a1 98 0b 00 00       	mov    0xb98,%eax
 862:	a3 90 0b 00 00       	mov    %eax,0xb90
    base.s.size = 0;
 867:	c7 05 94 0b 00 00 00 	movl   $0x0,0xb94
 86e:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 871:	8b 45 f0             	mov    -0x10(%ebp),%eax
 874:	8b 00                	mov    (%eax),%eax
 876:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 879:	8b 45 f4             	mov    -0xc(%ebp),%eax
 87c:	8b 40 04             	mov    0x4(%eax),%eax
 87f:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 882:	77 4d                	ja     8d1 <malloc+0xa6>
      if(p->s.size == nunits)
 884:	8b 45 f4             	mov    -0xc(%ebp),%eax
 887:	8b 40 04             	mov    0x4(%eax),%eax
 88a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 88d:	75 0c                	jne    89b <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 88f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 892:	8b 10                	mov    (%eax),%edx
 894:	8b 45 f0             	mov    -0x10(%ebp),%eax
 897:	89 10                	mov    %edx,(%eax)
 899:	eb 26                	jmp    8c1 <malloc+0x96>
      else {
        p->s.size -= nunits;
 89b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 89e:	8b 40 04             	mov    0x4(%eax),%eax
 8a1:	2b 45 ec             	sub    -0x14(%ebp),%eax
 8a4:	89 c2                	mov    %eax,%edx
 8a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a9:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8af:	8b 40 04             	mov    0x4(%eax),%eax
 8b2:	c1 e0 03             	shl    $0x3,%eax
 8b5:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8bb:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8be:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8c1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8c4:	a3 98 0b 00 00       	mov    %eax,0xb98
      return (void*)(p + 1);
 8c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8cc:	83 c0 08             	add    $0x8,%eax
 8cf:	eb 3b                	jmp    90c <malloc+0xe1>
    }
    if(p == freep)
 8d1:	a1 98 0b 00 00       	mov    0xb98,%eax
 8d6:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8d9:	75 1e                	jne    8f9 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 8db:	83 ec 0c             	sub    $0xc,%esp
 8de:	ff 75 ec             	push   -0x14(%ebp)
 8e1:	e8 e5 fe ff ff       	call   7cb <morecore>
 8e6:	83 c4 10             	add    $0x10,%esp
 8e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
 8ec:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 8f0:	75 07                	jne    8f9 <malloc+0xce>
        return 0;
 8f2:	b8 00 00 00 00       	mov    $0x0,%eax
 8f7:	eb 13                	jmp    90c <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8fc:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
 902:	8b 00                	mov    (%eax),%eax
 904:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 907:	e9 6d ff ff ff       	jmp    879 <malloc+0x4e>
  }
}
 90c:	c9                   	leave  
 90d:	c3                   	ret    
