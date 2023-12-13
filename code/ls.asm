
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <fmtname>:
#include "user.h"
#include "fs.h"

char*
fmtname(char *path)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	53                   	push   %ebx
   4:	83 ec 14             	sub    $0x14,%esp
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
   7:	83 ec 0c             	sub    $0xc,%esp
   a:	ff 75 08             	push   0x8(%ebp)
   d:	e8 c5 03 00 00       	call   3d7 <strlen>
  12:	83 c4 10             	add    $0x10,%esp
  15:	8b 55 08             	mov    0x8(%ebp),%edx
  18:	01 d0                	add    %edx,%eax
  1a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  1d:	eb 04                	jmp    23 <fmtname+0x23>
  1f:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  23:	8b 45 f4             	mov    -0xc(%ebp),%eax
  26:	3b 45 08             	cmp    0x8(%ebp),%eax
  29:	72 0a                	jb     35 <fmtname+0x35>
  2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
  2e:	0f b6 00             	movzbl (%eax),%eax
  31:	3c 2f                	cmp    $0x2f,%al
  33:	75 ea                	jne    1f <fmtname+0x1f>
    ;
  p++;
  35:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  39:	83 ec 0c             	sub    $0xc,%esp
  3c:	ff 75 f4             	push   -0xc(%ebp)
  3f:	e8 93 03 00 00       	call   3d7 <strlen>
  44:	83 c4 10             	add    $0x10,%esp
  47:	83 f8 0d             	cmp    $0xd,%eax
  4a:	76 05                	jbe    51 <fmtname+0x51>
    return p;
  4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
  4f:	eb 60                	jmp    b1 <fmtname+0xb1>
  memmove(buf, p, strlen(p));
  51:	83 ec 0c             	sub    $0xc,%esp
  54:	ff 75 f4             	push   -0xc(%ebp)
  57:	e8 7b 03 00 00       	call   3d7 <strlen>
  5c:	83 c4 10             	add    $0x10,%esp
  5f:	83 ec 04             	sub    $0x4,%esp
  62:	50                   	push   %eax
  63:	ff 75 f4             	push   -0xc(%ebp)
  66:	68 60 0e 00 00       	push   $0xe60
  6b:	e8 e4 04 00 00       	call   554 <memmove>
  70:	83 c4 10             	add    $0x10,%esp
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  73:	83 ec 0c             	sub    $0xc,%esp
  76:	ff 75 f4             	push   -0xc(%ebp)
  79:	e8 59 03 00 00       	call   3d7 <strlen>
  7e:	83 c4 10             	add    $0x10,%esp
  81:	ba 0e 00 00 00       	mov    $0xe,%edx
  86:	89 d3                	mov    %edx,%ebx
  88:	29 c3                	sub    %eax,%ebx
  8a:	83 ec 0c             	sub    $0xc,%esp
  8d:	ff 75 f4             	push   -0xc(%ebp)
  90:	e8 42 03 00 00       	call   3d7 <strlen>
  95:	83 c4 10             	add    $0x10,%esp
  98:	05 60 0e 00 00       	add    $0xe60,%eax
  9d:	83 ec 04             	sub    $0x4,%esp
  a0:	53                   	push   %ebx
  a1:	6a 20                	push   $0x20
  a3:	50                   	push   %eax
  a4:	e8 55 03 00 00       	call   3fe <memset>
  a9:	83 c4 10             	add    $0x10,%esp
  return buf;
  ac:	b8 60 0e 00 00       	mov    $0xe60,%eax
}
  b1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  b4:	c9                   	leave  
  b5:	c3                   	ret    

000000b6 <ls>:

