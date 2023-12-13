
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
  54:	68 aa 09 00 00       	push   $0x9aa
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
  b9:	68 b0 09 00 00       	push   $0x9b0
  be:	6a 01                	push   $0x1
  c0:	e8 2e 05 00 00       	call   5f3 <printf>
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
  dc:	68 c0 09 00 00       	push   $0x9c0
  e1:	6a 01                	push   $0x1
  e3:	e8 0b 05 00 00       	call   5f3 <printf>
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
 10a:	68 cd 09 00 00       	push   $0x9cd
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
 167:	68 ce 09 00 00       	push   $0x9ce
 16c:	6a 01                	push   $0x1
 16e:	e8 80 04 00 00       	call   5f3 <printf>
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
 517:	b8 17 00 00 00       	mov    $0x17,%eax
 51c:	cd 40                	int    $0x40
 51e:	c3                   	ret    

0000051f <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 51f:	55                   	push   %ebp
 520:	89 e5                	mov    %esp,%ebp
 522:	83 ec 18             	sub    $0x18,%esp
 525:	8b 45 0c             	mov    0xc(%ebp),%eax
 528:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 52b:	83 ec 04             	sub    $0x4,%esp
 52e:	6a 01                	push   $0x1
 530:	8d 45 f4             	lea    -0xc(%ebp),%eax
 533:	50                   	push   %eax
 534:	ff 75 08             	push   0x8(%ebp)
 537:	e8 53 ff ff ff       	call   48f <write>
 53c:	83 c4 10             	add    $0x10,%esp
}
 53f:	90                   	nop
 540:	c9                   	leave  
 541:	c3                   	ret    

00000542 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 542:	55                   	push   %ebp
 543:	89 e5                	mov    %esp,%ebp
 545:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 548:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 54f:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 553:	74 17                	je     56c <printint+0x2a>
 555:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 559:	79 11                	jns    56c <printint+0x2a>
    neg = 1;
 55b:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 562:	8b 45 0c             	mov    0xc(%ebp),%eax
 565:	f7 d8                	neg    %eax
 567:	89 45 ec             	mov    %eax,-0x14(%ebp)
 56a:	eb 06                	jmp    572 <printint+0x30>
  } else {
    x = xx;
 56c:	8b 45 0c             	mov    0xc(%ebp),%eax
 56f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 572:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 579:	8b 4d 10             	mov    0x10(%ebp),%ecx
 57c:	8b 45 ec             	mov    -0x14(%ebp),%eax
 57f:	ba 00 00 00 00       	mov    $0x0,%edx
 584:	f7 f1                	div    %ecx
 586:	89 d1                	mov    %edx,%ecx
 588:	8b 45 f4             	mov    -0xc(%ebp),%eax
 58b:	8d 50 01             	lea    0x1(%eax),%edx
 58e:	89 55 f4             	mov    %edx,-0xc(%ebp)
 591:	0f b6 91 74 0c 00 00 	movzbl 0xc74(%ecx),%edx
 598:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 59c:	8b 4d 10             	mov    0x10(%ebp),%ecx
 59f:	8b 45 ec             	mov    -0x14(%ebp),%eax
 5a2:	ba 00 00 00 00       	mov    $0x0,%edx
 5a7:	f7 f1                	div    %ecx
 5a9:	89 45 ec             	mov    %eax,-0x14(%ebp)
 5ac:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5b0:	75 c7                	jne    579 <printint+0x37>
  if(neg)
 5b2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 5b6:	74 2d                	je     5e5 <printint+0xa3>
    buf[i++] = '-';
 5b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5bb:	8d 50 01             	lea    0x1(%eax),%edx
 5be:	89 55 f4             	mov    %edx,-0xc(%ebp)
 5c1:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 5c6:	eb 1d                	jmp    5e5 <printint+0xa3>
    putc(fd, buf[i]);
 5c8:	8d 55 dc             	lea    -0x24(%ebp),%edx
 5cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
 5ce:	01 d0                	add    %edx,%eax
 5d0:	0f b6 00             	movzbl (%eax),%eax
 5d3:	0f be c0             	movsbl %al,%eax
 5d6:	83 ec 08             	sub    $0x8,%esp
 5d9:	50                   	push   %eax
 5da:	ff 75 08             	push   0x8(%ebp)
 5dd:	e8 3d ff ff ff       	call   51f <putc>
 5e2:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 5e5:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 5e9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 5ed:	79 d9                	jns    5c8 <printint+0x86>
}
 5ef:	90                   	nop
 5f0:	90                   	nop
 5f1:	c9                   	leave  
 5f2:	c3                   	ret    

