
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	83 ec 28             	sub    $0x28,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
   6:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
   d:	8b 45 e8             	mov    -0x18(%ebp),%eax
  10:	89 45 ec             	mov    %eax,-0x14(%ebp)
  13:	8b 45 ec             	mov    -0x14(%ebp),%eax
  16:	89 45 f0             	mov    %eax,-0x10(%ebp)
  inword = 0;
  19:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  20:	eb 69                	jmp    8b <wc+0x8b>
    for(i=0; i<n; i++){
  22:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  29:	eb 58                	jmp    83 <wc+0x83>
      c++;
  2b:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
      if(buf[i] == '\n')
  2f:	8b 45 f4             	mov    -0xc(%ebp),%eax
  32:	05 a0 0c 00 00       	add    $0xca0,%eax
  37:	0f b6 00             	movzbl (%eax),%eax
  3a:	3c 0a                	cmp    $0xa,%al
  3c:	75 04                	jne    42 <wc+0x42>
        l++;
  3e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(strchr(" \r\t\n\v", buf[i]))
  42:	8b 45 f4             	mov    -0xc(%ebp),%eax
  45:	05 a0 0c 00 00       	add    $0xca0,%eax
  4a:	0f b6 00             	movzbl (%eax),%eax
  4d:	0f be c0             	movsbl %al,%eax
  50:	83 ec 08             	sub    $0x8,%esp
  53:	50                   	push   %eax
  54:	68 ba 09 00 00       	push   $0x9ba
  59:	e8 35 02 00 00       	call   293 <strchr>
  5e:	83 c4 10             	add    $0x10,%esp
  61:	85 c0                	test   %eax,%eax
  63:	74 09                	je     6e <wc+0x6e>
        inword = 0;
  65:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  6c:	eb 11                	jmp    7f <wc+0x7f>
      else if(!inword){
  6e:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  72:	75 0b                	jne    7f <wc+0x7f>
        w++;
  74:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
        inword = 1;
  78:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
    for(i=0; i<n; i++){
  7f:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  83:	8b 45 f4             	mov    -0xc(%ebp),%eax
  86:	3b 45 e0             	cmp    -0x20(%ebp),%eax
  89:	7c a0                	jl     2b <wc+0x2b>
  while((n = read(fd, buf, sizeof(buf))) > 0){
  8b:	83 ec 04             	sub    $0x4,%esp
  8e:	68 00 02 00 00       	push   $0x200
  93:	68 a0 0c 00 00       	push   $0xca0
  98:	ff 75 08             	push   0x8(%ebp)
  9b:	e8 e7 03 00 00       	call   487 <read>
  a0:	83 c4 10             	add    $0x10,%esp
  a3:	89 45 e0             	mov    %eax,-0x20(%ebp)
  a6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  aa:	0f 8f 72 ff ff ff    	jg     22 <wc+0x22>
      }
    }
  }
  if(n < 0){
  b0:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
  b4:	79 17                	jns    cd <wc+0xcd>
    printf(1, "wc: read error\n");
  b6:	83 ec 08             	sub    $0x8,%esp
  b9:	68 c0 09 00 00       	push   $0x9c0
  be:	6a 01                	push   $0x1
  c0:	e8 3e 05 00 00       	call   603 <printf>
  c5:	83 c4 10             	add    $0x10,%esp
    exit();
  c8:	e8 a2 03 00 00       	call   46f <exit>
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
  cd:	83 ec 08             	sub    $0x8,%esp
  d0:	ff 75 0c             	push   0xc(%ebp)
  d3:	ff 75 e8             	push   -0x18(%ebp)
  d6:	ff 75 ec             	push   -0x14(%ebp)
  d9:	ff 75 f0             	push   -0x10(%ebp)
  dc:	68 d0 09 00 00       	push   $0x9d0
  e1:	6a 01                	push   $0x1
  e3:	e8 1b 05 00 00       	call   603 <printf>
  e8:	83 c4 20             	add    $0x20,%esp
}
  eb:	90                   	nop
  ec:	c9                   	leave  
  ed:	c3                   	ret    

000000ee <main>:

int
main(int argc, char *argv[])
{
  ee:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  f2:	83 e4 f0             	and    $0xfffffff0,%esp
  f5:	ff 71 fc             	push   -0x4(%ecx)
  f8:	55                   	push   %ebp
  f9:	89 e5                	mov    %esp,%ebp
  fb:	53                   	push   %ebx
  fc:	51                   	push   %ecx
  fd:	83 ec 10             	sub    $0x10,%esp
 100:	89 cb                	mov    %ecx,%ebx
  int fd, i;

  if(argc <= 1){
 102:	83 3b 01             	cmpl   $0x1,(%ebx)
 105:	7f 17                	jg     11e <main+0x30>
    wc(0, "");
 107:	83 ec 08             	sub    $0x8,%esp
 10a:	68 dd 09 00 00       	push   $0x9dd
 10f:	6a 00                	push   $0x0
 111:	e8 ea fe ff ff       	call   0 <wc>
 116:	83 c4 10             	add    $0x10,%esp
    exit();
 119:	e8 51 03 00 00       	call   46f <exit>
  }

  for(i = 1; i < argc; i++){
 11e:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
 125:	e9 83 00 00 00       	jmp    1ad <main+0xbf>
    if((fd = open(argv[i], 0)) < 0){
 12a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 12d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 134:	8b 43 04             	mov    0x4(%ebx),%eax
 137:	01 d0                	add    %edx,%eax
 139:	8b 00                	mov    (%eax),%eax
 13b:	83 ec 08             	sub    $0x8,%esp
 13e:	6a 00                	push   $0x0
 140:	50                   	push   %eax
 141:	e8 69 03 00 00       	call   4af <open>
 146:	83 c4 10             	add    $0x10,%esp
 149:	89 45 f0             	mov    %eax,-0x10(%ebp)
 14c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 150:	79 29                	jns    17b <main+0x8d>
      printf(1, "wc: cannot open %s\n", argv[i]);
 152:	8b 45 f4             	mov    -0xc(%ebp),%eax
 155:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 15c:	8b 43 04             	mov    0x4(%ebx),%eax
 15f:	01 d0                	add    %edx,%eax
 161:	8b 00                	mov    (%eax),%eax
 163:	83 ec 04             	sub    $0x4,%esp
 166:	50                   	push   %eax
 167:	68 de 09 00 00       	push   $0x9de
 16c:	6a 01                	push   $0x1
 16e:	e8 90 04 00 00       	call   603 <printf>
 173:	83 c4 10             	add    $0x10,%esp
      exit();
 176:	e8 f4 02 00 00       	call   46f <exit>
    }
    wc(fd, argv[i]);
 17b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 17e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 185:	8b 43 04             	mov    0x4(%ebx),%eax
 188:	01 d0                	add    %edx,%eax
 18a:	8b 00                	mov    (%eax),%eax
 18c:	83 ec 08             	sub    $0x8,%esp
 18f:	50                   	push   %eax
 190:	ff 75 f0             	push   -0x10(%ebp)
 193:	e8 68 fe ff ff       	call   0 <wc>
 198:	83 c4 10             	add    $0x10,%esp
    close(fd);
 19b:	83 ec 0c             	sub    $0xc,%esp
 19e:	ff 75 f0             	push   -0x10(%ebp)
 1a1:	e8 f1 02 00 00       	call   497 <close>
 1a6:	83 c4 10             	add    $0x10,%esp
  for(i = 1; i < argc; i++){
 1a9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 1ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
 1b0:	3b 03                	cmp    (%ebx),%eax
 1b2:	0f 8c 72 ff ff ff    	jl     12a <main+0x3c>
  }
  exit();
 1b8:	e8 b2 02 00 00       	call   46f <exit>

000001bd <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 1bd:	55                   	push   %ebp
 1be:	89 e5                	mov    %esp,%ebp
 1c0:	57                   	push   %edi
 1c1:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 1c2:	8b 4d 08             	mov    0x8(%ebp),%ecx
 1c5:	8b 55 10             	mov    0x10(%ebp),%edx
 1c8:	8b 45 0c             	mov    0xc(%ebp),%eax
 1cb:	89 cb                	mov    %ecx,%ebx
 1cd:	89 df                	mov    %ebx,%edi
 1cf:	89 d1                	mov    %edx,%ecx
 1d1:	fc                   	cld    
 1d2:	f3 aa                	rep stos %al,%es:(%edi)
 1d4:	89 ca                	mov    %ecx,%edx
 1d6:	89 fb                	mov    %edi,%ebx
 1d8:	89 5d 08             	mov    %ebx,0x8(%ebp)
 1db:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 1de:	90                   	nop
 1df:	5b                   	pop    %ebx
 1e0:	5f                   	pop    %edi
 1e1:	5d                   	pop    %ebp
 1e2:	c3                   	ret    

000001e3 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 1e3:	55                   	push   %ebp
 1e4:	89 e5                	mov    %esp,%ebp
 1e6:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 1e9:	8b 45 08             	mov    0x8(%ebp),%eax
 1ec:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 1ef:	90                   	nop
 1f0:	8b 55 0c             	mov    0xc(%ebp),%edx
 1f3:	8d 42 01             	lea    0x1(%edx),%eax
 1f6:	89 45 0c             	mov    %eax,0xc(%ebp)
 1f9:	8b 45 08             	mov    0x8(%ebp),%eax
 1fc:	8d 48 01             	lea    0x1(%eax),%ecx
 1ff:	89 4d 08             	mov    %ecx,0x8(%ebp)
 202:	0f b6 12             	movzbl (%edx),%edx
 205:	88 10                	mov    %dl,(%eax)
 207:	0f b6 00             	movzbl (%eax),%eax
 20a:	84 c0                	test   %al,%al
 20c:	75 e2                	jne    1f0 <strcpy+0xd>
    ;
  return os;
 20e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 211:	c9                   	leave  
 212:	c3                   	ret    

00000213 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 213:	55                   	push   %ebp
 214:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 216:	eb 08                	jmp    220 <strcmp+0xd>
    p++, q++;
 218:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 21c:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 220:	8b 45 08             	mov    0x8(%ebp),%eax
 223:	0f b6 00             	movzbl (%eax),%eax
 226:	84 c0                	test   %al,%al
 228:	74 10                	je     23a <strcmp+0x27>
 22a:	8b 45 08             	mov    0x8(%ebp),%eax
 22d:	0f b6 10             	movzbl (%eax),%edx
 230:	8b 45 0c             	mov    0xc(%ebp),%eax
 233:	0f b6 00             	movzbl (%eax),%eax
 236:	38 c2                	cmp    %al,%dl
 238:	74 de                	je     218 <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 23a:	8b 45 08             	mov    0x8(%ebp),%eax
 23d:	0f b6 00             	movzbl (%eax),%eax
 240:	0f b6 d0             	movzbl %al,%edx
 243:	8b 45 0c             	mov    0xc(%ebp),%eax
 246:	0f b6 00             	movzbl (%eax),%eax
 249:	0f b6 c8             	movzbl %al,%ecx
 24c:	89 d0                	mov    %edx,%eax
 24e:	29 c8                	sub    %ecx,%eax
}
 250:	5d                   	pop    %ebp
 251:	c3                   	ret    

00000252 <strlen>:

uint
strlen(const char *s)
{
 252:	55                   	push   %ebp
 253:	89 e5                	mov    %esp,%ebp
 255:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 258:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 25f:	eb 04                	jmp    265 <strlen+0x13>
 261:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 265:	8b 55 fc             	mov    -0x4(%ebp),%edx
 268:	8b 45 08             	mov    0x8(%ebp),%eax
 26b:	01 d0                	add    %edx,%eax
 26d:	0f b6 00             	movzbl (%eax),%eax
 270:	84 c0                	test   %al,%al
 272:	75 ed                	jne    261 <strlen+0xf>
    ;
  return n;
 274:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 277:	c9                   	leave  
 278:	c3                   	ret    

00000279 <memset>:

void*
memset(void *dst, int c, uint n)
{
 279:	55                   	push   %ebp
 27a:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 27c:	8b 45 10             	mov    0x10(%ebp),%eax
 27f:	50                   	push   %eax
 280:	ff 75 0c             	push   0xc(%ebp)
 283:	ff 75 08             	push   0x8(%ebp)
 286:	e8 32 ff ff ff       	call   1bd <stosb>
 28b:	83 c4 0c             	add    $0xc,%esp
  return dst;
 28e:	8b 45 08             	mov    0x8(%ebp),%eax
}
 291:	c9                   	leave  
 292:	c3                   	ret    

00000293 <strchr>:

char*
strchr(const char *s, char c)
{
 293:	55                   	push   %ebp
 294:	89 e5                	mov    %esp,%ebp
 296:	83 ec 04             	sub    $0x4,%esp
 299:	8b 45 0c             	mov    0xc(%ebp),%eax
 29c:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 29f:	eb 14                	jmp    2b5 <strchr+0x22>
    if(*s == c)
 2a1:	8b 45 08             	mov    0x8(%ebp),%eax
 2a4:	0f b6 00             	movzbl (%eax),%eax
 2a7:	38 45 fc             	cmp    %al,-0x4(%ebp)
 2aa:	75 05                	jne    2b1 <strchr+0x1e>
      return (char*)s;
 2ac:	8b 45 08             	mov    0x8(%ebp),%eax
 2af:	eb 13                	jmp    2c4 <strchr+0x31>
  for(; *s; s++)
 2b1:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 2b5:	8b 45 08             	mov    0x8(%ebp),%eax
 2b8:	0f b6 00             	movzbl (%eax),%eax
 2bb:	84 c0                	test   %al,%al
 2bd:	75 e2                	jne    2a1 <strchr+0xe>
  return 0;
 2bf:	b8 00 00 00 00       	mov    $0x0,%eax
}
 2c4:	c9                   	leave  
 2c5:	c3                   	ret    

000002c6 <gets>:

char*
gets(char *buf, int max)
{
 2c6:	55                   	push   %ebp
 2c7:	89 e5                	mov    %esp,%ebp
 2c9:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 2cc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 2d3:	eb 42                	jmp    317 <gets+0x51>
    cc = read(0, &c, 1);
 2d5:	83 ec 04             	sub    $0x4,%esp
 2d8:	6a 01                	push   $0x1
 2da:	8d 45 ef             	lea    -0x11(%ebp),%eax
 2dd:	50                   	push   %eax
 2de:	6a 00                	push   $0x0
 2e0:	e8 a2 01 00 00       	call   487 <read>
 2e5:	83 c4 10             	add    $0x10,%esp
 2e8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 2eb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 2ef:	7e 33                	jle    324 <gets+0x5e>
      break;
    buf[i++] = c;
 2f1:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2f4:	8d 50 01             	lea    0x1(%eax),%edx
 2f7:	89 55 f4             	mov    %edx,-0xc(%ebp)
 2fa:	89 c2                	mov    %eax,%edx
 2fc:	8b 45 08             	mov    0x8(%ebp),%eax
 2ff:	01 c2                	add    %eax,%edx
 301:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 305:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 307:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 30b:	3c 0a                	cmp    $0xa,%al
 30d:	74 16                	je     325 <gets+0x5f>
 30f:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 313:	3c 0d                	cmp    $0xd,%al
 315:	74 0e                	je     325 <gets+0x5f>
  for(i=0; i+1 < max; ){
 317:	8b 45 f4             	mov    -0xc(%ebp),%eax
 31a:	83 c0 01             	add    $0x1,%eax
 31d:	39 45 0c             	cmp    %eax,0xc(%ebp)
 320:	7f b3                	jg     2d5 <gets+0xf>
 322:	eb 01                	jmp    325 <gets+0x5f>
      break;
 324:	90                   	nop
      break;
  }
  buf[i] = '\0';
 325:	8b 55 f4             	mov    -0xc(%ebp),%edx
 328:	8b 45 08             	mov    0x8(%ebp),%eax
 32b:	01 d0                	add    %edx,%eax
 32d:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 330:	8b 45 08             	mov    0x8(%ebp),%eax
}
 333:	c9                   	leave  
 334:	c3                   	ret    

00000335 <stat>:

int
stat(const char *n, struct stat *st)
{
 335:	55                   	push   %ebp
 336:	89 e5                	mov    %esp,%ebp
 338:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 33b:	83 ec 08             	sub    $0x8,%esp
 33e:	6a 00                	push   $0x0
 340:	ff 75 08             	push   0x8(%ebp)
 343:	e8 67 01 00 00       	call   4af <open>
 348:	83 c4 10             	add    $0x10,%esp
 34b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 34e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 352:	79 07                	jns    35b <stat+0x26>
    return -1;
 354:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 359:	eb 25                	jmp    380 <stat+0x4b>
  r = fstat(fd, st);
 35b:	83 ec 08             	sub    $0x8,%esp
 35e:	ff 75 0c             	push   0xc(%ebp)
 361:	ff 75 f4             	push   -0xc(%ebp)
 364:	e8 5e 01 00 00       	call   4c7 <fstat>
 369:	83 c4 10             	add    $0x10,%esp
 36c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 36f:	83 ec 0c             	sub    $0xc,%esp
 372:	ff 75 f4             	push   -0xc(%ebp)
 375:	e8 1d 01 00 00       	call   497 <close>
 37a:	83 c4 10             	add    $0x10,%esp
  return r;
 37d:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 380:	c9                   	leave  
 381:	c3                   	ret    

00000382 <atoi>:

int
atoi(const char *s)
{
 382:	55                   	push   %ebp
 383:	89 e5                	mov    %esp,%ebp
 385:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 388:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 38f:	eb 25                	jmp    3b6 <atoi+0x34>
    n = n*10 + *s++ - '0';
 391:	8b 55 fc             	mov    -0x4(%ebp),%edx
 394:	89 d0                	mov    %edx,%eax
 396:	c1 e0 02             	shl    $0x2,%eax
 399:	01 d0                	add    %edx,%eax
 39b:	01 c0                	add    %eax,%eax
 39d:	89 c1                	mov    %eax,%ecx
 39f:	8b 45 08             	mov    0x8(%ebp),%eax
 3a2:	8d 50 01             	lea    0x1(%eax),%edx
 3a5:	89 55 08             	mov    %edx,0x8(%ebp)
 3a8:	0f b6 00             	movzbl (%eax),%eax
 3ab:	0f be c0             	movsbl %al,%eax
 3ae:	01 c8                	add    %ecx,%eax
 3b0:	83 e8 30             	sub    $0x30,%eax
 3b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 3b6:	8b 45 08             	mov    0x8(%ebp),%eax
 3b9:	0f b6 00             	movzbl (%eax),%eax
 3bc:	3c 2f                	cmp    $0x2f,%al
 3be:	7e 0a                	jle    3ca <atoi+0x48>
 3c0:	8b 45 08             	mov    0x8(%ebp),%eax
 3c3:	0f b6 00             	movzbl (%eax),%eax
 3c6:	3c 39                	cmp    $0x39,%al
 3c8:	7e c7                	jle    391 <atoi+0xf>
  return n;
 3ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3cd:	c9                   	leave  
 3ce:	c3                   	ret    

000003cf <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3cf:	55                   	push   %ebp
 3d0:	89 e5                	mov    %esp,%ebp
 3d2:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
 3d5:	8b 45 08             	mov    0x8(%ebp),%eax
 3d8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 3db:	8b 45 0c             	mov    0xc(%ebp),%eax
 3de:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 3e1:	eb 17                	jmp    3fa <memmove+0x2b>
    *dst++ = *src++;
 3e3:	8b 55 f8             	mov    -0x8(%ebp),%edx
 3e6:	8d 42 01             	lea    0x1(%edx),%eax
 3e9:	89 45 f8             	mov    %eax,-0x8(%ebp)
 3ec:	8b 45 fc             	mov    -0x4(%ebp),%eax
 3ef:	8d 48 01             	lea    0x1(%eax),%ecx
 3f2:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 3f5:	0f b6 12             	movzbl (%edx),%edx
 3f8:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 3fa:	8b 45 10             	mov    0x10(%ebp),%eax
 3fd:	8d 50 ff             	lea    -0x1(%eax),%edx
 400:	89 55 10             	mov    %edx,0x10(%ebp)
 403:	85 c0                	test   %eax,%eax
 405:	7f dc                	jg     3e3 <memmove+0x14>
  return vdst;
 407:	8b 45 08             	mov    0x8(%ebp),%eax
}
 40a:	c9                   	leave  
 40b:	c3                   	ret    

0000040c <calc>:

int calc(int num)
{
 40c:	55                   	push   %ebp
 40d:	89 e5                	mov    %esp,%ebp
 40f:	83 ec 10             	sub    $0x10,%esp
    int c = 0;
 412:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for(uint i = 0; i < num; i++)
 419:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
 420:	eb 36                	jmp    458 <calc+0x4c>
    {
        for(uint j = 0; j < num; j++)
 422:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 429:	eb 21                	jmp    44c <calc+0x40>
        {
            for(uint k = 0; k < num; j++)
 42b:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 432:	eb 0c                	jmp    440 <calc+0x34>
            {
                c >>= 10;
 434:	c1 7d fc 0a          	sarl   $0xa,-0x4(%ebp)
                c <<= 10;
 438:	c1 65 fc 0a          	shll   $0xa,-0x4(%ebp)
            for(uint k = 0; k < num; j++)
 43c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 440:	8b 45 08             	mov    0x8(%ebp),%eax
 443:	39 45 f0             	cmp    %eax,-0x10(%ebp)
 446:	72 ec                	jb     434 <calc+0x28>
        for(uint j = 0; j < num; j++)
 448:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 44c:	8b 45 08             	mov    0x8(%ebp),%eax
 44f:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 452:	72 d7                	jb     42b <calc+0x1f>
    for(uint i = 0; i < num; i++)
 454:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 458:	8b 45 08             	mov    0x8(%ebp),%eax
 45b:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 45e:	72 c2                	jb     422 <calc+0x16>
            }
        }
    }
    return 0;
 460:	b8 00 00 00 00       	mov    $0x0,%eax
}
 465:	c9                   	leave  
 466:	c3                   	ret    

00000467 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 467:	b8 01 00 00 00       	mov    $0x1,%eax
 46c:	cd 40                	int    $0x40
 46e:	c3                   	ret    

0000046f <exit>:
SYSCALL(exit)
 46f:	b8 02 00 00 00       	mov    $0x2,%eax
 474:	cd 40                	int    $0x40
 476:	c3                   	ret    

00000477 <wait>:
SYSCALL(wait)
 477:	b8 03 00 00 00       	mov    $0x3,%eax
 47c:	cd 40                	int    $0x40
 47e:	c3                   	ret    

0000047f <pipe>:
SYSCALL(pipe)
 47f:	b8 04 00 00 00       	mov    $0x4,%eax
 484:	cd 40                	int    $0x40
 486:	c3                   	ret    

00000487 <read>:
SYSCALL(read)
 487:	b8 05 00 00 00       	mov    $0x5,%eax
 48c:	cd 40                	int    $0x40
 48e:	c3                   	ret    

0000048f <write>:
SYSCALL(write)
 48f:	b8 10 00 00 00       	mov    $0x10,%eax
 494:	cd 40                	int    $0x40
 496:	c3                   	ret    

00000497 <close>:
SYSCALL(close)
 497:	b8 15 00 00 00       	mov    $0x15,%eax
 49c:	cd 40                	int    $0x40
 49e:	c3                   	ret    

0000049f <kill>:
SYSCALL(kill)
 49f:	b8 06 00 00 00       	mov    $0x6,%eax
 4a4:	cd 40                	int    $0x40
 4a6:	c3                   	ret    

000004a7 <exec>:
SYSCALL(exec)
 4a7:	b8 07 00 00 00       	mov    $0x7,%eax
 4ac:	cd 40                	int    $0x40
 4ae:	c3                   	ret    

000004af <open>:
SYSCALL(open)
 4af:	b8 0f 00 00 00       	mov    $0xf,%eax
 4b4:	cd 40                	int    $0x40
 4b6:	c3                   	ret    

000004b7 <mknod>:
SYSCALL(mknod)
 4b7:	b8 11 00 00 00       	mov    $0x11,%eax
 4bc:	cd 40                	int    $0x40
 4be:	c3                   	ret    

000004bf <unlink>:
SYSCALL(unlink)
 4bf:	b8 12 00 00 00       	mov    $0x12,%eax
 4c4:	cd 40                	int    $0x40
 4c6:	c3                   	ret    

000004c7 <fstat>:
SYSCALL(fstat)
 4c7:	b8 08 00 00 00       	mov    $0x8,%eax
 4cc:	cd 40                	int    $0x40
 4ce:	c3                   	ret    

000004cf <link>:
SYSCALL(link)
 4cf:	b8 13 00 00 00       	mov    $0x13,%eax
 4d4:	cd 40                	int    $0x40
 4d6:	c3                   	ret    

000004d7 <mkdir>:
SYSCALL(mkdir)
 4d7:	b8 14 00 00 00       	mov    $0x14,%eax
 4dc:	cd 40                	int    $0x40
 4de:	c3                   	ret    

000004df <chdir>:
SYSCALL(chdir)
 4df:	b8 09 00 00 00       	mov    $0x9,%eax
 4e4:	cd 40                	int    $0x40
 4e6:	c3                   	ret    

000004e7 <dup>:
SYSCALL(dup)
 4e7:	b8 0a 00 00 00       	mov    $0xa,%eax
 4ec:	cd 40                	int    $0x40
 4ee:	c3                   	ret    

000004ef <getpid>:
SYSCALL(getpid)
 4ef:	b8 0b 00 00 00       	mov    $0xb,%eax
 4f4:	cd 40                	int    $0x40
 4f6:	c3                   	ret    

000004f7 <sbrk>:
SYSCALL(sbrk)
 4f7:	b8 0c 00 00 00       	mov    $0xc,%eax
 4fc:	cd 40                	int    $0x40
 4fe:	c3                   	ret    

000004ff <sleep>:
SYSCALL(sleep)
 4ff:	b8 0d 00 00 00       	mov    $0xd,%eax
 504:	cd 40                	int    $0x40
 506:	c3                   	ret    

00000507 <uptime>:
SYSCALL(uptime)
 507:	b8 0e 00 00 00       	mov    $0xe,%eax
 50c:	cd 40                	int    $0x40
 50e:	c3                   	ret    

0000050f <print_proc>:
SYSCALL(print_proc)
 50f:	b8 16 00 00 00       	mov    $0x16,%eax
 514:	cd 40                	int    $0x40
 516:	c3                   	ret    

00000517 <change_queue>:
SYSCALL(change_queue)
 517:	b8 17 00 00 00       	mov    $0x17,%eax
 51c:	cd 40                	int    $0x40
 51e:	c3                   	ret    

0000051f <change_local_bjf>:
SYSCALL(change_local_bjf)
 51f:	b8 18 00 00 00       	mov    $0x18,%eax
 524:	cd 40                	int    $0x40
 526:	c3                   	ret    

00000527 <change_global_bjf>:
SYSCALL(change_global_bjf)
 527:	b8 19 00 00 00       	mov    $0x19,%eax
 52c:	cd 40                	int    $0x40
 52e:	c3                   	ret    

0000052f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 52f:	55                   	push   %ebp
 530:	89 e5                	mov    %esp,%ebp
 532:	83 ec 18             	sub    $0x18,%esp
 535:	8b 45 0c             	mov    0xc(%ebp),%eax
 538:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 53b:	83 ec 04             	sub    $0x4,%esp
 53e:	6a 01                	push   $0x1
 540:	8d 45 f4             	lea    -0xc(%ebp),%eax
 543:	50                   	push   %eax
 544:	ff 75 08             	push   0x8(%ebp)
 547:	e8 43 ff ff ff       	call   48f <write>
 54c:	83 c4 10             	add    $0x10,%esp
}
 54f:	90                   	nop
 550:	c9                   	leave  
 551:	c3                   	ret    

00000552 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 552:	55                   	push   %ebp
 553:	89 e5                	mov    %esp,%ebp
 555:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 558:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 55f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 563:	74 17                	je     57c <printint+0x2a>
 565:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 569:	79 11                	jns    57c <printint+0x2a>
    neg = 1;
 56b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 572:	8b 45 0c             	mov    0xc(%ebp),%eax
 575:	f7 d8                	neg    %eax
 577:	89 45 ec             	mov    %eax,-0x14(%ebp)
 57a:	eb 06                	jmp    582 <printint+0x30>
  } else {
    x = xx;
 57c:	8b 45 0c             	mov    0xc(%ebp),%eax
 57f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 582:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 589:	8b 4d 10             	mov    0x10(%ebp),%ecx
 58c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 58f:	ba 00 00 00 00       	mov    $0x0,%edx
 594:	f7 f1                	div    %ecx
 596:	89 d1                	mov    %edx,%ecx
 598:	8b 45 f4             	mov    -0xc(%ebp),%eax
 59b:	8d 50 01             	lea    0x1(%eax),%edx
 59e:	89 55 f4             	mov    %edx,-0xc(%ebp)
 5a1:	0f b6 91 84 0c 00 00 	movzbl 0xc84(%ecx),%edx
 5a8:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 5ac:	8b 4d 10             	mov    0x10(%ebp),%ecx
 5af:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5b2:	ba 00 00 00 00       	mov    $0x0,%edx
 5b7:	f7 f1                	div    %ecx
 5b9:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5bc:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5c0:	75 c7                	jne    589 <printint+0x37>
  if(neg)
 5c2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5c6:	74 2d                	je     5f5 <printint+0xa3>
    buf[i++] = '-';
 5c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5cb:	8d 50 01             	lea    0x1(%eax),%edx
 5ce:	89 55 f4             	mov    %edx,-0xc(%ebp)
 5d1:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 5d6:	eb 1d                	jmp    5f5 <printint+0xa3>
    putc(fd, buf[i]);
 5d8:	8d 55 dc             	lea    -0x24(%ebp),%edx
 5db:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5de:	01 d0                	add    %edx,%eax
 5e0:	0f b6 00             	movzbl (%eax),%eax
 5e3:	0f be c0             	movsbl %al,%eax
 5e6:	83 ec 08             	sub    $0x8,%esp
 5e9:	50                   	push   %eax
 5ea:	ff 75 08             	push   0x8(%ebp)
 5ed:	e8 3d ff ff ff       	call   52f <putc>
 5f2:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 5f5:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5f9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5fd:	79 d9                	jns    5d8 <printint+0x86>
}
 5ff:	90                   	nop
 600:	90                   	nop
 601:	c9                   	leave  
 602:	c3                   	ret    

00000603 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 603:	55                   	push   %ebp
 604:	89 e5                	mov    %esp,%ebp
 606:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 609:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 610:	8d 45 0c             	lea    0xc(%ebp),%eax
 613:	83 c0 04             	add    $0x4,%eax
 616:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 619:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 620:	e9 59 01 00 00       	jmp    77e <printf+0x17b>
    c = fmt[i] & 0xff;
 625:	8b 55 0c             	mov    0xc(%ebp),%edx
 628:	8b 45 f0             	mov    -0x10(%ebp),%eax
 62b:	01 d0                	add    %edx,%eax
 62d:	0f b6 00             	movzbl (%eax),%eax
 630:	0f be c0             	movsbl %al,%eax
 633:	25 ff 00 00 00       	and    $0xff,%eax
 638:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 63b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 63f:	75 2c                	jne    66d <printf+0x6a>
      if(c == '%'){
 641:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 645:	75 0c                	jne    653 <printf+0x50>
        state = '%';
 647:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 64e:	e9 27 01 00 00       	jmp    77a <printf+0x177>
      } else {
        putc(fd, c);
 653:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 656:	0f be c0             	movsbl %al,%eax
 659:	83 ec 08             	sub    $0x8,%esp
 65c:	50                   	push   %eax
 65d:	ff 75 08             	push   0x8(%ebp)
 660:	e8 ca fe ff ff       	call   52f <putc>
 665:	83 c4 10             	add    $0x10,%esp
 668:	e9 0d 01 00 00       	jmp    77a <printf+0x177>
      }
    } else if(state == '%'){
 66d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 671:	0f 85 03 01 00 00    	jne    77a <printf+0x177>
      if(c == 'd'){
 677:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 67b:	75 1e                	jne    69b <printf+0x98>
        printint(fd, *ap, 10, 1);
 67d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 680:	8b 00                	mov    (%eax),%eax
 682:	6a 01                	push   $0x1
 684:	6a 0a                	push   $0xa
 686:	50                   	push   %eax
 687:	ff 75 08             	push   0x8(%ebp)
 68a:	e8 c3 fe ff ff       	call   552 <printint>
 68f:	83 c4 10             	add    $0x10,%esp
        ap++;
 692:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 696:	e9 d8 00 00 00       	jmp    773 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 69b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 69f:	74 06                	je     6a7 <printf+0xa4>
 6a1:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 6a5:	75 1e                	jne    6c5 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 6a7:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6aa:	8b 00                	mov    (%eax),%eax
 6ac:	6a 00                	push   $0x0
 6ae:	6a 10                	push   $0x10
 6b0:	50                   	push   %eax
 6b1:	ff 75 08             	push   0x8(%ebp)
 6b4:	e8 99 fe ff ff       	call   552 <printint>
 6b9:	83 c4 10             	add    $0x10,%esp
        ap++;
 6bc:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6c0:	e9 ae 00 00 00       	jmp    773 <printf+0x170>
      } else if(c == 's'){
 6c5:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6c9:	75 43                	jne    70e <printf+0x10b>
        s = (char*)*ap;
 6cb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6ce:	8b 00                	mov    (%eax),%eax
 6d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6d3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6d7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6db:	75 25                	jne    702 <printf+0xff>
          s = "(null)";
 6dd:	c7 45 f4 f2 09 00 00 	movl   $0x9f2,-0xc(%ebp)
        while(*s != 0){
 6e4:	eb 1c                	jmp    702 <printf+0xff>
          putc(fd, *s);
 6e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6e9:	0f b6 00             	movzbl (%eax),%eax
 6ec:	0f be c0             	movsbl %al,%eax
 6ef:	83 ec 08             	sub    $0x8,%esp
 6f2:	50                   	push   %eax
 6f3:	ff 75 08             	push   0x8(%ebp)
 6f6:	e8 34 fe ff ff       	call   52f <putc>
 6fb:	83 c4 10             	add    $0x10,%esp
          s++;
 6fe:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 702:	8b 45 f4             	mov    -0xc(%ebp),%eax
 705:	0f b6 00             	movzbl (%eax),%eax
 708:	84 c0                	test   %al,%al
 70a:	75 da                	jne    6e6 <printf+0xe3>
 70c:	eb 65                	jmp    773 <printf+0x170>
        }
      } else if(c == 'c'){
 70e:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 712:	75 1d                	jne    731 <printf+0x12e>
        putc(fd, *ap);
 714:	8b 45 e8             	mov    -0x18(%ebp),%eax
 717:	8b 00                	mov    (%eax),%eax
 719:	0f be c0             	movsbl %al,%eax
 71c:	83 ec 08             	sub    $0x8,%esp
 71f:	50                   	push   %eax
 720:	ff 75 08             	push   0x8(%ebp)
 723:	e8 07 fe ff ff       	call   52f <putc>
 728:	83 c4 10             	add    $0x10,%esp
        ap++;
 72b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 72f:	eb 42                	jmp    773 <printf+0x170>
      } else if(c == '%'){
 731:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 735:	75 17                	jne    74e <printf+0x14b>
        putc(fd, c);
 737:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 73a:	0f be c0             	movsbl %al,%eax
 73d:	83 ec 08             	sub    $0x8,%esp
 740:	50                   	push   %eax
 741:	ff 75 08             	push   0x8(%ebp)
 744:	e8 e6 fd ff ff       	call   52f <putc>
 749:	83 c4 10             	add    $0x10,%esp
 74c:	eb 25                	jmp    773 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 74e:	83 ec 08             	sub    $0x8,%esp
 751:	6a 25                	push   $0x25
 753:	ff 75 08             	push   0x8(%ebp)
 756:	e8 d4 fd ff ff       	call   52f <putc>
 75b:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 75e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 761:	0f be c0             	movsbl %al,%eax
 764:	83 ec 08             	sub    $0x8,%esp
 767:	50                   	push   %eax
 768:	ff 75 08             	push   0x8(%ebp)
 76b:	e8 bf fd ff ff       	call   52f <putc>
 770:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 773:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 77a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 77e:	8b 55 0c             	mov    0xc(%ebp),%edx
 781:	8b 45 f0             	mov    -0x10(%ebp),%eax
 784:	01 d0                	add    %edx,%eax
 786:	0f b6 00             	movzbl (%eax),%eax
 789:	84 c0                	test   %al,%al
 78b:	0f 85 94 fe ff ff    	jne    625 <printf+0x22>
    }
  }
}
 791:	90                   	nop
 792:	90                   	nop
 793:	c9                   	leave  
 794:	c3                   	ret    