void
ls(char *path)
{
  b6:	55                   	push   %ebp
  b7:	89 e5                	mov    %esp,%ebp
  b9:	57                   	push   %edi
  ba:	56                   	push   %esi
  bb:	53                   	push   %ebx
  bc:	81 ec 3c 02 00 00    	sub    $0x23c,%esp
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;

  if((fd = open(path, 0)) < 0){
  c2:	83 ec 08             	sub    $0x8,%esp
  c5:	6a 00                	push   $0x0
  c7:	ff 75 08             	push   0x8(%ebp)
  ca:	e8 65 05 00 00       	call   634 <open>
  cf:	83 c4 10             	add    $0x10,%esp
  d2:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  d5:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  d9:	79 1a                	jns    f5 <ls+0x3f>
    printf(2, "ls: cannot open %s\n", path);
  db:	83 ec 04             	sub    $0x4,%esp
  de:	ff 75 08             	push   0x8(%ebp)
  e1:	68 3f 0b 00 00       	push   $0xb3f
  e6:	6a 02                	push   $0x2
  e8:	e8 9b 06 00 00       	call   788 <printf>
  ed:	83 c4 10             	add    $0x10,%esp
    return;
  f0:	e9 e1 01 00 00       	jmp    2d6 <ls+0x220>
  }

  if(fstat(fd, &st) < 0){
  f5:	83 ec 08             	sub    $0x8,%esp
  f8:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
  fe:	50                   	push   %eax
  ff:	ff 75 e4             	push   -0x1c(%ebp)
 102:	e8 45 05 00 00       	call   64c <fstat>
 107:	83 c4 10             	add    $0x10,%esp
 10a:	85 c0                	test   %eax,%eax
 10c:	79 28                	jns    136 <ls+0x80>
    printf(2, "ls: cannot stat %s\n", path);
 10e:	83 ec 04             	sub    $0x4,%esp
 111:	ff 75 08             	push   0x8(%ebp)
 114:	68 53 0b 00 00       	push   $0xb53
 119:	6a 02                	push   $0x2
 11b:	e8 68 06 00 00       	call   788 <printf>
 120:	83 c4 10             	add    $0x10,%esp
    close(fd);
 123:	83 ec 0c             	sub    $0xc,%esp
 126:	ff 75 e4             	push   -0x1c(%ebp)
 129:	e8 ee 04 00 00       	call   61c <close>
 12e:	83 c4 10             	add    $0x10,%esp
    return;
 131:	e9 a0 01 00 00       	jmp    2d6 <ls+0x220>
  }

  switch(st.type){
 136:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 13d:	98                   	cwtl   
 13e:	83 f8 01             	cmp    $0x1,%eax
 141:	74 48                	je     18b <ls+0xd5>
 143:	83 f8 02             	cmp    $0x2,%eax
 146:	0f 85 7c 01 00 00    	jne    2c8 <ls+0x212>
  case T_FILE:
    printf(1, "%s %d %d %d\n", fmtname(path), st.type, st.ino, st.size);
 14c:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
 152:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
 158:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 15f:	0f bf d8             	movswl %ax,%ebx
 162:	83 ec 0c             	sub    $0xc,%esp
 165:	ff 75 08             	push   0x8(%ebp)
 168:	e8 93 fe ff ff       	call   0 <fmtname>
 16d:	83 c4 10             	add    $0x10,%esp
 170:	83 ec 08             	sub    $0x8,%esp
 173:	57                   	push   %edi
 174:	56                   	push   %esi
 175:	53                   	push   %ebx
 176:	50                   	push   %eax
 177:	68 67 0b 00 00       	push   $0xb67
 17c:	6a 01                	push   $0x1
 17e:	e8 05 06 00 00       	call   788 <printf>
 183:	83 c4 20             	add    $0x20,%esp
    break;
 186:	e9 3d 01 00 00       	jmp    2c8 <ls+0x212>

  case T_DIR:
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 18b:	83 ec 0c             	sub    $0xc,%esp
 18e:	ff 75 08             	push   0x8(%ebp)
 191:	e8 41 02 00 00       	call   3d7 <strlen>
 196:	83 c4 10             	add    $0x10,%esp
 199:	83 c0 10             	add    $0x10,%eax
 19c:	3d 00 02 00 00       	cmp    $0x200,%eax
 1a1:	76 17                	jbe    1ba <ls+0x104>
      printf(1, "ls: path too long\n");
 1a3:	83 ec 08             	sub    $0x8,%esp
 1a6:	68 74 0b 00 00       	push   $0xb74
 1ab:	6a 01                	push   $0x1
 1ad:	e8 d6 05 00 00       	call   788 <printf>
 1b2:	83 c4 10             	add    $0x10,%esp
      break;
 1b5:	e9 0e 01 00 00       	jmp    2c8 <ls+0x212>
    }
    strcpy(buf, path);
 1ba:	83 ec 08             	sub    $0x8,%esp
 1bd:	ff 75 08             	push   0x8(%ebp)
 1c0:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 1c6:	50                   	push   %eax
 1c7:	e8 9c 01 00 00       	call   368 <strcpy>
 1cc:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 1cf:	83 ec 0c             	sub    $0xc,%esp
 1d2:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 1d8:	50                   	push   %eax
 1d9:	e8 f9 01 00 00       	call   3d7 <strlen>
 1de:	83 c4 10             	add    $0x10,%esp
 1e1:	8d 95 e0 fd ff ff    	lea    -0x220(%ebp),%edx
 1e7:	01 d0                	add    %edx,%eax
 1e9:	89 45 e0             	mov    %eax,-0x20(%ebp)
    *p++ = '/';
 1ec:	8b 45 e0             	mov    -0x20(%ebp),%eax
 1ef:	8d 50 01             	lea    0x1(%eax),%edx
 1f2:	89 55 e0             	mov    %edx,-0x20(%ebp)
 1f5:	c6 00 2f             	movb   $0x2f,(%eax)
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 1f8:	e9 aa 00 00 00       	jmp    2a7 <ls+0x1f1>
      if(de.inum == 0)
 1fd:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
 204:	66 85 c0             	test   %ax,%ax
 207:	75 05                	jne    20e <ls+0x158>
        continue;
 209:	e9 99 00 00 00       	jmp    2a7 <ls+0x1f1>
      memmove(p, de.name, DIRSIZ);
 20e:	83 ec 04             	sub    $0x4,%esp
 211:	6a 0e                	push   $0xe
 213:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 219:	83 c0 02             	add    $0x2,%eax
 21c:	50                   	push   %eax
 21d:	ff 75 e0             	push   -0x20(%ebp)
 220:	e8 2f 03 00 00       	call   554 <memmove>
 225:	83 c4 10             	add    $0x10,%esp
      p[DIRSIZ] = 0;
 228:	8b 45 e0             	mov    -0x20(%ebp),%eax
 22b:	83 c0 0e             	add    $0xe,%eax
 22e:	c6 00 00             	movb   $0x0,(%eax)
      if(stat(buf, &st) < 0){
 231:	83 ec 08             	sub    $0x8,%esp
 234:	8d 85 bc fd ff ff    	lea    -0x244(%ebp),%eax
 23a:	50                   	push   %eax
 23b:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 241:	50                   	push   %eax
 242:	e8 73 02 00 00       	call   4ba <stat>
 247:	83 c4 10             	add    $0x10,%esp
 24a:	85 c0                	test   %eax,%eax
 24c:	79 1b                	jns    269 <ls+0x1b3>
        printf(1, "ls: cannot stat %s\n", buf);
 24e:	83 ec 04             	sub    $0x4,%esp
 251:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 257:	50                   	push   %eax
 258:	68 53 0b 00 00       	push   $0xb53
 25d:	6a 01                	push   $0x1
 25f:	e8 24 05 00 00       	call   788 <printf>
 264:	83 c4 10             	add    $0x10,%esp
        continue;
 267:	eb 3e                	jmp    2a7 <ls+0x1f1>
      }
      printf(1, "%s %d %d %d\n", fmtname(buf), st.type, st.ino, st.size);
 269:	8b bd cc fd ff ff    	mov    -0x234(%ebp),%edi
 26f:	8b b5 c4 fd ff ff    	mov    -0x23c(%ebp),%esi
 275:	0f b7 85 bc fd ff ff 	movzwl -0x244(%ebp),%eax
 27c:	0f bf d8             	movswl %ax,%ebx
 27f:	83 ec 0c             	sub    $0xc,%esp
 282:	8d 85 e0 fd ff ff    	lea    -0x220(%ebp),%eax
 288:	50                   	push   %eax
 289:	e8 72 fd ff ff       	call   0 <fmtname>
 28e:	83 c4 10             	add    $0x10,%esp
 291:	83 ec 08             	sub    $0x8,%esp
 294:	57                   	push   %edi
 295:	56                   	push   %esi
 296:	53                   	push   %ebx
 297:	50                   	push   %eax
 298:	68 67 0b 00 00       	push   $0xb67
 29d:	6a 01                	push   $0x1
 29f:	e8 e4 04 00 00       	call   788 <printf>
 2a4:	83 c4 20             	add    $0x20,%esp
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 2a7:	83 ec 04             	sub    $0x4,%esp
 2aa:	6a 10                	push   $0x10
 2ac:	8d 85 d0 fd ff ff    	lea    -0x230(%ebp),%eax
 2b2:	50                   	push   %eax
 2b3:	ff 75 e4             	push   -0x1c(%ebp)
 2b6:	e8 51 03 00 00       	call   60c <read>
 2bb:	83 c4 10             	add    $0x10,%esp
 2be:	83 f8 10             	cmp    $0x10,%eax
 2c1:	0f 84 36 ff ff ff    	je     1fd <ls+0x147>
    }
    break;
 2c7:	90                   	nop
  }
  close(fd);
 2c8:	83 ec 0c             	sub    $0xc,%esp
 2cb:	ff 75 e4             	push   -0x1c(%ebp)
 2ce:	e8 49 03 00 00       	call   61c <close>
 2d3:	83 c4 10             	add    $0x10,%esp
}
 2d6:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2d9:	5b                   	pop    %ebx
 2da:	5e                   	pop    %esi
 2db:	5f                   	pop    %edi
 2dc:	5d                   	pop    %ebp
 2dd:	c3                   	ret    

000002de <main>:

