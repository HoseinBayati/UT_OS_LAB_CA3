
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	push   -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	81 ec 24 02 00 00    	sub    $0x224,%esp
  int fd, i;
  char path[] = "stressfs0";
  14:	c7 45 e6 73 74 72 65 	movl   $0x65727473,-0x1a(%ebp)
  1b:	c7 45 ea 73 73 66 73 	movl   $0x73667373,-0x16(%ebp)
  22:	66 c7 45 ee 30 00    	movw   $0x30,-0x12(%ebp)
  char data[512];

  printf(1, "stressfs starting\n");
  28:	83 ec 08             	sub    $0x8,%esp
  2b:	68 3f 09 00 00       	push   $0x93f
  30:	6a 01                	push   $0x1
  32:	e8 51 05 00 00       	call   588 <printf>
  37:	83 c4 10             	add    $0x10,%esp
  memset(data, 'a', sizeof(data));
  3a:	83 ec 04             	sub    $0x4,%esp
  3d:	68 00 02 00 00       	push   $0x200
  42:	6a 61                	push   $0x61
  44:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
  4a:	50                   	push   %eax
  4b:	e8 be 01 00 00       	call   20e <memset>
  50:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 4; i++)
  53:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  5a:	eb 0d                	jmp    69 <main+0x69>
    if(fork() > 0)
  5c:	e8 9b 03 00 00       	call   3fc <fork>
  61:	85 c0                	test   %eax,%eax
  63:	7f 0c                	jg     71 <main+0x71>
  for(i = 0; i < 4; i++)
  65:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  69:	83 7d f4 03          	cmpl   $0x3,-0xc(%ebp)
  6d:	7e ed                	jle    5c <main+0x5c>
  6f:	eb 01                	jmp    72 <main+0x72>
      break;
  71:	90                   	nop

  printf(1, "write %d\n", i);
  72:	83 ec 04             	sub    $0x4,%esp
  75:	ff 75 f4             	push   -0xc(%ebp)
  78:	68 52 09 00 00       	push   $0x952
  7d:	6a 01                	push   $0x1
  7f:	e8 04 05 00 00       	call   588 <printf>
  84:	83 c4 10             	add    $0x10,%esp

  path[8] += i;
  87:	0f b6 45 ee          	movzbl -0x12(%ebp),%eax
  8b:	89 c2                	mov    %eax,%edx
  8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
  90:	01 d0                	add    %edx,%eax
  92:	88 45 ee             	mov    %al,-0x12(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
  95:	83 ec 08             	sub    $0x8,%esp
  98:	68 02 02 00 00       	push   $0x202
  9d:	8d 45 e6             	lea    -0x1a(%ebp),%eax
  a0:	50                   	push   %eax
  a1:	e8 9e 03 00 00       	call   444 <open>
  a6:	83 c4 10             	add    $0x10,%esp
  a9:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; i < 20; i++)
  ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  b3:	eb 1e                	jmp    d3 <main+0xd3>
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  b5:	83 ec 04             	sub    $0x4,%esp
  b8:	68 00 02 00 00       	push   $0x200
  bd:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
  c3:	50                   	push   %eax
  c4:	ff 75 f0             	push   -0x10(%ebp)
  c7:	e8 58 03 00 00       	call   424 <write>
  cc:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 20; i++)
  cf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  d3:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
  d7:	7e dc                	jle    b5 <main+0xb5>
  close(fd);
  d9:	83 ec 0c             	sub    $0xc,%esp
  dc:	ff 75 f0             	push   -0x10(%ebp)
  df:	e8 48 03 00 00       	call   42c <close>
  e4:	83 c4 10             	add    $0x10,%esp

  printf(1, "read\n");
  e7:	83 ec 08             	sub    $0x8,%esp
  ea:	68 5c 09 00 00       	push   $0x95c
  ef:	6a 01                	push   $0x1
  f1:	e8 92 04 00 00       	call   588 <printf>
  f6:	83 c4 10             	add    $0x10,%esp

  fd = open(path, O_RDONLY);
  f9:	83 ec 08             	sub    $0x8,%esp
  fc:	6a 00                	push   $0x0
  fe:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 101:	50                   	push   %eax
 102:	e8 3d 03 00 00       	call   444 <open>
 107:	83 c4 10             	add    $0x10,%esp
 10a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for (i = 0; i < 20; i++)
 10d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 114:	eb 1e                	jmp    134 <main+0x134>
    read(fd, data, sizeof(data));
 116:	83 ec 04             	sub    $0x4,%esp
 119:	68 00 02 00 00       	push   $0x200
 11e:	8d 85 e6 fd ff ff    	lea    -0x21a(%ebp),%eax
 124:	50                   	push   %eax
 125:	ff 75 f0             	push   -0x10(%ebp)
 128:	e8 ef 02 00 00       	call   41c <read>
 12d:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < 20; i++)
 130:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 134:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
 138:	7e dc                	jle    116 <main+0x116>
  close(fd);
 13a:	83 ec 0c             	sub    $0xc,%esp
 13d:	ff 75 f0             	push   -0x10(%ebp)
 140:	e8 e7 02 00 00       	call   42c <close>
 145:	83 c4 10             	add    $0x10,%esp

  wait();
 148:	e8 bf 02 00 00       	call   40c <wait>

  exit();
 14d:	e8 b2 02 00 00       	call   404 <exit>

