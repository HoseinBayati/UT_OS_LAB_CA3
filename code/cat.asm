
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 18             	sub    $0x18,%esp
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
   6:	eb 31                	jmp    39 <cat+0x39>
    if (write(1, buf, n) != n) {
   8:	83 ec 04             	sub    $0x4,%esp
   b:	ff 75 f4             	push   -0xc(%ebp)
   e:	68 20 0c 00 00       	push   $0xc20
  13:	6a 01                	push   $0x1
  15:	e8 e3 03 00 00       	call   3fd <write>
  1a:	83 c4 10             	add    $0x10,%esp
  1d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
  20:	74 17                	je     39 <cat+0x39>
      printf(1, "cat: write error\n");
  22:	83 ec 08             	sub    $0x8,%esp
  25:	68 28 09 00 00       	push   $0x928
  2a:	6a 01                	push   $0x1
  2c:	e8 40 05 00 00       	call   571 <printf>
  31:	83 c4 10             	add    $0x10,%esp
      exit();
  34:	e8 a4 03 00 00       	call   3dd <exit>
  while((n = read(fd, buf, sizeof(buf))) > 0) {
  39:	83 ec 04             	sub    $0x4,%esp
  3c:	68 00 02 00 00       	push   $0x200
  41:	68 20 0c 00 00       	push   $0xc20
  46:	ff 75 08             	push   0x8(%ebp)
  49:	e8 a7 03 00 00       	call   3f5 <read>
  4e:	83 c4 10             	add    $0x10,%esp
  51:	89 45 f4             	mov    %eax,-0xc(%ebp)
  54:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  58:	7f ae                	jg     8 <cat+0x8>
    }
  }
  if(n < 0){
  5a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
  5e:	79 17                	jns    77 <cat+0x77>
    printf(1, "cat: read error\n");
  60:	83 ec 08             	sub    $0x8,%esp
  63:	68 3a 09 00 00       	push   $0x93a
  68:	6a 01                	push   $0x1
  6a:	e8 02 05 00 00       	call   571 <printf>
  6f:	83 c4 10             	add    $0x10,%esp
    exit();
  72:	e8 66 03 00 00       	call   3dd <exit>
  }
}
  77:	90                   	nop
  78:	c9                   	leave  
  79:	c3                   	ret    

0000007a <main>:

int
main(int argc, char *argv[])
{
  7a:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  7e:	83 e4 f0             	and    $0xfffffff0,%esp
  81:	ff 71 fc             	push   -0x4(%ecx)
  84:	55                   	push   %ebp
  85:	89 e5                	mov    %esp,%ebp
  87:	53                   	push   %ebx
  88:	51                   	push   %ecx
  89:	83 ec 10             	sub    $0x10,%esp
  8c:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
  8e:	83 3b 01             	cmpl   $0x1,(%ebx)
  91:	7f 12                	jg     a5 <main+0x2b>
    cat(0);
  93:	83 ec 0c             	sub    $0xc,%esp
  96:	6a 00                	push   $0x0
  98:	e8 63 ff ff ff       	call   0 <cat>
  9d:	83 c4 10             	add    $0x10,%esp
    exit();
  a0:	e8 38 03 00 00       	call   3dd <exit>
  }

  for(i = 1; i < argc; i++){
  a5:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  ac:	eb 71                	jmp    11f <main+0xa5>
    if((fd = open(argv[i], 0)) < 0){
  ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
  b1:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  b8:	8b 43 04             	mov    0x4(%ebx),%eax
  bb:	01 d0                	add    %edx,%eax
  bd:	8b 00                	mov    (%eax),%eax
  bf:	83 ec 08             	sub    $0x8,%esp
  c2:	6a 00                	push   $0x0
  c4:	50                   	push   %eax
  c5:	e8 53 03 00 00       	call   41d <open>
  ca:	83 c4 10             	add    $0x10,%esp
  cd:	89 45 f0             	mov    %eax,-0x10(%ebp)
  d0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
  d4:	79 29                	jns    ff <main+0x85>
      printf(1, "cat: cannot open %s\n", argv[i]);
  d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
  d9:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
  e0:	8b 43 04             	mov    0x4(%ebx),%eax
  e3:	01 d0                	add    %edx,%eax
  e5:	8b 00                	mov    (%eax),%eax
  e7:	83 ec 04             	sub    $0x4,%esp
  ea:	50                   	push   %eax
  eb:	68 4b 09 00 00       	push   $0x94b
  f0:	6a 01                	push   $0x1
  f2:	e8 7a 04 00 00       	call   571 <printf>
  f7:	83 c4 10             	add    $0x10,%esp
      exit();
  fa:	e8 de 02 00 00       	call   3dd <exit>
    }
    cat(fd);
  ff:	83 ec 0c             	sub    $0xc,%esp
 102:	ff 75 f0             	push   -0x10(%ebp)
 105:	e8 f6 fe ff ff       	call   0 <cat>
 10a:	83 c4 10             	add    $0x10,%esp
    close(fd);
 10d:	83 ec 0c             	sub    $0xc,%esp
 110:	ff 75 f0             	push   -0x10(%ebp)
 113:	e8 ed 02 00 00       	call   405 <close>
 118:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i < argc; i++){
 11b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 11f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 122:	3b 03                	cmp    (%ebx),%eax
 124:	7c 88                	jl     ae <main+0x34>
  }
  exit();
 126:	e8 b2 02 00 00       	call   3dd <exit>