int
main(int argc, char *argv[])
{
 2de:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 2e2:	83 e4 f0             	and    $0xfffffff0,%esp
 2e5:	ff 71 fc             	push   -0x4(%ecx)
 2e8:	55                   	push   %ebp
 2e9:	89 e5                	mov    %esp,%ebp
 2eb:	53                   	push   %ebx
 2ec:	51                   	push   %ecx
 2ed:	83 ec 10             	sub    $0x10,%esp
 2f0:	89 cb                	mov    %ecx,%ebx
  int i;

  if(argc < 2){
 2f2:	83 3b 01             	cmpl   $0x1,(%ebx)
 2f5:	7f 15                	jg     30c <main+0x2e>
    ls(".");
 2f7:	83 ec 0c             	sub    $0xc,%esp
 2fa:	68 87 0b 00 00       	push   $0xb87
 2ff:	e8 b2 fd ff ff       	call   b6 <ls>
 304:	83 c4 10             	add    $0x10,%esp
    exit();
 307:	e8 e8 02 00 00       	call   5f4 <exit>
  }
  for(i=1; i<argc; i++)
 30c:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
 313:	eb 21                	jmp    336 <main+0x58>
    ls(argv[i]);
 315:	8b 45 f4             	mov    -0xc(%ebp),%eax
 318:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
 31f:	8b 43 04             	mov    0x4(%ebx),%eax
 322:	01 d0                	add    %edx,%eax
 324:	8b 00                	mov    (%eax),%eax
 326:	83 ec 0c             	sub    $0xc,%esp
 329:	50                   	push   %eax
 32a:	e8 87 fd ff ff       	call   b6 <ls>
 32f:	83 c4 10             	add    $0x10,%esp
  for(i=1; i<argc; i++)
 332:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 336:	8b 45 f4             	mov    -0xc(%ebp),%eax
 339:	3b 03                	cmp    (%ebx),%eax
 33b:	7c d8                	jl     315 <main+0x37>
  exit();
 33d:	e8 b2 02 00 00       	call   5f4 <exit>

00000342 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
 342:	55                   	push   %ebp
 343:	89 e5                	mov    %esp,%ebp
 345:	57                   	push   %edi
 346:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
 347:	8b 4d 08             	mov    0x8(%ebp),%ecx
 34a:	8b 55 10             	mov    0x10(%ebp),%edx
 34d:	8b 45 0c             	mov    0xc(%ebp),%eax
 350:	89 cb                	mov    %ecx,%ebx
 352:	89 df                	mov    %ebx,%edi
 354:	89 d1                	mov    %edx,%ecx
 356:	fc                   	cld    
 357:	f3 aa                	rep stos %al,%es:(%edi)
 359:	89 ca                	mov    %ecx,%edx
 35b:	89 fb                	mov    %edi,%ebx
 35d:	89 5d 08             	mov    %ebx,0x8(%ebp)
 360:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
 363:	90                   	nop
 364:	5b                   	pop    %ebx
 365:	5f                   	pop    %edi
 366:	5d                   	pop    %ebp
 367:	c3                   	ret    

00000368 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 368:	55                   	push   %ebp
 369:	89 e5                	mov    %esp,%ebp
 36b:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
 36e:	8b 45 08             	mov    0x8(%ebp),%eax
 371:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
 374:	90                   	nop
 375:	8b 55 0c             	mov    0xc(%ebp),%edx
 378:	8d 42 01             	lea    0x1(%edx),%eax
 37b:	89 45 0c             	mov    %eax,0xc(%ebp)
 37e:	8b 45 08             	mov    0x8(%ebp),%eax
 381:	8d 48 01             	lea    0x1(%eax),%ecx
 384:	89 4d 08             	mov    %ecx,0x8(%ebp)
 387:	0f b6 12             	movzbl (%edx),%edx
 38a:	88 10                	mov    %dl,(%eax)
 38c:	0f b6 00             	movzbl (%eax),%eax
 38f:	84 c0                	test   %al,%al
 391:	75 e2                	jne    375 <strcpy+0xd>
    ;
  return os;
 393:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 396:	c9                   	leave  
 397:	c3                   	ret    

00000398 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 398:	55                   	push   %ebp
 399:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
 39b:	eb 08                	jmp    3a5 <strcmp+0xd>
    p++, q++;
 39d:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 3a1:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
 3a5:	8b 45 08             	mov    0x8(%ebp),%eax
 3a8:	0f b6 00             	movzbl (%eax),%eax
 3ab:	84 c0                	test   %al,%al
 3ad:	74 10                	je     3bf <strcmp+0x27>
 3af:	8b 45 08             	mov    0x8(%ebp),%eax
 3b2:	0f b6 10             	movzbl (%eax),%edx
 3b5:	8b 45 0c             	mov    0xc(%ebp),%eax
 3b8:	0f b6 00             	movzbl (%eax),%eax
 3bb:	38 c2                	cmp    %al,%dl
 3bd:	74 de                	je     39d <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
 3bf:	8b 45 08             	mov    0x8(%ebp),%eax
 3c2:	0f b6 00             	movzbl (%eax),%eax
 3c5:	0f b6 d0             	movzbl %al,%edx
 3c8:	8b 45 0c             	mov    0xc(%ebp),%eax
 3cb:	0f b6 00             	movzbl (%eax),%eax
 3ce:	0f b6 c8             	movzbl %al,%ecx
 3d1:	89 d0                	mov    %edx,%eax
 3d3:	29 c8                	sub    %ecx,%eax
}
 3d5:	5d                   	pop    %ebp
 3d6:	c3                   	ret    

000003d7 <strlen>:

uint
strlen(const char *s)
{
 3d7:	55                   	push   %ebp
 3d8:	89 e5                	mov    %esp,%ebp
 3da:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
 3dd:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
 3e4:	eb 04                	jmp    3ea <strlen+0x13>
 3e6:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
 3ea:	8b 55 fc             	mov    -0x4(%ebp),%edx
 3ed:	8b 45 08             	mov    0x8(%ebp),%eax
 3f0:	01 d0                	add    %edx,%eax
 3f2:	0f b6 00             	movzbl (%eax),%eax
 3f5:	84 c0                	test   %al,%al
 3f7:	75 ed                	jne    3e6 <strlen+0xf>
    ;
  return n;
 3f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 3fc:	c9                   	leave  
 3fd:	c3                   	ret    

000003fe <memset>:

void*
memset(void *dst, int c, uint n)
{
 3fe:	55                   	push   %ebp
 3ff:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
 401:	8b 45 10             	mov    0x10(%ebp),%eax
 404:	50                   	push   %eax
 405:	ff 75 0c             	push   0xc(%ebp)
 408:	ff 75 08             	push   0x8(%ebp)
 40b:	e8 32 ff ff ff       	call   342 <stosb>
 410:	83 c4 0c             	add    $0xc,%esp
  return dst;
 413:	8b 45 08             	mov    0x8(%ebp),%eax
}
 416:	c9                   	leave  
 417:	c3                   	ret    

00000418 <strchr>:

char*
strchr(const char *s, char c)
{
 418:	55                   	push   %ebp
 419:	89 e5                	mov    %esp,%ebp
 41b:	83 ec 04             	sub    $0x4,%esp
 41e:	8b 45 0c             	mov    0xc(%ebp),%eax
 421:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
 424:	eb 14                	jmp    43a <strchr+0x22>
    if(*s == c)
 426:	8b 45 08             	mov    0x8(%ebp),%eax
 429:	0f b6 00             	movzbl (%eax),%eax
 42c:	38 45 fc             	cmp    %al,-0x4(%ebp)
 42f:	75 05                	jne    436 <strchr+0x1e>
      return (char*)s;
 431:	8b 45 08             	mov    0x8(%ebp),%eax
 434:	eb 13                	jmp    449 <strchr+0x31>
  for(; *s; s++)
 436:	83 45 08 01          	addl   $0x1,0x8(%ebp)
 43a:	8b 45 08             	mov    0x8(%ebp),%eax
 43d:	0f b6 00             	movzbl (%eax),%eax
 440:	84 c0                	test   %al,%al
 442:	75 e2                	jne    426 <strchr+0xe>
  return 0;
 444:	b8 00 00 00 00       	mov    $0x0,%eax
}
 449:	c9                   	leave  
 44a:	c3                   	ret    

0000044b <gets>:

char*
gets(char *buf, int max)
{
 44b:	55                   	push   %ebp
 44c:	89 e5                	mov    %esp,%ebp
 44e:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 451:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 458:	eb 42                	jmp    49c <gets+0x51>
    cc = read(0, &c, 1);
 45a:	83 ec 04             	sub    $0x4,%esp
 45d:	6a 01                	push   $0x1
 45f:	8d 45 ef             	lea    -0x11(%ebp),%eax
 462:	50                   	push   %eax
 463:	6a 00                	push   $0x0
 465:	e8 a2 01 00 00       	call   60c <read>
 46a:	83 c4 10             	add    $0x10,%esp
 46d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
 470:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 474:	7e 33                	jle    4a9 <gets+0x5e>
      break;
    buf[i++] = c;
 476:	8b 45 f4             	mov    -0xc(%ebp),%eax
 479:	8d 50 01             	lea    0x1(%eax),%edx
 47c:	89 55 f4             	mov    %edx,-0xc(%ebp)
 47f:	89 c2                	mov    %eax,%edx
 481:	8b 45 08             	mov    0x8(%ebp),%eax
 484:	01 c2                	add    %eax,%edx
 486:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 48a:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
 48c:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 490:	3c 0a                	cmp    $0xa,%al
 492:	74 16                	je     4aa <gets+0x5f>
 494:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
 498:	3c 0d                	cmp    $0xd,%al
 49a:	74 0e                	je     4aa <gets+0x5f>
  for(i=0; i+1 < max; ){
 49c:	8b 45 f4             	mov    -0xc(%ebp),%eax
 49f:	83 c0 01             	add    $0x1,%eax
 4a2:	39 45 0c             	cmp    %eax,0xc(%ebp)
 4a5:	7f b3                	jg     45a <gets+0xf>
 4a7:	eb 01                	jmp    4aa <gets+0x5f>
      break;
 4a9:	90                   	nop
      break;
  }
  buf[i] = '\0';
 4aa:	8b 55 f4             	mov    -0xc(%ebp),%edx
 4ad:	8b 45 08             	mov    0x8(%ebp),%eax
 4b0:	01 d0                	add    %edx,%eax
 4b2:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
 4b5:	8b 45 08             	mov    0x8(%ebp),%eax
}
 4b8:	c9                   	leave  
 4b9:	c3                   	ret    

000004ba <stat>:

int
stat(const char *n, struct stat *st)
{
 4ba:	55                   	push   %ebp
 4bb:	89 e5                	mov    %esp,%ebp
 4bd:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 4c0:	83 ec 08             	sub    $0x8,%esp
 4c3:	6a 00                	push   $0x0
 4c5:	ff 75 08             	push   0x8(%ebp)
 4c8:	e8 67 01 00 00       	call   634 <open>
 4cd:	83 c4 10             	add    $0x10,%esp
 4d0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
 4d3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 4d7:	79 07                	jns    4e0 <stat+0x26>
    return -1;
 4d9:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
 4de:	eb 25                	jmp    505 <stat+0x4b>
  r = fstat(fd, st);
 4e0:	83 ec 08             	sub    $0x8,%esp
 4e3:	ff 75 0c             	push   0xc(%ebp)
 4e6:	ff 75 f4             	push   -0xc(%ebp)
 4e9:	e8 5e 01 00 00       	call   64c <fstat>
 4ee:	83 c4 10             	add    $0x10,%esp
 4f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
 4f4:	83 ec 0c             	sub    $0xc,%esp
 4f7:	ff 75 f4             	push   -0xc(%ebp)
 4fa:	e8 1d 01 00 00       	call   61c <close>
 4ff:	83 c4 10             	add    $0x10,%esp
  return r;
 502:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
 505:	c9                   	leave  
 506:	c3                   	ret    

00000507 <atoi>:

int
atoi(const char *s)
{
 507:	55                   	push   %ebp
 508:	89 e5                	mov    %esp,%ebp
 50a:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
 50d:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 514:	eb 25                	jmp    53b <atoi+0x34>
    n = n*10 + *s++ - '0';
 516:	8b 55 fc             	mov    -0x4(%ebp),%edx
 519:	89 d0                	mov    %edx,%eax
 51b:	c1 e0 02             	shl    $0x2,%eax
 51e:	01 d0                	add    %edx,%eax
 520:	01 c0                	add    %eax,%eax
 522:	89 c1                	mov    %eax,%ecx
 524:	8b 45 08             	mov    0x8(%ebp),%eax
 527:	8d 50 01             	lea    0x1(%eax),%edx
 52a:	89 55 08             	mov    %edx,0x8(%ebp)
 52d:	0f b6 00             	movzbl (%eax),%eax
 530:	0f be c0             	movsbl %al,%eax
 533:	01 c8                	add    %ecx,%eax
 535:	83 e8 30             	sub    $0x30,%eax
 538:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
 53b:	8b 45 08             	mov    0x8(%ebp),%eax
 53e:	0f b6 00             	movzbl (%eax),%eax
 541:	3c 2f                	cmp    $0x2f,%al
 543:	7e 0a                	jle    54f <atoi+0x48>
 545:	8b 45 08             	mov    0x8(%ebp),%eax
 548:	0f b6 00             	movzbl (%eax),%eax
 54b:	3c 39                	cmp    $0x39,%al
 54d:	7e c7                	jle    516 <atoi+0xf>
  return n;
 54f:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
 552:	c9                   	leave  
 553:	c3                   	ret    

00000554 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 554:	55                   	push   %ebp
 555:	89 e5                	mov    %esp,%ebp
 557:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
 55a:	8b 45 08             	mov    0x8(%ebp),%eax
 55d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
 560:	8b 45 0c             	mov    0xc(%ebp),%eax
 563:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
 566:	eb 17                	jmp    57f <memmove+0x2b>
    *dst++ = *src++;
 568:	8b 55 f8             	mov    -0x8(%ebp),%edx
 56b:	8d 42 01             	lea    0x1(%edx),%eax
 56e:	89 45 f8             	mov    %eax,-0x8(%ebp)
 571:	8b 45 fc             	mov    -0x4(%ebp),%eax
 574:	8d 48 01             	lea    0x1(%eax),%ecx
 577:	89 4d fc             	mov    %ecx,-0x4(%ebp)
 57a:	0f b6 12             	movzbl (%edx),%edx
 57d:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
 57f:	8b 45 10             	mov    0x10(%ebp),%eax
 582:	8d 50 ff             	lea    -0x1(%eax),%edx
 585:	89 55 10             	mov    %edx,0x10(%ebp)
 588:	85 c0                	test   %eax,%eax
 58a:	7f dc                	jg     568 <memmove+0x14>
  return vdst;
 58c:	8b 45 08             	mov    0x8(%ebp),%eax
}
 58f:	c9                   	leave  
 590:	c3                   	ret    

00000591 <calc>:

int calc(int num)
{
 591:	55                   	push   %ebp
 592:	89 e5                	mov    %esp,%ebp
 594:	83 ec 10             	sub    $0x10,%esp
    int c = 0;
 597:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for(uint i = 0; i < num; i++)
 59e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
 5a5:	eb 36                	jmp    5dd <calc+0x4c>
    {
        for(uint j = 0; j < num; j++)
 5a7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
 5ae:	eb 21                	jmp    5d1 <calc+0x40>
        {
            for(uint k = 0; k < num; j++)
 5b0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 5b7:	eb 0c                	jmp    5c5 <calc+0x34>
            {
                c >>= 10;
 5b9:	c1 7d fc 0a          	sarl   $0xa,-0x4(%ebp)
                c <<= 10;
 5bd:	c1 65 fc 0a          	shll   $0xa,-0x4(%ebp)
            for(uint k = 0; k < num; j++)
 5c1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 5c5:	8b 45 08             	mov    0x8(%ebp),%eax
 5c8:	39 45 f0             	cmp    %eax,-0x10(%ebp)
 5cb:	72 ec                	jb     5b9 <calc+0x28>
        for(uint j = 0; j < num; j++)
 5cd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
 5d1:	8b 45 08             	mov    0x8(%ebp),%eax
 5d4:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 5d7:	72 d7                	jb     5b0 <calc+0x1f>
    for(uint i = 0; i < num; i++)
 5d9:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
 5dd:	8b 45 08             	mov    0x8(%ebp),%eax
 5e0:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 5e3:	72 c2                	jb     5a7 <calc+0x16>
            }
        }
    }
    return 0;
 5e5:	b8 00 00 00 00       	mov    $0x0,%eax
}
 5ea:	c9                   	leave  
 5eb:	c3                   	ret    

000005ec <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5ec:	b8 01 00 00 00       	mov    $0x1,%eax
 5f1:	cd 40                	int    $0x40
 5f3:	c3                   	ret    

000005f4 <exit>:
SYSCALL(exit)
 5f4:	b8 02 00 00 00       	mov    $0x2,%eax
 5f9:	cd 40                	int    $0x40
 5fb:	c3                   	ret    

000005fc <wait>:
SYSCALL(wait)
 5fc:	b8 03 00 00 00       	mov    $0x3,%eax
 601:	cd 40                	int    $0x40
 603:	c3                   	ret    

00000604 <pipe>:
SYSCALL(pipe)
 604:	b8 04 00 00 00       	mov    $0x4,%eax
 609:	cd 40                	int    $0x40
 60b:	c3                   	ret    

0000060c <read>:
SYSCALL(read)
 60c:	b8 05 00 00 00       	mov    $0x5,%eax
 611:	cd 40                	int    $0x40
 613:	c3                   	ret    

00000614 <write>:
SYSCALL(write)
 614:	b8 10 00 00 00       	mov    $0x10,%eax
 619:	cd 40                	int    $0x40
 61b:	c3                   	ret    

0000061c <close>:
SYSCALL(close)
 61c:	b8 15 00 00 00       	mov    $0x15,%eax
 621:	cd 40                	int    $0x40
 623:	c3                   	ret    

00000624 <kill>:
SYSCALL(kill)
 624:	b8 06 00 00 00       	mov    $0x6,%eax
 629:	cd 40                	int    $0x40
 62b:	c3                   	ret    

0000062c <exec>:
SYSCALL(exec)
 62c:	b8 07 00 00 00       	mov    $0x7,%eax
 631:	cd 40                	int    $0x40
 633:	c3                   	ret    

00000634 <open>:
SYSCALL(open)
 634:	b8 0f 00 00 00       	mov    $0xf,%eax
 639:	cd 40                	int    $0x40
 63b:	c3                   	ret    

0000063c <mknod>:
SYSCALL(mknod)
 63c:	b8 11 00 00 00       	mov    $0x11,%eax
 641:	cd 40                	int    $0x40
 643:	c3                   	ret    

00000644 <unlink>:
SYSCALL(unlink)
 644:	b8 12 00 00 00       	mov    $0x12,%eax
 649:	cd 40                	int    $0x40
 64b:	c3                   	ret    

0000064c <fstat>:
SYSCALL(fstat)
 64c:	b8 08 00 00 00       	mov    $0x8,%eax
 651:	cd 40                	int    $0x40
 653:	c3                   	ret    

00000654 <link>:
SYSCALL(link)
 654:	b8 13 00 00 00       	mov    $0x13,%eax
 659:	cd 40                	int    $0x40
 65b:	c3                   	ret    

0000065c <mkdir>:
SYSCALL(mkdir)
 65c:	b8 14 00 00 00       	mov    $0x14,%eax
 661:	cd 40                	int    $0x40
 663:	c3                   	ret    

00000664 <chdir>:
SYSCALL(chdir)
 664:	b8 09 00 00 00       	mov    $0x9,%eax
 669:	cd 40                	int    $0x40
 66b:	c3                   	ret    

0000066c <dup>:
SYSCALL(dup)
 66c:	b8 0a 00 00 00       	mov    $0xa,%eax
 671:	cd 40                	int    $0x40
 673:	c3                   	ret    

00000674 <getpid>:
SYSCALL(getpid)
 674:	b8 0b 00 00 00       	mov    $0xb,%eax
 679:	cd 40                	int    $0x40
 67b:	c3                   	ret    

0000067c <sbrk>:
SYSCALL(sbrk)
 67c:	b8 0c 00 00 00       	mov    $0xc,%eax
 681:	cd 40                	int    $0x40
 683:	c3                   	ret    

00000684 <sleep>:
SYSCALL(sleep)
 684:	b8 0d 00 00 00       	mov    $0xd,%eax
 689:	cd 40                	int    $0x40
 68b:	c3                   	ret    

0000068c <uptime>:
SYSCALL(uptime)
 68c:	b8 0e 00 00 00       	mov    $0xe,%eax
 691:	cd 40                	int    $0x40
 693:	c3                   	ret    

00000694 <print_proc>:
SYSCALL(print_proc)
 694:	b8 16 00 00 00       	mov    $0x16,%eax
 699:	cd 40                	int    $0x40
 69b:	c3                   	ret    

0000069c <change_queue>:
SYSCALL(change_queue)
 69c:	b8 17 00 00 00       	mov    $0x17,%eax
 6a1:	cd 40                	int    $0x40
 6a3:	c3                   	ret    

000006a4 <change_local_bjf>:
SYSCALL(change_local_bjf)
 6a4:	b8 18 00 00 00       	mov    $0x18,%eax
 6a9:	cd 40                	int    $0x40
 6ab:	c3                   	ret    

000006ac <change_global_bjf>:
SYSCALL(change_global_bjf)
 6ac:	b8 19 00 00 00       	mov    $0x19,%eax
 6b1:	cd 40                	int    $0x40
 6b3:	c3                   	ret    

000006b4 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
 6b4:	55                   	push   %ebp
 6b5:	89 e5                	mov    %esp,%ebp
 6b7:	83 ec 18             	sub    $0x18,%esp
 6ba:	8b 45 0c             	mov    0xc(%ebp),%eax
 6bd:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
 6c0:	83 ec 04             	sub    $0x4,%esp
 6c3:	6a 01                	push   $0x1
 6c5:	8d 45 f4             	lea    -0xc(%ebp),%eax
 6c8:	50                   	push   %eax
 6c9:	ff 75 08             	push   0x8(%ebp)
 6cc:	e8 43 ff ff ff       	call   614 <write>
 6d1:	83 c4 10             	add    $0x10,%esp
}
 6d4:	90                   	nop
 6d5:	c9                   	leave  
 6d6:	c3                   	ret    

000006d7 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
 6d7:	55                   	push   %ebp
 6d8:	89 e5                	mov    %esp,%ebp
 6da:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
 6dd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
 6e4:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
 6e8:	74 17                	je     701 <printint+0x2a>
 6ea:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
 6ee:	79 11                	jns    701 <printint+0x2a>
    neg = 1;
 6f0:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
 6f7:	8b 45 0c             	mov    0xc(%ebp),%eax
 6fa:	f7 d8                	neg    %eax
 6fc:	89 45 ec             	mov    %eax,-0x14(%ebp)
 6ff:	eb 06                	jmp    707 <printint+0x30>
  } else {
    x = xx;
 701:	8b 45 0c             	mov    0xc(%ebp),%eax
 704:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
 707:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
 70e:	8b 4d 10             	mov    0x10(%ebp),%ecx
 711:	8b 45 ec             	mov    -0x14(%ebp),%eax
 714:	ba 00 00 00 00       	mov    $0x0,%edx
 719:	f7 f1                	div    %ecx
 71b:	89 d1                	mov    %edx,%ecx
 71d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 720:	8d 50 01             	lea    0x1(%eax),%edx
 723:	89 55 f4             	mov    %edx,-0xc(%ebp)
 726:	0f b6 91 4c 0e 00 00 	movzbl 0xe4c(%ecx),%edx
 72d:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
 731:	8b 4d 10             	mov    0x10(%ebp),%ecx
 734:	8b 45 ec             	mov    -0x14(%ebp),%eax
 737:	ba 00 00 00 00       	mov    $0x0,%edx
 73c:	f7 f1                	div    %ecx
 73e:	89 45 ec             	mov    %eax,-0x14(%ebp)
 741:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 745:	75 c7                	jne    70e <printint+0x37>
  if(neg)
 747:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 74b:	74 2d                	je     77a <printint+0xa3>
    buf[i++] = '-';
 74d:	8b 45 f4             	mov    -0xc(%ebp),%eax
 750:	8d 50 01             	lea    0x1(%eax),%edx
 753:	89 55 f4             	mov    %edx,-0xc(%ebp)
 756:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
 75b:	eb 1d                	jmp    77a <printint+0xa3>
    putc(fd, buf[i]);
 75d:	8d 55 dc             	lea    -0x24(%ebp),%edx
 760:	8b 45 f4             	mov    -0xc(%ebp),%eax
 763:	01 d0                	add    %edx,%eax
 765:	0f b6 00             	movzbl (%eax),%eax
 768:	0f be c0             	movsbl %al,%eax
 76b:	83 ec 08             	sub    $0x8,%esp
 76e:	50                   	push   %eax
 76f:	ff 75 08             	push   0x8(%ebp)
 772:	e8 3d ff ff ff       	call   6b4 <putc>
 777:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
 77a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
 77e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 782:	79 d9                	jns    75d <printint+0x86>
}
 784:	90                   	nop
 785:	90                   	nop
 786:	c9                   	leave  
 787:	c3                   	ret    