00000152 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 152:	55                   	push   %ebp
 153:	89 e5                	mov    %esp,%ebp
 155:	57                   	push   %edi
 156:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 157:	8b 4d 08             	mov    0x8(%ebp),%ecx
 15a:	8b 55 10             	mov    0x10(%ebp),%edx
 15d:	8b 45 0c             	mov    0xc(%ebp),%eax
 160:	89 cb                	mov    %ecx,%ebx
 162:	89 df                	mov    %ebx,%edi
 164:	89 d1                	mov    %edx,%ecx
 166:	fc                   	cld    
 167:	f3 aa                	rep stos %al,%es:(%edi)
 169:	89 ca                	mov    %ecx,%edx
 16b:	89 fb                	mov    %edi,%ebx
 16d:	89 5d 08             	mov    %ebx,0x8(%ebp)
 170:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 173:	90                   	nop
 174:	5b                   	pop    %ebx
 175:	5f                   	pop    %edi
 176:	5d                   	pop    %ebp
 177:	c3                   	ret    

00000178 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 178:	55                   	push   %ebp
 179:	89 e5                	mov    %esp,%ebp
 17b:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 17e:	8b 45 08             	mov    0x8(%ebp),%eax
 181:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 184:	90                   	nop
 185:	8b 55 0c             	mov    0xc(%ebp),%edx
 188:	8d 42 01             	lea    0x1(%edx),%eax
 18b:	89 45 0c             	mov    %eax,0xc(%ebp)
 18e:	8b 45 08             	mov    0x8(%ebp),%eax
 191:	8d 48 01             	lea    0x1(%eax),%ecx
 194:	89 4d 08             	mov    %ecx,0x8(%ebp)
 197:	0f b6 12             	movzbl (%edx),%edx
 19a:	88 10                	mov    %dl,(%eax)
 19c:	0f b6 00             	movzbl (%eax),%eax
 19f:	84 c0                	test   %al,%al
 1a1:	75 e2                	jne    185 <strcpy+0xd>
    ;
  return os;
 1a3:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 1a6:	c9                   	leave  
 1a7:	c3                   	ret    

000001a8 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1a8:	55                   	push   %ebp
 1a9:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 1ab:	eb 08                	jmp    1b5 <strcmp+0xd>
    p++, q++;
 1ad:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 1b1:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 1b5:	8b 45 08             	mov    0x8(%ebp),%eax
 1b8:	0f b6 00             	movzbl (%eax),%eax
 1bb:	84 c0                	test   %al,%al
 1bd:	74 10                	je     1cf <strcmp+0x27>
 1bf:	8b 45 08             	mov    0x8(%ebp),%eax
 1c2:	0f b6 10             	movzbl (%eax),%edx
 1c5:	8b 45 0c             	mov    0xc(%ebp),%eax
 1c8:	0f b6 00             	movzbl (%eax),%eax
 1cb:	38 c2                	cmp    %al,%dl
 1cd:	74 de                	je     1ad <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 1cf:	8b 45 08             	mov    0x8(%ebp),%eax
 1d2:	0f b6 00             	movzbl (%eax),%eax
 1d5:	0f b6 d0             	movzbl %al,%edx
 1d8:	8b 45 0c             	mov    0xc(%ebp),%eax
 1db:	0f b6 00             	movzbl (%eax),%eax
 1de:	0f b6 c8             	movzbl %al,%ecx
 1e1:	89 d0                	mov    %edx,%eax
 1e3:	29 c8                	sub    %ecx,%eax
}
 1e5:	5d                   	pop    %ebp
 1e6:	c3                   	ret    

000001e7 <strlen>:

uint
strlen(const char *s)
{
 1e7:	55                   	push   %ebp
 1e8:	89 e5                	mov    %esp,%ebp
 1ea:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 1ed:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 1f4:	eb 04                	jmp    1fa <strlen+0x13>
 1f6:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 1fa:	8b 55 fc             	mov    -0x4(%ebp),%edx
 1fd:	8b 45 08             	mov    0x8(%ebp),%eax
 200:	01 d0                	add    %edx,%eax
 202:	0f b6 00             	movzbl (%eax),%eax
 205:	84 c0                	test   %al,%al
 207:	75 ed                	jne    1f6 <strlen+0xf>
    ;
  return n;
 209:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 20c:	c9                   	leave  
 20d:	c3                   	ret    

0000020e <memset>:

void*
memset(void *dst, int c, uint n)
{
 20e:	55                   	push   %ebp
 20f:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 211:	8b 45 10             	mov    0x10(%ebp),%eax
 214:	50                   	push   %eax
 215:	ff 75 0c             	push   0xc(%ebp)
 218:	ff 75 08             	push   0x8(%ebp)
 21b:	e8 32 ff ff ff       	call   152 <stosb>
 220:	83 c4 0c             	add    $0xc,%esp
  return dst;
 223:	8b 45 08             	mov    0x8(%ebp),%eax
}
 226:	c9                   	leave  
 227:	c3                   	ret    

00000228 <strchr>:

char*
strchr(const char *s, char c)
{
 228:	55                   	push   %ebp
 229:	89 e5                	mov    %esp,%ebp
 22b:	83 ec 04             	sub    $0x4,%esp
 22e:	8b 45 0c             	mov    0xc(%ebp),%eax
 231:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 234:	eb 14                	jmp    24a <strchr+0x22>
    if(*s == c)
 236:	8b 45 08             	mov    0x8(%ebp),%eax
 239:	0f b6 00             	movzbl (%eax),%eax
 23c:	38 45 fc             	cmp    %al,-0x4(%ebp)
 23f:	75 05                	jne    246 <strchr+0x1e>
      return (char*)s;
 241:	8b 45 08             	mov    0x8(%ebp),%eax
 244:	eb 13                	jmp    259 <strchr+0x31>
  for(; *s; s++)
 246:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 24a:	8b 45 08             	mov    0x8(%ebp),%eax
 24d:	0f b6 00             	movzbl (%eax),%eax
 250:	84 c0                	test   %al,%al
 252:	75 e2                	jne    236 <strchr+0xe>
  return 0;
 254:	b8 00 00 00 00       	mov    $0x0,%eax
}
 259:	c9                   	leave  
 25a:	c3                   	ret    

0000025b <gets>:

char*
gets(char *buf, int max)
{
 25b:	55                   	push   %ebp
 25c:	89 e5                	mov    %esp,%ebp
 25e:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 261:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 268:	eb 42                	jmp    2ac <gets+0x51>
    cc = read(0, &c, 1);
 26a:	83 ec 04             	sub    $0x4,%esp
 26d:	6a 01                	push   $0x1
 26f:	8d 45 ef             	lea    -0x11(%ebp),%eax
 272:	50                   	push   %eax
 273:	6a 00                	push   $0x0
 275:	e8 a2 01 00 00       	call   41c <read>
 27a:	83 c4 10             	add    $0x10,%esp
 27d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 280:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 284:	7e 33                	jle    2b9 <gets+0x5e>
      break;
    buf[i++] = c;
 286:	8b 45 f4             	mov    -0xc(%ebp),%eax
 289:	8d 50 01             	lea    0x1(%eax),%edx
 28c:	89 55 f4             	mov    %edx,-0xc(%ebp)
 28f:	89 c2                	mov    %eax,%edx
 291:	8b 45 08             	mov    0x8(%ebp),%eax
 294:	01 c2                	add    %eax,%edx
 296:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 29a:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 29c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2a0:	3c 0a                	cmp    $0xa,%al
 2a2:	74 16                	je     2ba <gets+0x5f>
 2a4:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 2a8:	3c 0d                	cmp    $0xd,%al
 2aa:	74 0e                	je     2ba <gets+0x5f>
  for(i=0; i+1 < max; ){
 2ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
 2af:	83 c0 01             	add    $0x1,%eax
 2b2:	39 45 0c             	cmp    %eax,0xc(%ebp)
 2b5:	7f b3                	jg     26a <gets+0xf>
 2b7:	eb 01                	jmp    2ba <gets+0x5f>
      break;
 2b9:	90                   	nop
      break;
  }
  buf[i] = '\0';
 2ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
 2bd:	8b 45 08             	mov    0x8(%ebp),%eax
 2c0:	01 d0                	add    %edx,%eax
 2c2:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 2c5:	8b 45 08             	mov    0x8(%ebp),%eax
}
 2c8:	c9                   	leave  
 2c9:	c3                   	ret    

000002ca <stat>:

int
stat(const char *n, struct stat *st)
{
 2ca:	55                   	push   %ebp
 2cb:	89 e5                	mov    %esp,%ebp
 2cd:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d0:	83 ec 08             	sub    $0x8,%esp
 2d3:	6a 00                	push   $0x0
 2d5:	ff 75 08             	push   0x8(%ebp)
 2d8:	e8 67 01 00 00       	call   444 <open>
 2dd:	83 c4 10             	add    $0x10,%esp
 2e0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 2e3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 2e7:	79 07                	jns    2f0 <stat+0x26>
    return -1;
 2e9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 2ee:	eb 25                	jmp    315 <stat+0x4b>
  r = fstat(fd, st);
 2f0:	83 ec 08             	sub    $0x8,%esp
 2f3:	ff 75 0c             	push   0xc(%ebp)
 2f6:	ff 75 f4             	push   -0xc(%ebp)
 2f9:	e8 5e 01 00 00       	call   45c <fstat>
 2fe:	83 c4 10             	add    $0x10,%esp
 301:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 304:	83 ec 0c             	sub    $0xc,%esp
 307:	ff 75 f4             	push   -0xc(%ebp)
 30a:	e8 1d 01 00 00       	call   42c <close>
 30f:	83 c4 10             	add    $0x10,%esp
  return r;
 312:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 315:	c9                   	leave  
 316:	c3                   	ret    

00000317 <atoi>:

int
atoi(const char *s)
{
 317:	55                   	push   %ebp
 318:	89 e5                	mov    %esp,%ebp
 31a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 31d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 324:	eb 25                	jmp    34b <atoi+0x34>
    n = n*10 + *s++ - '0';
 326:	8b 55 fc             	mov    -0x4(%ebp),%edx
 329:	89 d0                	mov    %edx,%eax
 32b:	c1 e0 02             	shl    $0x2,%eax
 32e:	01 d0                	add    %edx,%eax
 330:	01 c0                	add    %eax,%eax
 332:	89 c1                	mov    %eax,%ecx
 334:	8b 45 08             	mov    0x8(%ebp),%eax
 337:	8d 50 01             	lea    0x1(%eax),%edx
 33a:	89 55 08             	mov    %edx,0x8(%ebp)
 33d:	0f b6 00             	movzbl (%eax),%eax
 340:	0f be c0             	movsbl %al,%eax
 343:	01 c8                	add    %ecx,%eax
 345:	83 e8 30             	sub    $0x30,%eax
 348:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 34b:	8b 45 08             	mov    0x8(%ebp),%eax
 34e:	0f b6 00             	movzbl (%eax),%eax
 351:	3c 2f                	cmp    $0x2f,%al
 353:	7e 0a                	jle    35f <atoi+0x48>
 355:	8b 45 08             	mov    0x8(%ebp),%eax
 358:	0f b6 00             	movzbl (%eax),%eax
 35b:	3c 39                	cmp    $0x39,%al
 35d:	7e c7                	jle    326 <atoi+0xf>
  return n;
 35f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 362:	c9                   	leave  
 363:	c3                   	ret    

00000364 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 364:	55                   	push   %ebp
 365:	89 e5                	mov    %esp,%ebp
 367:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
 36a:	8b 45 08             	mov    0x8(%ebp),%eax
 36d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 370:	8b 45 0c             	mov    0xc(%ebp),%eax
 373:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 376:	eb 17                	jmp    38f <memmove+0x2b>
    *dst++ = *src++;
 378:	8b 55 f8             	mov    -0x8(%ebp),%edx
 37b:	8d 42 01             	lea    0x1(%edx),%eax
 37e:	89 45 f8             	mov    %eax,-0x8(%ebp)
 381:	8b 45 fc             	mov    -0x4(%ebp),%eax
 384:	8d 48 01             	lea    0x1(%eax),%ecx
 387:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 38a:	0f b6 12             	movzbl (%edx),%edx
 38d:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 38f:	8b 45 10             	mov    0x10(%ebp),%eax
 392:	8d 50 ff             	lea    -0x1(%eax),%edx
 395:	89 55 10             	mov    %edx,0x10(%ebp)
 398:	85 c0                	test   %eax,%eax
 39a:	7f dc                	jg     378 <memmove+0x14>
  return vdst;
 39c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 39f:	c9                   	leave  
 3a0:	c3                   	ret    

000003a1 <calc>:

int calc(int num)
{
 3a1:	55                   	push   %ebp
 3a2:	89 e5                	mov    %esp,%ebp
 3a4:	83 ec 10             	sub    $0x10,%esp
    int c = 0;
 3a7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for(uint i = 0; i < num; i++)
 3ae:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
 3b5:	eb 36                	jmp    3ed <calc+0x4c>
    {
        for(uint j = 0; j < num; j++)
 3b7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 3be:	eb 21                	jmp    3e1 <calc+0x40>
        {
            for(uint k = 0; k < num; j++)
 3c0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 3c7:	eb 0c                	jmp    3d5 <calc+0x34>
            {
                c >>= 10;
 3c9:	c1 7d fc 0a          	sarl   $0xa,-0x4(%ebp)
                c <<= 10;
 3cd:	c1 65 fc 0a          	shll   $0xa,-0x4(%ebp)
            for(uint k = 0; k < num; j++)
 3d1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 3d5:	8b 45 08             	mov    0x8(%ebp),%eax
 3d8:	39 45 f0             	cmp    %eax,-0x10(%ebp)
 3db:	72 ec                	jb     3c9 <calc+0x28>
        for(uint j = 0; j < num; j++)
 3dd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 3e1:	8b 45 08             	mov    0x8(%ebp),%eax
 3e4:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 3e7:	72 d7                	jb     3c0 <calc+0x1f>
    for(uint i = 0; i < num; i++)
 3e9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 3ed:	8b 45 08             	mov    0x8(%ebp),%eax
 3f0:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 3f3:	72 c2                	jb     3b7 <calc+0x16>
            }
        }
    }
    return 0;
 3f5:	b8 00 00 00 00       	mov    $0x0,%eax
}
 3fa:	c9                   	leave  
 3fb:	c3                   	ret    

000003fc <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 3fc:	b8 01 00 00 00       	mov    $0x1,%eax
 401:	cd 40                	int    $0x40
 403:	c3                   	ret    

00000404 <exit>:
SYSCALL(exit)
 404:	b8 02 00 00 00       	mov    $0x2,%eax
 409:	cd 40                	int    $0x40
 40b:	c3                   	ret    

0000040c <wait>:
SYSCALL(wait)
 40c:	b8 03 00 00 00       	mov    $0x3,%eax
 411:	cd 40                	int    $0x40
 413:	c3                   	ret    

00000414 <pipe>:
SYSCALL(pipe)
 414:	b8 04 00 00 00       	mov    $0x4,%eax
 419:	cd 40                	int    $0x40
 41b:	c3                   	ret    

0000041c <read>:
SYSCALL(read)
 41c:	b8 05 00 00 00       	mov    $0x5,%eax
 421:	cd 40                	int    $0x40
 423:	c3                   	ret    

00000424 <write>:
SYSCALL(write)
 424:	b8 10 00 00 00       	mov    $0x10,%eax
 429:	cd 40                	int    $0x40
 42b:	c3                   	ret    

0000042c <close>:
SYSCALL(close)
 42c:	b8 15 00 00 00       	mov    $0x15,%eax
 431:	cd 40                	int    $0x40
 433:	c3                   	ret    

00000434 <kill>:
SYSCALL(kill)
 434:	b8 06 00 00 00       	mov    $0x6,%eax
 439:	cd 40                	int    $0x40
 43b:	c3                   	ret    

0000043c <exec>:
SYSCALL(exec)
 43c:	b8 07 00 00 00       	mov    $0x7,%eax
 441:	cd 40                	int    $0x40
 443:	c3                   	ret    

00000444 <open>:
SYSCALL(open)
 444:	b8 0f 00 00 00       	mov    $0xf,%eax
 449:	cd 40                	int    $0x40
 44b:	c3                   	ret    

0000044c <mknod>:
SYSCALL(mknod)
 44c:	b8 11 00 00 00       	mov    $0x11,%eax
 451:	cd 40                	int    $0x40
 453:	c3                   	ret    

00000454 <unlink>:
SYSCALL(unlink)
 454:	b8 12 00 00 00       	mov    $0x12,%eax
 459:	cd 40                	int    $0x40
 45b:	c3                   	ret    

0000045c <fstat>:
SYSCALL(fstat)
 45c:	b8 08 00 00 00       	mov    $0x8,%eax
 461:	cd 40                	int    $0x40
 463:	c3                   	ret    

00000464 <link>:
SYSCALL(link)
 464:	b8 13 00 00 00       	mov    $0x13,%eax
 469:	cd 40                	int    $0x40
 46b:	c3                   	ret    

0000046c <mkdir>:
SYSCALL(mkdir)
 46c:	b8 14 00 00 00       	mov    $0x14,%eax
 471:	cd 40                	int    $0x40
 473:	c3                   	ret    

00000474 <chdir>:
SYSCALL(chdir)
 474:	b8 09 00 00 00       	mov    $0x9,%eax
 479:	cd 40                	int    $0x40
 47b:	c3                   	ret    

0000047c <dup>:
SYSCALL(dup)
 47c:	b8 0a 00 00 00       	mov    $0xa,%eax
 481:	cd 40                	int    $0x40
 483:	c3                   	ret    

00000484 <getpid>:
SYSCALL(getpid)
 484:	b8 0b 00 00 00       	mov    $0xb,%eax
 489:	cd 40                	int    $0x40
 48b:	c3                   	ret    

0000048c <sbrk>:
SYSCALL(sbrk)
 48c:	b8 0c 00 00 00       	mov    $0xc,%eax
 491:	cd 40                	int    $0x40
 493:	c3                   	ret    

00000494 <sleep>:
SYSCALL(sleep)
 494:	b8 0d 00 00 00       	mov    $0xd,%eax
 499:	cd 40                	int    $0x40
 49b:	c3                   	ret    

0000049c <uptime>:
SYSCALL(uptime)
 49c:	b8 0e 00 00 00       	mov    $0xe,%eax
 4a1:	cd 40                	int    $0x40
 4a3:	c3                   	ret    

000004a4 <print_proc>:
SYSCALL(print_proc)
 4a4:	b8 16 00 00 00       	mov    $0x16,%eax
 4a9:	cd 40                	int    $0x40
 4ab:	c3                   	ret    

000004ac <change_queue>:
 4ac:	b8 17 00 00 00       	mov    $0x17,%eax
 4b1:	cd 40                	int    $0x40
 4b3:	c3                   	ret    

000004b4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 4b4:	55                   	push   %ebp
 4b5:	89 e5                	mov    %esp,%ebp
 4b7:	83 ec 18             	sub    $0x18,%esp
 4ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 4bd:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 4c0:	83 ec 04             	sub    $0x4,%esp
 4c3:	6a 01                	push   $0x1
 4c5:	8d 45 f4             	lea    -0xc(%ebp),%eax
 4c8:	50                   	push   %eax
 4c9:	ff 75 08             	push   0x8(%ebp)
 4cc:	e8 53 ff ff ff       	call   424 <write>
 4d1:	83 c4 10             	add    $0x10,%esp
}
 4d4:	90                   	nop
 4d5:	c9                   	leave  
 4d6:	c3                   	ret    

000004d7 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 4d7:	55                   	push   %ebp
 4d8:	89 e5                	mov    %esp,%ebp
 4da:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 4dd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 4e4:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 4e8:	74 17                	je     501 <printint+0x2a>
 4ea:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 4ee:	79 11                	jns    501 <printint+0x2a>
    neg = 1;
 4f0:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 4f7:	8b 45 0c             	mov    0xc(%ebp),%eax
 4fa:	f7 d8                	neg    %eax
 4fc:	89 45 ec             	mov    %eax,-0x14(%ebp)
 4ff:	eb 06                	jmp    507 <printint+0x30>
  } else {
    x = xx;
 501:	8b 45 0c             	mov    0xc(%ebp),%eax
 504:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 507:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 50e:	8b 4d 10             	mov    0x10(%ebp),%ecx
 511:	8b 45 ec             	mov    -0x14(%ebp),%eax
 514:	ba 00 00 00 00       	mov    $0x0,%edx
 519:	f7 f1                	div    %ecx
 51b:	89 d1                	mov    %edx,%ecx
 51d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 520:	8d 50 01             	lea    0x1(%eax),%edx
 523:	89 55 f4             	mov    %edx,-0xc(%ebp)
 526:	0f b6 91 d0 0b 00 00 	movzbl 0xbd0(%ecx),%edx
 52d:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 531:	8b 4d 10             	mov    0x10(%ebp),%ecx
 534:	8b 45 ec             	mov    -0x14(%ebp),%eax
 537:	ba 00 00 00 00       	mov    $0x0,%edx
 53c:	f7 f1                	div    %ecx
 53e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 541:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 545:	75 c7                	jne    50e <printint+0x37>
  if(neg)
 547:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 54b:	74 2d                	je     57a <printint+0xa3>
    buf[i++] = '-';
 54d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 550:	8d 50 01             	lea    0x1(%eax),%edx
 553:	89 55 f4             	mov    %edx,-0xc(%ebp)
 556:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 55b:	eb 1d                	jmp    57a <printint+0xa3>
    putc(fd, buf[i]);
 55d:	8d 55 dc             	lea    -0x24(%ebp),%edx
 560:	8b 45 f4             	mov    -0xc(%ebp),%eax
 563:	01 d0                	add    %edx,%eax
 565:	0f b6 00             	movzbl (%eax),%eax
 568:	0f be c0             	movsbl %al,%eax
 56b:	83 ec 08             	sub    $0x8,%esp
 56e:	50                   	push   %eax
 56f:	ff 75 08             	push   0x8(%ebp)
 572:	e8 3d ff ff ff       	call   4b4 <putc>
 577:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 57a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 57e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 582:	79 d9                	jns    55d <printint+0x86>
}
 584:	90                   	nop
 585:	90                   	nop
 586:	c9                   	leave  
 587:	c3                   	ret    

00000588 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 588:	55                   	push   %ebp
 589:	89 e5                	mov    %esp,%ebp
 58b:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 58e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 595:	8d 45 0c             	lea    0xc(%ebp),%eax
 598:	83 c0 04             	add    $0x4,%eax
 59b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 59e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5a5:	e9 59 01 00 00       	jmp    703 <printf+0x17b>
    c = fmt[i] & 0xff;
 5aa:	8b 55 0c             	mov    0xc(%ebp),%edx
 5ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
 5b0:	01 d0                	add    %edx,%eax
 5b2:	0f b6 00             	movzbl (%eax),%eax
 5b5:	0f be c0             	movsbl %al,%eax
 5b8:	25 ff 00 00 00       	and    $0xff,%eax
 5bd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 5c0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 5c4:	75 2c                	jne    5f2 <printf+0x6a>
      if(c == '%'){
 5c6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 5ca:	75 0c                	jne    5d8 <printf+0x50>
        state = '%';
 5cc:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 5d3:	e9 27 01 00 00       	jmp    6ff <printf+0x177>
      } else {
        putc(fd, c);
 5d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 5db:	0f be c0             	movsbl %al,%eax
 5de:	83 ec 08             	sub    $0x8,%esp
 5e1:	50                   	push   %eax
 5e2:	ff 75 08             	push   0x8(%ebp)
 5e5:	e8 ca fe ff ff       	call   4b4 <putc>
 5ea:	83 c4 10             	add    $0x10,%esp
 5ed:	e9 0d 01 00 00       	jmp    6ff <printf+0x177>
      }
    } else if(state == '%'){
 5f2:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 5f6:	0f 85 03 01 00 00    	jne    6ff <printf+0x177>
      if(c == 'd'){
 5fc:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 600:	75 1e                	jne    620 <printf+0x98>
        printint(fd, *ap, 10, 1);
 602:	8b 45 e8             	mov    -0x18(%ebp),%eax
 605:	8b 00                	mov    (%eax),%eax
 607:	6a 01                	push   $0x1
 609:	6a 0a                	push   $0xa
 60b:	50                   	push   %eax
 60c:	ff 75 08             	push   0x8(%ebp)
 60f:	e8 c3 fe ff ff       	call   4d7 <printint>
 614:	83 c4 10             	add    $0x10,%esp
        ap++;
 617:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 61b:	e9 d8 00 00 00       	jmp    6f8 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 620:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 624:	74 06                	je     62c <printf+0xa4>
 626:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 62a:	75 1e                	jne    64a <printf+0xc2>
        printint(fd, *ap, 16, 0);
 62c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 62f:	8b 00                	mov    (%eax),%eax
 631:	6a 00                	push   $0x0
 633:	6a 10                	push   $0x10
 635:	50                   	push   %eax
 636:	ff 75 08             	push   0x8(%ebp)
 639:	e8 99 fe ff ff       	call   4d7 <printint>
 63e:	83 c4 10             	add    $0x10,%esp
        ap++;
 641:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 645:	e9 ae 00 00 00       	jmp    6f8 <printf+0x170>
      } else if(c == 's'){
 64a:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 64e:	75 43                	jne    693 <printf+0x10b>
        s = (char*)*ap;
 650:	8b 45 e8             	mov    -0x18(%ebp),%eax
 653:	8b 00                	mov    (%eax),%eax
 655:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 658:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 65c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 660:	75 25                	jne    687 <printf+0xff>
          s = "(null)";
 662:	c7 45 f4 62 09 00 00 	movl   $0x962,-0xc(%ebp)
        while(*s != 0){
 669:	eb 1c                	jmp    687 <printf+0xff>
          putc(fd, *s);
 66b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 66e:	0f b6 00             	movzbl (%eax),%eax
 671:	0f be c0             	movsbl %al,%eax
 674:	83 ec 08             	sub    $0x8,%esp
 677:	50                   	push   %eax
 678:	ff 75 08             	push   0x8(%ebp)
 67b:	e8 34 fe ff ff       	call   4b4 <putc>
 680:	83 c4 10             	add    $0x10,%esp
          s++;
 683:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 687:	8b 45 f4             	mov    -0xc(%ebp),%eax
 68a:	0f b6 00             	movzbl (%eax),%eax
 68d:	84 c0                	test   %al,%al
 68f:	75 da                	jne    66b <printf+0xe3>
 691:	eb 65                	jmp    6f8 <printf+0x170>
        }
      } else if(c == 'c'){
 693:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 697:	75 1d                	jne    6b6 <printf+0x12e>
        putc(fd, *ap);
 699:	8b 45 e8             	mov    -0x18(%ebp),%eax
 69c:	8b 00                	mov    (%eax),%eax
 69e:	0f be c0             	movsbl %al,%eax
 6a1:	83 ec 08             	sub    $0x8,%esp
 6a4:	50                   	push   %eax
 6a5:	ff 75 08             	push   0x8(%ebp)
 6a8:	e8 07 fe ff ff       	call   4b4 <putc>
 6ad:	83 c4 10             	add    $0x10,%esp
        ap++;
 6b0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 6b4:	eb 42                	jmp    6f8 <printf+0x170>
      } else if(c == '%'){
 6b6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 6ba:	75 17                	jne    6d3 <printf+0x14b>
        putc(fd, c);
 6bc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6bf:	0f be c0             	movsbl %al,%eax
 6c2:	83 ec 08             	sub    $0x8,%esp
 6c5:	50                   	push   %eax
 6c6:	ff 75 08             	push   0x8(%ebp)
 6c9:	e8 e6 fd ff ff       	call   4b4 <putc>
 6ce:	83 c4 10             	add    $0x10,%esp
 6d1:	eb 25                	jmp    6f8 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 6d3:	83 ec 08             	sub    $0x8,%esp
 6d6:	6a 25                	push   $0x25
 6d8:	ff 75 08             	push   0x8(%ebp)
 6db:	e8 d4 fd ff ff       	call   4b4 <putc>
 6e0:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 6e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 6e6:	0f be c0             	movsbl %al,%eax
 6e9:	83 ec 08             	sub    $0x8,%esp
 6ec:	50                   	push   %eax
 6ed:	ff 75 08             	push   0x8(%ebp)
 6f0:	e8 bf fd ff ff       	call   4b4 <putc>
 6f5:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 6f8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 6ff:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 703:	8b 55 0c             	mov    0xc(%ebp),%edx
 706:	8b 45 f0             	mov    -0x10(%ebp),%eax
 709:	01 d0                	add    %edx,%eax
 70b:	0f b6 00             	movzbl (%eax),%eax
 70e:	84 c0                	test   %al,%al
 710:	0f 85 94 fe ff ff    	jne    5aa <printf+0x22>
    }
  }
}
 716:	90                   	nop
 717:	90                   	nop
 718:	c9                   	leave  
 719:	c3                   	ret    