0000012b <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 12b:	55                   	push   %ebp
 12c:	89 e5                	mov    %esp,%ebp
 12e:	57                   	push   %edi
 12f:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 130:	8b 4d 08             	mov    0x8(%ebp),%ecx
 133:	8b 55 10             	mov    0x10(%ebp),%edx
 136:	8b 45 0c             	mov    0xc(%ebp),%eax
 139:	89 cb                	mov    %ecx,%ebx
 13b:	89 df                	mov    %ebx,%edi
 13d:	89 d1                	mov    %edx,%ecx
 13f:	fc                   	cld    
 140:	f3 aa                	rep stos %al,%es:(%edi)
 142:	89 ca                	mov    %ecx,%edx
 144:	89 fb                	mov    %edi,%ebx
 146:	89 5d 08             	mov    %ebx,0x8(%ebp)
 149:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 14c:	90                   	nop
 14d:	5b                   	pop    %ebx
 14e:	5f                   	pop    %edi
 14f:	5d                   	pop    %ebp
 150:	c3                   	ret    

00000151 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 151:	55                   	push   %ebp
 152:	89 e5                	mov    %esp,%ebp
 154:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 157:	8b 45 08             	mov    0x8(%ebp),%eax
 15a:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 15d:	90                   	nop
 15e:	8b 55 0c             	mov    0xc(%ebp),%edx
 161:	8d 42 01             	lea    0x1(%edx),%eax
 164:	89 45 0c             	mov    %eax,0xc(%ebp)
 167:	8b 45 08             	mov    0x8(%ebp),%eax
 16a:	8d 48 01             	lea    0x1(%eax),%ecx
 16d:	89 4d 08             	mov    %ecx,0x8(%ebp)
 170:	0f b6 12             	movzbl (%edx),%edx
 173:	88 10                	mov    %dl,(%eax)
 175:	0f b6 00             	movzbl (%eax),%eax
 178:	84 c0                	test   %al,%al
 17a:	75 e2                	jne    15e <strcpy+0xd>
    ;
  return os;
 17c:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 17f:	c9                   	leave  
 180:	c3                   	ret    

00000181 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 181:	55                   	push   %ebp
 182:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 184:	eb 08                	jmp    18e <strcmp+0xd>
    p++, q++;
 186:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 18a:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 18e:	8b 45 08             	mov    0x8(%ebp),%eax
 191:	0f b6 00             	movzbl (%eax),%eax
 194:	84 c0                	test   %al,%al
 196:	74 10                	je     1a8 <strcmp+0x27>
 198:	8b 45 08             	mov    0x8(%ebp),%eax
 19b:	0f b6 10             	movzbl (%eax),%edx
 19e:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a1:	0f b6 00             	movzbl (%eax),%eax
 1a4:	38 c2                	cmp    %al,%dl
 1a6:	74 de                	je     186 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 1a8:	8b 45 08             	mov    0x8(%ebp),%eax
 1ab:	0f b6 00             	movzbl (%eax),%eax
 1ae:	0f b6 d0             	movzbl %al,%edx
 1b1:	8b 45 0c             	mov    0xc(%ebp),%eax
 1b4:	0f b6 00             	movzbl (%eax),%eax
 1b7:	0f b6 c8             	movzbl %al,%ecx
 1ba:	89 d0                	mov    %edx,%eax
 1bc:	29 c8                	sub    %ecx,%eax
}
 1be:	5d                   	pop    %ebp
 1bf:	c3                   	ret    

000001c0 <strlen>:

uint
strlen(const char *s)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1c6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1cd:	eb 04                	jmp    1d3 <strlen+0x13>
 1cf:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1d3:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1d6:	8b 45 08             	mov    0x8(%ebp),%eax
 1d9:	01 d0                	add    %edx,%eax
 1db:	0f b6 00             	movzbl (%eax),%eax
 1de:	84 c0                	test   %al,%al
 1e0:	75 ed                	jne    1cf <strlen+0xf>
    ;
  return n;
 1e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1e5:	c9                   	leave  
 1e6:	c3                   	ret    

000001e7 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1e7:	55                   	push   %ebp
 1e8:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 1ea:	8b 45 10             	mov    0x10(%ebp),%eax
 1ed:	50                   	push   %eax
 1ee:	ff 75 0c             	push   0xc(%ebp)
 1f1:	ff 75 08             	push   0x8(%ebp)
 1f4:	e8 32 ff ff ff       	call   12b <stosb>
 1f9:	83 c4 0c             	add    $0xc,%esp
  return dst;
 1fc:	8b 45 08             	mov    0x8(%ebp),%eax
}
 1ff:	c9                   	leave  
 200:	c3                   	ret    

00000201 <strchr>:

char*
strchr(const char *s, char c)
{
 201:	55                   	push   %ebp
 202:	89 e5                	mov    %esp,%ebp
 204:	83 ec 04             	sub    $0x4,%esp
 207:	8b 45 0c             	mov    0xc(%ebp),%eax
 20a:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 20d:	eb 14                	jmp    223 <strchr+0x22>
    if(*s == c)
 20f:	8b 45 08             	mov    0x8(%ebp),%eax
 212:	0f b6 00             	movzbl (%eax),%eax
 215:	38 45 fc             	cmp    %al,-0x4(%ebp)
 218:	75 05                	jne    21f <strchr+0x1e>
      return (char*)s;
 21a:	8b 45 08             	mov    0x8(%ebp),%eax
 21d:	eb 13                	jmp    232 <strchr+0x31>
  for(; *s; s++)
 21f:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 223:	8b 45 08             	mov    0x8(%ebp),%eax
 226:	0f b6 00             	movzbl (%eax),%eax
 229:	84 c0                	test   %al,%al
 22b:	75 e2                	jne    20f <strchr+0xe>
  return 0;
 22d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 232:	c9                   	leave  
 233:	c3                   	ret    

00000234 <gets>:

char*
gets(char *buf, int max)
{
 234:	55                   	push   %ebp
 235:	89 e5                	mov    %esp,%ebp
 237:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 23a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 241:	eb 42                	jmp    285 <gets+0x51>
    cc = read(0, &c, 1);
 243:	83 ec 04             	sub    $0x4,%esp
 246:	6a 01                	push   $0x1
 248:	8d 45 ef             	lea    -0x11(%ebp),%eax
 24b:	50                   	push   %eax
 24c:	6a 00                	push   $0x0
 24e:	e8 a2 01 00 00       	call   3f5 <read>
 253:	83 c4 10             	add    $0x10,%esp
 256:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 259:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 25d:	7e 33                	jle    292 <gets+0x5e>
      break;
    buf[i++] = c;
 25f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 262:	8d 50 01             	lea    0x1(%eax),%edx
 265:	89 55 f4             	mov    %edx,-0xc(%ebp)
 268:	89 c2                	mov    %eax,%edx
 26a:	8b 45 08             	mov    0x8(%ebp),%eax
 26d:	01 c2                	add    %eax,%edx
 26f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 273:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 275:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 279:	3c 0a                	cmp    $0xa,%al
 27b:	74 16                	je     293 <gets+0x5f>
 27d:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 281:	3c 0d                	cmp    $0xd,%al
 283:	74 0e                	je     293 <gets+0x5f>
  for(i=0; i+1 < max; ){
 285:	8b 45 f4             	mov    -0xc(%ebp),%eax
 288:	83 c0 01             	add    $0x1,%eax
 28b:	39 45 0c             	cmp    %eax,0xc(%ebp)
 28e:	7f b3                	jg     243 <gets+0xf>
 290:	eb 01                	jmp    293 <gets+0x5f>
      break;
 292:	90                   	nop
      break;
  }
  buf[i] = '\0';
 293:	8b 55 f4             	mov    -0xc(%ebp),%edx
 296:	8b 45 08             	mov    0x8(%ebp),%eax
 299:	01 d0                	add    %edx,%eax
 29b:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 29e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2a1:	c9                   	leave  
 2a2:	c3                   	ret    

000002a3 <stat>:

int
stat(const char *n, struct stat *st)
{
 2a3:	55                   	push   %ebp
 2a4:	89 e5                	mov    %esp,%ebp
 2a6:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2a9:	83 ec 08             	sub    $0x8,%esp
 2ac:	6a 00                	push   $0x0
 2ae:	ff 75 08             	push   0x8(%ebp)
 2b1:	e8 67 01 00 00       	call   41d <open>
 2b6:	83 c4 10             	add    $0x10,%esp
 2b9:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2bc:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2c0:	79 07                	jns    2c9 <stat+0x26>
    return -1;
 2c2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2c7:	eb 25                	jmp    2ee <stat+0x4b>
  r = fstat(fd, st);
 2c9:	83 ec 08             	sub    $0x8,%esp
 2cc:	ff 75 0c             	push   0xc(%ebp)
 2cf:	ff 75 f4             	push   -0xc(%ebp)
 2d2:	e8 5e 01 00 00       	call   435 <fstat>
 2d7:	83 c4 10             	add    $0x10,%esp
 2da:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 2dd:	83 ec 0c             	sub    $0xc,%esp
 2e0:	ff 75 f4             	push   -0xc(%ebp)
 2e3:	e8 1d 01 00 00       	call   405 <close>
 2e8:	83 c4 10             	add    $0x10,%esp
  return r;
 2eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 2ee:	c9                   	leave  
 2ef:	c3                   	ret    

000002f0 <atoi>:

int
atoi(const char *s)
{
 2f0:	55                   	push   %ebp
 2f1:	89 e5                	mov    %esp,%ebp
 2f3:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 2f6:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 2fd:	eb 25                	jmp    324 <atoi+0x34>
    n = n*10 + *s++ - '0';
 2ff:	8b 55 fc             	mov    -0x4(%ebp),%edx
 302:	89 d0                	mov    %edx,%eax
 304:	c1 e0 02             	shl    $0x2,%eax
 307:	01 d0                	add    %edx,%eax
 309:	01 c0                	add    %eax,%eax
 30b:	89 c1                	mov    %eax,%ecx
 30d:	8b 45 08             	mov    0x8(%ebp),%eax
 310:	8d 50 01             	lea    0x1(%eax),%edx
 313:	89 55 08             	mov    %edx,0x8(%ebp)
 316:	0f b6 00             	movzbl (%eax),%eax
 319:	0f be c0             	movsbl %al,%eax
 31c:	01 c8                	add    %ecx,%eax
 31e:	83 e8 30             	sub    $0x30,%eax
 321:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 324:	8b 45 08             	mov    0x8(%ebp),%eax
 327:	0f b6 00             	movzbl (%eax),%eax
 32a:	3c 2f                	cmp    $0x2f,%al
 32c:	7e 0a                	jle    338 <atoi+0x48>
 32e:	8b 45 08             	mov    0x8(%ebp),%eax
 331:	0f b6 00             	movzbl (%eax),%eax
 334:	3c 39                	cmp    $0x39,%al
 336:	7e c7                	jle    2ff <atoi+0xf>
  return n;
 338:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 33b:	c9                   	leave  
 33c:	c3                   	ret    

0000033d <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 33d:	55                   	push   %ebp
 33e:	89 e5                	mov    %esp,%ebp
 340:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
 343:	8b 45 08             	mov    0x8(%ebp),%eax
 346:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 349:	8b 45 0c             	mov    0xc(%ebp),%eax
 34c:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 34f:	eb 17                	jmp    368 <memmove+0x2b>
    *dst++ = *src++;
 351:	8b 55 f8             	mov    -0x8(%ebp),%edx
 354:	8d 42 01             	lea    0x1(%edx),%eax
 357:	89 45 f8             	mov    %eax,-0x8(%ebp)
 35a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 35d:	8d 48 01             	lea    0x1(%eax),%ecx
 360:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 363:	0f b6 12             	movzbl (%edx),%edx
 366:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 368:	8b 45 10             	mov    0x10(%ebp),%eax
 36b:	8d 50 ff             	lea    -0x1(%eax),%edx
 36e:	89 55 10             	mov    %edx,0x10(%ebp)
 371:	85 c0                	test   %eax,%eax
 373:	7f dc                	jg     351 <memmove+0x14>
  return vdst;
 375:	8b 45 08             	mov    0x8(%ebp),%eax
}
 378:	c9                   	leave  
 379:	c3                   	ret    

0000037a <calc>:

int calc(int num)
{
 37a:	55                   	push   %ebp
 37b:	89 e5                	mov    %esp,%ebp
 37d:	83 ec 10             	sub    $0x10,%esp
    int c = 0;
 380:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for(uint i = 0; i < num; i++)
 387:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
 38e:	eb 36                	jmp    3c6 <calc+0x4c>
    {
        for(uint j = 0; j < num; j++)
 390:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 397:	eb 21                	jmp    3ba <calc+0x40>
        {
            for(uint k = 0; k < num; j++)
 399:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 3a0:	eb 0c                	jmp    3ae <calc+0x34>
            {
                c >>= 10;
 3a2:	c1 7d fc 0a          	sarl   $0xa,-0x4(%ebp)
                c <<= 10;
 3a6:	c1 65 fc 0a          	shll   $0xa,-0x4(%ebp)
            for(uint k = 0; k < num; j++)
 3aa:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 3ae:	8b 45 08             	mov    0x8(%ebp),%eax
 3b1:	39 45 f0             	cmp    %eax,-0x10(%ebp)
 3b4:	72 ec                	jb     3a2 <calc+0x28>
        for(uint j = 0; j < num; j++)
 3b6:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 3ba:	8b 45 08             	mov    0x8(%ebp),%eax
 3bd:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 3c0:	72 d7                	jb     399 <calc+0x1f>
    for(uint i = 0; i < num; i++)
 3c2:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 3c6:	8b 45 08             	mov    0x8(%ebp),%eax
 3c9:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 3cc:	72 c2                	jb     390 <calc+0x16>
            }
        }
    }
    return 0;
 3ce:	b8 00 00 00 00       	mov    $0x0,%eax
}
 3d3:	c9                   	leave  
 3d4:	c3                   	ret    

000003d5 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3d5:	b8 01 00 00 00       	mov    $0x1,%eax
 3da:	cd 40                	int    $0x40
 3dc:	c3                   	ret    

000003dd <exit>:
SYSCALL(exit)
 3dd:	b8 02 00 00 00       	mov    $0x2,%eax
 3e2:	cd 40                	int    $0x40
 3e4:	c3                   	ret    

000003e5 <wait>:
SYSCALL(wait)
 3e5:	b8 03 00 00 00       	mov    $0x3,%eax
 3ea:	cd 40                	int    $0x40
 3ec:	c3                   	ret    

000003ed <pipe>:
SYSCALL(pipe)
 3ed:	b8 04 00 00 00       	mov    $0x4,%eax
 3f2:	cd 40                	int    $0x40
 3f4:	c3                   	ret    

000003f5 <read>:
SYSCALL(read)
 3f5:	b8 05 00 00 00       	mov    $0x5,%eax
 3fa:	cd 40                	int    $0x40
 3fc:	c3                   	ret    

000003fd <write>:
SYSCALL(write)
 3fd:	b8 10 00 00 00       	mov    $0x10,%eax
 402:	cd 40                	int    $0x40
 404:	c3                   	ret    

00000405 <close>:
SYSCALL(close)
 405:	b8 15 00 00 00       	mov    $0x15,%eax
 40a:	cd 40                	int    $0x40
 40c:	c3                   	ret    

0000040d <kill>:
SYSCALL(kill)
 40d:	b8 06 00 00 00       	mov    $0x6,%eax
 412:	cd 40                	int    $0x40
 414:	c3                   	ret    

00000415 <exec>:
SYSCALL(exec)
 415:	b8 07 00 00 00       	mov    $0x7,%eax
 41a:	cd 40                	int    $0x40
 41c:	c3                   	ret    

0000041d <open>:
SYSCALL(open)
 41d:	b8 0f 00 00 00       	mov    $0xf,%eax
 422:	cd 40                	int    $0x40
 424:	c3                   	ret    

00000425 <mknod>:
SYSCALL(mknod)
 425:	b8 11 00 00 00       	mov    $0x11,%eax
 42a:	cd 40                	int    $0x40
 42c:	c3                   	ret    

0000042d <unlink>:
SYSCALL(unlink)
 42d:	b8 12 00 00 00       	mov    $0x12,%eax
 432:	cd 40                	int    $0x40
 434:	c3                   	ret    

00000435 <fstat>:
SYSCALL(fstat)
 435:	b8 08 00 00 00       	mov    $0x8,%eax
 43a:	cd 40                	int    $0x40
 43c:	c3                   	ret    

0000043d <link>:
SYSCALL(link)
 43d:	b8 13 00 00 00       	mov    $0x13,%eax
 442:	cd 40                	int    $0x40
 444:	c3                   	ret    

00000445 <mkdir>:
SYSCALL(mkdir)
 445:	b8 14 00 00 00       	mov    $0x14,%eax
 44a:	cd 40                	int    $0x40
 44c:	c3                   	ret    

0000044d <chdir>:
SYSCALL(chdir)
 44d:	b8 09 00 00 00       	mov    $0x9,%eax
 452:	cd 40                	int    $0x40
 454:	c3                   	ret    

00000455 <dup>:
SYSCALL(dup)
 455:	b8 0a 00 00 00       	mov    $0xa,%eax
 45a:	cd 40                	int    $0x40
 45c:	c3                   	ret    

0000045d <getpid>:
SYSCALL(getpid)
 45d:	b8 0b 00 00 00       	mov    $0xb,%eax
 462:	cd 40                	int    $0x40
 464:	c3                   	ret    

00000465 <sbrk>:
SYSCALL(sbrk)
 465:	b8 0c 00 00 00       	mov    $0xc,%eax
 46a:	cd 40                	int    $0x40
 46c:	c3                   	ret    

0000046d <sleep>:
SYSCALL(sleep)
 46d:	b8 0d 00 00 00       	mov    $0xd,%eax
 472:	cd 40                	int    $0x40
 474:	c3                   	ret    

00000475 <uptime>:
SYSCALL(uptime)
 475:	b8 0e 00 00 00       	mov    $0xe,%eax
 47a:	cd 40                	int    $0x40
 47c:	c3                   	ret    

0000047d <print_proc>:
SYSCALL(print_proc)
 47d:	b8 16 00 00 00       	mov    $0x16,%eax
 482:	cd 40                	int    $0x40
 484:	c3                   	ret    

00000485 <change_queue>:
SYSCALL(change_queue)
 485:	b8 17 00 00 00       	mov    $0x17,%eax
 48a:	cd 40                	int    $0x40
 48c:	c3                   	ret    

0000048d <change_local_bjf>:
SYSCALL(change_local_bjf)
 48d:	b8 18 00 00 00       	mov    $0x18,%eax
 492:	cd 40                	int    $0x40
 494:	c3                   	ret    

00000495 <change_global_bjf>:
SYSCALL(change_global_bjf)
 495:	b8 19 00 00 00       	mov    $0x19,%eax
 49a:	cd 40                	int    $0x40
 49c:	c3                   	ret    

0000049d <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 49d:	55                   	push   %ebp
 49e:	89 e5                	mov    %esp,%ebp
 4a0:	83 ec 18             	sub    $0x18,%esp
 4a3:	8b 45 0c             	mov    0xc(%ebp),%eax
 4a6:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 4a9:	83 ec 04             	sub    $0x4,%esp
 4ac:	6a 01                	push   $0x1
 4ae:	8d 45 f4             	lea    -0xc(%ebp),%eax
 4b1:	50                   	push   %eax
 4b2:	ff 75 08             	push   0x8(%ebp)
 4b5:	e8 43 ff ff ff       	call   3fd <write>
 4ba:	83 c4 10             	add    $0x10,%esp
}
 4bd:	90                   	nop
 4be:	c9                   	leave  
 4bf:	c3                   	ret    

000004c0 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4c6:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4cd:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4d1:	74 17                	je     4ea <printint+0x2a>
 4d3:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4d7:	79 11                	jns    4ea <printint+0x2a>
    neg = 1;
 4d9:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4e0:	8b 45 0c             	mov    0xc(%ebp),%eax
 4e3:	f7 d8                	neg    %eax
 4e5:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4e8:	eb 06                	jmp    4f0 <printint+0x30>
  } else {
    x = xx;
 4ea:	8b 45 0c             	mov    0xc(%ebp),%eax
 4ed:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 4f0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 4f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 4fa:	8b 45 ec             	mov    -0x14(%ebp),%eax
 4fd:	ba 00 00 00 00       	mov    $0x0,%edx
 502:	f7 f1                	div    %ecx
 504:	89 d1                	mov    %edx,%ecx
 506:	8b 45 f4             	mov    -0xc(%ebp),%eax
 509:	8d 50 01             	lea    0x1(%eax),%edx
 50c:	89 55 f4             	mov    %edx,-0xc(%ebp)
 50f:	0f b6 91 f0 0b 00 00 	movzbl 0xbf0(%ecx),%edx
 516:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 51a:	8b 4d 10             	mov    0x10(%ebp),%ecx
 51d:	8b 45 ec             	mov    -0x14(%ebp),%eax
 520:	ba 00 00 00 00       	mov    $0x0,%edx
 525:	f7 f1                	div    %ecx
 527:	89 45 ec             	mov    %eax,-0x14(%ebp)
 52a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 52e:	75 c7                	jne    4f7 <printint+0x37>
  if(neg)
 530:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 534:	74 2d                	je     563 <printint+0xa3>
    buf[i++] = '-';
 536:	8b 45 f4             	mov    -0xc(%ebp),%eax
 539:	8d 50 01             	lea    0x1(%eax),%edx
 53c:	89 55 f4             	mov    %edx,-0xc(%ebp)
 53f:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 544:	eb 1d                	jmp    563 <printint+0xa3>
    putc(fd, buf[i]);
 546:	8d 55 dc             	lea    -0x24(%ebp),%edx
 549:	8b 45 f4             	mov    -0xc(%ebp),%eax
 54c:	01 d0                	add    %edx,%eax
 54e:	0f b6 00             	movzbl (%eax),%eax
 551:	0f be c0             	movsbl %al,%eax
 554:	83 ec 08             	sub    $0x8,%esp
 557:	50                   	push   %eax
 558:	ff 75 08             	push   0x8(%ebp)
 55b:	e8 3d ff ff ff       	call   49d <putc>
 560:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 563:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 567:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 56b:	79 d9                	jns    546 <printint+0x86>
}
 56d:	90                   	nop
 56e:	90                   	nop
 56f:	c9                   	leave  
 570:	c3                   	ret    

00000571 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 571:	55                   	push   %ebp
 572:	89 e5                	mov    %esp,%ebp
 574:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 577:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 57e:	8d 45 0c             	lea    0xc(%ebp),%eax
 581:	83 c0 04             	add    $0x4,%eax
 584:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 587:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 58e:	e9 59 01 00 00       	jmp    6ec <printf+0x17b>
    c = fmt[i] & 0xff;
 593:	8b 55 0c             	mov    0xc(%ebp),%edx
 596:	8b 45 f0             	mov    -0x10(%ebp),%eax
 599:	01 d0                	add    %edx,%eax
 59b:	0f b6 00             	movzbl (%eax),%eax
 59e:	0f be c0             	movsbl %al,%eax
 5a1:	25 ff 00 00 00       	and    $0xff,%eax
 5a6:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 5a9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5ad:	75 2c                	jne    5db <printf+0x6a>
      if(c == '%'){
 5af:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5b3:	75 0c                	jne    5c1 <printf+0x50>
        state = '%';
 5b5:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5bc:	e9 27 01 00 00       	jmp    6e8 <printf+0x177>
      } else {
        putc(fd, c);
 5c1:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5c4:	0f be c0             	movsbl %al,%eax
 5c7:	83 ec 08             	sub    $0x8,%esp
 5ca:	50                   	push   %eax
 5cb:	ff 75 08             	push   0x8(%ebp)
 5ce:	e8 ca fe ff ff       	call   49d <putc>
 5d3:	83 c4 10             	add    $0x10,%esp
 5d6:	e9 0d 01 00 00       	jmp    6e8 <printf+0x177>
      }
    } else if(state == '%'){
 5db:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5df:	0f 85 03 01 00 00    	jne    6e8 <printf+0x177>
      if(c == 'd'){
 5e5:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 5e9:	75 1e                	jne    609 <printf+0x98>
        printint(fd, *ap, 10, 1);
 5eb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 5ee:	8b 00                	mov    (%eax),%eax
 5f0:	6a 01                	push   $0x1
 5f2:	6a 0a                	push   $0xa
 5f4:	50                   	push   %eax
 5f5:	ff 75 08             	push   0x8(%ebp)
 5f8:	e8 c3 fe ff ff       	call   4c0 <printint>
 5fd:	83 c4 10             	add    $0x10,%esp
        ap++;
 600:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 604:	e9 d8 00 00 00       	jmp    6e1 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 609:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 60d:	74 06                	je     615 <printf+0xa4>
 60f:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 613:	75 1e                	jne    633 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 615:	8b 45 e8             	mov    -0x18(%ebp),%eax
 618:	8b 00                	mov    (%eax),%eax
 61a:	6a 00                	push   $0x0
 61c:	6a 10                	push   $0x10
 61e:	50                   	push   %eax
 61f:	ff 75 08             	push   0x8(%ebp)
 622:	e8 99 fe ff ff       	call   4c0 <printint>
 627:	83 c4 10             	add    $0x10,%esp
        ap++;
 62a:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 62e:	e9 ae 00 00 00       	jmp    6e1 <printf+0x170>
      } else if(c == 's'){
 633:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 637:	75 43                	jne    67c <printf+0x10b>
        s = (char*)*ap;
 639:	8b 45 e8             	mov    -0x18(%ebp),%eax
 63c:	8b 00                	mov    (%eax),%eax
 63e:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 641:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 645:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 649:	75 25                	jne    670 <printf+0xff>
          s = "(null)";
 64b:	c7 45 f4 60 09 00 00 	movl   $0x960,-0xc(%ebp)
        while(*s != 0){
 652:	eb 1c                	jmp    670 <printf+0xff>
          putc(fd, *s);
 654:	8b 45 f4             	mov    -0xc(%ebp),%eax
 657:	0f b6 00             	movzbl (%eax),%eax
 65a:	0f be c0             	movsbl %al,%eax
 65d:	83 ec 08             	sub    $0x8,%esp
 660:	50                   	push   %eax
 661:	ff 75 08             	push   0x8(%ebp)
 664:	e8 34 fe ff ff       	call   49d <putc>
 669:	83 c4 10             	add    $0x10,%esp
          s++;
 66c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 670:	8b 45 f4             	mov    -0xc(%ebp),%eax
 673:	0f b6 00             	movzbl (%eax),%eax
 676:	84 c0                	test   %al,%al
 678:	75 da                	jne    654 <printf+0xe3>
 67a:	eb 65                	jmp    6e1 <printf+0x170>
        }
      } else if(c == 'c'){
 67c:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 680:	75 1d                	jne    69f <printf+0x12e>
        putc(fd, *ap);
 682:	8b 45 e8             	mov    -0x18(%ebp),%eax
 685:	8b 00                	mov    (%eax),%eax
 687:	0f be c0             	movsbl %al,%eax
 68a:	83 ec 08             	sub    $0x8,%esp
 68d:	50                   	push   %eax
 68e:	ff 75 08             	push   0x8(%ebp)
 691:	e8 07 fe ff ff       	call   49d <putc>
 696:	83 c4 10             	add    $0x10,%esp
        ap++;
 699:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 69d:	eb 42                	jmp    6e1 <printf+0x170>
      } else if(c == '%'){
 69f:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6a3:	75 17                	jne    6bc <printf+0x14b>
        putc(fd, c);
 6a5:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6a8:	0f be c0             	movsbl %al,%eax
 6ab:	83 ec 08             	sub    $0x8,%esp
 6ae:	50                   	push   %eax
 6af:	ff 75 08             	push   0x8(%ebp)
 6b2:	e8 e6 fd ff ff       	call   49d <putc>
 6b7:	83 c4 10             	add    $0x10,%esp
 6ba:	eb 25                	jmp    6e1 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6bc:	83 ec 08             	sub    $0x8,%esp
 6bf:	6a 25                	push   $0x25
 6c1:	ff 75 08             	push   0x8(%ebp)
 6c4:	e8 d4 fd ff ff       	call   49d <putc>
 6c9:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 6cc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6cf:	0f be c0             	movsbl %al,%eax
 6d2:	83 ec 08             	sub    $0x8,%esp
 6d5:	50                   	push   %eax
 6d6:	ff 75 08             	push   0x8(%ebp)
 6d9:	e8 bf fd ff ff       	call   49d <putc>
 6de:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 6e1:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 6e8:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 6ec:	8b 55 0c             	mov    0xc(%ebp),%edx
 6ef:	8b 45 f0             	mov    -0x10(%ebp),%eax
 6f2:	01 d0                	add    %edx,%eax
 6f4:	0f b6 00             	movzbl (%eax),%eax
 6f7:	84 c0                	test   %al,%al
 6f9:	0f 85 94 fe ff ff    	jne    593 <printf+0x22>
    }
  }
}
 6ff:	90                   	nop
 700:	90                   	nop
 701:	c9                   	leave  
 702:	c3                   	ret    