00000788 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 788:	55                   	push   %ebp
 789:	89 e5                	mov    %esp,%ebp
 78b:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
 78e:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
 795:	8d 45 0c             	lea    0xc(%ebp),%eax
 798:	83 c0 04             	add    $0x4,%eax
 79b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
 79e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
 7a5:	e9 59 01 00 00       	jmp    903 <printf+0x17b>
    c = fmt[i] & 0xff;
 7aa:	8b 55 0c             	mov    0xc(%ebp),%edx
 7ad:	8b 45 f0             	mov    -0x10(%ebp),%eax
 7b0:	01 d0                	add    %edx,%eax
 7b2:	0f b6 00             	movzbl (%eax),%eax
 7b5:	0f be c0             	movsbl %al,%eax
 7b8:	25 ff 00 00 00       	and    $0xff,%eax
 7bd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
 7c0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
 7c4:	75 2c                	jne    7f2 <printf+0x6a>
      if(c == '%'){
 7c6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 7ca:	75 0c                	jne    7d8 <printf+0x50>
        state = '%';
 7cc:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
 7d3:	e9 27 01 00 00       	jmp    8ff <printf+0x177>
      } else {
        putc(fd, c);
 7d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 7db:	0f be c0             	movsbl %al,%eax
 7de:	83 ec 08             	sub    $0x8,%esp
 7e1:	50                   	push   %eax
 7e2:	ff 75 08             	push   0x8(%ebp)
 7e5:	e8 ca fe ff ff       	call   6b4 <putc>
 7ea:	83 c4 10             	add    $0x10,%esp
 7ed:	e9 0d 01 00 00       	jmp    8ff <printf+0x177>
      }
    } else if(state == '%'){
 7f2:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
 7f6:	0f 85 03 01 00 00    	jne    8ff <printf+0x177>
      if(c == 'd'){
 7fc:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
 800:	75 1e                	jne    820 <printf+0x98>
        printint(fd, *ap, 10, 1);
 802:	8b 45 e8             	mov    -0x18(%ebp),%eax
 805:	8b 00                	mov    (%eax),%eax
 807:	6a 01                	push   $0x1
 809:	6a 0a                	push   $0xa
 80b:	50                   	push   %eax
 80c:	ff 75 08             	push   0x8(%ebp)
 80f:	e8 c3 fe ff ff       	call   6d7 <printint>
 814:	83 c4 10             	add    $0x10,%esp
        ap++;
 817:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 81b:	e9 d8 00 00 00       	jmp    8f8 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
 820:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
 824:	74 06                	je     82c <printf+0xa4>
 826:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
 82a:	75 1e                	jne    84a <printf+0xc2>
        printint(fd, *ap, 16, 0);
 82c:	8b 45 e8             	mov    -0x18(%ebp),%eax
 82f:	8b 00                	mov    (%eax),%eax
 831:	6a 00                	push   $0x0
 833:	6a 10                	push   $0x10
 835:	50                   	push   %eax
 836:	ff 75 08             	push   0x8(%ebp)
 839:	e8 99 fe ff ff       	call   6d7 <printint>
 83e:	83 c4 10             	add    $0x10,%esp
        ap++;
 841:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 845:	e9 ae 00 00 00       	jmp    8f8 <printf+0x170>
      } else if(c == 's'){
 84a:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
 84e:	75 43                	jne    893 <printf+0x10b>
        s = (char*)*ap;
 850:	8b 45 e8             	mov    -0x18(%ebp),%eax
 853:	8b 00                	mov    (%eax),%eax
 855:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
 858:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
 85c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 860:	75 25                	jne    887 <printf+0xff>
          s = "(null)";
 862:	c7 45 f4 89 0b 00 00 	movl   $0xb89,-0xc(%ebp)
        while(*s != 0){
 869:	eb 1c                	jmp    887 <printf+0xff>
          putc(fd, *s);
 86b:	8b 45 f4             	mov    -0xc(%ebp),%eax
 86e:	0f b6 00             	movzbl (%eax),%eax
 871:	0f be c0             	movsbl %al,%eax
 874:	83 ec 08             	sub    $0x8,%esp
 877:	50                   	push   %eax
 878:	ff 75 08             	push   0x8(%ebp)
 87b:	e8 34 fe ff ff       	call   6b4 <putc>
 880:	83 c4 10             	add    $0x10,%esp
          s++;
 883:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
 887:	8b 45 f4             	mov    -0xc(%ebp),%eax
 88a:	0f b6 00             	movzbl (%eax),%eax
 88d:	84 c0                	test   %al,%al
 88f:	75 da                	jne    86b <printf+0xe3>
 891:	eb 65                	jmp    8f8 <printf+0x170>
        }
      } else if(c == 'c'){
 893:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
 897:	75 1d                	jne    8b6 <printf+0x12e>
        putc(fd, *ap);
 899:	8b 45 e8             	mov    -0x18(%ebp),%eax
 89c:	8b 00                	mov    (%eax),%eax
 89e:	0f be c0             	movsbl %al,%eax
 8a1:	83 ec 08             	sub    $0x8,%esp
 8a4:	50                   	push   %eax
 8a5:	ff 75 08             	push   0x8(%ebp)
 8a8:	e8 07 fe ff ff       	call   6b4 <putc>
 8ad:	83 c4 10             	add    $0x10,%esp
        ap++;
 8b0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
 8b4:	eb 42                	jmp    8f8 <printf+0x170>
      } else if(c == '%'){
 8b6:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
 8ba:	75 17                	jne    8d3 <printf+0x14b>
        putc(fd, c);
 8bc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8bf:	0f be c0             	movsbl %al,%eax
 8c2:	83 ec 08             	sub    $0x8,%esp
 8c5:	50                   	push   %eax
 8c6:	ff 75 08             	push   0x8(%ebp)
 8c9:	e8 e6 fd ff ff       	call   6b4 <putc>
 8ce:	83 c4 10             	add    $0x10,%esp
 8d1:	eb 25                	jmp    8f8 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 8d3:	83 ec 08             	sub    $0x8,%esp
 8d6:	6a 25                	push   $0x25
 8d8:	ff 75 08             	push   0x8(%ebp)
 8db:	e8 d4 fd ff ff       	call   6b4 <putc>
 8e0:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
 8e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
 8e6:	0f be c0             	movsbl %al,%eax
 8e9:	83 ec 08             	sub    $0x8,%esp
 8ec:	50                   	push   %eax
 8ed:	ff 75 08             	push   0x8(%ebp)
 8f0:	e8 bf fd ff ff       	call   6b4 <putc>
 8f5:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 8f8:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
 8ff:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
 903:	8b 55 0c             	mov    0xc(%ebp),%edx
 906:	8b 45 f0             	mov    -0x10(%ebp),%eax
 909:	01 d0                	add    %edx,%eax
 90b:	0f b6 00             	movzbl (%eax),%eax
 90e:	84 c0                	test   %al,%al
 910:	0f 85 94 fe ff ff    	jne    7aa <printf+0x22>
    }
  }
}
 916:	90                   	nop
 917:	90                   	nop
 918:	c9                   	leave  
 919:	c3                   	ret    