000005f3 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 5f3:	55                   	push   %ebp
 5f4:	89 e5                	mov    %esp,%ebp
 5f6:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 5f9:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 600:	8d 45 0c             	lea    0xc(%ebp),%eax
 603:	83 c0 04             	add    $0x4,%eax
 606:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 609:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 610:	e9 59 01 00 00       	jmp    76e <printf+0x17b>
    c = fmt[i] & 0xff;
 615:	8b 55 0c             	mov    0xc(%ebp),%edx
 618:	8b 45 f0             	mov    -0x10(%ebp),%eax
 61b:	01 d0                	add    %edx,%eax
 61d:	0f b6 00             	movzbl (%eax),%eax
 620:	0f be c0             	movsbl %al,%eax
 623:	25 ff 00 00 00       	and    $0xff,%eax
 628:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 62b:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 62f:	75 2c                	jne    65d <printf+0x6a>
      if(c == '%'){
 631:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 635:	75 0c                	jne    643 <printf+0x50>
        state = '%';
 637:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 63e:	e9 27 01 00 00       	jmp    76a <printf+0x177>
      } else {
        putc(fd, c);
 643:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 646:	0f be c0             	movsbl %al,%eax
 649:	83 ec 08             	sub    $0x8,%esp
 64c:	50                   	push   %eax
 64d:	ff 75 08             	push   0x8(%ebp)
 650:	e8 ca fe ff ff       	call   51f <putc>
 655:	83 c4 10             	add    $0x10,%esp
 658:	e9 0d 01 00 00       	jmp    76a <printf+0x177>
      }
    } else if(state == '%'){
 65d:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 661:	0f 85 03 01 00 00    	jne    76a <printf+0x177>
      if(c == 'd'){
 667:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 66b:	75 1e                	jne    68b <printf+0x98>
        printint(fd, *ap, 10, 1);
 66d:	8b 45 e8             	mov    -0x18(%ebp),%eax
 670:	8b 00                	mov    (%eax),%eax
 672:	6a 01                	push   $0x1
 674:	6a 0a                	push   $0xa
 676:	50                   	push   %eax
 677:	ff 75 08             	push   0x8(%ebp)
 67a:	e8 c3 fe ff ff       	call   542 <printint>
 67f:	83 c4 10             	add    $0x10,%esp
        ap++;
 682:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 686:	e9 d8 00 00 00       	jmp    763 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 68b:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 68f:	74 06                	je     697 <printf+0xa4>
 691:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 695:	75 1e                	jne    6b5 <printf+0xc2>
        printint(fd, *ap, 16, 0);
 697:	8b 45 e8             	mov    -0x18(%ebp),%eax
 69a:	8b 00                	mov    (%eax),%eax
 69c:	6a 00                	push   $0x0
 69e:	6a 10                	push   $0x10
 6a0:	50                   	push   %eax
 6a1:	ff 75 08             	push   0x8(%ebp)
 6a4:	e8 99 fe ff ff       	call   542 <printint>
 6a9:	83 c4 10             	add    $0x10,%esp
        ap++;
 6ac:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6b0:	e9 ae 00 00 00       	jmp    763 <printf+0x170>
      } else if(c == 's'){
 6b5:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 6b9:	75 43                	jne    6fe <printf+0x10b>
        s = (char*)*ap;
 6bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
 6be:	8b 00                	mov    (%eax),%eax
 6c0:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 6c3:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 6c7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 6cb:	75 25                	jne    6f2 <printf+0xff>
          s = "(null)";
 6cd:	c7 45 f4 e2 09 00 00 	movl   $0x9e2,-0xc(%ebp)
        while(*s != 0){
 6d4:	eb 1c                	jmp    6f2 <printf+0xff>
          putc(fd, *s);
 6d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6d9:	0f b6 00             	movzbl (%eax),%eax
 6dc:	0f be c0             	movsbl %al,%eax
 6df:	83 ec 08             	sub    $0x8,%esp
 6e2:	50                   	push   %eax
 6e3:	ff 75 08             	push   0x8(%ebp)
 6e6:	e8 34 fe ff ff       	call   51f <putc>
 6eb:	83 c4 10             	add    $0x10,%esp
          s++;
 6ee:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 6f2:	8b 45 f4             	mov    -0xc(%ebp),%eax
 6f5:	0f b6 00             	movzbl (%eax),%eax
 6f8:	84 c0                	test   %al,%al
 6fa:	75 da                	jne    6d6 <printf+0xe3>
 6fc:	eb 65                	jmp    763 <printf+0x170>
        }
      } else if(c == 'c'){
 6fe:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 702:	75 1d                	jne    721 <printf+0x12e>
        putc(fd, *ap);
 704:	8b 45 e8             	mov    -0x18(%ebp),%eax
 707:	8b 00                	mov    (%eax),%eax
 709:	0f be c0             	movsbl %al,%eax
 70c:	83 ec 08             	sub    $0x8,%esp
 70f:	50                   	push   %eax
 710:	ff 75 08             	push   0x8(%ebp)
 713:	e8 07 fe ff ff       	call   51f <putc>
 718:	83 c4 10             	add    $0x10,%esp
        ap++;
 71b:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 71f:	eb 42                	jmp    763 <printf+0x170>
      } else if(c == '%'){
 721:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 725:	75 17                	jne    73e <printf+0x14b>
        putc(fd, c);
 727:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 72a:	0f be c0             	movsbl %al,%eax
 72d:	83 ec 08             	sub    $0x8,%esp
 730:	50                   	push   %eax
 731:	ff 75 08             	push   0x8(%ebp)
 734:	e8 e6 fd ff ff       	call   51f <putc>
 739:	83 c4 10             	add    $0x10,%esp
 73c:	eb 25                	jmp    763 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 73e:	83 ec 08             	sub    $0x8,%esp
 741:	6a 25                	push   $0x25
 743:	ff 75 08             	push   0x8(%ebp)
 746:	e8 d4 fd ff ff       	call   51f <putc>
 74b:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 74e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 751:	0f be c0             	movsbl %al,%eax
 754:	83 ec 08             	sub    $0x8,%esp
 757:	50                   	push   %eax
 758:	ff 75 08             	push   0x8(%ebp)
 75b:	e8 bf fd ff ff       	call   51f <putc>
 760:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 763:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 76a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 76e:	8b 55 0c             	mov    0xc(%ebp),%edx
 771:	8b 45 f0             	mov    -0x10(%ebp),%eax
 774:	01 d0                	add    %edx,%eax
 776:	0f b6 00             	movzbl (%eax),%eax
 779:	84 c0                	test   %al,%al
 77b:	0f 85 94 fe ff ff    	jne    615 <printf+0x22>
    }
  }
}
 781:	90                   	nop
 782:	90                   	nop
 783:	c9                   	leave  
 784:	c3                   	ret    