00000703 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 703:	55                   	push   %ebp
 704:	89 e5                	mov    %esp,%ebp
 706:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 709:	8b 45 08             	mov    0x8(%ebp),%eax
 70c:	83 e8 08             	sub    $0x8,%eax
 70f:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 712:	a1 28 0e 00 00       	mov    0xe28,%eax
 717:	89 45 fc             	mov    %eax,-0x4(%ebp)
 71a:	eb 24                	jmp    740 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 71c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 71f:	8b 00                	mov    (%eax),%eax
 721:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 724:	72 12                	jb     738 <free+0x35>
 726:	8b 45 f8             	mov    -0x8(%ebp),%eax
 729:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 72c:	77 24                	ja     752 <free+0x4f>
 72e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 731:	8b 00                	mov    (%eax),%eax
 733:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 736:	72 1a                	jb     752 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 738:	8b 45 fc             	mov    -0x4(%ebp),%eax
 73b:	8b 00                	mov    (%eax),%eax
 73d:	89 45 fc             	mov    %eax,-0x4(%ebp)
 740:	8b 45 f8             	mov    -0x8(%ebp),%eax
 743:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 746:	76 d4                	jbe    71c <free+0x19>
 748:	8b 45 fc             	mov    -0x4(%ebp),%eax
 74b:	8b 00                	mov    (%eax),%eax
 74d:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 750:	73 ca                	jae    71c <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 752:	8b 45 f8             	mov    -0x8(%ebp),%eax
 755:	8b 40 04             	mov    0x4(%eax),%eax
 758:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 75f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 762:	01 c2                	add    %eax,%edx
 764:	8b 45 fc             	mov    -0x4(%ebp),%eax
 767:	8b 00                	mov    (%eax),%eax
 769:	39 c2                	cmp    %eax,%edx
 76b:	75 24                	jne    791 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 76d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 770:	8b 50 04             	mov    0x4(%eax),%edx
 773:	8b 45 fc             	mov    -0x4(%ebp),%eax
 776:	8b 00                	mov    (%eax),%eax
 778:	8b 40 04             	mov    0x4(%eax),%eax
 77b:	01 c2                	add    %eax,%edx
 77d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 780:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 783:	8b 45 fc             	mov    -0x4(%ebp),%eax
 786:	8b 00                	mov    (%eax),%eax
 788:	8b 10                	mov    (%eax),%edx
 78a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 78d:	89 10                	mov    %edx,(%eax)
 78f:	eb 0a                	jmp    79b <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 791:	8b 45 fc             	mov    -0x4(%ebp),%eax
 794:	8b 10                	mov    (%eax),%edx
 796:	8b 45 f8             	mov    -0x8(%ebp),%eax
 799:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 79b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 79e:	8b 40 04             	mov    0x4(%eax),%eax
 7a1:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ab:	01 d0                	add    %edx,%eax
 7ad:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 7b0:	75 20                	jne    7d2 <free+0xcf>
    p->s.size += bp->s.size;
 7b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b5:	8b 50 04             	mov    0x4(%eax),%edx
 7b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7bb:	8b 40 04             	mov    0x4(%eax),%eax
 7be:	01 c2                	add    %eax,%edx
 7c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c3:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7c6:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7c9:	8b 10                	mov    (%eax),%edx
 7cb:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ce:	89 10                	mov    %edx,(%eax)
 7d0:	eb 08                	jmp    7da <free+0xd7>
  } else
    p->s.ptr = bp;
 7d2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7d5:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7d8:	89 10                	mov    %edx,(%eax)
  freep = p;
 7da:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7dd:	a3 28 0e 00 00       	mov    %eax,0xe28
}
 7e2:	90                   	nop
 7e3:	c9                   	leave  
 7e4:	c3                   	ret    