0000091a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 91a:	55                   	push   %ebp
 91b:	89 e5                	mov    %esp,%ebp
 91d:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
 920:	8b 45 08             	mov    0x8(%ebp),%eax
 923:	83 e8 08             	sub    $0x8,%eax
 926:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 929:	a1 78 0e 00 00       	mov    0xe78,%eax
 92e:	89 45 fc             	mov    %eax,-0x4(%ebp)
 931:	eb 24                	jmp    957 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 933:	8b 45 fc             	mov    -0x4(%ebp),%eax
 936:	8b 00                	mov    (%eax),%eax
 938:	39 45 fc             	cmp    %eax,-0x4(%ebp)
 93b:	72 12                	jb     94f <free+0x35>
 93d:	8b 45 f8             	mov    -0x8(%ebp),%eax
 940:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 943:	77 24                	ja     969 <free+0x4f>
 945:	8b 45 fc             	mov    -0x4(%ebp),%eax
 948:	8b 00                	mov    (%eax),%eax
 94a:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 94d:	72 1a                	jb     969 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 94f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 952:	8b 00                	mov    (%eax),%eax
 954:	89 45 fc             	mov    %eax,-0x4(%ebp)
 957:	8b 45 f8             	mov    -0x8(%ebp),%eax
 95a:	3b 45 fc             	cmp    -0x4(%ebp),%eax
 95d:	76 d4                	jbe    933 <free+0x19>
 95f:	8b 45 fc             	mov    -0x4(%ebp),%eax
 962:	8b 00                	mov    (%eax),%eax
 964:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 967:	73 ca                	jae    933 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
 969:	8b 45 f8             	mov    -0x8(%ebp),%eax
 96c:	8b 40 04             	mov    0x4(%eax),%eax
 96f:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 976:	8b 45 f8             	mov    -0x8(%ebp),%eax
 979:	01 c2                	add    %eax,%edx
 97b:	8b 45 fc             	mov    -0x4(%ebp),%eax
 97e:	8b 00                	mov    (%eax),%eax
 980:	39 c2                	cmp    %eax,%edx
 982:	75 24                	jne    9a8 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
 984:	8b 45 f8             	mov    -0x8(%ebp),%eax
 987:	8b 50 04             	mov    0x4(%eax),%edx
 98a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 98d:	8b 00                	mov    (%eax),%eax
 98f:	8b 40 04             	mov    0x4(%eax),%eax
 992:	01 c2                	add    %eax,%edx
 994:	8b 45 f8             	mov    -0x8(%ebp),%eax
 997:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
 99a:	8b 45 fc             	mov    -0x4(%ebp),%eax
 99d:	8b 00                	mov    (%eax),%eax
 99f:	8b 10                	mov    (%eax),%edx
 9a1:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9a4:	89 10                	mov    %edx,(%eax)
 9a6:	eb 0a                	jmp    9b2 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
 9a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9ab:	8b 10                	mov    (%eax),%edx
 9ad:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9b0:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
 9b2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9b5:	8b 40 04             	mov    0x4(%eax),%eax
 9b8:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
 9bf:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9c2:	01 d0                	add    %edx,%eax
 9c4:	39 45 f8             	cmp    %eax,-0x8(%ebp)
 9c7:	75 20                	jne    9e9 <free+0xcf>
    p->s.size += bp->s.size;
 9c9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9cc:	8b 50 04             	mov    0x4(%eax),%edx
 9cf:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9d2:	8b 40 04             	mov    0x4(%eax),%eax
 9d5:	01 c2                	add    %eax,%edx
 9d7:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9da:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9dd:	8b 45 f8             	mov    -0x8(%ebp),%eax
 9e0:	8b 10                	mov    (%eax),%edx
 9e2:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9e5:	89 10                	mov    %edx,(%eax)
 9e7:	eb 08                	jmp    9f1 <free+0xd7>
  } else
    p->s.ptr = bp;
 9e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9ec:	8b 55 f8             	mov    -0x8(%ebp),%edx
 9ef:	89 10                	mov    %edx,(%eax)
  freep = p;
 9f1:	8b 45 fc             	mov    -0x4(%ebp),%eax
 9f4:	a3 78 0e 00 00       	mov    %eax,0xe78
}
 9f9:	90                   	nop
 9fa:	c9                   	leave  
 9fb:	c3                   	ret    