0000071a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 71a:	55                   	push   %ebp
 71b:	89 e5                	mov    %esp,%ebp
 71d:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 720:	8b 45 08             	mov    0x8(%ebp),%eax
 723:	83 e8 08             	sub    $0x8,%eax
 726:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 729:	a1 ec 0b 00 00       	mov    0xbec,%eax
 72e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 731:	eb 24                	jmp    757 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 733:	8b 45 fc             	mov    -0x4(%ebp),%eax
 736:	8b 00                	mov    (%eax),%eax
 738:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 73b:	72 12                	jb     74f <free+0x35>
 73d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 740:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 743:	77 24                	ja     769 <free+0x4f>
 745:	8b 45 fc             	mov    -0x4(%ebp),%eax
 748:	8b 00                	mov    (%eax),%eax
 74a:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 74d:	72 1a                	jb     769 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 74f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 752:	8b 00                	mov    (%eax),%eax
 754:	89 45 fc             	mov    %eax,-0x4(%ebp)
 757:	8b 45 f8             	mov    -0x8(%ebp),%eax
 75a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 75d:	76 d4                	jbe    733 <free+0x19>
 75f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 762:	8b 00                	mov    (%eax),%eax
 764:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 767:	73 ca                	jae    733 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 769:	8b 45 f8             	mov    -0x8(%ebp),%eax
 76c:	8b 40 04             	mov    0x4(%eax),%eax
 76f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 776:	8b 45 f8             	mov    -0x8(%ebp),%eax
 779:	01 c2                	add    %eax,%edx
 77b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 77e:	8b 00                	mov    (%eax),%eax
 780:	39 c2                	cmp    %eax,%edx
 782:	75 24                	jne    7a8 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 784:	8b 45 f8             	mov    -0x8(%ebp),%eax
 787:	8b 50 04             	mov    0x4(%eax),%edx
 78a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 78d:	8b 00                	mov    (%eax),%eax
 78f:	8b 40 04             	mov    0x4(%eax),%eax
 792:	01 c2                	add    %eax,%edx
 794:	8b 45 f8             	mov    -0x8(%ebp),%eax
 797:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 79a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 79d:	8b 00                	mov    (%eax),%eax
 79f:	8b 10                	mov    (%eax),%edx
 7a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7a4:	89 10                	mov    %edx,(%eax)
 7a6:	eb 0a                	jmp    7b2 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 7a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ab:	8b 10                	mov    (%eax),%edx
 7ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7b0:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 7b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7b5:	8b 40 04             	mov    0x4(%eax),%eax
 7b8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 7bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7c2:	01 d0                	add    %edx,%eax
 7c4:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 7c7:	75 20                	jne    7e9 <free+0xcf>
    p->s.size += bp->s.size;
 7c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7cc:	8b 50 04             	mov    0x4(%eax),%edx
 7cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7d2:	8b 40 04             	mov    0x4(%eax),%eax
 7d5:	01 c2                	add    %eax,%edx
 7d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7da:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 7e0:	8b 10                	mov    (%eax),%edx
 7e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7e5:	89 10                	mov    %edx,(%eax)
 7e7:	eb 08                	jmp    7f1 <free+0xd7>
  } else
    p->s.ptr = bp;
 7e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7ec:	8b 55 f8             	mov    -0x8(%ebp),%edx
 7ef:	89 10                	mov    %edx,(%eax)
  freep = p;
 7f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 7f4:	a3 ec 0b 00 00       	mov    %eax,0xbec
}
 7f9:	90                   	nop
 7fa:	c9                   	leave  
 7fb:	c3                   	ret    