000007e5 <morecore>:

static Header*
morecore(uint nu)
{
 7e5:	55                   	push   %ebp
 7e6:	89 e5                	mov    %esp,%ebp
 7e8:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 7eb:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 7f2:	77 07                	ja     7fb <morecore+0x16>
    nu = 4096;
 7f4:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 7fb:	8b 45 08             	mov    0x8(%ebp),%eax
 7fe:	c1 e0 03             	shl    $0x3,%eax
 801:	83 ec 0c             	sub    $0xc,%esp
 804:	50                   	push   %eax
 805:	e8 5b fc ff ff       	call   465 <sbrk>
 80a:	83 c4 10             	add    $0x10,%esp
 80d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 810:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 814:	75 07                	jne    81d <morecore+0x38>
    return 0;
 816:	b8 00 00 00 00       	mov    $0x0,%eax
 81b:	eb 26                	jmp    843 <morecore+0x5e>
  hp = (Header*)p;
 81d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 820:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 823:	8b 45 f0             	mov    -0x10(%ebp),%eax
 826:	8b 55 08             	mov    0x8(%ebp),%edx
 829:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 82c:	8b 45 f0             	mov    -0x10(%ebp),%eax
 82f:	83 c0 08             	add    $0x8,%eax
 832:	83 ec 0c             	sub    $0xc,%esp
 835:	50                   	push   %eax
 836:	e8 c8 fe ff ff       	call   703 <free>
 83b:	83 c4 10             	add    $0x10,%esp
  return freep;
 83e:	a1 28 0e 00 00       	mov    0xe28,%eax
}
 843:	c9                   	leave  
 844:	c3                   	ret    