000009fc <morecore>:

static Header*
morecore(uint nu)
{
 9fc:	55                   	push   %ebp
 9fd:	89 e5                	mov    %esp,%ebp
 9ff:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
 a02:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
 a09:	77 07                	ja     a12 <morecore+0x16>
    nu = 4096;
 a0b:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
 a12:	8b 45 08             	mov    0x8(%ebp),%eax
 a15:	c1 e0 03             	shl    $0x3,%eax
 a18:	83 ec 0c             	sub    $0xc,%esp
 a1b:	50                   	push   %eax
 a1c:	e8 5b fc ff ff       	call   67c <sbrk>
 a21:	83 c4 10             	add    $0x10,%esp
 a24:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
 a27:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
 a2b:	75 07                	jne    a34 <morecore+0x38>
    return 0;
 a2d:	b8 00 00 00 00       	mov    $0x0,%eax
 a32:	eb 26                	jmp    a5a <morecore+0x5e>
  hp = (Header*)p;
 a34:	8b 45 f4             	mov    -0xc(%ebp),%eax
 a37:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
 a3a:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a3d:	8b 55 08             	mov    0x8(%ebp),%edx
 a40:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
 a43:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a46:	83 c0 08             	add    $0x8,%eax
 a49:	83 ec 0c             	sub    $0xc,%esp
 a4c:	50                   	push   %eax
 a4d:	e8 c8 fe ff ff       	call   91a <free>
 a52:	83 c4 10             	add    $0x10,%esp
  return freep;
 a55:	a1 78 0e 00 00       	mov    0xe78,%eax
}
 a5a:	c9                   	leave  
 a5b:	c3                   	ret    