000007fc <morecore>:

static Header*
morecore(uint nu)
{
 7fc:	55                   	push   %ebp
 7fd:	89 e5                	mov    %esp,%ebp
 7ff:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 802:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 809:	77 07                	ja     812 <morecore+0x16>
    nu = 4096;
 80b:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 812:	8b 45 08             	mov    0x8(%ebp),%eax
 815:	c1 e0 03             	shl    $0x3,%eax
 818:	83 ec 0c             	sub    $0xc,%esp
 81b:	50                   	push   %eax
 81c:	e8 6b fc ff ff       	call   48c <sbrk>
 821:	83 c4 10             	add    $0x10,%esp
 824:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 827:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 82b:	75 07                	jne    834 <morecore+0x38>
    return 0;
 82d:	b8 00 00 00 00       	mov    $0x0,%eax
 832:	eb 26                	jmp    85a <morecore+0x5e>
  hp = (Header*)p;
 834:	8b 45 f4             	mov    -0xc(%ebp),%eax
 837:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 83a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 83d:	8b 55 08             	mov    0x8(%ebp),%edx
 840:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 843:	8b 45 f0             	mov    -0x10(%ebp),%eax
 846:	83 c0 08             	add    $0x8,%eax
 849:	83 ec 0c             	sub    $0xc,%esp
 84c:	50                   	push   %eax
 84d:	e8 c8 fe ff ff       	call   71a <free>
 852:	83 c4 10             	add    $0x10,%esp
  return freep;
 855:	a1 ec 0b 00 00       	mov    0xbec,%eax
}
 85a:	c9                   	leave  
 85b:	c3                   	ret    