00000795 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 795:	55                   	push   %ebp
 796:	89 e5                	mov    %esp,%ebp
 798:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 79b:	8b 45 08             	mov    0x8(%ebp),%eax
 79e:	83 e8 08             	sub    $0x8,%eax
 7a1:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a4:	a1 a8 0e 00 00       	mov    0xea8,%eax
 7a9:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7ac:	eb 24                	jmp    7d2 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b1:	8b 00                	mov    (%eax),%eax
 7b3:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 7b6:	72 12                	jb     7ca <free+0x35>
 7b8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7bb:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7be:	77 24                	ja     7e4 <free+0x4f>
 7c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c3:	8b 00                	mov    (%eax),%eax
 7c5:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 7c8:	72 1a                	jb     7e4 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7cd:	8b 00                	mov    (%eax),%eax
 7cf:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7d5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7d8:	76 d4                	jbe    7ae <free+0x19>
 7da:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7dd:	8b 00                	mov    (%eax),%eax
 7df:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 7e2:	73 ca                	jae    7ae <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7e4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e7:	8b 40 04             	mov    0x4(%eax),%eax
 7ea:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7f1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f4:	01 c2                	add    %eax,%edx
 7f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f9:	8b 00                	mov    (%eax),%eax
 7fb:	39 c2                	cmp    %eax,%edx
 7fd:	75 24                	jne    823 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 7ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
 802:	8b 50 04             	mov    0x4(%eax),%edx
 805:	8b 45 fc             	mov    -0x4(%ebp),%eax
 808:	8b 00                	mov    (%eax),%eax
 80a:	8b 40 04             	mov    0x4(%eax),%eax
 80d:	01 c2                	add    %eax,%edx
 80f:	8b 45 f8             	mov    -0x8(%ebp),%eax
 812:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 815:	8b 45 fc             	mov    -0x4(%ebp),%eax
 818:	8b 00                	mov    (%eax),%eax
 81a:	8b 10                	mov    (%eax),%edx
 81c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 81f:	89 10                	mov    %edx,(%eax)
 821:	eb 0a                	jmp    82d <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 823:	8b 45 fc             	mov    -0x4(%ebp),%eax
 826:	8b 10                	mov    (%eax),%edx
 828:	8b 45 f8             	mov    -0x8(%ebp),%eax
 82b:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 82d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 830:	8b 40 04             	mov    0x4(%eax),%eax
 833:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 83a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 83d:	01 d0                	add    %edx,%eax
 83f:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 842:	75 20                	jne    864 <free+0xcf>
    p->s.size += bp->s.size;
 844:	8b 45 fc             	mov    -0x4(%ebp),%eax
 847:	8b 50 04             	mov    0x4(%eax),%edx
 84a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 84d:	8b 40 04             	mov    0x4(%eax),%eax
 850:	01 c2                	add    %eax,%edx
 852:	8b 45 fc             	mov    -0x4(%ebp),%eax
 855:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 858:	8b 45 f8             	mov    -0x8(%ebp),%eax
 85b:	8b 10                	mov    (%eax),%edx
 85d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 860:	89 10                	mov    %edx,(%eax)
 862:	eb 08                	jmp    86c <free+0xd7>
  } else
    p->s.ptr = bp;
 864:	8b 45 fc             	mov    -0x4(%ebp),%eax
 867:	8b 55 f8             	mov    -0x8(%ebp),%edx
 86a:	89 10                	mov    %edx,(%eax)
  freep = p;
 86c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 86f:	a3 a8 0e 00 00       	mov    %eax,0xea8
}
 874:	90                   	nop
 875:	c9                   	leave  
 876:	c3                   	ret    