00000a5c <malloc>:

void*
malloc(uint nbytes)
{
 a5c:	55                   	push   %ebp
 a5d:	89 e5                	mov    %esp,%ebp
 a5f:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a62:	8b 45 08             	mov    0x8(%ebp),%eax
 a65:	83 c0 07             	add    $0x7,%eax
 a68:	c1 e8 03             	shr    $0x3,%eax
 a6b:	83 c0 01             	add    $0x1,%eax
 a6e:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
 a71:	a1 78 0e 00 00       	mov    0xe78,%eax
 a76:	89 45 f0             	mov    %eax,-0x10(%ebp)
 a79:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
 a7d:	75 23                	jne    aa2 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
 a7f:	c7 45 f0 70 0e 00 00 	movl   $0xe70,-0x10(%ebp)
 a86:	8b 45 f0             	mov    -0x10(%ebp),%eax
 a89:	a3 78 0e 00 00       	mov    %eax,0xe78
 a8e:	a1 78 0e 00 00       	mov    0xe78,%eax
 a93:	a3 70 0e 00 00       	mov    %eax,0xe70
    base.s.size = 0;
 a98:	c7 05 74 0e 00 00 00 	movl   $0x0,0xe74
 a9f:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aa2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 aa5:	8b 00                	mov    (%eax),%eax
 aa7:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 aaa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aad:	8b 40 04             	mov    0x4(%eax),%eax
 ab0:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 ab3:	77 4d                	ja     b02 <malloc+0xa6>
      if(p->s.size == nunits)
 ab5:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ab8:	8b 40 04             	mov    0x4(%eax),%eax
 abb:	39 45 ec             	cmp    %eax,-0x14(%ebp)
 abe:	75 0c                	jne    acc <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
 ac0:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ac3:	8b 10                	mov    (%eax),%edx
 ac5:	8b 45 f0             	mov    -0x10(%ebp),%eax
 ac8:	89 10                	mov    %edx,(%eax)
 aca:	eb 26                	jmp    af2 <malloc+0x96>
      else {
        p->s.size -= nunits;
 acc:	8b 45 f4             	mov    -0xc(%ebp),%eax
 acf:	8b 40 04             	mov    0x4(%eax),%eax
 ad2:	2b 45 ec             	sub    -0x14(%ebp),%eax
 ad5:	89 c2                	mov    %eax,%edx
 ad7:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ada:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
 add:	8b 45 f4             	mov    -0xc(%ebp),%eax
 ae0:	8b 40 04             	mov    0x4(%eax),%eax
 ae3:	c1 e0 03             	shl    $0x3,%eax
 ae6:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
 ae9:	8b 45 f4             	mov    -0xc(%ebp),%eax
 aec:	8b 55 ec             	mov    -0x14(%ebp),%edx
 aef:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
 af2:	8b 45 f0             	mov    -0x10(%ebp),%eax
 af5:	a3 78 0e 00 00       	mov    %eax,0xe78
      return (void*)(p + 1);
 afa:	8b 45 f4             	mov    -0xc(%ebp),%eax
 afd:	83 c0 08             	add    $0x8,%eax
 b00:	eb 3b                	jmp    b3d <malloc+0xe1>
    }
    if(p == freep)
 b02:	a1 78 0e 00 00       	mov    0xe78,%eax
 b07:	39 45 f4             	cmp    %eax,-0xc(%ebp)
 b0a:	75 1e                	jne    b2a <malloc+0xce>
      if((p = morecore(nunits)) == 0)
 b0c:	83 ec 0c             	sub    $0xc,%esp
 b0f:	ff 75 ec             	push   -0x14(%ebp)
 b12:	e8 e5 fe ff ff       	call   9fc <morecore>
 b17:	83 c4 10             	add    $0x10,%esp
 b1a:	89 45 f4             	mov    %eax,-0xc(%ebp)
 b1d:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
 b21:	75 07                	jne    b2a <malloc+0xce>
        return 0;
 b23:	b8 00 00 00 00       	mov    $0x0,%eax
 b28:	eb 13                	jmp    b3d <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b2d:	89 45 f0             	mov    %eax,-0x10(%ebp)
 b30:	8b 45 f4             	mov    -0xc(%ebp),%eax
 b33:	8b 00                	mov    (%eax),%eax
 b35:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
 b38:	e9 6d ff ff ff       	jmp    aaa <malloc+0x4e>
  }
}
 b3d:	c9                   	leave  
 b3e:	c3                   	ret    