00000785 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 785:	55                   	push   %ebp
 786:	89 e5                	mov    %esp,%ebp
 788:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 78b:	8b 45 08             	mov    0x8(%ebp),%eax
 78e:	83 e8 08             	sub    $0x8,%eax
 791:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 794:	a1 a8 0e 00 00       	mov    0xea8,%eax
 799:	89 45 fc             	mov    %eax,-0x4(%ebp)
 79c:	eb 24                	jmp    7c2 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 79e:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7a1:	8b 00                	mov    (%eax),%eax
 7a3:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 7a6:	72 12                	jb     7ba <free+0x35>
 7a8:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7ab:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7ae:	77 24                	ja     7d4 <free+0x4f>
 7b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b3:	8b 00                	mov    (%eax),%eax
 7b5:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 7b8:	72 1a                	jb     7d4 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7ba:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7bd:	8b 00                	mov    (%eax),%eax
 7bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
 7c2:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7c5:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 7c8:	76 d4                	jbe    79e <free+0x19>
 7ca:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7cd:	8b 00                	mov    (%eax),%eax
 7cf:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 7d2:	73 ca                	jae    79e <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7d4:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7d7:	8b 40 04             	mov    0x4(%eax),%eax
 7da:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7e1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e4:	01 c2                	add    %eax,%edx
 7e6:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7e9:	8b 00                	mov    (%eax),%eax
 7eb:	39 c2                	cmp    %eax,%edx
 7ed:	75 24                	jne    813 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 7ef:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7f2:	8b 50 04             	mov    0x4(%eax),%edx
 7f5:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f8:	8b 00                	mov    (%eax),%eax
 7fa:	8b 40 04             	mov    0x4(%eax),%eax
 7fd:	01 c2                	add    %eax,%edx
 7ff:	8b 45 f8             	mov    -0x8(%ebp),%eax
 802:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 805:	8b 45 fc             	mov    -0x4(%ebp),%eax
 808:	8b 00                	mov    (%eax),%eax
 80a:	8b 10                	mov    (%eax),%edx
 80c:	8b 45 f8             	mov    -0x8(%ebp),%eax
 80f:	89 10                	mov    %edx,(%eax)
 811:	eb 0a                	jmp    81d <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 813:	8b 45 fc             	mov    -0x4(%ebp),%eax
 816:	8b 10                	mov    (%eax),%edx
 818:	8b 45 f8             	mov    -0x8(%ebp),%eax
 81b:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 81d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 820:	8b 40 04             	mov    0x4(%eax),%eax
 823:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 82a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 82d:	01 d0                	add    %edx,%eax
 82f:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 832:	75 20                	jne    854 <free+0xcf>
    p->s.size += bp->s.size;
 834:	8b 45 fc             	mov    -0x4(%ebp),%eax
 837:	8b 50 04             	mov    0x4(%eax),%edx
 83a:	8b 45 f8             	mov    -0x8(%ebp),%eax
 83d:	8b 40 04             	mov    0x4(%eax),%eax
 840:	01 c2                	add    %eax,%edx
 842:	8b 45 fc             	mov    -0x4(%ebp),%eax
 845:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 848:	8b 45 f8             	mov    -0x8(%ebp),%eax
 84b:	8b 10                	mov    (%eax),%edx
 84d:	8b 45 fc             	mov    -0x4(%ebp),%eax
 850:	89 10                	mov    %edx,(%eax)
 852:	eb 08                	jmp    85c <free+0xd7>
  } else
    p->s.ptr = bp;
 854:	8b 45 fc             	mov    -0x4(%ebp),%eax
 857:	8b 55 f8             	mov    -0x8(%ebp),%edx
 85a:	89 10                	mov    %edx,(%eax)
  freep = p;
 85c:	8b 45 fc             	mov    -0x4(%ebp),%eax
 85f:	a3 a8 0e 00 00       	mov    %eax,0xea8
}
 864:	90                   	nop
 865:	c9                   	leave  
 866:	c3                   	ret    

