
_usertests:     file format elf32-i386


Disassembly of section .text:

00000000 <iputtest>:
int stdout = 1;

// does chdir() call iput(p->cwd) in a transaction?
void
iputtest(void)
{
       0:	55                   	push   %ebp
       1:	89 e5                	mov    %esp,%ebp
       3:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "iput test\n");
       6:	a1 18 65 00 00       	mov    0x6518,%eax
       b:	83 ec 08             	sub    $0x8,%esp
       e:	68 b6 45 00 00       	push   $0x45b6
      13:	50                   	push   %eax
      14:	e8 ce 41 00 00       	call   41e7 <printf>
      19:	83 c4 10             	add    $0x10,%esp

  if(mkdir("iputdir") < 0){
      1c:	83 ec 0c             	sub    $0xc,%esp
      1f:	68 c1 45 00 00       	push   $0x45c1
      24:	e8 a2 40 00 00       	call   40cb <mkdir>
      29:	83 c4 10             	add    $0x10,%esp
      2c:	85 c0                	test   %eax,%eax
      2e:	79 1b                	jns    4b <iputtest+0x4b>
    printf(stdout, "mkdir failed\n");
      30:	a1 18 65 00 00       	mov    0x6518,%eax
      35:	83 ec 08             	sub    $0x8,%esp
      38:	68 c9 45 00 00       	push   $0x45c9
      3d:	50                   	push   %eax
      3e:	e8 a4 41 00 00       	call   41e7 <printf>
      43:	83 c4 10             	add    $0x10,%esp
    exit();
      46:	e8 18 40 00 00       	call   4063 <exit>
  }
  if(chdir("iputdir") < 0){
      4b:	83 ec 0c             	sub    $0xc,%esp
      4e:	68 c1 45 00 00       	push   $0x45c1
      53:	e8 7b 40 00 00       	call   40d3 <chdir>
      58:	83 c4 10             	add    $0x10,%esp
      5b:	85 c0                	test   %eax,%eax
      5d:	79 1b                	jns    7a <iputtest+0x7a>
    printf(stdout, "chdir iputdir failed\n");
      5f:	a1 18 65 00 00       	mov    0x6518,%eax
      64:	83 ec 08             	sub    $0x8,%esp
      67:	68 d7 45 00 00       	push   $0x45d7
      6c:	50                   	push   %eax
      6d:	e8 75 41 00 00       	call   41e7 <printf>
      72:	83 c4 10             	add    $0x10,%esp
    exit();
      75:	e8 e9 3f 00 00       	call   4063 <exit>
  }
  if(unlink("../iputdir") < 0){
      7a:	83 ec 0c             	sub    $0xc,%esp
      7d:	68 ed 45 00 00       	push   $0x45ed
      82:	e8 2c 40 00 00       	call   40b3 <unlink>
      87:	83 c4 10             	add    $0x10,%esp
      8a:	85 c0                	test   %eax,%eax
      8c:	79 1b                	jns    a9 <iputtest+0xa9>
    printf(stdout, "unlink ../iputdir failed\n");
      8e:	a1 18 65 00 00       	mov    0x6518,%eax
      93:	83 ec 08             	sub    $0x8,%esp
      96:	68 f8 45 00 00       	push   $0x45f8
      9b:	50                   	push   %eax
      9c:	e8 46 41 00 00       	call   41e7 <printf>
      a1:	83 c4 10             	add    $0x10,%esp
    exit();
      a4:	e8 ba 3f 00 00       	call   4063 <exit>
  }
  if(chdir("/") < 0){
      a9:	83 ec 0c             	sub    $0xc,%esp
      ac:	68 12 46 00 00       	push   $0x4612
      b1:	e8 1d 40 00 00       	call   40d3 <chdir>
      b6:	83 c4 10             	add    $0x10,%esp
      b9:	85 c0                	test   %eax,%eax
      bb:	79 1b                	jns    d8 <iputtest+0xd8>
    printf(stdout, "chdir / failed\n");
      bd:	a1 18 65 00 00       	mov    0x6518,%eax
      c2:	83 ec 08             	sub    $0x8,%esp
      c5:	68 14 46 00 00       	push   $0x4614
      ca:	50                   	push   %eax
      cb:	e8 17 41 00 00       	call   41e7 <printf>
      d0:	83 c4 10             	add    $0x10,%esp
    exit();
      d3:	e8 8b 3f 00 00       	call   4063 <exit>
  }
  printf(stdout, "iput test ok\n");
      d8:	a1 18 65 00 00       	mov    0x6518,%eax
      dd:	83 ec 08             	sub    $0x8,%esp
      e0:	68 24 46 00 00       	push   $0x4624
      e5:	50                   	push   %eax
      e6:	e8 fc 40 00 00       	call   41e7 <printf>
      eb:	83 c4 10             	add    $0x10,%esp
}
      ee:	90                   	nop
      ef:	c9                   	leave  
      f0:	c3                   	ret    

000000f1 <exitiputtest>:

// does exit() call iput(p->cwd) in a transaction?
void
exitiputtest(void)
{
      f1:	55                   	push   %ebp
      f2:	89 e5                	mov    %esp,%ebp
      f4:	83 ec 18             	sub    $0x18,%esp
  int pid;

  printf(stdout, "exitiput test\n");
      f7:	a1 18 65 00 00       	mov    0x6518,%eax
      fc:	83 ec 08             	sub    $0x8,%esp
      ff:	68 32 46 00 00       	push   $0x4632
     104:	50                   	push   %eax
     105:	e8 dd 40 00 00       	call   41e7 <printf>
     10a:	83 c4 10             	add    $0x10,%esp

  pid = fork();
     10d:	e8 49 3f 00 00       	call   405b <fork>
     112:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid < 0){
     115:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     119:	79 1b                	jns    136 <exitiputtest+0x45>
    printf(stdout, "fork failed\n");
     11b:	a1 18 65 00 00       	mov    0x6518,%eax
     120:	83 ec 08             	sub    $0x8,%esp
     123:	68 41 46 00 00       	push   $0x4641
     128:	50                   	push   %eax
     129:	e8 b9 40 00 00       	call   41e7 <printf>
     12e:	83 c4 10             	add    $0x10,%esp
    exit();
     131:	e8 2d 3f 00 00       	call   4063 <exit>
  }
  if(pid == 0){
     136:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     13a:	0f 85 92 00 00 00    	jne    1d2 <exitiputtest+0xe1>
    if(mkdir("iputdir") < 0){
     140:	83 ec 0c             	sub    $0xc,%esp
     143:	68 c1 45 00 00       	push   $0x45c1
     148:	e8 7e 3f 00 00       	call   40cb <mkdir>
     14d:	83 c4 10             	add    $0x10,%esp
     150:	85 c0                	test   %eax,%eax
     152:	79 1b                	jns    16f <exitiputtest+0x7e>
      printf(stdout, "mkdir failed\n");
     154:	a1 18 65 00 00       	mov    0x6518,%eax
     159:	83 ec 08             	sub    $0x8,%esp
     15c:	68 c9 45 00 00       	push   $0x45c9
     161:	50                   	push   %eax
     162:	e8 80 40 00 00       	call   41e7 <printf>
     167:	83 c4 10             	add    $0x10,%esp
      exit();
     16a:	e8 f4 3e 00 00       	call   4063 <exit>
    }
    if(chdir("iputdir") < 0){
     16f:	83 ec 0c             	sub    $0xc,%esp
     172:	68 c1 45 00 00       	push   $0x45c1
     177:	e8 57 3f 00 00       	call   40d3 <chdir>
     17c:	83 c4 10             	add    $0x10,%esp
     17f:	85 c0                	test   %eax,%eax
     181:	79 1b                	jns    19e <exitiputtest+0xad>
      printf(stdout, "child chdir failed\n");
     183:	a1 18 65 00 00       	mov    0x6518,%eax
     188:	83 ec 08             	sub    $0x8,%esp
     18b:	68 4e 46 00 00       	push   $0x464e
     190:	50                   	push   %eax
     191:	e8 51 40 00 00       	call   41e7 <printf>
     196:	83 c4 10             	add    $0x10,%esp
      exit();
     199:	e8 c5 3e 00 00       	call   4063 <exit>
    }
    if(unlink("../iputdir") < 0){
     19e:	83 ec 0c             	sub    $0xc,%esp
     1a1:	68 ed 45 00 00       	push   $0x45ed
     1a6:	e8 08 3f 00 00       	call   40b3 <unlink>
     1ab:	83 c4 10             	add    $0x10,%esp
     1ae:	85 c0                	test   %eax,%eax
     1b0:	79 1b                	jns    1cd <exitiputtest+0xdc>
      printf(stdout, "unlink ../iputdir failed\n");
     1b2:	a1 18 65 00 00       	mov    0x6518,%eax
     1b7:	83 ec 08             	sub    $0x8,%esp
     1ba:	68 f8 45 00 00       	push   $0x45f8
     1bf:	50                   	push   %eax
     1c0:	e8 22 40 00 00       	call   41e7 <printf>
     1c5:	83 c4 10             	add    $0x10,%esp
      exit();
     1c8:	e8 96 3e 00 00       	call   4063 <exit>
    }
    exit();
     1cd:	e8 91 3e 00 00       	call   4063 <exit>
  }
  wait();
     1d2:	e8 94 3e 00 00       	call   406b <wait>
  printf(stdout, "exitiput test ok\n");
     1d7:	a1 18 65 00 00       	mov    0x6518,%eax
     1dc:	83 ec 08             	sub    $0x8,%esp
     1df:	68 62 46 00 00       	push   $0x4662
     1e4:	50                   	push   %eax
     1e5:	e8 fd 3f 00 00       	call   41e7 <printf>
     1ea:	83 c4 10             	add    $0x10,%esp
}
     1ed:	90                   	nop
     1ee:	c9                   	leave  
     1ef:	c3                   	ret    

000001f0 <openiputtest>:
//      for(i = 0; i < 10000; i++)
//        yield();
//    }
void
openiputtest(void)
{
     1f0:	55                   	push   %ebp
     1f1:	89 e5                	mov    %esp,%ebp
     1f3:	83 ec 18             	sub    $0x18,%esp
  int pid;

  printf(stdout, "openiput test\n");
     1f6:	a1 18 65 00 00       	mov    0x6518,%eax
     1fb:	83 ec 08             	sub    $0x8,%esp
     1fe:	68 74 46 00 00       	push   $0x4674
     203:	50                   	push   %eax
     204:	e8 de 3f 00 00       	call   41e7 <printf>
     209:	83 c4 10             	add    $0x10,%esp
  if(mkdir("oidir") < 0){
     20c:	83 ec 0c             	sub    $0xc,%esp
     20f:	68 83 46 00 00       	push   $0x4683
     214:	e8 b2 3e 00 00       	call   40cb <mkdir>
     219:	83 c4 10             	add    $0x10,%esp
     21c:	85 c0                	test   %eax,%eax
     21e:	79 1b                	jns    23b <openiputtest+0x4b>
    printf(stdout, "mkdir oidir failed\n");
     220:	a1 18 65 00 00       	mov    0x6518,%eax
     225:	83 ec 08             	sub    $0x8,%esp
     228:	68 89 46 00 00       	push   $0x4689
     22d:	50                   	push   %eax
     22e:	e8 b4 3f 00 00       	call   41e7 <printf>
     233:	83 c4 10             	add    $0x10,%esp
    exit();
     236:	e8 28 3e 00 00       	call   4063 <exit>
  }
  pid = fork();
     23b:	e8 1b 3e 00 00       	call   405b <fork>
     240:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid < 0){
     243:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     247:	79 1b                	jns    264 <openiputtest+0x74>
    printf(stdout, "fork failed\n");
     249:	a1 18 65 00 00       	mov    0x6518,%eax
     24e:	83 ec 08             	sub    $0x8,%esp
     251:	68 41 46 00 00       	push   $0x4641
     256:	50                   	push   %eax
     257:	e8 8b 3f 00 00       	call   41e7 <printf>
     25c:	83 c4 10             	add    $0x10,%esp
    exit();
     25f:	e8 ff 3d 00 00       	call   4063 <exit>
  }
  if(pid == 0){
     264:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     268:	75 3b                	jne    2a5 <openiputtest+0xb5>
    int fd = open("oidir", O_RDWR);
     26a:	83 ec 08             	sub    $0x8,%esp
     26d:	6a 02                	push   $0x2
     26f:	68 83 46 00 00       	push   $0x4683
     274:	e8 2a 3e 00 00       	call   40a3 <open>
     279:	83 c4 10             	add    $0x10,%esp
     27c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0){
     27f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     283:	78 1b                	js     2a0 <openiputtest+0xb0>
      printf(stdout, "open directory for write succeeded\n");
     285:	a1 18 65 00 00       	mov    0x6518,%eax
     28a:	83 ec 08             	sub    $0x8,%esp
     28d:	68 a0 46 00 00       	push   $0x46a0
     292:	50                   	push   %eax
     293:	e8 4f 3f 00 00       	call   41e7 <printf>
     298:	83 c4 10             	add    $0x10,%esp
      exit();
     29b:	e8 c3 3d 00 00       	call   4063 <exit>
    }
    exit();
     2a0:	e8 be 3d 00 00       	call   4063 <exit>
  }
  sleep(1);
     2a5:	83 ec 0c             	sub    $0xc,%esp
     2a8:	6a 01                	push   $0x1
     2aa:	e8 44 3e 00 00       	call   40f3 <sleep>
     2af:	83 c4 10             	add    $0x10,%esp
  if(unlink("oidir") != 0){
     2b2:	83 ec 0c             	sub    $0xc,%esp
     2b5:	68 83 46 00 00       	push   $0x4683
     2ba:	e8 f4 3d 00 00       	call   40b3 <unlink>
     2bf:	83 c4 10             	add    $0x10,%esp
     2c2:	85 c0                	test   %eax,%eax
     2c4:	74 1b                	je     2e1 <openiputtest+0xf1>
    printf(stdout, "unlink failed\n");
     2c6:	a1 18 65 00 00       	mov    0x6518,%eax
     2cb:	83 ec 08             	sub    $0x8,%esp
     2ce:	68 c4 46 00 00       	push   $0x46c4
     2d3:	50                   	push   %eax
     2d4:	e8 0e 3f 00 00       	call   41e7 <printf>
     2d9:	83 c4 10             	add    $0x10,%esp
    exit();
     2dc:	e8 82 3d 00 00       	call   4063 <exit>
  }
  wait();
     2e1:	e8 85 3d 00 00       	call   406b <wait>
  printf(stdout, "openiput test ok\n");
     2e6:	a1 18 65 00 00       	mov    0x6518,%eax
     2eb:	83 ec 08             	sub    $0x8,%esp
     2ee:	68 d3 46 00 00       	push   $0x46d3
     2f3:	50                   	push   %eax
     2f4:	e8 ee 3e 00 00       	call   41e7 <printf>
     2f9:	83 c4 10             	add    $0x10,%esp
}
     2fc:	90                   	nop
     2fd:	c9                   	leave  
     2fe:	c3                   	ret    

000002ff <opentest>:

// simple file system tests

void
opentest(void)
{
     2ff:	55                   	push   %ebp
     300:	89 e5                	mov    %esp,%ebp
     302:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(stdout, "open test\n");
     305:	a1 18 65 00 00       	mov    0x6518,%eax
     30a:	83 ec 08             	sub    $0x8,%esp
     30d:	68 e5 46 00 00       	push   $0x46e5
     312:	50                   	push   %eax
     313:	e8 cf 3e 00 00       	call   41e7 <printf>
     318:	83 c4 10             	add    $0x10,%esp
  fd = open("echo", 0);
     31b:	83 ec 08             	sub    $0x8,%esp
     31e:	6a 00                	push   $0x0
     320:	68 a0 45 00 00       	push   $0x45a0
     325:	e8 79 3d 00 00       	call   40a3 <open>
     32a:	83 c4 10             	add    $0x10,%esp
     32d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
     330:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     334:	79 1b                	jns    351 <opentest+0x52>
    printf(stdout, "open echo failed!\n");
     336:	a1 18 65 00 00       	mov    0x6518,%eax
     33b:	83 ec 08             	sub    $0x8,%esp
     33e:	68 f0 46 00 00       	push   $0x46f0
     343:	50                   	push   %eax
     344:	e8 9e 3e 00 00       	call   41e7 <printf>
     349:	83 c4 10             	add    $0x10,%esp
    exit();
     34c:	e8 12 3d 00 00       	call   4063 <exit>
  }
  close(fd);
     351:	83 ec 0c             	sub    $0xc,%esp
     354:	ff 75 f4             	push   -0xc(%ebp)
     357:	e8 2f 3d 00 00       	call   408b <close>
     35c:	83 c4 10             	add    $0x10,%esp
  fd = open("doesnotexist", 0);
     35f:	83 ec 08             	sub    $0x8,%esp
     362:	6a 00                	push   $0x0
     364:	68 03 47 00 00       	push   $0x4703
     369:	e8 35 3d 00 00       	call   40a3 <open>
     36e:	83 c4 10             	add    $0x10,%esp
     371:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
     374:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     378:	78 1b                	js     395 <opentest+0x96>
    printf(stdout, "open doesnotexist succeeded!\n");
     37a:	a1 18 65 00 00       	mov    0x6518,%eax
     37f:	83 ec 08             	sub    $0x8,%esp
     382:	68 10 47 00 00       	push   $0x4710
     387:	50                   	push   %eax
     388:	e8 5a 3e 00 00       	call   41e7 <printf>
     38d:	83 c4 10             	add    $0x10,%esp
    exit();
     390:	e8 ce 3c 00 00       	call   4063 <exit>
  }
  printf(stdout, "open test ok\n");
     395:	a1 18 65 00 00       	mov    0x6518,%eax
     39a:	83 ec 08             	sub    $0x8,%esp
     39d:	68 2e 47 00 00       	push   $0x472e
     3a2:	50                   	push   %eax
     3a3:	e8 3f 3e 00 00       	call   41e7 <printf>
     3a8:	83 c4 10             	add    $0x10,%esp
}
     3ab:	90                   	nop
     3ac:	c9                   	leave  
     3ad:	c3                   	ret    

000003ae <writetest>:

void
writetest(void)
{
     3ae:	55                   	push   %ebp
     3af:	89 e5                	mov    %esp,%ebp
     3b1:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int i;

  printf(stdout, "small file test\n");
     3b4:	a1 18 65 00 00       	mov    0x6518,%eax
     3b9:	83 ec 08             	sub    $0x8,%esp
     3bc:	68 3c 47 00 00       	push   $0x473c
     3c1:	50                   	push   %eax
     3c2:	e8 20 3e 00 00       	call   41e7 <printf>
     3c7:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_CREATE|O_RDWR);
     3ca:	83 ec 08             	sub    $0x8,%esp
     3cd:	68 02 02 00 00       	push   $0x202
     3d2:	68 4d 47 00 00       	push   $0x474d
     3d7:	e8 c7 3c 00 00       	call   40a3 <open>
     3dc:	83 c4 10             	add    $0x10,%esp
     3df:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd >= 0){
     3e2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     3e6:	78 22                	js     40a <writetest+0x5c>
    printf(stdout, "creat small succeeded; ok\n");
     3e8:	a1 18 65 00 00       	mov    0x6518,%eax
     3ed:	83 ec 08             	sub    $0x8,%esp
     3f0:	68 53 47 00 00       	push   $0x4753
     3f5:	50                   	push   %eax
     3f6:	e8 ec 3d 00 00       	call   41e7 <printf>
     3fb:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "error: creat small failed!\n");
    exit();
  }
  for(i = 0; i < 100; i++){
     3fe:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     405:	e9 8f 00 00 00       	jmp    499 <writetest+0xeb>
    printf(stdout, "error: creat small failed!\n");
     40a:	a1 18 65 00 00       	mov    0x6518,%eax
     40f:	83 ec 08             	sub    $0x8,%esp
     412:	68 6e 47 00 00       	push   $0x476e
     417:	50                   	push   %eax
     418:	e8 ca 3d 00 00       	call   41e7 <printf>
     41d:	83 c4 10             	add    $0x10,%esp
    exit();
     420:	e8 3e 3c 00 00       	call   4063 <exit>
    if(write(fd, "aaaaaaaaaa", 10) != 10){
     425:	83 ec 04             	sub    $0x4,%esp
     428:	6a 0a                	push   $0xa
     42a:	68 8a 47 00 00       	push   $0x478a
     42f:	ff 75 f0             	push   -0x10(%ebp)
     432:	e8 4c 3c 00 00       	call   4083 <write>
     437:	83 c4 10             	add    $0x10,%esp
     43a:	83 f8 0a             	cmp    $0xa,%eax
     43d:	74 1e                	je     45d <writetest+0xaf>
      printf(stdout, "error: write aa %d new file failed\n", i);
     43f:	a1 18 65 00 00       	mov    0x6518,%eax
     444:	83 ec 04             	sub    $0x4,%esp
     447:	ff 75 f4             	push   -0xc(%ebp)
     44a:	68 98 47 00 00       	push   $0x4798
     44f:	50                   	push   %eax
     450:	e8 92 3d 00 00       	call   41e7 <printf>
     455:	83 c4 10             	add    $0x10,%esp
      exit();
     458:	e8 06 3c 00 00       	call   4063 <exit>
    }
    if(write(fd, "bbbbbbbbbb", 10) != 10){
     45d:	83 ec 04             	sub    $0x4,%esp
     460:	6a 0a                	push   $0xa
     462:	68 bc 47 00 00       	push   $0x47bc
     467:	ff 75 f0             	push   -0x10(%ebp)
     46a:	e8 14 3c 00 00       	call   4083 <write>
     46f:	83 c4 10             	add    $0x10,%esp
     472:	83 f8 0a             	cmp    $0xa,%eax
     475:	74 1e                	je     495 <writetest+0xe7>
      printf(stdout, "error: write bb %d new file failed\n", i);
     477:	a1 18 65 00 00       	mov    0x6518,%eax
     47c:	83 ec 04             	sub    $0x4,%esp
     47f:	ff 75 f4             	push   -0xc(%ebp)
     482:	68 c8 47 00 00       	push   $0x47c8
     487:	50                   	push   %eax
     488:	e8 5a 3d 00 00       	call   41e7 <printf>
     48d:	83 c4 10             	add    $0x10,%esp
      exit();
     490:	e8 ce 3b 00 00       	call   4063 <exit>
  for(i = 0; i < 100; i++){
     495:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     499:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     49d:	7e 86                	jle    425 <writetest+0x77>
    }
  }
  printf(stdout, "writes ok\n");
     49f:	a1 18 65 00 00       	mov    0x6518,%eax
     4a4:	83 ec 08             	sub    $0x8,%esp
     4a7:	68 ec 47 00 00       	push   $0x47ec
     4ac:	50                   	push   %eax
     4ad:	e8 35 3d 00 00       	call   41e7 <printf>
     4b2:	83 c4 10             	add    $0x10,%esp
  close(fd);
     4b5:	83 ec 0c             	sub    $0xc,%esp
     4b8:	ff 75 f0             	push   -0x10(%ebp)
     4bb:	e8 cb 3b 00 00       	call   408b <close>
     4c0:	83 c4 10             	add    $0x10,%esp
  fd = open("small", O_RDONLY);
     4c3:	83 ec 08             	sub    $0x8,%esp
     4c6:	6a 00                	push   $0x0
     4c8:	68 4d 47 00 00       	push   $0x474d
     4cd:	e8 d1 3b 00 00       	call   40a3 <open>
     4d2:	83 c4 10             	add    $0x10,%esp
     4d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd >= 0){
     4d8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     4dc:	78 3c                	js     51a <writetest+0x16c>
    printf(stdout, "open small succeeded ok\n");
     4de:	a1 18 65 00 00       	mov    0x6518,%eax
     4e3:	83 ec 08             	sub    $0x8,%esp
     4e6:	68 f7 47 00 00       	push   $0x47f7
     4eb:	50                   	push   %eax
     4ec:	e8 f6 3c 00 00       	call   41e7 <printf>
     4f1:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "error: open small failed!\n");
    exit();
  }
  i = read(fd, buf, 2000);
     4f4:	83 ec 04             	sub    $0x4,%esp
     4f7:	68 d0 07 00 00       	push   $0x7d0
     4fc:	68 40 65 00 00       	push   $0x6540
     501:	ff 75 f0             	push   -0x10(%ebp)
     504:	e8 72 3b 00 00       	call   407b <read>
     509:	83 c4 10             	add    $0x10,%esp
     50c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(i == 2000){
     50f:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
     516:	75 57                	jne    56f <writetest+0x1c1>
     518:	eb 1b                	jmp    535 <writetest+0x187>
    printf(stdout, "error: open small failed!\n");
     51a:	a1 18 65 00 00       	mov    0x6518,%eax
     51f:	83 ec 08             	sub    $0x8,%esp
     522:	68 10 48 00 00       	push   $0x4810
     527:	50                   	push   %eax
     528:	e8 ba 3c 00 00       	call   41e7 <printf>
     52d:	83 c4 10             	add    $0x10,%esp
    exit();
     530:	e8 2e 3b 00 00       	call   4063 <exit>
    printf(stdout, "read succeeded ok\n");
     535:	a1 18 65 00 00       	mov    0x6518,%eax
     53a:	83 ec 08             	sub    $0x8,%esp
     53d:	68 2b 48 00 00       	push   $0x482b
     542:	50                   	push   %eax
     543:	e8 9f 3c 00 00       	call   41e7 <printf>
     548:	83 c4 10             	add    $0x10,%esp
  } else {
    printf(stdout, "read failed\n");
    exit();
  }
  close(fd);
     54b:	83 ec 0c             	sub    $0xc,%esp
     54e:	ff 75 f0             	push   -0x10(%ebp)
     551:	e8 35 3b 00 00       	call   408b <close>
     556:	83 c4 10             	add    $0x10,%esp

  if(unlink("small") < 0){
     559:	83 ec 0c             	sub    $0xc,%esp
     55c:	68 4d 47 00 00       	push   $0x474d
     561:	e8 4d 3b 00 00       	call   40b3 <unlink>
     566:	83 c4 10             	add    $0x10,%esp
     569:	85 c0                	test   %eax,%eax
     56b:	79 38                	jns    5a5 <writetest+0x1f7>
     56d:	eb 1b                	jmp    58a <writetest+0x1dc>
    printf(stdout, "read failed\n");
     56f:	a1 18 65 00 00       	mov    0x6518,%eax
     574:	83 ec 08             	sub    $0x8,%esp
     577:	68 3e 48 00 00       	push   $0x483e
     57c:	50                   	push   %eax
     57d:	e8 65 3c 00 00       	call   41e7 <printf>
     582:	83 c4 10             	add    $0x10,%esp
    exit();
     585:	e8 d9 3a 00 00       	call   4063 <exit>
    printf(stdout, "unlink small failed\n");
     58a:	a1 18 65 00 00       	mov    0x6518,%eax
     58f:	83 ec 08             	sub    $0x8,%esp
     592:	68 4b 48 00 00       	push   $0x484b
     597:	50                   	push   %eax
     598:	e8 4a 3c 00 00       	call   41e7 <printf>
     59d:	83 c4 10             	add    $0x10,%esp
    exit();
     5a0:	e8 be 3a 00 00       	call   4063 <exit>
  }
  printf(stdout, "small file test ok\n");
     5a5:	a1 18 65 00 00       	mov    0x6518,%eax
     5aa:	83 ec 08             	sub    $0x8,%esp
     5ad:	68 60 48 00 00       	push   $0x4860
     5b2:	50                   	push   %eax
     5b3:	e8 2f 3c 00 00       	call   41e7 <printf>
     5b8:	83 c4 10             	add    $0x10,%esp
}
     5bb:	90                   	nop
     5bc:	c9                   	leave  
     5bd:	c3                   	ret    

000005be <writetest1>:

void
writetest1(void)
{
     5be:	55                   	push   %ebp
     5bf:	89 e5                	mov    %esp,%ebp
     5c1:	83 ec 18             	sub    $0x18,%esp
  int i, fd, n;

  printf(stdout, "big files test\n");
     5c4:	a1 18 65 00 00       	mov    0x6518,%eax
     5c9:	83 ec 08             	sub    $0x8,%esp
     5cc:	68 74 48 00 00       	push   $0x4874
     5d1:	50                   	push   %eax
     5d2:	e8 10 3c 00 00       	call   41e7 <printf>
     5d7:	83 c4 10             	add    $0x10,%esp

  fd = open("big", O_CREATE|O_RDWR);
     5da:	83 ec 08             	sub    $0x8,%esp
     5dd:	68 02 02 00 00       	push   $0x202
     5e2:	68 84 48 00 00       	push   $0x4884
     5e7:	e8 b7 3a 00 00       	call   40a3 <open>
     5ec:	83 c4 10             	add    $0x10,%esp
     5ef:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
     5f2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     5f6:	79 1b                	jns    613 <writetest1+0x55>
    printf(stdout, "error: creat big failed!\n");
     5f8:	a1 18 65 00 00       	mov    0x6518,%eax
     5fd:	83 ec 08             	sub    $0x8,%esp
     600:	68 88 48 00 00       	push   $0x4888
     605:	50                   	push   %eax
     606:	e8 dc 3b 00 00       	call   41e7 <printf>
     60b:	83 c4 10             	add    $0x10,%esp
    exit();
     60e:	e8 50 3a 00 00       	call   4063 <exit>
  }

  for(i = 0; i < MAXFILE; i++){
     613:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     61a:	eb 4b                	jmp    667 <writetest1+0xa9>
    ((int*)buf)[0] = i;
     61c:	ba 40 65 00 00       	mov    $0x6540,%edx
     621:	8b 45 f4             	mov    -0xc(%ebp),%eax
     624:	89 02                	mov    %eax,(%edx)
    if(write(fd, buf, 512) != 512){
     626:	83 ec 04             	sub    $0x4,%esp
     629:	68 00 02 00 00       	push   $0x200
     62e:	68 40 65 00 00       	push   $0x6540
     633:	ff 75 ec             	push   -0x14(%ebp)
     636:	e8 48 3a 00 00       	call   4083 <write>
     63b:	83 c4 10             	add    $0x10,%esp
     63e:	3d 00 02 00 00       	cmp    $0x200,%eax
     643:	74 1e                	je     663 <writetest1+0xa5>
      printf(stdout, "error: write big file failed\n", i);
     645:	a1 18 65 00 00       	mov    0x6518,%eax
     64a:	83 ec 04             	sub    $0x4,%esp
     64d:	ff 75 f4             	push   -0xc(%ebp)
     650:	68 a2 48 00 00       	push   $0x48a2
     655:	50                   	push   %eax
     656:	e8 8c 3b 00 00       	call   41e7 <printf>
     65b:	83 c4 10             	add    $0x10,%esp
      exit();
     65e:	e8 00 3a 00 00       	call   4063 <exit>
  for(i = 0; i < MAXFILE; i++){
     663:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     667:	8b 45 f4             	mov    -0xc(%ebp),%eax
     66a:	3d 8b 00 00 00       	cmp    $0x8b,%eax
     66f:	76 ab                	jbe    61c <writetest1+0x5e>
    }
  }

  close(fd);
     671:	83 ec 0c             	sub    $0xc,%esp
     674:	ff 75 ec             	push   -0x14(%ebp)
     677:	e8 0f 3a 00 00       	call   408b <close>
     67c:	83 c4 10             	add    $0x10,%esp

  fd = open("big", O_RDONLY);
     67f:	83 ec 08             	sub    $0x8,%esp
     682:	6a 00                	push   $0x0
     684:	68 84 48 00 00       	push   $0x4884
     689:	e8 15 3a 00 00       	call   40a3 <open>
     68e:	83 c4 10             	add    $0x10,%esp
     691:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
     694:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     698:	79 1b                	jns    6b5 <writetest1+0xf7>
    printf(stdout, "error: open big failed!\n");
     69a:	a1 18 65 00 00       	mov    0x6518,%eax
     69f:	83 ec 08             	sub    $0x8,%esp
     6a2:	68 c0 48 00 00       	push   $0x48c0
     6a7:	50                   	push   %eax
     6a8:	e8 3a 3b 00 00       	call   41e7 <printf>
     6ad:	83 c4 10             	add    $0x10,%esp
    exit();
     6b0:	e8 ae 39 00 00       	call   4063 <exit>
  }

  n = 0;
     6b5:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(;;){
    i = read(fd, buf, 512);
     6bc:	83 ec 04             	sub    $0x4,%esp
     6bf:	68 00 02 00 00       	push   $0x200
     6c4:	68 40 65 00 00       	push   $0x6540
     6c9:	ff 75 ec             	push   -0x14(%ebp)
     6cc:	e8 aa 39 00 00       	call   407b <read>
     6d1:	83 c4 10             	add    $0x10,%esp
     6d4:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(i == 0){
     6d7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     6db:	75 27                	jne    704 <writetest1+0x146>
      if(n == MAXFILE - 1){
     6dd:	81 7d f0 8b 00 00 00 	cmpl   $0x8b,-0x10(%ebp)
     6e4:	75 7d                	jne    763 <writetest1+0x1a5>
        printf(stdout, "read only %d blocks from big", n);
     6e6:	a1 18 65 00 00       	mov    0x6518,%eax
     6eb:	83 ec 04             	sub    $0x4,%esp
     6ee:	ff 75 f0             	push   -0x10(%ebp)
     6f1:	68 d9 48 00 00       	push   $0x48d9
     6f6:	50                   	push   %eax
     6f7:	e8 eb 3a 00 00       	call   41e7 <printf>
     6fc:	83 c4 10             	add    $0x10,%esp
        exit();
     6ff:	e8 5f 39 00 00       	call   4063 <exit>
      }
      break;
    } else if(i != 512){
     704:	81 7d f4 00 02 00 00 	cmpl   $0x200,-0xc(%ebp)
     70b:	74 1e                	je     72b <writetest1+0x16d>
      printf(stdout, "read failed %d\n", i);
     70d:	a1 18 65 00 00       	mov    0x6518,%eax
     712:	83 ec 04             	sub    $0x4,%esp
     715:	ff 75 f4             	push   -0xc(%ebp)
     718:	68 f6 48 00 00       	push   $0x48f6
     71d:	50                   	push   %eax
     71e:	e8 c4 3a 00 00       	call   41e7 <printf>
     723:	83 c4 10             	add    $0x10,%esp
      exit();
     726:	e8 38 39 00 00       	call   4063 <exit>
    }
    if(((int*)buf)[0] != n){
     72b:	b8 40 65 00 00       	mov    $0x6540,%eax
     730:	8b 00                	mov    (%eax),%eax
     732:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     735:	74 23                	je     75a <writetest1+0x19c>
      printf(stdout, "read content of block %d is %d\n",
             n, ((int*)buf)[0]);
     737:	b8 40 65 00 00       	mov    $0x6540,%eax
      printf(stdout, "read content of block %d is %d\n",
     73c:	8b 10                	mov    (%eax),%edx
     73e:	a1 18 65 00 00       	mov    0x6518,%eax
     743:	52                   	push   %edx
     744:	ff 75 f0             	push   -0x10(%ebp)
     747:	68 08 49 00 00       	push   $0x4908
     74c:	50                   	push   %eax
     74d:	e8 95 3a 00 00       	call   41e7 <printf>
     752:	83 c4 10             	add    $0x10,%esp
      exit();
     755:	e8 09 39 00 00       	call   4063 <exit>
    }
    n++;
     75a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    i = read(fd, buf, 512);
     75e:	e9 59 ff ff ff       	jmp    6bc <writetest1+0xfe>
      break;
     763:	90                   	nop
  }
  close(fd);
     764:	83 ec 0c             	sub    $0xc,%esp
     767:	ff 75 ec             	push   -0x14(%ebp)
     76a:	e8 1c 39 00 00       	call   408b <close>
     76f:	83 c4 10             	add    $0x10,%esp
  if(unlink("big") < 0){
     772:	83 ec 0c             	sub    $0xc,%esp
     775:	68 84 48 00 00       	push   $0x4884
     77a:	e8 34 39 00 00       	call   40b3 <unlink>
     77f:	83 c4 10             	add    $0x10,%esp
     782:	85 c0                	test   %eax,%eax
     784:	79 1b                	jns    7a1 <writetest1+0x1e3>
    printf(stdout, "unlink big failed\n");
     786:	a1 18 65 00 00       	mov    0x6518,%eax
     78b:	83 ec 08             	sub    $0x8,%esp
     78e:	68 28 49 00 00       	push   $0x4928
     793:	50                   	push   %eax
     794:	e8 4e 3a 00 00       	call   41e7 <printf>
     799:	83 c4 10             	add    $0x10,%esp
    exit();
     79c:	e8 c2 38 00 00       	call   4063 <exit>
  }
  printf(stdout, "big files ok\n");
     7a1:	a1 18 65 00 00       	mov    0x6518,%eax
     7a6:	83 ec 08             	sub    $0x8,%esp
     7a9:	68 3b 49 00 00       	push   $0x493b
     7ae:	50                   	push   %eax
     7af:	e8 33 3a 00 00       	call   41e7 <printf>
     7b4:	83 c4 10             	add    $0x10,%esp
}
     7b7:	90                   	nop
     7b8:	c9                   	leave  
     7b9:	c3                   	ret    

000007ba <createtest>:

void
createtest(void)
{
     7ba:	55                   	push   %ebp
     7bb:	89 e5                	mov    %esp,%ebp
     7bd:	83 ec 18             	sub    $0x18,%esp
  int i, fd;

  printf(stdout, "many creates, followed by unlink test\n");
     7c0:	a1 18 65 00 00       	mov    0x6518,%eax
     7c5:	83 ec 08             	sub    $0x8,%esp
     7c8:	68 4c 49 00 00       	push   $0x494c
     7cd:	50                   	push   %eax
     7ce:	e8 14 3a 00 00       	call   41e7 <printf>
     7d3:	83 c4 10             	add    $0x10,%esp

  name[0] = 'a';
     7d6:	c6 05 40 85 00 00 61 	movb   $0x61,0x8540
  name[2] = '\0';
     7dd:	c6 05 42 85 00 00 00 	movb   $0x0,0x8542
  for(i = 0; i < 52; i++){
     7e4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     7eb:	eb 35                	jmp    822 <createtest+0x68>
    name[1] = '0' + i;
     7ed:	8b 45 f4             	mov    -0xc(%ebp),%eax
     7f0:	83 c0 30             	add    $0x30,%eax
     7f3:	a2 41 85 00 00       	mov    %al,0x8541
    fd = open(name, O_CREATE|O_RDWR);
     7f8:	83 ec 08             	sub    $0x8,%esp
     7fb:	68 02 02 00 00       	push   $0x202
     800:	68 40 85 00 00       	push   $0x8540
     805:	e8 99 38 00 00       	call   40a3 <open>
     80a:	83 c4 10             	add    $0x10,%esp
     80d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    close(fd);
     810:	83 ec 0c             	sub    $0xc,%esp
     813:	ff 75 f0             	push   -0x10(%ebp)
     816:	e8 70 38 00 00       	call   408b <close>
     81b:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 52; i++){
     81e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     822:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     826:	7e c5                	jle    7ed <createtest+0x33>
  }
  name[0] = 'a';
     828:	c6 05 40 85 00 00 61 	movb   $0x61,0x8540
  name[2] = '\0';
     82f:	c6 05 42 85 00 00 00 	movb   $0x0,0x8542
  for(i = 0; i < 52; i++){
     836:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     83d:	eb 1f                	jmp    85e <createtest+0xa4>
    name[1] = '0' + i;
     83f:	8b 45 f4             	mov    -0xc(%ebp),%eax
     842:	83 c0 30             	add    $0x30,%eax
     845:	a2 41 85 00 00       	mov    %al,0x8541
    unlink(name);
     84a:	83 ec 0c             	sub    $0xc,%esp
     84d:	68 40 85 00 00       	push   $0x8540
     852:	e8 5c 38 00 00       	call   40b3 <unlink>
     857:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 52; i++){
     85a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     85e:	83 7d f4 33          	cmpl   $0x33,-0xc(%ebp)
     862:	7e db                	jle    83f <createtest+0x85>
  }
  printf(stdout, "many creates, followed by unlink; ok\n");
     864:	a1 18 65 00 00       	mov    0x6518,%eax
     869:	83 ec 08             	sub    $0x8,%esp
     86c:	68 74 49 00 00       	push   $0x4974
     871:	50                   	push   %eax
     872:	e8 70 39 00 00       	call   41e7 <printf>
     877:	83 c4 10             	add    $0x10,%esp
}
     87a:	90                   	nop
     87b:	c9                   	leave  
     87c:	c3                   	ret    

0000087d <dirtest>:

void dirtest(void)
{
     87d:	55                   	push   %ebp
     87e:	89 e5                	mov    %esp,%ebp
     880:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "mkdir test\n");
     883:	a1 18 65 00 00       	mov    0x6518,%eax
     888:	83 ec 08             	sub    $0x8,%esp
     88b:	68 9a 49 00 00       	push   $0x499a
     890:	50                   	push   %eax
     891:	e8 51 39 00 00       	call   41e7 <printf>
     896:	83 c4 10             	add    $0x10,%esp

  if(mkdir("dir0") < 0){
     899:	83 ec 0c             	sub    $0xc,%esp
     89c:	68 a6 49 00 00       	push   $0x49a6
     8a1:	e8 25 38 00 00       	call   40cb <mkdir>
     8a6:	83 c4 10             	add    $0x10,%esp
     8a9:	85 c0                	test   %eax,%eax
     8ab:	79 1b                	jns    8c8 <dirtest+0x4b>
    printf(stdout, "mkdir failed\n");
     8ad:	a1 18 65 00 00       	mov    0x6518,%eax
     8b2:	83 ec 08             	sub    $0x8,%esp
     8b5:	68 c9 45 00 00       	push   $0x45c9
     8ba:	50                   	push   %eax
     8bb:	e8 27 39 00 00       	call   41e7 <printf>
     8c0:	83 c4 10             	add    $0x10,%esp
    exit();
     8c3:	e8 9b 37 00 00       	call   4063 <exit>
  }

  if(chdir("dir0") < 0){
     8c8:	83 ec 0c             	sub    $0xc,%esp
     8cb:	68 a6 49 00 00       	push   $0x49a6
     8d0:	e8 fe 37 00 00       	call   40d3 <chdir>
     8d5:	83 c4 10             	add    $0x10,%esp
     8d8:	85 c0                	test   %eax,%eax
     8da:	79 1b                	jns    8f7 <dirtest+0x7a>
    printf(stdout, "chdir dir0 failed\n");
     8dc:	a1 18 65 00 00       	mov    0x6518,%eax
     8e1:	83 ec 08             	sub    $0x8,%esp
     8e4:	68 ab 49 00 00       	push   $0x49ab
     8e9:	50                   	push   %eax
     8ea:	e8 f8 38 00 00       	call   41e7 <printf>
     8ef:	83 c4 10             	add    $0x10,%esp
    exit();
     8f2:	e8 6c 37 00 00       	call   4063 <exit>
  }

  if(chdir("..") < 0){
     8f7:	83 ec 0c             	sub    $0xc,%esp
     8fa:	68 be 49 00 00       	push   $0x49be
     8ff:	e8 cf 37 00 00       	call   40d3 <chdir>
     904:	83 c4 10             	add    $0x10,%esp
     907:	85 c0                	test   %eax,%eax
     909:	79 1b                	jns    926 <dirtest+0xa9>
    printf(stdout, "chdir .. failed\n");
     90b:	a1 18 65 00 00       	mov    0x6518,%eax
     910:	83 ec 08             	sub    $0x8,%esp
     913:	68 c1 49 00 00       	push   $0x49c1
     918:	50                   	push   %eax
     919:	e8 c9 38 00 00       	call   41e7 <printf>
     91e:	83 c4 10             	add    $0x10,%esp
    exit();
     921:	e8 3d 37 00 00       	call   4063 <exit>
  }

  if(unlink("dir0") < 0){
     926:	83 ec 0c             	sub    $0xc,%esp
     929:	68 a6 49 00 00       	push   $0x49a6
     92e:	e8 80 37 00 00       	call   40b3 <unlink>
     933:	83 c4 10             	add    $0x10,%esp
     936:	85 c0                	test   %eax,%eax
     938:	79 1b                	jns    955 <dirtest+0xd8>
    printf(stdout, "unlink dir0 failed\n");
     93a:	a1 18 65 00 00       	mov    0x6518,%eax
     93f:	83 ec 08             	sub    $0x8,%esp
     942:	68 d2 49 00 00       	push   $0x49d2
     947:	50                   	push   %eax
     948:	e8 9a 38 00 00       	call   41e7 <printf>
     94d:	83 c4 10             	add    $0x10,%esp
    exit();
     950:	e8 0e 37 00 00       	call   4063 <exit>
  }
  printf(stdout, "mkdir test ok\n");
     955:	a1 18 65 00 00       	mov    0x6518,%eax
     95a:	83 ec 08             	sub    $0x8,%esp
     95d:	68 e6 49 00 00       	push   $0x49e6
     962:	50                   	push   %eax
     963:	e8 7f 38 00 00       	call   41e7 <printf>
     968:	83 c4 10             	add    $0x10,%esp
}
     96b:	90                   	nop
     96c:	c9                   	leave  
     96d:	c3                   	ret    

0000096e <exectest>:

void
exectest(void)
{
     96e:	55                   	push   %ebp
     96f:	89 e5                	mov    %esp,%ebp
     971:	83 ec 08             	sub    $0x8,%esp
  printf(stdout, "exec test\n");
     974:	a1 18 65 00 00       	mov    0x6518,%eax
     979:	83 ec 08             	sub    $0x8,%esp
     97c:	68 f5 49 00 00       	push   $0x49f5
     981:	50                   	push   %eax
     982:	e8 60 38 00 00       	call   41e7 <printf>
     987:	83 c4 10             	add    $0x10,%esp
  if(exec("echo", echoargv) < 0){
     98a:	83 ec 08             	sub    $0x8,%esp
     98d:	68 04 65 00 00       	push   $0x6504
     992:	68 a0 45 00 00       	push   $0x45a0
     997:	e8 ff 36 00 00       	call   409b <exec>
     99c:	83 c4 10             	add    $0x10,%esp
     99f:	85 c0                	test   %eax,%eax
     9a1:	79 1b                	jns    9be <exectest+0x50>
    printf(stdout, "exec echo failed\n");
     9a3:	a1 18 65 00 00       	mov    0x6518,%eax
     9a8:	83 ec 08             	sub    $0x8,%esp
     9ab:	68 00 4a 00 00       	push   $0x4a00
     9b0:	50                   	push   %eax
     9b1:	e8 31 38 00 00       	call   41e7 <printf>
     9b6:	83 c4 10             	add    $0x10,%esp
    exit();
     9b9:	e8 a5 36 00 00       	call   4063 <exit>
  }
}
     9be:	90                   	nop
     9bf:	c9                   	leave  
     9c0:	c3                   	ret    

000009c1 <pipe1>:

// simple fork and pipe read/write

void
pipe1(void)
{
     9c1:	55                   	push   %ebp
     9c2:	89 e5                	mov    %esp,%ebp
     9c4:	83 ec 28             	sub    $0x28,%esp
  int fds[2], pid;
  int seq, i, n, cc, total;

  if(pipe(fds) != 0){
     9c7:	83 ec 0c             	sub    $0xc,%esp
     9ca:	8d 45 d8             	lea    -0x28(%ebp),%eax
     9cd:	50                   	push   %eax
     9ce:	e8 a0 36 00 00       	call   4073 <pipe>
     9d3:	83 c4 10             	add    $0x10,%esp
     9d6:	85 c0                	test   %eax,%eax
     9d8:	74 17                	je     9f1 <pipe1+0x30>
    printf(1, "pipe() failed\n");
     9da:	83 ec 08             	sub    $0x8,%esp
     9dd:	68 12 4a 00 00       	push   $0x4a12
     9e2:	6a 01                	push   $0x1
     9e4:	e8 fe 37 00 00       	call   41e7 <printf>
     9e9:	83 c4 10             	add    $0x10,%esp
    exit();
     9ec:	e8 72 36 00 00       	call   4063 <exit>
  }
  pid = fork();
     9f1:	e8 65 36 00 00       	call   405b <fork>
     9f6:	89 45 e0             	mov    %eax,-0x20(%ebp)
  seq = 0;
     9f9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  if(pid == 0){
     a00:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     a04:	0f 85 89 00 00 00    	jne    a93 <pipe1+0xd2>
    close(fds[0]);
     a0a:	8b 45 d8             	mov    -0x28(%ebp),%eax
     a0d:	83 ec 0c             	sub    $0xc,%esp
     a10:	50                   	push   %eax
     a11:	e8 75 36 00 00       	call   408b <close>
     a16:	83 c4 10             	add    $0x10,%esp
    for(n = 0; n < 5; n++){
     a19:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     a20:	eb 66                	jmp    a88 <pipe1+0xc7>
      for(i = 0; i < 1033; i++)
     a22:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     a29:	eb 19                	jmp    a44 <pipe1+0x83>
        buf[i] = seq++;
     a2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
     a2e:	8d 50 01             	lea    0x1(%eax),%edx
     a31:	89 55 f4             	mov    %edx,-0xc(%ebp)
     a34:	89 c2                	mov    %eax,%edx
     a36:	8b 45 f0             	mov    -0x10(%ebp),%eax
     a39:	05 40 65 00 00       	add    $0x6540,%eax
     a3e:	88 10                	mov    %dl,(%eax)
      for(i = 0; i < 1033; i++)
     a40:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     a44:	81 7d f0 08 04 00 00 	cmpl   $0x408,-0x10(%ebp)
     a4b:	7e de                	jle    a2b <pipe1+0x6a>
      if(write(fds[1], buf, 1033) != 1033){
     a4d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     a50:	83 ec 04             	sub    $0x4,%esp
     a53:	68 09 04 00 00       	push   $0x409
     a58:	68 40 65 00 00       	push   $0x6540
     a5d:	50                   	push   %eax
     a5e:	e8 20 36 00 00       	call   4083 <write>
     a63:	83 c4 10             	add    $0x10,%esp
     a66:	3d 09 04 00 00       	cmp    $0x409,%eax
     a6b:	74 17                	je     a84 <pipe1+0xc3>
        printf(1, "pipe1 oops 1\n");
     a6d:	83 ec 08             	sub    $0x8,%esp
     a70:	68 21 4a 00 00       	push   $0x4a21
     a75:	6a 01                	push   $0x1
     a77:	e8 6b 37 00 00       	call   41e7 <printf>
     a7c:	83 c4 10             	add    $0x10,%esp
        exit();
     a7f:	e8 df 35 00 00       	call   4063 <exit>
    for(n = 0; n < 5; n++){
     a84:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
     a88:	83 7d ec 04          	cmpl   $0x4,-0x14(%ebp)
     a8c:	7e 94                	jle    a22 <pipe1+0x61>
      }
    }
    exit();
     a8e:	e8 d0 35 00 00       	call   4063 <exit>
  } else if(pid > 0){
     a93:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     a97:	0f 8e f4 00 00 00    	jle    b91 <pipe1+0x1d0>
    close(fds[1]);
     a9d:	8b 45 dc             	mov    -0x24(%ebp),%eax
     aa0:	83 ec 0c             	sub    $0xc,%esp
     aa3:	50                   	push   %eax
     aa4:	e8 e2 35 00 00       	call   408b <close>
     aa9:	83 c4 10             	add    $0x10,%esp
    total = 0;
     aac:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    cc = 1;
     ab3:	c7 45 e8 01 00 00 00 	movl   $0x1,-0x18(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     aba:	eb 66                	jmp    b22 <pipe1+0x161>
      for(i = 0; i < n; i++){
     abc:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
     ac3:	eb 3b                	jmp    b00 <pipe1+0x13f>
        if((buf[i] & 0xff) != (seq++ & 0xff)){
     ac5:	8b 45 f0             	mov    -0x10(%ebp),%eax
     ac8:	05 40 65 00 00       	add    $0x6540,%eax
     acd:	0f b6 00             	movzbl (%eax),%eax
     ad0:	0f be c8             	movsbl %al,%ecx
     ad3:	8b 45 f4             	mov    -0xc(%ebp),%eax
     ad6:	8d 50 01             	lea    0x1(%eax),%edx
     ad9:	89 55 f4             	mov    %edx,-0xc(%ebp)
     adc:	31 c8                	xor    %ecx,%eax
     ade:	0f b6 c0             	movzbl %al,%eax
     ae1:	85 c0                	test   %eax,%eax
     ae3:	74 17                	je     afc <pipe1+0x13b>
          printf(1, "pipe1 oops 2\n");
     ae5:	83 ec 08             	sub    $0x8,%esp
     ae8:	68 2f 4a 00 00       	push   $0x4a2f
     aed:	6a 01                	push   $0x1
     aef:	e8 f3 36 00 00       	call   41e7 <printf>
     af4:	83 c4 10             	add    $0x10,%esp
     af7:	e9 ac 00 00 00       	jmp    ba8 <pipe1+0x1e7>
      for(i = 0; i < n; i++){
     afc:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
     b00:	8b 45 f0             	mov    -0x10(%ebp),%eax
     b03:	3b 45 ec             	cmp    -0x14(%ebp),%eax
     b06:	7c bd                	jl     ac5 <pipe1+0x104>
          return;
        }
      }
      total += n;
     b08:	8b 45 ec             	mov    -0x14(%ebp),%eax
     b0b:	01 45 e4             	add    %eax,-0x1c(%ebp)
      cc = cc * 2;
     b0e:	d1 65 e8             	shll   -0x18(%ebp)
      if(cc > sizeof(buf))
     b11:	8b 45 e8             	mov    -0x18(%ebp),%eax
     b14:	3d 00 20 00 00       	cmp    $0x2000,%eax
     b19:	76 07                	jbe    b22 <pipe1+0x161>
        cc = sizeof(buf);
     b1b:	c7 45 e8 00 20 00 00 	movl   $0x2000,-0x18(%ebp)
    while((n = read(fds[0], buf, cc)) > 0){
     b22:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b25:	83 ec 04             	sub    $0x4,%esp
     b28:	ff 75 e8             	push   -0x18(%ebp)
     b2b:	68 40 65 00 00       	push   $0x6540
     b30:	50                   	push   %eax
     b31:	e8 45 35 00 00       	call   407b <read>
     b36:	83 c4 10             	add    $0x10,%esp
     b39:	89 45 ec             	mov    %eax,-0x14(%ebp)
     b3c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     b40:	0f 8f 76 ff ff ff    	jg     abc <pipe1+0xfb>
    }
    if(total != 5 * 1033){
     b46:	81 7d e4 2d 14 00 00 	cmpl   $0x142d,-0x1c(%ebp)
     b4d:	74 1a                	je     b69 <pipe1+0x1a8>
      printf(1, "pipe1 oops 3 total %d\n", total);
     b4f:	83 ec 04             	sub    $0x4,%esp
     b52:	ff 75 e4             	push   -0x1c(%ebp)
     b55:	68 3d 4a 00 00       	push   $0x4a3d
     b5a:	6a 01                	push   $0x1
     b5c:	e8 86 36 00 00       	call   41e7 <printf>
     b61:	83 c4 10             	add    $0x10,%esp
      exit();
     b64:	e8 fa 34 00 00       	call   4063 <exit>
    }
    close(fds[0]);
     b69:	8b 45 d8             	mov    -0x28(%ebp),%eax
     b6c:	83 ec 0c             	sub    $0xc,%esp
     b6f:	50                   	push   %eax
     b70:	e8 16 35 00 00       	call   408b <close>
     b75:	83 c4 10             	add    $0x10,%esp
    wait();
     b78:	e8 ee 34 00 00       	call   406b <wait>
  } else {
    printf(1, "fork() failed\n");
    exit();
  }
  printf(1, "pipe1 ok\n");
     b7d:	83 ec 08             	sub    $0x8,%esp
     b80:	68 63 4a 00 00       	push   $0x4a63
     b85:	6a 01                	push   $0x1
     b87:	e8 5b 36 00 00       	call   41e7 <printf>
     b8c:	83 c4 10             	add    $0x10,%esp
     b8f:	eb 17                	jmp    ba8 <pipe1+0x1e7>
    printf(1, "fork() failed\n");
     b91:	83 ec 08             	sub    $0x8,%esp
     b94:	68 54 4a 00 00       	push   $0x4a54
     b99:	6a 01                	push   $0x1
     b9b:	e8 47 36 00 00       	call   41e7 <printf>
     ba0:	83 c4 10             	add    $0x10,%esp
    exit();
     ba3:	e8 bb 34 00 00       	call   4063 <exit>
}
     ba8:	c9                   	leave  
     ba9:	c3                   	ret    

00000baa <preempt>:

// meant to be run w/ at most two CPUs
void
preempt(void)
{
     baa:	55                   	push   %ebp
     bab:	89 e5                	mov    %esp,%ebp
     bad:	83 ec 28             	sub    $0x28,%esp
  int pid1, pid2, pid3;
  int pfds[2];

  printf(1, "preempt: ");
     bb0:	83 ec 08             	sub    $0x8,%esp
     bb3:	68 6d 4a 00 00       	push   $0x4a6d
     bb8:	6a 01                	push   $0x1
     bba:	e8 28 36 00 00       	call   41e7 <printf>
     bbf:	83 c4 10             	add    $0x10,%esp
  pid1 = fork();
     bc2:	e8 94 34 00 00       	call   405b <fork>
     bc7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pid1 == 0)
     bca:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     bce:	75 02                	jne    bd2 <preempt+0x28>
    for(;;)
     bd0:	eb fe                	jmp    bd0 <preempt+0x26>
      ;

  pid2 = fork();
     bd2:	e8 84 34 00 00       	call   405b <fork>
     bd7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid2 == 0)
     bda:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     bde:	75 02                	jne    be2 <preempt+0x38>
    for(;;)
     be0:	eb fe                	jmp    be0 <preempt+0x36>
      ;

  pipe(pfds);
     be2:	83 ec 0c             	sub    $0xc,%esp
     be5:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     be8:	50                   	push   %eax
     be9:	e8 85 34 00 00       	call   4073 <pipe>
     bee:	83 c4 10             	add    $0x10,%esp
  pid3 = fork();
     bf1:	e8 65 34 00 00       	call   405b <fork>
     bf6:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(pid3 == 0){
     bf9:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     bfd:	75 4d                	jne    c4c <preempt+0xa2>
    close(pfds[0]);
     bff:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c02:	83 ec 0c             	sub    $0xc,%esp
     c05:	50                   	push   %eax
     c06:	e8 80 34 00 00       	call   408b <close>
     c0b:	83 c4 10             	add    $0x10,%esp
    if(write(pfds[1], "x", 1) != 1)
     c0e:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c11:	83 ec 04             	sub    $0x4,%esp
     c14:	6a 01                	push   $0x1
     c16:	68 77 4a 00 00       	push   $0x4a77
     c1b:	50                   	push   %eax
     c1c:	e8 62 34 00 00       	call   4083 <write>
     c21:	83 c4 10             	add    $0x10,%esp
     c24:	83 f8 01             	cmp    $0x1,%eax
     c27:	74 12                	je     c3b <preempt+0x91>
      printf(1, "preempt write error");
     c29:	83 ec 08             	sub    $0x8,%esp
     c2c:	68 79 4a 00 00       	push   $0x4a79
     c31:	6a 01                	push   $0x1
     c33:	e8 af 35 00 00       	call   41e7 <printf>
     c38:	83 c4 10             	add    $0x10,%esp
    close(pfds[1]);
     c3b:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c3e:	83 ec 0c             	sub    $0xc,%esp
     c41:	50                   	push   %eax
     c42:	e8 44 34 00 00       	call   408b <close>
     c47:	83 c4 10             	add    $0x10,%esp
    for(;;)
     c4a:	eb fe                	jmp    c4a <preempt+0xa0>
      ;
  }

  close(pfds[1]);
     c4c:	8b 45 e8             	mov    -0x18(%ebp),%eax
     c4f:	83 ec 0c             	sub    $0xc,%esp
     c52:	50                   	push   %eax
     c53:	e8 33 34 00 00       	call   408b <close>
     c58:	83 c4 10             	add    $0x10,%esp
  if(read(pfds[0], buf, sizeof(buf)) != 1){
     c5b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c5e:	83 ec 04             	sub    $0x4,%esp
     c61:	68 00 20 00 00       	push   $0x2000
     c66:	68 40 65 00 00       	push   $0x6540
     c6b:	50                   	push   %eax
     c6c:	e8 0a 34 00 00       	call   407b <read>
     c71:	83 c4 10             	add    $0x10,%esp
     c74:	83 f8 01             	cmp    $0x1,%eax
     c77:	74 14                	je     c8d <preempt+0xe3>
    printf(1, "preempt read error");
     c79:	83 ec 08             	sub    $0x8,%esp
     c7c:	68 8d 4a 00 00       	push   $0x4a8d
     c81:	6a 01                	push   $0x1
     c83:	e8 5f 35 00 00       	call   41e7 <printf>
     c88:	83 c4 10             	add    $0x10,%esp
     c8b:	eb 7e                	jmp    d0b <preempt+0x161>
    return;
  }
  close(pfds[0]);
     c8d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     c90:	83 ec 0c             	sub    $0xc,%esp
     c93:	50                   	push   %eax
     c94:	e8 f2 33 00 00       	call   408b <close>
     c99:	83 c4 10             	add    $0x10,%esp
  printf(1, "kill... ");
     c9c:	83 ec 08             	sub    $0x8,%esp
     c9f:	68 a0 4a 00 00       	push   $0x4aa0
     ca4:	6a 01                	push   $0x1
     ca6:	e8 3c 35 00 00       	call   41e7 <printf>
     cab:	83 c4 10             	add    $0x10,%esp
  kill(pid1);
     cae:	83 ec 0c             	sub    $0xc,%esp
     cb1:	ff 75 f4             	push   -0xc(%ebp)
     cb4:	e8 da 33 00 00       	call   4093 <kill>
     cb9:	83 c4 10             	add    $0x10,%esp
  kill(pid2);
     cbc:	83 ec 0c             	sub    $0xc,%esp
     cbf:	ff 75 f0             	push   -0x10(%ebp)
     cc2:	e8 cc 33 00 00       	call   4093 <kill>
     cc7:	83 c4 10             	add    $0x10,%esp
  kill(pid3);
     cca:	83 ec 0c             	sub    $0xc,%esp
     ccd:	ff 75 ec             	push   -0x14(%ebp)
     cd0:	e8 be 33 00 00       	call   4093 <kill>
     cd5:	83 c4 10             	add    $0x10,%esp
  printf(1, "wait... ");
     cd8:	83 ec 08             	sub    $0x8,%esp
     cdb:	68 a9 4a 00 00       	push   $0x4aa9
     ce0:	6a 01                	push   $0x1
     ce2:	e8 00 35 00 00       	call   41e7 <printf>
     ce7:	83 c4 10             	add    $0x10,%esp
  wait();
     cea:	e8 7c 33 00 00       	call   406b <wait>
  wait();
     cef:	e8 77 33 00 00       	call   406b <wait>
  wait();
     cf4:	e8 72 33 00 00       	call   406b <wait>
  printf(1, "preempt ok\n");
     cf9:	83 ec 08             	sub    $0x8,%esp
     cfc:	68 b2 4a 00 00       	push   $0x4ab2
     d01:	6a 01                	push   $0x1
     d03:	e8 df 34 00 00       	call   41e7 <printf>
     d08:	83 c4 10             	add    $0x10,%esp
}
     d0b:	c9                   	leave  
     d0c:	c3                   	ret    

00000d0d <exitwait>:

// try to find any races between exit and wait
void
exitwait(void)
{
     d0d:	55                   	push   %ebp
     d0e:	89 e5                	mov    %esp,%ebp
     d10:	83 ec 18             	sub    $0x18,%esp
  int i, pid;

  for(i = 0; i < 100; i++){
     d13:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     d1a:	eb 4f                	jmp    d6b <exitwait+0x5e>
    pid = fork();
     d1c:	e8 3a 33 00 00       	call   405b <fork>
     d21:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0){
     d24:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     d28:	79 14                	jns    d3e <exitwait+0x31>
      printf(1, "fork failed\n");
     d2a:	83 ec 08             	sub    $0x8,%esp
     d2d:	68 41 46 00 00       	push   $0x4641
     d32:	6a 01                	push   $0x1
     d34:	e8 ae 34 00 00       	call   41e7 <printf>
     d39:	83 c4 10             	add    $0x10,%esp
      return;
     d3c:	eb 45                	jmp    d83 <exitwait+0x76>
    }
    if(pid){
     d3e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
     d42:	74 1e                	je     d62 <exitwait+0x55>
      if(wait() != pid){
     d44:	e8 22 33 00 00       	call   406b <wait>
     d49:	39 45 f0             	cmp    %eax,-0x10(%ebp)
     d4c:	74 19                	je     d67 <exitwait+0x5a>
        printf(1, "wait wrong pid\n");
     d4e:	83 ec 08             	sub    $0x8,%esp
     d51:	68 be 4a 00 00       	push   $0x4abe
     d56:	6a 01                	push   $0x1
     d58:	e8 8a 34 00 00       	call   41e7 <printf>
     d5d:	83 c4 10             	add    $0x10,%esp
        return;
     d60:	eb 21                	jmp    d83 <exitwait+0x76>
      }
    } else {
      exit();
     d62:	e8 fc 32 00 00       	call   4063 <exit>
  for(i = 0; i < 100; i++){
     d67:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     d6b:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
     d6f:	7e ab                	jle    d1c <exitwait+0xf>
    }
  }
  printf(1, "exitwait ok\n");
     d71:	83 ec 08             	sub    $0x8,%esp
     d74:	68 ce 4a 00 00       	push   $0x4ace
     d79:	6a 01                	push   $0x1
     d7b:	e8 67 34 00 00       	call   41e7 <printf>
     d80:	83 c4 10             	add    $0x10,%esp
}
     d83:	c9                   	leave  
     d84:	c3                   	ret    

00000d85 <mem>:

void
mem(void)
{
     d85:	55                   	push   %ebp
     d86:	89 e5                	mov    %esp,%ebp
     d88:	83 ec 18             	sub    $0x18,%esp
  void *m1, *m2;
  int pid, ppid;

  printf(1, "mem test\n");
     d8b:	83 ec 08             	sub    $0x8,%esp
     d8e:	68 db 4a 00 00       	push   $0x4adb
     d93:	6a 01                	push   $0x1
     d95:	e8 4d 34 00 00       	call   41e7 <printf>
     d9a:	83 c4 10             	add    $0x10,%esp
  ppid = getpid();
     d9d:	e8 41 33 00 00       	call   40e3 <getpid>
     da2:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if((pid = fork()) == 0){
     da5:	e8 b1 32 00 00       	call   405b <fork>
     daa:	89 45 ec             	mov    %eax,-0x14(%ebp)
     dad:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
     db1:	0f 85 b7 00 00 00    	jne    e6e <mem+0xe9>
    m1 = 0;
     db7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while((m2 = malloc(10001)) != 0){
     dbe:	eb 0e                	jmp    dce <mem+0x49>
      *(char**)m2 = m1;
     dc0:	8b 45 e8             	mov    -0x18(%ebp),%eax
     dc3:	8b 55 f4             	mov    -0xc(%ebp),%edx
     dc6:	89 10                	mov    %edx,(%eax)
      m1 = m2;
     dc8:	8b 45 e8             	mov    -0x18(%ebp),%eax
     dcb:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while((m2 = malloc(10001)) != 0){
     dce:	83 ec 0c             	sub    $0xc,%esp
     dd1:	68 11 27 00 00       	push   $0x2711
     dd6:	e8 e0 36 00 00       	call   44bb <malloc>
     ddb:	83 c4 10             	add    $0x10,%esp
     dde:	89 45 e8             	mov    %eax,-0x18(%ebp)
     de1:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     de5:	75 d9                	jne    dc0 <mem+0x3b>
    }
    while(m1){
     de7:	eb 1c                	jmp    e05 <mem+0x80>
      m2 = *(char**)m1;
     de9:	8b 45 f4             	mov    -0xc(%ebp),%eax
     dec:	8b 00                	mov    (%eax),%eax
     dee:	89 45 e8             	mov    %eax,-0x18(%ebp)
      free(m1);
     df1:	83 ec 0c             	sub    $0xc,%esp
     df4:	ff 75 f4             	push   -0xc(%ebp)
     df7:	e8 7d 35 00 00       	call   4379 <free>
     dfc:	83 c4 10             	add    $0x10,%esp
      m1 = m2;
     dff:	8b 45 e8             	mov    -0x18(%ebp),%eax
     e02:	89 45 f4             	mov    %eax,-0xc(%ebp)
    while(m1){
     e05:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     e09:	75 de                	jne    de9 <mem+0x64>
    }
    m1 = malloc(1024*20);
     e0b:	83 ec 0c             	sub    $0xc,%esp
     e0e:	68 00 50 00 00       	push   $0x5000
     e13:	e8 a3 36 00 00       	call   44bb <malloc>
     e18:	83 c4 10             	add    $0x10,%esp
     e1b:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(m1 == 0){
     e1e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
     e22:	75 25                	jne    e49 <mem+0xc4>
      printf(1, "couldn't allocate mem?!!\n");
     e24:	83 ec 08             	sub    $0x8,%esp
     e27:	68 e5 4a 00 00       	push   $0x4ae5
     e2c:	6a 01                	push   $0x1
     e2e:	e8 b4 33 00 00       	call   41e7 <printf>
     e33:	83 c4 10             	add    $0x10,%esp
      kill(ppid);
     e36:	83 ec 0c             	sub    $0xc,%esp
     e39:	ff 75 f0             	push   -0x10(%ebp)
     e3c:	e8 52 32 00 00       	call   4093 <kill>
     e41:	83 c4 10             	add    $0x10,%esp
      exit();
     e44:	e8 1a 32 00 00       	call   4063 <exit>
    }
    free(m1);
     e49:	83 ec 0c             	sub    $0xc,%esp
     e4c:	ff 75 f4             	push   -0xc(%ebp)
     e4f:	e8 25 35 00 00       	call   4379 <free>
     e54:	83 c4 10             	add    $0x10,%esp
    printf(1, "mem ok\n");
     e57:	83 ec 08             	sub    $0x8,%esp
     e5a:	68 ff 4a 00 00       	push   $0x4aff
     e5f:	6a 01                	push   $0x1
     e61:	e8 81 33 00 00       	call   41e7 <printf>
     e66:	83 c4 10             	add    $0x10,%esp
    exit();
     e69:	e8 f5 31 00 00       	call   4063 <exit>
  } else {
    wait();
     e6e:	e8 f8 31 00 00       	call   406b <wait>
  }
}
     e73:	90                   	nop
     e74:	c9                   	leave  
     e75:	c3                   	ret    

00000e76 <sharedfd>:

// two processes write to the same file descriptor
// is the offset shared? does inode locking work?
void
sharedfd(void)
{
     e76:	55                   	push   %ebp
     e77:	89 e5                	mov    %esp,%ebp
     e79:	83 ec 38             	sub    $0x38,%esp
  int fd, pid, i, n, nc, np;
  char buf[10];

  printf(1, "sharedfd test\n");
     e7c:	83 ec 08             	sub    $0x8,%esp
     e7f:	68 07 4b 00 00       	push   $0x4b07
     e84:	6a 01                	push   $0x1
     e86:	e8 5c 33 00 00       	call   41e7 <printf>
     e8b:	83 c4 10             	add    $0x10,%esp

  unlink("sharedfd");
     e8e:	83 ec 0c             	sub    $0xc,%esp
     e91:	68 16 4b 00 00       	push   $0x4b16
     e96:	e8 18 32 00 00       	call   40b3 <unlink>
     e9b:	83 c4 10             	add    $0x10,%esp
  fd = open("sharedfd", O_CREATE|O_RDWR);
     e9e:	83 ec 08             	sub    $0x8,%esp
     ea1:	68 02 02 00 00       	push   $0x202
     ea6:	68 16 4b 00 00       	push   $0x4b16
     eab:	e8 f3 31 00 00       	call   40a3 <open>
     eb0:	83 c4 10             	add    $0x10,%esp
     eb3:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(fd < 0){
     eb6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     eba:	79 17                	jns    ed3 <sharedfd+0x5d>
    printf(1, "fstests: cannot open sharedfd for writing");
     ebc:	83 ec 08             	sub    $0x8,%esp
     ebf:	68 20 4b 00 00       	push   $0x4b20
     ec4:	6a 01                	push   $0x1
     ec6:	e8 1c 33 00 00       	call   41e7 <printf>
     ecb:	83 c4 10             	add    $0x10,%esp
    return;
     ece:	e9 84 01 00 00       	jmp    1057 <sharedfd+0x1e1>
  }
  pid = fork();
     ed3:	e8 83 31 00 00       	call   405b <fork>
     ed8:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  memset(buf, pid==0?'c':'p', sizeof(buf));
     edb:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     edf:	75 07                	jne    ee8 <sharedfd+0x72>
     ee1:	b8 63 00 00 00       	mov    $0x63,%eax
     ee6:	eb 05                	jmp    eed <sharedfd+0x77>
     ee8:	b8 70 00 00 00       	mov    $0x70,%eax
     eed:	83 ec 04             	sub    $0x4,%esp
     ef0:	6a 0a                	push   $0xa
     ef2:	50                   	push   %eax
     ef3:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     ef6:	50                   	push   %eax
     ef7:	e8 71 2f 00 00       	call   3e6d <memset>
     efc:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 1000; i++){
     eff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     f06:	eb 31                	jmp    f39 <sharedfd+0xc3>
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
     f08:	83 ec 04             	sub    $0x4,%esp
     f0b:	6a 0a                	push   $0xa
     f0d:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     f10:	50                   	push   %eax
     f11:	ff 75 e8             	push   -0x18(%ebp)
     f14:	e8 6a 31 00 00       	call   4083 <write>
     f19:	83 c4 10             	add    $0x10,%esp
     f1c:	83 f8 0a             	cmp    $0xa,%eax
     f1f:	74 14                	je     f35 <sharedfd+0xbf>
      printf(1, "fstests: write sharedfd failed\n");
     f21:	83 ec 08             	sub    $0x8,%esp
     f24:	68 4c 4b 00 00       	push   $0x4b4c
     f29:	6a 01                	push   $0x1
     f2b:	e8 b7 32 00 00       	call   41e7 <printf>
     f30:	83 c4 10             	add    $0x10,%esp
      break;
     f33:	eb 0d                	jmp    f42 <sharedfd+0xcc>
  for(i = 0; i < 1000; i++){
     f35:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     f39:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
     f40:	7e c6                	jle    f08 <sharedfd+0x92>
    }
  }
  if(pid == 0)
     f42:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
     f46:	75 05                	jne    f4d <sharedfd+0xd7>
    exit();
     f48:	e8 16 31 00 00       	call   4063 <exit>
  else
    wait();
     f4d:	e8 19 31 00 00       	call   406b <wait>
  close(fd);
     f52:	83 ec 0c             	sub    $0xc,%esp
     f55:	ff 75 e8             	push   -0x18(%ebp)
     f58:	e8 2e 31 00 00       	call   408b <close>
     f5d:	83 c4 10             	add    $0x10,%esp
  fd = open("sharedfd", 0);
     f60:	83 ec 08             	sub    $0x8,%esp
     f63:	6a 00                	push   $0x0
     f65:	68 16 4b 00 00       	push   $0x4b16
     f6a:	e8 34 31 00 00       	call   40a3 <open>
     f6f:	83 c4 10             	add    $0x10,%esp
     f72:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(fd < 0){
     f75:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
     f79:	79 17                	jns    f92 <sharedfd+0x11c>
    printf(1, "fstests: cannot open sharedfd for reading\n");
     f7b:	83 ec 08             	sub    $0x8,%esp
     f7e:	68 6c 4b 00 00       	push   $0x4b6c
     f83:	6a 01                	push   $0x1
     f85:	e8 5d 32 00 00       	call   41e7 <printf>
     f8a:	83 c4 10             	add    $0x10,%esp
    return;
     f8d:	e9 c5 00 00 00       	jmp    1057 <sharedfd+0x1e1>
  }
  nc = np = 0;
     f92:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
     f99:	8b 45 ec             	mov    -0x14(%ebp),%eax
     f9c:	89 45 f0             	mov    %eax,-0x10(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
     f9f:	eb 3b                	jmp    fdc <sharedfd+0x166>
    for(i = 0; i < sizeof(buf); i++){
     fa1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
     fa8:	eb 2a                	jmp    fd4 <sharedfd+0x15e>
      if(buf[i] == 'c')
     faa:	8d 55 d6             	lea    -0x2a(%ebp),%edx
     fad:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fb0:	01 d0                	add    %edx,%eax
     fb2:	0f b6 00             	movzbl (%eax),%eax
     fb5:	3c 63                	cmp    $0x63,%al
     fb7:	75 04                	jne    fbd <sharedfd+0x147>
        nc++;
     fb9:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
      if(buf[i] == 'p')
     fbd:	8d 55 d6             	lea    -0x2a(%ebp),%edx
     fc0:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fc3:	01 d0                	add    %edx,%eax
     fc5:	0f b6 00             	movzbl (%eax),%eax
     fc8:	3c 70                	cmp    $0x70,%al
     fca:	75 04                	jne    fd0 <sharedfd+0x15a>
        np++;
     fcc:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
    for(i = 0; i < sizeof(buf); i++){
     fd0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
     fd4:	8b 45 f4             	mov    -0xc(%ebp),%eax
     fd7:	83 f8 09             	cmp    $0x9,%eax
     fda:	76 ce                	jbe    faa <sharedfd+0x134>
  while((n = read(fd, buf, sizeof(buf))) > 0){
     fdc:	83 ec 04             	sub    $0x4,%esp
     fdf:	6a 0a                	push   $0xa
     fe1:	8d 45 d6             	lea    -0x2a(%ebp),%eax
     fe4:	50                   	push   %eax
     fe5:	ff 75 e8             	push   -0x18(%ebp)
     fe8:	e8 8e 30 00 00       	call   407b <read>
     fed:	83 c4 10             	add    $0x10,%esp
     ff0:	89 45 e0             	mov    %eax,-0x20(%ebp)
     ff3:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
     ff7:	7f a8                	jg     fa1 <sharedfd+0x12b>
    }
  }
  close(fd);
     ff9:	83 ec 0c             	sub    $0xc,%esp
     ffc:	ff 75 e8             	push   -0x18(%ebp)
     fff:	e8 87 30 00 00       	call   408b <close>
    1004:	83 c4 10             	add    $0x10,%esp
  unlink("sharedfd");
    1007:	83 ec 0c             	sub    $0xc,%esp
    100a:	68 16 4b 00 00       	push   $0x4b16
    100f:	e8 9f 30 00 00       	call   40b3 <unlink>
    1014:	83 c4 10             	add    $0x10,%esp
  if(nc == 10000 && np == 10000){
    1017:	81 7d f0 10 27 00 00 	cmpl   $0x2710,-0x10(%ebp)
    101e:	75 1d                	jne    103d <sharedfd+0x1c7>
    1020:	81 7d ec 10 27 00 00 	cmpl   $0x2710,-0x14(%ebp)
    1027:	75 14                	jne    103d <sharedfd+0x1c7>
    printf(1, "sharedfd ok\n");
    1029:	83 ec 08             	sub    $0x8,%esp
    102c:	68 97 4b 00 00       	push   $0x4b97
    1031:	6a 01                	push   $0x1
    1033:	e8 af 31 00 00       	call   41e7 <printf>
    1038:	83 c4 10             	add    $0x10,%esp
    103b:	eb 1a                	jmp    1057 <sharedfd+0x1e1>
  } else {
    printf(1, "sharedfd oops %d %d\n", nc, np);
    103d:	ff 75 ec             	push   -0x14(%ebp)
    1040:	ff 75 f0             	push   -0x10(%ebp)
    1043:	68 a4 4b 00 00       	push   $0x4ba4
    1048:	6a 01                	push   $0x1
    104a:	e8 98 31 00 00       	call   41e7 <printf>
    104f:	83 c4 10             	add    $0x10,%esp
    exit();
    1052:	e8 0c 30 00 00       	call   4063 <exit>
  }
}
    1057:	c9                   	leave  
    1058:	c3                   	ret    

00001059 <fourfiles>:

// four processes write different files at the same
// time, to test block allocation.
void
fourfiles(void)
{
    1059:	55                   	push   %ebp
    105a:	89 e5                	mov    %esp,%ebp
    105c:	83 ec 38             	sub    $0x38,%esp
  int fd, pid, i, j, n, total, pi;
  char *names[] = { "f0", "f1", "f2", "f3" };
    105f:	c7 45 c8 b9 4b 00 00 	movl   $0x4bb9,-0x38(%ebp)
    1066:	c7 45 cc bc 4b 00 00 	movl   $0x4bbc,-0x34(%ebp)
    106d:	c7 45 d0 bf 4b 00 00 	movl   $0x4bbf,-0x30(%ebp)
    1074:	c7 45 d4 c2 4b 00 00 	movl   $0x4bc2,-0x2c(%ebp)
  char *fname;

  printf(1, "fourfiles test\n");
    107b:	83 ec 08             	sub    $0x8,%esp
    107e:	68 c5 4b 00 00       	push   $0x4bc5
    1083:	6a 01                	push   $0x1
    1085:	e8 5d 31 00 00       	call   41e7 <printf>
    108a:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    108d:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    1094:	e9 f0 00 00 00       	jmp    1189 <fourfiles+0x130>
    fname = names[pi];
    1099:	8b 45 e8             	mov    -0x18(%ebp),%eax
    109c:	8b 44 85 c8          	mov    -0x38(%ebp,%eax,4),%eax
    10a0:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    unlink(fname);
    10a3:	83 ec 0c             	sub    $0xc,%esp
    10a6:	ff 75 e4             	push   -0x1c(%ebp)
    10a9:	e8 05 30 00 00       	call   40b3 <unlink>
    10ae:	83 c4 10             	add    $0x10,%esp

    pid = fork();
    10b1:	e8 a5 2f 00 00       	call   405b <fork>
    10b6:	89 45 d8             	mov    %eax,-0x28(%ebp)
    if(pid < 0){
    10b9:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
    10bd:	79 17                	jns    10d6 <fourfiles+0x7d>
      printf(1, "fork failed\n");
    10bf:	83 ec 08             	sub    $0x8,%esp
    10c2:	68 41 46 00 00       	push   $0x4641
    10c7:	6a 01                	push   $0x1
    10c9:	e8 19 31 00 00       	call   41e7 <printf>
    10ce:	83 c4 10             	add    $0x10,%esp
      exit();
    10d1:	e8 8d 2f 00 00       	call   4063 <exit>
    }

    if(pid == 0){
    10d6:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
    10da:	0f 85 a5 00 00 00    	jne    1185 <fourfiles+0x12c>
      fd = open(fname, O_CREATE | O_RDWR);
    10e0:	83 ec 08             	sub    $0x8,%esp
    10e3:	68 02 02 00 00       	push   $0x202
    10e8:	ff 75 e4             	push   -0x1c(%ebp)
    10eb:	e8 b3 2f 00 00       	call   40a3 <open>
    10f0:	83 c4 10             	add    $0x10,%esp
    10f3:	89 45 e0             	mov    %eax,-0x20(%ebp)
      if(fd < 0){
    10f6:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
    10fa:	79 17                	jns    1113 <fourfiles+0xba>
        printf(1, "create failed\n");
    10fc:	83 ec 08             	sub    $0x8,%esp
    10ff:	68 d5 4b 00 00       	push   $0x4bd5
    1104:	6a 01                	push   $0x1
    1106:	e8 dc 30 00 00       	call   41e7 <printf>
    110b:	83 c4 10             	add    $0x10,%esp
        exit();
    110e:	e8 50 2f 00 00       	call   4063 <exit>
      }

      memset(buf, '0'+pi, 512);
    1113:	8b 45 e8             	mov    -0x18(%ebp),%eax
    1116:	83 c0 30             	add    $0x30,%eax
    1119:	83 ec 04             	sub    $0x4,%esp
    111c:	68 00 02 00 00       	push   $0x200
    1121:	50                   	push   %eax
    1122:	68 40 65 00 00       	push   $0x6540
    1127:	e8 41 2d 00 00       	call   3e6d <memset>
    112c:	83 c4 10             	add    $0x10,%esp
      for(i = 0; i < 12; i++){
    112f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1136:	eb 42                	jmp    117a <fourfiles+0x121>
        if((n = write(fd, buf, 500)) != 500){
    1138:	83 ec 04             	sub    $0x4,%esp
    113b:	68 f4 01 00 00       	push   $0x1f4
    1140:	68 40 65 00 00       	push   $0x6540
    1145:	ff 75 e0             	push   -0x20(%ebp)
    1148:	e8 36 2f 00 00       	call   4083 <write>
    114d:	83 c4 10             	add    $0x10,%esp
    1150:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1153:	81 7d dc f4 01 00 00 	cmpl   $0x1f4,-0x24(%ebp)
    115a:	74 1a                	je     1176 <fourfiles+0x11d>
          printf(1, "write failed %d\n", n);
    115c:	83 ec 04             	sub    $0x4,%esp
    115f:	ff 75 dc             	push   -0x24(%ebp)
    1162:	68 e4 4b 00 00       	push   $0x4be4
    1167:	6a 01                	push   $0x1
    1169:	e8 79 30 00 00       	call   41e7 <printf>
    116e:	83 c4 10             	add    $0x10,%esp
          exit();
    1171:	e8 ed 2e 00 00       	call   4063 <exit>
      for(i = 0; i < 12; i++){
    1176:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    117a:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
    117e:	7e b8                	jle    1138 <fourfiles+0xdf>
        }
      }
      exit();
    1180:	e8 de 2e 00 00       	call   4063 <exit>
  for(pi = 0; pi < 4; pi++){
    1185:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    1189:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
    118d:	0f 8e 06 ff ff ff    	jle    1099 <fourfiles+0x40>
    }
  }

  for(pi = 0; pi < 4; pi++){
    1193:	c7 45 e8 00 00 00 00 	movl   $0x0,-0x18(%ebp)
    119a:	eb 09                	jmp    11a5 <fourfiles+0x14c>
    wait();
    119c:	e8 ca 2e 00 00       	call   406b <wait>
  for(pi = 0; pi < 4; pi++){
    11a1:	83 45 e8 01          	addl   $0x1,-0x18(%ebp)
    11a5:	83 7d e8 03          	cmpl   $0x3,-0x18(%ebp)
    11a9:	7e f1                	jle    119c <fourfiles+0x143>
  }

  for(i = 0; i < 2; i++){
    11ab:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    11b2:	e9 d4 00 00 00       	jmp    128b <fourfiles+0x232>
    fname = names[i];
    11b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    11ba:	8b 44 85 c8          	mov    -0x38(%ebp,%eax,4),%eax
    11be:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    fd = open(fname, 0);
    11c1:	83 ec 08             	sub    $0x8,%esp
    11c4:	6a 00                	push   $0x0
    11c6:	ff 75 e4             	push   -0x1c(%ebp)
    11c9:	e8 d5 2e 00 00       	call   40a3 <open>
    11ce:	83 c4 10             	add    $0x10,%esp
    11d1:	89 45 e0             	mov    %eax,-0x20(%ebp)
    total = 0;
    11d4:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    11db:	eb 4a                	jmp    1227 <fourfiles+0x1ce>
      for(j = 0; j < n; j++){
    11dd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    11e4:	eb 33                	jmp    1219 <fourfiles+0x1c0>
        if(buf[j] != '0'+i){
    11e6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    11e9:	05 40 65 00 00       	add    $0x6540,%eax
    11ee:	0f b6 00             	movzbl (%eax),%eax
    11f1:	0f be c0             	movsbl %al,%eax
    11f4:	8b 55 f4             	mov    -0xc(%ebp),%edx
    11f7:	83 c2 30             	add    $0x30,%edx
    11fa:	39 d0                	cmp    %edx,%eax
    11fc:	74 17                	je     1215 <fourfiles+0x1bc>
          printf(1, "wrong char\n");
    11fe:	83 ec 08             	sub    $0x8,%esp
    1201:	68 f5 4b 00 00       	push   $0x4bf5
    1206:	6a 01                	push   $0x1
    1208:	e8 da 2f 00 00       	call   41e7 <printf>
    120d:	83 c4 10             	add    $0x10,%esp
          exit();
    1210:	e8 4e 2e 00 00       	call   4063 <exit>
      for(j = 0; j < n; j++){
    1215:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    1219:	8b 45 f0             	mov    -0x10(%ebp),%eax
    121c:	3b 45 dc             	cmp    -0x24(%ebp),%eax
    121f:	7c c5                	jl     11e6 <fourfiles+0x18d>
        }
      }
      total += n;
    1221:	8b 45 dc             	mov    -0x24(%ebp),%eax
    1224:	01 45 ec             	add    %eax,-0x14(%ebp)
    while((n = read(fd, buf, sizeof(buf))) > 0){
    1227:	83 ec 04             	sub    $0x4,%esp
    122a:	68 00 20 00 00       	push   $0x2000
    122f:	68 40 65 00 00       	push   $0x6540
    1234:	ff 75 e0             	push   -0x20(%ebp)
    1237:	e8 3f 2e 00 00       	call   407b <read>
    123c:	83 c4 10             	add    $0x10,%esp
    123f:	89 45 dc             	mov    %eax,-0x24(%ebp)
    1242:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
    1246:	7f 95                	jg     11dd <fourfiles+0x184>
    }
    close(fd);
    1248:	83 ec 0c             	sub    $0xc,%esp
    124b:	ff 75 e0             	push   -0x20(%ebp)
    124e:	e8 38 2e 00 00       	call   408b <close>
    1253:	83 c4 10             	add    $0x10,%esp
    if(total != 12*500){
    1256:	81 7d ec 70 17 00 00 	cmpl   $0x1770,-0x14(%ebp)
    125d:	74 1a                	je     1279 <fourfiles+0x220>
      printf(1, "wrong length %d\n", total);
    125f:	83 ec 04             	sub    $0x4,%esp
    1262:	ff 75 ec             	push   -0x14(%ebp)
    1265:	68 01 4c 00 00       	push   $0x4c01
    126a:	6a 01                	push   $0x1
    126c:	e8 76 2f 00 00       	call   41e7 <printf>
    1271:	83 c4 10             	add    $0x10,%esp
      exit();
    1274:	e8 ea 2d 00 00       	call   4063 <exit>
    }
    unlink(fname);
    1279:	83 ec 0c             	sub    $0xc,%esp
    127c:	ff 75 e4             	push   -0x1c(%ebp)
    127f:	e8 2f 2e 00 00       	call   40b3 <unlink>
    1284:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 2; i++){
    1287:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    128b:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
    128f:	0f 8e 22 ff ff ff    	jle    11b7 <fourfiles+0x15e>
  }

  printf(1, "fourfiles ok\n");
    1295:	83 ec 08             	sub    $0x8,%esp
    1298:	68 12 4c 00 00       	push   $0x4c12
    129d:	6a 01                	push   $0x1
    129f:	e8 43 2f 00 00       	call   41e7 <printf>
    12a4:	83 c4 10             	add    $0x10,%esp
}
    12a7:	90                   	nop
    12a8:	c9                   	leave  
    12a9:	c3                   	ret    

000012aa <createdelete>:

// four processes create and delete different files in same directory
void
createdelete(void)
{
    12aa:	55                   	push   %ebp
    12ab:	89 e5                	mov    %esp,%ebp
    12ad:	83 ec 38             	sub    $0x38,%esp
  enum { N = 20 };
  int pid, i, fd, pi;
  char name[32];

  printf(1, "createdelete test\n");
    12b0:	83 ec 08             	sub    $0x8,%esp
    12b3:	68 20 4c 00 00       	push   $0x4c20
    12b8:	6a 01                	push   $0x1
    12ba:	e8 28 2f 00 00       	call   41e7 <printf>
    12bf:	83 c4 10             	add    $0x10,%esp

  for(pi = 0; pi < 4; pi++){
    12c2:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    12c9:	e9 f6 00 00 00       	jmp    13c4 <createdelete+0x11a>
    pid = fork();
    12ce:	e8 88 2d 00 00       	call   405b <fork>
    12d3:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pid < 0){
    12d6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    12da:	79 17                	jns    12f3 <createdelete+0x49>
      printf(1, "fork failed\n");
    12dc:	83 ec 08             	sub    $0x8,%esp
    12df:	68 41 46 00 00       	push   $0x4641
    12e4:	6a 01                	push   $0x1
    12e6:	e8 fc 2e 00 00       	call   41e7 <printf>
    12eb:	83 c4 10             	add    $0x10,%esp
      exit();
    12ee:	e8 70 2d 00 00       	call   4063 <exit>
    }

    if(pid == 0){
    12f3:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    12f7:	0f 85 c3 00 00 00    	jne    13c0 <createdelete+0x116>
      name[0] = 'p' + pi;
    12fd:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1300:	83 c0 70             	add    $0x70,%eax
    1303:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[2] = '\0';
    1306:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
      for(i = 0; i < N; i++){
    130a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1311:	e9 9b 00 00 00       	jmp    13b1 <createdelete+0x107>
        name[1] = '0' + i;
    1316:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1319:	83 c0 30             	add    $0x30,%eax
    131c:	88 45 c9             	mov    %al,-0x37(%ebp)
        fd = open(name, O_CREATE | O_RDWR);
    131f:	83 ec 08             	sub    $0x8,%esp
    1322:	68 02 02 00 00       	push   $0x202
    1327:	8d 45 c8             	lea    -0x38(%ebp),%eax
    132a:	50                   	push   %eax
    132b:	e8 73 2d 00 00       	call   40a3 <open>
    1330:	83 c4 10             	add    $0x10,%esp
    1333:	89 45 ec             	mov    %eax,-0x14(%ebp)
        if(fd < 0){
    1336:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    133a:	79 17                	jns    1353 <createdelete+0xa9>
          printf(1, "create failed\n");
    133c:	83 ec 08             	sub    $0x8,%esp
    133f:	68 d5 4b 00 00       	push   $0x4bd5
    1344:	6a 01                	push   $0x1
    1346:	e8 9c 2e 00 00       	call   41e7 <printf>
    134b:	83 c4 10             	add    $0x10,%esp
          exit();
    134e:	e8 10 2d 00 00       	call   4063 <exit>
        }
        close(fd);
    1353:	83 ec 0c             	sub    $0xc,%esp
    1356:	ff 75 ec             	push   -0x14(%ebp)
    1359:	e8 2d 2d 00 00       	call   408b <close>
    135e:	83 c4 10             	add    $0x10,%esp
        if(i > 0 && (i % 2 ) == 0){
    1361:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1365:	7e 46                	jle    13ad <createdelete+0x103>
    1367:	8b 45 f4             	mov    -0xc(%ebp),%eax
    136a:	83 e0 01             	and    $0x1,%eax
    136d:	85 c0                	test   %eax,%eax
    136f:	75 3c                	jne    13ad <createdelete+0x103>
          name[1] = '0' + (i / 2);
    1371:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1374:	89 c2                	mov    %eax,%edx
    1376:	c1 ea 1f             	shr    $0x1f,%edx
    1379:	01 d0                	add    %edx,%eax
    137b:	d1 f8                	sar    %eax
    137d:	83 c0 30             	add    $0x30,%eax
    1380:	88 45 c9             	mov    %al,-0x37(%ebp)
          if(unlink(name) < 0){
    1383:	83 ec 0c             	sub    $0xc,%esp
    1386:	8d 45 c8             	lea    -0x38(%ebp),%eax
    1389:	50                   	push   %eax
    138a:	e8 24 2d 00 00       	call   40b3 <unlink>
    138f:	83 c4 10             	add    $0x10,%esp
    1392:	85 c0                	test   %eax,%eax
    1394:	79 17                	jns    13ad <createdelete+0x103>
            printf(1, "unlink failed\n");
    1396:	83 ec 08             	sub    $0x8,%esp
    1399:	68 c4 46 00 00       	push   $0x46c4
    139e:	6a 01                	push   $0x1
    13a0:	e8 42 2e 00 00       	call   41e7 <printf>
    13a5:	83 c4 10             	add    $0x10,%esp
            exit();
    13a8:	e8 b6 2c 00 00       	call   4063 <exit>
      for(i = 0; i < N; i++){
    13ad:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    13b1:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    13b5:	0f 8e 5b ff ff ff    	jle    1316 <createdelete+0x6c>
          }
        }
      }
      exit();
    13bb:	e8 a3 2c 00 00       	call   4063 <exit>
  for(pi = 0; pi < 4; pi++){
    13c0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    13c4:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    13c8:	0f 8e 00 ff ff ff    	jle    12ce <createdelete+0x24>
    }
  }

  for(pi = 0; pi < 4; pi++){
    13ce:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    13d5:	eb 09                	jmp    13e0 <createdelete+0x136>
    wait();
    13d7:	e8 8f 2c 00 00       	call   406b <wait>
  for(pi = 0; pi < 4; pi++){
    13dc:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    13e0:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    13e4:	7e f1                	jle    13d7 <createdelete+0x12d>
  }

  name[0] = name[1] = name[2] = 0;
    13e6:	c6 45 ca 00          	movb   $0x0,-0x36(%ebp)
    13ea:	0f b6 45 ca          	movzbl -0x36(%ebp),%eax
    13ee:	88 45 c9             	mov    %al,-0x37(%ebp)
    13f1:	0f b6 45 c9          	movzbl -0x37(%ebp),%eax
    13f5:	88 45 c8             	mov    %al,-0x38(%ebp)
  for(i = 0; i < N; i++){
    13f8:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    13ff:	e9 b2 00 00 00       	jmp    14b6 <createdelete+0x20c>
    for(pi = 0; pi < 4; pi++){
    1404:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    140b:	e9 98 00 00 00       	jmp    14a8 <createdelete+0x1fe>
      name[0] = 'p' + pi;
    1410:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1413:	83 c0 70             	add    $0x70,%eax
    1416:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    1419:	8b 45 f4             	mov    -0xc(%ebp),%eax
    141c:	83 c0 30             	add    $0x30,%eax
    141f:	88 45 c9             	mov    %al,-0x37(%ebp)
      fd = open(name, 0);
    1422:	83 ec 08             	sub    $0x8,%esp
    1425:	6a 00                	push   $0x0
    1427:	8d 45 c8             	lea    -0x38(%ebp),%eax
    142a:	50                   	push   %eax
    142b:	e8 73 2c 00 00       	call   40a3 <open>
    1430:	83 c4 10             	add    $0x10,%esp
    1433:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if((i == 0 || i >= N/2) && fd < 0){
    1436:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    143a:	74 06                	je     1442 <createdelete+0x198>
    143c:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    1440:	7e 21                	jle    1463 <createdelete+0x1b9>
    1442:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1446:	79 1b                	jns    1463 <createdelete+0x1b9>
        printf(1, "oops createdelete %s didn't exist\n", name);
    1448:	83 ec 04             	sub    $0x4,%esp
    144b:	8d 45 c8             	lea    -0x38(%ebp),%eax
    144e:	50                   	push   %eax
    144f:	68 34 4c 00 00       	push   $0x4c34
    1454:	6a 01                	push   $0x1
    1456:	e8 8c 2d 00 00       	call   41e7 <printf>
    145b:	83 c4 10             	add    $0x10,%esp
        exit();
    145e:	e8 00 2c 00 00       	call   4063 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1463:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1467:	7e 27                	jle    1490 <createdelete+0x1e6>
    1469:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
    146d:	7f 21                	jg     1490 <createdelete+0x1e6>
    146f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1473:	78 1b                	js     1490 <createdelete+0x1e6>
        printf(1, "oops createdelete %s did exist\n", name);
    1475:	83 ec 04             	sub    $0x4,%esp
    1478:	8d 45 c8             	lea    -0x38(%ebp),%eax
    147b:	50                   	push   %eax
    147c:	68 58 4c 00 00       	push   $0x4c58
    1481:	6a 01                	push   $0x1
    1483:	e8 5f 2d 00 00       	call   41e7 <printf>
    1488:	83 c4 10             	add    $0x10,%esp
        exit();
    148b:	e8 d3 2b 00 00       	call   4063 <exit>
      }
      if(fd >= 0)
    1490:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1494:	78 0e                	js     14a4 <createdelete+0x1fa>
        close(fd);
    1496:	83 ec 0c             	sub    $0xc,%esp
    1499:	ff 75 ec             	push   -0x14(%ebp)
    149c:	e8 ea 2b 00 00       	call   408b <close>
    14a1:	83 c4 10             	add    $0x10,%esp
    for(pi = 0; pi < 4; pi++){
    14a4:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    14a8:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    14ac:	0f 8e 5e ff ff ff    	jle    1410 <createdelete+0x166>
  for(i = 0; i < N; i++){
    14b2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    14b6:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    14ba:	0f 8e 44 ff ff ff    	jle    1404 <createdelete+0x15a>
    }
  }

  for(i = 0; i < N; i++){
    14c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    14c7:	eb 38                	jmp    1501 <createdelete+0x257>
    for(pi = 0; pi < 4; pi++){
    14c9:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    14d0:	eb 25                	jmp    14f7 <createdelete+0x24d>
      name[0] = 'p' + i;
    14d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14d5:	83 c0 70             	add    $0x70,%eax
    14d8:	88 45 c8             	mov    %al,-0x38(%ebp)
      name[1] = '0' + i;
    14db:	8b 45 f4             	mov    -0xc(%ebp),%eax
    14de:	83 c0 30             	add    $0x30,%eax
    14e1:	88 45 c9             	mov    %al,-0x37(%ebp)
      unlink(name);
    14e4:	83 ec 0c             	sub    $0xc,%esp
    14e7:	8d 45 c8             	lea    -0x38(%ebp),%eax
    14ea:	50                   	push   %eax
    14eb:	e8 c3 2b 00 00       	call   40b3 <unlink>
    14f0:	83 c4 10             	add    $0x10,%esp
    for(pi = 0; pi < 4; pi++){
    14f3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    14f7:	83 7d f0 03          	cmpl   $0x3,-0x10(%ebp)
    14fb:	7e d5                	jle    14d2 <createdelete+0x228>
  for(i = 0; i < N; i++){
    14fd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1501:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    1505:	7e c2                	jle    14c9 <createdelete+0x21f>
    }
  }

  printf(1, "createdelete ok\n");
    1507:	83 ec 08             	sub    $0x8,%esp
    150a:	68 78 4c 00 00       	push   $0x4c78
    150f:	6a 01                	push   $0x1
    1511:	e8 d1 2c 00 00       	call   41e7 <printf>
    1516:	83 c4 10             	add    $0x10,%esp
}
    1519:	90                   	nop
    151a:	c9                   	leave  
    151b:	c3                   	ret    

0000151c <unlinkread>:

// can I unlink a file and still read it?
void
unlinkread(void)
{
    151c:	55                   	push   %ebp
    151d:	89 e5                	mov    %esp,%ebp
    151f:	83 ec 18             	sub    $0x18,%esp
  int fd, fd1;

  printf(1, "unlinkread test\n");
    1522:	83 ec 08             	sub    $0x8,%esp
    1525:	68 89 4c 00 00       	push   $0x4c89
    152a:	6a 01                	push   $0x1
    152c:	e8 b6 2c 00 00       	call   41e7 <printf>
    1531:	83 c4 10             	add    $0x10,%esp
  fd = open("unlinkread", O_CREATE | O_RDWR);
    1534:	83 ec 08             	sub    $0x8,%esp
    1537:	68 02 02 00 00       	push   $0x202
    153c:	68 9a 4c 00 00       	push   $0x4c9a
    1541:	e8 5d 2b 00 00       	call   40a3 <open>
    1546:	83 c4 10             	add    $0x10,%esp
    1549:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    154c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1550:	79 17                	jns    1569 <unlinkread+0x4d>
    printf(1, "create unlinkread failed\n");
    1552:	83 ec 08             	sub    $0x8,%esp
    1555:	68 a5 4c 00 00       	push   $0x4ca5
    155a:	6a 01                	push   $0x1
    155c:	e8 86 2c 00 00       	call   41e7 <printf>
    1561:	83 c4 10             	add    $0x10,%esp
    exit();
    1564:	e8 fa 2a 00 00       	call   4063 <exit>
  }
  write(fd, "hello", 5);
    1569:	83 ec 04             	sub    $0x4,%esp
    156c:	6a 05                	push   $0x5
    156e:	68 bf 4c 00 00       	push   $0x4cbf
    1573:	ff 75 f4             	push   -0xc(%ebp)
    1576:	e8 08 2b 00 00       	call   4083 <write>
    157b:	83 c4 10             	add    $0x10,%esp
  close(fd);
    157e:	83 ec 0c             	sub    $0xc,%esp
    1581:	ff 75 f4             	push   -0xc(%ebp)
    1584:	e8 02 2b 00 00       	call   408b <close>
    1589:	83 c4 10             	add    $0x10,%esp

  fd = open("unlinkread", O_RDWR);
    158c:	83 ec 08             	sub    $0x8,%esp
    158f:	6a 02                	push   $0x2
    1591:	68 9a 4c 00 00       	push   $0x4c9a
    1596:	e8 08 2b 00 00       	call   40a3 <open>
    159b:	83 c4 10             	add    $0x10,%esp
    159e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    15a1:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    15a5:	79 17                	jns    15be <unlinkread+0xa2>
    printf(1, "open unlinkread failed\n");
    15a7:	83 ec 08             	sub    $0x8,%esp
    15aa:	68 c5 4c 00 00       	push   $0x4cc5
    15af:	6a 01                	push   $0x1
    15b1:	e8 31 2c 00 00       	call   41e7 <printf>
    15b6:	83 c4 10             	add    $0x10,%esp
    exit();
    15b9:	e8 a5 2a 00 00       	call   4063 <exit>
  }
  if(unlink("unlinkread") != 0){
    15be:	83 ec 0c             	sub    $0xc,%esp
    15c1:	68 9a 4c 00 00       	push   $0x4c9a
    15c6:	e8 e8 2a 00 00       	call   40b3 <unlink>
    15cb:	83 c4 10             	add    $0x10,%esp
    15ce:	85 c0                	test   %eax,%eax
    15d0:	74 17                	je     15e9 <unlinkread+0xcd>
    printf(1, "unlink unlinkread failed\n");
    15d2:	83 ec 08             	sub    $0x8,%esp
    15d5:	68 dd 4c 00 00       	push   $0x4cdd
    15da:	6a 01                	push   $0x1
    15dc:	e8 06 2c 00 00       	call   41e7 <printf>
    15e1:	83 c4 10             	add    $0x10,%esp
    exit();
    15e4:	e8 7a 2a 00 00       	call   4063 <exit>
  }

  fd1 = open("unlinkread", O_CREATE | O_RDWR);
    15e9:	83 ec 08             	sub    $0x8,%esp
    15ec:	68 02 02 00 00       	push   $0x202
    15f1:	68 9a 4c 00 00       	push   $0x4c9a
    15f6:	e8 a8 2a 00 00       	call   40a3 <open>
    15fb:	83 c4 10             	add    $0x10,%esp
    15fe:	89 45 f0             	mov    %eax,-0x10(%ebp)
  write(fd1, "yyy", 3);
    1601:	83 ec 04             	sub    $0x4,%esp
    1604:	6a 03                	push   $0x3
    1606:	68 f7 4c 00 00       	push   $0x4cf7
    160b:	ff 75 f0             	push   -0x10(%ebp)
    160e:	e8 70 2a 00 00       	call   4083 <write>
    1613:	83 c4 10             	add    $0x10,%esp
  close(fd1);
    1616:	83 ec 0c             	sub    $0xc,%esp
    1619:	ff 75 f0             	push   -0x10(%ebp)
    161c:	e8 6a 2a 00 00       	call   408b <close>
    1621:	83 c4 10             	add    $0x10,%esp

  if(read(fd, buf, sizeof(buf)) != 5){
    1624:	83 ec 04             	sub    $0x4,%esp
    1627:	68 00 20 00 00       	push   $0x2000
    162c:	68 40 65 00 00       	push   $0x6540
    1631:	ff 75 f4             	push   -0xc(%ebp)
    1634:	e8 42 2a 00 00       	call   407b <read>
    1639:	83 c4 10             	add    $0x10,%esp
    163c:	83 f8 05             	cmp    $0x5,%eax
    163f:	74 17                	je     1658 <unlinkread+0x13c>
    printf(1, "unlinkread read failed");
    1641:	83 ec 08             	sub    $0x8,%esp
    1644:	68 fb 4c 00 00       	push   $0x4cfb
    1649:	6a 01                	push   $0x1
    164b:	e8 97 2b 00 00       	call   41e7 <printf>
    1650:	83 c4 10             	add    $0x10,%esp
    exit();
    1653:	e8 0b 2a 00 00       	call   4063 <exit>
  }
  if(buf[0] != 'h'){
    1658:	0f b6 05 40 65 00 00 	movzbl 0x6540,%eax
    165f:	3c 68                	cmp    $0x68,%al
    1661:	74 17                	je     167a <unlinkread+0x15e>
    printf(1, "unlinkread wrong data\n");
    1663:	83 ec 08             	sub    $0x8,%esp
    1666:	68 12 4d 00 00       	push   $0x4d12
    166b:	6a 01                	push   $0x1
    166d:	e8 75 2b 00 00       	call   41e7 <printf>
    1672:	83 c4 10             	add    $0x10,%esp
    exit();
    1675:	e8 e9 29 00 00       	call   4063 <exit>
  }
  if(write(fd, buf, 10) != 10){
    167a:	83 ec 04             	sub    $0x4,%esp
    167d:	6a 0a                	push   $0xa
    167f:	68 40 65 00 00       	push   $0x6540
    1684:	ff 75 f4             	push   -0xc(%ebp)
    1687:	e8 f7 29 00 00       	call   4083 <write>
    168c:	83 c4 10             	add    $0x10,%esp
    168f:	83 f8 0a             	cmp    $0xa,%eax
    1692:	74 17                	je     16ab <unlinkread+0x18f>
    printf(1, "unlinkread write failed\n");
    1694:	83 ec 08             	sub    $0x8,%esp
    1697:	68 29 4d 00 00       	push   $0x4d29
    169c:	6a 01                	push   $0x1
    169e:	e8 44 2b 00 00       	call   41e7 <printf>
    16a3:	83 c4 10             	add    $0x10,%esp
    exit();
    16a6:	e8 b8 29 00 00       	call   4063 <exit>
  }
  close(fd);
    16ab:	83 ec 0c             	sub    $0xc,%esp
    16ae:	ff 75 f4             	push   -0xc(%ebp)
    16b1:	e8 d5 29 00 00       	call   408b <close>
    16b6:	83 c4 10             	add    $0x10,%esp
  unlink("unlinkread");
    16b9:	83 ec 0c             	sub    $0xc,%esp
    16bc:	68 9a 4c 00 00       	push   $0x4c9a
    16c1:	e8 ed 29 00 00       	call   40b3 <unlink>
    16c6:	83 c4 10             	add    $0x10,%esp
  printf(1, "unlinkread ok\n");
    16c9:	83 ec 08             	sub    $0x8,%esp
    16cc:	68 42 4d 00 00       	push   $0x4d42
    16d1:	6a 01                	push   $0x1
    16d3:	e8 0f 2b 00 00       	call   41e7 <printf>
    16d8:	83 c4 10             	add    $0x10,%esp
}
    16db:	90                   	nop
    16dc:	c9                   	leave  
    16dd:	c3                   	ret    

000016de <linktest>:

void
linktest(void)
{
    16de:	55                   	push   %ebp
    16df:	89 e5                	mov    %esp,%ebp
    16e1:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(1, "linktest\n");
    16e4:	83 ec 08             	sub    $0x8,%esp
    16e7:	68 51 4d 00 00       	push   $0x4d51
    16ec:	6a 01                	push   $0x1
    16ee:	e8 f4 2a 00 00       	call   41e7 <printf>
    16f3:	83 c4 10             	add    $0x10,%esp

  unlink("lf1");
    16f6:	83 ec 0c             	sub    $0xc,%esp
    16f9:	68 5b 4d 00 00       	push   $0x4d5b
    16fe:	e8 b0 29 00 00       	call   40b3 <unlink>
    1703:	83 c4 10             	add    $0x10,%esp
  unlink("lf2");
    1706:	83 ec 0c             	sub    $0xc,%esp
    1709:	68 5f 4d 00 00       	push   $0x4d5f
    170e:	e8 a0 29 00 00       	call   40b3 <unlink>
    1713:	83 c4 10             	add    $0x10,%esp

  fd = open("lf1", O_CREATE|O_RDWR);
    1716:	83 ec 08             	sub    $0x8,%esp
    1719:	68 02 02 00 00       	push   $0x202
    171e:	68 5b 4d 00 00       	push   $0x4d5b
    1723:	e8 7b 29 00 00       	call   40a3 <open>
    1728:	83 c4 10             	add    $0x10,%esp
    172b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    172e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1732:	79 17                	jns    174b <linktest+0x6d>
    printf(1, "create lf1 failed\n");
    1734:	83 ec 08             	sub    $0x8,%esp
    1737:	68 63 4d 00 00       	push   $0x4d63
    173c:	6a 01                	push   $0x1
    173e:	e8 a4 2a 00 00       	call   41e7 <printf>
    1743:	83 c4 10             	add    $0x10,%esp
    exit();
    1746:	e8 18 29 00 00       	call   4063 <exit>
  }
  if(write(fd, "hello", 5) != 5){
    174b:	83 ec 04             	sub    $0x4,%esp
    174e:	6a 05                	push   $0x5
    1750:	68 bf 4c 00 00       	push   $0x4cbf
    1755:	ff 75 f4             	push   -0xc(%ebp)
    1758:	e8 26 29 00 00       	call   4083 <write>
    175d:	83 c4 10             	add    $0x10,%esp
    1760:	83 f8 05             	cmp    $0x5,%eax
    1763:	74 17                	je     177c <linktest+0x9e>
    printf(1, "write lf1 failed\n");
    1765:	83 ec 08             	sub    $0x8,%esp
    1768:	68 76 4d 00 00       	push   $0x4d76
    176d:	6a 01                	push   $0x1
    176f:	e8 73 2a 00 00       	call   41e7 <printf>
    1774:	83 c4 10             	add    $0x10,%esp
    exit();
    1777:	e8 e7 28 00 00       	call   4063 <exit>
  }
  close(fd);
    177c:	83 ec 0c             	sub    $0xc,%esp
    177f:	ff 75 f4             	push   -0xc(%ebp)
    1782:	e8 04 29 00 00       	call   408b <close>
    1787:	83 c4 10             	add    $0x10,%esp

  if(link("lf1", "lf2") < 0){
    178a:	83 ec 08             	sub    $0x8,%esp
    178d:	68 5f 4d 00 00       	push   $0x4d5f
    1792:	68 5b 4d 00 00       	push   $0x4d5b
    1797:	e8 27 29 00 00       	call   40c3 <link>
    179c:	83 c4 10             	add    $0x10,%esp
    179f:	85 c0                	test   %eax,%eax
    17a1:	79 17                	jns    17ba <linktest+0xdc>
    printf(1, "link lf1 lf2 failed\n");
    17a3:	83 ec 08             	sub    $0x8,%esp
    17a6:	68 88 4d 00 00       	push   $0x4d88
    17ab:	6a 01                	push   $0x1
    17ad:	e8 35 2a 00 00       	call   41e7 <printf>
    17b2:	83 c4 10             	add    $0x10,%esp
    exit();
    17b5:	e8 a9 28 00 00       	call   4063 <exit>
  }
  unlink("lf1");
    17ba:	83 ec 0c             	sub    $0xc,%esp
    17bd:	68 5b 4d 00 00       	push   $0x4d5b
    17c2:	e8 ec 28 00 00       	call   40b3 <unlink>
    17c7:	83 c4 10             	add    $0x10,%esp

  if(open("lf1", 0) >= 0){
    17ca:	83 ec 08             	sub    $0x8,%esp
    17cd:	6a 00                	push   $0x0
    17cf:	68 5b 4d 00 00       	push   $0x4d5b
    17d4:	e8 ca 28 00 00       	call   40a3 <open>
    17d9:	83 c4 10             	add    $0x10,%esp
    17dc:	85 c0                	test   %eax,%eax
    17de:	78 17                	js     17f7 <linktest+0x119>
    printf(1, "unlinked lf1 but it is still there!\n");
    17e0:	83 ec 08             	sub    $0x8,%esp
    17e3:	68 a0 4d 00 00       	push   $0x4da0
    17e8:	6a 01                	push   $0x1
    17ea:	e8 f8 29 00 00       	call   41e7 <printf>
    17ef:	83 c4 10             	add    $0x10,%esp
    exit();
    17f2:	e8 6c 28 00 00       	call   4063 <exit>
  }

  fd = open("lf2", 0);
    17f7:	83 ec 08             	sub    $0x8,%esp
    17fa:	6a 00                	push   $0x0
    17fc:	68 5f 4d 00 00       	push   $0x4d5f
    1801:	e8 9d 28 00 00       	call   40a3 <open>
    1806:	83 c4 10             	add    $0x10,%esp
    1809:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    180c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1810:	79 17                	jns    1829 <linktest+0x14b>
    printf(1, "open lf2 failed\n");
    1812:	83 ec 08             	sub    $0x8,%esp
    1815:	68 c5 4d 00 00       	push   $0x4dc5
    181a:	6a 01                	push   $0x1
    181c:	e8 c6 29 00 00       	call   41e7 <printf>
    1821:	83 c4 10             	add    $0x10,%esp
    exit();
    1824:	e8 3a 28 00 00       	call   4063 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 5){
    1829:	83 ec 04             	sub    $0x4,%esp
    182c:	68 00 20 00 00       	push   $0x2000
    1831:	68 40 65 00 00       	push   $0x6540
    1836:	ff 75 f4             	push   -0xc(%ebp)
    1839:	e8 3d 28 00 00       	call   407b <read>
    183e:	83 c4 10             	add    $0x10,%esp
    1841:	83 f8 05             	cmp    $0x5,%eax
    1844:	74 17                	je     185d <linktest+0x17f>
    printf(1, "read lf2 failed\n");
    1846:	83 ec 08             	sub    $0x8,%esp
    1849:	68 d6 4d 00 00       	push   $0x4dd6
    184e:	6a 01                	push   $0x1
    1850:	e8 92 29 00 00       	call   41e7 <printf>
    1855:	83 c4 10             	add    $0x10,%esp
    exit();
    1858:	e8 06 28 00 00       	call   4063 <exit>
  }
  close(fd);
    185d:	83 ec 0c             	sub    $0xc,%esp
    1860:	ff 75 f4             	push   -0xc(%ebp)
    1863:	e8 23 28 00 00       	call   408b <close>
    1868:	83 c4 10             	add    $0x10,%esp

  if(link("lf2", "lf2") >= 0){
    186b:	83 ec 08             	sub    $0x8,%esp
    186e:	68 5f 4d 00 00       	push   $0x4d5f
    1873:	68 5f 4d 00 00       	push   $0x4d5f
    1878:	e8 46 28 00 00       	call   40c3 <link>
    187d:	83 c4 10             	add    $0x10,%esp
    1880:	85 c0                	test   %eax,%eax
    1882:	78 17                	js     189b <linktest+0x1bd>
    printf(1, "link lf2 lf2 succeeded! oops\n");
    1884:	83 ec 08             	sub    $0x8,%esp
    1887:	68 e7 4d 00 00       	push   $0x4de7
    188c:	6a 01                	push   $0x1
    188e:	e8 54 29 00 00       	call   41e7 <printf>
    1893:	83 c4 10             	add    $0x10,%esp
    exit();
    1896:	e8 c8 27 00 00       	call   4063 <exit>
  }

  unlink("lf2");
    189b:	83 ec 0c             	sub    $0xc,%esp
    189e:	68 5f 4d 00 00       	push   $0x4d5f
    18a3:	e8 0b 28 00 00       	call   40b3 <unlink>
    18a8:	83 c4 10             	add    $0x10,%esp
  if(link("lf2", "lf1") >= 0){
    18ab:	83 ec 08             	sub    $0x8,%esp
    18ae:	68 5b 4d 00 00       	push   $0x4d5b
    18b3:	68 5f 4d 00 00       	push   $0x4d5f
    18b8:	e8 06 28 00 00       	call   40c3 <link>
    18bd:	83 c4 10             	add    $0x10,%esp
    18c0:	85 c0                	test   %eax,%eax
    18c2:	78 17                	js     18db <linktest+0x1fd>
    printf(1, "link non-existant succeeded! oops\n");
    18c4:	83 ec 08             	sub    $0x8,%esp
    18c7:	68 08 4e 00 00       	push   $0x4e08
    18cc:	6a 01                	push   $0x1
    18ce:	e8 14 29 00 00       	call   41e7 <printf>
    18d3:	83 c4 10             	add    $0x10,%esp
    exit();
    18d6:	e8 88 27 00 00       	call   4063 <exit>
  }

  if(link(".", "lf1") >= 0){
    18db:	83 ec 08             	sub    $0x8,%esp
    18de:	68 5b 4d 00 00       	push   $0x4d5b
    18e3:	68 2b 4e 00 00       	push   $0x4e2b
    18e8:	e8 d6 27 00 00       	call   40c3 <link>
    18ed:	83 c4 10             	add    $0x10,%esp
    18f0:	85 c0                	test   %eax,%eax
    18f2:	78 17                	js     190b <linktest+0x22d>
    printf(1, "link . lf1 succeeded! oops\n");
    18f4:	83 ec 08             	sub    $0x8,%esp
    18f7:	68 2d 4e 00 00       	push   $0x4e2d
    18fc:	6a 01                	push   $0x1
    18fe:	e8 e4 28 00 00       	call   41e7 <printf>
    1903:	83 c4 10             	add    $0x10,%esp
    exit();
    1906:	e8 58 27 00 00       	call   4063 <exit>
  }

  printf(1, "linktest ok\n");
    190b:	83 ec 08             	sub    $0x8,%esp
    190e:	68 49 4e 00 00       	push   $0x4e49
    1913:	6a 01                	push   $0x1
    1915:	e8 cd 28 00 00       	call   41e7 <printf>
    191a:	83 c4 10             	add    $0x10,%esp
}
    191d:	90                   	nop
    191e:	c9                   	leave  
    191f:	c3                   	ret    

00001920 <concreate>:

// test concurrent create/link/unlink of the same file
void
concreate(void)
{
    1920:	55                   	push   %ebp
    1921:	89 e5                	mov    %esp,%ebp
    1923:	53                   	push   %ebx
    1924:	83 ec 54             	sub    $0x54,%esp
  struct {
    ushort inum;
    char name[14];
  } de;

  printf(1, "concreate test\n");
    1927:	83 ec 08             	sub    $0x8,%esp
    192a:	68 56 4e 00 00       	push   $0x4e56
    192f:	6a 01                	push   $0x1
    1931:	e8 b1 28 00 00       	call   41e7 <printf>
    1936:	83 c4 10             	add    $0x10,%esp
  file[0] = 'C';
    1939:	c6 45 e5 43          	movb   $0x43,-0x1b(%ebp)
  file[2] = '\0';
    193d:	c6 45 e7 00          	movb   $0x0,-0x19(%ebp)
  for(i = 0; i < 40; i++){
    1941:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1948:	e9 00 01 00 00       	jmp    1a4d <concreate+0x12d>
    file[1] = '0' + i;
    194d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1950:	83 c0 30             	add    $0x30,%eax
    1953:	88 45 e6             	mov    %al,-0x1a(%ebp)
    unlink(file);
    1956:	83 ec 0c             	sub    $0xc,%esp
    1959:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    195c:	50                   	push   %eax
    195d:	e8 51 27 00 00       	call   40b3 <unlink>
    1962:	83 c4 10             	add    $0x10,%esp
    pid = fork();
    1965:	e8 f1 26 00 00       	call   405b <fork>
    196a:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pid && (i % 3) == 1){
    196d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1971:	74 3d                	je     19b0 <concreate+0x90>
    1973:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1976:	ba 56 55 55 55       	mov    $0x55555556,%edx
    197b:	89 c8                	mov    %ecx,%eax
    197d:	f7 ea                	imul   %edx
    197f:	89 cb                	mov    %ecx,%ebx
    1981:	c1 fb 1f             	sar    $0x1f,%ebx
    1984:	89 d0                	mov    %edx,%eax
    1986:	29 d8                	sub    %ebx,%eax
    1988:	89 c2                	mov    %eax,%edx
    198a:	01 d2                	add    %edx,%edx
    198c:	01 c2                	add    %eax,%edx
    198e:	89 c8                	mov    %ecx,%eax
    1990:	29 d0                	sub    %edx,%eax
    1992:	83 f8 01             	cmp    $0x1,%eax
    1995:	75 19                	jne    19b0 <concreate+0x90>
      link("C0", file);
    1997:	83 ec 08             	sub    $0x8,%esp
    199a:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    199d:	50                   	push   %eax
    199e:	68 66 4e 00 00       	push   $0x4e66
    19a3:	e8 1b 27 00 00       	call   40c3 <link>
    19a8:	83 c4 10             	add    $0x10,%esp
    19ab:	e9 89 00 00 00       	jmp    1a39 <concreate+0x119>
    } else if(pid == 0 && (i % 5) == 1){
    19b0:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    19b4:	75 3d                	jne    19f3 <concreate+0xd3>
    19b6:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    19b9:	ba 67 66 66 66       	mov    $0x66666667,%edx
    19be:	89 c8                	mov    %ecx,%eax
    19c0:	f7 ea                	imul   %edx
    19c2:	89 d0                	mov    %edx,%eax
    19c4:	d1 f8                	sar    %eax
    19c6:	89 ca                	mov    %ecx,%edx
    19c8:	c1 fa 1f             	sar    $0x1f,%edx
    19cb:	29 d0                	sub    %edx,%eax
    19cd:	89 c2                	mov    %eax,%edx
    19cf:	c1 e2 02             	shl    $0x2,%edx
    19d2:	01 c2                	add    %eax,%edx
    19d4:	89 c8                	mov    %ecx,%eax
    19d6:	29 d0                	sub    %edx,%eax
    19d8:	83 f8 01             	cmp    $0x1,%eax
    19db:	75 16                	jne    19f3 <concreate+0xd3>
      link("C0", file);
    19dd:	83 ec 08             	sub    $0x8,%esp
    19e0:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19e3:	50                   	push   %eax
    19e4:	68 66 4e 00 00       	push   $0x4e66
    19e9:	e8 d5 26 00 00       	call   40c3 <link>
    19ee:	83 c4 10             	add    $0x10,%esp
    19f1:	eb 46                	jmp    1a39 <concreate+0x119>
    } else {
      fd = open(file, O_CREATE | O_RDWR);
    19f3:	83 ec 08             	sub    $0x8,%esp
    19f6:	68 02 02 00 00       	push   $0x202
    19fb:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    19fe:	50                   	push   %eax
    19ff:	e8 9f 26 00 00       	call   40a3 <open>
    1a04:	83 c4 10             	add    $0x10,%esp
    1a07:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(fd < 0){
    1a0a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1a0e:	79 1b                	jns    1a2b <concreate+0x10b>
        printf(1, "concreate create %s failed\n", file);
    1a10:	83 ec 04             	sub    $0x4,%esp
    1a13:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1a16:	50                   	push   %eax
    1a17:	68 69 4e 00 00       	push   $0x4e69
    1a1c:	6a 01                	push   $0x1
    1a1e:	e8 c4 27 00 00       	call   41e7 <printf>
    1a23:	83 c4 10             	add    $0x10,%esp
        exit();
    1a26:	e8 38 26 00 00       	call   4063 <exit>
      }
      close(fd);
    1a2b:	83 ec 0c             	sub    $0xc,%esp
    1a2e:	ff 75 ec             	push   -0x14(%ebp)
    1a31:	e8 55 26 00 00       	call   408b <close>
    1a36:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    1a39:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1a3d:	75 05                	jne    1a44 <concreate+0x124>
      exit();
    1a3f:	e8 1f 26 00 00       	call   4063 <exit>
    else
      wait();
    1a44:	e8 22 26 00 00       	call   406b <wait>
  for(i = 0; i < 40; i++){
    1a49:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1a4d:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    1a51:	0f 8e f6 fe ff ff    	jle    194d <concreate+0x2d>
  }

  memset(fa, 0, sizeof(fa));
    1a57:	83 ec 04             	sub    $0x4,%esp
    1a5a:	6a 28                	push   $0x28
    1a5c:	6a 00                	push   $0x0
    1a5e:	8d 45 bd             	lea    -0x43(%ebp),%eax
    1a61:	50                   	push   %eax
    1a62:	e8 06 24 00 00       	call   3e6d <memset>
    1a67:	83 c4 10             	add    $0x10,%esp
  fd = open(".", 0);
    1a6a:	83 ec 08             	sub    $0x8,%esp
    1a6d:	6a 00                	push   $0x0
    1a6f:	68 2b 4e 00 00       	push   $0x4e2b
    1a74:	e8 2a 26 00 00       	call   40a3 <open>
    1a79:	83 c4 10             	add    $0x10,%esp
    1a7c:	89 45 ec             	mov    %eax,-0x14(%ebp)
  n = 0;
    1a7f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  while(read(fd, &de, sizeof(de)) > 0){
    1a86:	e9 93 00 00 00       	jmp    1b1e <concreate+0x1fe>
    if(de.inum == 0)
    1a8b:	0f b7 45 ac          	movzwl -0x54(%ebp),%eax
    1a8f:	66 85 c0             	test   %ax,%ax
    1a92:	75 05                	jne    1a99 <concreate+0x179>
      continue;
    1a94:	e9 85 00 00 00       	jmp    1b1e <concreate+0x1fe>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    1a99:	0f b6 45 ae          	movzbl -0x52(%ebp),%eax
    1a9d:	3c 43                	cmp    $0x43,%al
    1a9f:	75 7d                	jne    1b1e <concreate+0x1fe>
    1aa1:	0f b6 45 b0          	movzbl -0x50(%ebp),%eax
    1aa5:	84 c0                	test   %al,%al
    1aa7:	75 75                	jne    1b1e <concreate+0x1fe>
      i = de.name[1] - '0';
    1aa9:	0f b6 45 af          	movzbl -0x51(%ebp),%eax
    1aad:	0f be c0             	movsbl %al,%eax
    1ab0:	83 e8 30             	sub    $0x30,%eax
    1ab3:	89 45 f4             	mov    %eax,-0xc(%ebp)
      if(i < 0 || i >= sizeof(fa)){
    1ab6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1aba:	78 08                	js     1ac4 <concreate+0x1a4>
    1abc:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1abf:	83 f8 27             	cmp    $0x27,%eax
    1ac2:	76 1e                	jbe    1ae2 <concreate+0x1c2>
        printf(1, "concreate weird file %s\n", de.name);
    1ac4:	83 ec 04             	sub    $0x4,%esp
    1ac7:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1aca:	83 c0 02             	add    $0x2,%eax
    1acd:	50                   	push   %eax
    1ace:	68 85 4e 00 00       	push   $0x4e85
    1ad3:	6a 01                	push   $0x1
    1ad5:	e8 0d 27 00 00       	call   41e7 <printf>
    1ada:	83 c4 10             	add    $0x10,%esp
        exit();
    1add:	e8 81 25 00 00       	call   4063 <exit>
      }
      if(fa[i]){
    1ae2:	8d 55 bd             	lea    -0x43(%ebp),%edx
    1ae5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ae8:	01 d0                	add    %edx,%eax
    1aea:	0f b6 00             	movzbl (%eax),%eax
    1aed:	84 c0                	test   %al,%al
    1aef:	74 1e                	je     1b0f <concreate+0x1ef>
        printf(1, "concreate duplicate file %s\n", de.name);
    1af1:	83 ec 04             	sub    $0x4,%esp
    1af4:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1af7:	83 c0 02             	add    $0x2,%eax
    1afa:	50                   	push   %eax
    1afb:	68 9e 4e 00 00       	push   $0x4e9e
    1b00:	6a 01                	push   $0x1
    1b02:	e8 e0 26 00 00       	call   41e7 <printf>
    1b07:	83 c4 10             	add    $0x10,%esp
        exit();
    1b0a:	e8 54 25 00 00       	call   4063 <exit>
      }
      fa[i] = 1;
    1b0f:	8d 55 bd             	lea    -0x43(%ebp),%edx
    1b12:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b15:	01 d0                	add    %edx,%eax
    1b17:	c6 00 01             	movb   $0x1,(%eax)
      n++;
    1b1a:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  while(read(fd, &de, sizeof(de)) > 0){
    1b1e:	83 ec 04             	sub    $0x4,%esp
    1b21:	6a 10                	push   $0x10
    1b23:	8d 45 ac             	lea    -0x54(%ebp),%eax
    1b26:	50                   	push   %eax
    1b27:	ff 75 ec             	push   -0x14(%ebp)
    1b2a:	e8 4c 25 00 00       	call   407b <read>
    1b2f:	83 c4 10             	add    $0x10,%esp
    1b32:	85 c0                	test   %eax,%eax
    1b34:	0f 8f 51 ff ff ff    	jg     1a8b <concreate+0x16b>
    }
  }
  close(fd);
    1b3a:	83 ec 0c             	sub    $0xc,%esp
    1b3d:	ff 75 ec             	push   -0x14(%ebp)
    1b40:	e8 46 25 00 00       	call   408b <close>
    1b45:	83 c4 10             	add    $0x10,%esp

  if(n != 40){
    1b48:	83 7d f0 28          	cmpl   $0x28,-0x10(%ebp)
    1b4c:	74 17                	je     1b65 <concreate+0x245>
    printf(1, "concreate not enough files in directory listing\n");
    1b4e:	83 ec 08             	sub    $0x8,%esp
    1b51:	68 bc 4e 00 00       	push   $0x4ebc
    1b56:	6a 01                	push   $0x1
    1b58:	e8 8a 26 00 00       	call   41e7 <printf>
    1b5d:	83 c4 10             	add    $0x10,%esp
    exit();
    1b60:	e8 fe 24 00 00       	call   4063 <exit>
  }

  for(i = 0; i < 40; i++){
    1b65:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1b6c:	e9 47 01 00 00       	jmp    1cb8 <concreate+0x398>
    file[1] = '0' + i;
    1b71:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1b74:	83 c0 30             	add    $0x30,%eax
    1b77:	88 45 e6             	mov    %al,-0x1a(%ebp)
    pid = fork();
    1b7a:	e8 dc 24 00 00       	call   405b <fork>
    1b7f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pid < 0){
    1b82:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1b86:	79 17                	jns    1b9f <concreate+0x27f>
      printf(1, "fork failed\n");
    1b88:	83 ec 08             	sub    $0x8,%esp
    1b8b:	68 41 46 00 00       	push   $0x4641
    1b90:	6a 01                	push   $0x1
    1b92:	e8 50 26 00 00       	call   41e7 <printf>
    1b97:	83 c4 10             	add    $0x10,%esp
      exit();
    1b9a:	e8 c4 24 00 00       	call   4063 <exit>
    }
    if(((i % 3) == 0 && pid == 0) ||
    1b9f:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1ba2:	ba 56 55 55 55       	mov    $0x55555556,%edx
    1ba7:	89 c8                	mov    %ecx,%eax
    1ba9:	f7 ea                	imul   %edx
    1bab:	89 cb                	mov    %ecx,%ebx
    1bad:	c1 fb 1f             	sar    $0x1f,%ebx
    1bb0:	89 d0                	mov    %edx,%eax
    1bb2:	29 d8                	sub    %ebx,%eax
    1bb4:	89 c2                	mov    %eax,%edx
    1bb6:	01 d2                	add    %edx,%edx
    1bb8:	01 c2                	add    %eax,%edx
    1bba:	89 c8                	mov    %ecx,%eax
    1bbc:	29 d0                	sub    %edx,%eax
    1bbe:	85 c0                	test   %eax,%eax
    1bc0:	75 06                	jne    1bc8 <concreate+0x2a8>
    1bc2:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1bc6:	74 2a                	je     1bf2 <concreate+0x2d2>
       ((i % 3) == 1 && pid != 0)){
    1bc8:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    1bcb:	ba 56 55 55 55       	mov    $0x55555556,%edx
    1bd0:	89 c8                	mov    %ecx,%eax
    1bd2:	f7 ea                	imul   %edx
    1bd4:	89 cb                	mov    %ecx,%ebx
    1bd6:	c1 fb 1f             	sar    $0x1f,%ebx
    1bd9:	89 d0                	mov    %edx,%eax
    1bdb:	29 d8                	sub    %ebx,%eax
    1bdd:	89 c2                	mov    %eax,%edx
    1bdf:	01 d2                	add    %edx,%edx
    1be1:	01 c2                	add    %eax,%edx
    1be3:	89 c8                	mov    %ecx,%eax
    1be5:	29 d0                	sub    %edx,%eax
    if(((i % 3) == 0 && pid == 0) ||
    1be7:	83 f8 01             	cmp    $0x1,%eax
    1bea:	75 7c                	jne    1c68 <concreate+0x348>
       ((i % 3) == 1 && pid != 0)){
    1bec:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1bf0:	74 76                	je     1c68 <concreate+0x348>
      close(open(file, 0));
    1bf2:	83 ec 08             	sub    $0x8,%esp
    1bf5:	6a 00                	push   $0x0
    1bf7:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1bfa:	50                   	push   %eax
    1bfb:	e8 a3 24 00 00       	call   40a3 <open>
    1c00:	83 c4 10             	add    $0x10,%esp
    1c03:	83 ec 0c             	sub    $0xc,%esp
    1c06:	50                   	push   %eax
    1c07:	e8 7f 24 00 00       	call   408b <close>
    1c0c:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    1c0f:	83 ec 08             	sub    $0x8,%esp
    1c12:	6a 00                	push   $0x0
    1c14:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c17:	50                   	push   %eax
    1c18:	e8 86 24 00 00       	call   40a3 <open>
    1c1d:	83 c4 10             	add    $0x10,%esp
    1c20:	83 ec 0c             	sub    $0xc,%esp
    1c23:	50                   	push   %eax
    1c24:	e8 62 24 00 00       	call   408b <close>
    1c29:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    1c2c:	83 ec 08             	sub    $0x8,%esp
    1c2f:	6a 00                	push   $0x0
    1c31:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c34:	50                   	push   %eax
    1c35:	e8 69 24 00 00       	call   40a3 <open>
    1c3a:	83 c4 10             	add    $0x10,%esp
    1c3d:	83 ec 0c             	sub    $0xc,%esp
    1c40:	50                   	push   %eax
    1c41:	e8 45 24 00 00       	call   408b <close>
    1c46:	83 c4 10             	add    $0x10,%esp
      close(open(file, 0));
    1c49:	83 ec 08             	sub    $0x8,%esp
    1c4c:	6a 00                	push   $0x0
    1c4e:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c51:	50                   	push   %eax
    1c52:	e8 4c 24 00 00       	call   40a3 <open>
    1c57:	83 c4 10             	add    $0x10,%esp
    1c5a:	83 ec 0c             	sub    $0xc,%esp
    1c5d:	50                   	push   %eax
    1c5e:	e8 28 24 00 00       	call   408b <close>
    1c63:	83 c4 10             	add    $0x10,%esp
    1c66:	eb 3c                	jmp    1ca4 <concreate+0x384>
    } else {
      unlink(file);
    1c68:	83 ec 0c             	sub    $0xc,%esp
    1c6b:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c6e:	50                   	push   %eax
    1c6f:	e8 3f 24 00 00       	call   40b3 <unlink>
    1c74:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    1c77:	83 ec 0c             	sub    $0xc,%esp
    1c7a:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c7d:	50                   	push   %eax
    1c7e:	e8 30 24 00 00       	call   40b3 <unlink>
    1c83:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    1c86:	83 ec 0c             	sub    $0xc,%esp
    1c89:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c8c:	50                   	push   %eax
    1c8d:	e8 21 24 00 00       	call   40b3 <unlink>
    1c92:	83 c4 10             	add    $0x10,%esp
      unlink(file);
    1c95:	83 ec 0c             	sub    $0xc,%esp
    1c98:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    1c9b:	50                   	push   %eax
    1c9c:	e8 12 24 00 00       	call   40b3 <unlink>
    1ca1:	83 c4 10             	add    $0x10,%esp
    }
    if(pid == 0)
    1ca4:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    1ca8:	75 05                	jne    1caf <concreate+0x38f>
      exit();
    1caa:	e8 b4 23 00 00       	call   4063 <exit>
    else
      wait();
    1caf:	e8 b7 23 00 00       	call   406b <wait>
  for(i = 0; i < 40; i++){
    1cb4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1cb8:	83 7d f4 27          	cmpl   $0x27,-0xc(%ebp)
    1cbc:	0f 8e af fe ff ff    	jle    1b71 <concreate+0x251>
  }

  printf(1, "concreate ok\n");
    1cc2:	83 ec 08             	sub    $0x8,%esp
    1cc5:	68 ed 4e 00 00       	push   $0x4eed
    1cca:	6a 01                	push   $0x1
    1ccc:	e8 16 25 00 00       	call   41e7 <printf>
    1cd1:	83 c4 10             	add    $0x10,%esp
}
    1cd4:	90                   	nop
    1cd5:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    1cd8:	c9                   	leave  
    1cd9:	c3                   	ret    

00001cda <linkunlink>:

// another concurrent link/unlink/create test,
// to look for deadlocks.
void
linkunlink()
{
    1cda:	55                   	push   %ebp
    1cdb:	89 e5                	mov    %esp,%ebp
    1cdd:	83 ec 18             	sub    $0x18,%esp
  int pid, i;

  printf(1, "linkunlink test\n");
    1ce0:	83 ec 08             	sub    $0x8,%esp
    1ce3:	68 fb 4e 00 00       	push   $0x4efb
    1ce8:	6a 01                	push   $0x1
    1cea:	e8 f8 24 00 00       	call   41e7 <printf>
    1cef:	83 c4 10             	add    $0x10,%esp

  unlink("x");
    1cf2:	83 ec 0c             	sub    $0xc,%esp
    1cf5:	68 77 4a 00 00       	push   $0x4a77
    1cfa:	e8 b4 23 00 00       	call   40b3 <unlink>
    1cff:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    1d02:	e8 54 23 00 00       	call   405b <fork>
    1d07:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(pid < 0){
    1d0a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1d0e:	79 17                	jns    1d27 <linkunlink+0x4d>
    printf(1, "fork failed\n");
    1d10:	83 ec 08             	sub    $0x8,%esp
    1d13:	68 41 46 00 00       	push   $0x4641
    1d18:	6a 01                	push   $0x1
    1d1a:	e8 c8 24 00 00       	call   41e7 <printf>
    1d1f:	83 c4 10             	add    $0x10,%esp
    exit();
    1d22:	e8 3c 23 00 00       	call   4063 <exit>
  }

  unsigned int x = (pid ? 1 : 97);
    1d27:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1d2b:	74 07                	je     1d34 <linkunlink+0x5a>
    1d2d:	b8 01 00 00 00       	mov    $0x1,%eax
    1d32:	eb 05                	jmp    1d39 <linkunlink+0x5f>
    1d34:	b8 61 00 00 00       	mov    $0x61,%eax
    1d39:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; i < 100; i++){
    1d3c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1d43:	e9 9c 00 00 00       	jmp    1de4 <linkunlink+0x10a>
    x = x * 1103515245 + 12345;
    1d48:	8b 45 f0             	mov    -0x10(%ebp),%eax
    1d4b:	69 c0 6d 4e c6 41    	imul   $0x41c64e6d,%eax,%eax
    1d51:	05 39 30 00 00       	add    $0x3039,%eax
    1d56:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((x % 3) == 0){
    1d59:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1d5c:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    1d61:	89 c8                	mov    %ecx,%eax
    1d63:	f7 e2                	mul    %edx
    1d65:	89 d0                	mov    %edx,%eax
    1d67:	d1 e8                	shr    %eax
    1d69:	89 c2                	mov    %eax,%edx
    1d6b:	01 d2                	add    %edx,%edx
    1d6d:	01 c2                	add    %eax,%edx
    1d6f:	89 c8                	mov    %ecx,%eax
    1d71:	29 d0                	sub    %edx,%eax
    1d73:	85 c0                	test   %eax,%eax
    1d75:	75 23                	jne    1d9a <linkunlink+0xc0>
      close(open("x", O_RDWR | O_CREATE));
    1d77:	83 ec 08             	sub    $0x8,%esp
    1d7a:	68 02 02 00 00       	push   $0x202
    1d7f:	68 77 4a 00 00       	push   $0x4a77
    1d84:	e8 1a 23 00 00       	call   40a3 <open>
    1d89:	83 c4 10             	add    $0x10,%esp
    1d8c:	83 ec 0c             	sub    $0xc,%esp
    1d8f:	50                   	push   %eax
    1d90:	e8 f6 22 00 00       	call   408b <close>
    1d95:	83 c4 10             	add    $0x10,%esp
    1d98:	eb 46                	jmp    1de0 <linkunlink+0x106>
    } else if((x % 3) == 1){
    1d9a:	8b 4d f0             	mov    -0x10(%ebp),%ecx
    1d9d:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
    1da2:	89 c8                	mov    %ecx,%eax
    1da4:	f7 e2                	mul    %edx
    1da6:	89 d0                	mov    %edx,%eax
    1da8:	d1 e8                	shr    %eax
    1daa:	89 c2                	mov    %eax,%edx
    1dac:	01 d2                	add    %edx,%edx
    1dae:	01 c2                	add    %eax,%edx
    1db0:	89 c8                	mov    %ecx,%eax
    1db2:	29 d0                	sub    %edx,%eax
    1db4:	83 f8 01             	cmp    $0x1,%eax
    1db7:	75 17                	jne    1dd0 <linkunlink+0xf6>
      link("cat", "x");
    1db9:	83 ec 08             	sub    $0x8,%esp
    1dbc:	68 77 4a 00 00       	push   $0x4a77
    1dc1:	68 0c 4f 00 00       	push   $0x4f0c
    1dc6:	e8 f8 22 00 00       	call   40c3 <link>
    1dcb:	83 c4 10             	add    $0x10,%esp
    1dce:	eb 10                	jmp    1de0 <linkunlink+0x106>
    } else {
      unlink("x");
    1dd0:	83 ec 0c             	sub    $0xc,%esp
    1dd3:	68 77 4a 00 00       	push   $0x4a77
    1dd8:	e8 d6 22 00 00       	call   40b3 <unlink>
    1ddd:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 100; i++){
    1de0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1de4:	83 7d f4 63          	cmpl   $0x63,-0xc(%ebp)
    1de8:	0f 8e 5a ff ff ff    	jle    1d48 <linkunlink+0x6e>
    }
  }

  if(pid)
    1dee:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    1df2:	74 07                	je     1dfb <linkunlink+0x121>
    wait();
    1df4:	e8 72 22 00 00       	call   406b <wait>
    1df9:	eb 05                	jmp    1e00 <linkunlink+0x126>
  else
    exit();
    1dfb:	e8 63 22 00 00       	call   4063 <exit>

  printf(1, "linkunlink ok\n");
    1e00:	83 ec 08             	sub    $0x8,%esp
    1e03:	68 10 4f 00 00       	push   $0x4f10
    1e08:	6a 01                	push   $0x1
    1e0a:	e8 d8 23 00 00       	call   41e7 <printf>
    1e0f:	83 c4 10             	add    $0x10,%esp
}
    1e12:	90                   	nop
    1e13:	c9                   	leave  
    1e14:	c3                   	ret    

00001e15 <bigdir>:

// directory that uses indirect blocks
void
bigdir(void)
{
    1e15:	55                   	push   %ebp
    1e16:	89 e5                	mov    %esp,%ebp
    1e18:	83 ec 28             	sub    $0x28,%esp
  int i, fd;
  char name[10];

  printf(1, "bigdir test\n");
    1e1b:	83 ec 08             	sub    $0x8,%esp
    1e1e:	68 1f 4f 00 00       	push   $0x4f1f
    1e23:	6a 01                	push   $0x1
    1e25:	e8 bd 23 00 00       	call   41e7 <printf>
    1e2a:	83 c4 10             	add    $0x10,%esp
  unlink("bd");
    1e2d:	83 ec 0c             	sub    $0xc,%esp
    1e30:	68 2c 4f 00 00       	push   $0x4f2c
    1e35:	e8 79 22 00 00       	call   40b3 <unlink>
    1e3a:	83 c4 10             	add    $0x10,%esp

  fd = open("bd", O_CREATE);
    1e3d:	83 ec 08             	sub    $0x8,%esp
    1e40:	68 00 02 00 00       	push   $0x200
    1e45:	68 2c 4f 00 00       	push   $0x4f2c
    1e4a:	e8 54 22 00 00       	call   40a3 <open>
    1e4f:	83 c4 10             	add    $0x10,%esp
    1e52:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(fd < 0){
    1e55:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    1e59:	79 17                	jns    1e72 <bigdir+0x5d>
    printf(1, "bigdir create failed\n");
    1e5b:	83 ec 08             	sub    $0x8,%esp
    1e5e:	68 2f 4f 00 00       	push   $0x4f2f
    1e63:	6a 01                	push   $0x1
    1e65:	e8 7d 23 00 00       	call   41e7 <printf>
    1e6a:	83 c4 10             	add    $0x10,%esp
    exit();
    1e6d:	e8 f1 21 00 00       	call   4063 <exit>
  }
  close(fd);
    1e72:	83 ec 0c             	sub    $0xc,%esp
    1e75:	ff 75 f0             	push   -0x10(%ebp)
    1e78:	e8 0e 22 00 00       	call   408b <close>
    1e7d:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 500; i++){
    1e80:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1e87:	eb 63                	jmp    1eec <bigdir+0xd7>
    name[0] = 'x';
    1e89:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    name[1] = '0' + (i / 64);
    1e8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1e90:	8d 50 3f             	lea    0x3f(%eax),%edx
    1e93:	85 c0                	test   %eax,%eax
    1e95:	0f 48 c2             	cmovs  %edx,%eax
    1e98:	c1 f8 06             	sar    $0x6,%eax
    1e9b:	83 c0 30             	add    $0x30,%eax
    1e9e:	88 45 e7             	mov    %al,-0x19(%ebp)
    name[2] = '0' + (i % 64);
    1ea1:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1ea4:	99                   	cltd   
    1ea5:	c1 ea 1a             	shr    $0x1a,%edx
    1ea8:	01 d0                	add    %edx,%eax
    1eaa:	83 e0 3f             	and    $0x3f,%eax
    1ead:	29 d0                	sub    %edx,%eax
    1eaf:	83 c0 30             	add    $0x30,%eax
    1eb2:	88 45 e8             	mov    %al,-0x18(%ebp)
    name[3] = '\0';
    1eb5:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    if(link("bd", name) != 0){
    1eb9:	83 ec 08             	sub    $0x8,%esp
    1ebc:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1ebf:	50                   	push   %eax
    1ec0:	68 2c 4f 00 00       	push   $0x4f2c
    1ec5:	e8 f9 21 00 00       	call   40c3 <link>
    1eca:	83 c4 10             	add    $0x10,%esp
    1ecd:	85 c0                	test   %eax,%eax
    1ecf:	74 17                	je     1ee8 <bigdir+0xd3>
      printf(1, "bigdir link failed\n");
    1ed1:	83 ec 08             	sub    $0x8,%esp
    1ed4:	68 45 4f 00 00       	push   $0x4f45
    1ed9:	6a 01                	push   $0x1
    1edb:	e8 07 23 00 00       	call   41e7 <printf>
    1ee0:	83 c4 10             	add    $0x10,%esp
      exit();
    1ee3:	e8 7b 21 00 00       	call   4063 <exit>
  for(i = 0; i < 500; i++){
    1ee8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1eec:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    1ef3:	7e 94                	jle    1e89 <bigdir+0x74>
    }
  }

  unlink("bd");
    1ef5:	83 ec 0c             	sub    $0xc,%esp
    1ef8:	68 2c 4f 00 00       	push   $0x4f2c
    1efd:	e8 b1 21 00 00       	call   40b3 <unlink>
    1f02:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 500; i++){
    1f05:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    1f0c:	eb 5e                	jmp    1f6c <bigdir+0x157>
    name[0] = 'x';
    1f0e:	c6 45 e6 78          	movb   $0x78,-0x1a(%ebp)
    name[1] = '0' + (i / 64);
    1f12:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f15:	8d 50 3f             	lea    0x3f(%eax),%edx
    1f18:	85 c0                	test   %eax,%eax
    1f1a:	0f 48 c2             	cmovs  %edx,%eax
    1f1d:	c1 f8 06             	sar    $0x6,%eax
    1f20:	83 c0 30             	add    $0x30,%eax
    1f23:	88 45 e7             	mov    %al,-0x19(%ebp)
    name[2] = '0' + (i % 64);
    1f26:	8b 45 f4             	mov    -0xc(%ebp),%eax
    1f29:	99                   	cltd   
    1f2a:	c1 ea 1a             	shr    $0x1a,%edx
    1f2d:	01 d0                	add    %edx,%eax
    1f2f:	83 e0 3f             	and    $0x3f,%eax
    1f32:	29 d0                	sub    %edx,%eax
    1f34:	83 c0 30             	add    $0x30,%eax
    1f37:	88 45 e8             	mov    %al,-0x18(%ebp)
    name[3] = '\0';
    1f3a:	c6 45 e9 00          	movb   $0x0,-0x17(%ebp)
    if(unlink(name) != 0){
    1f3e:	83 ec 0c             	sub    $0xc,%esp
    1f41:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    1f44:	50                   	push   %eax
    1f45:	e8 69 21 00 00       	call   40b3 <unlink>
    1f4a:	83 c4 10             	add    $0x10,%esp
    1f4d:	85 c0                	test   %eax,%eax
    1f4f:	74 17                	je     1f68 <bigdir+0x153>
      printf(1, "bigdir unlink failed");
    1f51:	83 ec 08             	sub    $0x8,%esp
    1f54:	68 59 4f 00 00       	push   $0x4f59
    1f59:	6a 01                	push   $0x1
    1f5b:	e8 87 22 00 00       	call   41e7 <printf>
    1f60:	83 c4 10             	add    $0x10,%esp
      exit();
    1f63:	e8 fb 20 00 00       	call   4063 <exit>
  for(i = 0; i < 500; i++){
    1f68:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    1f6c:	81 7d f4 f3 01 00 00 	cmpl   $0x1f3,-0xc(%ebp)
    1f73:	7e 99                	jle    1f0e <bigdir+0xf9>
    }
  }

  printf(1, "bigdir ok\n");
    1f75:	83 ec 08             	sub    $0x8,%esp
    1f78:	68 6e 4f 00 00       	push   $0x4f6e
    1f7d:	6a 01                	push   $0x1
    1f7f:	e8 63 22 00 00       	call   41e7 <printf>
    1f84:	83 c4 10             	add    $0x10,%esp
}
    1f87:	90                   	nop
    1f88:	c9                   	leave  
    1f89:	c3                   	ret    

00001f8a <subdir>:

void
subdir(void)
{
    1f8a:	55                   	push   %ebp
    1f8b:	89 e5                	mov    %esp,%ebp
    1f8d:	83 ec 18             	sub    $0x18,%esp
  int fd, cc;

  printf(1, "subdir test\n");
    1f90:	83 ec 08             	sub    $0x8,%esp
    1f93:	68 79 4f 00 00       	push   $0x4f79
    1f98:	6a 01                	push   $0x1
    1f9a:	e8 48 22 00 00       	call   41e7 <printf>
    1f9f:	83 c4 10             	add    $0x10,%esp

  unlink("ff");
    1fa2:	83 ec 0c             	sub    $0xc,%esp
    1fa5:	68 86 4f 00 00       	push   $0x4f86
    1faa:	e8 04 21 00 00       	call   40b3 <unlink>
    1faf:	83 c4 10             	add    $0x10,%esp
  if(mkdir("dd") != 0){
    1fb2:	83 ec 0c             	sub    $0xc,%esp
    1fb5:	68 89 4f 00 00       	push   $0x4f89
    1fba:	e8 0c 21 00 00       	call   40cb <mkdir>
    1fbf:	83 c4 10             	add    $0x10,%esp
    1fc2:	85 c0                	test   %eax,%eax
    1fc4:	74 17                	je     1fdd <subdir+0x53>
    printf(1, "subdir mkdir dd failed\n");
    1fc6:	83 ec 08             	sub    $0x8,%esp
    1fc9:	68 8c 4f 00 00       	push   $0x4f8c
    1fce:	6a 01                	push   $0x1
    1fd0:	e8 12 22 00 00       	call   41e7 <printf>
    1fd5:	83 c4 10             	add    $0x10,%esp
    exit();
    1fd8:	e8 86 20 00 00       	call   4063 <exit>
  }

  fd = open("dd/ff", O_CREATE | O_RDWR);
    1fdd:	83 ec 08             	sub    $0x8,%esp
    1fe0:	68 02 02 00 00       	push   $0x202
    1fe5:	68 a4 4f 00 00       	push   $0x4fa4
    1fea:	e8 b4 20 00 00       	call   40a3 <open>
    1fef:	83 c4 10             	add    $0x10,%esp
    1ff2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    1ff5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    1ff9:	79 17                	jns    2012 <subdir+0x88>
    printf(1, "create dd/ff failed\n");
    1ffb:	83 ec 08             	sub    $0x8,%esp
    1ffe:	68 aa 4f 00 00       	push   $0x4faa
    2003:	6a 01                	push   $0x1
    2005:	e8 dd 21 00 00       	call   41e7 <printf>
    200a:	83 c4 10             	add    $0x10,%esp
    exit();
    200d:	e8 51 20 00 00       	call   4063 <exit>
  }
  write(fd, "ff", 2);
    2012:	83 ec 04             	sub    $0x4,%esp
    2015:	6a 02                	push   $0x2
    2017:	68 86 4f 00 00       	push   $0x4f86
    201c:	ff 75 f4             	push   -0xc(%ebp)
    201f:	e8 5f 20 00 00       	call   4083 <write>
    2024:	83 c4 10             	add    $0x10,%esp
  close(fd);
    2027:	83 ec 0c             	sub    $0xc,%esp
    202a:	ff 75 f4             	push   -0xc(%ebp)
    202d:	e8 59 20 00 00       	call   408b <close>
    2032:	83 c4 10             	add    $0x10,%esp

  if(unlink("dd") >= 0){
    2035:	83 ec 0c             	sub    $0xc,%esp
    2038:	68 89 4f 00 00       	push   $0x4f89
    203d:	e8 71 20 00 00       	call   40b3 <unlink>
    2042:	83 c4 10             	add    $0x10,%esp
    2045:	85 c0                	test   %eax,%eax
    2047:	78 17                	js     2060 <subdir+0xd6>
    printf(1, "unlink dd (non-empty dir) succeeded!\n");
    2049:	83 ec 08             	sub    $0x8,%esp
    204c:	68 c0 4f 00 00       	push   $0x4fc0
    2051:	6a 01                	push   $0x1
    2053:	e8 8f 21 00 00       	call   41e7 <printf>
    2058:	83 c4 10             	add    $0x10,%esp
    exit();
    205b:	e8 03 20 00 00       	call   4063 <exit>
  }

  if(mkdir("/dd/dd") != 0){
    2060:	83 ec 0c             	sub    $0xc,%esp
    2063:	68 e6 4f 00 00       	push   $0x4fe6
    2068:	e8 5e 20 00 00       	call   40cb <mkdir>
    206d:	83 c4 10             	add    $0x10,%esp
    2070:	85 c0                	test   %eax,%eax
    2072:	74 17                	je     208b <subdir+0x101>
    printf(1, "subdir mkdir dd/dd failed\n");
    2074:	83 ec 08             	sub    $0x8,%esp
    2077:	68 ed 4f 00 00       	push   $0x4fed
    207c:	6a 01                	push   $0x1
    207e:	e8 64 21 00 00       	call   41e7 <printf>
    2083:	83 c4 10             	add    $0x10,%esp
    exit();
    2086:	e8 d8 1f 00 00       	call   4063 <exit>
  }

  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    208b:	83 ec 08             	sub    $0x8,%esp
    208e:	68 02 02 00 00       	push   $0x202
    2093:	68 08 50 00 00       	push   $0x5008
    2098:	e8 06 20 00 00       	call   40a3 <open>
    209d:	83 c4 10             	add    $0x10,%esp
    20a0:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    20a3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    20a7:	79 17                	jns    20c0 <subdir+0x136>
    printf(1, "create dd/dd/ff failed\n");
    20a9:	83 ec 08             	sub    $0x8,%esp
    20ac:	68 11 50 00 00       	push   $0x5011
    20b1:	6a 01                	push   $0x1
    20b3:	e8 2f 21 00 00       	call   41e7 <printf>
    20b8:	83 c4 10             	add    $0x10,%esp
    exit();
    20bb:	e8 a3 1f 00 00       	call   4063 <exit>
  }
  write(fd, "FF", 2);
    20c0:	83 ec 04             	sub    $0x4,%esp
    20c3:	6a 02                	push   $0x2
    20c5:	68 29 50 00 00       	push   $0x5029
    20ca:	ff 75 f4             	push   -0xc(%ebp)
    20cd:	e8 b1 1f 00 00       	call   4083 <write>
    20d2:	83 c4 10             	add    $0x10,%esp
  close(fd);
    20d5:	83 ec 0c             	sub    $0xc,%esp
    20d8:	ff 75 f4             	push   -0xc(%ebp)
    20db:	e8 ab 1f 00 00       	call   408b <close>
    20e0:	83 c4 10             	add    $0x10,%esp

  fd = open("dd/dd/../ff", 0);
    20e3:	83 ec 08             	sub    $0x8,%esp
    20e6:	6a 00                	push   $0x0
    20e8:	68 2c 50 00 00       	push   $0x502c
    20ed:	e8 b1 1f 00 00       	call   40a3 <open>
    20f2:	83 c4 10             	add    $0x10,%esp
    20f5:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    20f8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    20fc:	79 17                	jns    2115 <subdir+0x18b>
    printf(1, "open dd/dd/../ff failed\n");
    20fe:	83 ec 08             	sub    $0x8,%esp
    2101:	68 38 50 00 00       	push   $0x5038
    2106:	6a 01                	push   $0x1
    2108:	e8 da 20 00 00       	call   41e7 <printf>
    210d:	83 c4 10             	add    $0x10,%esp
    exit();
    2110:	e8 4e 1f 00 00       	call   4063 <exit>
  }
  cc = read(fd, buf, sizeof(buf));
    2115:	83 ec 04             	sub    $0x4,%esp
    2118:	68 00 20 00 00       	push   $0x2000
    211d:	68 40 65 00 00       	push   $0x6540
    2122:	ff 75 f4             	push   -0xc(%ebp)
    2125:	e8 51 1f 00 00       	call   407b <read>
    212a:	83 c4 10             	add    $0x10,%esp
    212d:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(cc != 2 || buf[0] != 'f'){
    2130:	83 7d f0 02          	cmpl   $0x2,-0x10(%ebp)
    2134:	75 0b                	jne    2141 <subdir+0x1b7>
    2136:	0f b6 05 40 65 00 00 	movzbl 0x6540,%eax
    213d:	3c 66                	cmp    $0x66,%al
    213f:	74 17                	je     2158 <subdir+0x1ce>
    printf(1, "dd/dd/../ff wrong content\n");
    2141:	83 ec 08             	sub    $0x8,%esp
    2144:	68 51 50 00 00       	push   $0x5051
    2149:	6a 01                	push   $0x1
    214b:	e8 97 20 00 00       	call   41e7 <printf>
    2150:	83 c4 10             	add    $0x10,%esp
    exit();
    2153:	e8 0b 1f 00 00       	call   4063 <exit>
  }
  close(fd);
    2158:	83 ec 0c             	sub    $0xc,%esp
    215b:	ff 75 f4             	push   -0xc(%ebp)
    215e:	e8 28 1f 00 00       	call   408b <close>
    2163:	83 c4 10             	add    $0x10,%esp

  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    2166:	83 ec 08             	sub    $0x8,%esp
    2169:	68 6c 50 00 00       	push   $0x506c
    216e:	68 08 50 00 00       	push   $0x5008
    2173:	e8 4b 1f 00 00       	call   40c3 <link>
    2178:	83 c4 10             	add    $0x10,%esp
    217b:	85 c0                	test   %eax,%eax
    217d:	74 17                	je     2196 <subdir+0x20c>
    printf(1, "link dd/dd/ff dd/dd/ffff failed\n");
    217f:	83 ec 08             	sub    $0x8,%esp
    2182:	68 78 50 00 00       	push   $0x5078
    2187:	6a 01                	push   $0x1
    2189:	e8 59 20 00 00       	call   41e7 <printf>
    218e:	83 c4 10             	add    $0x10,%esp
    exit();
    2191:	e8 cd 1e 00 00       	call   4063 <exit>
  }

  if(unlink("dd/dd/ff") != 0){
    2196:	83 ec 0c             	sub    $0xc,%esp
    2199:	68 08 50 00 00       	push   $0x5008
    219e:	e8 10 1f 00 00       	call   40b3 <unlink>
    21a3:	83 c4 10             	add    $0x10,%esp
    21a6:	85 c0                	test   %eax,%eax
    21a8:	74 17                	je     21c1 <subdir+0x237>
    printf(1, "unlink dd/dd/ff failed\n");
    21aa:	83 ec 08             	sub    $0x8,%esp
    21ad:	68 99 50 00 00       	push   $0x5099
    21b2:	6a 01                	push   $0x1
    21b4:	e8 2e 20 00 00       	call   41e7 <printf>
    21b9:	83 c4 10             	add    $0x10,%esp
    exit();
    21bc:	e8 a2 1e 00 00       	call   4063 <exit>
  }
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    21c1:	83 ec 08             	sub    $0x8,%esp
    21c4:	6a 00                	push   $0x0
    21c6:	68 08 50 00 00       	push   $0x5008
    21cb:	e8 d3 1e 00 00       	call   40a3 <open>
    21d0:	83 c4 10             	add    $0x10,%esp
    21d3:	85 c0                	test   %eax,%eax
    21d5:	78 17                	js     21ee <subdir+0x264>
    printf(1, "open (unlinked) dd/dd/ff succeeded\n");
    21d7:	83 ec 08             	sub    $0x8,%esp
    21da:	68 b4 50 00 00       	push   $0x50b4
    21df:	6a 01                	push   $0x1
    21e1:	e8 01 20 00 00       	call   41e7 <printf>
    21e6:	83 c4 10             	add    $0x10,%esp
    exit();
    21e9:	e8 75 1e 00 00       	call   4063 <exit>
  }

  if(chdir("dd") != 0){
    21ee:	83 ec 0c             	sub    $0xc,%esp
    21f1:	68 89 4f 00 00       	push   $0x4f89
    21f6:	e8 d8 1e 00 00       	call   40d3 <chdir>
    21fb:	83 c4 10             	add    $0x10,%esp
    21fe:	85 c0                	test   %eax,%eax
    2200:	74 17                	je     2219 <subdir+0x28f>
    printf(1, "chdir dd failed\n");
    2202:	83 ec 08             	sub    $0x8,%esp
    2205:	68 d8 50 00 00       	push   $0x50d8
    220a:	6a 01                	push   $0x1
    220c:	e8 d6 1f 00 00       	call   41e7 <printf>
    2211:	83 c4 10             	add    $0x10,%esp
    exit();
    2214:	e8 4a 1e 00 00       	call   4063 <exit>
  }
  if(chdir("dd/../../dd") != 0){
    2219:	83 ec 0c             	sub    $0xc,%esp
    221c:	68 e9 50 00 00       	push   $0x50e9
    2221:	e8 ad 1e 00 00       	call   40d3 <chdir>
    2226:	83 c4 10             	add    $0x10,%esp
    2229:	85 c0                	test   %eax,%eax
    222b:	74 17                	je     2244 <subdir+0x2ba>
    printf(1, "chdir dd/../../dd failed\n");
    222d:	83 ec 08             	sub    $0x8,%esp
    2230:	68 f5 50 00 00       	push   $0x50f5
    2235:	6a 01                	push   $0x1
    2237:	e8 ab 1f 00 00       	call   41e7 <printf>
    223c:	83 c4 10             	add    $0x10,%esp
    exit();
    223f:	e8 1f 1e 00 00       	call   4063 <exit>
  }
  if(chdir("dd/../../../dd") != 0){
    2244:	83 ec 0c             	sub    $0xc,%esp
    2247:	68 0f 51 00 00       	push   $0x510f
    224c:	e8 82 1e 00 00       	call   40d3 <chdir>
    2251:	83 c4 10             	add    $0x10,%esp
    2254:	85 c0                	test   %eax,%eax
    2256:	74 17                	je     226f <subdir+0x2e5>
    printf(1, "chdir dd/../../dd failed\n");
    2258:	83 ec 08             	sub    $0x8,%esp
    225b:	68 f5 50 00 00       	push   $0x50f5
    2260:	6a 01                	push   $0x1
    2262:	e8 80 1f 00 00       	call   41e7 <printf>
    2267:	83 c4 10             	add    $0x10,%esp
    exit();
    226a:	e8 f4 1d 00 00       	call   4063 <exit>
  }
  if(chdir("./..") != 0){
    226f:	83 ec 0c             	sub    $0xc,%esp
    2272:	68 1e 51 00 00       	push   $0x511e
    2277:	e8 57 1e 00 00       	call   40d3 <chdir>
    227c:	83 c4 10             	add    $0x10,%esp
    227f:	85 c0                	test   %eax,%eax
    2281:	74 17                	je     229a <subdir+0x310>
    printf(1, "chdir ./.. failed\n");
    2283:	83 ec 08             	sub    $0x8,%esp
    2286:	68 23 51 00 00       	push   $0x5123
    228b:	6a 01                	push   $0x1
    228d:	e8 55 1f 00 00       	call   41e7 <printf>
    2292:	83 c4 10             	add    $0x10,%esp
    exit();
    2295:	e8 c9 1d 00 00       	call   4063 <exit>
  }

  fd = open("dd/dd/ffff", 0);
    229a:	83 ec 08             	sub    $0x8,%esp
    229d:	6a 00                	push   $0x0
    229f:	68 6c 50 00 00       	push   $0x506c
    22a4:	e8 fa 1d 00 00       	call   40a3 <open>
    22a9:	83 c4 10             	add    $0x10,%esp
    22ac:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    22af:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    22b3:	79 17                	jns    22cc <subdir+0x342>
    printf(1, "open dd/dd/ffff failed\n");
    22b5:	83 ec 08             	sub    $0x8,%esp
    22b8:	68 36 51 00 00       	push   $0x5136
    22bd:	6a 01                	push   $0x1
    22bf:	e8 23 1f 00 00       	call   41e7 <printf>
    22c4:	83 c4 10             	add    $0x10,%esp
    exit();
    22c7:	e8 97 1d 00 00       	call   4063 <exit>
  }
  if(read(fd, buf, sizeof(buf)) != 2){
    22cc:	83 ec 04             	sub    $0x4,%esp
    22cf:	68 00 20 00 00       	push   $0x2000
    22d4:	68 40 65 00 00       	push   $0x6540
    22d9:	ff 75 f4             	push   -0xc(%ebp)
    22dc:	e8 9a 1d 00 00       	call   407b <read>
    22e1:	83 c4 10             	add    $0x10,%esp
    22e4:	83 f8 02             	cmp    $0x2,%eax
    22e7:	74 17                	je     2300 <subdir+0x376>
    printf(1, "read dd/dd/ffff wrong len\n");
    22e9:	83 ec 08             	sub    $0x8,%esp
    22ec:	68 4e 51 00 00       	push   $0x514e
    22f1:	6a 01                	push   $0x1
    22f3:	e8 ef 1e 00 00       	call   41e7 <printf>
    22f8:	83 c4 10             	add    $0x10,%esp
    exit();
    22fb:	e8 63 1d 00 00       	call   4063 <exit>
  }
  close(fd);
    2300:	83 ec 0c             	sub    $0xc,%esp
    2303:	ff 75 f4             	push   -0xc(%ebp)
    2306:	e8 80 1d 00 00       	call   408b <close>
    230b:	83 c4 10             	add    $0x10,%esp

  if(open("dd/dd/ff", O_RDONLY) >= 0){
    230e:	83 ec 08             	sub    $0x8,%esp
    2311:	6a 00                	push   $0x0
    2313:	68 08 50 00 00       	push   $0x5008
    2318:	e8 86 1d 00 00       	call   40a3 <open>
    231d:	83 c4 10             	add    $0x10,%esp
    2320:	85 c0                	test   %eax,%eax
    2322:	78 17                	js     233b <subdir+0x3b1>
    printf(1, "open (unlinked) dd/dd/ff succeeded!\n");
    2324:	83 ec 08             	sub    $0x8,%esp
    2327:	68 6c 51 00 00       	push   $0x516c
    232c:	6a 01                	push   $0x1
    232e:	e8 b4 1e 00 00       	call   41e7 <printf>
    2333:	83 c4 10             	add    $0x10,%esp
    exit();
    2336:	e8 28 1d 00 00       	call   4063 <exit>
  }

  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    233b:	83 ec 08             	sub    $0x8,%esp
    233e:	68 02 02 00 00       	push   $0x202
    2343:	68 91 51 00 00       	push   $0x5191
    2348:	e8 56 1d 00 00       	call   40a3 <open>
    234d:	83 c4 10             	add    $0x10,%esp
    2350:	85 c0                	test   %eax,%eax
    2352:	78 17                	js     236b <subdir+0x3e1>
    printf(1, "create dd/ff/ff succeeded!\n");
    2354:	83 ec 08             	sub    $0x8,%esp
    2357:	68 9a 51 00 00       	push   $0x519a
    235c:	6a 01                	push   $0x1
    235e:	e8 84 1e 00 00       	call   41e7 <printf>
    2363:	83 c4 10             	add    $0x10,%esp
    exit();
    2366:	e8 f8 1c 00 00       	call   4063 <exit>
  }
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    236b:	83 ec 08             	sub    $0x8,%esp
    236e:	68 02 02 00 00       	push   $0x202
    2373:	68 b6 51 00 00       	push   $0x51b6
    2378:	e8 26 1d 00 00       	call   40a3 <open>
    237d:	83 c4 10             	add    $0x10,%esp
    2380:	85 c0                	test   %eax,%eax
    2382:	78 17                	js     239b <subdir+0x411>
    printf(1, "create dd/xx/ff succeeded!\n");
    2384:	83 ec 08             	sub    $0x8,%esp
    2387:	68 bf 51 00 00       	push   $0x51bf
    238c:	6a 01                	push   $0x1
    238e:	e8 54 1e 00 00       	call   41e7 <printf>
    2393:	83 c4 10             	add    $0x10,%esp
    exit();
    2396:	e8 c8 1c 00 00       	call   4063 <exit>
  }
  if(open("dd", O_CREATE) >= 0){
    239b:	83 ec 08             	sub    $0x8,%esp
    239e:	68 00 02 00 00       	push   $0x200
    23a3:	68 89 4f 00 00       	push   $0x4f89
    23a8:	e8 f6 1c 00 00       	call   40a3 <open>
    23ad:	83 c4 10             	add    $0x10,%esp
    23b0:	85 c0                	test   %eax,%eax
    23b2:	78 17                	js     23cb <subdir+0x441>
    printf(1, "create dd succeeded!\n");
    23b4:	83 ec 08             	sub    $0x8,%esp
    23b7:	68 db 51 00 00       	push   $0x51db
    23bc:	6a 01                	push   $0x1
    23be:	e8 24 1e 00 00       	call   41e7 <printf>
    23c3:	83 c4 10             	add    $0x10,%esp
    exit();
    23c6:	e8 98 1c 00 00       	call   4063 <exit>
  }
  if(open("dd", O_RDWR) >= 0){
    23cb:	83 ec 08             	sub    $0x8,%esp
    23ce:	6a 02                	push   $0x2
    23d0:	68 89 4f 00 00       	push   $0x4f89
    23d5:	e8 c9 1c 00 00       	call   40a3 <open>
    23da:	83 c4 10             	add    $0x10,%esp
    23dd:	85 c0                	test   %eax,%eax
    23df:	78 17                	js     23f8 <subdir+0x46e>
    printf(1, "open dd rdwr succeeded!\n");
    23e1:	83 ec 08             	sub    $0x8,%esp
    23e4:	68 f1 51 00 00       	push   $0x51f1
    23e9:	6a 01                	push   $0x1
    23eb:	e8 f7 1d 00 00       	call   41e7 <printf>
    23f0:	83 c4 10             	add    $0x10,%esp
    exit();
    23f3:	e8 6b 1c 00 00       	call   4063 <exit>
  }
  if(open("dd", O_WRONLY) >= 0){
    23f8:	83 ec 08             	sub    $0x8,%esp
    23fb:	6a 01                	push   $0x1
    23fd:	68 89 4f 00 00       	push   $0x4f89
    2402:	e8 9c 1c 00 00       	call   40a3 <open>
    2407:	83 c4 10             	add    $0x10,%esp
    240a:	85 c0                	test   %eax,%eax
    240c:	78 17                	js     2425 <subdir+0x49b>
    printf(1, "open dd wronly succeeded!\n");
    240e:	83 ec 08             	sub    $0x8,%esp
    2411:	68 0a 52 00 00       	push   $0x520a
    2416:	6a 01                	push   $0x1
    2418:	e8 ca 1d 00 00       	call   41e7 <printf>
    241d:	83 c4 10             	add    $0x10,%esp
    exit();
    2420:	e8 3e 1c 00 00       	call   4063 <exit>
  }
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    2425:	83 ec 08             	sub    $0x8,%esp
    2428:	68 25 52 00 00       	push   $0x5225
    242d:	68 91 51 00 00       	push   $0x5191
    2432:	e8 8c 1c 00 00       	call   40c3 <link>
    2437:	83 c4 10             	add    $0x10,%esp
    243a:	85 c0                	test   %eax,%eax
    243c:	75 17                	jne    2455 <subdir+0x4cb>
    printf(1, "link dd/ff/ff dd/dd/xx succeeded!\n");
    243e:	83 ec 08             	sub    $0x8,%esp
    2441:	68 30 52 00 00       	push   $0x5230
    2446:	6a 01                	push   $0x1
    2448:	e8 9a 1d 00 00       	call   41e7 <printf>
    244d:	83 c4 10             	add    $0x10,%esp
    exit();
    2450:	e8 0e 1c 00 00       	call   4063 <exit>
  }
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    2455:	83 ec 08             	sub    $0x8,%esp
    2458:	68 25 52 00 00       	push   $0x5225
    245d:	68 b6 51 00 00       	push   $0x51b6
    2462:	e8 5c 1c 00 00       	call   40c3 <link>
    2467:	83 c4 10             	add    $0x10,%esp
    246a:	85 c0                	test   %eax,%eax
    246c:	75 17                	jne    2485 <subdir+0x4fb>
    printf(1, "link dd/xx/ff dd/dd/xx succeeded!\n");
    246e:	83 ec 08             	sub    $0x8,%esp
    2471:	68 54 52 00 00       	push   $0x5254
    2476:	6a 01                	push   $0x1
    2478:	e8 6a 1d 00 00       	call   41e7 <printf>
    247d:	83 c4 10             	add    $0x10,%esp
    exit();
    2480:	e8 de 1b 00 00       	call   4063 <exit>
  }
  if(link("dd/ff", "dd/dd/ffff") == 0){
    2485:	83 ec 08             	sub    $0x8,%esp
    2488:	68 6c 50 00 00       	push   $0x506c
    248d:	68 a4 4f 00 00       	push   $0x4fa4
    2492:	e8 2c 1c 00 00       	call   40c3 <link>
    2497:	83 c4 10             	add    $0x10,%esp
    249a:	85 c0                	test   %eax,%eax
    249c:	75 17                	jne    24b5 <subdir+0x52b>
    printf(1, "link dd/ff dd/dd/ffff succeeded!\n");
    249e:	83 ec 08             	sub    $0x8,%esp
    24a1:	68 78 52 00 00       	push   $0x5278
    24a6:	6a 01                	push   $0x1
    24a8:	e8 3a 1d 00 00       	call   41e7 <printf>
    24ad:	83 c4 10             	add    $0x10,%esp
    exit();
    24b0:	e8 ae 1b 00 00       	call   4063 <exit>
  }
  if(mkdir("dd/ff/ff") == 0){
    24b5:	83 ec 0c             	sub    $0xc,%esp
    24b8:	68 91 51 00 00       	push   $0x5191
    24bd:	e8 09 1c 00 00       	call   40cb <mkdir>
    24c2:	83 c4 10             	add    $0x10,%esp
    24c5:	85 c0                	test   %eax,%eax
    24c7:	75 17                	jne    24e0 <subdir+0x556>
    printf(1, "mkdir dd/ff/ff succeeded!\n");
    24c9:	83 ec 08             	sub    $0x8,%esp
    24cc:	68 9a 52 00 00       	push   $0x529a
    24d1:	6a 01                	push   $0x1
    24d3:	e8 0f 1d 00 00       	call   41e7 <printf>
    24d8:	83 c4 10             	add    $0x10,%esp
    exit();
    24db:	e8 83 1b 00 00       	call   4063 <exit>
  }
  if(mkdir("dd/xx/ff") == 0){
    24e0:	83 ec 0c             	sub    $0xc,%esp
    24e3:	68 b6 51 00 00       	push   $0x51b6
    24e8:	e8 de 1b 00 00       	call   40cb <mkdir>
    24ed:	83 c4 10             	add    $0x10,%esp
    24f0:	85 c0                	test   %eax,%eax
    24f2:	75 17                	jne    250b <subdir+0x581>
    printf(1, "mkdir dd/xx/ff succeeded!\n");
    24f4:	83 ec 08             	sub    $0x8,%esp
    24f7:	68 b5 52 00 00       	push   $0x52b5
    24fc:	6a 01                	push   $0x1
    24fe:	e8 e4 1c 00 00       	call   41e7 <printf>
    2503:	83 c4 10             	add    $0x10,%esp
    exit();
    2506:	e8 58 1b 00 00       	call   4063 <exit>
  }
  if(mkdir("dd/dd/ffff") == 0){
    250b:	83 ec 0c             	sub    $0xc,%esp
    250e:	68 6c 50 00 00       	push   $0x506c
    2513:	e8 b3 1b 00 00       	call   40cb <mkdir>
    2518:	83 c4 10             	add    $0x10,%esp
    251b:	85 c0                	test   %eax,%eax
    251d:	75 17                	jne    2536 <subdir+0x5ac>
    printf(1, "mkdir dd/dd/ffff succeeded!\n");
    251f:	83 ec 08             	sub    $0x8,%esp
    2522:	68 d0 52 00 00       	push   $0x52d0
    2527:	6a 01                	push   $0x1
    2529:	e8 b9 1c 00 00       	call   41e7 <printf>
    252e:	83 c4 10             	add    $0x10,%esp
    exit();
    2531:	e8 2d 1b 00 00       	call   4063 <exit>
  }
  if(unlink("dd/xx/ff") == 0){
    2536:	83 ec 0c             	sub    $0xc,%esp
    2539:	68 b6 51 00 00       	push   $0x51b6
    253e:	e8 70 1b 00 00       	call   40b3 <unlink>
    2543:	83 c4 10             	add    $0x10,%esp
    2546:	85 c0                	test   %eax,%eax
    2548:	75 17                	jne    2561 <subdir+0x5d7>
    printf(1, "unlink dd/xx/ff succeeded!\n");
    254a:	83 ec 08             	sub    $0x8,%esp
    254d:	68 ed 52 00 00       	push   $0x52ed
    2552:	6a 01                	push   $0x1
    2554:	e8 8e 1c 00 00       	call   41e7 <printf>
    2559:	83 c4 10             	add    $0x10,%esp
    exit();
    255c:	e8 02 1b 00 00       	call   4063 <exit>
  }
  if(unlink("dd/ff/ff") == 0){
    2561:	83 ec 0c             	sub    $0xc,%esp
    2564:	68 91 51 00 00       	push   $0x5191
    2569:	e8 45 1b 00 00       	call   40b3 <unlink>
    256e:	83 c4 10             	add    $0x10,%esp
    2571:	85 c0                	test   %eax,%eax
    2573:	75 17                	jne    258c <subdir+0x602>
    printf(1, "unlink dd/ff/ff succeeded!\n");
    2575:	83 ec 08             	sub    $0x8,%esp
    2578:	68 09 53 00 00       	push   $0x5309
    257d:	6a 01                	push   $0x1
    257f:	e8 63 1c 00 00       	call   41e7 <printf>
    2584:	83 c4 10             	add    $0x10,%esp
    exit();
    2587:	e8 d7 1a 00 00       	call   4063 <exit>
  }
  if(chdir("dd/ff") == 0){
    258c:	83 ec 0c             	sub    $0xc,%esp
    258f:	68 a4 4f 00 00       	push   $0x4fa4
    2594:	e8 3a 1b 00 00       	call   40d3 <chdir>
    2599:	83 c4 10             	add    $0x10,%esp
    259c:	85 c0                	test   %eax,%eax
    259e:	75 17                	jne    25b7 <subdir+0x62d>
    printf(1, "chdir dd/ff succeeded!\n");
    25a0:	83 ec 08             	sub    $0x8,%esp
    25a3:	68 25 53 00 00       	push   $0x5325
    25a8:	6a 01                	push   $0x1
    25aa:	e8 38 1c 00 00       	call   41e7 <printf>
    25af:	83 c4 10             	add    $0x10,%esp
    exit();
    25b2:	e8 ac 1a 00 00       	call   4063 <exit>
  }
  if(chdir("dd/xx") == 0){
    25b7:	83 ec 0c             	sub    $0xc,%esp
    25ba:	68 3d 53 00 00       	push   $0x533d
    25bf:	e8 0f 1b 00 00       	call   40d3 <chdir>
    25c4:	83 c4 10             	add    $0x10,%esp
    25c7:	85 c0                	test   %eax,%eax
    25c9:	75 17                	jne    25e2 <subdir+0x658>
    printf(1, "chdir dd/xx succeeded!\n");
    25cb:	83 ec 08             	sub    $0x8,%esp
    25ce:	68 43 53 00 00       	push   $0x5343
    25d3:	6a 01                	push   $0x1
    25d5:	e8 0d 1c 00 00       	call   41e7 <printf>
    25da:	83 c4 10             	add    $0x10,%esp
    exit();
    25dd:	e8 81 1a 00 00       	call   4063 <exit>
  }

  if(unlink("dd/dd/ffff") != 0){
    25e2:	83 ec 0c             	sub    $0xc,%esp
    25e5:	68 6c 50 00 00       	push   $0x506c
    25ea:	e8 c4 1a 00 00       	call   40b3 <unlink>
    25ef:	83 c4 10             	add    $0x10,%esp
    25f2:	85 c0                	test   %eax,%eax
    25f4:	74 17                	je     260d <subdir+0x683>
    printf(1, "unlink dd/dd/ff failed\n");
    25f6:	83 ec 08             	sub    $0x8,%esp
    25f9:	68 99 50 00 00       	push   $0x5099
    25fe:	6a 01                	push   $0x1
    2600:	e8 e2 1b 00 00       	call   41e7 <printf>
    2605:	83 c4 10             	add    $0x10,%esp
    exit();
    2608:	e8 56 1a 00 00       	call   4063 <exit>
  }
  if(unlink("dd/ff") != 0){
    260d:	83 ec 0c             	sub    $0xc,%esp
    2610:	68 a4 4f 00 00       	push   $0x4fa4
    2615:	e8 99 1a 00 00       	call   40b3 <unlink>
    261a:	83 c4 10             	add    $0x10,%esp
    261d:	85 c0                	test   %eax,%eax
    261f:	74 17                	je     2638 <subdir+0x6ae>
    printf(1, "unlink dd/ff failed\n");
    2621:	83 ec 08             	sub    $0x8,%esp
    2624:	68 5b 53 00 00       	push   $0x535b
    2629:	6a 01                	push   $0x1
    262b:	e8 b7 1b 00 00       	call   41e7 <printf>
    2630:	83 c4 10             	add    $0x10,%esp
    exit();
    2633:	e8 2b 1a 00 00       	call   4063 <exit>
  }
  if(unlink("dd") == 0){
    2638:	83 ec 0c             	sub    $0xc,%esp
    263b:	68 89 4f 00 00       	push   $0x4f89
    2640:	e8 6e 1a 00 00       	call   40b3 <unlink>
    2645:	83 c4 10             	add    $0x10,%esp
    2648:	85 c0                	test   %eax,%eax
    264a:	75 17                	jne    2663 <subdir+0x6d9>
    printf(1, "unlink non-empty dd succeeded!\n");
    264c:	83 ec 08             	sub    $0x8,%esp
    264f:	68 70 53 00 00       	push   $0x5370
    2654:	6a 01                	push   $0x1
    2656:	e8 8c 1b 00 00       	call   41e7 <printf>
    265b:	83 c4 10             	add    $0x10,%esp
    exit();
    265e:	e8 00 1a 00 00       	call   4063 <exit>
  }
  if(unlink("dd/dd") < 0){
    2663:	83 ec 0c             	sub    $0xc,%esp
    2666:	68 90 53 00 00       	push   $0x5390
    266b:	e8 43 1a 00 00       	call   40b3 <unlink>
    2670:	83 c4 10             	add    $0x10,%esp
    2673:	85 c0                	test   %eax,%eax
    2675:	79 17                	jns    268e <subdir+0x704>
    printf(1, "unlink dd/dd failed\n");
    2677:	83 ec 08             	sub    $0x8,%esp
    267a:	68 96 53 00 00       	push   $0x5396
    267f:	6a 01                	push   $0x1
    2681:	e8 61 1b 00 00       	call   41e7 <printf>
    2686:	83 c4 10             	add    $0x10,%esp
    exit();
    2689:	e8 d5 19 00 00       	call   4063 <exit>
  }
  if(unlink("dd") < 0){
    268e:	83 ec 0c             	sub    $0xc,%esp
    2691:	68 89 4f 00 00       	push   $0x4f89
    2696:	e8 18 1a 00 00       	call   40b3 <unlink>
    269b:	83 c4 10             	add    $0x10,%esp
    269e:	85 c0                	test   %eax,%eax
    26a0:	79 17                	jns    26b9 <subdir+0x72f>
    printf(1, "unlink dd failed\n");
    26a2:	83 ec 08             	sub    $0x8,%esp
    26a5:	68 ab 53 00 00       	push   $0x53ab
    26aa:	6a 01                	push   $0x1
    26ac:	e8 36 1b 00 00       	call   41e7 <printf>
    26b1:	83 c4 10             	add    $0x10,%esp
    exit();
    26b4:	e8 aa 19 00 00       	call   4063 <exit>
  }

  printf(1, "subdir ok\n");
    26b9:	83 ec 08             	sub    $0x8,%esp
    26bc:	68 bd 53 00 00       	push   $0x53bd
    26c1:	6a 01                	push   $0x1
    26c3:	e8 1f 1b 00 00       	call   41e7 <printf>
    26c8:	83 c4 10             	add    $0x10,%esp
}
    26cb:	90                   	nop
    26cc:	c9                   	leave  
    26cd:	c3                   	ret    

000026ce <bigwrite>:

// test writes that are larger than the log.
void
bigwrite(void)
{
    26ce:	55                   	push   %ebp
    26cf:	89 e5                	mov    %esp,%ebp
    26d1:	83 ec 18             	sub    $0x18,%esp
  int fd, sz;

  printf(1, "bigwrite test\n");
    26d4:	83 ec 08             	sub    $0x8,%esp
    26d7:	68 c8 53 00 00       	push   $0x53c8
    26dc:	6a 01                	push   $0x1
    26de:	e8 04 1b 00 00       	call   41e7 <printf>
    26e3:	83 c4 10             	add    $0x10,%esp

  unlink("bigwrite");
    26e6:	83 ec 0c             	sub    $0xc,%esp
    26e9:	68 d7 53 00 00       	push   $0x53d7
    26ee:	e8 c0 19 00 00       	call   40b3 <unlink>
    26f3:	83 c4 10             	add    $0x10,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    26f6:	c7 45 f4 f3 01 00 00 	movl   $0x1f3,-0xc(%ebp)
    26fd:	e9 a8 00 00 00       	jmp    27aa <bigwrite+0xdc>
    fd = open("bigwrite", O_CREATE | O_RDWR);
    2702:	83 ec 08             	sub    $0x8,%esp
    2705:	68 02 02 00 00       	push   $0x202
    270a:	68 d7 53 00 00       	push   $0x53d7
    270f:	e8 8f 19 00 00       	call   40a3 <open>
    2714:	83 c4 10             	add    $0x10,%esp
    2717:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(fd < 0){
    271a:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    271e:	79 17                	jns    2737 <bigwrite+0x69>
      printf(1, "cannot create bigwrite\n");
    2720:	83 ec 08             	sub    $0x8,%esp
    2723:	68 e0 53 00 00       	push   $0x53e0
    2728:	6a 01                	push   $0x1
    272a:	e8 b8 1a 00 00       	call   41e7 <printf>
    272f:	83 c4 10             	add    $0x10,%esp
      exit();
    2732:	e8 2c 19 00 00       	call   4063 <exit>
    }
    int i;
    for(i = 0; i < 2; i++){
    2737:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    273e:	eb 3f                	jmp    277f <bigwrite+0xb1>
      int cc = write(fd, buf, sz);
    2740:	83 ec 04             	sub    $0x4,%esp
    2743:	ff 75 f4             	push   -0xc(%ebp)
    2746:	68 40 65 00 00       	push   $0x6540
    274b:	ff 75 ec             	push   -0x14(%ebp)
    274e:	e8 30 19 00 00       	call   4083 <write>
    2753:	83 c4 10             	add    $0x10,%esp
    2756:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if(cc != sz){
    2759:	8b 45 e8             	mov    -0x18(%ebp),%eax
    275c:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    275f:	74 1a                	je     277b <bigwrite+0xad>
        printf(1, "write(%d) ret %d\n", sz, cc);
    2761:	ff 75 e8             	push   -0x18(%ebp)
    2764:	ff 75 f4             	push   -0xc(%ebp)
    2767:	68 f8 53 00 00       	push   $0x53f8
    276c:	6a 01                	push   $0x1
    276e:	e8 74 1a 00 00       	call   41e7 <printf>
    2773:	83 c4 10             	add    $0x10,%esp
        exit();
    2776:	e8 e8 18 00 00       	call   4063 <exit>
    for(i = 0; i < 2; i++){
    277b:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    277f:	83 7d f0 01          	cmpl   $0x1,-0x10(%ebp)
    2783:	7e bb                	jle    2740 <bigwrite+0x72>
      }
    }
    close(fd);
    2785:	83 ec 0c             	sub    $0xc,%esp
    2788:	ff 75 ec             	push   -0x14(%ebp)
    278b:	e8 fb 18 00 00       	call   408b <close>
    2790:	83 c4 10             	add    $0x10,%esp
    unlink("bigwrite");
    2793:	83 ec 0c             	sub    $0xc,%esp
    2796:	68 d7 53 00 00       	push   $0x53d7
    279b:	e8 13 19 00 00       	call   40b3 <unlink>
    27a0:	83 c4 10             	add    $0x10,%esp
  for(sz = 499; sz < 12*512; sz += 471){
    27a3:	81 45 f4 d7 01 00 00 	addl   $0x1d7,-0xc(%ebp)
    27aa:	81 7d f4 ff 17 00 00 	cmpl   $0x17ff,-0xc(%ebp)
    27b1:	0f 8e 4b ff ff ff    	jle    2702 <bigwrite+0x34>
  }

  printf(1, "bigwrite ok\n");
    27b7:	83 ec 08             	sub    $0x8,%esp
    27ba:	68 0a 54 00 00       	push   $0x540a
    27bf:	6a 01                	push   $0x1
    27c1:	e8 21 1a 00 00       	call   41e7 <printf>
    27c6:	83 c4 10             	add    $0x10,%esp
}
    27c9:	90                   	nop
    27ca:	c9                   	leave  
    27cb:	c3                   	ret    

000027cc <bigfile>:

void
bigfile(void)
{
    27cc:	55                   	push   %ebp
    27cd:	89 e5                	mov    %esp,%ebp
    27cf:	83 ec 18             	sub    $0x18,%esp
  int fd, i, total, cc;

  printf(1, "bigfile test\n");
    27d2:	83 ec 08             	sub    $0x8,%esp
    27d5:	68 17 54 00 00       	push   $0x5417
    27da:	6a 01                	push   $0x1
    27dc:	e8 06 1a 00 00       	call   41e7 <printf>
    27e1:	83 c4 10             	add    $0x10,%esp

  unlink("bigfile");
    27e4:	83 ec 0c             	sub    $0xc,%esp
    27e7:	68 25 54 00 00       	push   $0x5425
    27ec:	e8 c2 18 00 00       	call   40b3 <unlink>
    27f1:	83 c4 10             	add    $0x10,%esp
  fd = open("bigfile", O_CREATE | O_RDWR);
    27f4:	83 ec 08             	sub    $0x8,%esp
    27f7:	68 02 02 00 00       	push   $0x202
    27fc:	68 25 54 00 00       	push   $0x5425
    2801:	e8 9d 18 00 00       	call   40a3 <open>
    2806:	83 c4 10             	add    $0x10,%esp
    2809:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    280c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    2810:	79 17                	jns    2829 <bigfile+0x5d>
    printf(1, "cannot create bigfile");
    2812:	83 ec 08             	sub    $0x8,%esp
    2815:	68 2d 54 00 00       	push   $0x542d
    281a:	6a 01                	push   $0x1
    281c:	e8 c6 19 00 00       	call   41e7 <printf>
    2821:	83 c4 10             	add    $0x10,%esp
    exit();
    2824:	e8 3a 18 00 00       	call   4063 <exit>
  }
  for(i = 0; i < 20; i++){
    2829:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2830:	eb 52                	jmp    2884 <bigfile+0xb8>
    memset(buf, i, 600);
    2832:	83 ec 04             	sub    $0x4,%esp
    2835:	68 58 02 00 00       	push   $0x258
    283a:	ff 75 f4             	push   -0xc(%ebp)
    283d:	68 40 65 00 00       	push   $0x6540
    2842:	e8 26 16 00 00       	call   3e6d <memset>
    2847:	83 c4 10             	add    $0x10,%esp
    if(write(fd, buf, 600) != 600){
    284a:	83 ec 04             	sub    $0x4,%esp
    284d:	68 58 02 00 00       	push   $0x258
    2852:	68 40 65 00 00       	push   $0x6540
    2857:	ff 75 ec             	push   -0x14(%ebp)
    285a:	e8 24 18 00 00       	call   4083 <write>
    285f:	83 c4 10             	add    $0x10,%esp
    2862:	3d 58 02 00 00       	cmp    $0x258,%eax
    2867:	74 17                	je     2880 <bigfile+0xb4>
      printf(1, "write bigfile failed\n");
    2869:	83 ec 08             	sub    $0x8,%esp
    286c:	68 43 54 00 00       	push   $0x5443
    2871:	6a 01                	push   $0x1
    2873:	e8 6f 19 00 00       	call   41e7 <printf>
    2878:	83 c4 10             	add    $0x10,%esp
      exit();
    287b:	e8 e3 17 00 00       	call   4063 <exit>
  for(i = 0; i < 20; i++){
    2880:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    2884:	83 7d f4 13          	cmpl   $0x13,-0xc(%ebp)
    2888:	7e a8                	jle    2832 <bigfile+0x66>
    }
  }
  close(fd);
    288a:	83 ec 0c             	sub    $0xc,%esp
    288d:	ff 75 ec             	push   -0x14(%ebp)
    2890:	e8 f6 17 00 00       	call   408b <close>
    2895:	83 c4 10             	add    $0x10,%esp

  fd = open("bigfile", 0);
    2898:	83 ec 08             	sub    $0x8,%esp
    289b:	6a 00                	push   $0x0
    289d:	68 25 54 00 00       	push   $0x5425
    28a2:	e8 fc 17 00 00       	call   40a3 <open>
    28a7:	83 c4 10             	add    $0x10,%esp
    28aa:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    28ad:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    28b1:	79 17                	jns    28ca <bigfile+0xfe>
    printf(1, "cannot open bigfile\n");
    28b3:	83 ec 08             	sub    $0x8,%esp
    28b6:	68 59 54 00 00       	push   $0x5459
    28bb:	6a 01                	push   $0x1
    28bd:	e8 25 19 00 00       	call   41e7 <printf>
    28c2:	83 c4 10             	add    $0x10,%esp
    exit();
    28c5:	e8 99 17 00 00       	call   4063 <exit>
  }
  total = 0;
    28ca:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(i = 0; ; i++){
    28d1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    cc = read(fd, buf, 300);
    28d8:	83 ec 04             	sub    $0x4,%esp
    28db:	68 2c 01 00 00       	push   $0x12c
    28e0:	68 40 65 00 00       	push   $0x6540
    28e5:	ff 75 ec             	push   -0x14(%ebp)
    28e8:	e8 8e 17 00 00       	call   407b <read>
    28ed:	83 c4 10             	add    $0x10,%esp
    28f0:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(cc < 0){
    28f3:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    28f7:	79 17                	jns    2910 <bigfile+0x144>
      printf(1, "read bigfile failed\n");
    28f9:	83 ec 08             	sub    $0x8,%esp
    28fc:	68 6e 54 00 00       	push   $0x546e
    2901:	6a 01                	push   $0x1
    2903:	e8 df 18 00 00       	call   41e7 <printf>
    2908:	83 c4 10             	add    $0x10,%esp
      exit();
    290b:	e8 53 17 00 00       	call   4063 <exit>
    }
    if(cc == 0)
    2910:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    2914:	74 7a                	je     2990 <bigfile+0x1c4>
      break;
    if(cc != 300){
    2916:	81 7d e8 2c 01 00 00 	cmpl   $0x12c,-0x18(%ebp)
    291d:	74 17                	je     2936 <bigfile+0x16a>
      printf(1, "short read bigfile\n");
    291f:	83 ec 08             	sub    $0x8,%esp
    2922:	68 83 54 00 00       	push   $0x5483
    2927:	6a 01                	push   $0x1
    2929:	e8 b9 18 00 00       	call   41e7 <printf>
    292e:	83 c4 10             	add    $0x10,%esp
      exit();
    2931:	e8 2d 17 00 00       	call   4063 <exit>
    }
    if(buf[0] != i/2 || buf[299] != i/2){
    2936:	0f b6 05 40 65 00 00 	movzbl 0x6540,%eax
    293d:	0f be d0             	movsbl %al,%edx
    2940:	8b 45 f4             	mov    -0xc(%ebp),%eax
    2943:	89 c1                	mov    %eax,%ecx
    2945:	c1 e9 1f             	shr    $0x1f,%ecx
    2948:	01 c8                	add    %ecx,%eax
    294a:	d1 f8                	sar    %eax
    294c:	39 c2                	cmp    %eax,%edx
    294e:	75 1a                	jne    296a <bigfile+0x19e>
    2950:	0f b6 05 6b 66 00 00 	movzbl 0x666b,%eax
    2957:	0f be d0             	movsbl %al,%edx
    295a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    295d:	89 c1                	mov    %eax,%ecx
    295f:	c1 e9 1f             	shr    $0x1f,%ecx
    2962:	01 c8                	add    %ecx,%eax
    2964:	d1 f8                	sar    %eax
    2966:	39 c2                	cmp    %eax,%edx
    2968:	74 17                	je     2981 <bigfile+0x1b5>
      printf(1, "read bigfile wrong data\n");
    296a:	83 ec 08             	sub    $0x8,%esp
    296d:	68 97 54 00 00       	push   $0x5497
    2972:	6a 01                	push   $0x1
    2974:	e8 6e 18 00 00       	call   41e7 <printf>
    2979:	83 c4 10             	add    $0x10,%esp
      exit();
    297c:	e8 e2 16 00 00       	call   4063 <exit>
    }
    total += cc;
    2981:	8b 45 e8             	mov    -0x18(%ebp),%eax
    2984:	01 45 f0             	add    %eax,-0x10(%ebp)
  for(i = 0; ; i++){
    2987:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    cc = read(fd, buf, 300);
    298b:	e9 48 ff ff ff       	jmp    28d8 <bigfile+0x10c>
      break;
    2990:	90                   	nop
  }
  close(fd);
    2991:	83 ec 0c             	sub    $0xc,%esp
    2994:	ff 75 ec             	push   -0x14(%ebp)
    2997:	e8 ef 16 00 00       	call   408b <close>
    299c:	83 c4 10             	add    $0x10,%esp
  if(total != 20*600){
    299f:	81 7d f0 e0 2e 00 00 	cmpl   $0x2ee0,-0x10(%ebp)
    29a6:	74 17                	je     29bf <bigfile+0x1f3>
    printf(1, "read bigfile wrong total\n");
    29a8:	83 ec 08             	sub    $0x8,%esp
    29ab:	68 b0 54 00 00       	push   $0x54b0
    29b0:	6a 01                	push   $0x1
    29b2:	e8 30 18 00 00       	call   41e7 <printf>
    29b7:	83 c4 10             	add    $0x10,%esp
    exit();
    29ba:	e8 a4 16 00 00       	call   4063 <exit>
  }
  unlink("bigfile");
    29bf:	83 ec 0c             	sub    $0xc,%esp
    29c2:	68 25 54 00 00       	push   $0x5425
    29c7:	e8 e7 16 00 00       	call   40b3 <unlink>
    29cc:	83 c4 10             	add    $0x10,%esp

  printf(1, "bigfile test ok\n");
    29cf:	83 ec 08             	sub    $0x8,%esp
    29d2:	68 ca 54 00 00       	push   $0x54ca
    29d7:	6a 01                	push   $0x1
    29d9:	e8 09 18 00 00       	call   41e7 <printf>
    29de:	83 c4 10             	add    $0x10,%esp
}
    29e1:	90                   	nop
    29e2:	c9                   	leave  
    29e3:	c3                   	ret    

000029e4 <fourteen>:

void
fourteen(void)
{
    29e4:	55                   	push   %ebp
    29e5:	89 e5                	mov    %esp,%ebp
    29e7:	83 ec 18             	sub    $0x18,%esp
  int fd;

  // DIRSIZ is 14.
  printf(1, "fourteen test\n");
    29ea:	83 ec 08             	sub    $0x8,%esp
    29ed:	68 db 54 00 00       	push   $0x54db
    29f2:	6a 01                	push   $0x1
    29f4:	e8 ee 17 00 00       	call   41e7 <printf>
    29f9:	83 c4 10             	add    $0x10,%esp

  if(mkdir("12345678901234") != 0){
    29fc:	83 ec 0c             	sub    $0xc,%esp
    29ff:	68 ea 54 00 00       	push   $0x54ea
    2a04:	e8 c2 16 00 00       	call   40cb <mkdir>
    2a09:	83 c4 10             	add    $0x10,%esp
    2a0c:	85 c0                	test   %eax,%eax
    2a0e:	74 17                	je     2a27 <fourteen+0x43>
    printf(1, "mkdir 12345678901234 failed\n");
    2a10:	83 ec 08             	sub    $0x8,%esp
    2a13:	68 f9 54 00 00       	push   $0x54f9
    2a18:	6a 01                	push   $0x1
    2a1a:	e8 c8 17 00 00       	call   41e7 <printf>
    2a1f:	83 c4 10             	add    $0x10,%esp
    exit();
    2a22:	e8 3c 16 00 00       	call   4063 <exit>
  }
  if(mkdir("12345678901234/123456789012345") != 0){
    2a27:	83 ec 0c             	sub    $0xc,%esp
    2a2a:	68 18 55 00 00       	push   $0x5518
    2a2f:	e8 97 16 00 00       	call   40cb <mkdir>
    2a34:	83 c4 10             	add    $0x10,%esp
    2a37:	85 c0                	test   %eax,%eax
    2a39:	74 17                	je     2a52 <fourteen+0x6e>
    printf(1, "mkdir 12345678901234/123456789012345 failed\n");
    2a3b:	83 ec 08             	sub    $0x8,%esp
    2a3e:	68 38 55 00 00       	push   $0x5538
    2a43:	6a 01                	push   $0x1
    2a45:	e8 9d 17 00 00       	call   41e7 <printf>
    2a4a:	83 c4 10             	add    $0x10,%esp
    exit();
    2a4d:	e8 11 16 00 00       	call   4063 <exit>
  }
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2a52:	83 ec 08             	sub    $0x8,%esp
    2a55:	68 00 02 00 00       	push   $0x200
    2a5a:	68 68 55 00 00       	push   $0x5568
    2a5f:	e8 3f 16 00 00       	call   40a3 <open>
    2a64:	83 c4 10             	add    $0x10,%esp
    2a67:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2a6a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2a6e:	79 17                	jns    2a87 <fourteen+0xa3>
    printf(1, "create 123456789012345/123456789012345/123456789012345 failed\n");
    2a70:	83 ec 08             	sub    $0x8,%esp
    2a73:	68 98 55 00 00       	push   $0x5598
    2a78:	6a 01                	push   $0x1
    2a7a:	e8 68 17 00 00       	call   41e7 <printf>
    2a7f:	83 c4 10             	add    $0x10,%esp
    exit();
    2a82:	e8 dc 15 00 00       	call   4063 <exit>
  }
  close(fd);
    2a87:	83 ec 0c             	sub    $0xc,%esp
    2a8a:	ff 75 f4             	push   -0xc(%ebp)
    2a8d:	e8 f9 15 00 00       	call   408b <close>
    2a92:	83 c4 10             	add    $0x10,%esp
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2a95:	83 ec 08             	sub    $0x8,%esp
    2a98:	6a 00                	push   $0x0
    2a9a:	68 d8 55 00 00       	push   $0x55d8
    2a9f:	e8 ff 15 00 00       	call   40a3 <open>
    2aa4:	83 c4 10             	add    $0x10,%esp
    2aa7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2aaa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2aae:	79 17                	jns    2ac7 <fourteen+0xe3>
    printf(1, "open 12345678901234/12345678901234/12345678901234 failed\n");
    2ab0:	83 ec 08             	sub    $0x8,%esp
    2ab3:	68 08 56 00 00       	push   $0x5608
    2ab8:	6a 01                	push   $0x1
    2aba:	e8 28 17 00 00       	call   41e7 <printf>
    2abf:	83 c4 10             	add    $0x10,%esp
    exit();
    2ac2:	e8 9c 15 00 00       	call   4063 <exit>
  }
  close(fd);
    2ac7:	83 ec 0c             	sub    $0xc,%esp
    2aca:	ff 75 f4             	push   -0xc(%ebp)
    2acd:	e8 b9 15 00 00       	call   408b <close>
    2ad2:	83 c4 10             	add    $0x10,%esp

  if(mkdir("12345678901234/12345678901234") == 0){
    2ad5:	83 ec 0c             	sub    $0xc,%esp
    2ad8:	68 42 56 00 00       	push   $0x5642
    2add:	e8 e9 15 00 00       	call   40cb <mkdir>
    2ae2:	83 c4 10             	add    $0x10,%esp
    2ae5:	85 c0                	test   %eax,%eax
    2ae7:	75 17                	jne    2b00 <fourteen+0x11c>
    printf(1, "mkdir 12345678901234/12345678901234 succeeded!\n");
    2ae9:	83 ec 08             	sub    $0x8,%esp
    2aec:	68 60 56 00 00       	push   $0x5660
    2af1:	6a 01                	push   $0x1
    2af3:	e8 ef 16 00 00       	call   41e7 <printf>
    2af8:	83 c4 10             	add    $0x10,%esp
    exit();
    2afb:	e8 63 15 00 00       	call   4063 <exit>
  }
  if(mkdir("123456789012345/12345678901234") == 0){
    2b00:	83 ec 0c             	sub    $0xc,%esp
    2b03:	68 90 56 00 00       	push   $0x5690
    2b08:	e8 be 15 00 00       	call   40cb <mkdir>
    2b0d:	83 c4 10             	add    $0x10,%esp
    2b10:	85 c0                	test   %eax,%eax
    2b12:	75 17                	jne    2b2b <fourteen+0x147>
    printf(1, "mkdir 12345678901234/123456789012345 succeeded!\n");
    2b14:	83 ec 08             	sub    $0x8,%esp
    2b17:	68 b0 56 00 00       	push   $0x56b0
    2b1c:	6a 01                	push   $0x1
    2b1e:	e8 c4 16 00 00       	call   41e7 <printf>
    2b23:	83 c4 10             	add    $0x10,%esp
    exit();
    2b26:	e8 38 15 00 00       	call   4063 <exit>
  }

  printf(1, "fourteen ok\n");
    2b2b:	83 ec 08             	sub    $0x8,%esp
    2b2e:	68 e1 56 00 00       	push   $0x56e1
    2b33:	6a 01                	push   $0x1
    2b35:	e8 ad 16 00 00       	call   41e7 <printf>
    2b3a:	83 c4 10             	add    $0x10,%esp
}
    2b3d:	90                   	nop
    2b3e:	c9                   	leave  
    2b3f:	c3                   	ret    

00002b40 <rmdot>:

void
rmdot(void)
{
    2b40:	55                   	push   %ebp
    2b41:	89 e5                	mov    %esp,%ebp
    2b43:	83 ec 08             	sub    $0x8,%esp
  printf(1, "rmdot test\n");
    2b46:	83 ec 08             	sub    $0x8,%esp
    2b49:	68 ee 56 00 00       	push   $0x56ee
    2b4e:	6a 01                	push   $0x1
    2b50:	e8 92 16 00 00       	call   41e7 <printf>
    2b55:	83 c4 10             	add    $0x10,%esp
  if(mkdir("dots") != 0){
    2b58:	83 ec 0c             	sub    $0xc,%esp
    2b5b:	68 fa 56 00 00       	push   $0x56fa
    2b60:	e8 66 15 00 00       	call   40cb <mkdir>
    2b65:	83 c4 10             	add    $0x10,%esp
    2b68:	85 c0                	test   %eax,%eax
    2b6a:	74 17                	je     2b83 <rmdot+0x43>
    printf(1, "mkdir dots failed\n");
    2b6c:	83 ec 08             	sub    $0x8,%esp
    2b6f:	68 ff 56 00 00       	push   $0x56ff
    2b74:	6a 01                	push   $0x1
    2b76:	e8 6c 16 00 00       	call   41e7 <printf>
    2b7b:	83 c4 10             	add    $0x10,%esp
    exit();
    2b7e:	e8 e0 14 00 00       	call   4063 <exit>
  }
  if(chdir("dots") != 0){
    2b83:	83 ec 0c             	sub    $0xc,%esp
    2b86:	68 fa 56 00 00       	push   $0x56fa
    2b8b:	e8 43 15 00 00       	call   40d3 <chdir>
    2b90:	83 c4 10             	add    $0x10,%esp
    2b93:	85 c0                	test   %eax,%eax
    2b95:	74 17                	je     2bae <rmdot+0x6e>
    printf(1, "chdir dots failed\n");
    2b97:	83 ec 08             	sub    $0x8,%esp
    2b9a:	68 12 57 00 00       	push   $0x5712
    2b9f:	6a 01                	push   $0x1
    2ba1:	e8 41 16 00 00       	call   41e7 <printf>
    2ba6:	83 c4 10             	add    $0x10,%esp
    exit();
    2ba9:	e8 b5 14 00 00       	call   4063 <exit>
  }
  if(unlink(".") == 0){
    2bae:	83 ec 0c             	sub    $0xc,%esp
    2bb1:	68 2b 4e 00 00       	push   $0x4e2b
    2bb6:	e8 f8 14 00 00       	call   40b3 <unlink>
    2bbb:	83 c4 10             	add    $0x10,%esp
    2bbe:	85 c0                	test   %eax,%eax
    2bc0:	75 17                	jne    2bd9 <rmdot+0x99>
    printf(1, "rm . worked!\n");
    2bc2:	83 ec 08             	sub    $0x8,%esp
    2bc5:	68 25 57 00 00       	push   $0x5725
    2bca:	6a 01                	push   $0x1
    2bcc:	e8 16 16 00 00       	call   41e7 <printf>
    2bd1:	83 c4 10             	add    $0x10,%esp
    exit();
    2bd4:	e8 8a 14 00 00       	call   4063 <exit>
  }
  if(unlink("..") == 0){
    2bd9:	83 ec 0c             	sub    $0xc,%esp
    2bdc:	68 be 49 00 00       	push   $0x49be
    2be1:	e8 cd 14 00 00       	call   40b3 <unlink>
    2be6:	83 c4 10             	add    $0x10,%esp
    2be9:	85 c0                	test   %eax,%eax
    2beb:	75 17                	jne    2c04 <rmdot+0xc4>
    printf(1, "rm .. worked!\n");
    2bed:	83 ec 08             	sub    $0x8,%esp
    2bf0:	68 33 57 00 00       	push   $0x5733
    2bf5:	6a 01                	push   $0x1
    2bf7:	e8 eb 15 00 00       	call   41e7 <printf>
    2bfc:	83 c4 10             	add    $0x10,%esp
    exit();
    2bff:	e8 5f 14 00 00       	call   4063 <exit>
  }
  if(chdir("/") != 0){
    2c04:	83 ec 0c             	sub    $0xc,%esp
    2c07:	68 12 46 00 00       	push   $0x4612
    2c0c:	e8 c2 14 00 00       	call   40d3 <chdir>
    2c11:	83 c4 10             	add    $0x10,%esp
    2c14:	85 c0                	test   %eax,%eax
    2c16:	74 17                	je     2c2f <rmdot+0xef>
    printf(1, "chdir / failed\n");
    2c18:	83 ec 08             	sub    $0x8,%esp
    2c1b:	68 14 46 00 00       	push   $0x4614
    2c20:	6a 01                	push   $0x1
    2c22:	e8 c0 15 00 00       	call   41e7 <printf>
    2c27:	83 c4 10             	add    $0x10,%esp
    exit();
    2c2a:	e8 34 14 00 00       	call   4063 <exit>
  }
  if(unlink("dots/.") == 0){
    2c2f:	83 ec 0c             	sub    $0xc,%esp
    2c32:	68 42 57 00 00       	push   $0x5742
    2c37:	e8 77 14 00 00       	call   40b3 <unlink>
    2c3c:	83 c4 10             	add    $0x10,%esp
    2c3f:	85 c0                	test   %eax,%eax
    2c41:	75 17                	jne    2c5a <rmdot+0x11a>
    printf(1, "unlink dots/. worked!\n");
    2c43:	83 ec 08             	sub    $0x8,%esp
    2c46:	68 49 57 00 00       	push   $0x5749
    2c4b:	6a 01                	push   $0x1
    2c4d:	e8 95 15 00 00       	call   41e7 <printf>
    2c52:	83 c4 10             	add    $0x10,%esp
    exit();
    2c55:	e8 09 14 00 00       	call   4063 <exit>
  }
  if(unlink("dots/..") == 0){
    2c5a:	83 ec 0c             	sub    $0xc,%esp
    2c5d:	68 60 57 00 00       	push   $0x5760
    2c62:	e8 4c 14 00 00       	call   40b3 <unlink>
    2c67:	83 c4 10             	add    $0x10,%esp
    2c6a:	85 c0                	test   %eax,%eax
    2c6c:	75 17                	jne    2c85 <rmdot+0x145>
    printf(1, "unlink dots/.. worked!\n");
    2c6e:	83 ec 08             	sub    $0x8,%esp
    2c71:	68 68 57 00 00       	push   $0x5768
    2c76:	6a 01                	push   $0x1
    2c78:	e8 6a 15 00 00       	call   41e7 <printf>
    2c7d:	83 c4 10             	add    $0x10,%esp
    exit();
    2c80:	e8 de 13 00 00       	call   4063 <exit>
  }
  if(unlink("dots") != 0){
    2c85:	83 ec 0c             	sub    $0xc,%esp
    2c88:	68 fa 56 00 00       	push   $0x56fa
    2c8d:	e8 21 14 00 00       	call   40b3 <unlink>
    2c92:	83 c4 10             	add    $0x10,%esp
    2c95:	85 c0                	test   %eax,%eax
    2c97:	74 17                	je     2cb0 <rmdot+0x170>
    printf(1, "unlink dots failed!\n");
    2c99:	83 ec 08             	sub    $0x8,%esp
    2c9c:	68 80 57 00 00       	push   $0x5780
    2ca1:	6a 01                	push   $0x1
    2ca3:	e8 3f 15 00 00       	call   41e7 <printf>
    2ca8:	83 c4 10             	add    $0x10,%esp
    exit();
    2cab:	e8 b3 13 00 00       	call   4063 <exit>
  }
  printf(1, "rmdot ok\n");
    2cb0:	83 ec 08             	sub    $0x8,%esp
    2cb3:	68 95 57 00 00       	push   $0x5795
    2cb8:	6a 01                	push   $0x1
    2cba:	e8 28 15 00 00       	call   41e7 <printf>
    2cbf:	83 c4 10             	add    $0x10,%esp
}
    2cc2:	90                   	nop
    2cc3:	c9                   	leave  
    2cc4:	c3                   	ret    

00002cc5 <dirfile>:

void
dirfile(void)
{
    2cc5:	55                   	push   %ebp
    2cc6:	89 e5                	mov    %esp,%ebp
    2cc8:	83 ec 18             	sub    $0x18,%esp
  int fd;

  printf(1, "dir vs file\n");
    2ccb:	83 ec 08             	sub    $0x8,%esp
    2cce:	68 9f 57 00 00       	push   $0x579f
    2cd3:	6a 01                	push   $0x1
    2cd5:	e8 0d 15 00 00       	call   41e7 <printf>
    2cda:	83 c4 10             	add    $0x10,%esp

  fd = open("dirfile", O_CREATE);
    2cdd:	83 ec 08             	sub    $0x8,%esp
    2ce0:	68 00 02 00 00       	push   $0x200
    2ce5:	68 ac 57 00 00       	push   $0x57ac
    2cea:	e8 b4 13 00 00       	call   40a3 <open>
    2cef:	83 c4 10             	add    $0x10,%esp
    2cf2:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0){
    2cf5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2cf9:	79 17                	jns    2d12 <dirfile+0x4d>
    printf(1, "create dirfile failed\n");
    2cfb:	83 ec 08             	sub    $0x8,%esp
    2cfe:	68 b4 57 00 00       	push   $0x57b4
    2d03:	6a 01                	push   $0x1
    2d05:	e8 dd 14 00 00       	call   41e7 <printf>
    2d0a:	83 c4 10             	add    $0x10,%esp
    exit();
    2d0d:	e8 51 13 00 00       	call   4063 <exit>
  }
  close(fd);
    2d12:	83 ec 0c             	sub    $0xc,%esp
    2d15:	ff 75 f4             	push   -0xc(%ebp)
    2d18:	e8 6e 13 00 00       	call   408b <close>
    2d1d:	83 c4 10             	add    $0x10,%esp
  if(chdir("dirfile") == 0){
    2d20:	83 ec 0c             	sub    $0xc,%esp
    2d23:	68 ac 57 00 00       	push   $0x57ac
    2d28:	e8 a6 13 00 00       	call   40d3 <chdir>
    2d2d:	83 c4 10             	add    $0x10,%esp
    2d30:	85 c0                	test   %eax,%eax
    2d32:	75 17                	jne    2d4b <dirfile+0x86>
    printf(1, "chdir dirfile succeeded!\n");
    2d34:	83 ec 08             	sub    $0x8,%esp
    2d37:	68 cb 57 00 00       	push   $0x57cb
    2d3c:	6a 01                	push   $0x1
    2d3e:	e8 a4 14 00 00       	call   41e7 <printf>
    2d43:	83 c4 10             	add    $0x10,%esp
    exit();
    2d46:	e8 18 13 00 00       	call   4063 <exit>
  }
  fd = open("dirfile/xx", 0);
    2d4b:	83 ec 08             	sub    $0x8,%esp
    2d4e:	6a 00                	push   $0x0
    2d50:	68 e5 57 00 00       	push   $0x57e5
    2d55:	e8 49 13 00 00       	call   40a3 <open>
    2d5a:	83 c4 10             	add    $0x10,%esp
    2d5d:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2d60:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2d64:	78 17                	js     2d7d <dirfile+0xb8>
    printf(1, "create dirfile/xx succeeded!\n");
    2d66:	83 ec 08             	sub    $0x8,%esp
    2d69:	68 f0 57 00 00       	push   $0x57f0
    2d6e:	6a 01                	push   $0x1
    2d70:	e8 72 14 00 00       	call   41e7 <printf>
    2d75:	83 c4 10             	add    $0x10,%esp
    exit();
    2d78:	e8 e6 12 00 00       	call   4063 <exit>
  }
  fd = open("dirfile/xx", O_CREATE);
    2d7d:	83 ec 08             	sub    $0x8,%esp
    2d80:	68 00 02 00 00       	push   $0x200
    2d85:	68 e5 57 00 00       	push   $0x57e5
    2d8a:	e8 14 13 00 00       	call   40a3 <open>
    2d8f:	83 c4 10             	add    $0x10,%esp
    2d92:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2d95:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2d99:	78 17                	js     2db2 <dirfile+0xed>
    printf(1, "create dirfile/xx succeeded!\n");
    2d9b:	83 ec 08             	sub    $0x8,%esp
    2d9e:	68 f0 57 00 00       	push   $0x57f0
    2da3:	6a 01                	push   $0x1
    2da5:	e8 3d 14 00 00       	call   41e7 <printf>
    2daa:	83 c4 10             	add    $0x10,%esp
    exit();
    2dad:	e8 b1 12 00 00       	call   4063 <exit>
  }
  if(mkdir("dirfile/xx") == 0){
    2db2:	83 ec 0c             	sub    $0xc,%esp
    2db5:	68 e5 57 00 00       	push   $0x57e5
    2dba:	e8 0c 13 00 00       	call   40cb <mkdir>
    2dbf:	83 c4 10             	add    $0x10,%esp
    2dc2:	85 c0                	test   %eax,%eax
    2dc4:	75 17                	jne    2ddd <dirfile+0x118>
    printf(1, "mkdir dirfile/xx succeeded!\n");
    2dc6:	83 ec 08             	sub    $0x8,%esp
    2dc9:	68 0e 58 00 00       	push   $0x580e
    2dce:	6a 01                	push   $0x1
    2dd0:	e8 12 14 00 00       	call   41e7 <printf>
    2dd5:	83 c4 10             	add    $0x10,%esp
    exit();
    2dd8:	e8 86 12 00 00       	call   4063 <exit>
  }
  if(unlink("dirfile/xx") == 0){
    2ddd:	83 ec 0c             	sub    $0xc,%esp
    2de0:	68 e5 57 00 00       	push   $0x57e5
    2de5:	e8 c9 12 00 00       	call   40b3 <unlink>
    2dea:	83 c4 10             	add    $0x10,%esp
    2ded:	85 c0                	test   %eax,%eax
    2def:	75 17                	jne    2e08 <dirfile+0x143>
    printf(1, "unlink dirfile/xx succeeded!\n");
    2df1:	83 ec 08             	sub    $0x8,%esp
    2df4:	68 2b 58 00 00       	push   $0x582b
    2df9:	6a 01                	push   $0x1
    2dfb:	e8 e7 13 00 00       	call   41e7 <printf>
    2e00:	83 c4 10             	add    $0x10,%esp
    exit();
    2e03:	e8 5b 12 00 00       	call   4063 <exit>
  }
  if(link("README", "dirfile/xx") == 0){
    2e08:	83 ec 08             	sub    $0x8,%esp
    2e0b:	68 e5 57 00 00       	push   $0x57e5
    2e10:	68 49 58 00 00       	push   $0x5849
    2e15:	e8 a9 12 00 00       	call   40c3 <link>
    2e1a:	83 c4 10             	add    $0x10,%esp
    2e1d:	85 c0                	test   %eax,%eax
    2e1f:	75 17                	jne    2e38 <dirfile+0x173>
    printf(1, "link to dirfile/xx succeeded!\n");
    2e21:	83 ec 08             	sub    $0x8,%esp
    2e24:	68 50 58 00 00       	push   $0x5850
    2e29:	6a 01                	push   $0x1
    2e2b:	e8 b7 13 00 00       	call   41e7 <printf>
    2e30:	83 c4 10             	add    $0x10,%esp
    exit();
    2e33:	e8 2b 12 00 00       	call   4063 <exit>
  }
  if(unlink("dirfile") != 0){
    2e38:	83 ec 0c             	sub    $0xc,%esp
    2e3b:	68 ac 57 00 00       	push   $0x57ac
    2e40:	e8 6e 12 00 00       	call   40b3 <unlink>
    2e45:	83 c4 10             	add    $0x10,%esp
    2e48:	85 c0                	test   %eax,%eax
    2e4a:	74 17                	je     2e63 <dirfile+0x19e>
    printf(1, "unlink dirfile failed!\n");
    2e4c:	83 ec 08             	sub    $0x8,%esp
    2e4f:	68 6f 58 00 00       	push   $0x586f
    2e54:	6a 01                	push   $0x1
    2e56:	e8 8c 13 00 00       	call   41e7 <printf>
    2e5b:	83 c4 10             	add    $0x10,%esp
    exit();
    2e5e:	e8 00 12 00 00       	call   4063 <exit>
  }

  fd = open(".", O_RDWR);
    2e63:	83 ec 08             	sub    $0x8,%esp
    2e66:	6a 02                	push   $0x2
    2e68:	68 2b 4e 00 00       	push   $0x4e2b
    2e6d:	e8 31 12 00 00       	call   40a3 <open>
    2e72:	83 c4 10             	add    $0x10,%esp
    2e75:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd >= 0){
    2e78:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    2e7c:	78 17                	js     2e95 <dirfile+0x1d0>
    printf(1, "open . for writing succeeded!\n");
    2e7e:	83 ec 08             	sub    $0x8,%esp
    2e81:	68 88 58 00 00       	push   $0x5888
    2e86:	6a 01                	push   $0x1
    2e88:	e8 5a 13 00 00       	call   41e7 <printf>
    2e8d:	83 c4 10             	add    $0x10,%esp
    exit();
    2e90:	e8 ce 11 00 00       	call   4063 <exit>
  }
  fd = open(".", 0);
    2e95:	83 ec 08             	sub    $0x8,%esp
    2e98:	6a 00                	push   $0x0
    2e9a:	68 2b 4e 00 00       	push   $0x4e2b
    2e9f:	e8 ff 11 00 00       	call   40a3 <open>
    2ea4:	83 c4 10             	add    $0x10,%esp
    2ea7:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(write(fd, "x", 1) > 0){
    2eaa:	83 ec 04             	sub    $0x4,%esp
    2ead:	6a 01                	push   $0x1
    2eaf:	68 77 4a 00 00       	push   $0x4a77
    2eb4:	ff 75 f4             	push   -0xc(%ebp)
    2eb7:	e8 c7 11 00 00       	call   4083 <write>
    2ebc:	83 c4 10             	add    $0x10,%esp
    2ebf:	85 c0                	test   %eax,%eax
    2ec1:	7e 17                	jle    2eda <dirfile+0x215>
    printf(1, "write . succeeded!\n");
    2ec3:	83 ec 08             	sub    $0x8,%esp
    2ec6:	68 a7 58 00 00       	push   $0x58a7
    2ecb:	6a 01                	push   $0x1
    2ecd:	e8 15 13 00 00       	call   41e7 <printf>
    2ed2:	83 c4 10             	add    $0x10,%esp
    exit();
    2ed5:	e8 89 11 00 00       	call   4063 <exit>
  }
  close(fd);
    2eda:	83 ec 0c             	sub    $0xc,%esp
    2edd:	ff 75 f4             	push   -0xc(%ebp)
    2ee0:	e8 a6 11 00 00       	call   408b <close>
    2ee5:	83 c4 10             	add    $0x10,%esp

  printf(1, "dir vs file OK\n");
    2ee8:	83 ec 08             	sub    $0x8,%esp
    2eeb:	68 bb 58 00 00       	push   $0x58bb
    2ef0:	6a 01                	push   $0x1
    2ef2:	e8 f0 12 00 00       	call   41e7 <printf>
    2ef7:	83 c4 10             	add    $0x10,%esp
}
    2efa:	90                   	nop
    2efb:	c9                   	leave  
    2efc:	c3                   	ret    

00002efd <iref>:

// test that iput() is called at the end of _namei()
void
iref(void)
{
    2efd:	55                   	push   %ebp
    2efe:	89 e5                	mov    %esp,%ebp
    2f00:	83 ec 18             	sub    $0x18,%esp
  int i, fd;

  printf(1, "empty file name\n");
    2f03:	83 ec 08             	sub    $0x8,%esp
    2f06:	68 cb 58 00 00       	push   $0x58cb
    2f0b:	6a 01                	push   $0x1
    2f0d:	e8 d5 12 00 00       	call   41e7 <printf>
    2f12:	83 c4 10             	add    $0x10,%esp

  // the 50 is NINODE
  for(i = 0; i < 50 + 1; i++){
    2f15:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    2f1c:	e9 e7 00 00 00       	jmp    3008 <iref+0x10b>
    if(mkdir("irefd") != 0){
    2f21:	83 ec 0c             	sub    $0xc,%esp
    2f24:	68 dc 58 00 00       	push   $0x58dc
    2f29:	e8 9d 11 00 00       	call   40cb <mkdir>
    2f2e:	83 c4 10             	add    $0x10,%esp
    2f31:	85 c0                	test   %eax,%eax
    2f33:	74 17                	je     2f4c <iref+0x4f>
      printf(1, "mkdir irefd failed\n");
    2f35:	83 ec 08             	sub    $0x8,%esp
    2f38:	68 e2 58 00 00       	push   $0x58e2
    2f3d:	6a 01                	push   $0x1
    2f3f:	e8 a3 12 00 00       	call   41e7 <printf>
    2f44:	83 c4 10             	add    $0x10,%esp
      exit();
    2f47:	e8 17 11 00 00       	call   4063 <exit>
    }
    if(chdir("irefd") != 0){
    2f4c:	83 ec 0c             	sub    $0xc,%esp
    2f4f:	68 dc 58 00 00       	push   $0x58dc
    2f54:	e8 7a 11 00 00       	call   40d3 <chdir>
    2f59:	83 c4 10             	add    $0x10,%esp
    2f5c:	85 c0                	test   %eax,%eax
    2f5e:	74 17                	je     2f77 <iref+0x7a>
      printf(1, "chdir irefd failed\n");
    2f60:	83 ec 08             	sub    $0x8,%esp
    2f63:	68 f6 58 00 00       	push   $0x58f6
    2f68:	6a 01                	push   $0x1
    2f6a:	e8 78 12 00 00       	call   41e7 <printf>
    2f6f:	83 c4 10             	add    $0x10,%esp
      exit();
    2f72:	e8 ec 10 00 00       	call   4063 <exit>
    }

    mkdir("");
    2f77:	83 ec 0c             	sub    $0xc,%esp
    2f7a:	68 0a 59 00 00       	push   $0x590a
    2f7f:	e8 47 11 00 00       	call   40cb <mkdir>
    2f84:	83 c4 10             	add    $0x10,%esp
    link("README", "");
    2f87:	83 ec 08             	sub    $0x8,%esp
    2f8a:	68 0a 59 00 00       	push   $0x590a
    2f8f:	68 49 58 00 00       	push   $0x5849
    2f94:	e8 2a 11 00 00       	call   40c3 <link>
    2f99:	83 c4 10             	add    $0x10,%esp
    fd = open("", O_CREATE);
    2f9c:	83 ec 08             	sub    $0x8,%esp
    2f9f:	68 00 02 00 00       	push   $0x200
    2fa4:	68 0a 59 00 00       	push   $0x590a
    2fa9:	e8 f5 10 00 00       	call   40a3 <open>
    2fae:	83 c4 10             	add    $0x10,%esp
    2fb1:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0)
    2fb4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2fb8:	78 0e                	js     2fc8 <iref+0xcb>
      close(fd);
    2fba:	83 ec 0c             	sub    $0xc,%esp
    2fbd:	ff 75 f0             	push   -0x10(%ebp)
    2fc0:	e8 c6 10 00 00       	call   408b <close>
    2fc5:	83 c4 10             	add    $0x10,%esp
    fd = open("xx", O_CREATE);
    2fc8:	83 ec 08             	sub    $0x8,%esp
    2fcb:	68 00 02 00 00       	push   $0x200
    2fd0:	68 0b 59 00 00       	push   $0x590b
    2fd5:	e8 c9 10 00 00       	call   40a3 <open>
    2fda:	83 c4 10             	add    $0x10,%esp
    2fdd:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(fd >= 0)
    2fe0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    2fe4:	78 0e                	js     2ff4 <iref+0xf7>
      close(fd);
    2fe6:	83 ec 0c             	sub    $0xc,%esp
    2fe9:	ff 75 f0             	push   -0x10(%ebp)
    2fec:	e8 9a 10 00 00       	call   408b <close>
    2ff1:	83 c4 10             	add    $0x10,%esp
    unlink("xx");
    2ff4:	83 ec 0c             	sub    $0xc,%esp
    2ff7:	68 0b 59 00 00       	push   $0x590b
    2ffc:	e8 b2 10 00 00       	call   40b3 <unlink>
    3001:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 50 + 1; i++){
    3004:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3008:	83 7d f4 32          	cmpl   $0x32,-0xc(%ebp)
    300c:	0f 8e 0f ff ff ff    	jle    2f21 <iref+0x24>
  }

  chdir("/");
    3012:	83 ec 0c             	sub    $0xc,%esp
    3015:	68 12 46 00 00       	push   $0x4612
    301a:	e8 b4 10 00 00       	call   40d3 <chdir>
    301f:	83 c4 10             	add    $0x10,%esp
  printf(1, "empty file name OK\n");
    3022:	83 ec 08             	sub    $0x8,%esp
    3025:	68 0e 59 00 00       	push   $0x590e
    302a:	6a 01                	push   $0x1
    302c:	e8 b6 11 00 00       	call   41e7 <printf>
    3031:	83 c4 10             	add    $0x10,%esp
}
    3034:	90                   	nop
    3035:	c9                   	leave  
    3036:	c3                   	ret    

00003037 <forktest>:
// test that fork fails gracefully
// the forktest binary also does this, but it runs out of proc entries first.
// inside the bigger usertests binary, we run out of memory first.
void
forktest(void)
{
    3037:	55                   	push   %ebp
    3038:	89 e5                	mov    %esp,%ebp
    303a:	83 ec 18             	sub    $0x18,%esp
  int n, pid;

  printf(1, "fork test\n");
    303d:	83 ec 08             	sub    $0x8,%esp
    3040:	68 22 59 00 00       	push   $0x5922
    3045:	6a 01                	push   $0x1
    3047:	e8 9b 11 00 00       	call   41e7 <printf>
    304c:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<1000; n++){
    304f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3056:	eb 1d                	jmp    3075 <forktest+0x3e>
    pid = fork();
    3058:	e8 fe 0f 00 00       	call   405b <fork>
    305d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(pid < 0)
    3060:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3064:	78 1a                	js     3080 <forktest+0x49>
      break;
    if(pid == 0)
    3066:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    306a:	75 05                	jne    3071 <forktest+0x3a>
      exit();
    306c:	e8 f2 0f 00 00       	call   4063 <exit>
  for(n=0; n<1000; n++){
    3071:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3075:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
    307c:	7e da                	jle    3058 <forktest+0x21>
    307e:	eb 01                	jmp    3081 <forktest+0x4a>
      break;
    3080:	90                   	nop
  }

  if(n == 1000){
    3081:	81 7d f4 e8 03 00 00 	cmpl   $0x3e8,-0xc(%ebp)
    3088:	75 3b                	jne    30c5 <forktest+0x8e>
    printf(1, "fork claimed to work 1000 times!\n");
    308a:	83 ec 08             	sub    $0x8,%esp
    308d:	68 30 59 00 00       	push   $0x5930
    3092:	6a 01                	push   $0x1
    3094:	e8 4e 11 00 00       	call   41e7 <printf>
    3099:	83 c4 10             	add    $0x10,%esp
    exit();
    309c:	e8 c2 0f 00 00       	call   4063 <exit>
  }

  for(; n > 0; n--){
    if(wait() < 0){
    30a1:	e8 c5 0f 00 00       	call   406b <wait>
    30a6:	85 c0                	test   %eax,%eax
    30a8:	79 17                	jns    30c1 <forktest+0x8a>
      printf(1, "wait stopped early\n");
    30aa:	83 ec 08             	sub    $0x8,%esp
    30ad:	68 52 59 00 00       	push   $0x5952
    30b2:	6a 01                	push   $0x1
    30b4:	e8 2e 11 00 00       	call   41e7 <printf>
    30b9:	83 c4 10             	add    $0x10,%esp
      exit();
    30bc:	e8 a2 0f 00 00       	call   4063 <exit>
  for(; n > 0; n--){
    30c1:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    30c5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    30c9:	7f d6                	jg     30a1 <forktest+0x6a>
    }
  }

  if(wait() != -1){
    30cb:	e8 9b 0f 00 00       	call   406b <wait>
    30d0:	83 f8 ff             	cmp    $0xffffffff,%eax
    30d3:	74 17                	je     30ec <forktest+0xb5>
    printf(1, "wait got too many\n");
    30d5:	83 ec 08             	sub    $0x8,%esp
    30d8:	68 66 59 00 00       	push   $0x5966
    30dd:	6a 01                	push   $0x1
    30df:	e8 03 11 00 00       	call   41e7 <printf>
    30e4:	83 c4 10             	add    $0x10,%esp
    exit();
    30e7:	e8 77 0f 00 00       	call   4063 <exit>
  }

  printf(1, "fork test OK\n");
    30ec:	83 ec 08             	sub    $0x8,%esp
    30ef:	68 79 59 00 00       	push   $0x5979
    30f4:	6a 01                	push   $0x1
    30f6:	e8 ec 10 00 00       	call   41e7 <printf>
    30fb:	83 c4 10             	add    $0x10,%esp
}
    30fe:	90                   	nop
    30ff:	c9                   	leave  
    3100:	c3                   	ret    

00003101 <sbrktest>:

void
sbrktest(void)
{
    3101:	55                   	push   %ebp
    3102:	89 e5                	mov    %esp,%ebp
    3104:	83 ec 68             	sub    $0x68,%esp
  int fds[2], pid, pids[10], ppid;
  char *a, *b, *c, *lastaddr, *oldbrk, *p, scratch;
  uint amt;

  printf(stdout, "sbrk test\n");
    3107:	a1 18 65 00 00       	mov    0x6518,%eax
    310c:	83 ec 08             	sub    $0x8,%esp
    310f:	68 87 59 00 00       	push   $0x5987
    3114:	50                   	push   %eax
    3115:	e8 cd 10 00 00       	call   41e7 <printf>
    311a:	83 c4 10             	add    $0x10,%esp
  oldbrk = sbrk(0);
    311d:	83 ec 0c             	sub    $0xc,%esp
    3120:	6a 00                	push   $0x0
    3122:	e8 c4 0f 00 00       	call   40eb <sbrk>
    3127:	83 c4 10             	add    $0x10,%esp
    312a:	89 45 ec             	mov    %eax,-0x14(%ebp)

  // can one sbrk() less than a page?
  a = sbrk(0);
    312d:	83 ec 0c             	sub    $0xc,%esp
    3130:	6a 00                	push   $0x0
    3132:	e8 b4 0f 00 00       	call   40eb <sbrk>
    3137:	83 c4 10             	add    $0x10,%esp
    313a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int i;
  for(i = 0; i < 5000; i++){
    313d:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3144:	eb 4f                	jmp    3195 <sbrktest+0x94>
    b = sbrk(1);
    3146:	83 ec 0c             	sub    $0xc,%esp
    3149:	6a 01                	push   $0x1
    314b:	e8 9b 0f 00 00       	call   40eb <sbrk>
    3150:	83 c4 10             	add    $0x10,%esp
    3153:	89 45 d0             	mov    %eax,-0x30(%ebp)
    if(b != a){
    3156:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3159:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    315c:	74 24                	je     3182 <sbrktest+0x81>
      printf(stdout, "sbrk test failed %d %x %x\n", i, a, b);
    315e:	a1 18 65 00 00       	mov    0x6518,%eax
    3163:	83 ec 0c             	sub    $0xc,%esp
    3166:	ff 75 d0             	push   -0x30(%ebp)
    3169:	ff 75 f4             	push   -0xc(%ebp)
    316c:	ff 75 f0             	push   -0x10(%ebp)
    316f:	68 92 59 00 00       	push   $0x5992
    3174:	50                   	push   %eax
    3175:	e8 6d 10 00 00       	call   41e7 <printf>
    317a:	83 c4 20             	add    $0x20,%esp
      exit();
    317d:	e8 e1 0e 00 00       	call   4063 <exit>
    }
    *b = 1;
    3182:	8b 45 d0             	mov    -0x30(%ebp),%eax
    3185:	c6 00 01             	movb   $0x1,(%eax)
    a = b + 1;
    3188:	8b 45 d0             	mov    -0x30(%ebp),%eax
    318b:	83 c0 01             	add    $0x1,%eax
    318e:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(i = 0; i < 5000; i++){
    3191:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    3195:	81 7d f0 87 13 00 00 	cmpl   $0x1387,-0x10(%ebp)
    319c:	7e a8                	jle    3146 <sbrktest+0x45>
  }
  pid = fork();
    319e:	e8 b8 0e 00 00       	call   405b <fork>
    31a3:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(pid < 0){
    31a6:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    31aa:	79 1b                	jns    31c7 <sbrktest+0xc6>
    printf(stdout, "sbrk test fork failed\n");
    31ac:	a1 18 65 00 00       	mov    0x6518,%eax
    31b1:	83 ec 08             	sub    $0x8,%esp
    31b4:	68 ad 59 00 00       	push   $0x59ad
    31b9:	50                   	push   %eax
    31ba:	e8 28 10 00 00       	call   41e7 <printf>
    31bf:	83 c4 10             	add    $0x10,%esp
    exit();
    31c2:	e8 9c 0e 00 00       	call   4063 <exit>
  }
  c = sbrk(1);
    31c7:	83 ec 0c             	sub    $0xc,%esp
    31ca:	6a 01                	push   $0x1
    31cc:	e8 1a 0f 00 00       	call   40eb <sbrk>
    31d1:	83 c4 10             	add    $0x10,%esp
    31d4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  c = sbrk(1);
    31d7:	83 ec 0c             	sub    $0xc,%esp
    31da:	6a 01                	push   $0x1
    31dc:	e8 0a 0f 00 00       	call   40eb <sbrk>
    31e1:	83 c4 10             	add    $0x10,%esp
    31e4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c != a + 1){
    31e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
    31ea:	83 c0 01             	add    $0x1,%eax
    31ed:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
    31f0:	74 1b                	je     320d <sbrktest+0x10c>
    printf(stdout, "sbrk test failed post-fork\n");
    31f2:	a1 18 65 00 00       	mov    0x6518,%eax
    31f7:	83 ec 08             	sub    $0x8,%esp
    31fa:	68 c4 59 00 00       	push   $0x59c4
    31ff:	50                   	push   %eax
    3200:	e8 e2 0f 00 00       	call   41e7 <printf>
    3205:	83 c4 10             	add    $0x10,%esp
    exit();
    3208:	e8 56 0e 00 00       	call   4063 <exit>
  }
  if(pid == 0)
    320d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    3211:	75 05                	jne    3218 <sbrktest+0x117>
    exit();
    3213:	e8 4b 0e 00 00       	call   4063 <exit>
  wait();
    3218:	e8 4e 0e 00 00       	call   406b <wait>

  // can one grow address space to something big?
#define BIG (100*1024*1024)
  a = sbrk(0);
    321d:	83 ec 0c             	sub    $0xc,%esp
    3220:	6a 00                	push   $0x0
    3222:	e8 c4 0e 00 00       	call   40eb <sbrk>
    3227:	83 c4 10             	add    $0x10,%esp
    322a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  amt = (BIG) - (uint)a;
    322d:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3230:	b8 00 00 40 06       	mov    $0x6400000,%eax
    3235:	29 d0                	sub    %edx,%eax
    3237:	89 45 e0             	mov    %eax,-0x20(%ebp)
  p = sbrk(amt);
    323a:	8b 45 e0             	mov    -0x20(%ebp),%eax
    323d:	83 ec 0c             	sub    $0xc,%esp
    3240:	50                   	push   %eax
    3241:	e8 a5 0e 00 00       	call   40eb <sbrk>
    3246:	83 c4 10             	add    $0x10,%esp
    3249:	89 45 dc             	mov    %eax,-0x24(%ebp)
  if (p != a) {
    324c:	8b 45 dc             	mov    -0x24(%ebp),%eax
    324f:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    3252:	74 1b                	je     326f <sbrktest+0x16e>
    printf(stdout, "sbrk test failed to grow big address space; enough phys mem?\n");
    3254:	a1 18 65 00 00       	mov    0x6518,%eax
    3259:	83 ec 08             	sub    $0x8,%esp
    325c:	68 e0 59 00 00       	push   $0x59e0
    3261:	50                   	push   %eax
    3262:	e8 80 0f 00 00       	call   41e7 <printf>
    3267:	83 c4 10             	add    $0x10,%esp
    exit();
    326a:	e8 f4 0d 00 00       	call   4063 <exit>
  }
  lastaddr = (char*) (BIG-1);
    326f:	c7 45 d8 ff ff 3f 06 	movl   $0x63fffff,-0x28(%ebp)
  *lastaddr = 99;
    3276:	8b 45 d8             	mov    -0x28(%ebp),%eax
    3279:	c6 00 63             	movb   $0x63,(%eax)

  // can one de-allocate?
  a = sbrk(0);
    327c:	83 ec 0c             	sub    $0xc,%esp
    327f:	6a 00                	push   $0x0
    3281:	e8 65 0e 00 00       	call   40eb <sbrk>
    3286:	83 c4 10             	add    $0x10,%esp
    3289:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(-4096);
    328c:	83 ec 0c             	sub    $0xc,%esp
    328f:	68 00 f0 ff ff       	push   $0xfffff000
    3294:	e8 52 0e 00 00       	call   40eb <sbrk>
    3299:	83 c4 10             	add    $0x10,%esp
    329c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c == (char*)0xffffffff){
    329f:	83 7d e4 ff          	cmpl   $0xffffffff,-0x1c(%ebp)
    32a3:	75 1b                	jne    32c0 <sbrktest+0x1bf>
    printf(stdout, "sbrk could not deallocate\n");
    32a5:	a1 18 65 00 00       	mov    0x6518,%eax
    32aa:	83 ec 08             	sub    $0x8,%esp
    32ad:	68 1e 5a 00 00       	push   $0x5a1e
    32b2:	50                   	push   %eax
    32b3:	e8 2f 0f 00 00       	call   41e7 <printf>
    32b8:	83 c4 10             	add    $0x10,%esp
    exit();
    32bb:	e8 a3 0d 00 00       	call   4063 <exit>
  }
  c = sbrk(0);
    32c0:	83 ec 0c             	sub    $0xc,%esp
    32c3:	6a 00                	push   $0x0
    32c5:	e8 21 0e 00 00       	call   40eb <sbrk>
    32ca:	83 c4 10             	add    $0x10,%esp
    32cd:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c != a - 4096){
    32d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
    32d3:	2d 00 10 00 00       	sub    $0x1000,%eax
    32d8:	39 45 e4             	cmp    %eax,-0x1c(%ebp)
    32db:	74 1e                	je     32fb <sbrktest+0x1fa>
    printf(stdout, "sbrk deallocation produced wrong address, a %x c %x\n", a, c);
    32dd:	a1 18 65 00 00       	mov    0x6518,%eax
    32e2:	ff 75 e4             	push   -0x1c(%ebp)
    32e5:	ff 75 f4             	push   -0xc(%ebp)
    32e8:	68 3c 5a 00 00       	push   $0x5a3c
    32ed:	50                   	push   %eax
    32ee:	e8 f4 0e 00 00       	call   41e7 <printf>
    32f3:	83 c4 10             	add    $0x10,%esp
    exit();
    32f6:	e8 68 0d 00 00       	call   4063 <exit>
  }

  // can one re-allocate that page?
  a = sbrk(0);
    32fb:	83 ec 0c             	sub    $0xc,%esp
    32fe:	6a 00                	push   $0x0
    3300:	e8 e6 0d 00 00       	call   40eb <sbrk>
    3305:	83 c4 10             	add    $0x10,%esp
    3308:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(4096);
    330b:	83 ec 0c             	sub    $0xc,%esp
    330e:	68 00 10 00 00       	push   $0x1000
    3313:	e8 d3 0d 00 00       	call   40eb <sbrk>
    3318:	83 c4 10             	add    $0x10,%esp
    331b:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c != a || sbrk(0) != a + 4096){
    331e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3321:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    3324:	75 1a                	jne    3340 <sbrktest+0x23f>
    3326:	83 ec 0c             	sub    $0xc,%esp
    3329:	6a 00                	push   $0x0
    332b:	e8 bb 0d 00 00       	call   40eb <sbrk>
    3330:	83 c4 10             	add    $0x10,%esp
    3333:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3336:	81 c2 00 10 00 00    	add    $0x1000,%edx
    333c:	39 d0                	cmp    %edx,%eax
    333e:	74 1e                	je     335e <sbrktest+0x25d>
    printf(stdout, "sbrk re-allocation failed, a %x c %x\n", a, c);
    3340:	a1 18 65 00 00       	mov    0x6518,%eax
    3345:	ff 75 e4             	push   -0x1c(%ebp)
    3348:	ff 75 f4             	push   -0xc(%ebp)
    334b:	68 74 5a 00 00       	push   $0x5a74
    3350:	50                   	push   %eax
    3351:	e8 91 0e 00 00       	call   41e7 <printf>
    3356:	83 c4 10             	add    $0x10,%esp
    exit();
    3359:	e8 05 0d 00 00       	call   4063 <exit>
  }
  if(*lastaddr == 99){
    335e:	8b 45 d8             	mov    -0x28(%ebp),%eax
    3361:	0f b6 00             	movzbl (%eax),%eax
    3364:	3c 63                	cmp    $0x63,%al
    3366:	75 1b                	jne    3383 <sbrktest+0x282>
    // should be zero
    printf(stdout, "sbrk de-allocation didn't really deallocate\n");
    3368:	a1 18 65 00 00       	mov    0x6518,%eax
    336d:	83 ec 08             	sub    $0x8,%esp
    3370:	68 9c 5a 00 00       	push   $0x5a9c
    3375:	50                   	push   %eax
    3376:	e8 6c 0e 00 00       	call   41e7 <printf>
    337b:	83 c4 10             	add    $0x10,%esp
    exit();
    337e:	e8 e0 0c 00 00       	call   4063 <exit>
  }

  a = sbrk(0);
    3383:	83 ec 0c             	sub    $0xc,%esp
    3386:	6a 00                	push   $0x0
    3388:	e8 5e 0d 00 00       	call   40eb <sbrk>
    338d:	83 c4 10             	add    $0x10,%esp
    3390:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c = sbrk(-(sbrk(0) - oldbrk));
    3393:	83 ec 0c             	sub    $0xc,%esp
    3396:	6a 00                	push   $0x0
    3398:	e8 4e 0d 00 00       	call   40eb <sbrk>
    339d:	83 c4 10             	add    $0x10,%esp
    33a0:	89 c2                	mov    %eax,%edx
    33a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
    33a5:	29 d0                	sub    %edx,%eax
    33a7:	83 ec 0c             	sub    $0xc,%esp
    33aa:	50                   	push   %eax
    33ab:	e8 3b 0d 00 00       	call   40eb <sbrk>
    33b0:	83 c4 10             	add    $0x10,%esp
    33b3:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(c != a){
    33b6:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    33b9:	3b 45 f4             	cmp    -0xc(%ebp),%eax
    33bc:	74 1e                	je     33dc <sbrktest+0x2db>
    printf(stdout, "sbrk downsize failed, a %x c %x\n", a, c);
    33be:	a1 18 65 00 00       	mov    0x6518,%eax
    33c3:	ff 75 e4             	push   -0x1c(%ebp)
    33c6:	ff 75 f4             	push   -0xc(%ebp)
    33c9:	68 cc 5a 00 00       	push   $0x5acc
    33ce:	50                   	push   %eax
    33cf:	e8 13 0e 00 00       	call   41e7 <printf>
    33d4:	83 c4 10             	add    $0x10,%esp
    exit();
    33d7:	e8 87 0c 00 00       	call   4063 <exit>
  }

  // can we read the kernel's memory?
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    33dc:	c7 45 f4 00 00 00 80 	movl   $0x80000000,-0xc(%ebp)
    33e3:	eb 76                	jmp    345b <sbrktest+0x35a>
    ppid = getpid();
    33e5:	e8 f9 0c 00 00       	call   40e3 <getpid>
    33ea:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    pid = fork();
    33ed:	e8 69 0c 00 00       	call   405b <fork>
    33f2:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pid < 0){
    33f5:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    33f9:	79 1b                	jns    3416 <sbrktest+0x315>
      printf(stdout, "fork failed\n");
    33fb:	a1 18 65 00 00       	mov    0x6518,%eax
    3400:	83 ec 08             	sub    $0x8,%esp
    3403:	68 41 46 00 00       	push   $0x4641
    3408:	50                   	push   %eax
    3409:	e8 d9 0d 00 00       	call   41e7 <printf>
    340e:	83 c4 10             	add    $0x10,%esp
      exit();
    3411:	e8 4d 0c 00 00       	call   4063 <exit>
    }
    if(pid == 0){
    3416:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    341a:	75 33                	jne    344f <sbrktest+0x34e>
      printf(stdout, "oops could read %x = %x\n", a, *a);
    341c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    341f:	0f b6 00             	movzbl (%eax),%eax
    3422:	0f be d0             	movsbl %al,%edx
    3425:	a1 18 65 00 00       	mov    0x6518,%eax
    342a:	52                   	push   %edx
    342b:	ff 75 f4             	push   -0xc(%ebp)
    342e:	68 ed 5a 00 00       	push   $0x5aed
    3433:	50                   	push   %eax
    3434:	e8 ae 0d 00 00       	call   41e7 <printf>
    3439:	83 c4 10             	add    $0x10,%esp
      kill(ppid);
    343c:	83 ec 0c             	sub    $0xc,%esp
    343f:	ff 75 d4             	push   -0x2c(%ebp)
    3442:	e8 4c 0c 00 00       	call   4093 <kill>
    3447:	83 c4 10             	add    $0x10,%esp
      exit();
    344a:	e8 14 0c 00 00       	call   4063 <exit>
    }
    wait();
    344f:	e8 17 0c 00 00       	call   406b <wait>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    3454:	81 45 f4 50 c3 00 00 	addl   $0xc350,-0xc(%ebp)
    345b:	81 7d f4 7f 84 1e 80 	cmpl   $0x801e847f,-0xc(%ebp)
    3462:	76 81                	jbe    33e5 <sbrktest+0x2e4>
  }

  // if we run the system out of memory, does it clean up the last
  // failed allocation?
  if(pipe(fds) != 0){
    3464:	83 ec 0c             	sub    $0xc,%esp
    3467:	8d 45 c8             	lea    -0x38(%ebp),%eax
    346a:	50                   	push   %eax
    346b:	e8 03 0c 00 00       	call   4073 <pipe>
    3470:	83 c4 10             	add    $0x10,%esp
    3473:	85 c0                	test   %eax,%eax
    3475:	74 17                	je     348e <sbrktest+0x38d>
    printf(1, "pipe() failed\n");
    3477:	83 ec 08             	sub    $0x8,%esp
    347a:	68 12 4a 00 00       	push   $0x4a12
    347f:	6a 01                	push   $0x1
    3481:	e8 61 0d 00 00       	call   41e7 <printf>
    3486:	83 c4 10             	add    $0x10,%esp
    exit();
    3489:	e8 d5 0b 00 00       	call   4063 <exit>
  }
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    348e:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3495:	e9 86 00 00 00       	jmp    3520 <sbrktest+0x41f>
    if((pids[i] = fork()) == 0){
    349a:	e8 bc 0b 00 00       	call   405b <fork>
    349f:	8b 55 f0             	mov    -0x10(%ebp),%edx
    34a2:	89 44 95 a0          	mov    %eax,-0x60(%ebp,%edx,4)
    34a6:	8b 45 f0             	mov    -0x10(%ebp),%eax
    34a9:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    34ad:	85 c0                	test   %eax,%eax
    34af:	75 4a                	jne    34fb <sbrktest+0x3fa>
      // allocate a lot of memory
      sbrk(BIG - (uint)sbrk(0));
    34b1:	83 ec 0c             	sub    $0xc,%esp
    34b4:	6a 00                	push   $0x0
    34b6:	e8 30 0c 00 00       	call   40eb <sbrk>
    34bb:	83 c4 10             	add    $0x10,%esp
    34be:	89 c2                	mov    %eax,%edx
    34c0:	b8 00 00 40 06       	mov    $0x6400000,%eax
    34c5:	29 d0                	sub    %edx,%eax
    34c7:	83 ec 0c             	sub    $0xc,%esp
    34ca:	50                   	push   %eax
    34cb:	e8 1b 0c 00 00       	call   40eb <sbrk>
    34d0:	83 c4 10             	add    $0x10,%esp
      write(fds[1], "x", 1);
    34d3:	8b 45 cc             	mov    -0x34(%ebp),%eax
    34d6:	83 ec 04             	sub    $0x4,%esp
    34d9:	6a 01                	push   $0x1
    34db:	68 77 4a 00 00       	push   $0x4a77
    34e0:	50                   	push   %eax
    34e1:	e8 9d 0b 00 00       	call   4083 <write>
    34e6:	83 c4 10             	add    $0x10,%esp
      // sit around until killed
      for(;;) sleep(1000);
    34e9:	83 ec 0c             	sub    $0xc,%esp
    34ec:	68 e8 03 00 00       	push   $0x3e8
    34f1:	e8 fd 0b 00 00       	call   40f3 <sleep>
    34f6:	83 c4 10             	add    $0x10,%esp
    34f9:	eb ee                	jmp    34e9 <sbrktest+0x3e8>
    }
    if(pids[i] != -1)
    34fb:	8b 45 f0             	mov    -0x10(%ebp),%eax
    34fe:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    3502:	83 f8 ff             	cmp    $0xffffffff,%eax
    3505:	74 15                	je     351c <sbrktest+0x41b>
      read(fds[0], &scratch, 1);
    3507:	8b 45 c8             	mov    -0x38(%ebp),%eax
    350a:	83 ec 04             	sub    $0x4,%esp
    350d:	6a 01                	push   $0x1
    350f:	8d 55 9f             	lea    -0x61(%ebp),%edx
    3512:	52                   	push   %edx
    3513:	50                   	push   %eax
    3514:	e8 62 0b 00 00       	call   407b <read>
    3519:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    351c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    3520:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3523:	83 f8 09             	cmp    $0x9,%eax
    3526:	0f 86 6e ff ff ff    	jbe    349a <sbrktest+0x399>
  }
  // if those failed allocations freed up the pages they did allocate,
  // we'll be able to allocate here
  c = sbrk(4096);
    352c:	83 ec 0c             	sub    $0xc,%esp
    352f:	68 00 10 00 00       	push   $0x1000
    3534:	e8 b2 0b 00 00       	call   40eb <sbrk>
    3539:	83 c4 10             	add    $0x10,%esp
    353c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    353f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    3546:	eb 2b                	jmp    3573 <sbrktest+0x472>
    if(pids[i] == -1)
    3548:	8b 45 f0             	mov    -0x10(%ebp),%eax
    354b:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    354f:	83 f8 ff             	cmp    $0xffffffff,%eax
    3552:	74 1a                	je     356e <sbrktest+0x46d>
      continue;
    kill(pids[i]);
    3554:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3557:	8b 44 85 a0          	mov    -0x60(%ebp,%eax,4),%eax
    355b:	83 ec 0c             	sub    $0xc,%esp
    355e:	50                   	push   %eax
    355f:	e8 2f 0b 00 00       	call   4093 <kill>
    3564:	83 c4 10             	add    $0x10,%esp
    wait();
    3567:	e8 ff 0a 00 00       	call   406b <wait>
    356c:	eb 01                	jmp    356f <sbrktest+0x46e>
      continue;
    356e:	90                   	nop
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    356f:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    3573:	8b 45 f0             	mov    -0x10(%ebp),%eax
    3576:	83 f8 09             	cmp    $0x9,%eax
    3579:	76 cd                	jbe    3548 <sbrktest+0x447>
  }
  if(c == (char*)0xffffffff){
    357b:	83 7d e4 ff          	cmpl   $0xffffffff,-0x1c(%ebp)
    357f:	75 1b                	jne    359c <sbrktest+0x49b>
    printf(stdout, "failed sbrk leaked memory\n");
    3581:	a1 18 65 00 00       	mov    0x6518,%eax
    3586:	83 ec 08             	sub    $0x8,%esp
    3589:	68 06 5b 00 00       	push   $0x5b06
    358e:	50                   	push   %eax
    358f:	e8 53 0c 00 00       	call   41e7 <printf>
    3594:	83 c4 10             	add    $0x10,%esp
    exit();
    3597:	e8 c7 0a 00 00       	call   4063 <exit>
  }

  if(sbrk(0) > oldbrk)
    359c:	83 ec 0c             	sub    $0xc,%esp
    359f:	6a 00                	push   $0x0
    35a1:	e8 45 0b 00 00       	call   40eb <sbrk>
    35a6:	83 c4 10             	add    $0x10,%esp
    35a9:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    35ac:	73 20                	jae    35ce <sbrktest+0x4cd>
    sbrk(-(sbrk(0) - oldbrk));
    35ae:	83 ec 0c             	sub    $0xc,%esp
    35b1:	6a 00                	push   $0x0
    35b3:	e8 33 0b 00 00       	call   40eb <sbrk>
    35b8:	83 c4 10             	add    $0x10,%esp
    35bb:	89 c2                	mov    %eax,%edx
    35bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
    35c0:	29 d0                	sub    %edx,%eax
    35c2:	83 ec 0c             	sub    $0xc,%esp
    35c5:	50                   	push   %eax
    35c6:	e8 20 0b 00 00       	call   40eb <sbrk>
    35cb:	83 c4 10             	add    $0x10,%esp

  printf(stdout, "sbrk test OK\n");
    35ce:	a1 18 65 00 00       	mov    0x6518,%eax
    35d3:	83 ec 08             	sub    $0x8,%esp
    35d6:	68 21 5b 00 00       	push   $0x5b21
    35db:	50                   	push   %eax
    35dc:	e8 06 0c 00 00       	call   41e7 <printf>
    35e1:	83 c4 10             	add    $0x10,%esp
}
    35e4:	90                   	nop
    35e5:	c9                   	leave  
    35e6:	c3                   	ret    

000035e7 <validateint>:

void
validateint(int *p)
{
    35e7:	55                   	push   %ebp
    35e8:	89 e5                	mov    %esp,%ebp
    35ea:	53                   	push   %ebx
    35eb:	83 ec 10             	sub    $0x10,%esp
  int res;
  asm("mov %%esp, %%ebx\n\t"
    35ee:	b8 0d 00 00 00       	mov    $0xd,%eax
    35f3:	8b 55 08             	mov    0x8(%ebp),%edx
    35f6:	89 d1                	mov    %edx,%ecx
    35f8:	89 e3                	mov    %esp,%ebx
    35fa:	89 cc                	mov    %ecx,%esp
    35fc:	cd 40                	int    $0x40
    35fe:	89 dc                	mov    %ebx,%esp
    3600:	89 45 f8             	mov    %eax,-0x8(%ebp)
      "int %2\n\t"
      "mov %%ebx, %%esp" :
      "=a" (res) :
      "a" (SYS_sleep), "n" (T_SYSCALL), "c" (p) :
      "ebx");
}
    3603:	90                   	nop
    3604:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3607:	c9                   	leave  
    3608:	c3                   	ret    

00003609 <validatetest>:

void
validatetest(void)
{
    3609:	55                   	push   %ebp
    360a:	89 e5                	mov    %esp,%ebp
    360c:	83 ec 18             	sub    $0x18,%esp
  int hi, pid;
  uint p;

  printf(stdout, "validate test\n");
    360f:	a1 18 65 00 00       	mov    0x6518,%eax
    3614:	83 ec 08             	sub    $0x8,%esp
    3617:	68 2f 5b 00 00       	push   $0x5b2f
    361c:	50                   	push   %eax
    361d:	e8 c5 0b 00 00       	call   41e7 <printf>
    3622:	83 c4 10             	add    $0x10,%esp
  hi = 1100*1024;
    3625:	c7 45 f0 00 30 11 00 	movl   $0x113000,-0x10(%ebp)

  for(p = 0; p <= (uint)hi; p += 4096){
    362c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3633:	e9 8a 00 00 00       	jmp    36c2 <validatetest+0xb9>
    if((pid = fork()) == 0){
    3638:	e8 1e 0a 00 00       	call   405b <fork>
    363d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    3640:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3644:	75 14                	jne    365a <validatetest+0x51>
      // try to crash the kernel by passing in a badly placed integer
      validateint((int*)p);
    3646:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3649:	83 ec 0c             	sub    $0xc,%esp
    364c:	50                   	push   %eax
    364d:	e8 95 ff ff ff       	call   35e7 <validateint>
    3652:	83 c4 10             	add    $0x10,%esp
      exit();
    3655:	e8 09 0a 00 00       	call   4063 <exit>
    }
    sleep(0);
    365a:	83 ec 0c             	sub    $0xc,%esp
    365d:	6a 00                	push   $0x0
    365f:	e8 8f 0a 00 00       	call   40f3 <sleep>
    3664:	83 c4 10             	add    $0x10,%esp
    sleep(0);
    3667:	83 ec 0c             	sub    $0xc,%esp
    366a:	6a 00                	push   $0x0
    366c:	e8 82 0a 00 00       	call   40f3 <sleep>
    3671:	83 c4 10             	add    $0x10,%esp
    kill(pid);
    3674:	83 ec 0c             	sub    $0xc,%esp
    3677:	ff 75 ec             	push   -0x14(%ebp)
    367a:	e8 14 0a 00 00       	call   4093 <kill>
    367f:	83 c4 10             	add    $0x10,%esp
    wait();
    3682:	e8 e4 09 00 00       	call   406b <wait>

    // try to crash the kernel by passing in a bad string pointer
    if(link("nosuchfile", (char*)p) != -1){
    3687:	8b 45 f4             	mov    -0xc(%ebp),%eax
    368a:	83 ec 08             	sub    $0x8,%esp
    368d:	50                   	push   %eax
    368e:	68 3e 5b 00 00       	push   $0x5b3e
    3693:	e8 2b 0a 00 00       	call   40c3 <link>
    3698:	83 c4 10             	add    $0x10,%esp
    369b:	83 f8 ff             	cmp    $0xffffffff,%eax
    369e:	74 1b                	je     36bb <validatetest+0xb2>
      printf(stdout, "link should not succeed\n");
    36a0:	a1 18 65 00 00       	mov    0x6518,%eax
    36a5:	83 ec 08             	sub    $0x8,%esp
    36a8:	68 49 5b 00 00       	push   $0x5b49
    36ad:	50                   	push   %eax
    36ae:	e8 34 0b 00 00       	call   41e7 <printf>
    36b3:	83 c4 10             	add    $0x10,%esp
      exit();
    36b6:	e8 a8 09 00 00       	call   4063 <exit>
  for(p = 0; p <= (uint)hi; p += 4096){
    36bb:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    36c2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    36c5:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    36c8:	0f 86 6a ff ff ff    	jbe    3638 <validatetest+0x2f>
    }
  }

  printf(stdout, "validate ok\n");
    36ce:	a1 18 65 00 00       	mov    0x6518,%eax
    36d3:	83 ec 08             	sub    $0x8,%esp
    36d6:	68 62 5b 00 00       	push   $0x5b62
    36db:	50                   	push   %eax
    36dc:	e8 06 0b 00 00       	call   41e7 <printf>
    36e1:	83 c4 10             	add    $0x10,%esp
}
    36e4:	90                   	nop
    36e5:	c9                   	leave  
    36e6:	c3                   	ret    

000036e7 <bsstest>:

// does unintialized data start out zero?
char uninit[10000];
void
bsstest(void)
{
    36e7:	55                   	push   %ebp
    36e8:	89 e5                	mov    %esp,%ebp
    36ea:	83 ec 18             	sub    $0x18,%esp
  int i;

  printf(stdout, "bss test\n");
    36ed:	a1 18 65 00 00       	mov    0x6518,%eax
    36f2:	83 ec 08             	sub    $0x8,%esp
    36f5:	68 6f 5b 00 00       	push   $0x5b6f
    36fa:	50                   	push   %eax
    36fb:	e8 e7 0a 00 00       	call   41e7 <printf>
    3700:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < sizeof(uninit); i++){
    3703:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    370a:	eb 2e                	jmp    373a <bsstest+0x53>
    if(uninit[i] != '\0'){
    370c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    370f:	05 60 85 00 00       	add    $0x8560,%eax
    3714:	0f b6 00             	movzbl (%eax),%eax
    3717:	84 c0                	test   %al,%al
    3719:	74 1b                	je     3736 <bsstest+0x4f>
      printf(stdout, "bss test failed\n");
    371b:	a1 18 65 00 00       	mov    0x6518,%eax
    3720:	83 ec 08             	sub    $0x8,%esp
    3723:	68 79 5b 00 00       	push   $0x5b79
    3728:	50                   	push   %eax
    3729:	e8 b9 0a 00 00       	call   41e7 <printf>
    372e:	83 c4 10             	add    $0x10,%esp
      exit();
    3731:	e8 2d 09 00 00       	call   4063 <exit>
  for(i = 0; i < sizeof(uninit); i++){
    3736:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    373a:	8b 45 f4             	mov    -0xc(%ebp),%eax
    373d:	3d 0f 27 00 00       	cmp    $0x270f,%eax
    3742:	76 c8                	jbe    370c <bsstest+0x25>
    }
  }
  printf(stdout, "bss test ok\n");
    3744:	a1 18 65 00 00       	mov    0x6518,%eax
    3749:	83 ec 08             	sub    $0x8,%esp
    374c:	68 8a 5b 00 00       	push   $0x5b8a
    3751:	50                   	push   %eax
    3752:	e8 90 0a 00 00       	call   41e7 <printf>
    3757:	83 c4 10             	add    $0x10,%esp
}
    375a:	90                   	nop
    375b:	c9                   	leave  
    375c:	c3                   	ret    

0000375d <bigargtest>:
// does exec return an error if the arguments
// are larger than a page? or does it write
// below the stack and wreck the instructions/data?
void
bigargtest(void)
{
    375d:	55                   	push   %ebp
    375e:	89 e5                	mov    %esp,%ebp
    3760:	83 ec 18             	sub    $0x18,%esp
  int pid, fd;

  unlink("bigarg-ok");
    3763:	83 ec 0c             	sub    $0xc,%esp
    3766:	68 97 5b 00 00       	push   $0x5b97
    376b:	e8 43 09 00 00       	call   40b3 <unlink>
    3770:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    3773:	e8 e3 08 00 00       	call   405b <fork>
    3778:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid == 0){
    377b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    377f:	0f 85 97 00 00 00    	jne    381c <bigargtest+0xbf>
    static char *args[MAXARG];
    int i;
    for(i = 0; i < MAXARG-1; i++)
    3785:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    378c:	eb 12                	jmp    37a0 <bigargtest+0x43>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    378e:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3791:	c7 04 85 80 ac 00 00 	movl   $0x5ba4,0xac80(,%eax,4)
    3798:	a4 5b 00 00 
    for(i = 0; i < MAXARG-1; i++)
    379c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    37a0:	83 7d f4 1e          	cmpl   $0x1e,-0xc(%ebp)
    37a4:	7e e8                	jle    378e <bigargtest+0x31>
    args[MAXARG-1] = 0;
    37a6:	c7 05 fc ac 00 00 00 	movl   $0x0,0xacfc
    37ad:	00 00 00 
    printf(stdout, "bigarg test\n");
    37b0:	a1 18 65 00 00       	mov    0x6518,%eax
    37b5:	83 ec 08             	sub    $0x8,%esp
    37b8:	68 81 5c 00 00       	push   $0x5c81
    37bd:	50                   	push   %eax
    37be:	e8 24 0a 00 00       	call   41e7 <printf>
    37c3:	83 c4 10             	add    $0x10,%esp
    exec("echo", args);
    37c6:	83 ec 08             	sub    $0x8,%esp
    37c9:	68 80 ac 00 00       	push   $0xac80
    37ce:	68 a0 45 00 00       	push   $0x45a0
    37d3:	e8 c3 08 00 00       	call   409b <exec>
    37d8:	83 c4 10             	add    $0x10,%esp
    printf(stdout, "bigarg test ok\n");
    37db:	a1 18 65 00 00       	mov    0x6518,%eax
    37e0:	83 ec 08             	sub    $0x8,%esp
    37e3:	68 8e 5c 00 00       	push   $0x5c8e
    37e8:	50                   	push   %eax
    37e9:	e8 f9 09 00 00       	call   41e7 <printf>
    37ee:	83 c4 10             	add    $0x10,%esp
    fd = open("bigarg-ok", O_CREATE);
    37f1:	83 ec 08             	sub    $0x8,%esp
    37f4:	68 00 02 00 00       	push   $0x200
    37f9:	68 97 5b 00 00       	push   $0x5b97
    37fe:	e8 a0 08 00 00       	call   40a3 <open>
    3803:	83 c4 10             	add    $0x10,%esp
    3806:	89 45 ec             	mov    %eax,-0x14(%ebp)
    close(fd);
    3809:	83 ec 0c             	sub    $0xc,%esp
    380c:	ff 75 ec             	push   -0x14(%ebp)
    380f:	e8 77 08 00 00       	call   408b <close>
    3814:	83 c4 10             	add    $0x10,%esp
    exit();
    3817:	e8 47 08 00 00       	call   4063 <exit>
  } else if(pid < 0){
    381c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3820:	79 1b                	jns    383d <bigargtest+0xe0>
    printf(stdout, "bigargtest: fork failed\n");
    3822:	a1 18 65 00 00       	mov    0x6518,%eax
    3827:	83 ec 08             	sub    $0x8,%esp
    382a:	68 9e 5c 00 00       	push   $0x5c9e
    382f:	50                   	push   %eax
    3830:	e8 b2 09 00 00       	call   41e7 <printf>
    3835:	83 c4 10             	add    $0x10,%esp
    exit();
    3838:	e8 26 08 00 00       	call   4063 <exit>
  }
  wait();
    383d:	e8 29 08 00 00       	call   406b <wait>
  fd = open("bigarg-ok", 0);
    3842:	83 ec 08             	sub    $0x8,%esp
    3845:	6a 00                	push   $0x0
    3847:	68 97 5b 00 00       	push   $0x5b97
    384c:	e8 52 08 00 00       	call   40a3 <open>
    3851:	83 c4 10             	add    $0x10,%esp
    3854:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(fd < 0){
    3857:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    385b:	79 1b                	jns    3878 <bigargtest+0x11b>
    printf(stdout, "bigarg test failed!\n");
    385d:	a1 18 65 00 00       	mov    0x6518,%eax
    3862:	83 ec 08             	sub    $0x8,%esp
    3865:	68 b7 5c 00 00       	push   $0x5cb7
    386a:	50                   	push   %eax
    386b:	e8 77 09 00 00       	call   41e7 <printf>
    3870:	83 c4 10             	add    $0x10,%esp
    exit();
    3873:	e8 eb 07 00 00       	call   4063 <exit>
  }
  close(fd);
    3878:	83 ec 0c             	sub    $0xc,%esp
    387b:	ff 75 ec             	push   -0x14(%ebp)
    387e:	e8 08 08 00 00       	call   408b <close>
    3883:	83 c4 10             	add    $0x10,%esp
  unlink("bigarg-ok");
    3886:	83 ec 0c             	sub    $0xc,%esp
    3889:	68 97 5b 00 00       	push   $0x5b97
    388e:	e8 20 08 00 00       	call   40b3 <unlink>
    3893:	83 c4 10             	add    $0x10,%esp
}
    3896:	90                   	nop
    3897:	c9                   	leave  
    3898:	c3                   	ret    

00003899 <fsfull>:

// what happens when the file system runs out of blocks?
// answer: balloc panics, so this test is not useful.
void
fsfull()
{
    3899:	55                   	push   %ebp
    389a:	89 e5                	mov    %esp,%ebp
    389c:	53                   	push   %ebx
    389d:	83 ec 64             	sub    $0x64,%esp
  int nfiles;
  int fsblocks = 0;
    38a0:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)

  printf(1, "fsfull test\n");
    38a7:	83 ec 08             	sub    $0x8,%esp
    38aa:	68 cc 5c 00 00       	push   $0x5ccc
    38af:	6a 01                	push   $0x1
    38b1:	e8 31 09 00 00       	call   41e7 <printf>
    38b6:	83 c4 10             	add    $0x10,%esp

  for(nfiles = 0; ; nfiles++){
    38b9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    char name[64];
    name[0] = 'f';
    38c0:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    name[1] = '0' + nfiles / 1000;
    38c4:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    38c7:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    38cc:	89 c8                	mov    %ecx,%eax
    38ce:	f7 ea                	imul   %edx
    38d0:	89 d0                	mov    %edx,%eax
    38d2:	c1 f8 06             	sar    $0x6,%eax
    38d5:	c1 f9 1f             	sar    $0x1f,%ecx
    38d8:	89 ca                	mov    %ecx,%edx
    38da:	29 d0                	sub    %edx,%eax
    38dc:	83 c0 30             	add    $0x30,%eax
    38df:	88 45 a5             	mov    %al,-0x5b(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    38e2:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    38e5:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    38ea:	89 d8                	mov    %ebx,%eax
    38ec:	f7 ea                	imul   %edx
    38ee:	89 d0                	mov    %edx,%eax
    38f0:	c1 f8 06             	sar    $0x6,%eax
    38f3:	89 da                	mov    %ebx,%edx
    38f5:	c1 fa 1f             	sar    $0x1f,%edx
    38f8:	29 d0                	sub    %edx,%eax
    38fa:	89 c1                	mov    %eax,%ecx
    38fc:	69 c1 e8 03 00 00    	imul   $0x3e8,%ecx,%eax
    3902:	29 c3                	sub    %eax,%ebx
    3904:	89 d9                	mov    %ebx,%ecx
    3906:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    390b:	89 c8                	mov    %ecx,%eax
    390d:	f7 ea                	imul   %edx
    390f:	89 d0                	mov    %edx,%eax
    3911:	c1 f8 05             	sar    $0x5,%eax
    3914:	c1 f9 1f             	sar    $0x1f,%ecx
    3917:	89 ca                	mov    %ecx,%edx
    3919:	29 d0                	sub    %edx,%eax
    391b:	83 c0 30             	add    $0x30,%eax
    391e:	88 45 a6             	mov    %al,-0x5a(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3921:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3924:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3929:	89 d8                	mov    %ebx,%eax
    392b:	f7 ea                	imul   %edx
    392d:	89 d0                	mov    %edx,%eax
    392f:	c1 f8 05             	sar    $0x5,%eax
    3932:	89 da                	mov    %ebx,%edx
    3934:	c1 fa 1f             	sar    $0x1f,%edx
    3937:	29 d0                	sub    %edx,%eax
    3939:	89 c1                	mov    %eax,%ecx
    393b:	6b c1 64             	imul   $0x64,%ecx,%eax
    393e:	29 c3                	sub    %eax,%ebx
    3940:	89 d9                	mov    %ebx,%ecx
    3942:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3947:	89 c8                	mov    %ecx,%eax
    3949:	f7 ea                	imul   %edx
    394b:	89 d0                	mov    %edx,%eax
    394d:	c1 f8 02             	sar    $0x2,%eax
    3950:	c1 f9 1f             	sar    $0x1f,%ecx
    3953:	89 ca                	mov    %ecx,%edx
    3955:	29 d0                	sub    %edx,%eax
    3957:	83 c0 30             	add    $0x30,%eax
    395a:	88 45 a7             	mov    %al,-0x59(%ebp)
    name[4] = '0' + (nfiles % 10);
    395d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3960:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3965:	89 c8                	mov    %ecx,%eax
    3967:	f7 ea                	imul   %edx
    3969:	89 d0                	mov    %edx,%eax
    396b:	c1 f8 02             	sar    $0x2,%eax
    396e:	89 cb                	mov    %ecx,%ebx
    3970:	c1 fb 1f             	sar    $0x1f,%ebx
    3973:	29 d8                	sub    %ebx,%eax
    3975:	89 c2                	mov    %eax,%edx
    3977:	89 d0                	mov    %edx,%eax
    3979:	c1 e0 02             	shl    $0x2,%eax
    397c:	01 d0                	add    %edx,%eax
    397e:	01 c0                	add    %eax,%eax
    3980:	29 c1                	sub    %eax,%ecx
    3982:	89 ca                	mov    %ecx,%edx
    3984:	89 d0                	mov    %edx,%eax
    3986:	83 c0 30             	add    $0x30,%eax
    3989:	88 45 a8             	mov    %al,-0x58(%ebp)
    name[5] = '\0';
    398c:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    printf(1, "writing %s\n", name);
    3990:	83 ec 04             	sub    $0x4,%esp
    3993:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3996:	50                   	push   %eax
    3997:	68 d9 5c 00 00       	push   $0x5cd9
    399c:	6a 01                	push   $0x1
    399e:	e8 44 08 00 00       	call   41e7 <printf>
    39a3:	83 c4 10             	add    $0x10,%esp
    int fd = open(name, O_CREATE|O_RDWR);
    39a6:	83 ec 08             	sub    $0x8,%esp
    39a9:	68 02 02 00 00       	push   $0x202
    39ae:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    39b1:	50                   	push   %eax
    39b2:	e8 ec 06 00 00       	call   40a3 <open>
    39b7:	83 c4 10             	add    $0x10,%esp
    39ba:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(fd < 0){
    39bd:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
    39c1:	79 18                	jns    39db <fsfull+0x142>
      printf(1, "open %s failed\n", name);
    39c3:	83 ec 04             	sub    $0x4,%esp
    39c6:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    39c9:	50                   	push   %eax
    39ca:	68 e5 5c 00 00       	push   $0x5ce5
    39cf:	6a 01                	push   $0x1
    39d1:	e8 11 08 00 00       	call   41e7 <printf>
    39d6:	83 c4 10             	add    $0x10,%esp
      break;
    39d9:	eb 6b                	jmp    3a46 <fsfull+0x1ad>
    }
    int total = 0;
    39db:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
    while(1){
      int cc = write(fd, buf, 512);
    39e2:	83 ec 04             	sub    $0x4,%esp
    39e5:	68 00 02 00 00       	push   $0x200
    39ea:	68 40 65 00 00       	push   $0x6540
    39ef:	ff 75 e8             	push   -0x18(%ebp)
    39f2:	e8 8c 06 00 00       	call   4083 <write>
    39f7:	83 c4 10             	add    $0x10,%esp
    39fa:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      if(cc < 512)
    39fd:	81 7d e4 ff 01 00 00 	cmpl   $0x1ff,-0x1c(%ebp)
    3a04:	7e 0c                	jle    3a12 <fsfull+0x179>
        break;
      total += cc;
    3a06:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    3a09:	01 45 ec             	add    %eax,-0x14(%ebp)
      fsblocks++;
    3a0c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    while(1){
    3a10:	eb d0                	jmp    39e2 <fsfull+0x149>
        break;
    3a12:	90                   	nop
    }
    printf(1, "wrote %d bytes\n", total);
    3a13:	83 ec 04             	sub    $0x4,%esp
    3a16:	ff 75 ec             	push   -0x14(%ebp)
    3a19:	68 f5 5c 00 00       	push   $0x5cf5
    3a1e:	6a 01                	push   $0x1
    3a20:	e8 c2 07 00 00       	call   41e7 <printf>
    3a25:	83 c4 10             	add    $0x10,%esp
    close(fd);
    3a28:	83 ec 0c             	sub    $0xc,%esp
    3a2b:	ff 75 e8             	push   -0x18(%ebp)
    3a2e:	e8 58 06 00 00       	call   408b <close>
    3a33:	83 c4 10             	add    $0x10,%esp
    if(total == 0)
    3a36:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    3a3a:	74 09                	je     3a45 <fsfull+0x1ac>
  for(nfiles = 0; ; nfiles++){
    3a3c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    3a40:	e9 7b fe ff ff       	jmp    38c0 <fsfull+0x27>
      break;
    3a45:	90                   	nop
  }

  while(nfiles >= 0){
    3a46:	e9 e3 00 00 00       	jmp    3b2e <fsfull+0x295>
    char name[64];
    name[0] = 'f';
    3a4b:	c6 45 a4 66          	movb   $0x66,-0x5c(%ebp)
    name[1] = '0' + nfiles / 1000;
    3a4f:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3a52:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    3a57:	89 c8                	mov    %ecx,%eax
    3a59:	f7 ea                	imul   %edx
    3a5b:	89 d0                	mov    %edx,%eax
    3a5d:	c1 f8 06             	sar    $0x6,%eax
    3a60:	c1 f9 1f             	sar    $0x1f,%ecx
    3a63:	89 ca                	mov    %ecx,%edx
    3a65:	29 d0                	sub    %edx,%eax
    3a67:	83 c0 30             	add    $0x30,%eax
    3a6a:	88 45 a5             	mov    %al,-0x5b(%ebp)
    name[2] = '0' + (nfiles % 1000) / 100;
    3a6d:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3a70:	ba d3 4d 62 10       	mov    $0x10624dd3,%edx
    3a75:	89 d8                	mov    %ebx,%eax
    3a77:	f7 ea                	imul   %edx
    3a79:	89 d0                	mov    %edx,%eax
    3a7b:	c1 f8 06             	sar    $0x6,%eax
    3a7e:	89 da                	mov    %ebx,%edx
    3a80:	c1 fa 1f             	sar    $0x1f,%edx
    3a83:	29 d0                	sub    %edx,%eax
    3a85:	89 c1                	mov    %eax,%ecx
    3a87:	69 c1 e8 03 00 00    	imul   $0x3e8,%ecx,%eax
    3a8d:	29 c3                	sub    %eax,%ebx
    3a8f:	89 d9                	mov    %ebx,%ecx
    3a91:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3a96:	89 c8                	mov    %ecx,%eax
    3a98:	f7 ea                	imul   %edx
    3a9a:	89 d0                	mov    %edx,%eax
    3a9c:	c1 f8 05             	sar    $0x5,%eax
    3a9f:	c1 f9 1f             	sar    $0x1f,%ecx
    3aa2:	89 ca                	mov    %ecx,%edx
    3aa4:	29 d0                	sub    %edx,%eax
    3aa6:	83 c0 30             	add    $0x30,%eax
    3aa9:	88 45 a6             	mov    %al,-0x5a(%ebp)
    name[3] = '0' + (nfiles % 100) / 10;
    3aac:	8b 5d f4             	mov    -0xc(%ebp),%ebx
    3aaf:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
    3ab4:	89 d8                	mov    %ebx,%eax
    3ab6:	f7 ea                	imul   %edx
    3ab8:	89 d0                	mov    %edx,%eax
    3aba:	c1 f8 05             	sar    $0x5,%eax
    3abd:	89 da                	mov    %ebx,%edx
    3abf:	c1 fa 1f             	sar    $0x1f,%edx
    3ac2:	29 d0                	sub    %edx,%eax
    3ac4:	89 c1                	mov    %eax,%ecx
    3ac6:	6b c1 64             	imul   $0x64,%ecx,%eax
    3ac9:	29 c3                	sub    %eax,%ebx
    3acb:	89 d9                	mov    %ebx,%ecx
    3acd:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3ad2:	89 c8                	mov    %ecx,%eax
    3ad4:	f7 ea                	imul   %edx
    3ad6:	89 d0                	mov    %edx,%eax
    3ad8:	c1 f8 02             	sar    $0x2,%eax
    3adb:	c1 f9 1f             	sar    $0x1f,%ecx
    3ade:	89 ca                	mov    %ecx,%edx
    3ae0:	29 d0                	sub    %edx,%eax
    3ae2:	83 c0 30             	add    $0x30,%eax
    3ae5:	88 45 a7             	mov    %al,-0x59(%ebp)
    name[4] = '0' + (nfiles % 10);
    3ae8:	8b 4d f4             	mov    -0xc(%ebp),%ecx
    3aeb:	ba 67 66 66 66       	mov    $0x66666667,%edx
    3af0:	89 c8                	mov    %ecx,%eax
    3af2:	f7 ea                	imul   %edx
    3af4:	89 d0                	mov    %edx,%eax
    3af6:	c1 f8 02             	sar    $0x2,%eax
    3af9:	89 cb                	mov    %ecx,%ebx
    3afb:	c1 fb 1f             	sar    $0x1f,%ebx
    3afe:	29 d8                	sub    %ebx,%eax
    3b00:	89 c2                	mov    %eax,%edx
    3b02:	89 d0                	mov    %edx,%eax
    3b04:	c1 e0 02             	shl    $0x2,%eax
    3b07:	01 d0                	add    %edx,%eax
    3b09:	01 c0                	add    %eax,%eax
    3b0b:	29 c1                	sub    %eax,%ecx
    3b0d:	89 ca                	mov    %ecx,%edx
    3b0f:	89 d0                	mov    %edx,%eax
    3b11:	83 c0 30             	add    $0x30,%eax
    3b14:	88 45 a8             	mov    %al,-0x58(%ebp)
    name[5] = '\0';
    3b17:	c6 45 a9 00          	movb   $0x0,-0x57(%ebp)
    unlink(name);
    3b1b:	83 ec 0c             	sub    $0xc,%esp
    3b1e:	8d 45 a4             	lea    -0x5c(%ebp),%eax
    3b21:	50                   	push   %eax
    3b22:	e8 8c 05 00 00       	call   40b3 <unlink>
    3b27:	83 c4 10             	add    $0x10,%esp
    nfiles--;
    3b2a:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
  while(nfiles >= 0){
    3b2e:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3b32:	0f 89 13 ff ff ff    	jns    3a4b <fsfull+0x1b2>
  }

  printf(1, "fsfull test finished\n");
    3b38:	83 ec 08             	sub    $0x8,%esp
    3b3b:	68 05 5d 00 00       	push   $0x5d05
    3b40:	6a 01                	push   $0x1
    3b42:	e8 a0 06 00 00       	call   41e7 <printf>
    3b47:	83 c4 10             	add    $0x10,%esp
}
    3b4a:	90                   	nop
    3b4b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
    3b4e:	c9                   	leave  
    3b4f:	c3                   	ret    

00003b50 <uio>:

void
uio()
{
    3b50:	55                   	push   %ebp
    3b51:	89 e5                	mov    %esp,%ebp
    3b53:	83 ec 18             	sub    $0x18,%esp
  #define RTC_ADDR 0x70
  #define RTC_DATA 0x71

  ushort port = 0;
    3b56:	66 c7 45 f6 00 00    	movw   $0x0,-0xa(%ebp)
  uchar val = 0;
    3b5c:	c6 45 f5 00          	movb   $0x0,-0xb(%ebp)
  int pid;

  printf(1, "uio test\n");
    3b60:	83 ec 08             	sub    $0x8,%esp
    3b63:	68 1b 5d 00 00       	push   $0x5d1b
    3b68:	6a 01                	push   $0x1
    3b6a:	e8 78 06 00 00       	call   41e7 <printf>
    3b6f:	83 c4 10             	add    $0x10,%esp
  pid = fork();
    3b72:	e8 e4 04 00 00       	call   405b <fork>
    3b77:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(pid == 0){
    3b7a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3b7e:	75 3a                	jne    3bba <uio+0x6a>
    port = RTC_ADDR;
    3b80:	66 c7 45 f6 70 00    	movw   $0x70,-0xa(%ebp)
    val = 0x09;  /* year */
    3b86:	c6 45 f5 09          	movb   $0x9,-0xb(%ebp)
    /* http://wiki.osdev.org/Inline_Assembly/Examples */
    asm volatile("outb %0,%1"::"a"(val), "d" (port));
    3b8a:	0f b6 45 f5          	movzbl -0xb(%ebp),%eax
    3b8e:	0f b7 55 f6          	movzwl -0xa(%ebp),%edx
    3b92:	ee                   	out    %al,(%dx)
    port = RTC_DATA;
    3b93:	66 c7 45 f6 71 00    	movw   $0x71,-0xa(%ebp)
    asm volatile("inb %1,%0" : "=a" (val) : "d" (port));
    3b99:	0f b7 45 f6          	movzwl -0xa(%ebp),%eax
    3b9d:	89 c2                	mov    %eax,%edx
    3b9f:	ec                   	in     (%dx),%al
    3ba0:	88 45 f5             	mov    %al,-0xb(%ebp)
    printf(1, "uio: uio succeeded; test FAILED\n");
    3ba3:	83 ec 08             	sub    $0x8,%esp
    3ba6:	68 28 5d 00 00       	push   $0x5d28
    3bab:	6a 01                	push   $0x1
    3bad:	e8 35 06 00 00       	call   41e7 <printf>
    3bb2:	83 c4 10             	add    $0x10,%esp
    exit();
    3bb5:	e8 a9 04 00 00       	call   4063 <exit>
  } else if(pid < 0){
    3bba:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3bbe:	79 17                	jns    3bd7 <uio+0x87>
    printf (1, "fork failed\n");
    3bc0:	83 ec 08             	sub    $0x8,%esp
    3bc3:	68 41 46 00 00       	push   $0x4641
    3bc8:	6a 01                	push   $0x1
    3bca:	e8 18 06 00 00       	call   41e7 <printf>
    3bcf:	83 c4 10             	add    $0x10,%esp
    exit();
    3bd2:	e8 8c 04 00 00       	call   4063 <exit>
  }
  wait();
    3bd7:	e8 8f 04 00 00       	call   406b <wait>
  printf(1, "uio test done\n");
    3bdc:	83 ec 08             	sub    $0x8,%esp
    3bdf:	68 49 5d 00 00       	push   $0x5d49
    3be4:	6a 01                	push   $0x1
    3be6:	e8 fc 05 00 00       	call   41e7 <printf>
    3beb:	83 c4 10             	add    $0x10,%esp
}
    3bee:	90                   	nop
    3bef:	c9                   	leave  
    3bf0:	c3                   	ret    

00003bf1 <argptest>:

void argptest()
{
    3bf1:	55                   	push   %ebp
    3bf2:	89 e5                	mov    %esp,%ebp
    3bf4:	83 ec 18             	sub    $0x18,%esp
  int fd;
  fd = open("init", O_RDONLY);
    3bf7:	83 ec 08             	sub    $0x8,%esp
    3bfa:	6a 00                	push   $0x0
    3bfc:	68 58 5d 00 00       	push   $0x5d58
    3c01:	e8 9d 04 00 00       	call   40a3 <open>
    3c06:	83 c4 10             	add    $0x10,%esp
    3c09:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if (fd < 0) {
    3c0c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3c10:	79 17                	jns    3c29 <argptest+0x38>
    printf(2, "open failed\n");
    3c12:	83 ec 08             	sub    $0x8,%esp
    3c15:	68 5d 5d 00 00       	push   $0x5d5d
    3c1a:	6a 02                	push   $0x2
    3c1c:	e8 c6 05 00 00       	call   41e7 <printf>
    3c21:	83 c4 10             	add    $0x10,%esp
    exit();
    3c24:	e8 3a 04 00 00       	call   4063 <exit>
  }
  read(fd, sbrk(0) - 1, -1);
    3c29:	83 ec 0c             	sub    $0xc,%esp
    3c2c:	6a 00                	push   $0x0
    3c2e:	e8 b8 04 00 00       	call   40eb <sbrk>
    3c33:	83 c4 10             	add    $0x10,%esp
    3c36:	83 e8 01             	sub    $0x1,%eax
    3c39:	83 ec 04             	sub    $0x4,%esp
    3c3c:	6a ff                	push   $0xffffffff
    3c3e:	50                   	push   %eax
    3c3f:	ff 75 f4             	push   -0xc(%ebp)
    3c42:	e8 34 04 00 00       	call   407b <read>
    3c47:	83 c4 10             	add    $0x10,%esp
  close(fd);
    3c4a:	83 ec 0c             	sub    $0xc,%esp
    3c4d:	ff 75 f4             	push   -0xc(%ebp)
    3c50:	e8 36 04 00 00       	call   408b <close>
    3c55:	83 c4 10             	add    $0x10,%esp
  printf(1, "arg test passed\n");
    3c58:	83 ec 08             	sub    $0x8,%esp
    3c5b:	68 6a 5d 00 00       	push   $0x5d6a
    3c60:	6a 01                	push   $0x1
    3c62:	e8 80 05 00 00       	call   41e7 <printf>
    3c67:	83 c4 10             	add    $0x10,%esp
}
    3c6a:	90                   	nop
    3c6b:	c9                   	leave  
    3c6c:	c3                   	ret    

00003c6d <rand>:

unsigned long randstate = 1;
unsigned int
rand()
{
    3c6d:	55                   	push   %ebp
    3c6e:	89 e5                	mov    %esp,%ebp
  randstate = randstate * 1664525 + 1013904223;
    3c70:	a1 1c 65 00 00       	mov    0x651c,%eax
    3c75:	69 c0 0d 66 19 00    	imul   $0x19660d,%eax,%eax
    3c7b:	05 5f f3 6e 3c       	add    $0x3c6ef35f,%eax
    3c80:	a3 1c 65 00 00       	mov    %eax,0x651c
  return randstate;
    3c85:	a1 1c 65 00 00       	mov    0x651c,%eax
}
    3c8a:	5d                   	pop    %ebp
    3c8b:	c3                   	ret    

00003c8c <main>:

int
main(int argc, char *argv[])
{
    3c8c:	8d 4c 24 04          	lea    0x4(%esp),%ecx
    3c90:	83 e4 f0             	and    $0xfffffff0,%esp
    3c93:	ff 71 fc             	push   -0x4(%ecx)
    3c96:	55                   	push   %ebp
    3c97:	89 e5                	mov    %esp,%ebp
    3c99:	51                   	push   %ecx
    3c9a:	83 ec 04             	sub    $0x4,%esp
  printf(1, "usertests starting\n");
    3c9d:	83 ec 08             	sub    $0x8,%esp
    3ca0:	68 7b 5d 00 00       	push   $0x5d7b
    3ca5:	6a 01                	push   $0x1
    3ca7:	e8 3b 05 00 00       	call   41e7 <printf>
    3cac:	83 c4 10             	add    $0x10,%esp

  if(open("usertests.ran", 0) >= 0){
    3caf:	83 ec 08             	sub    $0x8,%esp
    3cb2:	6a 00                	push   $0x0
    3cb4:	68 8f 5d 00 00       	push   $0x5d8f
    3cb9:	e8 e5 03 00 00       	call   40a3 <open>
    3cbe:	83 c4 10             	add    $0x10,%esp
    3cc1:	85 c0                	test   %eax,%eax
    3cc3:	78 17                	js     3cdc <main+0x50>
    printf(1, "already ran user tests -- rebuild fs.img\n");
    3cc5:	83 ec 08             	sub    $0x8,%esp
    3cc8:	68 a0 5d 00 00       	push   $0x5da0
    3ccd:	6a 01                	push   $0x1
    3ccf:	e8 13 05 00 00       	call   41e7 <printf>
    3cd4:	83 c4 10             	add    $0x10,%esp
    exit();
    3cd7:	e8 87 03 00 00       	call   4063 <exit>
  }
  close(open("usertests.ran", O_CREATE));
    3cdc:	83 ec 08             	sub    $0x8,%esp
    3cdf:	68 00 02 00 00       	push   $0x200
    3ce4:	68 8f 5d 00 00       	push   $0x5d8f
    3ce9:	e8 b5 03 00 00       	call   40a3 <open>
    3cee:	83 c4 10             	add    $0x10,%esp
    3cf1:	83 ec 0c             	sub    $0xc,%esp
    3cf4:	50                   	push   %eax
    3cf5:	e8 91 03 00 00       	call   408b <close>
    3cfa:	83 c4 10             	add    $0x10,%esp

  argptest();
    3cfd:	e8 ef fe ff ff       	call   3bf1 <argptest>
  createdelete();
    3d02:	e8 a3 d5 ff ff       	call   12aa <createdelete>
  linkunlink();
    3d07:	e8 ce df ff ff       	call   1cda <linkunlink>
  concreate();
    3d0c:	e8 0f dc ff ff       	call   1920 <concreate>
  fourfiles();
    3d11:	e8 43 d3 ff ff       	call   1059 <fourfiles>
  sharedfd();
    3d16:	e8 5b d1 ff ff       	call   e76 <sharedfd>

  bigargtest();
    3d1b:	e8 3d fa ff ff       	call   375d <bigargtest>
  bigwrite();
    3d20:	e8 a9 e9 ff ff       	call   26ce <bigwrite>
  bigargtest();
    3d25:	e8 33 fa ff ff       	call   375d <bigargtest>
  bsstest();
    3d2a:	e8 b8 f9 ff ff       	call   36e7 <bsstest>
  sbrktest();
    3d2f:	e8 cd f3 ff ff       	call   3101 <sbrktest>
  validatetest();
    3d34:	e8 d0 f8 ff ff       	call   3609 <validatetest>

  opentest();
    3d39:	e8 c1 c5 ff ff       	call   2ff <opentest>
  writetest();
    3d3e:	e8 6b c6 ff ff       	call   3ae <writetest>
  writetest1();
    3d43:	e8 76 c8 ff ff       	call   5be <writetest1>
  createtest();
    3d48:	e8 6d ca ff ff       	call   7ba <createtest>

  openiputtest();
    3d4d:	e8 9e c4 ff ff       	call   1f0 <openiputtest>
  exitiputtest();
    3d52:	e8 9a c3 ff ff       	call   f1 <exitiputtest>
  iputtest();
    3d57:	e8 a4 c2 ff ff       	call   0 <iputtest>

  mem();
    3d5c:	e8 24 d0 ff ff       	call   d85 <mem>
  pipe1();
    3d61:	e8 5b cc ff ff       	call   9c1 <pipe1>
  preempt();
    3d66:	e8 3f ce ff ff       	call   baa <preempt>
  exitwait();
    3d6b:	e8 9d cf ff ff       	call   d0d <exitwait>

  rmdot();
    3d70:	e8 cb ed ff ff       	call   2b40 <rmdot>
  fourteen();
    3d75:	e8 6a ec ff ff       	call   29e4 <fourteen>
  bigfile();
    3d7a:	e8 4d ea ff ff       	call   27cc <bigfile>
  subdir();
    3d7f:	e8 06 e2 ff ff       	call   1f8a <subdir>
  linktest();
    3d84:	e8 55 d9 ff ff       	call   16de <linktest>
  unlinkread();
    3d89:	e8 8e d7 ff ff       	call   151c <unlinkread>
  dirfile();
    3d8e:	e8 32 ef ff ff       	call   2cc5 <dirfile>
  iref();
    3d93:	e8 65 f1 ff ff       	call   2efd <iref>
  forktest();
    3d98:	e8 9a f2 ff ff       	call   3037 <forktest>
  bigdir(); // slow
    3d9d:	e8 73 e0 ff ff       	call   1e15 <bigdir>

  uio();
    3da2:	e8 a9 fd ff ff       	call   3b50 <uio>

  exectest();
    3da7:	e8 c2 cb ff ff       	call   96e <exectest>

  exit();
    3dac:	e8 b2 02 00 00       	call   4063 <exit>

00003db1 <stosb>:
               "cc");
}

static inline void
stosb(void *addr, int data, int cnt)
{
    3db1:	55                   	push   %ebp
    3db2:	89 e5                	mov    %esp,%ebp
    3db4:	57                   	push   %edi
    3db5:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
    3db6:	8b 4d 08             	mov    0x8(%ebp),%ecx
    3db9:	8b 55 10             	mov    0x10(%ebp),%edx
    3dbc:	8b 45 0c             	mov    0xc(%ebp),%eax
    3dbf:	89 cb                	mov    %ecx,%ebx
    3dc1:	89 df                	mov    %ebx,%edi
    3dc3:	89 d1                	mov    %edx,%ecx
    3dc5:	fc                   	cld    
    3dc6:	f3 aa                	rep stos %al,%es:(%edi)
    3dc8:	89 ca                	mov    %ecx,%edx
    3dca:	89 fb                	mov    %edi,%ebx
    3dcc:	89 5d 08             	mov    %ebx,0x8(%ebp)
    3dcf:	89 55 10             	mov    %edx,0x10(%ebp)
               "=D" (addr), "=c" (cnt) :
               "0" (addr), "1" (cnt), "a" (data) :
               "memory", "cc");
}
    3dd2:	90                   	nop
    3dd3:	5b                   	pop    %ebx
    3dd4:	5f                   	pop    %edi
    3dd5:	5d                   	pop    %ebp
    3dd6:	c3                   	ret    

00003dd7 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
    3dd7:	55                   	push   %ebp
    3dd8:	89 e5                	mov    %esp,%ebp
    3dda:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
    3ddd:	8b 45 08             	mov    0x8(%ebp),%eax
    3de0:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while((*s++ = *t++) != 0)
    3de3:	90                   	nop
    3de4:	8b 55 0c             	mov    0xc(%ebp),%edx
    3de7:	8d 42 01             	lea    0x1(%edx),%eax
    3dea:	89 45 0c             	mov    %eax,0xc(%ebp)
    3ded:	8b 45 08             	mov    0x8(%ebp),%eax
    3df0:	8d 48 01             	lea    0x1(%eax),%ecx
    3df3:	89 4d 08             	mov    %ecx,0x8(%ebp)
    3df6:	0f b6 12             	movzbl (%edx),%edx
    3df9:	88 10                	mov    %dl,(%eax)
    3dfb:	0f b6 00             	movzbl (%eax),%eax
    3dfe:	84 c0                	test   %al,%al
    3e00:	75 e2                	jne    3de4 <strcpy+0xd>
    ;
  return os;
    3e02:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3e05:	c9                   	leave  
    3e06:	c3                   	ret    

00003e07 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    3e07:	55                   	push   %ebp
    3e08:	89 e5                	mov    %esp,%ebp
  while(*p && *p == *q)
    3e0a:	eb 08                	jmp    3e14 <strcmp+0xd>
    p++, q++;
    3e0c:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3e10:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(*p && *p == *q)
    3e14:	8b 45 08             	mov    0x8(%ebp),%eax
    3e17:	0f b6 00             	movzbl (%eax),%eax
    3e1a:	84 c0                	test   %al,%al
    3e1c:	74 10                	je     3e2e <strcmp+0x27>
    3e1e:	8b 45 08             	mov    0x8(%ebp),%eax
    3e21:	0f b6 10             	movzbl (%eax),%edx
    3e24:	8b 45 0c             	mov    0xc(%ebp),%eax
    3e27:	0f b6 00             	movzbl (%eax),%eax
    3e2a:	38 c2                	cmp    %al,%dl
    3e2c:	74 de                	je     3e0c <strcmp+0x5>
  return (uchar)*p - (uchar)*q;
    3e2e:	8b 45 08             	mov    0x8(%ebp),%eax
    3e31:	0f b6 00             	movzbl (%eax),%eax
    3e34:	0f b6 d0             	movzbl %al,%edx
    3e37:	8b 45 0c             	mov    0xc(%ebp),%eax
    3e3a:	0f b6 00             	movzbl (%eax),%eax
    3e3d:	0f b6 c8             	movzbl %al,%ecx
    3e40:	89 d0                	mov    %edx,%eax
    3e42:	29 c8                	sub    %ecx,%eax
}
    3e44:	5d                   	pop    %ebp
    3e45:	c3                   	ret    

00003e46 <strlen>:

uint
strlen(const char *s)
{
    3e46:	55                   	push   %ebp
    3e47:	89 e5                	mov    %esp,%ebp
    3e49:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
    3e4c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    3e53:	eb 04                	jmp    3e59 <strlen+0x13>
    3e55:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
    3e59:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3e5c:	8b 45 08             	mov    0x8(%ebp),%eax
    3e5f:	01 d0                	add    %edx,%eax
    3e61:	0f b6 00             	movzbl (%eax),%eax
    3e64:	84 c0                	test   %al,%al
    3e66:	75 ed                	jne    3e55 <strlen+0xf>
    ;
  return n;
    3e68:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3e6b:	c9                   	leave  
    3e6c:	c3                   	ret    

00003e6d <memset>:

void*
memset(void *dst, int c, uint n)
{
    3e6d:	55                   	push   %ebp
    3e6e:	89 e5                	mov    %esp,%ebp
  stosb(dst, c, n);
    3e70:	8b 45 10             	mov    0x10(%ebp),%eax
    3e73:	50                   	push   %eax
    3e74:	ff 75 0c             	push   0xc(%ebp)
    3e77:	ff 75 08             	push   0x8(%ebp)
    3e7a:	e8 32 ff ff ff       	call   3db1 <stosb>
    3e7f:	83 c4 0c             	add    $0xc,%esp
  return dst;
    3e82:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3e85:	c9                   	leave  
    3e86:	c3                   	ret    

00003e87 <strchr>:

char*
strchr(const char *s, char c)
{
    3e87:	55                   	push   %ebp
    3e88:	89 e5                	mov    %esp,%ebp
    3e8a:	83 ec 04             	sub    $0x4,%esp
    3e8d:	8b 45 0c             	mov    0xc(%ebp),%eax
    3e90:	88 45 fc             	mov    %al,-0x4(%ebp)
  for(; *s; s++)
    3e93:	eb 14                	jmp    3ea9 <strchr+0x22>
    if(*s == c)
    3e95:	8b 45 08             	mov    0x8(%ebp),%eax
    3e98:	0f b6 00             	movzbl (%eax),%eax
    3e9b:	38 45 fc             	cmp    %al,-0x4(%ebp)
    3e9e:	75 05                	jne    3ea5 <strchr+0x1e>
      return (char*)s;
    3ea0:	8b 45 08             	mov    0x8(%ebp),%eax
    3ea3:	eb 13                	jmp    3eb8 <strchr+0x31>
  for(; *s; s++)
    3ea5:	83 45 08 01          	addl   $0x1,0x8(%ebp)
    3ea9:	8b 45 08             	mov    0x8(%ebp),%eax
    3eac:	0f b6 00             	movzbl (%eax),%eax
    3eaf:	84 c0                	test   %al,%al
    3eb1:	75 e2                	jne    3e95 <strchr+0xe>
  return 0;
    3eb3:	b8 00 00 00 00       	mov    $0x0,%eax
}
    3eb8:	c9                   	leave  
    3eb9:	c3                   	ret    

00003eba <gets>:

char*
gets(char *buf, int max)
{
    3eba:	55                   	push   %ebp
    3ebb:	89 e5                	mov    %esp,%ebp
    3ebd:	83 ec 18             	sub    $0x18,%esp
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    3ec0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    3ec7:	eb 42                	jmp    3f0b <gets+0x51>
    cc = read(0, &c, 1);
    3ec9:	83 ec 04             	sub    $0x4,%esp
    3ecc:	6a 01                	push   $0x1
    3ece:	8d 45 ef             	lea    -0x11(%ebp),%eax
    3ed1:	50                   	push   %eax
    3ed2:	6a 00                	push   $0x0
    3ed4:	e8 a2 01 00 00       	call   407b <read>
    3ed9:	83 c4 10             	add    $0x10,%esp
    3edc:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(cc < 1)
    3edf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    3ee3:	7e 33                	jle    3f18 <gets+0x5e>
      break;
    buf[i++] = c;
    3ee5:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3ee8:	8d 50 01             	lea    0x1(%eax),%edx
    3eeb:	89 55 f4             	mov    %edx,-0xc(%ebp)
    3eee:	89 c2                	mov    %eax,%edx
    3ef0:	8b 45 08             	mov    0x8(%ebp),%eax
    3ef3:	01 c2                	add    %eax,%edx
    3ef5:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3ef9:	88 02                	mov    %al,(%edx)
    if(c == '\n' || c == '\r')
    3efb:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3eff:	3c 0a                	cmp    $0xa,%al
    3f01:	74 16                	je     3f19 <gets+0x5f>
    3f03:	0f b6 45 ef          	movzbl -0x11(%ebp),%eax
    3f07:	3c 0d                	cmp    $0xd,%al
    3f09:	74 0e                	je     3f19 <gets+0x5f>
  for(i=0; i+1 < max; ){
    3f0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    3f0e:	83 c0 01             	add    $0x1,%eax
    3f11:	39 45 0c             	cmp    %eax,0xc(%ebp)
    3f14:	7f b3                	jg     3ec9 <gets+0xf>
    3f16:	eb 01                	jmp    3f19 <gets+0x5f>
      break;
    3f18:	90                   	nop
      break;
  }
  buf[i] = '\0';
    3f19:	8b 55 f4             	mov    -0xc(%ebp),%edx
    3f1c:	8b 45 08             	mov    0x8(%ebp),%eax
    3f1f:	01 d0                	add    %edx,%eax
    3f21:	c6 00 00             	movb   $0x0,(%eax)
  return buf;
    3f24:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3f27:	c9                   	leave  
    3f28:	c3                   	ret    

00003f29 <stat>:

int
stat(const char *n, struct stat *st)
{
    3f29:	55                   	push   %ebp
    3f2a:	89 e5                	mov    %esp,%ebp
    3f2c:	83 ec 18             	sub    $0x18,%esp
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    3f2f:	83 ec 08             	sub    $0x8,%esp
    3f32:	6a 00                	push   $0x0
    3f34:	ff 75 08             	push   0x8(%ebp)
    3f37:	e8 67 01 00 00       	call   40a3 <open>
    3f3c:	83 c4 10             	add    $0x10,%esp
    3f3f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(fd < 0)
    3f42:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    3f46:	79 07                	jns    3f4f <stat+0x26>
    return -1;
    3f48:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
    3f4d:	eb 25                	jmp    3f74 <stat+0x4b>
  r = fstat(fd, st);
    3f4f:	83 ec 08             	sub    $0x8,%esp
    3f52:	ff 75 0c             	push   0xc(%ebp)
    3f55:	ff 75 f4             	push   -0xc(%ebp)
    3f58:	e8 5e 01 00 00       	call   40bb <fstat>
    3f5d:	83 c4 10             	add    $0x10,%esp
    3f60:	89 45 f0             	mov    %eax,-0x10(%ebp)
  close(fd);
    3f63:	83 ec 0c             	sub    $0xc,%esp
    3f66:	ff 75 f4             	push   -0xc(%ebp)
    3f69:	e8 1d 01 00 00       	call   408b <close>
    3f6e:	83 c4 10             	add    $0x10,%esp
  return r;
    3f71:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
    3f74:	c9                   	leave  
    3f75:	c3                   	ret    

00003f76 <atoi>:

int
atoi(const char *s)
{
    3f76:	55                   	push   %ebp
    3f77:	89 e5                	mov    %esp,%ebp
    3f79:	83 ec 10             	sub    $0x10,%esp
  int n;

  n = 0;
    3f7c:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    3f83:	eb 25                	jmp    3faa <atoi+0x34>
    n = n*10 + *s++ - '0';
    3f85:	8b 55 fc             	mov    -0x4(%ebp),%edx
    3f88:	89 d0                	mov    %edx,%eax
    3f8a:	c1 e0 02             	shl    $0x2,%eax
    3f8d:	01 d0                	add    %edx,%eax
    3f8f:	01 c0                	add    %eax,%eax
    3f91:	89 c1                	mov    %eax,%ecx
    3f93:	8b 45 08             	mov    0x8(%ebp),%eax
    3f96:	8d 50 01             	lea    0x1(%eax),%edx
    3f99:	89 55 08             	mov    %edx,0x8(%ebp)
    3f9c:	0f b6 00             	movzbl (%eax),%eax
    3f9f:	0f be c0             	movsbl %al,%eax
    3fa2:	01 c8                	add    %ecx,%eax
    3fa4:	83 e8 30             	sub    $0x30,%eax
    3fa7:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while('0' <= *s && *s <= '9')
    3faa:	8b 45 08             	mov    0x8(%ebp),%eax
    3fad:	0f b6 00             	movzbl (%eax),%eax
    3fb0:	3c 2f                	cmp    $0x2f,%al
    3fb2:	7e 0a                	jle    3fbe <atoi+0x48>
    3fb4:	8b 45 08             	mov    0x8(%ebp),%eax
    3fb7:	0f b6 00             	movzbl (%eax),%eax
    3fba:	3c 39                	cmp    $0x39,%al
    3fbc:	7e c7                	jle    3f85 <atoi+0xf>
  return n;
    3fbe:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
    3fc1:	c9                   	leave  
    3fc2:	c3                   	ret    

00003fc3 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    3fc3:	55                   	push   %ebp
    3fc4:	89 e5                	mov    %esp,%ebp
    3fc6:	83 ec 10             	sub    $0x10,%esp
  char *dst;
  const char *src;

  dst = vdst;
    3fc9:	8b 45 08             	mov    0x8(%ebp),%eax
    3fcc:	89 45 fc             	mov    %eax,-0x4(%ebp)
  src = vsrc;
    3fcf:	8b 45 0c             	mov    0xc(%ebp),%eax
    3fd2:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0)
    3fd5:	eb 17                	jmp    3fee <memmove+0x2b>
    *dst++ = *src++;
    3fd7:	8b 55 f8             	mov    -0x8(%ebp),%edx
    3fda:	8d 42 01             	lea    0x1(%edx),%eax
    3fdd:	89 45 f8             	mov    %eax,-0x8(%ebp)
    3fe0:	8b 45 fc             	mov    -0x4(%ebp),%eax
    3fe3:	8d 48 01             	lea    0x1(%eax),%ecx
    3fe6:	89 4d fc             	mov    %ecx,-0x4(%ebp)
    3fe9:	0f b6 12             	movzbl (%edx),%edx
    3fec:	88 10                	mov    %dl,(%eax)
  while(n-- > 0)
    3fee:	8b 45 10             	mov    0x10(%ebp),%eax
    3ff1:	8d 50 ff             	lea    -0x1(%eax),%edx
    3ff4:	89 55 10             	mov    %edx,0x10(%ebp)
    3ff7:	85 c0                	test   %eax,%eax
    3ff9:	7f dc                	jg     3fd7 <memmove+0x14>
  return vdst;
    3ffb:	8b 45 08             	mov    0x8(%ebp),%eax
}
    3ffe:	c9                   	leave  
    3fff:	c3                   	ret    

00004000 <calc>:

int calc(int num)
{
    4000:	55                   	push   %ebp
    4001:	89 e5                	mov    %esp,%ebp
    4003:	83 ec 10             	sub    $0x10,%esp
    int c = 0;
    4006:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
    for(uint i = 0; i < num; i++)
    400d:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
    4014:	eb 36                	jmp    404c <calc+0x4c>
    {
        for(uint j = 0; j < num; j++)
    4016:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    401d:	eb 21                	jmp    4040 <calc+0x40>
        {
            for(uint k = 0; k < num; j++)
    401f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    4026:	eb 0c                	jmp    4034 <calc+0x34>
            {
                c >>= 10;
    4028:	c1 7d fc 0a          	sarl   $0xa,-0x4(%ebp)
                c <<= 10;
    402c:	c1 65 fc 0a          	shll   $0xa,-0x4(%ebp)
            for(uint k = 0; k < num; j++)
    4030:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    4034:	8b 45 08             	mov    0x8(%ebp),%eax
    4037:	39 45 f0             	cmp    %eax,-0x10(%ebp)
    403a:	72 ec                	jb     4028 <calc+0x28>
        for(uint j = 0; j < num; j++)
    403c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    4040:	8b 45 08             	mov    0x8(%ebp),%eax
    4043:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    4046:	72 d7                	jb     401f <calc+0x1f>
    for(uint i = 0; i < num; i++)
    4048:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
    404c:	8b 45 08             	mov    0x8(%ebp),%eax
    404f:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    4052:	72 c2                	jb     4016 <calc+0x16>
            }
        }
    }
    return 0;
    4054:	b8 00 00 00 00       	mov    $0x0,%eax
}
    4059:	c9                   	leave  
    405a:	c3                   	ret    

0000405b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    405b:	b8 01 00 00 00       	mov    $0x1,%eax
    4060:	cd 40                	int    $0x40
    4062:	c3                   	ret    

00004063 <exit>:
SYSCALL(exit)
    4063:	b8 02 00 00 00       	mov    $0x2,%eax
    4068:	cd 40                	int    $0x40
    406a:	c3                   	ret    

0000406b <wait>:
SYSCALL(wait)
    406b:	b8 03 00 00 00       	mov    $0x3,%eax
    4070:	cd 40                	int    $0x40
    4072:	c3                   	ret    

00004073 <pipe>:
SYSCALL(pipe)
    4073:	b8 04 00 00 00       	mov    $0x4,%eax
    4078:	cd 40                	int    $0x40
    407a:	c3                   	ret    

0000407b <read>:
SYSCALL(read)
    407b:	b8 05 00 00 00       	mov    $0x5,%eax
    4080:	cd 40                	int    $0x40
    4082:	c3                   	ret    

00004083 <write>:
SYSCALL(write)
    4083:	b8 10 00 00 00       	mov    $0x10,%eax
    4088:	cd 40                	int    $0x40
    408a:	c3                   	ret    

0000408b <close>:
SYSCALL(close)
    408b:	b8 15 00 00 00       	mov    $0x15,%eax
    4090:	cd 40                	int    $0x40
    4092:	c3                   	ret    

00004093 <kill>:
SYSCALL(kill)
    4093:	b8 06 00 00 00       	mov    $0x6,%eax
    4098:	cd 40                	int    $0x40
    409a:	c3                   	ret    

0000409b <exec>:
SYSCALL(exec)
    409b:	b8 07 00 00 00       	mov    $0x7,%eax
    40a0:	cd 40                	int    $0x40
    40a2:	c3                   	ret    

000040a3 <open>:
SYSCALL(open)
    40a3:	b8 0f 00 00 00       	mov    $0xf,%eax
    40a8:	cd 40                	int    $0x40
    40aa:	c3                   	ret    

000040ab <mknod>:
SYSCALL(mknod)
    40ab:	b8 11 00 00 00       	mov    $0x11,%eax
    40b0:	cd 40                	int    $0x40
    40b2:	c3                   	ret    

000040b3 <unlink>:
SYSCALL(unlink)
    40b3:	b8 12 00 00 00       	mov    $0x12,%eax
    40b8:	cd 40                	int    $0x40
    40ba:	c3                   	ret    

000040bb <fstat>:
SYSCALL(fstat)
    40bb:	b8 08 00 00 00       	mov    $0x8,%eax
    40c0:	cd 40                	int    $0x40
    40c2:	c3                   	ret    

000040c3 <link>:
SYSCALL(link)
    40c3:	b8 13 00 00 00       	mov    $0x13,%eax
    40c8:	cd 40                	int    $0x40
    40ca:	c3                   	ret    

000040cb <mkdir>:
SYSCALL(mkdir)
    40cb:	b8 14 00 00 00       	mov    $0x14,%eax
    40d0:	cd 40                	int    $0x40
    40d2:	c3                   	ret    

000040d3 <chdir>:
SYSCALL(chdir)
    40d3:	b8 09 00 00 00       	mov    $0x9,%eax
    40d8:	cd 40                	int    $0x40
    40da:	c3                   	ret    

000040db <dup>:
SYSCALL(dup)
    40db:	b8 0a 00 00 00       	mov    $0xa,%eax
    40e0:	cd 40                	int    $0x40
    40e2:	c3                   	ret    

000040e3 <getpid>:
SYSCALL(getpid)
    40e3:	b8 0b 00 00 00       	mov    $0xb,%eax
    40e8:	cd 40                	int    $0x40
    40ea:	c3                   	ret    

000040eb <sbrk>:
SYSCALL(sbrk)
    40eb:	b8 0c 00 00 00       	mov    $0xc,%eax
    40f0:	cd 40                	int    $0x40
    40f2:	c3                   	ret    

000040f3 <sleep>:
SYSCALL(sleep)
    40f3:	b8 0d 00 00 00       	mov    $0xd,%eax
    40f8:	cd 40                	int    $0x40
    40fa:	c3                   	ret    

000040fb <uptime>:
SYSCALL(uptime)
    40fb:	b8 0e 00 00 00       	mov    $0xe,%eax
    4100:	cd 40                	int    $0x40
    4102:	c3                   	ret    

00004103 <print_proc>:
SYSCALL(print_proc)
    4103:	b8 16 00 00 00       	mov    $0x16,%eax
    4108:	cd 40                	int    $0x40
    410a:	c3                   	ret    

0000410b <change_queue>:
    410b:	b8 17 00 00 00       	mov    $0x17,%eax
    4110:	cd 40                	int    $0x40
    4112:	c3                   	ret    

00004113 <putc>:
#include "stat.h"
#include "user.h"

static void
putc(int fd, char c)
{
    4113:	55                   	push   %ebp
    4114:	89 e5                	mov    %esp,%ebp
    4116:	83 ec 18             	sub    $0x18,%esp
    4119:	8b 45 0c             	mov    0xc(%ebp),%eax
    411c:	88 45 f4             	mov    %al,-0xc(%ebp)
  write(fd, &c, 1);
    411f:	83 ec 04             	sub    $0x4,%esp
    4122:	6a 01                	push   $0x1
    4124:	8d 45 f4             	lea    -0xc(%ebp),%eax
    4127:	50                   	push   %eax
    4128:	ff 75 08             	push   0x8(%ebp)
    412b:	e8 53 ff ff ff       	call   4083 <write>
    4130:	83 c4 10             	add    $0x10,%esp
}
    4133:	90                   	nop
    4134:	c9                   	leave  
    4135:	c3                   	ret    

00004136 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    4136:	55                   	push   %ebp
    4137:	89 e5                	mov    %esp,%ebp
    4139:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789ABCDEF";
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
    413c:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  if(sgn && xx < 0){
    4143:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
    4147:	74 17                	je     4160 <printint+0x2a>
    4149:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
    414d:	79 11                	jns    4160 <printint+0x2a>
    neg = 1;
    414f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
    x = -xx;
    4156:	8b 45 0c             	mov    0xc(%ebp),%eax
    4159:	f7 d8                	neg    %eax
    415b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    415e:	eb 06                	jmp    4166 <printint+0x30>
  } else {
    x = xx;
    4160:	8b 45 0c             	mov    0xc(%ebp),%eax
    4163:	89 45 ec             	mov    %eax,-0x14(%ebp)
  }

  i = 0;
    4166:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
    416d:	8b 4d 10             	mov    0x10(%ebp),%ecx
    4170:	8b 45 ec             	mov    -0x14(%ebp),%eax
    4173:	ba 00 00 00 00       	mov    $0x0,%edx
    4178:	f7 f1                	div    %ecx
    417a:	89 d1                	mov    %edx,%ecx
    417c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    417f:	8d 50 01             	lea    0x1(%eax),%edx
    4182:	89 55 f4             	mov    %edx,-0xc(%ebp)
    4185:	0f b6 91 20 65 00 00 	movzbl 0x6520(%ecx),%edx
    418c:	88 54 05 dc          	mov    %dl,-0x24(%ebp,%eax,1)
  }while((x /= base) != 0);
    4190:	8b 4d 10             	mov    0x10(%ebp),%ecx
    4193:	8b 45 ec             	mov    -0x14(%ebp),%eax
    4196:	ba 00 00 00 00       	mov    $0x0,%edx
    419b:	f7 f1                	div    %ecx
    419d:	89 45 ec             	mov    %eax,-0x14(%ebp)
    41a0:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    41a4:	75 c7                	jne    416d <printint+0x37>
  if(neg)
    41a6:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    41aa:	74 2d                	je     41d9 <printint+0xa3>
    buf[i++] = '-';
    41ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
    41af:	8d 50 01             	lea    0x1(%eax),%edx
    41b2:	89 55 f4             	mov    %edx,-0xc(%ebp)
    41b5:	c6 44 05 dc 2d       	movb   $0x2d,-0x24(%ebp,%eax,1)

  while(--i >= 0)
    41ba:	eb 1d                	jmp    41d9 <printint+0xa3>
    putc(fd, buf[i]);
    41bc:	8d 55 dc             	lea    -0x24(%ebp),%edx
    41bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
    41c2:	01 d0                	add    %edx,%eax
    41c4:	0f b6 00             	movzbl (%eax),%eax
    41c7:	0f be c0             	movsbl %al,%eax
    41ca:	83 ec 08             	sub    $0x8,%esp
    41cd:	50                   	push   %eax
    41ce:	ff 75 08             	push   0x8(%ebp)
    41d1:	e8 3d ff ff ff       	call   4113 <putc>
    41d6:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
    41d9:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
    41dd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    41e1:	79 d9                	jns    41bc <printint+0x86>
}
    41e3:	90                   	nop
    41e4:	90                   	nop
    41e5:	c9                   	leave  
    41e6:	c3                   	ret    

000041e7 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    41e7:	55                   	push   %ebp
    41e8:	89 e5                	mov    %esp,%ebp
    41ea:	83 ec 28             	sub    $0x28,%esp
  char *s;
  int c, i, state;
  uint *ap;

  state = 0;
    41ed:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  ap = (uint*)(void*)&fmt + 1;
    41f4:	8d 45 0c             	lea    0xc(%ebp),%eax
    41f7:	83 c0 04             	add    $0x4,%eax
    41fa:	89 45 e8             	mov    %eax,-0x18(%ebp)
  for(i = 0; fmt[i]; i++){
    41fd:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    4204:	e9 59 01 00 00       	jmp    4362 <printf+0x17b>
    c = fmt[i] & 0xff;
    4209:	8b 55 0c             	mov    0xc(%ebp),%edx
    420c:	8b 45 f0             	mov    -0x10(%ebp),%eax
    420f:	01 d0                	add    %edx,%eax
    4211:	0f b6 00             	movzbl (%eax),%eax
    4214:	0f be c0             	movsbl %al,%eax
    4217:	25 ff 00 00 00       	and    $0xff,%eax
    421c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(state == 0){
    421f:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
    4223:	75 2c                	jne    4251 <printf+0x6a>
      if(c == '%'){
    4225:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    4229:	75 0c                	jne    4237 <printf+0x50>
        state = '%';
    422b:	c7 45 ec 25 00 00 00 	movl   $0x25,-0x14(%ebp)
    4232:	e9 27 01 00 00       	jmp    435e <printf+0x177>
      } else {
        putc(fd, c);
    4237:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    423a:	0f be c0             	movsbl %al,%eax
    423d:	83 ec 08             	sub    $0x8,%esp
    4240:	50                   	push   %eax
    4241:	ff 75 08             	push   0x8(%ebp)
    4244:	e8 ca fe ff ff       	call   4113 <putc>
    4249:	83 c4 10             	add    $0x10,%esp
    424c:	e9 0d 01 00 00       	jmp    435e <printf+0x177>
      }
    } else if(state == '%'){
    4251:	83 7d ec 25          	cmpl   $0x25,-0x14(%ebp)
    4255:	0f 85 03 01 00 00    	jne    435e <printf+0x177>
      if(c == 'd'){
    425b:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
    425f:	75 1e                	jne    427f <printf+0x98>
        printint(fd, *ap, 10, 1);
    4261:	8b 45 e8             	mov    -0x18(%ebp),%eax
    4264:	8b 00                	mov    (%eax),%eax
    4266:	6a 01                	push   $0x1
    4268:	6a 0a                	push   $0xa
    426a:	50                   	push   %eax
    426b:	ff 75 08             	push   0x8(%ebp)
    426e:	e8 c3 fe ff ff       	call   4136 <printint>
    4273:	83 c4 10             	add    $0x10,%esp
        ap++;
    4276:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    427a:	e9 d8 00 00 00       	jmp    4357 <printf+0x170>
      } else if(c == 'x' || c == 'p'){
    427f:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
    4283:	74 06                	je     428b <printf+0xa4>
    4285:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
    4289:	75 1e                	jne    42a9 <printf+0xc2>
        printint(fd, *ap, 16, 0);
    428b:	8b 45 e8             	mov    -0x18(%ebp),%eax
    428e:	8b 00                	mov    (%eax),%eax
    4290:	6a 00                	push   $0x0
    4292:	6a 10                	push   $0x10
    4294:	50                   	push   %eax
    4295:	ff 75 08             	push   0x8(%ebp)
    4298:	e8 99 fe ff ff       	call   4136 <printint>
    429d:	83 c4 10             	add    $0x10,%esp
        ap++;
    42a0:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    42a4:	e9 ae 00 00 00       	jmp    4357 <printf+0x170>
      } else if(c == 's'){
    42a9:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
    42ad:	75 43                	jne    42f2 <printf+0x10b>
        s = (char*)*ap;
    42af:	8b 45 e8             	mov    -0x18(%ebp),%eax
    42b2:	8b 00                	mov    (%eax),%eax
    42b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
        ap++;
    42b7:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
        if(s == 0)
    42bb:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    42bf:	75 25                	jne    42e6 <printf+0xff>
          s = "(null)";
    42c1:	c7 45 f4 ca 5d 00 00 	movl   $0x5dca,-0xc(%ebp)
        while(*s != 0){
    42c8:	eb 1c                	jmp    42e6 <printf+0xff>
          putc(fd, *s);
    42ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
    42cd:	0f b6 00             	movzbl (%eax),%eax
    42d0:	0f be c0             	movsbl %al,%eax
    42d3:	83 ec 08             	sub    $0x8,%esp
    42d6:	50                   	push   %eax
    42d7:	ff 75 08             	push   0x8(%ebp)
    42da:	e8 34 fe ff ff       	call   4113 <putc>
    42df:	83 c4 10             	add    $0x10,%esp
          s++;
    42e2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
        while(*s != 0){
    42e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
    42e9:	0f b6 00             	movzbl (%eax),%eax
    42ec:	84 c0                	test   %al,%al
    42ee:	75 da                	jne    42ca <printf+0xe3>
    42f0:	eb 65                	jmp    4357 <printf+0x170>
        }
      } else if(c == 'c'){
    42f2:	83 7d e4 63          	cmpl   $0x63,-0x1c(%ebp)
    42f6:	75 1d                	jne    4315 <printf+0x12e>
        putc(fd, *ap);
    42f8:	8b 45 e8             	mov    -0x18(%ebp),%eax
    42fb:	8b 00                	mov    (%eax),%eax
    42fd:	0f be c0             	movsbl %al,%eax
    4300:	83 ec 08             	sub    $0x8,%esp
    4303:	50                   	push   %eax
    4304:	ff 75 08             	push   0x8(%ebp)
    4307:	e8 07 fe ff ff       	call   4113 <putc>
    430c:	83 c4 10             	add    $0x10,%esp
        ap++;
    430f:	83 45 e8 04          	addl   $0x4,-0x18(%ebp)
    4313:	eb 42                	jmp    4357 <printf+0x170>
      } else if(c == '%'){
    4315:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
    4319:	75 17                	jne    4332 <printf+0x14b>
        putc(fd, c);
    431b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    431e:	0f be c0             	movsbl %al,%eax
    4321:	83 ec 08             	sub    $0x8,%esp
    4324:	50                   	push   %eax
    4325:	ff 75 08             	push   0x8(%ebp)
    4328:	e8 e6 fd ff ff       	call   4113 <putc>
    432d:	83 c4 10             	add    $0x10,%esp
    4330:	eb 25                	jmp    4357 <printf+0x170>
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
    4332:	83 ec 08             	sub    $0x8,%esp
    4335:	6a 25                	push   $0x25
    4337:	ff 75 08             	push   0x8(%ebp)
    433a:	e8 d4 fd ff ff       	call   4113 <putc>
    433f:	83 c4 10             	add    $0x10,%esp
        putc(fd, c);
    4342:	8b 45 e4             	mov    -0x1c(%ebp),%eax
    4345:	0f be c0             	movsbl %al,%eax
    4348:	83 ec 08             	sub    $0x8,%esp
    434b:	50                   	push   %eax
    434c:	ff 75 08             	push   0x8(%ebp)
    434f:	e8 bf fd ff ff       	call   4113 <putc>
    4354:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
    4357:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(i = 0; fmt[i]; i++){
    435e:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
    4362:	8b 55 0c             	mov    0xc(%ebp),%edx
    4365:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4368:	01 d0                	add    %edx,%eax
    436a:	0f b6 00             	movzbl (%eax),%eax
    436d:	84 c0                	test   %al,%al
    436f:	0f 85 94 fe ff ff    	jne    4209 <printf+0x22>
    }
  }
}
    4375:	90                   	nop
    4376:	90                   	nop
    4377:	c9                   	leave  
    4378:	c3                   	ret    

00004379 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    4379:	55                   	push   %ebp
    437a:	89 e5                	mov    %esp,%ebp
    437c:	83 ec 10             	sub    $0x10,%esp
  Header *bp, *p;

  bp = (Header*)ap - 1;
    437f:	8b 45 08             	mov    0x8(%ebp),%eax
    4382:	83 e8 08             	sub    $0x8,%eax
    4385:	89 45 f8             	mov    %eax,-0x8(%ebp)
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    4388:	a1 08 ad 00 00       	mov    0xad08,%eax
    438d:	89 45 fc             	mov    %eax,-0x4(%ebp)
    4390:	eb 24                	jmp    43b6 <free+0x3d>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    4392:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4395:	8b 00                	mov    (%eax),%eax
    4397:	39 45 fc             	cmp    %eax,-0x4(%ebp)
    439a:	72 12                	jb     43ae <free+0x35>
    439c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    439f:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    43a2:	77 24                	ja     43c8 <free+0x4f>
    43a4:	8b 45 fc             	mov    -0x4(%ebp),%eax
    43a7:	8b 00                	mov    (%eax),%eax
    43a9:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    43ac:	72 1a                	jb     43c8 <free+0x4f>
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    43ae:	8b 45 fc             	mov    -0x4(%ebp),%eax
    43b1:	8b 00                	mov    (%eax),%eax
    43b3:	89 45 fc             	mov    %eax,-0x4(%ebp)
    43b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
    43b9:	3b 45 fc             	cmp    -0x4(%ebp),%eax
    43bc:	76 d4                	jbe    4392 <free+0x19>
    43be:	8b 45 fc             	mov    -0x4(%ebp),%eax
    43c1:	8b 00                	mov    (%eax),%eax
    43c3:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    43c6:	73 ca                	jae    4392 <free+0x19>
      break;
  if(bp + bp->s.size == p->s.ptr){
    43c8:	8b 45 f8             	mov    -0x8(%ebp),%eax
    43cb:	8b 40 04             	mov    0x4(%eax),%eax
    43ce:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    43d5:	8b 45 f8             	mov    -0x8(%ebp),%eax
    43d8:	01 c2                	add    %eax,%edx
    43da:	8b 45 fc             	mov    -0x4(%ebp),%eax
    43dd:	8b 00                	mov    (%eax),%eax
    43df:	39 c2                	cmp    %eax,%edx
    43e1:	75 24                	jne    4407 <free+0x8e>
    bp->s.size += p->s.ptr->s.size;
    43e3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    43e6:	8b 50 04             	mov    0x4(%eax),%edx
    43e9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    43ec:	8b 00                	mov    (%eax),%eax
    43ee:	8b 40 04             	mov    0x4(%eax),%eax
    43f1:	01 c2                	add    %eax,%edx
    43f3:	8b 45 f8             	mov    -0x8(%ebp),%eax
    43f6:	89 50 04             	mov    %edx,0x4(%eax)
    bp->s.ptr = p->s.ptr->s.ptr;
    43f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
    43fc:	8b 00                	mov    (%eax),%eax
    43fe:	8b 10                	mov    (%eax),%edx
    4400:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4403:	89 10                	mov    %edx,(%eax)
    4405:	eb 0a                	jmp    4411 <free+0x98>
  } else
    bp->s.ptr = p->s.ptr;
    4407:	8b 45 fc             	mov    -0x4(%ebp),%eax
    440a:	8b 10                	mov    (%eax),%edx
    440c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    440f:	89 10                	mov    %edx,(%eax)
  if(p + p->s.size == bp){
    4411:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4414:	8b 40 04             	mov    0x4(%eax),%eax
    4417:	8d 14 c5 00 00 00 00 	lea    0x0(,%eax,8),%edx
    441e:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4421:	01 d0                	add    %edx,%eax
    4423:	39 45 f8             	cmp    %eax,-0x8(%ebp)
    4426:	75 20                	jne    4448 <free+0xcf>
    p->s.size += bp->s.size;
    4428:	8b 45 fc             	mov    -0x4(%ebp),%eax
    442b:	8b 50 04             	mov    0x4(%eax),%edx
    442e:	8b 45 f8             	mov    -0x8(%ebp),%eax
    4431:	8b 40 04             	mov    0x4(%eax),%eax
    4434:	01 c2                	add    %eax,%edx
    4436:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4439:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    443c:	8b 45 f8             	mov    -0x8(%ebp),%eax
    443f:	8b 10                	mov    (%eax),%edx
    4441:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4444:	89 10                	mov    %edx,(%eax)
    4446:	eb 08                	jmp    4450 <free+0xd7>
  } else
    p->s.ptr = bp;
    4448:	8b 45 fc             	mov    -0x4(%ebp),%eax
    444b:	8b 55 f8             	mov    -0x8(%ebp),%edx
    444e:	89 10                	mov    %edx,(%eax)
  freep = p;
    4450:	8b 45 fc             	mov    -0x4(%ebp),%eax
    4453:	a3 08 ad 00 00       	mov    %eax,0xad08
}
    4458:	90                   	nop
    4459:	c9                   	leave  
    445a:	c3                   	ret    

0000445b <morecore>:

static Header*
morecore(uint nu)
{
    445b:	55                   	push   %ebp
    445c:	89 e5                	mov    %esp,%ebp
    445e:	83 ec 18             	sub    $0x18,%esp
  char *p;
  Header *hp;

  if(nu < 4096)
    4461:	81 7d 08 ff 0f 00 00 	cmpl   $0xfff,0x8(%ebp)
    4468:	77 07                	ja     4471 <morecore+0x16>
    nu = 4096;
    446a:	c7 45 08 00 10 00 00 	movl   $0x1000,0x8(%ebp)
  p = sbrk(nu * sizeof(Header));
    4471:	8b 45 08             	mov    0x8(%ebp),%eax
    4474:	c1 e0 03             	shl    $0x3,%eax
    4477:	83 ec 0c             	sub    $0xc,%esp
    447a:	50                   	push   %eax
    447b:	e8 6b fc ff ff       	call   40eb <sbrk>
    4480:	83 c4 10             	add    $0x10,%esp
    4483:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(p == (char*)-1)
    4486:	83 7d f4 ff          	cmpl   $0xffffffff,-0xc(%ebp)
    448a:	75 07                	jne    4493 <morecore+0x38>
    return 0;
    448c:	b8 00 00 00 00       	mov    $0x0,%eax
    4491:	eb 26                	jmp    44b9 <morecore+0x5e>
  hp = (Header*)p;
    4493:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4496:	89 45 f0             	mov    %eax,-0x10(%ebp)
  hp->s.size = nu;
    4499:	8b 45 f0             	mov    -0x10(%ebp),%eax
    449c:	8b 55 08             	mov    0x8(%ebp),%edx
    449f:	89 50 04             	mov    %edx,0x4(%eax)
  free((void*)(hp + 1));
    44a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
    44a5:	83 c0 08             	add    $0x8,%eax
    44a8:	83 ec 0c             	sub    $0xc,%esp
    44ab:	50                   	push   %eax
    44ac:	e8 c8 fe ff ff       	call   4379 <free>
    44b1:	83 c4 10             	add    $0x10,%esp
  return freep;
    44b4:	a1 08 ad 00 00       	mov    0xad08,%eax
}
    44b9:	c9                   	leave  
    44ba:	c3                   	ret    

000044bb <malloc>:

void*
malloc(uint nbytes)
{
    44bb:	55                   	push   %ebp
    44bc:	89 e5                	mov    %esp,%ebp
    44be:	83 ec 18             	sub    $0x18,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    44c1:	8b 45 08             	mov    0x8(%ebp),%eax
    44c4:	83 c0 07             	add    $0x7,%eax
    44c7:	c1 e8 03             	shr    $0x3,%eax
    44ca:	83 c0 01             	add    $0x1,%eax
    44cd:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((prevp = freep) == 0){
    44d0:	a1 08 ad 00 00       	mov    0xad08,%eax
    44d5:	89 45 f0             	mov    %eax,-0x10(%ebp)
    44d8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
    44dc:	75 23                	jne    4501 <malloc+0x46>
    base.s.ptr = freep = prevp = &base;
    44de:	c7 45 f0 00 ad 00 00 	movl   $0xad00,-0x10(%ebp)
    44e5:	8b 45 f0             	mov    -0x10(%ebp),%eax
    44e8:	a3 08 ad 00 00       	mov    %eax,0xad08
    44ed:	a1 08 ad 00 00       	mov    0xad08,%eax
    44f2:	a3 00 ad 00 00       	mov    %eax,0xad00
    base.s.size = 0;
    44f7:	c7 05 04 ad 00 00 00 	movl   $0x0,0xad04
    44fe:	00 00 00 
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4501:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4504:	8b 00                	mov    (%eax),%eax
    4506:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    4509:	8b 45 f4             	mov    -0xc(%ebp),%eax
    450c:	8b 40 04             	mov    0x4(%eax),%eax
    450f:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    4512:	77 4d                	ja     4561 <malloc+0xa6>
      if(p->s.size == nunits)
    4514:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4517:	8b 40 04             	mov    0x4(%eax),%eax
    451a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
    451d:	75 0c                	jne    452b <malloc+0x70>
        prevp->s.ptr = p->s.ptr;
    451f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4522:	8b 10                	mov    (%eax),%edx
    4524:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4527:	89 10                	mov    %edx,(%eax)
    4529:	eb 26                	jmp    4551 <malloc+0x96>
      else {
        p->s.size -= nunits;
    452b:	8b 45 f4             	mov    -0xc(%ebp),%eax
    452e:	8b 40 04             	mov    0x4(%eax),%eax
    4531:	2b 45 ec             	sub    -0x14(%ebp),%eax
    4534:	89 c2                	mov    %eax,%edx
    4536:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4539:	89 50 04             	mov    %edx,0x4(%eax)
        p += p->s.size;
    453c:	8b 45 f4             	mov    -0xc(%ebp),%eax
    453f:	8b 40 04             	mov    0x4(%eax),%eax
    4542:	c1 e0 03             	shl    $0x3,%eax
    4545:	01 45 f4             	add    %eax,-0xc(%ebp)
        p->s.size = nunits;
    4548:	8b 45 f4             	mov    -0xc(%ebp),%eax
    454b:	8b 55 ec             	mov    -0x14(%ebp),%edx
    454e:	89 50 04             	mov    %edx,0x4(%eax)
      }
      freep = prevp;
    4551:	8b 45 f0             	mov    -0x10(%ebp),%eax
    4554:	a3 08 ad 00 00       	mov    %eax,0xad08
      return (void*)(p + 1);
    4559:	8b 45 f4             	mov    -0xc(%ebp),%eax
    455c:	83 c0 08             	add    $0x8,%eax
    455f:	eb 3b                	jmp    459c <malloc+0xe1>
    }
    if(p == freep)
    4561:	a1 08 ad 00 00       	mov    0xad08,%eax
    4566:	39 45 f4             	cmp    %eax,-0xc(%ebp)
    4569:	75 1e                	jne    4589 <malloc+0xce>
      if((p = morecore(nunits)) == 0)
    456b:	83 ec 0c             	sub    $0xc,%esp
    456e:	ff 75 ec             	push   -0x14(%ebp)
    4571:	e8 e5 fe ff ff       	call   445b <morecore>
    4576:	83 c4 10             	add    $0x10,%esp
    4579:	89 45 f4             	mov    %eax,-0xc(%ebp)
    457c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
    4580:	75 07                	jne    4589 <malloc+0xce>
        return 0;
    4582:	b8 00 00 00 00       	mov    $0x0,%eax
    4587:	eb 13                	jmp    459c <malloc+0xe1>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    4589:	8b 45 f4             	mov    -0xc(%ebp),%eax
    458c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    458f:	8b 45 f4             	mov    -0xc(%ebp),%eax
    4592:	8b 00                	mov    (%eax),%eax
    4594:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(p->s.size >= nunits){
    4597:	e9 6d ff ff ff       	jmp    4509 <malloc+0x4e>
  }
}
    459c:	c9                   	leave  
    459d:	c3                   	ret    