00000877 <morecore>:

static Header*
morecore(uint nu)
{
 877:	55                   	push   %ebp
 878:	89 e5                	mov    %esp,%ebp
 87a:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 87d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 884:	77 07                	ja     88d <morecore+0x16>
    nu = 4096;
 886:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 88d:	8b 45 08             	mov    0x8(%ebp),%eax
 890:	c1 e0 03             	shl    $0x3,%eax
 893:	83 ec 0c             	sub    $0xc,%esp
 896:	50                   	push   %eax
 897:	e8 5b fc ff ff       	call   4f7 <sbrk>
 89c:	83 c4 10             	add    $0x10,%esp
 89f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 8a2:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 8a6:	75 07                	jne    8af <morecore+0x38>
    return 0;
 8a8:	b8 00 00 00 00       	mov    $0x0,%eax
 8ad:	eb 26                	jmp    8d5 <morecore+0x5e>
  hp = (Header*)p;
 8af:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 8b5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8b8:	8b 55 08             	mov    0x8(%ebp),%edx
 8bb:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 8be:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8c1:	83 c0 08             	add    $0x8,%eax
 8c4:	83 ec 0c             	sub    $0xc,%esp
 8c7:	50                   	push   %eax
 8c8:	e8 c8 fe ff ff       	call   795 <free>
 8cd:	83 c4 10             	add    $0x10,%esp
  return freep;
 8d0:	a1 a8 0e 00 00       	mov    0xea8,%eax
}
 8d5:	c9                   	leave  
 8d6:	c3                   	ret    