00000845 <malloc>:

void*
malloc(uint nbytes)
{
 845:	55                   	push   %ebp
 846:	89 e5                	mov    %esp,%ebp
 848:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 84b:	8b 45 08             	mov    0x8(%ebp),%eax
 84e:	83 c0 07             	add    $0x7,%eax
 851:	c1 e8 03             	shr    $0x3,%eax
 854:	83 c0 01             	add    $0x1,%eax
 857:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 85a:	a1 28 0e 00 00       	mov    0xe28,%eax
 85f:	89 45 f0             	mov    %eax,-0x10(%ebp)
 862:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 866:	75 23                	jne    88b <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 868:	c7 45 f0 20 0e 00 00 	movl   $0xe20,-0x10(%ebp)
 86f:	8b 45 f0             	mov    -0x10(%ebp),%eax
 872:	a3 28 0e 00 00       	mov    %eax,0xe28
 877:	a1 28 0e 00 00       	mov    0xe28,%eax
 87c:	a3 20 0e 00 00       	mov    %eax,0xe20
    base.s.size = 0;
 881:	c7 05 24 0e 00 00 00 	movl   $0x0,0xe24
 888:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 88b:	8b 45 f0             	mov    -0x10(%ebp),%eax
 88e:	8b 00                	mov    (%eax),%eax
 890:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 893:	8b 45 f4             	mov    -0xc(%ebp),%eax
 896:	8b 40 04             	mov    0x4(%eax),%eax
 899:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 89c:	77 4d                	ja     8eb <malloc+0xa6>
      if(p->s.size == nunits)
 89e:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a1:	8b 40 04             	mov    0x4(%eax),%eax
 8a4:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 8a7:	75 0c                	jne    8b5 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 8a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ac:	8b 10                	mov    (%eax),%edx
 8ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8b1:	89 10                	mov    %edx,(%eax)
 8b3:	eb 26                	jmp    8db <malloc+0x96>
      else {
        p->s.size -= nunits;
 8b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b8:	8b 40 04             	mov    0x4(%eax),%eax
 8bb:	2b 45 ec             	sub    -0x14(%ebp),%eax
 8be:	89 c2                	mov    %eax,%edx
 8c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c3:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c9:	8b 40 04             	mov    0x4(%eax),%eax
 8cc:	c1 e0 03             	shl    $0x3,%eax
 8cf:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8d5:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8d8:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8db:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8de:	a3 28 0e 00 00       	mov    %eax,0xe28
      return (void*)(p + 1);
 8e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8e6:	83 c0 08             	add    $0x8,%eax
 8e9:	eb 3b                	jmp    926 <malloc+0xe1>
    }
    if(p == freep)
 8eb:	a1 28 0e 00 00       	mov    0xe28,%eax
 8f0:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 8f3:	75 1e                	jne    913 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 8f5:	83 ec 0c             	sub    $0xc,%esp
 8f8:	ff 75 ec             	push   -0x14(%ebp)
 8fb:	e8 e5 fe ff ff       	call   7e5 <morecore>
 900:	83 c4 10             	add    $0x10,%esp
 903:	89 45 f4             	mov    %eax,-0xc(%ebp)
 906:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 90a:	75 07                	jne    913 <malloc+0xce>
        return 0;
 90c:	b8 00 00 00 00       	mov    $0x0,%eax
 911:	eb 13                	jmp    926 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 913:	8b 45 f4             	mov    -0xc(%ebp),%eax
 916:	89 45 f0             	mov    %eax,-0x10(%ebp)
 919:	8b 45 f4             	mov    -0xc(%ebp),%eax
 91c:	8b 00                	mov    (%eax),%eax
 91e:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 921:	e9 6d ff ff ff       	jmp    893 <malloc+0x4e>
  }
}
 926:	c9                   	leave  
 927:	c3                   	ret    