0000085c <malloc>:

void*
malloc(uint nbytes)
{
 85c:	55                   	push   %ebp
 85d:	89 e5                	mov    %esp,%ebp
 85f:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 862:	8b 45 08             	mov    0x8(%ebp),%eax
 865:	83 c0 07             	add    $0x7,%eax
 868:	c1 e8 03             	shr    $0x3,%eax
 86b:	83 c0 01             	add    $0x1,%eax
 86e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 871:	a1 ec 0b 00 00       	mov    0xbec,%eax
 876:	89 45 f0             	mov    %eax,-0x10(%ebp)
 879:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 87d:	75 23                	jne    8a2 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 87f:	c7 45 f0 e4 0b 00 00 	movl   $0xbe4,-0x10(%ebp)
 886:	8b 45 f0             	mov    -0x10(%ebp),%eax
 889:	a3 ec 0b 00 00       	mov    %eax,0xbec
 88e:	a1 ec 0b 00 00       	mov    0xbec,%eax
 893:	a3 e4 0b 00 00       	mov    %eax,0xbe4
    base.s.size = 0;
 898:	c7 05 e8 0b 00 00 00 	movl   $0x0,0xbe8
 89f:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8a5:	8b 00                	mov    (%eax),%eax
 8a7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 8aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ad:	8b 40 04             	mov    0x4(%eax),%eax
 8b0:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 8b3:	77 4d                	ja     902 <malloc+0xa6>
      if(p->s.size == nunits)
 8b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8b8:	8b 40 04             	mov    0x4(%eax),%eax
 8bb:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 8be:	75 0c                	jne    8cc <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 8c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8c3:	8b 10                	mov    (%eax),%edx
 8c5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8c8:	89 10                	mov    %edx,(%eax)
 8ca:	eb 26                	jmp    8f2 <malloc+0x96>
      else {
        p->s.size -= nunits;
 8cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8cf:	8b 40 04             	mov    0x4(%eax),%eax
 8d2:	2b 45 ec             	sub    -0x14(%ebp),%eax
 8d5:	89 c2                	mov    %eax,%edx
 8d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8da:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 8dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8e0:	8b 40 04             	mov    0x4(%eax),%eax
 8e3:	c1 e0 03             	shl    $0x3,%eax
 8e6:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 8e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8ec:	8b 55 ec             	mov    -0x14(%ebp),%edx
 8ef:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 8f2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 8f5:	a3 ec 0b 00 00       	mov    %eax,0xbec
      return (void*)(p + 1);
 8fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 8fd:	83 c0 08             	add    $0x8,%eax
 900:	eb 3b                	jmp    93d <malloc+0xe1>
    }
    if(p == freep)
 902:	a1 ec 0b 00 00       	mov    0xbec,%eax
 907:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 90a:	75 1e                	jne    92a <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 90c:	83 ec 0c             	sub    $0xc,%esp
 90f:	ff 75 ec             	push   -0x14(%ebp)
 912:	e8 e5 fe ff ff       	call   7fc <morecore>
 917:	83 c4 10             	add    $0x10,%esp
 91a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 91d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 921:	75 07                	jne    92a <malloc+0xce>
        return 0;
 923:	b8 00 00 00 00       	mov    $0x0,%eax
 928:	eb 13                	jmp    93d <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 92a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 92d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 930:	8b 45 f4             	mov    -0xc(%ebp),%eax
 933:	8b 00                	mov    (%eax),%eax
 935:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 938:	e9 6d ff ff ff       	jmp    8aa <malloc+0x4e>
  }
}
 93d:	c9                   	leave  
 93e:	c3                   	ret    