000008d7 <malloc>:

void*
malloc(uint nbytes)
{
 8d7:	55                   	push   %ebp
 8d8:	89 e5                	mov    %esp,%ebp
 8da:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8dd:	8b 45 08             	mov    0x8(%ebp),%eax
 8e0:	83 c0 07             	add    $0x7,%eax
 8e3:	c1 e8 03             	shr    $0x3,%eax
 8e6:	83 c0 01             	add    $0x1,%eax
 8e9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8ec:	a1 a8 0e 00 00       	mov    0xea8,%eax
 8f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8f4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8f8:	75 23                	jne    91d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 8fa:	c7 45 f0 a0 0e 00 00 	movl   $0xea0,-0x10(%ebp)
 901:	8b 45 f0             	mov    -0x10(%ebp),%eax
 904:	a3 a8 0e 00 00       	mov    %eax,0xea8
 909:	a1 a8 0e 00 00       	mov    0xea8,%eax
 90e:	a3 a0 0e 00 00       	mov    %eax,0xea0
    base.s.size = 0;
 913:	c7 05 a4 0e 00 00 00 	movl   $0x0,0xea4
 91a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 91d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 920:	8b 00                	mov    (%eax),%eax
 922:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 925:	8b 45 f4             	mov    -0xc(%ebp),%eax
 928:	8b 40 04             	mov    0x4(%eax),%eax
 92b:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 92e:	77 4d                	ja     97d <malloc+0xa6>
      if(p->s.size == nunits)
 930:	8b 45 f4             	mov    -0xc(%ebp),%eax
 933:	8b 40 04             	mov    0x4(%eax),%eax
 936:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 939:	75 0c                	jne    947 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 93b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 93e:	8b 10                	mov    (%eax),%edx
 940:	8b 45 f0             	mov    -0x10(%ebp),%eax
 943:	89 10                	mov    %edx,(%eax)
 945:	eb 26                	jmp    96d <malloc+0x96>
      else {
        p->s.size -= nunits;
 947:	8b 45 f4             	mov    -0xc(%ebp),%eax
 94a:	8b 40 04             	mov    0x4(%eax),%eax
 94d:	2b 45 ec             	sub    -0x14(%ebp),%eax
 950:	89 c2                	mov    %eax,%edx
 952:	8b 45 f4             	mov    -0xc(%ebp),%eax
 955:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 958:	8b 45 f4             	mov    -0xc(%ebp),%eax
 95b:	8b 40 04             	mov    0x4(%eax),%eax
 95e:	c1 e0 03             	shl    $0x3,%eax
 961:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 964:	8b 45 f4             	mov    -0xc(%ebp),%eax
 967:	8b 55 ec             	mov    -0x14(%ebp),%edx
 96a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 96d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 970:	a3 a8 0e 00 00       	mov    %eax,0xea8
      return (void*)(p + 1);
 975:	8b 45 f4             	mov    -0xc(%ebp),%eax
 978:	83 c0 08             	add    $0x8,%eax
 97b:	eb 3b                	jmp    9b8 <malloc+0xe1>
    }
    if(p == freep)
 97d:	a1 a8 0e 00 00       	mov    0xea8,%eax
 982:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 985:	75 1e                	jne    9a5 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 987:	83 ec 0c             	sub    $0xc,%esp
 98a:	ff 75 ec             	push   -0x14(%ebp)
 98d:	e8 e5 fe ff ff       	call   877 <morecore>
 992:	83 c4 10             	add    $0x10,%esp
 995:	89 45 f4             	mov    %eax,-0xc(%ebp)
 998:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 99c:	75 07                	jne    9a5 <malloc+0xce>
        return 0;
 99e:	b8 00 00 00 00       	mov    $0x0,%eax
 9a3:	eb 13                	jmp    9b8 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 9a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9a8:	89 45 f0             	mov    %eax,-0x10(%ebp)
 9ab:	8b 45 f4             	mov    -0xc(%ebp),%eax
 9ae:	8b 00                	mov    (%eax),%eax
 9b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 9b3:	e9 6d ff ff ff       	jmp    925 <malloc+0x4e>
  }
}
 9b8:	c9                   	leave  
 9b9:	c3                   	ret    