00000867 <morecore>:

static Header*
morecore(uint nu)
{
 867:	55                   	push   %ebp
 868:	89 e5                	mov    %esp,%ebp
 86a:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 86d:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 874:	77 07                	ja     87d <morecore+0x16>
    nu = 4096;
 876:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 87d:	8b 45 08             	mov    0x8(%ebp),%eax
 880:	c1 e0 03             	shl    $0x3,%eax
 883:	83 ec 0c             	sub    $0xc,%esp
 886:	50                   	push   %eax
 887:	e8 6b fc ff ff       	call   4f7 <sbrk>
 88c:	83 c4 10             	add    $0x10,%esp
 88f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 892:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 896:	75 07                	jne    89f <morecore+0x38>
    return 0;
 898:	b8 00 00 00 00       	mov    $0x0,%eax
 89d:	eb 26                	jmp    8c5 <morecore+0x5e>
  hp = (Header*)p;
 89f:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8a2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 8a5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8a8:	8b 55 08             	mov    0x8(%ebp),%edx
 8ab:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 8ae:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8b1:	83 c0 08             	add    $0x8,%eax
 8b4:	83 ec 0c             	sub    $0xc,%esp
 8b7:	50                   	push   %eax
 8b8:	e8 c8 fe ff ff       	call   785 <free>
 8bd:	83 c4 10             	add    $0x10,%esp
  return freep;
 8c0:	a1 a8 0e 00 00       	mov    0xea8,%eax
}
 8c5:	c9                   	leave  
 8c6:	c3                   	ret    

000008c7 <malloc>:

void*
malloc(uint nbytes)
{
 8c7:	55                   	push   %ebp
 8c8:	89 e5                	mov    %esp,%ebp
 8ca:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 8cd:	8b 45 08             	mov    0x8(%ebp),%eax
 8d0:	83 c0 07             	add    $0x7,%eax
 8d3:	c1 e8 03             	shr    $0x3,%eax
 8d6:	83 c0 01             	add    $0x1,%eax
 8d9:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 8dc:	a1 a8 0e 00 00       	mov    0xea8,%eax
 8e1:	89 45 f0             	mov    %eax,-0x10(%ebp)
 8e4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 8e8:	75 23                	jne    90d <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 8ea:	c7 45 f0 a0 0e 00 00 	movl   $0xea0,-0x10(%ebp)
 8f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8f4:	a3 a8 0e 00 00       	mov    %eax,0xea8
 8f9:	a1 a8 0e 00 00       	mov    0xea8,%eax
 8fe:	a3 a0 0e 00 00       	mov    %eax,0xea0
    base.s.size = 0;
 903:	c7 05 a4 0e 00 00 00 	movl   $0x0,0xea4
 90a:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 90d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 910:	8b 00                	mov    (%eax),%eax
 912:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 915:	8b 45 f4             	mov    -0xc(%ebp),%eax
 918:	8b 40 04             	mov    0x4(%eax),%eax
 91b:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 91e:	77 4d                	ja     96d <malloc+0xa6>
      if(p->s.size == nunits)
 920:	8b 45 f4             	mov    -0xc(%ebp),%eax
 923:	8b 40 04             	mov    0x4(%eax),%eax
 926:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 929:	75 0c                	jne    937 <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 92b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 92e:	8b 10                	mov    (%eax),%edx
 930:	8b 45 f0             	mov    -0x10(%ebp),%eax
 933:	89 10                	mov    %edx,(%eax)
 935:	eb 26                	jmp    95d <malloc+0x96>
      else {
        p->s.size -= nunits;
 937:	8b 45 f4             	mov    -0xc(%ebp),%eax
 93a:	8b 40 04             	mov    0x4(%eax),%eax
 93d:	2b 45 ec             	sub    -0x14(%ebp),%eax
 940:	89 c2                	mov    %eax,%edx
 942:	8b 45 f4             	mov    -0xc(%ebp),%eax
 945:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 948:	8b 45 f4             	mov    -0xc(%ebp),%eax
 94b:	8b 40 04             	mov    0x4(%eax),%eax
 94e:	c1 e0 03             	shl    $0x3,%eax
 951:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 954:	8b 45 f4             	mov    -0xc(%ebp),%eax
 957:	8b 55 ec             	mov    -0x14(%ebp),%edx
 95a:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 95d:	8b 45 f0             	mov    -0x10(%ebp),%eax
 960:	a3 a8 0e 00 00       	mov    %eax,0xea8
      return (void*)(p + 1);
 965:	8b 45 f4             	mov    -0xc(%ebp),%eax
 968:	83 c0 08             	add    $0x8,%eax
 96b:	eb 3b                	jmp    9a8 <malloc+0xe1>
    }
    if(p == freep)
 96d:	a1 a8 0e 00 00       	mov    0xea8,%eax
 972:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 975:	75 1e                	jne    995 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 977:	83 ec 0c             	sub    $0xc,%esp
 97a:	ff 75 ec             	push   -0x14(%ebp)
 97d:	e8 e5 fe ff ff       	call   867 <morecore>
 982:	83 c4 10             	add    $0x10,%esp
 985:	89 45 f4             	mov    %eax,-0xc(%ebp)
 988:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 98c:	75 07                	jne    995 <malloc+0xce>
        return 0;
 98e:	b8 00 00 00 00       	mov    $0x0,%eax
 993:	eb 13                	jmp    9a8 <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 995:	8b 45 f4             	mov    -0xc(%ebp),%eax
 998:	89 45 f0             	mov    %eax,-0x10(%ebp)
 99b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 99e:	8b 00                	mov    (%eax),%eax
 9a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 9a3:	e9 6d ff ff ff       	jmp    915 <malloc+0x4e>
  }
}
 9a8:	c9                   	leave  
 9a9:	c3                   	ret    
