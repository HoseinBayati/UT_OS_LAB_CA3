
kernel:     file format elf32-i386


Disassembly of section .text:

80100000 <multiboot_header>:
80100000:	02 b0 ad 1b 00 00    	add    0x1bad(%eax),%dh
80100006:	00 00                	add    %al,(%eax)
80100008:	fe 4f 52             	decb   0x52(%edi)
8010000b:	e4                   	.byte 0xe4

8010000c <entry>:
8010000c:	0f 20 e0             	mov    %cr4,%eax
8010000f:	83 c8 10             	or     $0x10,%eax
80100012:	0f 22 e0             	mov    %eax,%cr4
80100015:	b8 00 b0 10 00       	mov    $0x10b000,%eax
8010001a:	0f 22 d8             	mov    %eax,%cr3
8010001d:	0f 20 c0             	mov    %cr0,%eax
80100020:	0d 00 00 01 80       	or     $0x80010000,%eax
80100025:	0f 22 c0             	mov    %eax,%cr0
80100028:	bc 60 83 11 80       	mov    $0x80118360,%esp
8010002d:	b8 5b 38 10 80       	mov    $0x8010385b,%eax
80100032:	ff e0                	jmp    *%eax

80100034 <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
80100034:	55                   	push   %ebp
80100035:	89 e5                	mov    %esp,%ebp
80100037:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  initlock(&bcache.lock, "bcache");
8010003a:	83 ec 08             	sub    $0x8,%esp
8010003d:	68 f4 95 10 80       	push   $0x801095f4
80100042:	68 a0 c5 10 80       	push   $0x8010c5a0
80100047:	e8 bf 5f 00 00       	call   8010600b <initlock>
8010004c:	83 c4 10             	add    $0x10,%esp

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004f:	c7 05 ec 0c 11 80 9c 	movl   $0x80110c9c,0x80110cec
80100056:	0c 11 80 
  bcache.head.next = &bcache.head;
80100059:	c7 05 f0 0c 11 80 9c 	movl   $0x80110c9c,0x80110cf0
80100060:	0c 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100063:	c7 45 f4 d4 c5 10 80 	movl   $0x8010c5d4,-0xc(%ebp)
8010006a:	eb 47                	jmp    801000b3 <binit+0x7f>
    b->next = bcache.head.next;
8010006c:	8b 15 f0 0c 11 80    	mov    0x80110cf0,%edx
80100072:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100075:	89 50 54             	mov    %edx,0x54(%eax)
    b->prev = &bcache.head;
80100078:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007b:	c7 40 50 9c 0c 11 80 	movl   $0x80110c9c,0x50(%eax)
    initsleeplock(&b->lock, "buffer");
80100082:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100085:	83 c0 0c             	add    $0xc,%eax
80100088:	83 ec 08             	sub    $0x8,%esp
8010008b:	68 fb 95 10 80       	push   $0x801095fb
80100090:	50                   	push   %eax
80100091:	e8 f2 5d 00 00       	call   80105e88 <initsleeplock>
80100096:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
80100099:	a1 f0 0c 11 80       	mov    0x80110cf0,%eax
8010009e:	8b 55 f4             	mov    -0xc(%ebp),%edx
801000a1:	89 50 50             	mov    %edx,0x50(%eax)
    bcache.head.next = b;
801000a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000a7:	a3 f0 0c 11 80       	mov    %eax,0x80110cf0
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000ac:	81 45 f4 5c 02 00 00 	addl   $0x25c,-0xc(%ebp)
801000b3:	b8 9c 0c 11 80       	mov    $0x80110c9c,%eax
801000b8:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801000bb:	72 af                	jb     8010006c <binit+0x38>
  }
}
801000bd:	90                   	nop
801000be:	90                   	nop
801000bf:	c9                   	leave  
801000c0:	c3                   	ret    

801000c1 <bget>:
// Look through buffer cache for block on device dev.
// If not found, allocate a buffer.
// In either case, return locked buffer.
static struct buf*
bget(uint dev, uint blockno)
{
801000c1:	55                   	push   %ebp
801000c2:	89 e5                	mov    %esp,%ebp
801000c4:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  acquire(&bcache.lock);
801000c7:	83 ec 0c             	sub    $0xc,%esp
801000ca:	68 a0 c5 10 80       	push   $0x8010c5a0
801000cf:	e8 59 5f 00 00       	call   8010602d <acquire>
801000d4:	83 c4 10             	add    $0x10,%esp

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000d7:	a1 f0 0c 11 80       	mov    0x80110cf0,%eax
801000dc:	89 45 f4             	mov    %eax,-0xc(%ebp)
801000df:	eb 58                	jmp    80100139 <bget+0x78>
    if(b->dev == dev && b->blockno == blockno){
801000e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000e4:	8b 40 04             	mov    0x4(%eax),%eax
801000e7:	39 45 08             	cmp    %eax,0x8(%ebp)
801000ea:	75 44                	jne    80100130 <bget+0x6f>
801000ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000ef:	8b 40 08             	mov    0x8(%eax),%eax
801000f2:	39 45 0c             	cmp    %eax,0xc(%ebp)
801000f5:	75 39                	jne    80100130 <bget+0x6f>
      b->refcnt++;
801000f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000fa:	8b 40 4c             	mov    0x4c(%eax),%eax
801000fd:	8d 50 01             	lea    0x1(%eax),%edx
80100100:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100103:	89 50 4c             	mov    %edx,0x4c(%eax)
      release(&bcache.lock);
80100106:	83 ec 0c             	sub    $0xc,%esp
80100109:	68 a0 c5 10 80       	push   $0x8010c5a0
8010010e:	e8 88 5f 00 00       	call   8010609b <release>
80100113:	83 c4 10             	add    $0x10,%esp
      acquiresleep(&b->lock);
80100116:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100119:	83 c0 0c             	add    $0xc,%eax
8010011c:	83 ec 0c             	sub    $0xc,%esp
8010011f:	50                   	push   %eax
80100120:	e8 9f 5d 00 00       	call   80105ec4 <acquiresleep>
80100125:	83 c4 10             	add    $0x10,%esp
      return b;
80100128:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010012b:	e9 9d 00 00 00       	jmp    801001cd <bget+0x10c>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
80100130:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100133:	8b 40 54             	mov    0x54(%eax),%eax
80100136:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100139:	81 7d f4 9c 0c 11 80 	cmpl   $0x80110c9c,-0xc(%ebp)
80100140:	75 9f                	jne    801000e1 <bget+0x20>
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100142:	a1 ec 0c 11 80       	mov    0x80110cec,%eax
80100147:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010014a:	eb 6b                	jmp    801001b7 <bget+0xf6>
    if(b->refcnt == 0 && (b->flags & B_DIRTY) == 0) {
8010014c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010014f:	8b 40 4c             	mov    0x4c(%eax),%eax
80100152:	85 c0                	test   %eax,%eax
80100154:	75 58                	jne    801001ae <bget+0xed>
80100156:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100159:	8b 00                	mov    (%eax),%eax
8010015b:	83 e0 04             	and    $0x4,%eax
8010015e:	85 c0                	test   %eax,%eax
80100160:	75 4c                	jne    801001ae <bget+0xed>
      b->dev = dev;
80100162:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100165:	8b 55 08             	mov    0x8(%ebp),%edx
80100168:	89 50 04             	mov    %edx,0x4(%eax)
      b->blockno = blockno;
8010016b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010016e:	8b 55 0c             	mov    0xc(%ebp),%edx
80100171:	89 50 08             	mov    %edx,0x8(%eax)
      b->flags = 0;
80100174:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100177:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
      b->refcnt = 1;
8010017d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100180:	c7 40 4c 01 00 00 00 	movl   $0x1,0x4c(%eax)
      release(&bcache.lock);
80100187:	83 ec 0c             	sub    $0xc,%esp
8010018a:	68 a0 c5 10 80       	push   $0x8010c5a0
8010018f:	e8 07 5f 00 00       	call   8010609b <release>
80100194:	83 c4 10             	add    $0x10,%esp
      acquiresleep(&b->lock);
80100197:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010019a:	83 c0 0c             	add    $0xc,%eax
8010019d:	83 ec 0c             	sub    $0xc,%esp
801001a0:	50                   	push   %eax
801001a1:	e8 1e 5d 00 00       	call   80105ec4 <acquiresleep>
801001a6:	83 c4 10             	add    $0x10,%esp
      return b;
801001a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001ac:	eb 1f                	jmp    801001cd <bget+0x10c>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
801001ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001b1:	8b 40 50             	mov    0x50(%eax),%eax
801001b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
801001b7:	81 7d f4 9c 0c 11 80 	cmpl   $0x80110c9c,-0xc(%ebp)
801001be:	75 8c                	jne    8010014c <bget+0x8b>
    }
  }
  panic("bget: no buffers");
801001c0:	83 ec 0c             	sub    $0xc,%esp
801001c3:	68 02 96 10 80       	push   $0x80109602
801001c8:	e8 e8 03 00 00       	call   801005b5 <panic>
}
801001cd:	c9                   	leave  
801001ce:	c3                   	ret    

801001cf <bread>:

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
801001cf:	55                   	push   %ebp
801001d0:	89 e5                	mov    %esp,%ebp
801001d2:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  b = bget(dev, blockno);
801001d5:	83 ec 08             	sub    $0x8,%esp
801001d8:	ff 75 0c             	push   0xc(%ebp)
801001db:	ff 75 08             	push   0x8(%ebp)
801001de:	e8 de fe ff ff       	call   801000c1 <bget>
801001e3:	83 c4 10             	add    $0x10,%esp
801001e6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((b->flags & B_VALID) == 0) {
801001e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001ec:	8b 00                	mov    (%eax),%eax
801001ee:	83 e0 02             	and    $0x2,%eax
801001f1:	85 c0                	test   %eax,%eax
801001f3:	75 0e                	jne    80100203 <bread+0x34>
    iderw(b);
801001f5:	83 ec 0c             	sub    $0xc,%esp
801001f8:	ff 75 f4             	push   -0xc(%ebp)
801001fb:	e8 5b 27 00 00       	call   8010295b <iderw>
80100200:	83 c4 10             	add    $0x10,%esp
  }
  return b;
80100203:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80100206:	c9                   	leave  
80100207:	c3                   	ret    

80100208 <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
80100208:	55                   	push   %ebp
80100209:	89 e5                	mov    %esp,%ebp
8010020b:	83 ec 08             	sub    $0x8,%esp
  if(!holdingsleep(&b->lock))
8010020e:	8b 45 08             	mov    0x8(%ebp),%eax
80100211:	83 c0 0c             	add    $0xc,%eax
80100214:	83 ec 0c             	sub    $0xc,%esp
80100217:	50                   	push   %eax
80100218:	e8 59 5d 00 00       	call   80105f76 <holdingsleep>
8010021d:	83 c4 10             	add    $0x10,%esp
80100220:	85 c0                	test   %eax,%eax
80100222:	75 0d                	jne    80100231 <bwrite+0x29>
    panic("bwrite");
80100224:	83 ec 0c             	sub    $0xc,%esp
80100227:	68 13 96 10 80       	push   $0x80109613
8010022c:	e8 84 03 00 00       	call   801005b5 <panic>
  b->flags |= B_DIRTY;
80100231:	8b 45 08             	mov    0x8(%ebp),%eax
80100234:	8b 00                	mov    (%eax),%eax
80100236:	83 c8 04             	or     $0x4,%eax
80100239:	89 c2                	mov    %eax,%edx
8010023b:	8b 45 08             	mov    0x8(%ebp),%eax
8010023e:	89 10                	mov    %edx,(%eax)
  iderw(b);
80100240:	83 ec 0c             	sub    $0xc,%esp
80100243:	ff 75 08             	push   0x8(%ebp)
80100246:	e8 10 27 00 00       	call   8010295b <iderw>
8010024b:	83 c4 10             	add    $0x10,%esp
}
8010024e:	90                   	nop
8010024f:	c9                   	leave  
80100250:	c3                   	ret    

80100251 <brelse>:

// Release a locked buffer.
// Move to the head of the MRU list.
void
brelse(struct buf *b)
{
80100251:	55                   	push   %ebp
80100252:	89 e5                	mov    %esp,%ebp
80100254:	83 ec 08             	sub    $0x8,%esp
  if(!holdingsleep(&b->lock))
80100257:	8b 45 08             	mov    0x8(%ebp),%eax
8010025a:	83 c0 0c             	add    $0xc,%eax
8010025d:	83 ec 0c             	sub    $0xc,%esp
80100260:	50                   	push   %eax
80100261:	e8 10 5d 00 00       	call   80105f76 <holdingsleep>
80100266:	83 c4 10             	add    $0x10,%esp
80100269:	85 c0                	test   %eax,%eax
8010026b:	75 0d                	jne    8010027a <brelse+0x29>
    panic("brelse");
8010026d:	83 ec 0c             	sub    $0xc,%esp
80100270:	68 1a 96 10 80       	push   $0x8010961a
80100275:	e8 3b 03 00 00       	call   801005b5 <panic>

  releasesleep(&b->lock);
8010027a:	8b 45 08             	mov    0x8(%ebp),%eax
8010027d:	83 c0 0c             	add    $0xc,%eax
80100280:	83 ec 0c             	sub    $0xc,%esp
80100283:	50                   	push   %eax
80100284:	e8 9f 5c 00 00       	call   80105f28 <releasesleep>
80100289:	83 c4 10             	add    $0x10,%esp

  acquire(&bcache.lock);
8010028c:	83 ec 0c             	sub    $0xc,%esp
8010028f:	68 a0 c5 10 80       	push   $0x8010c5a0
80100294:	e8 94 5d 00 00       	call   8010602d <acquire>
80100299:	83 c4 10             	add    $0x10,%esp
  b->refcnt--;
8010029c:	8b 45 08             	mov    0x8(%ebp),%eax
8010029f:	8b 40 4c             	mov    0x4c(%eax),%eax
801002a2:	8d 50 ff             	lea    -0x1(%eax),%edx
801002a5:	8b 45 08             	mov    0x8(%ebp),%eax
801002a8:	89 50 4c             	mov    %edx,0x4c(%eax)
  if (b->refcnt == 0) {
801002ab:	8b 45 08             	mov    0x8(%ebp),%eax
801002ae:	8b 40 4c             	mov    0x4c(%eax),%eax
801002b1:	85 c0                	test   %eax,%eax
801002b3:	75 47                	jne    801002fc <brelse+0xab>
    // no one is waiting for it.
    b->next->prev = b->prev;
801002b5:	8b 45 08             	mov    0x8(%ebp),%eax
801002b8:	8b 40 54             	mov    0x54(%eax),%eax
801002bb:	8b 55 08             	mov    0x8(%ebp),%edx
801002be:	8b 52 50             	mov    0x50(%edx),%edx
801002c1:	89 50 50             	mov    %edx,0x50(%eax)
    b->prev->next = b->next;
801002c4:	8b 45 08             	mov    0x8(%ebp),%eax
801002c7:	8b 40 50             	mov    0x50(%eax),%eax
801002ca:	8b 55 08             	mov    0x8(%ebp),%edx
801002cd:	8b 52 54             	mov    0x54(%edx),%edx
801002d0:	89 50 54             	mov    %edx,0x54(%eax)
    b->next = bcache.head.next;
801002d3:	8b 15 f0 0c 11 80    	mov    0x80110cf0,%edx
801002d9:	8b 45 08             	mov    0x8(%ebp),%eax
801002dc:	89 50 54             	mov    %edx,0x54(%eax)
    b->prev = &bcache.head;
801002df:	8b 45 08             	mov    0x8(%ebp),%eax
801002e2:	c7 40 50 9c 0c 11 80 	movl   $0x80110c9c,0x50(%eax)
    bcache.head.next->prev = b;
801002e9:	a1 f0 0c 11 80       	mov    0x80110cf0,%eax
801002ee:	8b 55 08             	mov    0x8(%ebp),%edx
801002f1:	89 50 50             	mov    %edx,0x50(%eax)
    bcache.head.next = b;
801002f4:	8b 45 08             	mov    0x8(%ebp),%eax
801002f7:	a3 f0 0c 11 80       	mov    %eax,0x80110cf0
  }
  
  release(&bcache.lock);
801002fc:	83 ec 0c             	sub    $0xc,%esp
801002ff:	68 a0 c5 10 80       	push   $0x8010c5a0
80100304:	e8 92 5d 00 00       	call   8010609b <release>
80100309:	83 c4 10             	add    $0x10,%esp
}
8010030c:	90                   	nop
8010030d:	c9                   	leave  
8010030e:	c3                   	ret    

8010030f <inb>:
// Routines to let C code use special x86 instructions.

static inline uchar
inb(ushort port)
{
8010030f:	55                   	push   %ebp
80100310:	89 e5                	mov    %esp,%ebp
80100312:	83 ec 14             	sub    $0x14,%esp
80100315:	8b 45 08             	mov    0x8(%ebp),%eax
80100318:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  uchar data;

  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
8010031c:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80100320:	89 c2                	mov    %eax,%edx
80100322:	ec                   	in     (%dx),%al
80100323:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80100326:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
8010032a:	c9                   	leave  
8010032b:	c3                   	ret    

8010032c <outb>:
               "memory", "cc");
}

static inline void
outb(ushort port, uchar data)
{
8010032c:	55                   	push   %ebp
8010032d:	89 e5                	mov    %esp,%ebp
8010032f:	83 ec 08             	sub    $0x8,%esp
80100332:	8b 45 08             	mov    0x8(%ebp),%eax
80100335:	8b 55 0c             	mov    0xc(%ebp),%edx
80100338:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
8010033c:	89 d0                	mov    %edx,%eax
8010033e:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80100341:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80100345:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80100349:	ee                   	out    %al,(%dx)
}
8010034a:	90                   	nop
8010034b:	c9                   	leave  
8010034c:	c3                   	ret    

8010034d <cli>:
  asm volatile("movw %0, %%gs" : : "r" (v));
}

static inline void
cli(void)
{
8010034d:	55                   	push   %ebp
8010034e:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80100350:	fa                   	cli    
}
80100351:	90                   	nop
80100352:	5d                   	pop    %ebp
80100353:	c3                   	ret    

80100354 <printint>:
  int locking;
} cons;

static void
printint(int xx, int base, int sign)
{
80100354:	55                   	push   %ebp
80100355:	89 e5                	mov    %esp,%ebp
80100357:	83 ec 28             	sub    $0x28,%esp
  static char digits[] = "0123456789abcdef";
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
8010035a:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010035e:	74 1c                	je     8010037c <printint+0x28>
80100360:	8b 45 08             	mov    0x8(%ebp),%eax
80100363:	c1 e8 1f             	shr    $0x1f,%eax
80100366:	0f b6 c0             	movzbl %al,%eax
80100369:	89 45 10             	mov    %eax,0x10(%ebp)
8010036c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100370:	74 0a                	je     8010037c <printint+0x28>
    x = -xx;
80100372:	8b 45 08             	mov    0x8(%ebp),%eax
80100375:	f7 d8                	neg    %eax
80100377:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010037a:	eb 06                	jmp    80100382 <printint+0x2e>
  else
    x = xx;
8010037c:	8b 45 08             	mov    0x8(%ebp),%eax
8010037f:	89 45 f0             	mov    %eax,-0x10(%ebp)

  i = 0;
80100382:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  do{
    buf[i++] = digits[x % base];
80100389:	8b 4d 0c             	mov    0xc(%ebp),%ecx
8010038c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010038f:	ba 00 00 00 00       	mov    $0x0,%edx
80100394:	f7 f1                	div    %ecx
80100396:	89 d1                	mov    %edx,%ecx
80100398:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010039b:	8d 50 01             	lea    0x1(%eax),%edx
8010039e:	89 55 f4             	mov    %edx,-0xc(%ebp)
801003a1:	0f b6 91 04 a0 10 80 	movzbl -0x7fef5ffc(%ecx),%edx
801003a8:	88 54 05 e0          	mov    %dl,-0x20(%ebp,%eax,1)
  }while((x /= base) != 0);
801003ac:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801003af:	8b 45 f0             	mov    -0x10(%ebp),%eax
801003b2:	ba 00 00 00 00       	mov    $0x0,%edx
801003b7:	f7 f1                	div    %ecx
801003b9:	89 45 f0             	mov    %eax,-0x10(%ebp)
801003bc:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801003c0:	75 c7                	jne    80100389 <printint+0x35>

  if(sign)
801003c2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801003c6:	74 2a                	je     801003f2 <printint+0x9e>
    buf[i++] = '-';
801003c8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801003cb:	8d 50 01             	lea    0x1(%eax),%edx
801003ce:	89 55 f4             	mov    %edx,-0xc(%ebp)
801003d1:	c6 44 05 e0 2d       	movb   $0x2d,-0x20(%ebp,%eax,1)

  while(--i >= 0)
801003d6:	eb 1a                	jmp    801003f2 <printint+0x9e>
    consputc(buf[i]);
801003d8:	8d 55 e0             	lea    -0x20(%ebp),%edx
801003db:	8b 45 f4             	mov    -0xc(%ebp),%eax
801003de:	01 d0                	add    %edx,%eax
801003e0:	0f b6 00             	movzbl (%eax),%eax
801003e3:	0f be c0             	movsbl %al,%eax
801003e6:	83 ec 0c             	sub    $0xc,%esp
801003e9:	50                   	push   %eax
801003ea:	e8 f9 03 00 00       	call   801007e8 <consputc>
801003ef:	83 c4 10             	add    $0x10,%esp
  while(--i >= 0)
801003f2:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
801003f6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801003fa:	79 dc                	jns    801003d8 <printint+0x84>
}
801003fc:	90                   	nop
801003fd:	90                   	nop
801003fe:	c9                   	leave  
801003ff:	c3                   	ret    

80100400 <cprintf>:
//PAGEBREAK: 50

// Print to the console. only understands %d, %x, %p, %s.
void
cprintf(char *fmt, ...)
{
80100400:	55                   	push   %ebp
80100401:	89 e5                	mov    %esp,%ebp
80100403:	83 ec 28             	sub    $0x28,%esp
  int i, c, locking;
  uint *argp;
  char *s;

  locking = cons.locking;
80100406:	a1 d4 0f 11 80       	mov    0x80110fd4,%eax
8010040b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
8010040e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80100412:	74 10                	je     80100424 <cprintf+0x24>
    acquire(&cons.lock);
80100414:	83 ec 0c             	sub    $0xc,%esp
80100417:	68 a0 0f 11 80       	push   $0x80110fa0
8010041c:	e8 0c 5c 00 00       	call   8010602d <acquire>
80100421:	83 c4 10             	add    $0x10,%esp

  if (fmt == 0)
80100424:	8b 45 08             	mov    0x8(%ebp),%eax
80100427:	85 c0                	test   %eax,%eax
80100429:	75 0d                	jne    80100438 <cprintf+0x38>
    panic("null fmt");
8010042b:	83 ec 0c             	sub    $0xc,%esp
8010042e:	68 21 96 10 80       	push   $0x80109621
80100433:	e8 7d 01 00 00       	call   801005b5 <panic>

  argp = (uint*)(void*)(&fmt + 1);
80100438:	8d 45 0c             	lea    0xc(%ebp),%eax
8010043b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
8010043e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100445:	e9 2f 01 00 00       	jmp    80100579 <cprintf+0x179>
    if(c != '%'){
8010044a:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
8010044e:	74 13                	je     80100463 <cprintf+0x63>
      consputc(c);
80100450:	83 ec 0c             	sub    $0xc,%esp
80100453:	ff 75 e4             	push   -0x1c(%ebp)
80100456:	e8 8d 03 00 00       	call   801007e8 <consputc>
8010045b:	83 c4 10             	add    $0x10,%esp
      continue;
8010045e:	e9 12 01 00 00       	jmp    80100575 <cprintf+0x175>
    }
    c = fmt[++i] & 0xff;
80100463:	8b 55 08             	mov    0x8(%ebp),%edx
80100466:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010046a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010046d:	01 d0                	add    %edx,%eax
8010046f:	0f b6 00             	movzbl (%eax),%eax
80100472:	0f be c0             	movsbl %al,%eax
80100475:	25 ff 00 00 00       	and    $0xff,%eax
8010047a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if(c == 0)
8010047d:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100481:	0f 84 14 01 00 00    	je     8010059b <cprintf+0x19b>
      break;
    switch(c){
80100487:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
8010048b:	74 5e                	je     801004eb <cprintf+0xeb>
8010048d:	83 7d e4 78          	cmpl   $0x78,-0x1c(%ebp)
80100491:	0f 8f c2 00 00 00    	jg     80100559 <cprintf+0x159>
80100497:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
8010049b:	74 6b                	je     80100508 <cprintf+0x108>
8010049d:	83 7d e4 73          	cmpl   $0x73,-0x1c(%ebp)
801004a1:	0f 8f b2 00 00 00    	jg     80100559 <cprintf+0x159>
801004a7:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
801004ab:	74 3e                	je     801004eb <cprintf+0xeb>
801004ad:	83 7d e4 70          	cmpl   $0x70,-0x1c(%ebp)
801004b1:	0f 8f a2 00 00 00    	jg     80100559 <cprintf+0x159>
801004b7:	83 7d e4 25          	cmpl   $0x25,-0x1c(%ebp)
801004bb:	0f 84 89 00 00 00    	je     8010054a <cprintf+0x14a>
801004c1:	83 7d e4 64          	cmpl   $0x64,-0x1c(%ebp)
801004c5:	0f 85 8e 00 00 00    	jne    80100559 <cprintf+0x159>
    case 'd':
      printint(*argp++, 10, 1);
801004cb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004ce:	8d 50 04             	lea    0x4(%eax),%edx
801004d1:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004d4:	8b 00                	mov    (%eax),%eax
801004d6:	83 ec 04             	sub    $0x4,%esp
801004d9:	6a 01                	push   $0x1
801004db:	6a 0a                	push   $0xa
801004dd:	50                   	push   %eax
801004de:	e8 71 fe ff ff       	call   80100354 <printint>
801004e3:	83 c4 10             	add    $0x10,%esp
      break;
801004e6:	e9 8a 00 00 00       	jmp    80100575 <cprintf+0x175>
    case 'x':
    case 'p':
      printint(*argp++, 16, 0);
801004eb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801004ee:	8d 50 04             	lea    0x4(%eax),%edx
801004f1:	89 55 f0             	mov    %edx,-0x10(%ebp)
801004f4:	8b 00                	mov    (%eax),%eax
801004f6:	83 ec 04             	sub    $0x4,%esp
801004f9:	6a 00                	push   $0x0
801004fb:	6a 10                	push   $0x10
801004fd:	50                   	push   %eax
801004fe:	e8 51 fe ff ff       	call   80100354 <printint>
80100503:	83 c4 10             	add    $0x10,%esp
      break;
80100506:	eb 6d                	jmp    80100575 <cprintf+0x175>
    case 's':
      if((s = (char*)*argp++) == 0)
80100508:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010050b:	8d 50 04             	lea    0x4(%eax),%edx
8010050e:	89 55 f0             	mov    %edx,-0x10(%ebp)
80100511:	8b 00                	mov    (%eax),%eax
80100513:	89 45 ec             	mov    %eax,-0x14(%ebp)
80100516:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010051a:	75 22                	jne    8010053e <cprintf+0x13e>
        s = "(null)";
8010051c:	c7 45 ec 2a 96 10 80 	movl   $0x8010962a,-0x14(%ebp)
      for(; *s; s++)
80100523:	eb 19                	jmp    8010053e <cprintf+0x13e>
        consputc(*s);
80100525:	8b 45 ec             	mov    -0x14(%ebp),%eax
80100528:	0f b6 00             	movzbl (%eax),%eax
8010052b:	0f be c0             	movsbl %al,%eax
8010052e:	83 ec 0c             	sub    $0xc,%esp
80100531:	50                   	push   %eax
80100532:	e8 b1 02 00 00       	call   801007e8 <consputc>
80100537:	83 c4 10             	add    $0x10,%esp
      for(; *s; s++)
8010053a:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
8010053e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80100541:	0f b6 00             	movzbl (%eax),%eax
80100544:	84 c0                	test   %al,%al
80100546:	75 dd                	jne    80100525 <cprintf+0x125>
      break;
80100548:	eb 2b                	jmp    80100575 <cprintf+0x175>
    case '%':
      consputc('%');
8010054a:	83 ec 0c             	sub    $0xc,%esp
8010054d:	6a 25                	push   $0x25
8010054f:	e8 94 02 00 00       	call   801007e8 <consputc>
80100554:	83 c4 10             	add    $0x10,%esp
      break;
80100557:	eb 1c                	jmp    80100575 <cprintf+0x175>
    default:
      // Print unknown % sequence to draw attention.
      consputc('%');
80100559:	83 ec 0c             	sub    $0xc,%esp
8010055c:	6a 25                	push   $0x25
8010055e:	e8 85 02 00 00       	call   801007e8 <consputc>
80100563:	83 c4 10             	add    $0x10,%esp
      consputc(c);
80100566:	83 ec 0c             	sub    $0xc,%esp
80100569:	ff 75 e4             	push   -0x1c(%ebp)
8010056c:	e8 77 02 00 00       	call   801007e8 <consputc>
80100571:	83 c4 10             	add    $0x10,%esp
      break;
80100574:	90                   	nop
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
80100575:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100579:	8b 55 08             	mov    0x8(%ebp),%edx
8010057c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010057f:	01 d0                	add    %edx,%eax
80100581:	0f b6 00             	movzbl (%eax),%eax
80100584:	0f be c0             	movsbl %al,%eax
80100587:	25 ff 00 00 00       	and    $0xff,%eax
8010058c:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010058f:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
80100593:	0f 85 b1 fe ff ff    	jne    8010044a <cprintf+0x4a>
80100599:	eb 01                	jmp    8010059c <cprintf+0x19c>
      break;
8010059b:	90                   	nop
    }
  }

  if(locking)
8010059c:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801005a0:	74 10                	je     801005b2 <cprintf+0x1b2>
    release(&cons.lock);
801005a2:	83 ec 0c             	sub    $0xc,%esp
801005a5:	68 a0 0f 11 80       	push   $0x80110fa0
801005aa:	e8 ec 5a 00 00       	call   8010609b <release>
801005af:	83 c4 10             	add    $0x10,%esp
}
801005b2:	90                   	nop
801005b3:	c9                   	leave  
801005b4:	c3                   	ret    

801005b5 <panic>:

void
panic(char *s)
{
801005b5:	55                   	push   %ebp
801005b6:	89 e5                	mov    %esp,%ebp
801005b8:	83 ec 38             	sub    $0x38,%esp
  int i;
  uint pcs[10];

  cli();
801005bb:	e8 8d fd ff ff       	call   8010034d <cli>
  cons.locking = 0;
801005c0:	c7 05 d4 0f 11 80 00 	movl   $0x0,0x80110fd4
801005c7:	00 00 00 
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
801005ca:	e8 21 2a 00 00       	call   80102ff0 <lapicid>
801005cf:	83 ec 08             	sub    $0x8,%esp
801005d2:	50                   	push   %eax
801005d3:	68 31 96 10 80       	push   $0x80109631
801005d8:	e8 23 fe ff ff       	call   80100400 <cprintf>
801005dd:	83 c4 10             	add    $0x10,%esp
  cprintf(s);
801005e0:	8b 45 08             	mov    0x8(%ebp),%eax
801005e3:	83 ec 0c             	sub    $0xc,%esp
801005e6:	50                   	push   %eax
801005e7:	e8 14 fe ff ff       	call   80100400 <cprintf>
801005ec:	83 c4 10             	add    $0x10,%esp
  cprintf("\n");
801005ef:	83 ec 0c             	sub    $0xc,%esp
801005f2:	68 45 96 10 80       	push   $0x80109645
801005f7:	e8 04 fe ff ff       	call   80100400 <cprintf>
801005fc:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
801005ff:	83 ec 08             	sub    $0x8,%esp
80100602:	8d 45 cc             	lea    -0x34(%ebp),%eax
80100605:	50                   	push   %eax
80100606:	8d 45 08             	lea    0x8(%ebp),%eax
80100609:	50                   	push   %eax
8010060a:	e8 de 5a 00 00       	call   801060ed <getcallerpcs>
8010060f:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
80100612:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100619:	eb 1c                	jmp    80100637 <panic+0x82>
    cprintf(" %p", pcs[i]);
8010061b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010061e:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
80100622:	83 ec 08             	sub    $0x8,%esp
80100625:	50                   	push   %eax
80100626:	68 47 96 10 80       	push   $0x80109647
8010062b:	e8 d0 fd ff ff       	call   80100400 <cprintf>
80100630:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
80100633:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100637:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
8010063b:	7e de                	jle    8010061b <panic+0x66>
  panicked = 1; // freeze other CPU
8010063d:	c7 05 8c 0f 11 80 01 	movl   $0x1,0x80110f8c
80100644:	00 00 00 
  for(;;)
80100647:	eb fe                	jmp    80100647 <panic+0x92>

80100649 <cgaputc>:
#define CRTPORT 0x3d4
static ushort *crt = (ushort*)P2V(0xb8000);  // CGA memory

static void
cgaputc(int c)
{
80100649:	55                   	push   %ebp
8010064a:	89 e5                	mov    %esp,%ebp
8010064c:	53                   	push   %ebx
8010064d:	83 ec 14             	sub    $0x14,%esp
  int pos;

  // Cursor position: col + 80*row.
  outb(CRTPORT, 14);
80100650:	6a 0e                	push   $0xe
80100652:	68 d4 03 00 00       	push   $0x3d4
80100657:	e8 d0 fc ff ff       	call   8010032c <outb>
8010065c:	83 c4 08             	add    $0x8,%esp
  pos = inb(CRTPORT+1) << 8;
8010065f:	68 d5 03 00 00       	push   $0x3d5
80100664:	e8 a6 fc ff ff       	call   8010030f <inb>
80100669:	83 c4 04             	add    $0x4,%esp
8010066c:	0f b6 c0             	movzbl %al,%eax
8010066f:	c1 e0 08             	shl    $0x8,%eax
80100672:	89 45 f4             	mov    %eax,-0xc(%ebp)
  outb(CRTPORT, 15);
80100675:	6a 0f                	push   $0xf
80100677:	68 d4 03 00 00       	push   $0x3d4
8010067c:	e8 ab fc ff ff       	call   8010032c <outb>
80100681:	83 c4 08             	add    $0x8,%esp
  pos |= inb(CRTPORT+1);
80100684:	68 d5 03 00 00       	push   $0x3d5
80100689:	e8 81 fc ff ff       	call   8010030f <inb>
8010068e:	83 c4 04             	add    $0x4,%esp
80100691:	0f b6 c0             	movzbl %al,%eax
80100694:	09 45 f4             	or     %eax,-0xc(%ebp)

  if(c == '\n')
80100697:	83 7d 08 0a          	cmpl   $0xa,0x8(%ebp)
8010069b:	75 34                	jne    801006d1 <cgaputc+0x88>
    pos += 80 - pos%80;
8010069d:	8b 4d f4             	mov    -0xc(%ebp),%ecx
801006a0:	ba 67 66 66 66       	mov    $0x66666667,%edx
801006a5:	89 c8                	mov    %ecx,%eax
801006a7:	f7 ea                	imul   %edx
801006a9:	89 d0                	mov    %edx,%eax
801006ab:	c1 f8 05             	sar    $0x5,%eax
801006ae:	89 cb                	mov    %ecx,%ebx
801006b0:	c1 fb 1f             	sar    $0x1f,%ebx
801006b3:	29 d8                	sub    %ebx,%eax
801006b5:	89 c2                	mov    %eax,%edx
801006b7:	89 d0                	mov    %edx,%eax
801006b9:	c1 e0 02             	shl    $0x2,%eax
801006bc:	01 d0                	add    %edx,%eax
801006be:	c1 e0 04             	shl    $0x4,%eax
801006c1:	29 c1                	sub    %eax,%ecx
801006c3:	89 ca                	mov    %ecx,%edx
801006c5:	b8 50 00 00 00       	mov    $0x50,%eax
801006ca:	29 d0                	sub    %edx,%eax
801006cc:	01 45 f4             	add    %eax,-0xc(%ebp)
801006cf:	eb 38                	jmp    80100709 <cgaputc+0xc0>
  else if(c == BACKSPACE){
801006d1:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
801006d8:	75 0c                	jne    801006e6 <cgaputc+0x9d>
    if(pos > 0) --pos;
801006da:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801006de:	7e 29                	jle    80100709 <cgaputc+0xc0>
801006e0:	83 6d f4 01          	subl   $0x1,-0xc(%ebp)
801006e4:	eb 23                	jmp    80100709 <cgaputc+0xc0>
  } else
    crt[pos++] = (c&0xff) | 0x0700;  // black on white
801006e6:	8b 45 08             	mov    0x8(%ebp),%eax
801006e9:	0f b6 c0             	movzbl %al,%eax
801006ec:	80 cc 07             	or     $0x7,%ah
801006ef:	89 c1                	mov    %eax,%ecx
801006f1:	8b 1d 00 a0 10 80    	mov    0x8010a000,%ebx
801006f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801006fa:	8d 50 01             	lea    0x1(%eax),%edx
801006fd:	89 55 f4             	mov    %edx,-0xc(%ebp)
80100700:	01 c0                	add    %eax,%eax
80100702:	01 d8                	add    %ebx,%eax
80100704:	89 ca                	mov    %ecx,%edx
80100706:	66 89 10             	mov    %dx,(%eax)

  if(pos < 0 || pos > 25*80)
80100709:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010070d:	78 09                	js     80100718 <cgaputc+0xcf>
8010070f:	81 7d f4 d0 07 00 00 	cmpl   $0x7d0,-0xc(%ebp)
80100716:	7e 0d                	jle    80100725 <cgaputc+0xdc>
    panic("pos under/overflow");
80100718:	83 ec 0c             	sub    $0xc,%esp
8010071b:	68 4b 96 10 80       	push   $0x8010964b
80100720:	e8 90 fe ff ff       	call   801005b5 <panic>

  if((pos/80) >= 24){  // Scroll up.
80100725:	81 7d f4 7f 07 00 00 	cmpl   $0x77f,-0xc(%ebp)
8010072c:	7e 4d                	jle    8010077b <cgaputc+0x132>
    memmove(crt, crt+80, sizeof(crt[0])*23*80);
8010072e:	a1 00 a0 10 80       	mov    0x8010a000,%eax
80100733:	8d 90 a0 00 00 00    	lea    0xa0(%eax),%edx
80100739:	a1 00 a0 10 80       	mov    0x8010a000,%eax
8010073e:	83 ec 04             	sub    $0x4,%esp
80100741:	68 60 0e 00 00       	push   $0xe60
80100746:	52                   	push   %edx
80100747:	50                   	push   %eax
80100748:	e8 25 5c 00 00       	call   80106372 <memmove>
8010074d:	83 c4 10             	add    $0x10,%esp
    pos -= 80;
80100750:	83 6d f4 50          	subl   $0x50,-0xc(%ebp)
    memset(crt+pos, 0, sizeof(crt[0])*(24*80 - pos));
80100754:	b8 80 07 00 00       	mov    $0x780,%eax
80100759:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010075c:	8d 14 00             	lea    (%eax,%eax,1),%edx
8010075f:	8b 0d 00 a0 10 80    	mov    0x8010a000,%ecx
80100765:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100768:	01 c0                	add    %eax,%eax
8010076a:	01 c8                	add    %ecx,%eax
8010076c:	83 ec 04             	sub    $0x4,%esp
8010076f:	52                   	push   %edx
80100770:	6a 00                	push   $0x0
80100772:	50                   	push   %eax
80100773:	e8 3b 5b 00 00       	call   801062b3 <memset>
80100778:	83 c4 10             	add    $0x10,%esp
  }

  outb(CRTPORT, 14);
8010077b:	83 ec 08             	sub    $0x8,%esp
8010077e:	6a 0e                	push   $0xe
80100780:	68 d4 03 00 00       	push   $0x3d4
80100785:	e8 a2 fb ff ff       	call   8010032c <outb>
8010078a:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos>>8);
8010078d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100790:	c1 f8 08             	sar    $0x8,%eax
80100793:	0f b6 c0             	movzbl %al,%eax
80100796:	83 ec 08             	sub    $0x8,%esp
80100799:	50                   	push   %eax
8010079a:	68 d5 03 00 00       	push   $0x3d5
8010079f:	e8 88 fb ff ff       	call   8010032c <outb>
801007a4:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT, 15);
801007a7:	83 ec 08             	sub    $0x8,%esp
801007aa:	6a 0f                	push   $0xf
801007ac:	68 d4 03 00 00       	push   $0x3d4
801007b1:	e8 76 fb ff ff       	call   8010032c <outb>
801007b6:	83 c4 10             	add    $0x10,%esp
  outb(CRTPORT+1, pos);
801007b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801007bc:	0f b6 c0             	movzbl %al,%eax
801007bf:	83 ec 08             	sub    $0x8,%esp
801007c2:	50                   	push   %eax
801007c3:	68 d5 03 00 00       	push   $0x3d5
801007c8:	e8 5f fb ff ff       	call   8010032c <outb>
801007cd:	83 c4 10             	add    $0x10,%esp
  crt[pos] = ' ' | 0x0700;
801007d0:	8b 15 00 a0 10 80    	mov    0x8010a000,%edx
801007d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801007d9:	01 c0                	add    %eax,%eax
801007db:	01 d0                	add    %edx,%eax
801007dd:	66 c7 00 20 07       	movw   $0x720,(%eax)
}
801007e2:	90                   	nop
801007e3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801007e6:	c9                   	leave  
801007e7:	c3                   	ret    

801007e8 <consputc>:

void
consputc(int c)
{
801007e8:	55                   	push   %ebp
801007e9:	89 e5                	mov    %esp,%ebp
801007eb:	83 ec 08             	sub    $0x8,%esp
  if(panicked){
801007ee:	a1 8c 0f 11 80       	mov    0x80110f8c,%eax
801007f3:	85 c0                	test   %eax,%eax
801007f5:	74 07                	je     801007fe <consputc+0x16>
    cli();
801007f7:	e8 51 fb ff ff       	call   8010034d <cli>
    for(;;)
801007fc:	eb fe                	jmp    801007fc <consputc+0x14>
      ;
  }

  if(c == BACKSPACE){
801007fe:	81 7d 08 00 01 00 00 	cmpl   $0x100,0x8(%ebp)
80100805:	75 29                	jne    80100830 <consputc+0x48>
    uartputc('\b'); uartputc(' '); uartputc('\b');
80100807:	83 ec 0c             	sub    $0xc,%esp
8010080a:	6a 08                	push   $0x8
8010080c:	e8 95 75 00 00       	call   80107da6 <uartputc>
80100811:	83 c4 10             	add    $0x10,%esp
80100814:	83 ec 0c             	sub    $0xc,%esp
80100817:	6a 20                	push   $0x20
80100819:	e8 88 75 00 00       	call   80107da6 <uartputc>
8010081e:	83 c4 10             	add    $0x10,%esp
80100821:	83 ec 0c             	sub    $0xc,%esp
80100824:	6a 08                	push   $0x8
80100826:	e8 7b 75 00 00       	call   80107da6 <uartputc>
8010082b:	83 c4 10             	add    $0x10,%esp
8010082e:	eb 0e                	jmp    8010083e <consputc+0x56>
  } else
    uartputc(c);
80100830:	83 ec 0c             	sub    $0xc,%esp
80100833:	ff 75 08             	push   0x8(%ebp)
80100836:	e8 6b 75 00 00       	call   80107da6 <uartputc>
8010083b:	83 c4 10             	add    $0x10,%esp
  cgaputc(c);
8010083e:	83 ec 0c             	sub    $0xc,%esp
80100841:	ff 75 08             	push   0x8(%ebp)
80100844:	e8 00 fe ff ff       	call   80100649 <cgaputc>
80100849:	83 c4 10             	add    $0x10,%esp
}
8010084c:	90                   	nop
8010084d:	c9                   	leave  
8010084e:	c3                   	ret    

8010084f <consoleintr>:

#define C(x)  ((x)-'@')  // Control-x

void
consoleintr(int (*getc)(void))
{
8010084f:	55                   	push   %ebp
80100850:	89 e5                	mov    %esp,%ebp
80100852:	83 ec 18             	sub    $0x18,%esp
  int c, doprocdump = 0;
80100855:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&cons.lock);
8010085c:	83 ec 0c             	sub    $0xc,%esp
8010085f:	68 a0 0f 11 80       	push   $0x80110fa0
80100864:	e8 c4 57 00 00       	call   8010602d <acquire>
80100869:	83 c4 10             	add    $0x10,%esp
  while((c = getc()) >= 0){
8010086c:	e9 50 01 00 00       	jmp    801009c1 <consoleintr+0x172>
    switch(c){
80100871:	83 7d f0 7f          	cmpl   $0x7f,-0x10(%ebp)
80100875:	0f 84 81 00 00 00    	je     801008fc <consoleintr+0xad>
8010087b:	83 7d f0 7f          	cmpl   $0x7f,-0x10(%ebp)
8010087f:	0f 8f ac 00 00 00    	jg     80100931 <consoleintr+0xe2>
80100885:	83 7d f0 15          	cmpl   $0x15,-0x10(%ebp)
80100889:	74 43                	je     801008ce <consoleintr+0x7f>
8010088b:	83 7d f0 15          	cmpl   $0x15,-0x10(%ebp)
8010088f:	0f 8f 9c 00 00 00    	jg     80100931 <consoleintr+0xe2>
80100895:	83 7d f0 08          	cmpl   $0x8,-0x10(%ebp)
80100899:	74 61                	je     801008fc <consoleintr+0xad>
8010089b:	83 7d f0 10          	cmpl   $0x10,-0x10(%ebp)
8010089f:	0f 85 8c 00 00 00    	jne    80100931 <consoleintr+0xe2>
    case C('P'):  // Process listing.
      // procdump() locks cons.lock indirectly; invoke later
      doprocdump = 1;
801008a5:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
      break;
801008ac:	e9 10 01 00 00       	jmp    801009c1 <consoleintr+0x172>
    case C('U'):  // Kill line.
      while(input.e != input.w &&
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
        input.e--;
801008b1:	a1 88 0f 11 80       	mov    0x80110f88,%eax
801008b6:	83 e8 01             	sub    $0x1,%eax
801008b9:	a3 88 0f 11 80       	mov    %eax,0x80110f88
        consputc(BACKSPACE);
801008be:	83 ec 0c             	sub    $0xc,%esp
801008c1:	68 00 01 00 00       	push   $0x100
801008c6:	e8 1d ff ff ff       	call   801007e8 <consputc>
801008cb:	83 c4 10             	add    $0x10,%esp
      while(input.e != input.w &&
801008ce:	8b 15 88 0f 11 80    	mov    0x80110f88,%edx
801008d4:	a1 84 0f 11 80       	mov    0x80110f84,%eax
801008d9:	39 c2                	cmp    %eax,%edx
801008db:	0f 84 e0 00 00 00    	je     801009c1 <consoleintr+0x172>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801008e1:	a1 88 0f 11 80       	mov    0x80110f88,%eax
801008e6:	83 e8 01             	sub    $0x1,%eax
801008e9:	83 e0 7f             	and    $0x7f,%eax
801008ec:	0f b6 80 00 0f 11 80 	movzbl -0x7feef100(%eax),%eax
      while(input.e != input.w &&
801008f3:	3c 0a                	cmp    $0xa,%al
801008f5:	75 ba                	jne    801008b1 <consoleintr+0x62>
      }
      break;
801008f7:	e9 c5 00 00 00       	jmp    801009c1 <consoleintr+0x172>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
801008fc:	8b 15 88 0f 11 80    	mov    0x80110f88,%edx
80100902:	a1 84 0f 11 80       	mov    0x80110f84,%eax
80100907:	39 c2                	cmp    %eax,%edx
80100909:	0f 84 b2 00 00 00    	je     801009c1 <consoleintr+0x172>
        input.e--;
8010090f:	a1 88 0f 11 80       	mov    0x80110f88,%eax
80100914:	83 e8 01             	sub    $0x1,%eax
80100917:	a3 88 0f 11 80       	mov    %eax,0x80110f88
        consputc(BACKSPACE);
8010091c:	83 ec 0c             	sub    $0xc,%esp
8010091f:	68 00 01 00 00       	push   $0x100
80100924:	e8 bf fe ff ff       	call   801007e8 <consputc>
80100929:	83 c4 10             	add    $0x10,%esp
      }
      break;
8010092c:	e9 90 00 00 00       	jmp    801009c1 <consoleintr+0x172>
    default:
      if(c != 0 && input.e-input.r < INPUT_BUF){
80100931:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80100935:	0f 84 85 00 00 00    	je     801009c0 <consoleintr+0x171>
8010093b:	a1 88 0f 11 80       	mov    0x80110f88,%eax
80100940:	8b 15 80 0f 11 80    	mov    0x80110f80,%edx
80100946:	29 d0                	sub    %edx,%eax
80100948:	83 f8 7f             	cmp    $0x7f,%eax
8010094b:	77 73                	ja     801009c0 <consoleintr+0x171>
        c = (c == '\r') ? '\n' : c;
8010094d:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
80100951:	74 05                	je     80100958 <consoleintr+0x109>
80100953:	8b 45 f0             	mov    -0x10(%ebp),%eax
80100956:	eb 05                	jmp    8010095d <consoleintr+0x10e>
80100958:	b8 0a 00 00 00       	mov    $0xa,%eax
8010095d:	89 45 f0             	mov    %eax,-0x10(%ebp)
        input.buf[input.e++ % INPUT_BUF] = c;
80100960:	a1 88 0f 11 80       	mov    0x80110f88,%eax
80100965:	8d 50 01             	lea    0x1(%eax),%edx
80100968:	89 15 88 0f 11 80    	mov    %edx,0x80110f88
8010096e:	83 e0 7f             	and    $0x7f,%eax
80100971:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100974:	88 90 00 0f 11 80    	mov    %dl,-0x7feef100(%eax)
        consputc(c);
8010097a:	83 ec 0c             	sub    $0xc,%esp
8010097d:	ff 75 f0             	push   -0x10(%ebp)
80100980:	e8 63 fe ff ff       	call   801007e8 <consputc>
80100985:	83 c4 10             	add    $0x10,%esp
        if(c == '\n' || c == C('D') || input.e == input.r+INPUT_BUF){
80100988:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
8010098c:	74 18                	je     801009a6 <consoleintr+0x157>
8010098e:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100992:	74 12                	je     801009a6 <consoleintr+0x157>
80100994:	a1 88 0f 11 80       	mov    0x80110f88,%eax
80100999:	8b 15 80 0f 11 80    	mov    0x80110f80,%edx
8010099f:	83 ea 80             	sub    $0xffffff80,%edx
801009a2:	39 d0                	cmp    %edx,%eax
801009a4:	75 1a                	jne    801009c0 <consoleintr+0x171>
          input.w = input.e;
801009a6:	a1 88 0f 11 80       	mov    0x80110f88,%eax
801009ab:	a3 84 0f 11 80       	mov    %eax,0x80110f84
          wakeup(&input.r);
801009b0:	83 ec 0c             	sub    $0xc,%esp
801009b3:	68 80 0f 11 80       	push   $0x80110f80
801009b8:	e8 0d 4a 00 00       	call   801053ca <wakeup>
801009bd:	83 c4 10             	add    $0x10,%esp
        }
      }
      break;
801009c0:	90                   	nop
  while((c = getc()) >= 0){
801009c1:	8b 45 08             	mov    0x8(%ebp),%eax
801009c4:	ff d0                	call   *%eax
801009c6:	89 45 f0             	mov    %eax,-0x10(%ebp)
801009c9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801009cd:	0f 89 9e fe ff ff    	jns    80100871 <consoleintr+0x22>
    }
  }
  release(&cons.lock);
801009d3:	83 ec 0c             	sub    $0xc,%esp
801009d6:	68 a0 0f 11 80       	push   $0x80110fa0
801009db:	e8 bb 56 00 00       	call   8010609b <release>
801009e0:	83 c4 10             	add    $0x10,%esp
  if(doprocdump) {
801009e3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801009e7:	74 05                	je     801009ee <consoleintr+0x19f>
    procdump();  // now call procdump() wo. cons.lock held
801009e9:	e8 22 4b 00 00       	call   80105510 <procdump>
  }
}
801009ee:	90                   	nop
801009ef:	c9                   	leave  
801009f0:	c3                   	ret    

801009f1 <consoleread>:

int
consoleread(struct inode *ip, char *dst, int n)
{
801009f1:	55                   	push   %ebp
801009f2:	89 e5                	mov    %esp,%ebp
801009f4:	83 ec 18             	sub    $0x18,%esp
  uint target;
  int c;

  iunlock(ip);
801009f7:	83 ec 0c             	sub    $0xc,%esp
801009fa:	ff 75 08             	push   0x8(%ebp)
801009fd:	e8 2b 11 00 00       	call   80101b2d <iunlock>
80100a02:	83 c4 10             	add    $0x10,%esp
  target = n;
80100a05:	8b 45 10             	mov    0x10(%ebp),%eax
80100a08:	89 45 f4             	mov    %eax,-0xc(%ebp)
  acquire(&cons.lock);
80100a0b:	83 ec 0c             	sub    $0xc,%esp
80100a0e:	68 a0 0f 11 80       	push   $0x80110fa0
80100a13:	e8 15 56 00 00       	call   8010602d <acquire>
80100a18:	83 c4 10             	add    $0x10,%esp
  while(n > 0){
80100a1b:	e9 ab 00 00 00       	jmp    80100acb <consoleread+0xda>
    while(input.r == input.w){
      if(myproc()->killed){
80100a20:	e8 f1 38 00 00       	call   80104316 <myproc>
80100a25:	8b 40 24             	mov    0x24(%eax),%eax
80100a28:	85 c0                	test   %eax,%eax
80100a2a:	74 28                	je     80100a54 <consoleread+0x63>
        release(&cons.lock);
80100a2c:	83 ec 0c             	sub    $0xc,%esp
80100a2f:	68 a0 0f 11 80       	push   $0x80110fa0
80100a34:	e8 62 56 00 00       	call   8010609b <release>
80100a39:	83 c4 10             	add    $0x10,%esp
        ilock(ip);
80100a3c:	83 ec 0c             	sub    $0xc,%esp
80100a3f:	ff 75 08             	push   0x8(%ebp)
80100a42:	e8 d3 0f 00 00       	call   80101a1a <ilock>
80100a47:	83 c4 10             	add    $0x10,%esp
        return -1;
80100a4a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100a4f:	e9 a9 00 00 00       	jmp    80100afd <consoleread+0x10c>
      }
      sleep(&input.r, &cons.lock);
80100a54:	83 ec 08             	sub    $0x8,%esp
80100a57:	68 a0 0f 11 80       	push   $0x80110fa0
80100a5c:	68 80 0f 11 80       	push   $0x80110f80
80100a61:	e8 e6 47 00 00       	call   8010524c <sleep>
80100a66:	83 c4 10             	add    $0x10,%esp
    while(input.r == input.w){
80100a69:	8b 15 80 0f 11 80    	mov    0x80110f80,%edx
80100a6f:	a1 84 0f 11 80       	mov    0x80110f84,%eax
80100a74:	39 c2                	cmp    %eax,%edx
80100a76:	74 a8                	je     80100a20 <consoleread+0x2f>
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100a78:	a1 80 0f 11 80       	mov    0x80110f80,%eax
80100a7d:	8d 50 01             	lea    0x1(%eax),%edx
80100a80:	89 15 80 0f 11 80    	mov    %edx,0x80110f80
80100a86:	83 e0 7f             	and    $0x7f,%eax
80100a89:	0f b6 80 00 0f 11 80 	movzbl -0x7feef100(%eax),%eax
80100a90:	0f be c0             	movsbl %al,%eax
80100a93:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(c == C('D')){  // EOF
80100a96:	83 7d f0 04          	cmpl   $0x4,-0x10(%ebp)
80100a9a:	75 17                	jne    80100ab3 <consoleread+0xc2>
      if(n < target){
80100a9c:	8b 45 10             	mov    0x10(%ebp),%eax
80100a9f:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80100aa2:	76 2f                	jbe    80100ad3 <consoleread+0xe2>
        // Save ^D for next time, to make sure
        // caller gets a 0-byte result.
        input.r--;
80100aa4:	a1 80 0f 11 80       	mov    0x80110f80,%eax
80100aa9:	83 e8 01             	sub    $0x1,%eax
80100aac:	a3 80 0f 11 80       	mov    %eax,0x80110f80
      }
      break;
80100ab1:	eb 20                	jmp    80100ad3 <consoleread+0xe2>
    }
    *dst++ = c;
80100ab3:	8b 45 0c             	mov    0xc(%ebp),%eax
80100ab6:	8d 50 01             	lea    0x1(%eax),%edx
80100ab9:	89 55 0c             	mov    %edx,0xc(%ebp)
80100abc:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100abf:	88 10                	mov    %dl,(%eax)
    --n;
80100ac1:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
    if(c == '\n')
80100ac5:	83 7d f0 0a          	cmpl   $0xa,-0x10(%ebp)
80100ac9:	74 0b                	je     80100ad6 <consoleread+0xe5>
  while(n > 0){
80100acb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80100acf:	7f 98                	jg     80100a69 <consoleread+0x78>
80100ad1:	eb 04                	jmp    80100ad7 <consoleread+0xe6>
      break;
80100ad3:	90                   	nop
80100ad4:	eb 01                	jmp    80100ad7 <consoleread+0xe6>
      break;
80100ad6:	90                   	nop
  }
  release(&cons.lock);
80100ad7:	83 ec 0c             	sub    $0xc,%esp
80100ada:	68 a0 0f 11 80       	push   $0x80110fa0
80100adf:	e8 b7 55 00 00       	call   8010609b <release>
80100ae4:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100ae7:	83 ec 0c             	sub    $0xc,%esp
80100aea:	ff 75 08             	push   0x8(%ebp)
80100aed:	e8 28 0f 00 00       	call   80101a1a <ilock>
80100af2:	83 c4 10             	add    $0x10,%esp

  return target - n;
80100af5:	8b 55 10             	mov    0x10(%ebp),%edx
80100af8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100afb:	29 d0                	sub    %edx,%eax
}
80100afd:	c9                   	leave  
80100afe:	c3                   	ret    

80100aff <consolewrite>:

int
consolewrite(struct inode *ip, char *buf, int n)
{
80100aff:	55                   	push   %ebp
80100b00:	89 e5                	mov    %esp,%ebp
80100b02:	83 ec 18             	sub    $0x18,%esp
  int i;

  iunlock(ip);
80100b05:	83 ec 0c             	sub    $0xc,%esp
80100b08:	ff 75 08             	push   0x8(%ebp)
80100b0b:	e8 1d 10 00 00       	call   80101b2d <iunlock>
80100b10:	83 c4 10             	add    $0x10,%esp
  acquire(&cons.lock);
80100b13:	83 ec 0c             	sub    $0xc,%esp
80100b16:	68 a0 0f 11 80       	push   $0x80110fa0
80100b1b:	e8 0d 55 00 00       	call   8010602d <acquire>
80100b20:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100b23:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100b2a:	eb 21                	jmp    80100b4d <consolewrite+0x4e>
    consputc(buf[i] & 0xff);
80100b2c:	8b 55 f4             	mov    -0xc(%ebp),%edx
80100b2f:	8b 45 0c             	mov    0xc(%ebp),%eax
80100b32:	01 d0                	add    %edx,%eax
80100b34:	0f b6 00             	movzbl (%eax),%eax
80100b37:	0f be c0             	movsbl %al,%eax
80100b3a:	0f b6 c0             	movzbl %al,%eax
80100b3d:	83 ec 0c             	sub    $0xc,%esp
80100b40:	50                   	push   %eax
80100b41:	e8 a2 fc ff ff       	call   801007e8 <consputc>
80100b46:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++)
80100b49:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100b4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100b50:	3b 45 10             	cmp    0x10(%ebp),%eax
80100b53:	7c d7                	jl     80100b2c <consolewrite+0x2d>
  release(&cons.lock);
80100b55:	83 ec 0c             	sub    $0xc,%esp
80100b58:	68 a0 0f 11 80       	push   $0x80110fa0
80100b5d:	e8 39 55 00 00       	call   8010609b <release>
80100b62:	83 c4 10             	add    $0x10,%esp
  ilock(ip);
80100b65:	83 ec 0c             	sub    $0xc,%esp
80100b68:	ff 75 08             	push   0x8(%ebp)
80100b6b:	e8 aa 0e 00 00       	call   80101a1a <ilock>
80100b70:	83 c4 10             	add    $0x10,%esp

  return n;
80100b73:	8b 45 10             	mov    0x10(%ebp),%eax
}
80100b76:	c9                   	leave  
80100b77:	c3                   	ret    

80100b78 <consoleinit>:

void
consoleinit(void)
{
80100b78:	55                   	push   %ebp
80100b79:	89 e5                	mov    %esp,%ebp
80100b7b:	83 ec 08             	sub    $0x8,%esp
  initlock(&cons.lock, "console");
80100b7e:	83 ec 08             	sub    $0x8,%esp
80100b81:	68 5e 96 10 80       	push   $0x8010965e
80100b86:	68 a0 0f 11 80       	push   $0x80110fa0
80100b8b:	e8 7b 54 00 00       	call   8010600b <initlock>
80100b90:	83 c4 10             	add    $0x10,%esp

  devsw[CONSOLE].write = consolewrite;
80100b93:	c7 05 ec 0f 11 80 ff 	movl   $0x80100aff,0x80110fec
80100b9a:	0a 10 80 
  devsw[CONSOLE].read = consoleread;
80100b9d:	c7 05 e8 0f 11 80 f1 	movl   $0x801009f1,0x80110fe8
80100ba4:	09 10 80 
  cons.locking = 1;
80100ba7:	c7 05 d4 0f 11 80 01 	movl   $0x1,0x80110fd4
80100bae:	00 00 00 

  ioapicenable(IRQ_KBD, 0);
80100bb1:	83 ec 08             	sub    $0x8,%esp
80100bb4:	6a 00                	push   $0x0
80100bb6:	6a 01                	push   $0x1
80100bb8:	e8 67 1f 00 00       	call   80102b24 <ioapicenable>
80100bbd:	83 c4 10             	add    $0x10,%esp
}
80100bc0:	90                   	nop
80100bc1:	c9                   	leave  
80100bc2:	c3                   	ret    

80100bc3 <exec>:
#include "x86.h"
#include "elf.h"

int
exec(char *path, char **argv)
{
80100bc3:	55                   	push   %ebp
80100bc4:	89 e5                	mov    %esp,%ebp
80100bc6:	81 ec 18 01 00 00    	sub    $0x118,%esp
  uint argc, sz, sp, ustack[3+MAXARG+1];
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pde_t *pgdir, *oldpgdir;
  struct proc *curproc = myproc();
80100bcc:	e8 45 37 00 00       	call   80104316 <myproc>
80100bd1:	89 45 d0             	mov    %eax,-0x30(%ebp)

  begin_op();
80100bd4:	e8 59 29 00 00       	call   80103532 <begin_op>

  if((ip = namei(path)) == 0){
80100bd9:	83 ec 0c             	sub    $0xc,%esp
80100bdc:	ff 75 08             	push   0x8(%ebp)
80100bdf:	e8 69 19 00 00       	call   8010254d <namei>
80100be4:	83 c4 10             	add    $0x10,%esp
80100be7:	89 45 d8             	mov    %eax,-0x28(%ebp)
80100bea:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100bee:	75 1f                	jne    80100c0f <exec+0x4c>
    end_op();
80100bf0:	e8 c9 29 00 00       	call   801035be <end_op>
    cprintf("exec: fail\n");
80100bf5:	83 ec 0c             	sub    $0xc,%esp
80100bf8:	68 66 96 10 80       	push   $0x80109666
80100bfd:	e8 fe f7 ff ff       	call   80100400 <cprintf>
80100c02:	83 c4 10             	add    $0x10,%esp
    return -1;
80100c05:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80100c0a:	e9 f1 03 00 00       	jmp    80101000 <exec+0x43d>
  }
  ilock(ip);
80100c0f:	83 ec 0c             	sub    $0xc,%esp
80100c12:	ff 75 d8             	push   -0x28(%ebp)
80100c15:	e8 00 0e 00 00       	call   80101a1a <ilock>
80100c1a:	83 c4 10             	add    $0x10,%esp
  pgdir = 0;
80100c1d:	c7 45 d4 00 00 00 00 	movl   $0x0,-0x2c(%ebp)

  // Check ELF header
  if(readi(ip, (char*)&elf, 0, sizeof(elf)) != sizeof(elf))
80100c24:	6a 34                	push   $0x34
80100c26:	6a 00                	push   $0x0
80100c28:	8d 85 08 ff ff ff    	lea    -0xf8(%ebp),%eax
80100c2e:	50                   	push   %eax
80100c2f:	ff 75 d8             	push   -0x28(%ebp)
80100c32:	e8 cf 12 00 00       	call   80101f06 <readi>
80100c37:	83 c4 10             	add    $0x10,%esp
80100c3a:	83 f8 34             	cmp    $0x34,%eax
80100c3d:	0f 85 66 03 00 00    	jne    80100fa9 <exec+0x3e6>
    goto bad;
  if(elf.magic != ELF_MAGIC)
80100c43:	8b 85 08 ff ff ff    	mov    -0xf8(%ebp),%eax
80100c49:	3d 7f 45 4c 46       	cmp    $0x464c457f,%eax
80100c4e:	0f 85 58 03 00 00    	jne    80100fac <exec+0x3e9>
    goto bad;

  if((pgdir = setupkvm()) == 0)
80100c54:	e8 49 81 00 00       	call   80108da2 <setupkvm>
80100c59:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80100c5c:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100c60:	0f 84 49 03 00 00    	je     80100faf <exec+0x3ec>
    goto bad;

  // Load program into memory.
  sz = 0;
80100c66:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100c6d:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80100c74:	8b 85 24 ff ff ff    	mov    -0xdc(%ebp),%eax
80100c7a:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100c7d:	e9 de 00 00 00       	jmp    80100d60 <exec+0x19d>
    if(readi(ip, (char*)&ph, off, sizeof(ph)) != sizeof(ph))
80100c82:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100c85:	6a 20                	push   $0x20
80100c87:	50                   	push   %eax
80100c88:	8d 85 e8 fe ff ff    	lea    -0x118(%ebp),%eax
80100c8e:	50                   	push   %eax
80100c8f:	ff 75 d8             	push   -0x28(%ebp)
80100c92:	e8 6f 12 00 00       	call   80101f06 <readi>
80100c97:	83 c4 10             	add    $0x10,%esp
80100c9a:	83 f8 20             	cmp    $0x20,%eax
80100c9d:	0f 85 0f 03 00 00    	jne    80100fb2 <exec+0x3ef>
      goto bad;
    if(ph.type != ELF_PROG_LOAD)
80100ca3:	8b 85 e8 fe ff ff    	mov    -0x118(%ebp),%eax
80100ca9:	83 f8 01             	cmp    $0x1,%eax
80100cac:	0f 85 a0 00 00 00    	jne    80100d52 <exec+0x18f>
      continue;
    if(ph.memsz < ph.filesz)
80100cb2:	8b 95 fc fe ff ff    	mov    -0x104(%ebp),%edx
80100cb8:	8b 85 f8 fe ff ff    	mov    -0x108(%ebp),%eax
80100cbe:	39 c2                	cmp    %eax,%edx
80100cc0:	0f 82 ef 02 00 00    	jb     80100fb5 <exec+0x3f2>
      goto bad;
    if(ph.vaddr + ph.memsz < ph.vaddr)
80100cc6:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
80100ccc:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100cd2:	01 c2                	add    %eax,%edx
80100cd4:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100cda:	39 c2                	cmp    %eax,%edx
80100cdc:	0f 82 d6 02 00 00    	jb     80100fb8 <exec+0x3f5>
      goto bad;
    if((sz = allocuvm(pgdir, sz, ph.vaddr + ph.memsz)) == 0)
80100ce2:	8b 95 f0 fe ff ff    	mov    -0x110(%ebp),%edx
80100ce8:	8b 85 fc fe ff ff    	mov    -0x104(%ebp),%eax
80100cee:	01 d0                	add    %edx,%eax
80100cf0:	83 ec 04             	sub    $0x4,%esp
80100cf3:	50                   	push   %eax
80100cf4:	ff 75 e0             	push   -0x20(%ebp)
80100cf7:	ff 75 d4             	push   -0x2c(%ebp)
80100cfa:	e8 49 84 00 00       	call   80109148 <allocuvm>
80100cff:	83 c4 10             	add    $0x10,%esp
80100d02:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100d05:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100d09:	0f 84 ac 02 00 00    	je     80100fbb <exec+0x3f8>
      goto bad;
    if(ph.vaddr % PGSIZE != 0)
80100d0f:	8b 85 f0 fe ff ff    	mov    -0x110(%ebp),%eax
80100d15:	25 ff 0f 00 00       	and    $0xfff,%eax
80100d1a:	85 c0                	test   %eax,%eax
80100d1c:	0f 85 9c 02 00 00    	jne    80100fbe <exec+0x3fb>
      goto bad;
    if(loaduvm(pgdir, (char*)ph.vaddr, ip, ph.off, ph.filesz) < 0)
80100d22:	8b 95 f8 fe ff ff    	mov    -0x108(%ebp),%edx
80100d28:	8b 85 ec fe ff ff    	mov    -0x114(%ebp),%eax
80100d2e:	8b 8d f0 fe ff ff    	mov    -0x110(%ebp),%ecx
80100d34:	83 ec 0c             	sub    $0xc,%esp
80100d37:	52                   	push   %edx
80100d38:	50                   	push   %eax
80100d39:	ff 75 d8             	push   -0x28(%ebp)
80100d3c:	51                   	push   %ecx
80100d3d:	ff 75 d4             	push   -0x2c(%ebp)
80100d40:	e8 36 83 00 00       	call   8010907b <loaduvm>
80100d45:	83 c4 20             	add    $0x20,%esp
80100d48:	85 c0                	test   %eax,%eax
80100d4a:	0f 88 71 02 00 00    	js     80100fc1 <exec+0x3fe>
80100d50:	eb 01                	jmp    80100d53 <exec+0x190>
      continue;
80100d52:	90                   	nop
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
80100d53:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80100d57:	8b 45 e8             	mov    -0x18(%ebp),%eax
80100d5a:	83 c0 20             	add    $0x20,%eax
80100d5d:	89 45 e8             	mov    %eax,-0x18(%ebp)
80100d60:	0f b7 85 34 ff ff ff 	movzwl -0xcc(%ebp),%eax
80100d67:	0f b7 c0             	movzwl %ax,%eax
80100d6a:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80100d6d:	0f 8c 0f ff ff ff    	jl     80100c82 <exec+0xbf>
      goto bad;
  }
  iunlockput(ip);
80100d73:	83 ec 0c             	sub    $0xc,%esp
80100d76:	ff 75 d8             	push   -0x28(%ebp)
80100d79:	e8 cd 0e 00 00       	call   80101c4b <iunlockput>
80100d7e:	83 c4 10             	add    $0x10,%esp
  end_op();
80100d81:	e8 38 28 00 00       	call   801035be <end_op>
  ip = 0;
80100d86:	c7 45 d8 00 00 00 00 	movl   $0x0,-0x28(%ebp)

  // Allocate two pages at the next page boundary.
  // Make the first inaccessible.  Use the second as the user stack.
  sz = PGROUNDUP(sz);
80100d8d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100d90:	05 ff 0f 00 00       	add    $0xfff,%eax
80100d95:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80100d9a:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if((sz = allocuvm(pgdir, sz, sz + 2*PGSIZE)) == 0)
80100d9d:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100da0:	05 00 20 00 00       	add    $0x2000,%eax
80100da5:	83 ec 04             	sub    $0x4,%esp
80100da8:	50                   	push   %eax
80100da9:	ff 75 e0             	push   -0x20(%ebp)
80100dac:	ff 75 d4             	push   -0x2c(%ebp)
80100daf:	e8 94 83 00 00       	call   80109148 <allocuvm>
80100db4:	83 c4 10             	add    $0x10,%esp
80100db7:	89 45 e0             	mov    %eax,-0x20(%ebp)
80100dba:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
80100dbe:	0f 84 00 02 00 00    	je     80100fc4 <exec+0x401>
    goto bad;
  clearpteu(pgdir, (char*)(sz - 2*PGSIZE));
80100dc4:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100dc7:	2d 00 20 00 00       	sub    $0x2000,%eax
80100dcc:	83 ec 08             	sub    $0x8,%esp
80100dcf:	50                   	push   %eax
80100dd0:	ff 75 d4             	push   -0x2c(%ebp)
80100dd3:	e8 d2 85 00 00       	call   801093aa <clearpteu>
80100dd8:	83 c4 10             	add    $0x10,%esp
  sp = sz;
80100ddb:	8b 45 e0             	mov    -0x20(%ebp),%eax
80100dde:	89 45 dc             	mov    %eax,-0x24(%ebp)

  // Push argument strings, prepare rest of stack in ustack.
  for(argc = 0; argv[argc]; argc++) {
80100de1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80100de8:	e9 96 00 00 00       	jmp    80100e83 <exec+0x2c0>
    if(argc >= MAXARG)
80100ded:	83 7d e4 1f          	cmpl   $0x1f,-0x1c(%ebp)
80100df1:	0f 87 d0 01 00 00    	ja     80100fc7 <exec+0x404>
      goto bad;
    sp = (sp - (strlen(argv[argc]) + 1)) & ~3;
80100df7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100dfa:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e01:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e04:	01 d0                	add    %edx,%eax
80100e06:	8b 00                	mov    (%eax),%eax
80100e08:	83 ec 0c             	sub    $0xc,%esp
80100e0b:	50                   	push   %eax
80100e0c:	e8 f0 56 00 00       	call   80106501 <strlen>
80100e11:	83 c4 10             	add    $0x10,%esp
80100e14:	89 c2                	mov    %eax,%edx
80100e16:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e19:	29 d0                	sub    %edx,%eax
80100e1b:	83 e8 01             	sub    $0x1,%eax
80100e1e:	83 e0 fc             	and    $0xfffffffc,%eax
80100e21:	89 45 dc             	mov    %eax,-0x24(%ebp)
    if(copyout(pgdir, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
80100e24:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e27:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e2e:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e31:	01 d0                	add    %edx,%eax
80100e33:	8b 00                	mov    (%eax),%eax
80100e35:	83 ec 0c             	sub    $0xc,%esp
80100e38:	50                   	push   %eax
80100e39:	e8 c3 56 00 00       	call   80106501 <strlen>
80100e3e:	83 c4 10             	add    $0x10,%esp
80100e41:	83 c0 01             	add    $0x1,%eax
80100e44:	89 c2                	mov    %eax,%edx
80100e46:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e49:	8d 0c 85 00 00 00 00 	lea    0x0(,%eax,4),%ecx
80100e50:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e53:	01 c8                	add    %ecx,%eax
80100e55:	8b 00                	mov    (%eax),%eax
80100e57:	52                   	push   %edx
80100e58:	50                   	push   %eax
80100e59:	ff 75 dc             	push   -0x24(%ebp)
80100e5c:	ff 75 d4             	push   -0x2c(%ebp)
80100e5f:	e8 f2 86 00 00       	call   80109556 <copyout>
80100e64:	83 c4 10             	add    $0x10,%esp
80100e67:	85 c0                	test   %eax,%eax
80100e69:	0f 88 5b 01 00 00    	js     80100fca <exec+0x407>
      goto bad;
    ustack[3+argc] = sp;
80100e6f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e72:	8d 50 03             	lea    0x3(%eax),%edx
80100e75:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100e78:	89 84 95 3c ff ff ff 	mov    %eax,-0xc4(%ebp,%edx,4)
  for(argc = 0; argv[argc]; argc++) {
80100e7f:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80100e83:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e86:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100e8d:	8b 45 0c             	mov    0xc(%ebp),%eax
80100e90:	01 d0                	add    %edx,%eax
80100e92:	8b 00                	mov    (%eax),%eax
80100e94:	85 c0                	test   %eax,%eax
80100e96:	0f 85 51 ff ff ff    	jne    80100ded <exec+0x22a>
  }
  ustack[3+argc] = 0;
80100e9c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100e9f:	83 c0 03             	add    $0x3,%eax
80100ea2:	c7 84 85 3c ff ff ff 	movl   $0x0,-0xc4(%ebp,%eax,4)
80100ea9:	00 00 00 00 

  ustack[0] = 0xffffffff;  // fake return PC
80100ead:	c7 85 3c ff ff ff ff 	movl   $0xffffffff,-0xc4(%ebp)
80100eb4:	ff ff ff 
  ustack[1] = argc;
80100eb7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100eba:	89 85 40 ff ff ff    	mov    %eax,-0xc0(%ebp)
  ustack[2] = sp - (argc+1)*4;  // argv pointer
80100ec0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100ec3:	83 c0 01             	add    $0x1,%eax
80100ec6:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80100ecd:	8b 45 dc             	mov    -0x24(%ebp),%eax
80100ed0:	29 d0                	sub    %edx,%eax
80100ed2:	89 85 44 ff ff ff    	mov    %eax,-0xbc(%ebp)

  sp -= (3+argc+1) * 4;
80100ed8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100edb:	83 c0 04             	add    $0x4,%eax
80100ede:	c1 e0 02             	shl    $0x2,%eax
80100ee1:	29 45 dc             	sub    %eax,-0x24(%ebp)
  if(copyout(pgdir, sp, ustack, (3+argc+1)*4) < 0)
80100ee4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80100ee7:	83 c0 04             	add    $0x4,%eax
80100eea:	c1 e0 02             	shl    $0x2,%eax
80100eed:	50                   	push   %eax
80100eee:	8d 85 3c ff ff ff    	lea    -0xc4(%ebp),%eax
80100ef4:	50                   	push   %eax
80100ef5:	ff 75 dc             	push   -0x24(%ebp)
80100ef8:	ff 75 d4             	push   -0x2c(%ebp)
80100efb:	e8 56 86 00 00       	call   80109556 <copyout>
80100f00:	83 c4 10             	add    $0x10,%esp
80100f03:	85 c0                	test   %eax,%eax
80100f05:	0f 88 c2 00 00 00    	js     80100fcd <exec+0x40a>
    goto bad;

  // Save program name for debugging.
  for(last=s=path; *s; s++)
80100f0b:	8b 45 08             	mov    0x8(%ebp),%eax
80100f0e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100f11:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f14:	89 45 f0             	mov    %eax,-0x10(%ebp)
80100f17:	eb 17                	jmp    80100f30 <exec+0x36d>
    if(*s == '/')
80100f19:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f1c:	0f b6 00             	movzbl (%eax),%eax
80100f1f:	3c 2f                	cmp    $0x2f,%al
80100f21:	75 09                	jne    80100f2c <exec+0x369>
      last = s+1;
80100f23:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f26:	83 c0 01             	add    $0x1,%eax
80100f29:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(last=s=path; *s; s++)
80100f2c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100f30:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100f33:	0f b6 00             	movzbl (%eax),%eax
80100f36:	84 c0                	test   %al,%al
80100f38:	75 df                	jne    80100f19 <exec+0x356>
  safestrcpy(curproc->name, last, sizeof(curproc->name));
80100f3a:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100f3d:	83 c0 6c             	add    $0x6c,%eax
80100f40:	83 ec 04             	sub    $0x4,%esp
80100f43:	6a 10                	push   $0x10
80100f45:	ff 75 f0             	push   -0x10(%ebp)
80100f48:	50                   	push   %eax
80100f49:	e8 68 55 00 00       	call   801064b6 <safestrcpy>
80100f4e:	83 c4 10             	add    $0x10,%esp

  // Commit to the user image.
  oldpgdir = curproc->pgdir;
80100f51:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100f54:	8b 40 04             	mov    0x4(%eax),%eax
80100f57:	89 45 cc             	mov    %eax,-0x34(%ebp)
  curproc->pgdir = pgdir;
80100f5a:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100f5d:	8b 55 d4             	mov    -0x2c(%ebp),%edx
80100f60:	89 50 04             	mov    %edx,0x4(%eax)
  curproc->sz = sz;
80100f63:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100f66:	8b 55 e0             	mov    -0x20(%ebp),%edx
80100f69:	89 10                	mov    %edx,(%eax)
  curproc->tf->eip = elf.entry;  // main
80100f6b:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100f6e:	8b 40 18             	mov    0x18(%eax),%eax
80100f71:	8b 95 20 ff ff ff    	mov    -0xe0(%ebp),%edx
80100f77:	89 50 38             	mov    %edx,0x38(%eax)
  curproc->tf->esp = sp;
80100f7a:	8b 45 d0             	mov    -0x30(%ebp),%eax
80100f7d:	8b 40 18             	mov    0x18(%eax),%eax
80100f80:	8b 55 dc             	mov    -0x24(%ebp),%edx
80100f83:	89 50 44             	mov    %edx,0x44(%eax)
  switchuvm(curproc);
80100f86:	83 ec 0c             	sub    $0xc,%esp
80100f89:	ff 75 d0             	push   -0x30(%ebp)
80100f8c:	e8 db 7e 00 00       	call   80108e6c <switchuvm>
80100f91:	83 c4 10             	add    $0x10,%esp
  freevm(oldpgdir);
80100f94:	83 ec 0c             	sub    $0xc,%esp
80100f97:	ff 75 cc             	push   -0x34(%ebp)
80100f9a:	e8 72 83 00 00       	call   80109311 <freevm>
80100f9f:	83 c4 10             	add    $0x10,%esp
  return 0;
80100fa2:	b8 00 00 00 00       	mov    $0x0,%eax
80100fa7:	eb 57                	jmp    80101000 <exec+0x43d>
    goto bad;
80100fa9:	90                   	nop
80100faa:	eb 22                	jmp    80100fce <exec+0x40b>
    goto bad;
80100fac:	90                   	nop
80100fad:	eb 1f                	jmp    80100fce <exec+0x40b>
    goto bad;
80100faf:	90                   	nop
80100fb0:	eb 1c                	jmp    80100fce <exec+0x40b>
      goto bad;
80100fb2:	90                   	nop
80100fb3:	eb 19                	jmp    80100fce <exec+0x40b>
      goto bad;
80100fb5:	90                   	nop
80100fb6:	eb 16                	jmp    80100fce <exec+0x40b>
      goto bad;
80100fb8:	90                   	nop
80100fb9:	eb 13                	jmp    80100fce <exec+0x40b>
      goto bad;
80100fbb:	90                   	nop
80100fbc:	eb 10                	jmp    80100fce <exec+0x40b>
      goto bad;
80100fbe:	90                   	nop
80100fbf:	eb 0d                	jmp    80100fce <exec+0x40b>
      goto bad;
80100fc1:	90                   	nop
80100fc2:	eb 0a                	jmp    80100fce <exec+0x40b>
    goto bad;
80100fc4:	90                   	nop
80100fc5:	eb 07                	jmp    80100fce <exec+0x40b>
      goto bad;
80100fc7:	90                   	nop
80100fc8:	eb 04                	jmp    80100fce <exec+0x40b>
      goto bad;
80100fca:	90                   	nop
80100fcb:	eb 01                	jmp    80100fce <exec+0x40b>
    goto bad;
80100fcd:	90                   	nop

 bad:
  if(pgdir)
80100fce:	83 7d d4 00          	cmpl   $0x0,-0x2c(%ebp)
80100fd2:	74 0e                	je     80100fe2 <exec+0x41f>
    freevm(pgdir);
80100fd4:	83 ec 0c             	sub    $0xc,%esp
80100fd7:	ff 75 d4             	push   -0x2c(%ebp)
80100fda:	e8 32 83 00 00       	call   80109311 <freevm>
80100fdf:	83 c4 10             	add    $0x10,%esp
  if(ip){
80100fe2:	83 7d d8 00          	cmpl   $0x0,-0x28(%ebp)
80100fe6:	74 13                	je     80100ffb <exec+0x438>
    iunlockput(ip);
80100fe8:	83 ec 0c             	sub    $0xc,%esp
80100feb:	ff 75 d8             	push   -0x28(%ebp)
80100fee:	e8 58 0c 00 00       	call   80101c4b <iunlockput>
80100ff3:	83 c4 10             	add    $0x10,%esp
    end_op();
80100ff6:	e8 c3 25 00 00       	call   801035be <end_op>
  }
  return -1;
80100ffb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80101000:	c9                   	leave  
80101001:	c3                   	ret    

80101002 <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
80101002:	55                   	push   %ebp
80101003:	89 e5                	mov    %esp,%ebp
80101005:	83 ec 08             	sub    $0x8,%esp
  initlock(&ftable.lock, "ftable");
80101008:	83 ec 08             	sub    $0x8,%esp
8010100b:	68 72 96 10 80       	push   $0x80109672
80101010:	68 40 10 11 80       	push   $0x80111040
80101015:	e8 f1 4f 00 00       	call   8010600b <initlock>
8010101a:	83 c4 10             	add    $0x10,%esp
}
8010101d:	90                   	nop
8010101e:	c9                   	leave  
8010101f:	c3                   	ret    

80101020 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
80101020:	55                   	push   %ebp
80101021:	89 e5                	mov    %esp,%ebp
80101023:	83 ec 18             	sub    $0x18,%esp
  struct file *f;

  acquire(&ftable.lock);
80101026:	83 ec 0c             	sub    $0xc,%esp
80101029:	68 40 10 11 80       	push   $0x80111040
8010102e:	e8 fa 4f 00 00       	call   8010602d <acquire>
80101033:	83 c4 10             	add    $0x10,%esp
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101036:	c7 45 f4 74 10 11 80 	movl   $0x80111074,-0xc(%ebp)
8010103d:	eb 2d                	jmp    8010106c <filealloc+0x4c>
    if(f->ref == 0){
8010103f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101042:	8b 40 04             	mov    0x4(%eax),%eax
80101045:	85 c0                	test   %eax,%eax
80101047:	75 1f                	jne    80101068 <filealloc+0x48>
      f->ref = 1;
80101049:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010104c:	c7 40 04 01 00 00 00 	movl   $0x1,0x4(%eax)
      release(&ftable.lock);
80101053:	83 ec 0c             	sub    $0xc,%esp
80101056:	68 40 10 11 80       	push   $0x80111040
8010105b:	e8 3b 50 00 00       	call   8010609b <release>
80101060:	83 c4 10             	add    $0x10,%esp
      return f;
80101063:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101066:	eb 23                	jmp    8010108b <filealloc+0x6b>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101068:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
8010106c:	b8 d4 19 11 80       	mov    $0x801119d4,%eax
80101071:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80101074:	72 c9                	jb     8010103f <filealloc+0x1f>
    }
  }
  release(&ftable.lock);
80101076:	83 ec 0c             	sub    $0xc,%esp
80101079:	68 40 10 11 80       	push   $0x80111040
8010107e:	e8 18 50 00 00       	call   8010609b <release>
80101083:	83 c4 10             	add    $0x10,%esp
  return 0;
80101086:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010108b:	c9                   	leave  
8010108c:	c3                   	ret    

8010108d <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
8010108d:	55                   	push   %ebp
8010108e:	89 e5                	mov    %esp,%ebp
80101090:	83 ec 08             	sub    $0x8,%esp
  acquire(&ftable.lock);
80101093:	83 ec 0c             	sub    $0xc,%esp
80101096:	68 40 10 11 80       	push   $0x80111040
8010109b:	e8 8d 4f 00 00       	call   8010602d <acquire>
801010a0:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
801010a3:	8b 45 08             	mov    0x8(%ebp),%eax
801010a6:	8b 40 04             	mov    0x4(%eax),%eax
801010a9:	85 c0                	test   %eax,%eax
801010ab:	7f 0d                	jg     801010ba <filedup+0x2d>
    panic("filedup");
801010ad:	83 ec 0c             	sub    $0xc,%esp
801010b0:	68 79 96 10 80       	push   $0x80109679
801010b5:	e8 fb f4 ff ff       	call   801005b5 <panic>
  f->ref++;
801010ba:	8b 45 08             	mov    0x8(%ebp),%eax
801010bd:	8b 40 04             	mov    0x4(%eax),%eax
801010c0:	8d 50 01             	lea    0x1(%eax),%edx
801010c3:	8b 45 08             	mov    0x8(%ebp),%eax
801010c6:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
801010c9:	83 ec 0c             	sub    $0xc,%esp
801010cc:	68 40 10 11 80       	push   $0x80111040
801010d1:	e8 c5 4f 00 00       	call   8010609b <release>
801010d6:	83 c4 10             	add    $0x10,%esp
  return f;
801010d9:	8b 45 08             	mov    0x8(%ebp),%eax
}
801010dc:	c9                   	leave  
801010dd:	c3                   	ret    

801010de <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
801010de:	55                   	push   %ebp
801010df:	89 e5                	mov    %esp,%ebp
801010e1:	83 ec 28             	sub    $0x28,%esp
  struct file ff;

  acquire(&ftable.lock);
801010e4:	83 ec 0c             	sub    $0xc,%esp
801010e7:	68 40 10 11 80       	push   $0x80111040
801010ec:	e8 3c 4f 00 00       	call   8010602d <acquire>
801010f1:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
801010f4:	8b 45 08             	mov    0x8(%ebp),%eax
801010f7:	8b 40 04             	mov    0x4(%eax),%eax
801010fa:	85 c0                	test   %eax,%eax
801010fc:	7f 0d                	jg     8010110b <fileclose+0x2d>
    panic("fileclose");
801010fe:	83 ec 0c             	sub    $0xc,%esp
80101101:	68 81 96 10 80       	push   $0x80109681
80101106:	e8 aa f4 ff ff       	call   801005b5 <panic>
  if(--f->ref > 0){
8010110b:	8b 45 08             	mov    0x8(%ebp),%eax
8010110e:	8b 40 04             	mov    0x4(%eax),%eax
80101111:	8d 50 ff             	lea    -0x1(%eax),%edx
80101114:	8b 45 08             	mov    0x8(%ebp),%eax
80101117:	89 50 04             	mov    %edx,0x4(%eax)
8010111a:	8b 45 08             	mov    0x8(%ebp),%eax
8010111d:	8b 40 04             	mov    0x4(%eax),%eax
80101120:	85 c0                	test   %eax,%eax
80101122:	7e 15                	jle    80101139 <fileclose+0x5b>
    release(&ftable.lock);
80101124:	83 ec 0c             	sub    $0xc,%esp
80101127:	68 40 10 11 80       	push   $0x80111040
8010112c:	e8 6a 4f 00 00       	call   8010609b <release>
80101131:	83 c4 10             	add    $0x10,%esp
80101134:	e9 8b 00 00 00       	jmp    801011c4 <fileclose+0xe6>
    return;
  }
  ff = *f;
80101139:	8b 45 08             	mov    0x8(%ebp),%eax
8010113c:	8b 10                	mov    (%eax),%edx
8010113e:	89 55 e0             	mov    %edx,-0x20(%ebp)
80101141:	8b 50 04             	mov    0x4(%eax),%edx
80101144:	89 55 e4             	mov    %edx,-0x1c(%ebp)
80101147:	8b 50 08             	mov    0x8(%eax),%edx
8010114a:	89 55 e8             	mov    %edx,-0x18(%ebp)
8010114d:	8b 50 0c             	mov    0xc(%eax),%edx
80101150:	89 55 ec             	mov    %edx,-0x14(%ebp)
80101153:	8b 50 10             	mov    0x10(%eax),%edx
80101156:	89 55 f0             	mov    %edx,-0x10(%ebp)
80101159:	8b 40 14             	mov    0x14(%eax),%eax
8010115c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  f->ref = 0;
8010115f:	8b 45 08             	mov    0x8(%ebp),%eax
80101162:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  f->type = FD_NONE;
80101169:	8b 45 08             	mov    0x8(%ebp),%eax
8010116c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  release(&ftable.lock);
80101172:	83 ec 0c             	sub    $0xc,%esp
80101175:	68 40 10 11 80       	push   $0x80111040
8010117a:	e8 1c 4f 00 00       	call   8010609b <release>
8010117f:	83 c4 10             	add    $0x10,%esp

  if(ff.type == FD_PIPE)
80101182:	8b 45 e0             	mov    -0x20(%ebp),%eax
80101185:	83 f8 01             	cmp    $0x1,%eax
80101188:	75 19                	jne    801011a3 <fileclose+0xc5>
    pipeclose(ff.pipe, ff.writable);
8010118a:	0f b6 45 e9          	movzbl -0x17(%ebp),%eax
8010118e:	0f be d0             	movsbl %al,%edx
80101191:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101194:	83 ec 08             	sub    $0x8,%esp
80101197:	52                   	push   %edx
80101198:	50                   	push   %eax
80101199:	e8 8a 2d 00 00       	call   80103f28 <pipeclose>
8010119e:	83 c4 10             	add    $0x10,%esp
801011a1:	eb 21                	jmp    801011c4 <fileclose+0xe6>
  else if(ff.type == FD_INODE){
801011a3:	8b 45 e0             	mov    -0x20(%ebp),%eax
801011a6:	83 f8 02             	cmp    $0x2,%eax
801011a9:	75 19                	jne    801011c4 <fileclose+0xe6>
    begin_op();
801011ab:	e8 82 23 00 00       	call   80103532 <begin_op>
    iput(ff.ip);
801011b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801011b3:	83 ec 0c             	sub    $0xc,%esp
801011b6:	50                   	push   %eax
801011b7:	e8 bf 09 00 00       	call   80101b7b <iput>
801011bc:	83 c4 10             	add    $0x10,%esp
    end_op();
801011bf:	e8 fa 23 00 00       	call   801035be <end_op>
  }
}
801011c4:	c9                   	leave  
801011c5:	c3                   	ret    

801011c6 <filestat>:

// Get metadata about file f.
int
filestat(struct file *f, struct stat *st)
{
801011c6:	55                   	push   %ebp
801011c7:	89 e5                	mov    %esp,%ebp
801011c9:	83 ec 08             	sub    $0x8,%esp
  if(f->type == FD_INODE){
801011cc:	8b 45 08             	mov    0x8(%ebp),%eax
801011cf:	8b 00                	mov    (%eax),%eax
801011d1:	83 f8 02             	cmp    $0x2,%eax
801011d4:	75 40                	jne    80101216 <filestat+0x50>
    ilock(f->ip);
801011d6:	8b 45 08             	mov    0x8(%ebp),%eax
801011d9:	8b 40 10             	mov    0x10(%eax),%eax
801011dc:	83 ec 0c             	sub    $0xc,%esp
801011df:	50                   	push   %eax
801011e0:	e8 35 08 00 00       	call   80101a1a <ilock>
801011e5:	83 c4 10             	add    $0x10,%esp
    stati(f->ip, st);
801011e8:	8b 45 08             	mov    0x8(%ebp),%eax
801011eb:	8b 40 10             	mov    0x10(%eax),%eax
801011ee:	83 ec 08             	sub    $0x8,%esp
801011f1:	ff 75 0c             	push   0xc(%ebp)
801011f4:	50                   	push   %eax
801011f5:	e8 c6 0c 00 00       	call   80101ec0 <stati>
801011fa:	83 c4 10             	add    $0x10,%esp
    iunlock(f->ip);
801011fd:	8b 45 08             	mov    0x8(%ebp),%eax
80101200:	8b 40 10             	mov    0x10(%eax),%eax
80101203:	83 ec 0c             	sub    $0xc,%esp
80101206:	50                   	push   %eax
80101207:	e8 21 09 00 00       	call   80101b2d <iunlock>
8010120c:	83 c4 10             	add    $0x10,%esp
    return 0;
8010120f:	b8 00 00 00 00       	mov    $0x0,%eax
80101214:	eb 05                	jmp    8010121b <filestat+0x55>
  }
  return -1;
80101216:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010121b:	c9                   	leave  
8010121c:	c3                   	ret    

8010121d <fileread>:

// Read from file f.
int
fileread(struct file *f, char *addr, int n)
{
8010121d:	55                   	push   %ebp
8010121e:	89 e5                	mov    %esp,%ebp
80101220:	83 ec 18             	sub    $0x18,%esp
  int r;

  if(f->readable == 0)
80101223:	8b 45 08             	mov    0x8(%ebp),%eax
80101226:	0f b6 40 08          	movzbl 0x8(%eax),%eax
8010122a:	84 c0                	test   %al,%al
8010122c:	75 0a                	jne    80101238 <fileread+0x1b>
    return -1;
8010122e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101233:	e9 9b 00 00 00       	jmp    801012d3 <fileread+0xb6>
  if(f->type == FD_PIPE)
80101238:	8b 45 08             	mov    0x8(%ebp),%eax
8010123b:	8b 00                	mov    (%eax),%eax
8010123d:	83 f8 01             	cmp    $0x1,%eax
80101240:	75 1a                	jne    8010125c <fileread+0x3f>
    return piperead(f->pipe, addr, n);
80101242:	8b 45 08             	mov    0x8(%ebp),%eax
80101245:	8b 40 0c             	mov    0xc(%eax),%eax
80101248:	83 ec 04             	sub    $0x4,%esp
8010124b:	ff 75 10             	push   0x10(%ebp)
8010124e:	ff 75 0c             	push   0xc(%ebp)
80101251:	50                   	push   %eax
80101252:	e8 7e 2e 00 00       	call   801040d5 <piperead>
80101257:	83 c4 10             	add    $0x10,%esp
8010125a:	eb 77                	jmp    801012d3 <fileread+0xb6>
  if(f->type == FD_INODE){
8010125c:	8b 45 08             	mov    0x8(%ebp),%eax
8010125f:	8b 00                	mov    (%eax),%eax
80101261:	83 f8 02             	cmp    $0x2,%eax
80101264:	75 60                	jne    801012c6 <fileread+0xa9>
    ilock(f->ip);
80101266:	8b 45 08             	mov    0x8(%ebp),%eax
80101269:	8b 40 10             	mov    0x10(%eax),%eax
8010126c:	83 ec 0c             	sub    $0xc,%esp
8010126f:	50                   	push   %eax
80101270:	e8 a5 07 00 00       	call   80101a1a <ilock>
80101275:	83 c4 10             	add    $0x10,%esp
    if((r = readi(f->ip, addr, f->off, n)) > 0)
80101278:	8b 4d 10             	mov    0x10(%ebp),%ecx
8010127b:	8b 45 08             	mov    0x8(%ebp),%eax
8010127e:	8b 50 14             	mov    0x14(%eax),%edx
80101281:	8b 45 08             	mov    0x8(%ebp),%eax
80101284:	8b 40 10             	mov    0x10(%eax),%eax
80101287:	51                   	push   %ecx
80101288:	52                   	push   %edx
80101289:	ff 75 0c             	push   0xc(%ebp)
8010128c:	50                   	push   %eax
8010128d:	e8 74 0c 00 00       	call   80101f06 <readi>
80101292:	83 c4 10             	add    $0x10,%esp
80101295:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101298:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010129c:	7e 11                	jle    801012af <fileread+0x92>
      f->off += r;
8010129e:	8b 45 08             	mov    0x8(%ebp),%eax
801012a1:	8b 50 14             	mov    0x14(%eax),%edx
801012a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801012a7:	01 c2                	add    %eax,%edx
801012a9:	8b 45 08             	mov    0x8(%ebp),%eax
801012ac:	89 50 14             	mov    %edx,0x14(%eax)
    iunlock(f->ip);
801012af:	8b 45 08             	mov    0x8(%ebp),%eax
801012b2:	8b 40 10             	mov    0x10(%eax),%eax
801012b5:	83 ec 0c             	sub    $0xc,%esp
801012b8:	50                   	push   %eax
801012b9:	e8 6f 08 00 00       	call   80101b2d <iunlock>
801012be:	83 c4 10             	add    $0x10,%esp
    return r;
801012c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801012c4:	eb 0d                	jmp    801012d3 <fileread+0xb6>
  }
  panic("fileread");
801012c6:	83 ec 0c             	sub    $0xc,%esp
801012c9:	68 8b 96 10 80       	push   $0x8010968b
801012ce:	e8 e2 f2 ff ff       	call   801005b5 <panic>
}
801012d3:	c9                   	leave  
801012d4:	c3                   	ret    

801012d5 <filewrite>:

//PAGEBREAK!
// Write to file f.
int
filewrite(struct file *f, char *addr, int n)
{
801012d5:	55                   	push   %ebp
801012d6:	89 e5                	mov    %esp,%ebp
801012d8:	53                   	push   %ebx
801012d9:	83 ec 14             	sub    $0x14,%esp
  int r;

  if(f->writable == 0)
801012dc:	8b 45 08             	mov    0x8(%ebp),%eax
801012df:	0f b6 40 09          	movzbl 0x9(%eax),%eax
801012e3:	84 c0                	test   %al,%al
801012e5:	75 0a                	jne    801012f1 <filewrite+0x1c>
    return -1;
801012e7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801012ec:	e9 1b 01 00 00       	jmp    8010140c <filewrite+0x137>
  if(f->type == FD_PIPE)
801012f1:	8b 45 08             	mov    0x8(%ebp),%eax
801012f4:	8b 00                	mov    (%eax),%eax
801012f6:	83 f8 01             	cmp    $0x1,%eax
801012f9:	75 1d                	jne    80101318 <filewrite+0x43>
    return pipewrite(f->pipe, addr, n);
801012fb:	8b 45 08             	mov    0x8(%ebp),%eax
801012fe:	8b 40 0c             	mov    0xc(%eax),%eax
80101301:	83 ec 04             	sub    $0x4,%esp
80101304:	ff 75 10             	push   0x10(%ebp)
80101307:	ff 75 0c             	push   0xc(%ebp)
8010130a:	50                   	push   %eax
8010130b:	e8 c3 2c 00 00       	call   80103fd3 <pipewrite>
80101310:	83 c4 10             	add    $0x10,%esp
80101313:	e9 f4 00 00 00       	jmp    8010140c <filewrite+0x137>
  if(f->type == FD_INODE){
80101318:	8b 45 08             	mov    0x8(%ebp),%eax
8010131b:	8b 00                	mov    (%eax),%eax
8010131d:	83 f8 02             	cmp    $0x2,%eax
80101320:	0f 85 d9 00 00 00    	jne    801013ff <filewrite+0x12a>
    // the maximum log transaction size, including
    // i-node, indirect block, allocation blocks,
    // and 2 blocks of slop for non-aligned writes.
    // this really belongs lower down, since writei()
    // might be writing a device like the console.
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * 512;
80101326:	c7 45 ec 00 06 00 00 	movl   $0x600,-0x14(%ebp)
    int i = 0;
8010132d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    while(i < n){
80101334:	e9 a3 00 00 00       	jmp    801013dc <filewrite+0x107>
      int n1 = n - i;
80101339:	8b 45 10             	mov    0x10(%ebp),%eax
8010133c:	2b 45 f4             	sub    -0xc(%ebp),%eax
8010133f:	89 45 f0             	mov    %eax,-0x10(%ebp)
      if(n1 > max)
80101342:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101345:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80101348:	7e 06                	jle    80101350 <filewrite+0x7b>
        n1 = max;
8010134a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010134d:	89 45 f0             	mov    %eax,-0x10(%ebp)

      begin_op();
80101350:	e8 dd 21 00 00       	call   80103532 <begin_op>
      ilock(f->ip);
80101355:	8b 45 08             	mov    0x8(%ebp),%eax
80101358:	8b 40 10             	mov    0x10(%eax),%eax
8010135b:	83 ec 0c             	sub    $0xc,%esp
8010135e:	50                   	push   %eax
8010135f:	e8 b6 06 00 00       	call   80101a1a <ilock>
80101364:	83 c4 10             	add    $0x10,%esp
      if ((r = writei(f->ip, addr + i, f->off, n1)) > 0)
80101367:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010136a:	8b 45 08             	mov    0x8(%ebp),%eax
8010136d:	8b 50 14             	mov    0x14(%eax),%edx
80101370:	8b 5d f4             	mov    -0xc(%ebp),%ebx
80101373:	8b 45 0c             	mov    0xc(%ebp),%eax
80101376:	01 c3                	add    %eax,%ebx
80101378:	8b 45 08             	mov    0x8(%ebp),%eax
8010137b:	8b 40 10             	mov    0x10(%eax),%eax
8010137e:	51                   	push   %ecx
8010137f:	52                   	push   %edx
80101380:	53                   	push   %ebx
80101381:	50                   	push   %eax
80101382:	e8 d4 0c 00 00       	call   8010205b <writei>
80101387:	83 c4 10             	add    $0x10,%esp
8010138a:	89 45 e8             	mov    %eax,-0x18(%ebp)
8010138d:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80101391:	7e 11                	jle    801013a4 <filewrite+0xcf>
        f->off += r;
80101393:	8b 45 08             	mov    0x8(%ebp),%eax
80101396:	8b 50 14             	mov    0x14(%eax),%edx
80101399:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010139c:	01 c2                	add    %eax,%edx
8010139e:	8b 45 08             	mov    0x8(%ebp),%eax
801013a1:	89 50 14             	mov    %edx,0x14(%eax)
      iunlock(f->ip);
801013a4:	8b 45 08             	mov    0x8(%ebp),%eax
801013a7:	8b 40 10             	mov    0x10(%eax),%eax
801013aa:	83 ec 0c             	sub    $0xc,%esp
801013ad:	50                   	push   %eax
801013ae:	e8 7a 07 00 00       	call   80101b2d <iunlock>
801013b3:	83 c4 10             	add    $0x10,%esp
      end_op();
801013b6:	e8 03 22 00 00       	call   801035be <end_op>

      if(r < 0)
801013bb:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801013bf:	78 29                	js     801013ea <filewrite+0x115>
        break;
      if(r != n1)
801013c1:	8b 45 e8             	mov    -0x18(%ebp),%eax
801013c4:	3b 45 f0             	cmp    -0x10(%ebp),%eax
801013c7:	74 0d                	je     801013d6 <filewrite+0x101>
        panic("short filewrite");
801013c9:	83 ec 0c             	sub    $0xc,%esp
801013cc:	68 94 96 10 80       	push   $0x80109694
801013d1:	e8 df f1 ff ff       	call   801005b5 <panic>
      i += r;
801013d6:	8b 45 e8             	mov    -0x18(%ebp),%eax
801013d9:	01 45 f4             	add    %eax,-0xc(%ebp)
    while(i < n){
801013dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013df:	3b 45 10             	cmp    0x10(%ebp),%eax
801013e2:	0f 8c 51 ff ff ff    	jl     80101339 <filewrite+0x64>
801013e8:	eb 01                	jmp    801013eb <filewrite+0x116>
        break;
801013ea:	90                   	nop
    }
    return i == n ? n : -1;
801013eb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801013ee:	3b 45 10             	cmp    0x10(%ebp),%eax
801013f1:	75 05                	jne    801013f8 <filewrite+0x123>
801013f3:	8b 45 10             	mov    0x10(%ebp),%eax
801013f6:	eb 14                	jmp    8010140c <filewrite+0x137>
801013f8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801013fd:	eb 0d                	jmp    8010140c <filewrite+0x137>
  }
  panic("filewrite");
801013ff:	83 ec 0c             	sub    $0xc,%esp
80101402:	68 a4 96 10 80       	push   $0x801096a4
80101407:	e8 a9 f1 ff ff       	call   801005b5 <panic>
}
8010140c:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010140f:	c9                   	leave  
80101410:	c3                   	ret    

80101411 <readsb>:
struct superblock sb; 

// Read the super block.
void
readsb(int dev, struct superblock *sb)
{
80101411:	55                   	push   %ebp
80101412:	89 e5                	mov    %esp,%ebp
80101414:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;

  bp = bread(dev, 1);
80101417:	8b 45 08             	mov    0x8(%ebp),%eax
8010141a:	83 ec 08             	sub    $0x8,%esp
8010141d:	6a 01                	push   $0x1
8010141f:	50                   	push   %eax
80101420:	e8 aa ed ff ff       	call   801001cf <bread>
80101425:	83 c4 10             	add    $0x10,%esp
80101428:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memmove(sb, bp->data, sizeof(*sb));
8010142b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010142e:	83 c0 5c             	add    $0x5c,%eax
80101431:	83 ec 04             	sub    $0x4,%esp
80101434:	6a 1c                	push   $0x1c
80101436:	50                   	push   %eax
80101437:	ff 75 0c             	push   0xc(%ebp)
8010143a:	e8 33 4f 00 00       	call   80106372 <memmove>
8010143f:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101442:	83 ec 0c             	sub    $0xc,%esp
80101445:	ff 75 f4             	push   -0xc(%ebp)
80101448:	e8 04 ee ff ff       	call   80100251 <brelse>
8010144d:	83 c4 10             	add    $0x10,%esp
}
80101450:	90                   	nop
80101451:	c9                   	leave  
80101452:	c3                   	ret    

80101453 <bzero>:

// Zero a block.
static void
bzero(int dev, int bno)
{
80101453:	55                   	push   %ebp
80101454:	89 e5                	mov    %esp,%ebp
80101456:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;

  bp = bread(dev, bno);
80101459:	8b 55 0c             	mov    0xc(%ebp),%edx
8010145c:	8b 45 08             	mov    0x8(%ebp),%eax
8010145f:	83 ec 08             	sub    $0x8,%esp
80101462:	52                   	push   %edx
80101463:	50                   	push   %eax
80101464:	e8 66 ed ff ff       	call   801001cf <bread>
80101469:	83 c4 10             	add    $0x10,%esp
8010146c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(bp->data, 0, BSIZE);
8010146f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101472:	83 c0 5c             	add    $0x5c,%eax
80101475:	83 ec 04             	sub    $0x4,%esp
80101478:	68 00 02 00 00       	push   $0x200
8010147d:	6a 00                	push   $0x0
8010147f:	50                   	push   %eax
80101480:	e8 2e 4e 00 00       	call   801062b3 <memset>
80101485:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
80101488:	83 ec 0c             	sub    $0xc,%esp
8010148b:	ff 75 f4             	push   -0xc(%ebp)
8010148e:	e8 d8 22 00 00       	call   8010376b <log_write>
80101493:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101496:	83 ec 0c             	sub    $0xc,%esp
80101499:	ff 75 f4             	push   -0xc(%ebp)
8010149c:	e8 b0 ed ff ff       	call   80100251 <brelse>
801014a1:	83 c4 10             	add    $0x10,%esp
}
801014a4:	90                   	nop
801014a5:	c9                   	leave  
801014a6:	c3                   	ret    

801014a7 <balloc>:
// Blocks.

// Allocate a zeroed disk block.
static uint
balloc(uint dev)
{
801014a7:	55                   	push   %ebp
801014a8:	89 e5                	mov    %esp,%ebp
801014aa:	83 ec 18             	sub    $0x18,%esp
  int b, bi, m;
  struct buf *bp;

  bp = 0;
801014ad:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
  for(b = 0; b < sb.size; b += BPB){
801014b4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801014bb:	e9 0b 01 00 00       	jmp    801015cb <balloc+0x124>
    bp = bread(dev, BBLOCK(b, sb));
801014c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801014c3:	8d 90 ff 0f 00 00    	lea    0xfff(%eax),%edx
801014c9:	85 c0                	test   %eax,%eax
801014cb:	0f 48 c2             	cmovs  %edx,%eax
801014ce:	c1 f8 0c             	sar    $0xc,%eax
801014d1:	89 c2                	mov    %eax,%edx
801014d3:	a1 f8 19 11 80       	mov    0x801119f8,%eax
801014d8:	01 d0                	add    %edx,%eax
801014da:	83 ec 08             	sub    $0x8,%esp
801014dd:	50                   	push   %eax
801014de:	ff 75 08             	push   0x8(%ebp)
801014e1:	e8 e9 ec ff ff       	call   801001cf <bread>
801014e6:	83 c4 10             	add    $0x10,%esp
801014e9:	89 45 ec             	mov    %eax,-0x14(%ebp)
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
801014ec:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
801014f3:	e9 9e 00 00 00       	jmp    80101596 <balloc+0xef>
      m = 1 << (bi % 8);
801014f8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801014fb:	83 e0 07             	and    $0x7,%eax
801014fe:	ba 01 00 00 00       	mov    $0x1,%edx
80101503:	89 c1                	mov    %eax,%ecx
80101505:	d3 e2                	shl    %cl,%edx
80101507:	89 d0                	mov    %edx,%eax
80101509:	89 45 e8             	mov    %eax,-0x18(%ebp)
      if((bp->data[bi/8] & m) == 0){  // Is block free?
8010150c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010150f:	8d 50 07             	lea    0x7(%eax),%edx
80101512:	85 c0                	test   %eax,%eax
80101514:	0f 48 c2             	cmovs  %edx,%eax
80101517:	c1 f8 03             	sar    $0x3,%eax
8010151a:	89 c2                	mov    %eax,%edx
8010151c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010151f:	0f b6 44 10 5c       	movzbl 0x5c(%eax,%edx,1),%eax
80101524:	0f b6 c0             	movzbl %al,%eax
80101527:	23 45 e8             	and    -0x18(%ebp),%eax
8010152a:	85 c0                	test   %eax,%eax
8010152c:	75 64                	jne    80101592 <balloc+0xeb>
        bp->data[bi/8] |= m;  // Mark block in use.
8010152e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101531:	8d 50 07             	lea    0x7(%eax),%edx
80101534:	85 c0                	test   %eax,%eax
80101536:	0f 48 c2             	cmovs  %edx,%eax
80101539:	c1 f8 03             	sar    $0x3,%eax
8010153c:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010153f:	0f b6 54 02 5c       	movzbl 0x5c(%edx,%eax,1),%edx
80101544:	89 d1                	mov    %edx,%ecx
80101546:	8b 55 e8             	mov    -0x18(%ebp),%edx
80101549:	09 ca                	or     %ecx,%edx
8010154b:	89 d1                	mov    %edx,%ecx
8010154d:	8b 55 ec             	mov    -0x14(%ebp),%edx
80101550:	88 4c 02 5c          	mov    %cl,0x5c(%edx,%eax,1)
        log_write(bp);
80101554:	83 ec 0c             	sub    $0xc,%esp
80101557:	ff 75 ec             	push   -0x14(%ebp)
8010155a:	e8 0c 22 00 00       	call   8010376b <log_write>
8010155f:	83 c4 10             	add    $0x10,%esp
        brelse(bp);
80101562:	83 ec 0c             	sub    $0xc,%esp
80101565:	ff 75 ec             	push   -0x14(%ebp)
80101568:	e8 e4 ec ff ff       	call   80100251 <brelse>
8010156d:	83 c4 10             	add    $0x10,%esp
        bzero(dev, b + bi);
80101570:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101573:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101576:	01 c2                	add    %eax,%edx
80101578:	8b 45 08             	mov    0x8(%ebp),%eax
8010157b:	83 ec 08             	sub    $0x8,%esp
8010157e:	52                   	push   %edx
8010157f:	50                   	push   %eax
80101580:	e8 ce fe ff ff       	call   80101453 <bzero>
80101585:	83 c4 10             	add    $0x10,%esp
        return b + bi;
80101588:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010158b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010158e:	01 d0                	add    %edx,%eax
80101590:	eb 57                	jmp    801015e9 <balloc+0x142>
    for(bi = 0; bi < BPB && b + bi < sb.size; bi++){
80101592:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101596:	81 7d f0 ff 0f 00 00 	cmpl   $0xfff,-0x10(%ebp)
8010159d:	7f 17                	jg     801015b6 <balloc+0x10f>
8010159f:	8b 55 f4             	mov    -0xc(%ebp),%edx
801015a2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801015a5:	01 d0                	add    %edx,%eax
801015a7:	89 c2                	mov    %eax,%edx
801015a9:	a1 e0 19 11 80       	mov    0x801119e0,%eax
801015ae:	39 c2                	cmp    %eax,%edx
801015b0:	0f 82 42 ff ff ff    	jb     801014f8 <balloc+0x51>
      }
    }
    brelse(bp);
801015b6:	83 ec 0c             	sub    $0xc,%esp
801015b9:	ff 75 ec             	push   -0x14(%ebp)
801015bc:	e8 90 ec ff ff       	call   80100251 <brelse>
801015c1:	83 c4 10             	add    $0x10,%esp
  for(b = 0; b < sb.size; b += BPB){
801015c4:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801015cb:	8b 15 e0 19 11 80    	mov    0x801119e0,%edx
801015d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801015d4:	39 c2                	cmp    %eax,%edx
801015d6:	0f 87 e4 fe ff ff    	ja     801014c0 <balloc+0x19>
  }
  panic("balloc: out of blocks");
801015dc:	83 ec 0c             	sub    $0xc,%esp
801015df:	68 b0 96 10 80       	push   $0x801096b0
801015e4:	e8 cc ef ff ff       	call   801005b5 <panic>
}
801015e9:	c9                   	leave  
801015ea:	c3                   	ret    

801015eb <bfree>:

// Free a disk block.
static void
bfree(int dev, uint b)
{
801015eb:	55                   	push   %ebp
801015ec:	89 e5                	mov    %esp,%ebp
801015ee:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
801015f1:	8b 45 0c             	mov    0xc(%ebp),%eax
801015f4:	c1 e8 0c             	shr    $0xc,%eax
801015f7:	89 c2                	mov    %eax,%edx
801015f9:	a1 f8 19 11 80       	mov    0x801119f8,%eax
801015fe:	01 c2                	add    %eax,%edx
80101600:	8b 45 08             	mov    0x8(%ebp),%eax
80101603:	83 ec 08             	sub    $0x8,%esp
80101606:	52                   	push   %edx
80101607:	50                   	push   %eax
80101608:	e8 c2 eb ff ff       	call   801001cf <bread>
8010160d:	83 c4 10             	add    $0x10,%esp
80101610:	89 45 f4             	mov    %eax,-0xc(%ebp)
  bi = b % BPB;
80101613:	8b 45 0c             	mov    0xc(%ebp),%eax
80101616:	25 ff 0f 00 00       	and    $0xfff,%eax
8010161b:	89 45 f0             	mov    %eax,-0x10(%ebp)
  m = 1 << (bi % 8);
8010161e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101621:	83 e0 07             	and    $0x7,%eax
80101624:	ba 01 00 00 00       	mov    $0x1,%edx
80101629:	89 c1                	mov    %eax,%ecx
8010162b:	d3 e2                	shl    %cl,%edx
8010162d:	89 d0                	mov    %edx,%eax
8010162f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if((bp->data[bi/8] & m) == 0)
80101632:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101635:	8d 50 07             	lea    0x7(%eax),%edx
80101638:	85 c0                	test   %eax,%eax
8010163a:	0f 48 c2             	cmovs  %edx,%eax
8010163d:	c1 f8 03             	sar    $0x3,%eax
80101640:	89 c2                	mov    %eax,%edx
80101642:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101645:	0f b6 44 10 5c       	movzbl 0x5c(%eax,%edx,1),%eax
8010164a:	0f b6 c0             	movzbl %al,%eax
8010164d:	23 45 ec             	and    -0x14(%ebp),%eax
80101650:	85 c0                	test   %eax,%eax
80101652:	75 0d                	jne    80101661 <bfree+0x76>
    panic("freeing free block");
80101654:	83 ec 0c             	sub    $0xc,%esp
80101657:	68 c6 96 10 80       	push   $0x801096c6
8010165c:	e8 54 ef ff ff       	call   801005b5 <panic>
  bp->data[bi/8] &= ~m;
80101661:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101664:	8d 50 07             	lea    0x7(%eax),%edx
80101667:	85 c0                	test   %eax,%eax
80101669:	0f 48 c2             	cmovs  %edx,%eax
8010166c:	c1 f8 03             	sar    $0x3,%eax
8010166f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101672:	0f b6 54 02 5c       	movzbl 0x5c(%edx,%eax,1),%edx
80101677:	89 d1                	mov    %edx,%ecx
80101679:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010167c:	f7 d2                	not    %edx
8010167e:	21 ca                	and    %ecx,%edx
80101680:	89 d1                	mov    %edx,%ecx
80101682:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101685:	88 4c 02 5c          	mov    %cl,0x5c(%edx,%eax,1)
  log_write(bp);
80101689:	83 ec 0c             	sub    $0xc,%esp
8010168c:	ff 75 f4             	push   -0xc(%ebp)
8010168f:	e8 d7 20 00 00       	call   8010376b <log_write>
80101694:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
80101697:	83 ec 0c             	sub    $0xc,%esp
8010169a:	ff 75 f4             	push   -0xc(%ebp)
8010169d:	e8 af eb ff ff       	call   80100251 <brelse>
801016a2:	83 c4 10             	add    $0x10,%esp
}
801016a5:	90                   	nop
801016a6:	c9                   	leave  
801016a7:	c3                   	ret    

801016a8 <iinit>:
  struct inode inode[NINODE];
} icache;

void
iinit(int dev)
{
801016a8:	55                   	push   %ebp
801016a9:	89 e5                	mov    %esp,%ebp
801016ab:	57                   	push   %edi
801016ac:	56                   	push   %esi
801016ad:	53                   	push   %ebx
801016ae:	83 ec 2c             	sub    $0x2c,%esp
  int i = 0;
801016b1:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  
  initlock(&icache.lock, "icache");
801016b8:	83 ec 08             	sub    $0x8,%esp
801016bb:	68 d9 96 10 80       	push   $0x801096d9
801016c0:	68 00 1a 11 80       	push   $0x80111a00
801016c5:	e8 41 49 00 00       	call   8010600b <initlock>
801016ca:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NINODE; i++) {
801016cd:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
801016d4:	eb 2d                	jmp    80101703 <iinit+0x5b>
    initsleeplock(&icache.inode[i].lock, "inode");
801016d6:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801016d9:	89 d0                	mov    %edx,%eax
801016db:	c1 e0 03             	shl    $0x3,%eax
801016de:	01 d0                	add    %edx,%eax
801016e0:	c1 e0 04             	shl    $0x4,%eax
801016e3:	83 c0 30             	add    $0x30,%eax
801016e6:	05 00 1a 11 80       	add    $0x80111a00,%eax
801016eb:	83 c0 10             	add    $0x10,%eax
801016ee:	83 ec 08             	sub    $0x8,%esp
801016f1:	68 e0 96 10 80       	push   $0x801096e0
801016f6:	50                   	push   %eax
801016f7:	e8 8c 47 00 00       	call   80105e88 <initsleeplock>
801016fc:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NINODE; i++) {
801016ff:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80101703:	83 7d e4 31          	cmpl   $0x31,-0x1c(%ebp)
80101707:	7e cd                	jle    801016d6 <iinit+0x2e>
  }

  readsb(dev, &sb);
80101709:	83 ec 08             	sub    $0x8,%esp
8010170c:	68 e0 19 11 80       	push   $0x801119e0
80101711:	ff 75 08             	push   0x8(%ebp)
80101714:	e8 f8 fc ff ff       	call   80101411 <readsb>
80101719:	83 c4 10             	add    $0x10,%esp
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010171c:	a1 f8 19 11 80       	mov    0x801119f8,%eax
80101721:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80101724:	8b 3d f4 19 11 80    	mov    0x801119f4,%edi
8010172a:	8b 35 f0 19 11 80    	mov    0x801119f0,%esi
80101730:	8b 1d ec 19 11 80    	mov    0x801119ec,%ebx
80101736:	8b 0d e8 19 11 80    	mov    0x801119e8,%ecx
8010173c:	8b 15 e4 19 11 80    	mov    0x801119e4,%edx
80101742:	a1 e0 19 11 80       	mov    0x801119e0,%eax
80101747:	ff 75 d4             	push   -0x2c(%ebp)
8010174a:	57                   	push   %edi
8010174b:	56                   	push   %esi
8010174c:	53                   	push   %ebx
8010174d:	51                   	push   %ecx
8010174e:	52                   	push   %edx
8010174f:	50                   	push   %eax
80101750:	68 e8 96 10 80       	push   $0x801096e8
80101755:	e8 a6 ec ff ff       	call   80100400 <cprintf>
8010175a:	83 c4 20             	add    $0x20,%esp
 inodestart %d bmap start %d\n", sb.size, sb.nblocks,
          sb.ninodes, sb.nlog, sb.logstart, sb.inodestart,
          sb.bmapstart);
}
8010175d:	90                   	nop
8010175e:	8d 65 f4             	lea    -0xc(%ebp),%esp
80101761:	5b                   	pop    %ebx
80101762:	5e                   	pop    %esi
80101763:	5f                   	pop    %edi
80101764:	5d                   	pop    %ebp
80101765:	c3                   	ret    

80101766 <ialloc>:
// Allocate an inode on device dev.
// Mark it as allocated by  giving it type type.
// Returns an unlocked but allocated and referenced inode.
struct inode*
ialloc(uint dev, short type)
{
80101766:	55                   	push   %ebp
80101767:	89 e5                	mov    %esp,%ebp
80101769:	83 ec 28             	sub    $0x28,%esp
8010176c:	8b 45 0c             	mov    0xc(%ebp),%eax
8010176f:	66 89 45 e4          	mov    %ax,-0x1c(%ebp)
  int inum;
  struct buf *bp;
  struct dinode *dip;

  for(inum = 1; inum < sb.ninodes; inum++){
80101773:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
8010177a:	e9 9e 00 00 00       	jmp    8010181d <ialloc+0xb7>
    bp = bread(dev, IBLOCK(inum, sb));
8010177f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101782:	c1 e8 03             	shr    $0x3,%eax
80101785:	89 c2                	mov    %eax,%edx
80101787:	a1 f4 19 11 80       	mov    0x801119f4,%eax
8010178c:	01 d0                	add    %edx,%eax
8010178e:	83 ec 08             	sub    $0x8,%esp
80101791:	50                   	push   %eax
80101792:	ff 75 08             	push   0x8(%ebp)
80101795:	e8 35 ea ff ff       	call   801001cf <bread>
8010179a:	83 c4 10             	add    $0x10,%esp
8010179d:	89 45 f0             	mov    %eax,-0x10(%ebp)
    dip = (struct dinode*)bp->data + inum%IPB;
801017a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801017a3:	8d 50 5c             	lea    0x5c(%eax),%edx
801017a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017a9:	83 e0 07             	and    $0x7,%eax
801017ac:	c1 e0 06             	shl    $0x6,%eax
801017af:	01 d0                	add    %edx,%eax
801017b1:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if(dip->type == 0){  // a free inode
801017b4:	8b 45 ec             	mov    -0x14(%ebp),%eax
801017b7:	0f b7 00             	movzwl (%eax),%eax
801017ba:	66 85 c0             	test   %ax,%ax
801017bd:	75 4c                	jne    8010180b <ialloc+0xa5>
      memset(dip, 0, sizeof(*dip));
801017bf:	83 ec 04             	sub    $0x4,%esp
801017c2:	6a 40                	push   $0x40
801017c4:	6a 00                	push   $0x0
801017c6:	ff 75 ec             	push   -0x14(%ebp)
801017c9:	e8 e5 4a 00 00       	call   801062b3 <memset>
801017ce:	83 c4 10             	add    $0x10,%esp
      dip->type = type;
801017d1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801017d4:	0f b7 55 e4          	movzwl -0x1c(%ebp),%edx
801017d8:	66 89 10             	mov    %dx,(%eax)
      log_write(bp);   // mark it allocated on the disk
801017db:	83 ec 0c             	sub    $0xc,%esp
801017de:	ff 75 f0             	push   -0x10(%ebp)
801017e1:	e8 85 1f 00 00       	call   8010376b <log_write>
801017e6:	83 c4 10             	add    $0x10,%esp
      brelse(bp);
801017e9:	83 ec 0c             	sub    $0xc,%esp
801017ec:	ff 75 f0             	push   -0x10(%ebp)
801017ef:	e8 5d ea ff ff       	call   80100251 <brelse>
801017f4:	83 c4 10             	add    $0x10,%esp
      return iget(dev, inum);
801017f7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801017fa:	83 ec 08             	sub    $0x8,%esp
801017fd:	50                   	push   %eax
801017fe:	ff 75 08             	push   0x8(%ebp)
80101801:	e8 f8 00 00 00       	call   801018fe <iget>
80101806:	83 c4 10             	add    $0x10,%esp
80101809:	eb 30                	jmp    8010183b <ialloc+0xd5>
    }
    brelse(bp);
8010180b:	83 ec 0c             	sub    $0xc,%esp
8010180e:	ff 75 f0             	push   -0x10(%ebp)
80101811:	e8 3b ea ff ff       	call   80100251 <brelse>
80101816:	83 c4 10             	add    $0x10,%esp
  for(inum = 1; inum < sb.ninodes; inum++){
80101819:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010181d:	8b 15 e8 19 11 80    	mov    0x801119e8,%edx
80101823:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101826:	39 c2                	cmp    %eax,%edx
80101828:	0f 87 51 ff ff ff    	ja     8010177f <ialloc+0x19>
  }
  panic("ialloc: no inodes");
8010182e:	83 ec 0c             	sub    $0xc,%esp
80101831:	68 3b 97 10 80       	push   $0x8010973b
80101836:	e8 7a ed ff ff       	call   801005b5 <panic>
}
8010183b:	c9                   	leave  
8010183c:	c3                   	ret    

8010183d <iupdate>:
// Must be called after every change to an ip->xxx field
// that lives on disk, since i-node cache is write-through.
// Caller must hold ip->lock.
void
iupdate(struct inode *ip)
{
8010183d:	55                   	push   %ebp
8010183e:	89 e5                	mov    %esp,%ebp
80101840:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101843:	8b 45 08             	mov    0x8(%ebp),%eax
80101846:	8b 40 04             	mov    0x4(%eax),%eax
80101849:	c1 e8 03             	shr    $0x3,%eax
8010184c:	89 c2                	mov    %eax,%edx
8010184e:	a1 f4 19 11 80       	mov    0x801119f4,%eax
80101853:	01 c2                	add    %eax,%edx
80101855:	8b 45 08             	mov    0x8(%ebp),%eax
80101858:	8b 00                	mov    (%eax),%eax
8010185a:	83 ec 08             	sub    $0x8,%esp
8010185d:	52                   	push   %edx
8010185e:	50                   	push   %eax
8010185f:	e8 6b e9 ff ff       	call   801001cf <bread>
80101864:	83 c4 10             	add    $0x10,%esp
80101867:	89 45 f4             	mov    %eax,-0xc(%ebp)
  dip = (struct dinode*)bp->data + ip->inum%IPB;
8010186a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010186d:	8d 50 5c             	lea    0x5c(%eax),%edx
80101870:	8b 45 08             	mov    0x8(%ebp),%eax
80101873:	8b 40 04             	mov    0x4(%eax),%eax
80101876:	83 e0 07             	and    $0x7,%eax
80101879:	c1 e0 06             	shl    $0x6,%eax
8010187c:	01 d0                	add    %edx,%eax
8010187e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  dip->type = ip->type;
80101881:	8b 45 08             	mov    0x8(%ebp),%eax
80101884:	0f b7 50 50          	movzwl 0x50(%eax),%edx
80101888:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010188b:	66 89 10             	mov    %dx,(%eax)
  dip->major = ip->major;
8010188e:	8b 45 08             	mov    0x8(%ebp),%eax
80101891:	0f b7 50 52          	movzwl 0x52(%eax),%edx
80101895:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101898:	66 89 50 02          	mov    %dx,0x2(%eax)
  dip->minor = ip->minor;
8010189c:	8b 45 08             	mov    0x8(%ebp),%eax
8010189f:	0f b7 50 54          	movzwl 0x54(%eax),%edx
801018a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018a6:	66 89 50 04          	mov    %dx,0x4(%eax)
  dip->nlink = ip->nlink;
801018aa:	8b 45 08             	mov    0x8(%ebp),%eax
801018ad:	0f b7 50 56          	movzwl 0x56(%eax),%edx
801018b1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018b4:	66 89 50 06          	mov    %dx,0x6(%eax)
  dip->size = ip->size;
801018b8:	8b 45 08             	mov    0x8(%ebp),%eax
801018bb:	8b 50 58             	mov    0x58(%eax),%edx
801018be:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018c1:	89 50 08             	mov    %edx,0x8(%eax)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs));
801018c4:	8b 45 08             	mov    0x8(%ebp),%eax
801018c7:	8d 50 5c             	lea    0x5c(%eax),%edx
801018ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
801018cd:	83 c0 0c             	add    $0xc,%eax
801018d0:	83 ec 04             	sub    $0x4,%esp
801018d3:	6a 34                	push   $0x34
801018d5:	52                   	push   %edx
801018d6:	50                   	push   %eax
801018d7:	e8 96 4a 00 00       	call   80106372 <memmove>
801018dc:	83 c4 10             	add    $0x10,%esp
  log_write(bp);
801018df:	83 ec 0c             	sub    $0xc,%esp
801018e2:	ff 75 f4             	push   -0xc(%ebp)
801018e5:	e8 81 1e 00 00       	call   8010376b <log_write>
801018ea:	83 c4 10             	add    $0x10,%esp
  brelse(bp);
801018ed:	83 ec 0c             	sub    $0xc,%esp
801018f0:	ff 75 f4             	push   -0xc(%ebp)
801018f3:	e8 59 e9 ff ff       	call   80100251 <brelse>
801018f8:	83 c4 10             	add    $0x10,%esp
}
801018fb:	90                   	nop
801018fc:	c9                   	leave  
801018fd:	c3                   	ret    

801018fe <iget>:
// Find the inode with number inum on device dev
// and return the in-memory copy. Does not lock
// the inode and does not read it from disk.
static struct inode*
iget(uint dev, uint inum)
{
801018fe:	55                   	push   %ebp
801018ff:	89 e5                	mov    %esp,%ebp
80101901:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *empty;

  acquire(&icache.lock);
80101904:	83 ec 0c             	sub    $0xc,%esp
80101907:	68 00 1a 11 80       	push   $0x80111a00
8010190c:	e8 1c 47 00 00       	call   8010602d <acquire>
80101911:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
80101914:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010191b:	c7 45 f4 34 1a 11 80 	movl   $0x80111a34,-0xc(%ebp)
80101922:	eb 60                	jmp    80101984 <iget+0x86>
    if(ip->ref > 0 && ip->dev == dev && ip->inum == inum){
80101924:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101927:	8b 40 08             	mov    0x8(%eax),%eax
8010192a:	85 c0                	test   %eax,%eax
8010192c:	7e 39                	jle    80101967 <iget+0x69>
8010192e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101931:	8b 00                	mov    (%eax),%eax
80101933:	39 45 08             	cmp    %eax,0x8(%ebp)
80101936:	75 2f                	jne    80101967 <iget+0x69>
80101938:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010193b:	8b 40 04             	mov    0x4(%eax),%eax
8010193e:	39 45 0c             	cmp    %eax,0xc(%ebp)
80101941:	75 24                	jne    80101967 <iget+0x69>
      ip->ref++;
80101943:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101946:	8b 40 08             	mov    0x8(%eax),%eax
80101949:	8d 50 01             	lea    0x1(%eax),%edx
8010194c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010194f:	89 50 08             	mov    %edx,0x8(%eax)
      release(&icache.lock);
80101952:	83 ec 0c             	sub    $0xc,%esp
80101955:	68 00 1a 11 80       	push   $0x80111a00
8010195a:	e8 3c 47 00 00       	call   8010609b <release>
8010195f:	83 c4 10             	add    $0x10,%esp
      return ip;
80101962:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101965:	eb 77                	jmp    801019de <iget+0xe0>
    }
    if(empty == 0 && ip->ref == 0)    // Remember empty slot.
80101967:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010196b:	75 10                	jne    8010197d <iget+0x7f>
8010196d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101970:	8b 40 08             	mov    0x8(%eax),%eax
80101973:	85 c0                	test   %eax,%eax
80101975:	75 06                	jne    8010197d <iget+0x7f>
      empty = ip;
80101977:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010197a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010197d:	81 45 f4 90 00 00 00 	addl   $0x90,-0xc(%ebp)
80101984:	81 7d f4 54 36 11 80 	cmpl   $0x80113654,-0xc(%ebp)
8010198b:	72 97                	jb     80101924 <iget+0x26>
  }

  // Recycle an inode cache entry.
  if(empty == 0)
8010198d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101991:	75 0d                	jne    801019a0 <iget+0xa2>
    panic("iget: no inodes");
80101993:	83 ec 0c             	sub    $0xc,%esp
80101996:	68 4d 97 10 80       	push   $0x8010974d
8010199b:	e8 15 ec ff ff       	call   801005b5 <panic>

  ip = empty;
801019a0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801019a3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  ip->dev = dev;
801019a6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019a9:	8b 55 08             	mov    0x8(%ebp),%edx
801019ac:	89 10                	mov    %edx,(%eax)
  ip->inum = inum;
801019ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019b1:	8b 55 0c             	mov    0xc(%ebp),%edx
801019b4:	89 50 04             	mov    %edx,0x4(%eax)
  ip->ref = 1;
801019b7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019ba:	c7 40 08 01 00 00 00 	movl   $0x1,0x8(%eax)
  ip->valid = 0;
801019c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801019c4:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
  release(&icache.lock);
801019cb:	83 ec 0c             	sub    $0xc,%esp
801019ce:	68 00 1a 11 80       	push   $0x80111a00
801019d3:	e8 c3 46 00 00       	call   8010609b <release>
801019d8:	83 c4 10             	add    $0x10,%esp

  return ip;
801019db:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801019de:	c9                   	leave  
801019df:	c3                   	ret    

801019e0 <idup>:

// Increment reference count for ip.
// Returns ip to enable ip = idup(ip1) idiom.
struct inode*
idup(struct inode *ip)
{
801019e0:	55                   	push   %ebp
801019e1:	89 e5                	mov    %esp,%ebp
801019e3:	83 ec 08             	sub    $0x8,%esp
  acquire(&icache.lock);
801019e6:	83 ec 0c             	sub    $0xc,%esp
801019e9:	68 00 1a 11 80       	push   $0x80111a00
801019ee:	e8 3a 46 00 00       	call   8010602d <acquire>
801019f3:	83 c4 10             	add    $0x10,%esp
  ip->ref++;
801019f6:	8b 45 08             	mov    0x8(%ebp),%eax
801019f9:	8b 40 08             	mov    0x8(%eax),%eax
801019fc:	8d 50 01             	lea    0x1(%eax),%edx
801019ff:	8b 45 08             	mov    0x8(%ebp),%eax
80101a02:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101a05:	83 ec 0c             	sub    $0xc,%esp
80101a08:	68 00 1a 11 80       	push   $0x80111a00
80101a0d:	e8 89 46 00 00       	call   8010609b <release>
80101a12:	83 c4 10             	add    $0x10,%esp
  return ip;
80101a15:	8b 45 08             	mov    0x8(%ebp),%eax
}
80101a18:	c9                   	leave  
80101a19:	c3                   	ret    

80101a1a <ilock>:

// Lock the given inode.
// Reads the inode from disk if necessary.
void
ilock(struct inode *ip)
{
80101a1a:	55                   	push   %ebp
80101a1b:	89 e5                	mov    %esp,%ebp
80101a1d:	83 ec 18             	sub    $0x18,%esp
  struct buf *bp;
  struct dinode *dip;

  if(ip == 0 || ip->ref < 1)
80101a20:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101a24:	74 0a                	je     80101a30 <ilock+0x16>
80101a26:	8b 45 08             	mov    0x8(%ebp),%eax
80101a29:	8b 40 08             	mov    0x8(%eax),%eax
80101a2c:	85 c0                	test   %eax,%eax
80101a2e:	7f 0d                	jg     80101a3d <ilock+0x23>
    panic("ilock");
80101a30:	83 ec 0c             	sub    $0xc,%esp
80101a33:	68 5d 97 10 80       	push   $0x8010975d
80101a38:	e8 78 eb ff ff       	call   801005b5 <panic>

  acquiresleep(&ip->lock);
80101a3d:	8b 45 08             	mov    0x8(%ebp),%eax
80101a40:	83 c0 0c             	add    $0xc,%eax
80101a43:	83 ec 0c             	sub    $0xc,%esp
80101a46:	50                   	push   %eax
80101a47:	e8 78 44 00 00       	call   80105ec4 <acquiresleep>
80101a4c:	83 c4 10             	add    $0x10,%esp

  if(ip->valid == 0){
80101a4f:	8b 45 08             	mov    0x8(%ebp),%eax
80101a52:	8b 40 4c             	mov    0x4c(%eax),%eax
80101a55:	85 c0                	test   %eax,%eax
80101a57:	0f 85 cd 00 00 00    	jne    80101b2a <ilock+0x110>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
80101a5d:	8b 45 08             	mov    0x8(%ebp),%eax
80101a60:	8b 40 04             	mov    0x4(%eax),%eax
80101a63:	c1 e8 03             	shr    $0x3,%eax
80101a66:	89 c2                	mov    %eax,%edx
80101a68:	a1 f4 19 11 80       	mov    0x801119f4,%eax
80101a6d:	01 c2                	add    %eax,%edx
80101a6f:	8b 45 08             	mov    0x8(%ebp),%eax
80101a72:	8b 00                	mov    (%eax),%eax
80101a74:	83 ec 08             	sub    $0x8,%esp
80101a77:	52                   	push   %edx
80101a78:	50                   	push   %eax
80101a79:	e8 51 e7 ff ff       	call   801001cf <bread>
80101a7e:	83 c4 10             	add    $0x10,%esp
80101a81:	89 45 f4             	mov    %eax,-0xc(%ebp)
    dip = (struct dinode*)bp->data + ip->inum%IPB;
80101a84:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101a87:	8d 50 5c             	lea    0x5c(%eax),%edx
80101a8a:	8b 45 08             	mov    0x8(%ebp),%eax
80101a8d:	8b 40 04             	mov    0x4(%eax),%eax
80101a90:	83 e0 07             	and    $0x7,%eax
80101a93:	c1 e0 06             	shl    $0x6,%eax
80101a96:	01 d0                	add    %edx,%eax
80101a98:	89 45 f0             	mov    %eax,-0x10(%ebp)
    ip->type = dip->type;
80101a9b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101a9e:	0f b7 10             	movzwl (%eax),%edx
80101aa1:	8b 45 08             	mov    0x8(%ebp),%eax
80101aa4:	66 89 50 50          	mov    %dx,0x50(%eax)
    ip->major = dip->major;
80101aa8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101aab:	0f b7 50 02          	movzwl 0x2(%eax),%edx
80101aaf:	8b 45 08             	mov    0x8(%ebp),%eax
80101ab2:	66 89 50 52          	mov    %dx,0x52(%eax)
    ip->minor = dip->minor;
80101ab6:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ab9:	0f b7 50 04          	movzwl 0x4(%eax),%edx
80101abd:	8b 45 08             	mov    0x8(%ebp),%eax
80101ac0:	66 89 50 54          	mov    %dx,0x54(%eax)
    ip->nlink = dip->nlink;
80101ac4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ac7:	0f b7 50 06          	movzwl 0x6(%eax),%edx
80101acb:	8b 45 08             	mov    0x8(%ebp),%eax
80101ace:	66 89 50 56          	mov    %dx,0x56(%eax)
    ip->size = dip->size;
80101ad2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ad5:	8b 50 08             	mov    0x8(%eax),%edx
80101ad8:	8b 45 08             	mov    0x8(%ebp),%eax
80101adb:	89 50 58             	mov    %edx,0x58(%eax)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
80101ade:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101ae1:	8d 50 0c             	lea    0xc(%eax),%edx
80101ae4:	8b 45 08             	mov    0x8(%ebp),%eax
80101ae7:	83 c0 5c             	add    $0x5c,%eax
80101aea:	83 ec 04             	sub    $0x4,%esp
80101aed:	6a 34                	push   $0x34
80101aef:	52                   	push   %edx
80101af0:	50                   	push   %eax
80101af1:	e8 7c 48 00 00       	call   80106372 <memmove>
80101af6:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80101af9:	83 ec 0c             	sub    $0xc,%esp
80101afc:	ff 75 f4             	push   -0xc(%ebp)
80101aff:	e8 4d e7 ff ff       	call   80100251 <brelse>
80101b04:	83 c4 10             	add    $0x10,%esp
    ip->valid = 1;
80101b07:	8b 45 08             	mov    0x8(%ebp),%eax
80101b0a:	c7 40 4c 01 00 00 00 	movl   $0x1,0x4c(%eax)
    if(ip->type == 0)
80101b11:	8b 45 08             	mov    0x8(%ebp),%eax
80101b14:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80101b18:	66 85 c0             	test   %ax,%ax
80101b1b:	75 0d                	jne    80101b2a <ilock+0x110>
      panic("ilock: no type");
80101b1d:	83 ec 0c             	sub    $0xc,%esp
80101b20:	68 63 97 10 80       	push   $0x80109763
80101b25:	e8 8b ea ff ff       	call   801005b5 <panic>
  }
}
80101b2a:	90                   	nop
80101b2b:	c9                   	leave  
80101b2c:	c3                   	ret    

80101b2d <iunlock>:

// Unlock the given inode.
void
iunlock(struct inode *ip)
{
80101b2d:	55                   	push   %ebp
80101b2e:	89 e5                	mov    %esp,%ebp
80101b30:	83 ec 08             	sub    $0x8,%esp
  if(ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
80101b33:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80101b37:	74 20                	je     80101b59 <iunlock+0x2c>
80101b39:	8b 45 08             	mov    0x8(%ebp),%eax
80101b3c:	83 c0 0c             	add    $0xc,%eax
80101b3f:	83 ec 0c             	sub    $0xc,%esp
80101b42:	50                   	push   %eax
80101b43:	e8 2e 44 00 00       	call   80105f76 <holdingsleep>
80101b48:	83 c4 10             	add    $0x10,%esp
80101b4b:	85 c0                	test   %eax,%eax
80101b4d:	74 0a                	je     80101b59 <iunlock+0x2c>
80101b4f:	8b 45 08             	mov    0x8(%ebp),%eax
80101b52:	8b 40 08             	mov    0x8(%eax),%eax
80101b55:	85 c0                	test   %eax,%eax
80101b57:	7f 0d                	jg     80101b66 <iunlock+0x39>
    panic("iunlock");
80101b59:	83 ec 0c             	sub    $0xc,%esp
80101b5c:	68 72 97 10 80       	push   $0x80109772
80101b61:	e8 4f ea ff ff       	call   801005b5 <panic>

  releasesleep(&ip->lock);
80101b66:	8b 45 08             	mov    0x8(%ebp),%eax
80101b69:	83 c0 0c             	add    $0xc,%eax
80101b6c:	83 ec 0c             	sub    $0xc,%esp
80101b6f:	50                   	push   %eax
80101b70:	e8 b3 43 00 00       	call   80105f28 <releasesleep>
80101b75:	83 c4 10             	add    $0x10,%esp
}
80101b78:	90                   	nop
80101b79:	c9                   	leave  
80101b7a:	c3                   	ret    

80101b7b <iput>:
// to it, free the inode (and its content) on disk.
// All calls to iput() must be inside a transaction in
// case it has to free the inode.
void
iput(struct inode *ip)
{
80101b7b:	55                   	push   %ebp
80101b7c:	89 e5                	mov    %esp,%ebp
80101b7e:	83 ec 18             	sub    $0x18,%esp
  acquiresleep(&ip->lock);
80101b81:	8b 45 08             	mov    0x8(%ebp),%eax
80101b84:	83 c0 0c             	add    $0xc,%eax
80101b87:	83 ec 0c             	sub    $0xc,%esp
80101b8a:	50                   	push   %eax
80101b8b:	e8 34 43 00 00       	call   80105ec4 <acquiresleep>
80101b90:	83 c4 10             	add    $0x10,%esp
  if(ip->valid && ip->nlink == 0){
80101b93:	8b 45 08             	mov    0x8(%ebp),%eax
80101b96:	8b 40 4c             	mov    0x4c(%eax),%eax
80101b99:	85 c0                	test   %eax,%eax
80101b9b:	74 6a                	je     80101c07 <iput+0x8c>
80101b9d:	8b 45 08             	mov    0x8(%ebp),%eax
80101ba0:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80101ba4:	66 85 c0             	test   %ax,%ax
80101ba7:	75 5e                	jne    80101c07 <iput+0x8c>
    acquire(&icache.lock);
80101ba9:	83 ec 0c             	sub    $0xc,%esp
80101bac:	68 00 1a 11 80       	push   $0x80111a00
80101bb1:	e8 77 44 00 00       	call   8010602d <acquire>
80101bb6:	83 c4 10             	add    $0x10,%esp
    int r = ip->ref;
80101bb9:	8b 45 08             	mov    0x8(%ebp),%eax
80101bbc:	8b 40 08             	mov    0x8(%eax),%eax
80101bbf:	89 45 f4             	mov    %eax,-0xc(%ebp)
    release(&icache.lock);
80101bc2:	83 ec 0c             	sub    $0xc,%esp
80101bc5:	68 00 1a 11 80       	push   $0x80111a00
80101bca:	e8 cc 44 00 00       	call   8010609b <release>
80101bcf:	83 c4 10             	add    $0x10,%esp
    if(r == 1){
80101bd2:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
80101bd6:	75 2f                	jne    80101c07 <iput+0x8c>
      // inode has no links and no other references: truncate and free.
      itrunc(ip);
80101bd8:	83 ec 0c             	sub    $0xc,%esp
80101bdb:	ff 75 08             	push   0x8(%ebp)
80101bde:	e8 ad 01 00 00       	call   80101d90 <itrunc>
80101be3:	83 c4 10             	add    $0x10,%esp
      ip->type = 0;
80101be6:	8b 45 08             	mov    0x8(%ebp),%eax
80101be9:	66 c7 40 50 00 00    	movw   $0x0,0x50(%eax)
      iupdate(ip);
80101bef:	83 ec 0c             	sub    $0xc,%esp
80101bf2:	ff 75 08             	push   0x8(%ebp)
80101bf5:	e8 43 fc ff ff       	call   8010183d <iupdate>
80101bfa:	83 c4 10             	add    $0x10,%esp
      ip->valid = 0;
80101bfd:	8b 45 08             	mov    0x8(%ebp),%eax
80101c00:	c7 40 4c 00 00 00 00 	movl   $0x0,0x4c(%eax)
    }
  }
  releasesleep(&ip->lock);
80101c07:	8b 45 08             	mov    0x8(%ebp),%eax
80101c0a:	83 c0 0c             	add    $0xc,%eax
80101c0d:	83 ec 0c             	sub    $0xc,%esp
80101c10:	50                   	push   %eax
80101c11:	e8 12 43 00 00       	call   80105f28 <releasesleep>
80101c16:	83 c4 10             	add    $0x10,%esp

  acquire(&icache.lock);
80101c19:	83 ec 0c             	sub    $0xc,%esp
80101c1c:	68 00 1a 11 80       	push   $0x80111a00
80101c21:	e8 07 44 00 00       	call   8010602d <acquire>
80101c26:	83 c4 10             	add    $0x10,%esp
  ip->ref--;
80101c29:	8b 45 08             	mov    0x8(%ebp),%eax
80101c2c:	8b 40 08             	mov    0x8(%eax),%eax
80101c2f:	8d 50 ff             	lea    -0x1(%eax),%edx
80101c32:	8b 45 08             	mov    0x8(%ebp),%eax
80101c35:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101c38:	83 ec 0c             	sub    $0xc,%esp
80101c3b:	68 00 1a 11 80       	push   $0x80111a00
80101c40:	e8 56 44 00 00       	call   8010609b <release>
80101c45:	83 c4 10             	add    $0x10,%esp
}
80101c48:	90                   	nop
80101c49:	c9                   	leave  
80101c4a:	c3                   	ret    

80101c4b <iunlockput>:

// Common idiom: unlock, then put.
void
iunlockput(struct inode *ip)
{
80101c4b:	55                   	push   %ebp
80101c4c:	89 e5                	mov    %esp,%ebp
80101c4e:	83 ec 08             	sub    $0x8,%esp
  iunlock(ip);
80101c51:	83 ec 0c             	sub    $0xc,%esp
80101c54:	ff 75 08             	push   0x8(%ebp)
80101c57:	e8 d1 fe ff ff       	call   80101b2d <iunlock>
80101c5c:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80101c5f:	83 ec 0c             	sub    $0xc,%esp
80101c62:	ff 75 08             	push   0x8(%ebp)
80101c65:	e8 11 ff ff ff       	call   80101b7b <iput>
80101c6a:	83 c4 10             	add    $0x10,%esp
}
80101c6d:	90                   	nop
80101c6e:	c9                   	leave  
80101c6f:	c3                   	ret    

80101c70 <bmap>:

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn)
{
80101c70:	55                   	push   %ebp
80101c71:	89 e5                	mov    %esp,%ebp
80101c73:	83 ec 18             	sub    $0x18,%esp
  uint addr, *a;
  struct buf *bp;

  if(bn < NDIRECT){
80101c76:	83 7d 0c 0b          	cmpl   $0xb,0xc(%ebp)
80101c7a:	77 42                	ja     80101cbe <bmap+0x4e>
    if((addr = ip->addrs[bn]) == 0)
80101c7c:	8b 45 08             	mov    0x8(%ebp),%eax
80101c7f:	8b 55 0c             	mov    0xc(%ebp),%edx
80101c82:	83 c2 14             	add    $0x14,%edx
80101c85:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101c89:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101c8c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101c90:	75 24                	jne    80101cb6 <bmap+0x46>
      ip->addrs[bn] = addr = balloc(ip->dev);
80101c92:	8b 45 08             	mov    0x8(%ebp),%eax
80101c95:	8b 00                	mov    (%eax),%eax
80101c97:	83 ec 0c             	sub    $0xc,%esp
80101c9a:	50                   	push   %eax
80101c9b:	e8 07 f8 ff ff       	call   801014a7 <balloc>
80101ca0:	83 c4 10             	add    $0x10,%esp
80101ca3:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101ca6:	8b 45 08             	mov    0x8(%ebp),%eax
80101ca9:	8b 55 0c             	mov    0xc(%ebp),%edx
80101cac:	8d 4a 14             	lea    0x14(%edx),%ecx
80101caf:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101cb2:	89 54 88 0c          	mov    %edx,0xc(%eax,%ecx,4)
    return addr;
80101cb6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101cb9:	e9 d0 00 00 00       	jmp    80101d8e <bmap+0x11e>
  }
  bn -= NDIRECT;
80101cbe:	83 6d 0c 0c          	subl   $0xc,0xc(%ebp)

  if(bn < NINDIRECT){
80101cc2:	83 7d 0c 7f          	cmpl   $0x7f,0xc(%ebp)
80101cc6:	0f 87 b5 00 00 00    	ja     80101d81 <bmap+0x111>
    // Load indirect block, allocating if necessary.
    if((addr = ip->addrs[NDIRECT]) == 0)
80101ccc:	8b 45 08             	mov    0x8(%ebp),%eax
80101ccf:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101cd5:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101cd8:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101cdc:	75 20                	jne    80101cfe <bmap+0x8e>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
80101cde:	8b 45 08             	mov    0x8(%ebp),%eax
80101ce1:	8b 00                	mov    (%eax),%eax
80101ce3:	83 ec 0c             	sub    $0xc,%esp
80101ce6:	50                   	push   %eax
80101ce7:	e8 bb f7 ff ff       	call   801014a7 <balloc>
80101cec:	83 c4 10             	add    $0x10,%esp
80101cef:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101cf2:	8b 45 08             	mov    0x8(%ebp),%eax
80101cf5:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101cf8:	89 90 8c 00 00 00    	mov    %edx,0x8c(%eax)
    bp = bread(ip->dev, addr);
80101cfe:	8b 45 08             	mov    0x8(%ebp),%eax
80101d01:	8b 00                	mov    (%eax),%eax
80101d03:	83 ec 08             	sub    $0x8,%esp
80101d06:	ff 75 f4             	push   -0xc(%ebp)
80101d09:	50                   	push   %eax
80101d0a:	e8 c0 e4 ff ff       	call   801001cf <bread>
80101d0f:	83 c4 10             	add    $0x10,%esp
80101d12:	89 45 f0             	mov    %eax,-0x10(%ebp)
    a = (uint*)bp->data;
80101d15:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101d18:	83 c0 5c             	add    $0x5c,%eax
80101d1b:	89 45 ec             	mov    %eax,-0x14(%ebp)
    if((addr = a[bn]) == 0){
80101d1e:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d21:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101d28:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d2b:	01 d0                	add    %edx,%eax
80101d2d:	8b 00                	mov    (%eax),%eax
80101d2f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101d32:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80101d36:	75 36                	jne    80101d6e <bmap+0xfe>
      a[bn] = addr = balloc(ip->dev);
80101d38:	8b 45 08             	mov    0x8(%ebp),%eax
80101d3b:	8b 00                	mov    (%eax),%eax
80101d3d:	83 ec 0c             	sub    $0xc,%esp
80101d40:	50                   	push   %eax
80101d41:	e8 61 f7 ff ff       	call   801014a7 <balloc>
80101d46:	83 c4 10             	add    $0x10,%esp
80101d49:	89 45 f4             	mov    %eax,-0xc(%ebp)
80101d4c:	8b 45 0c             	mov    0xc(%ebp),%eax
80101d4f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101d56:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101d59:	01 c2                	add    %eax,%edx
80101d5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d5e:	89 02                	mov    %eax,(%edx)
      log_write(bp);
80101d60:	83 ec 0c             	sub    $0xc,%esp
80101d63:	ff 75 f0             	push   -0x10(%ebp)
80101d66:	e8 00 1a 00 00       	call   8010376b <log_write>
80101d6b:	83 c4 10             	add    $0x10,%esp
    }
    brelse(bp);
80101d6e:	83 ec 0c             	sub    $0xc,%esp
80101d71:	ff 75 f0             	push   -0x10(%ebp)
80101d74:	e8 d8 e4 ff ff       	call   80100251 <brelse>
80101d79:	83 c4 10             	add    $0x10,%esp
    return addr;
80101d7c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101d7f:	eb 0d                	jmp    80101d8e <bmap+0x11e>
  }

  panic("bmap: out of range");
80101d81:	83 ec 0c             	sub    $0xc,%esp
80101d84:	68 7a 97 10 80       	push   $0x8010977a
80101d89:	e8 27 e8 ff ff       	call   801005b5 <panic>
}
80101d8e:	c9                   	leave  
80101d8f:	c3                   	ret    

80101d90 <itrunc>:
// to it (no directory entries referring to it)
// and has no in-memory reference to it (is
// not an open file or current directory).
static void
itrunc(struct inode *ip)
{
80101d90:	55                   	push   %ebp
80101d91:	89 e5                	mov    %esp,%ebp
80101d93:	83 ec 18             	sub    $0x18,%esp
  int i, j;
  struct buf *bp;
  uint *a;

  for(i = 0; i < NDIRECT; i++){
80101d96:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101d9d:	eb 45                	jmp    80101de4 <itrunc+0x54>
    if(ip->addrs[i]){
80101d9f:	8b 45 08             	mov    0x8(%ebp),%eax
80101da2:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101da5:	83 c2 14             	add    $0x14,%edx
80101da8:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101dac:	85 c0                	test   %eax,%eax
80101dae:	74 30                	je     80101de0 <itrunc+0x50>
      bfree(ip->dev, ip->addrs[i]);
80101db0:	8b 45 08             	mov    0x8(%ebp),%eax
80101db3:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101db6:	83 c2 14             	add    $0x14,%edx
80101db9:	8b 44 90 0c          	mov    0xc(%eax,%edx,4),%eax
80101dbd:	8b 55 08             	mov    0x8(%ebp),%edx
80101dc0:	8b 12                	mov    (%edx),%edx
80101dc2:	83 ec 08             	sub    $0x8,%esp
80101dc5:	50                   	push   %eax
80101dc6:	52                   	push   %edx
80101dc7:	e8 1f f8 ff ff       	call   801015eb <bfree>
80101dcc:	83 c4 10             	add    $0x10,%esp
      ip->addrs[i] = 0;
80101dcf:	8b 45 08             	mov    0x8(%ebp),%eax
80101dd2:	8b 55 f4             	mov    -0xc(%ebp),%edx
80101dd5:	83 c2 14             	add    $0x14,%edx
80101dd8:	c7 44 90 0c 00 00 00 	movl   $0x0,0xc(%eax,%edx,4)
80101ddf:	00 
  for(i = 0; i < NDIRECT; i++){
80101de0:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80101de4:	83 7d f4 0b          	cmpl   $0xb,-0xc(%ebp)
80101de8:	7e b5                	jle    80101d9f <itrunc+0xf>
    }
  }

  if(ip->addrs[NDIRECT]){
80101dea:	8b 45 08             	mov    0x8(%ebp),%eax
80101ded:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101df3:	85 c0                	test   %eax,%eax
80101df5:	0f 84 aa 00 00 00    	je     80101ea5 <itrunc+0x115>
    bp = bread(ip->dev, ip->addrs[NDIRECT]);
80101dfb:	8b 45 08             	mov    0x8(%ebp),%eax
80101dfe:	8b 90 8c 00 00 00    	mov    0x8c(%eax),%edx
80101e04:	8b 45 08             	mov    0x8(%ebp),%eax
80101e07:	8b 00                	mov    (%eax),%eax
80101e09:	83 ec 08             	sub    $0x8,%esp
80101e0c:	52                   	push   %edx
80101e0d:	50                   	push   %eax
80101e0e:	e8 bc e3 ff ff       	call   801001cf <bread>
80101e13:	83 c4 10             	add    $0x10,%esp
80101e16:	89 45 ec             	mov    %eax,-0x14(%ebp)
    a = (uint*)bp->data;
80101e19:	8b 45 ec             	mov    -0x14(%ebp),%eax
80101e1c:	83 c0 5c             	add    $0x5c,%eax
80101e1f:	89 45 e8             	mov    %eax,-0x18(%ebp)
    for(j = 0; j < NINDIRECT; j++){
80101e22:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80101e29:	eb 3c                	jmp    80101e67 <itrunc+0xd7>
      if(a[j])
80101e2b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e2e:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101e35:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101e38:	01 d0                	add    %edx,%eax
80101e3a:	8b 00                	mov    (%eax),%eax
80101e3c:	85 c0                	test   %eax,%eax
80101e3e:	74 23                	je     80101e63 <itrunc+0xd3>
        bfree(ip->dev, a[j]);
80101e40:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e43:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80101e4a:	8b 45 e8             	mov    -0x18(%ebp),%eax
80101e4d:	01 d0                	add    %edx,%eax
80101e4f:	8b 00                	mov    (%eax),%eax
80101e51:	8b 55 08             	mov    0x8(%ebp),%edx
80101e54:	8b 12                	mov    (%edx),%edx
80101e56:	83 ec 08             	sub    $0x8,%esp
80101e59:	50                   	push   %eax
80101e5a:	52                   	push   %edx
80101e5b:	e8 8b f7 ff ff       	call   801015eb <bfree>
80101e60:	83 c4 10             	add    $0x10,%esp
    for(j = 0; j < NINDIRECT; j++){
80101e63:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80101e67:	8b 45 f0             	mov    -0x10(%ebp),%eax
80101e6a:	83 f8 7f             	cmp    $0x7f,%eax
80101e6d:	76 bc                	jbe    80101e2b <itrunc+0x9b>
    }
    brelse(bp);
80101e6f:	83 ec 0c             	sub    $0xc,%esp
80101e72:	ff 75 ec             	push   -0x14(%ebp)
80101e75:	e8 d7 e3 ff ff       	call   80100251 <brelse>
80101e7a:	83 c4 10             	add    $0x10,%esp
    bfree(ip->dev, ip->addrs[NDIRECT]);
80101e7d:	8b 45 08             	mov    0x8(%ebp),%eax
80101e80:	8b 80 8c 00 00 00    	mov    0x8c(%eax),%eax
80101e86:	8b 55 08             	mov    0x8(%ebp),%edx
80101e89:	8b 12                	mov    (%edx),%edx
80101e8b:	83 ec 08             	sub    $0x8,%esp
80101e8e:	50                   	push   %eax
80101e8f:	52                   	push   %edx
80101e90:	e8 56 f7 ff ff       	call   801015eb <bfree>
80101e95:	83 c4 10             	add    $0x10,%esp
    ip->addrs[NDIRECT] = 0;
80101e98:	8b 45 08             	mov    0x8(%ebp),%eax
80101e9b:	c7 80 8c 00 00 00 00 	movl   $0x0,0x8c(%eax)
80101ea2:	00 00 00 
  }

  ip->size = 0;
80101ea5:	8b 45 08             	mov    0x8(%ebp),%eax
80101ea8:	c7 40 58 00 00 00 00 	movl   $0x0,0x58(%eax)
  iupdate(ip);
80101eaf:	83 ec 0c             	sub    $0xc,%esp
80101eb2:	ff 75 08             	push   0x8(%ebp)
80101eb5:	e8 83 f9 ff ff       	call   8010183d <iupdate>
80101eba:	83 c4 10             	add    $0x10,%esp
}
80101ebd:	90                   	nop
80101ebe:	c9                   	leave  
80101ebf:	c3                   	ret    

80101ec0 <stati>:

// Copy stat information from inode.
// Caller must hold ip->lock.
void
stati(struct inode *ip, struct stat *st)
{
80101ec0:	55                   	push   %ebp
80101ec1:	89 e5                	mov    %esp,%ebp
  st->dev = ip->dev;
80101ec3:	8b 45 08             	mov    0x8(%ebp),%eax
80101ec6:	8b 00                	mov    (%eax),%eax
80101ec8:	89 c2                	mov    %eax,%edx
80101eca:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ecd:	89 50 04             	mov    %edx,0x4(%eax)
  st->ino = ip->inum;
80101ed0:	8b 45 08             	mov    0x8(%ebp),%eax
80101ed3:	8b 50 04             	mov    0x4(%eax),%edx
80101ed6:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ed9:	89 50 08             	mov    %edx,0x8(%eax)
  st->type = ip->type;
80101edc:	8b 45 08             	mov    0x8(%ebp),%eax
80101edf:	0f b7 50 50          	movzwl 0x50(%eax),%edx
80101ee3:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ee6:	66 89 10             	mov    %dx,(%eax)
  st->nlink = ip->nlink;
80101ee9:	8b 45 08             	mov    0x8(%ebp),%eax
80101eec:	0f b7 50 56          	movzwl 0x56(%eax),%edx
80101ef0:	8b 45 0c             	mov    0xc(%ebp),%eax
80101ef3:	66 89 50 0c          	mov    %dx,0xc(%eax)
  st->size = ip->size;
80101ef7:	8b 45 08             	mov    0x8(%ebp),%eax
80101efa:	8b 50 58             	mov    0x58(%eax),%edx
80101efd:	8b 45 0c             	mov    0xc(%ebp),%eax
80101f00:	89 50 10             	mov    %edx,0x10(%eax)
}
80101f03:	90                   	nop
80101f04:	5d                   	pop    %ebp
80101f05:	c3                   	ret    

80101f06 <readi>:
//PAGEBREAK!
// Read data from inode.
// Caller must hold ip->lock.
int
readi(struct inode *ip, char *dst, uint off, uint n)
{
80101f06:	55                   	push   %ebp
80101f07:	89 e5                	mov    %esp,%ebp
80101f09:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80101f0c:	8b 45 08             	mov    0x8(%ebp),%eax
80101f0f:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80101f13:	66 83 f8 03          	cmp    $0x3,%ax
80101f17:	75 5c                	jne    80101f75 <readi+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].read)
80101f19:	8b 45 08             	mov    0x8(%ebp),%eax
80101f1c:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101f20:	66 85 c0             	test   %ax,%ax
80101f23:	78 20                	js     80101f45 <readi+0x3f>
80101f25:	8b 45 08             	mov    0x8(%ebp),%eax
80101f28:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101f2c:	66 83 f8 09          	cmp    $0x9,%ax
80101f30:	7f 13                	jg     80101f45 <readi+0x3f>
80101f32:	8b 45 08             	mov    0x8(%ebp),%eax
80101f35:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101f39:	98                   	cwtl   
80101f3a:	8b 04 c5 e0 0f 11 80 	mov    -0x7feef020(,%eax,8),%eax
80101f41:	85 c0                	test   %eax,%eax
80101f43:	75 0a                	jne    80101f4f <readi+0x49>
      return -1;
80101f45:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f4a:	e9 0a 01 00 00       	jmp    80102059 <readi+0x153>
    return devsw[ip->major].read(ip, dst, n);
80101f4f:	8b 45 08             	mov    0x8(%ebp),%eax
80101f52:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101f56:	98                   	cwtl   
80101f57:	8b 04 c5 e0 0f 11 80 	mov    -0x7feef020(,%eax,8),%eax
80101f5e:	8b 55 14             	mov    0x14(%ebp),%edx
80101f61:	83 ec 04             	sub    $0x4,%esp
80101f64:	52                   	push   %edx
80101f65:	ff 75 0c             	push   0xc(%ebp)
80101f68:	ff 75 08             	push   0x8(%ebp)
80101f6b:	ff d0                	call   *%eax
80101f6d:	83 c4 10             	add    $0x10,%esp
80101f70:	e9 e4 00 00 00       	jmp    80102059 <readi+0x153>
  }

  if(off > ip->size || off + n < off)
80101f75:	8b 45 08             	mov    0x8(%ebp),%eax
80101f78:	8b 40 58             	mov    0x58(%eax),%eax
80101f7b:	39 45 10             	cmp    %eax,0x10(%ebp)
80101f7e:	77 0d                	ja     80101f8d <readi+0x87>
80101f80:	8b 55 10             	mov    0x10(%ebp),%edx
80101f83:	8b 45 14             	mov    0x14(%ebp),%eax
80101f86:	01 d0                	add    %edx,%eax
80101f88:	39 45 10             	cmp    %eax,0x10(%ebp)
80101f8b:	76 0a                	jbe    80101f97 <readi+0x91>
    return -1;
80101f8d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f92:	e9 c2 00 00 00       	jmp    80102059 <readi+0x153>
  if(off + n > ip->size)
80101f97:	8b 55 10             	mov    0x10(%ebp),%edx
80101f9a:	8b 45 14             	mov    0x14(%ebp),%eax
80101f9d:	01 c2                	add    %eax,%edx
80101f9f:	8b 45 08             	mov    0x8(%ebp),%eax
80101fa2:	8b 40 58             	mov    0x58(%eax),%eax
80101fa5:	39 c2                	cmp    %eax,%edx
80101fa7:	76 0c                	jbe    80101fb5 <readi+0xaf>
    n = ip->size - off;
80101fa9:	8b 45 08             	mov    0x8(%ebp),%eax
80101fac:	8b 40 58             	mov    0x58(%eax),%eax
80101faf:	2b 45 10             	sub    0x10(%ebp),%eax
80101fb2:	89 45 14             	mov    %eax,0x14(%ebp)

  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80101fb5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80101fbc:	e9 89 00 00 00       	jmp    8010204a <readi+0x144>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80101fc1:	8b 45 10             	mov    0x10(%ebp),%eax
80101fc4:	c1 e8 09             	shr    $0x9,%eax
80101fc7:	83 ec 08             	sub    $0x8,%esp
80101fca:	50                   	push   %eax
80101fcb:	ff 75 08             	push   0x8(%ebp)
80101fce:	e8 9d fc ff ff       	call   80101c70 <bmap>
80101fd3:	83 c4 10             	add    $0x10,%esp
80101fd6:	8b 55 08             	mov    0x8(%ebp),%edx
80101fd9:	8b 12                	mov    (%edx),%edx
80101fdb:	83 ec 08             	sub    $0x8,%esp
80101fde:	50                   	push   %eax
80101fdf:	52                   	push   %edx
80101fe0:	e8 ea e1 ff ff       	call   801001cf <bread>
80101fe5:	83 c4 10             	add    $0x10,%esp
80101fe8:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
80101feb:	8b 45 10             	mov    0x10(%ebp),%eax
80101fee:	25 ff 01 00 00       	and    $0x1ff,%eax
80101ff3:	ba 00 02 00 00       	mov    $0x200,%edx
80101ff8:	29 c2                	sub    %eax,%edx
80101ffa:	8b 45 14             	mov    0x14(%ebp),%eax
80101ffd:	2b 45 f4             	sub    -0xc(%ebp),%eax
80102000:	39 c2                	cmp    %eax,%edx
80102002:	0f 46 c2             	cmovbe %edx,%eax
80102005:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dst, bp->data + off%BSIZE, m);
80102008:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010200b:	8d 50 5c             	lea    0x5c(%eax),%edx
8010200e:	8b 45 10             	mov    0x10(%ebp),%eax
80102011:	25 ff 01 00 00       	and    $0x1ff,%eax
80102016:	01 d0                	add    %edx,%eax
80102018:	83 ec 04             	sub    $0x4,%esp
8010201b:	ff 75 ec             	push   -0x14(%ebp)
8010201e:	50                   	push   %eax
8010201f:	ff 75 0c             	push   0xc(%ebp)
80102022:	e8 4b 43 00 00       	call   80106372 <memmove>
80102027:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
8010202a:	83 ec 0c             	sub    $0xc,%esp
8010202d:	ff 75 f0             	push   -0x10(%ebp)
80102030:	e8 1c e2 ff ff       	call   80100251 <brelse>
80102035:	83 c4 10             	add    $0x10,%esp
  for(tot=0; tot<n; tot+=m, off+=m, dst+=m){
80102038:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010203b:	01 45 f4             	add    %eax,-0xc(%ebp)
8010203e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102041:	01 45 10             	add    %eax,0x10(%ebp)
80102044:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102047:	01 45 0c             	add    %eax,0xc(%ebp)
8010204a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010204d:	3b 45 14             	cmp    0x14(%ebp),%eax
80102050:	0f 82 6b ff ff ff    	jb     80101fc1 <readi+0xbb>
  }
  return n;
80102056:	8b 45 14             	mov    0x14(%ebp),%eax
}
80102059:	c9                   	leave  
8010205a:	c3                   	ret    

8010205b <writei>:
// PAGEBREAK!
// Write data to inode.
// Caller must hold ip->lock.
int
writei(struct inode *ip, char *src, uint off, uint n)
{
8010205b:	55                   	push   %ebp
8010205c:	89 e5                	mov    %esp,%ebp
8010205e:	83 ec 18             	sub    $0x18,%esp
  uint tot, m;
  struct buf *bp;

  if(ip->type == T_DEV){
80102061:	8b 45 08             	mov    0x8(%ebp),%eax
80102064:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80102068:	66 83 f8 03          	cmp    $0x3,%ax
8010206c:	75 5c                	jne    801020ca <writei+0x6f>
    if(ip->major < 0 || ip->major >= NDEV || !devsw[ip->major].write)
8010206e:	8b 45 08             	mov    0x8(%ebp),%eax
80102071:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80102075:	66 85 c0             	test   %ax,%ax
80102078:	78 20                	js     8010209a <writei+0x3f>
8010207a:	8b 45 08             	mov    0x8(%ebp),%eax
8010207d:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80102081:	66 83 f8 09          	cmp    $0x9,%ax
80102085:	7f 13                	jg     8010209a <writei+0x3f>
80102087:	8b 45 08             	mov    0x8(%ebp),%eax
8010208a:	0f b7 40 52          	movzwl 0x52(%eax),%eax
8010208e:	98                   	cwtl   
8010208f:	8b 04 c5 e4 0f 11 80 	mov    -0x7feef01c(,%eax,8),%eax
80102096:	85 c0                	test   %eax,%eax
80102098:	75 0a                	jne    801020a4 <writei+0x49>
      return -1;
8010209a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010209f:	e9 3b 01 00 00       	jmp    801021df <writei+0x184>
    return devsw[ip->major].write(ip, src, n);
801020a4:	8b 45 08             	mov    0x8(%ebp),%eax
801020a7:	0f b7 40 52          	movzwl 0x52(%eax),%eax
801020ab:	98                   	cwtl   
801020ac:	8b 04 c5 e4 0f 11 80 	mov    -0x7feef01c(,%eax,8),%eax
801020b3:	8b 55 14             	mov    0x14(%ebp),%edx
801020b6:	83 ec 04             	sub    $0x4,%esp
801020b9:	52                   	push   %edx
801020ba:	ff 75 0c             	push   0xc(%ebp)
801020bd:	ff 75 08             	push   0x8(%ebp)
801020c0:	ff d0                	call   *%eax
801020c2:	83 c4 10             	add    $0x10,%esp
801020c5:	e9 15 01 00 00       	jmp    801021df <writei+0x184>
  }

  if(off > ip->size || off + n < off)
801020ca:	8b 45 08             	mov    0x8(%ebp),%eax
801020cd:	8b 40 58             	mov    0x58(%eax),%eax
801020d0:	39 45 10             	cmp    %eax,0x10(%ebp)
801020d3:	77 0d                	ja     801020e2 <writei+0x87>
801020d5:	8b 55 10             	mov    0x10(%ebp),%edx
801020d8:	8b 45 14             	mov    0x14(%ebp),%eax
801020db:	01 d0                	add    %edx,%eax
801020dd:	39 45 10             	cmp    %eax,0x10(%ebp)
801020e0:	76 0a                	jbe    801020ec <writei+0x91>
    return -1;
801020e2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801020e7:	e9 f3 00 00 00       	jmp    801021df <writei+0x184>
  if(off + n > MAXFILE*BSIZE)
801020ec:	8b 55 10             	mov    0x10(%ebp),%edx
801020ef:	8b 45 14             	mov    0x14(%ebp),%eax
801020f2:	01 d0                	add    %edx,%eax
801020f4:	3d 00 18 01 00       	cmp    $0x11800,%eax
801020f9:	76 0a                	jbe    80102105 <writei+0xaa>
    return -1;
801020fb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102100:	e9 da 00 00 00       	jmp    801021df <writei+0x184>

  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102105:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010210c:	e9 97 00 00 00       	jmp    801021a8 <writei+0x14d>
    bp = bread(ip->dev, bmap(ip, off/BSIZE));
80102111:	8b 45 10             	mov    0x10(%ebp),%eax
80102114:	c1 e8 09             	shr    $0x9,%eax
80102117:	83 ec 08             	sub    $0x8,%esp
8010211a:	50                   	push   %eax
8010211b:	ff 75 08             	push   0x8(%ebp)
8010211e:	e8 4d fb ff ff       	call   80101c70 <bmap>
80102123:	83 c4 10             	add    $0x10,%esp
80102126:	8b 55 08             	mov    0x8(%ebp),%edx
80102129:	8b 12                	mov    (%edx),%edx
8010212b:	83 ec 08             	sub    $0x8,%esp
8010212e:	50                   	push   %eax
8010212f:	52                   	push   %edx
80102130:	e8 9a e0 ff ff       	call   801001cf <bread>
80102135:	83 c4 10             	add    $0x10,%esp
80102138:	89 45 f0             	mov    %eax,-0x10(%ebp)
    m = min(n - tot, BSIZE - off%BSIZE);
8010213b:	8b 45 10             	mov    0x10(%ebp),%eax
8010213e:	25 ff 01 00 00       	and    $0x1ff,%eax
80102143:	ba 00 02 00 00       	mov    $0x200,%edx
80102148:	29 c2                	sub    %eax,%edx
8010214a:	8b 45 14             	mov    0x14(%ebp),%eax
8010214d:	2b 45 f4             	sub    -0xc(%ebp),%eax
80102150:	39 c2                	cmp    %eax,%edx
80102152:	0f 46 c2             	cmovbe %edx,%eax
80102155:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(bp->data + off%BSIZE, src, m);
80102158:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010215b:	8d 50 5c             	lea    0x5c(%eax),%edx
8010215e:	8b 45 10             	mov    0x10(%ebp),%eax
80102161:	25 ff 01 00 00       	and    $0x1ff,%eax
80102166:	01 d0                	add    %edx,%eax
80102168:	83 ec 04             	sub    $0x4,%esp
8010216b:	ff 75 ec             	push   -0x14(%ebp)
8010216e:	ff 75 0c             	push   0xc(%ebp)
80102171:	50                   	push   %eax
80102172:	e8 fb 41 00 00       	call   80106372 <memmove>
80102177:	83 c4 10             	add    $0x10,%esp
    log_write(bp);
8010217a:	83 ec 0c             	sub    $0xc,%esp
8010217d:	ff 75 f0             	push   -0x10(%ebp)
80102180:	e8 e6 15 00 00       	call   8010376b <log_write>
80102185:	83 c4 10             	add    $0x10,%esp
    brelse(bp);
80102188:	83 ec 0c             	sub    $0xc,%esp
8010218b:	ff 75 f0             	push   -0x10(%ebp)
8010218e:	e8 be e0 ff ff       	call   80100251 <brelse>
80102193:	83 c4 10             	add    $0x10,%esp
  for(tot=0; tot<n; tot+=m, off+=m, src+=m){
80102196:	8b 45 ec             	mov    -0x14(%ebp),%eax
80102199:	01 45 f4             	add    %eax,-0xc(%ebp)
8010219c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010219f:	01 45 10             	add    %eax,0x10(%ebp)
801021a2:	8b 45 ec             	mov    -0x14(%ebp),%eax
801021a5:	01 45 0c             	add    %eax,0xc(%ebp)
801021a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801021ab:	3b 45 14             	cmp    0x14(%ebp),%eax
801021ae:	0f 82 5d ff ff ff    	jb     80102111 <writei+0xb6>
  }

  if(n > 0 && off > ip->size){
801021b4:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
801021b8:	74 22                	je     801021dc <writei+0x181>
801021ba:	8b 45 08             	mov    0x8(%ebp),%eax
801021bd:	8b 40 58             	mov    0x58(%eax),%eax
801021c0:	39 45 10             	cmp    %eax,0x10(%ebp)
801021c3:	76 17                	jbe    801021dc <writei+0x181>
    ip->size = off;
801021c5:	8b 45 08             	mov    0x8(%ebp),%eax
801021c8:	8b 55 10             	mov    0x10(%ebp),%edx
801021cb:	89 50 58             	mov    %edx,0x58(%eax)
    iupdate(ip);
801021ce:	83 ec 0c             	sub    $0xc,%esp
801021d1:	ff 75 08             	push   0x8(%ebp)
801021d4:	e8 64 f6 ff ff       	call   8010183d <iupdate>
801021d9:	83 c4 10             	add    $0x10,%esp
  }
  return n;
801021dc:	8b 45 14             	mov    0x14(%ebp),%eax
}
801021df:	c9                   	leave  
801021e0:	c3                   	ret    

801021e1 <namecmp>:
//PAGEBREAK!
// Directories

int
namecmp(const char *s, const char *t)
{
801021e1:	55                   	push   %ebp
801021e2:	89 e5                	mov    %esp,%ebp
801021e4:	83 ec 08             	sub    $0x8,%esp
  return strncmp(s, t, DIRSIZ);
801021e7:	83 ec 04             	sub    $0x4,%esp
801021ea:	6a 0e                	push   $0xe
801021ec:	ff 75 0c             	push   0xc(%ebp)
801021ef:	ff 75 08             	push   0x8(%ebp)
801021f2:	e8 11 42 00 00       	call   80106408 <strncmp>
801021f7:	83 c4 10             	add    $0x10,%esp
}
801021fa:	c9                   	leave  
801021fb:	c3                   	ret    

801021fc <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode*
dirlookup(struct inode *dp, char *name, uint *poff)
{
801021fc:	55                   	push   %ebp
801021fd:	89 e5                	mov    %esp,%ebp
801021ff:	83 ec 28             	sub    $0x28,%esp
  uint off, inum;
  struct dirent de;

  if(dp->type != T_DIR)
80102202:	8b 45 08             	mov    0x8(%ebp),%eax
80102205:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80102209:	66 83 f8 01          	cmp    $0x1,%ax
8010220d:	74 0d                	je     8010221c <dirlookup+0x20>
    panic("dirlookup not DIR");
8010220f:	83 ec 0c             	sub    $0xc,%esp
80102212:	68 8d 97 10 80       	push   $0x8010978d
80102217:	e8 99 e3 ff ff       	call   801005b5 <panic>

  for(off = 0; off < dp->size; off += sizeof(de)){
8010221c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102223:	eb 7b                	jmp    801022a0 <dirlookup+0xa4>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102225:	6a 10                	push   $0x10
80102227:	ff 75 f4             	push   -0xc(%ebp)
8010222a:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010222d:	50                   	push   %eax
8010222e:	ff 75 08             	push   0x8(%ebp)
80102231:	e8 d0 fc ff ff       	call   80101f06 <readi>
80102236:	83 c4 10             	add    $0x10,%esp
80102239:	83 f8 10             	cmp    $0x10,%eax
8010223c:	74 0d                	je     8010224b <dirlookup+0x4f>
      panic("dirlookup read");
8010223e:	83 ec 0c             	sub    $0xc,%esp
80102241:	68 9f 97 10 80       	push   $0x8010979f
80102246:	e8 6a e3 ff ff       	call   801005b5 <panic>
    if(de.inum == 0)
8010224b:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
8010224f:	66 85 c0             	test   %ax,%ax
80102252:	74 47                	je     8010229b <dirlookup+0x9f>
      continue;
    if(namecmp(name, de.name) == 0){
80102254:	83 ec 08             	sub    $0x8,%esp
80102257:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010225a:	83 c0 02             	add    $0x2,%eax
8010225d:	50                   	push   %eax
8010225e:	ff 75 0c             	push   0xc(%ebp)
80102261:	e8 7b ff ff ff       	call   801021e1 <namecmp>
80102266:	83 c4 10             	add    $0x10,%esp
80102269:	85 c0                	test   %eax,%eax
8010226b:	75 2f                	jne    8010229c <dirlookup+0xa0>
      // entry matches path element
      if(poff)
8010226d:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80102271:	74 08                	je     8010227b <dirlookup+0x7f>
        *poff = off;
80102273:	8b 45 10             	mov    0x10(%ebp),%eax
80102276:	8b 55 f4             	mov    -0xc(%ebp),%edx
80102279:	89 10                	mov    %edx,(%eax)
      inum = de.inum;
8010227b:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
8010227f:	0f b7 c0             	movzwl %ax,%eax
80102282:	89 45 f0             	mov    %eax,-0x10(%ebp)
      return iget(dp->dev, inum);
80102285:	8b 45 08             	mov    0x8(%ebp),%eax
80102288:	8b 00                	mov    (%eax),%eax
8010228a:	83 ec 08             	sub    $0x8,%esp
8010228d:	ff 75 f0             	push   -0x10(%ebp)
80102290:	50                   	push   %eax
80102291:	e8 68 f6 ff ff       	call   801018fe <iget>
80102296:	83 c4 10             	add    $0x10,%esp
80102299:	eb 19                	jmp    801022b4 <dirlookup+0xb8>
      continue;
8010229b:	90                   	nop
  for(off = 0; off < dp->size; off += sizeof(de)){
8010229c:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
801022a0:	8b 45 08             	mov    0x8(%ebp),%eax
801022a3:	8b 40 58             	mov    0x58(%eax),%eax
801022a6:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801022a9:	0f 82 76 ff ff ff    	jb     80102225 <dirlookup+0x29>
    }
  }

  return 0;
801022af:	b8 00 00 00 00       	mov    $0x0,%eax
}
801022b4:	c9                   	leave  
801022b5:	c3                   	ret    

801022b6 <dirlink>:

// Write a new directory entry (name, inum) into the directory dp.
int
dirlink(struct inode *dp, char *name, uint inum)
{
801022b6:	55                   	push   %ebp
801022b7:	89 e5                	mov    %esp,%ebp
801022b9:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;
  struct inode *ip;

  // Check that name is not present.
  if((ip = dirlookup(dp, name, 0)) != 0){
801022bc:	83 ec 04             	sub    $0x4,%esp
801022bf:	6a 00                	push   $0x0
801022c1:	ff 75 0c             	push   0xc(%ebp)
801022c4:	ff 75 08             	push   0x8(%ebp)
801022c7:	e8 30 ff ff ff       	call   801021fc <dirlookup>
801022cc:	83 c4 10             	add    $0x10,%esp
801022cf:	89 45 f0             	mov    %eax,-0x10(%ebp)
801022d2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801022d6:	74 18                	je     801022f0 <dirlink+0x3a>
    iput(ip);
801022d8:	83 ec 0c             	sub    $0xc,%esp
801022db:	ff 75 f0             	push   -0x10(%ebp)
801022de:	e8 98 f8 ff ff       	call   80101b7b <iput>
801022e3:	83 c4 10             	add    $0x10,%esp
    return -1;
801022e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801022eb:	e9 9c 00 00 00       	jmp    8010238c <dirlink+0xd6>
  }

  // Look for an empty dirent.
  for(off = 0; off < dp->size; off += sizeof(de)){
801022f0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801022f7:	eb 39                	jmp    80102332 <dirlink+0x7c>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
801022f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801022fc:	6a 10                	push   $0x10
801022fe:	50                   	push   %eax
801022ff:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102302:	50                   	push   %eax
80102303:	ff 75 08             	push   0x8(%ebp)
80102306:	e8 fb fb ff ff       	call   80101f06 <readi>
8010230b:	83 c4 10             	add    $0x10,%esp
8010230e:	83 f8 10             	cmp    $0x10,%eax
80102311:	74 0d                	je     80102320 <dirlink+0x6a>
      panic("dirlink read");
80102313:	83 ec 0c             	sub    $0xc,%esp
80102316:	68 ae 97 10 80       	push   $0x801097ae
8010231b:	e8 95 e2 ff ff       	call   801005b5 <panic>
    if(de.inum == 0)
80102320:	0f b7 45 e0          	movzwl -0x20(%ebp),%eax
80102324:	66 85 c0             	test   %ax,%ax
80102327:	74 18                	je     80102341 <dirlink+0x8b>
  for(off = 0; off < dp->size; off += sizeof(de)){
80102329:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010232c:	83 c0 10             	add    $0x10,%eax
8010232f:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102332:	8b 45 08             	mov    0x8(%ebp),%eax
80102335:	8b 50 58             	mov    0x58(%eax),%edx
80102338:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010233b:	39 c2                	cmp    %eax,%edx
8010233d:	77 ba                	ja     801022f9 <dirlink+0x43>
8010233f:	eb 01                	jmp    80102342 <dirlink+0x8c>
      break;
80102341:	90                   	nop
  }

  strncpy(de.name, name, DIRSIZ);
80102342:	83 ec 04             	sub    $0x4,%esp
80102345:	6a 0e                	push   $0xe
80102347:	ff 75 0c             	push   0xc(%ebp)
8010234a:	8d 45 e0             	lea    -0x20(%ebp),%eax
8010234d:	83 c0 02             	add    $0x2,%eax
80102350:	50                   	push   %eax
80102351:	e8 08 41 00 00       	call   8010645e <strncpy>
80102356:	83 c4 10             	add    $0x10,%esp
  de.inum = inum;
80102359:	8b 45 10             	mov    0x10(%ebp),%eax
8010235c:	66 89 45 e0          	mov    %ax,-0x20(%ebp)
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80102360:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102363:	6a 10                	push   $0x10
80102365:	50                   	push   %eax
80102366:	8d 45 e0             	lea    -0x20(%ebp),%eax
80102369:	50                   	push   %eax
8010236a:	ff 75 08             	push   0x8(%ebp)
8010236d:	e8 e9 fc ff ff       	call   8010205b <writei>
80102372:	83 c4 10             	add    $0x10,%esp
80102375:	83 f8 10             	cmp    $0x10,%eax
80102378:	74 0d                	je     80102387 <dirlink+0xd1>
    panic("dirlink");
8010237a:	83 ec 0c             	sub    $0xc,%esp
8010237d:	68 bb 97 10 80       	push   $0x801097bb
80102382:	e8 2e e2 ff ff       	call   801005b5 <panic>

  return 0;
80102387:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010238c:	c9                   	leave  
8010238d:	c3                   	ret    

8010238e <skipelem>:
//   skipelem("a", name) = "", setting name = "a"
//   skipelem("", name) = skipelem("////", name) = 0
//
static char*
skipelem(char *path, char *name)
{
8010238e:	55                   	push   %ebp
8010238f:	89 e5                	mov    %esp,%ebp
80102391:	83 ec 18             	sub    $0x18,%esp
  char *s;
  int len;

  while(*path == '/')
80102394:	eb 04                	jmp    8010239a <skipelem+0xc>
    path++;
80102396:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
8010239a:	8b 45 08             	mov    0x8(%ebp),%eax
8010239d:	0f b6 00             	movzbl (%eax),%eax
801023a0:	3c 2f                	cmp    $0x2f,%al
801023a2:	74 f2                	je     80102396 <skipelem+0x8>
  if(*path == 0)
801023a4:	8b 45 08             	mov    0x8(%ebp),%eax
801023a7:	0f b6 00             	movzbl (%eax),%eax
801023aa:	84 c0                	test   %al,%al
801023ac:	75 07                	jne    801023b5 <skipelem+0x27>
    return 0;
801023ae:	b8 00 00 00 00       	mov    $0x0,%eax
801023b3:	eb 77                	jmp    8010242c <skipelem+0x9e>
  s = path;
801023b5:	8b 45 08             	mov    0x8(%ebp),%eax
801023b8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(*path != '/' && *path != 0)
801023bb:	eb 04                	jmp    801023c1 <skipelem+0x33>
    path++;
801023bd:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path != '/' && *path != 0)
801023c1:	8b 45 08             	mov    0x8(%ebp),%eax
801023c4:	0f b6 00             	movzbl (%eax),%eax
801023c7:	3c 2f                	cmp    $0x2f,%al
801023c9:	74 0a                	je     801023d5 <skipelem+0x47>
801023cb:	8b 45 08             	mov    0x8(%ebp),%eax
801023ce:	0f b6 00             	movzbl (%eax),%eax
801023d1:	84 c0                	test   %al,%al
801023d3:	75 e8                	jne    801023bd <skipelem+0x2f>
  len = path - s;
801023d5:	8b 45 08             	mov    0x8(%ebp),%eax
801023d8:	2b 45 f4             	sub    -0xc(%ebp),%eax
801023db:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(len >= DIRSIZ)
801023de:	83 7d f0 0d          	cmpl   $0xd,-0x10(%ebp)
801023e2:	7e 15                	jle    801023f9 <skipelem+0x6b>
    memmove(name, s, DIRSIZ);
801023e4:	83 ec 04             	sub    $0x4,%esp
801023e7:	6a 0e                	push   $0xe
801023e9:	ff 75 f4             	push   -0xc(%ebp)
801023ec:	ff 75 0c             	push   0xc(%ebp)
801023ef:	e8 7e 3f 00 00       	call   80106372 <memmove>
801023f4:	83 c4 10             	add    $0x10,%esp
801023f7:	eb 26                	jmp    8010241f <skipelem+0x91>
  else {
    memmove(name, s, len);
801023f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801023fc:	83 ec 04             	sub    $0x4,%esp
801023ff:	50                   	push   %eax
80102400:	ff 75 f4             	push   -0xc(%ebp)
80102403:	ff 75 0c             	push   0xc(%ebp)
80102406:	e8 67 3f 00 00       	call   80106372 <memmove>
8010240b:	83 c4 10             	add    $0x10,%esp
    name[len] = 0;
8010240e:	8b 55 f0             	mov    -0x10(%ebp),%edx
80102411:	8b 45 0c             	mov    0xc(%ebp),%eax
80102414:	01 d0                	add    %edx,%eax
80102416:	c6 00 00             	movb   $0x0,(%eax)
  }
  while(*path == '/')
80102419:	eb 04                	jmp    8010241f <skipelem+0x91>
    path++;
8010241b:	83 45 08 01          	addl   $0x1,0x8(%ebp)
  while(*path == '/')
8010241f:	8b 45 08             	mov    0x8(%ebp),%eax
80102422:	0f b6 00             	movzbl (%eax),%eax
80102425:	3c 2f                	cmp    $0x2f,%al
80102427:	74 f2                	je     8010241b <skipelem+0x8d>
  return path;
80102429:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010242c:	c9                   	leave  
8010242d:	c3                   	ret    

8010242e <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode*
namex(char *path, int nameiparent, char *name)
{
8010242e:	55                   	push   %ebp
8010242f:	89 e5                	mov    %esp,%ebp
80102431:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip, *next;

  if(*path == '/')
80102434:	8b 45 08             	mov    0x8(%ebp),%eax
80102437:	0f b6 00             	movzbl (%eax),%eax
8010243a:	3c 2f                	cmp    $0x2f,%al
8010243c:	75 17                	jne    80102455 <namex+0x27>
    ip = iget(ROOTDEV, ROOTINO);
8010243e:	83 ec 08             	sub    $0x8,%esp
80102441:	6a 01                	push   $0x1
80102443:	6a 01                	push   $0x1
80102445:	e8 b4 f4 ff ff       	call   801018fe <iget>
8010244a:	83 c4 10             	add    $0x10,%esp
8010244d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80102450:	e9 ba 00 00 00       	jmp    8010250f <namex+0xe1>
  else
    ip = idup(myproc()->cwd);
80102455:	e8 bc 1e 00 00       	call   80104316 <myproc>
8010245a:	8b 40 68             	mov    0x68(%eax),%eax
8010245d:	83 ec 0c             	sub    $0xc,%esp
80102460:	50                   	push   %eax
80102461:	e8 7a f5 ff ff       	call   801019e0 <idup>
80102466:	83 c4 10             	add    $0x10,%esp
80102469:	89 45 f4             	mov    %eax,-0xc(%ebp)

  while((path = skipelem(path, name)) != 0){
8010246c:	e9 9e 00 00 00       	jmp    8010250f <namex+0xe1>
    ilock(ip);
80102471:	83 ec 0c             	sub    $0xc,%esp
80102474:	ff 75 f4             	push   -0xc(%ebp)
80102477:	e8 9e f5 ff ff       	call   80101a1a <ilock>
8010247c:	83 c4 10             	add    $0x10,%esp
    if(ip->type != T_DIR){
8010247f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102482:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80102486:	66 83 f8 01          	cmp    $0x1,%ax
8010248a:	74 18                	je     801024a4 <namex+0x76>
      iunlockput(ip);
8010248c:	83 ec 0c             	sub    $0xc,%esp
8010248f:	ff 75 f4             	push   -0xc(%ebp)
80102492:	e8 b4 f7 ff ff       	call   80101c4b <iunlockput>
80102497:	83 c4 10             	add    $0x10,%esp
      return 0;
8010249a:	b8 00 00 00 00       	mov    $0x0,%eax
8010249f:	e9 a7 00 00 00       	jmp    8010254b <namex+0x11d>
    }
    if(nameiparent && *path == '\0'){
801024a4:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801024a8:	74 20                	je     801024ca <namex+0x9c>
801024aa:	8b 45 08             	mov    0x8(%ebp),%eax
801024ad:	0f b6 00             	movzbl (%eax),%eax
801024b0:	84 c0                	test   %al,%al
801024b2:	75 16                	jne    801024ca <namex+0x9c>
      // Stop one level early.
      iunlock(ip);
801024b4:	83 ec 0c             	sub    $0xc,%esp
801024b7:	ff 75 f4             	push   -0xc(%ebp)
801024ba:	e8 6e f6 ff ff       	call   80101b2d <iunlock>
801024bf:	83 c4 10             	add    $0x10,%esp
      return ip;
801024c2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801024c5:	e9 81 00 00 00       	jmp    8010254b <namex+0x11d>
    }
    if((next = dirlookup(ip, name, 0)) == 0){
801024ca:	83 ec 04             	sub    $0x4,%esp
801024cd:	6a 00                	push   $0x0
801024cf:	ff 75 10             	push   0x10(%ebp)
801024d2:	ff 75 f4             	push   -0xc(%ebp)
801024d5:	e8 22 fd ff ff       	call   801021fc <dirlookup>
801024da:	83 c4 10             	add    $0x10,%esp
801024dd:	89 45 f0             	mov    %eax,-0x10(%ebp)
801024e0:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801024e4:	75 15                	jne    801024fb <namex+0xcd>
      iunlockput(ip);
801024e6:	83 ec 0c             	sub    $0xc,%esp
801024e9:	ff 75 f4             	push   -0xc(%ebp)
801024ec:	e8 5a f7 ff ff       	call   80101c4b <iunlockput>
801024f1:	83 c4 10             	add    $0x10,%esp
      return 0;
801024f4:	b8 00 00 00 00       	mov    $0x0,%eax
801024f9:	eb 50                	jmp    8010254b <namex+0x11d>
    }
    iunlockput(ip);
801024fb:	83 ec 0c             	sub    $0xc,%esp
801024fe:	ff 75 f4             	push   -0xc(%ebp)
80102501:	e8 45 f7 ff ff       	call   80101c4b <iunlockput>
80102506:	83 c4 10             	add    $0x10,%esp
    ip = next;
80102509:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010250c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while((path = skipelem(path, name)) != 0){
8010250f:	83 ec 08             	sub    $0x8,%esp
80102512:	ff 75 10             	push   0x10(%ebp)
80102515:	ff 75 08             	push   0x8(%ebp)
80102518:	e8 71 fe ff ff       	call   8010238e <skipelem>
8010251d:	83 c4 10             	add    $0x10,%esp
80102520:	89 45 08             	mov    %eax,0x8(%ebp)
80102523:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102527:	0f 85 44 ff ff ff    	jne    80102471 <namex+0x43>
  }
  if(nameiparent){
8010252d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80102531:	74 15                	je     80102548 <namex+0x11a>
    iput(ip);
80102533:	83 ec 0c             	sub    $0xc,%esp
80102536:	ff 75 f4             	push   -0xc(%ebp)
80102539:	e8 3d f6 ff ff       	call   80101b7b <iput>
8010253e:	83 c4 10             	add    $0x10,%esp
    return 0;
80102541:	b8 00 00 00 00       	mov    $0x0,%eax
80102546:	eb 03                	jmp    8010254b <namex+0x11d>
  }
  return ip;
80102548:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010254b:	c9                   	leave  
8010254c:	c3                   	ret    

8010254d <namei>:

struct inode*
namei(char *path)
{
8010254d:	55                   	push   %ebp
8010254e:	89 e5                	mov    %esp,%ebp
80102550:	83 ec 18             	sub    $0x18,%esp
  char name[DIRSIZ];
  return namex(path, 0, name);
80102553:	83 ec 04             	sub    $0x4,%esp
80102556:	8d 45 ea             	lea    -0x16(%ebp),%eax
80102559:	50                   	push   %eax
8010255a:	6a 00                	push   $0x0
8010255c:	ff 75 08             	push   0x8(%ebp)
8010255f:	e8 ca fe ff ff       	call   8010242e <namex>
80102564:	83 c4 10             	add    $0x10,%esp
}
80102567:	c9                   	leave  
80102568:	c3                   	ret    

80102569 <nameiparent>:

struct inode*
nameiparent(char *path, char *name)
{
80102569:	55                   	push   %ebp
8010256a:	89 e5                	mov    %esp,%ebp
8010256c:	83 ec 08             	sub    $0x8,%esp
  return namex(path, 1, name);
8010256f:	83 ec 04             	sub    $0x4,%esp
80102572:	ff 75 0c             	push   0xc(%ebp)
80102575:	6a 01                	push   $0x1
80102577:	ff 75 08             	push   0x8(%ebp)
8010257a:	e8 af fe ff ff       	call   8010242e <namex>
8010257f:	83 c4 10             	add    $0x10,%esp
}
80102582:	c9                   	leave  
80102583:	c3                   	ret    

80102584 <inb>:
{
80102584:	55                   	push   %ebp
80102585:	89 e5                	mov    %esp,%ebp
80102587:	83 ec 14             	sub    $0x14,%esp
8010258a:	8b 45 08             	mov    0x8(%ebp),%eax
8010258d:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102591:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102595:	89 c2                	mov    %eax,%edx
80102597:	ec                   	in     (%dx),%al
80102598:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
8010259b:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
8010259f:	c9                   	leave  
801025a0:	c3                   	ret    

801025a1 <insl>:
{
801025a1:	55                   	push   %ebp
801025a2:	89 e5                	mov    %esp,%ebp
801025a4:	57                   	push   %edi
801025a5:	53                   	push   %ebx
  asm volatile("cld; rep insl" :
801025a6:	8b 55 08             	mov    0x8(%ebp),%edx
801025a9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801025ac:	8b 45 10             	mov    0x10(%ebp),%eax
801025af:	89 cb                	mov    %ecx,%ebx
801025b1:	89 df                	mov    %ebx,%edi
801025b3:	89 c1                	mov    %eax,%ecx
801025b5:	fc                   	cld    
801025b6:	f3 6d                	rep insl (%dx),%es:(%edi)
801025b8:	89 c8                	mov    %ecx,%eax
801025ba:	89 fb                	mov    %edi,%ebx
801025bc:	89 5d 0c             	mov    %ebx,0xc(%ebp)
801025bf:	89 45 10             	mov    %eax,0x10(%ebp)
}
801025c2:	90                   	nop
801025c3:	5b                   	pop    %ebx
801025c4:	5f                   	pop    %edi
801025c5:	5d                   	pop    %ebp
801025c6:	c3                   	ret    

801025c7 <outb>:
{
801025c7:	55                   	push   %ebp
801025c8:	89 e5                	mov    %esp,%ebp
801025ca:	83 ec 08             	sub    $0x8,%esp
801025cd:	8b 45 08             	mov    0x8(%ebp),%eax
801025d0:	8b 55 0c             	mov    0xc(%ebp),%edx
801025d3:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
801025d7:	89 d0                	mov    %edx,%eax
801025d9:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
801025dc:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
801025e0:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
801025e4:	ee                   	out    %al,(%dx)
}
801025e5:	90                   	nop
801025e6:	c9                   	leave  
801025e7:	c3                   	ret    

801025e8 <outsl>:
{
801025e8:	55                   	push   %ebp
801025e9:	89 e5                	mov    %esp,%ebp
801025eb:	56                   	push   %esi
801025ec:	53                   	push   %ebx
  asm volatile("cld; rep outsl" :
801025ed:	8b 55 08             	mov    0x8(%ebp),%edx
801025f0:	8b 4d 0c             	mov    0xc(%ebp),%ecx
801025f3:	8b 45 10             	mov    0x10(%ebp),%eax
801025f6:	89 cb                	mov    %ecx,%ebx
801025f8:	89 de                	mov    %ebx,%esi
801025fa:	89 c1                	mov    %eax,%ecx
801025fc:	fc                   	cld    
801025fd:	f3 6f                	rep outsl %ds:(%esi),(%dx)
801025ff:	89 c8                	mov    %ecx,%eax
80102601:	89 f3                	mov    %esi,%ebx
80102603:	89 5d 0c             	mov    %ebx,0xc(%ebp)
80102606:	89 45 10             	mov    %eax,0x10(%ebp)
}
80102609:	90                   	nop
8010260a:	5b                   	pop    %ebx
8010260b:	5e                   	pop    %esi
8010260c:	5d                   	pop    %ebp
8010260d:	c3                   	ret    

8010260e <idewait>:
static void idestart(struct buf*);

// Wait for IDE disk to become ready.
static int
idewait(int checkerr)
{
8010260e:	55                   	push   %ebp
8010260f:	89 e5                	mov    %esp,%ebp
80102611:	83 ec 10             	sub    $0x10,%esp
  int r;

  while(((r = inb(0x1f7)) & (IDE_BSY|IDE_DRDY)) != IDE_DRDY)
80102614:	90                   	nop
80102615:	68 f7 01 00 00       	push   $0x1f7
8010261a:	e8 65 ff ff ff       	call   80102584 <inb>
8010261f:	83 c4 04             	add    $0x4,%esp
80102622:	0f b6 c0             	movzbl %al,%eax
80102625:	89 45 fc             	mov    %eax,-0x4(%ebp)
80102628:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010262b:	25 c0 00 00 00       	and    $0xc0,%eax
80102630:	83 f8 40             	cmp    $0x40,%eax
80102633:	75 e0                	jne    80102615 <idewait+0x7>
    ;
  if(checkerr && (r & (IDE_DF|IDE_ERR)) != 0)
80102635:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80102639:	74 11                	je     8010264c <idewait+0x3e>
8010263b:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010263e:	83 e0 21             	and    $0x21,%eax
80102641:	85 c0                	test   %eax,%eax
80102643:	74 07                	je     8010264c <idewait+0x3e>
    return -1;
80102645:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010264a:	eb 05                	jmp    80102651 <idewait+0x43>
  return 0;
8010264c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80102651:	c9                   	leave  
80102652:	c3                   	ret    

80102653 <ideinit>:

void
ideinit(void)
{
80102653:	55                   	push   %ebp
80102654:	89 e5                	mov    %esp,%ebp
80102656:	83 ec 18             	sub    $0x18,%esp
  int i;

  initlock(&idelock, "ide");
80102659:	83 ec 08             	sub    $0x8,%esp
8010265c:	68 c3 97 10 80       	push   $0x801097c3
80102661:	68 60 36 11 80       	push   $0x80113660
80102666:	e8 a0 39 00 00       	call   8010600b <initlock>
8010266b:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_IDE, ncpu - 1);
8010266e:	a1 60 3d 11 80       	mov    0x80113d60,%eax
80102673:	83 e8 01             	sub    $0x1,%eax
80102676:	83 ec 08             	sub    $0x8,%esp
80102679:	50                   	push   %eax
8010267a:	6a 0e                	push   $0xe
8010267c:	e8 a3 04 00 00       	call   80102b24 <ioapicenable>
80102681:	83 c4 10             	add    $0x10,%esp
  idewait(0);
80102684:	83 ec 0c             	sub    $0xc,%esp
80102687:	6a 00                	push   $0x0
80102689:	e8 80 ff ff ff       	call   8010260e <idewait>
8010268e:	83 c4 10             	add    $0x10,%esp

  // Check if disk 1 is present
  outb(0x1f6, 0xe0 | (1<<4));
80102691:	83 ec 08             	sub    $0x8,%esp
80102694:	68 f0 00 00 00       	push   $0xf0
80102699:	68 f6 01 00 00       	push   $0x1f6
8010269e:	e8 24 ff ff ff       	call   801025c7 <outb>
801026a3:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<1000; i++){
801026a6:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801026ad:	eb 24                	jmp    801026d3 <ideinit+0x80>
    if(inb(0x1f7) != 0){
801026af:	83 ec 0c             	sub    $0xc,%esp
801026b2:	68 f7 01 00 00       	push   $0x1f7
801026b7:	e8 c8 fe ff ff       	call   80102584 <inb>
801026bc:	83 c4 10             	add    $0x10,%esp
801026bf:	84 c0                	test   %al,%al
801026c1:	74 0c                	je     801026cf <ideinit+0x7c>
      havedisk1 = 1;
801026c3:	c7 05 98 36 11 80 01 	movl   $0x1,0x80113698
801026ca:	00 00 00 
      break;
801026cd:	eb 0d                	jmp    801026dc <ideinit+0x89>
  for(i=0; i<1000; i++){
801026cf:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801026d3:	81 7d f4 e7 03 00 00 	cmpl   $0x3e7,-0xc(%ebp)
801026da:	7e d3                	jle    801026af <ideinit+0x5c>
    }
  }

  // Switch back to disk 0.
  outb(0x1f6, 0xe0 | (0<<4));
801026dc:	83 ec 08             	sub    $0x8,%esp
801026df:	68 e0 00 00 00       	push   $0xe0
801026e4:	68 f6 01 00 00       	push   $0x1f6
801026e9:	e8 d9 fe ff ff       	call   801025c7 <outb>
801026ee:	83 c4 10             	add    $0x10,%esp
}
801026f1:	90                   	nop
801026f2:	c9                   	leave  
801026f3:	c3                   	ret    

801026f4 <idestart>:

// Start the request for b.  Caller must hold idelock.
static void
idestart(struct buf *b)
{
801026f4:	55                   	push   %ebp
801026f5:	89 e5                	mov    %esp,%ebp
801026f7:	83 ec 18             	sub    $0x18,%esp
  if(b == 0)
801026fa:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801026fe:	75 0d                	jne    8010270d <idestart+0x19>
    panic("idestart");
80102700:	83 ec 0c             	sub    $0xc,%esp
80102703:	68 c7 97 10 80       	push   $0x801097c7
80102708:	e8 a8 de ff ff       	call   801005b5 <panic>
  if(b->blockno >= FSSIZE)
8010270d:	8b 45 08             	mov    0x8(%ebp),%eax
80102710:	8b 40 08             	mov    0x8(%eax),%eax
80102713:	3d e7 03 00 00       	cmp    $0x3e7,%eax
80102718:	76 0d                	jbe    80102727 <idestart+0x33>
    panic("incorrect blockno");
8010271a:	83 ec 0c             	sub    $0xc,%esp
8010271d:	68 d0 97 10 80       	push   $0x801097d0
80102722:	e8 8e de ff ff       	call   801005b5 <panic>
  int sector_per_block =  BSIZE/SECTOR_SIZE;
80102727:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
  int sector = b->blockno * sector_per_block;
8010272e:	8b 45 08             	mov    0x8(%ebp),%eax
80102731:	8b 50 08             	mov    0x8(%eax),%edx
80102734:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102737:	0f af c2             	imul   %edx,%eax
8010273a:	89 45 f0             	mov    %eax,-0x10(%ebp)
  int read_cmd = (sector_per_block == 1) ? IDE_CMD_READ :  IDE_CMD_RDMUL;
8010273d:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
80102741:	75 07                	jne    8010274a <idestart+0x56>
80102743:	b8 20 00 00 00       	mov    $0x20,%eax
80102748:	eb 05                	jmp    8010274f <idestart+0x5b>
8010274a:	b8 c4 00 00 00       	mov    $0xc4,%eax
8010274f:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int write_cmd = (sector_per_block == 1) ? IDE_CMD_WRITE : IDE_CMD_WRMUL;
80102752:	83 7d f4 01          	cmpl   $0x1,-0xc(%ebp)
80102756:	75 07                	jne    8010275f <idestart+0x6b>
80102758:	b8 30 00 00 00       	mov    $0x30,%eax
8010275d:	eb 05                	jmp    80102764 <idestart+0x70>
8010275f:	b8 c5 00 00 00       	mov    $0xc5,%eax
80102764:	89 45 e8             	mov    %eax,-0x18(%ebp)

  if (sector_per_block > 7) panic("idestart");
80102767:	83 7d f4 07          	cmpl   $0x7,-0xc(%ebp)
8010276b:	7e 0d                	jle    8010277a <idestart+0x86>
8010276d:	83 ec 0c             	sub    $0xc,%esp
80102770:	68 c7 97 10 80       	push   $0x801097c7
80102775:	e8 3b de ff ff       	call   801005b5 <panic>

  idewait(0);
8010277a:	83 ec 0c             	sub    $0xc,%esp
8010277d:	6a 00                	push   $0x0
8010277f:	e8 8a fe ff ff       	call   8010260e <idewait>
80102784:	83 c4 10             	add    $0x10,%esp
  outb(0x3f6, 0);  // generate interrupt
80102787:	83 ec 08             	sub    $0x8,%esp
8010278a:	6a 00                	push   $0x0
8010278c:	68 f6 03 00 00       	push   $0x3f6
80102791:	e8 31 fe ff ff       	call   801025c7 <outb>
80102796:	83 c4 10             	add    $0x10,%esp
  outb(0x1f2, sector_per_block);  // number of sectors
80102799:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010279c:	0f b6 c0             	movzbl %al,%eax
8010279f:	83 ec 08             	sub    $0x8,%esp
801027a2:	50                   	push   %eax
801027a3:	68 f2 01 00 00       	push   $0x1f2
801027a8:	e8 1a fe ff ff       	call   801025c7 <outb>
801027ad:	83 c4 10             	add    $0x10,%esp
  outb(0x1f3, sector & 0xff);
801027b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801027b3:	0f b6 c0             	movzbl %al,%eax
801027b6:	83 ec 08             	sub    $0x8,%esp
801027b9:	50                   	push   %eax
801027ba:	68 f3 01 00 00       	push   $0x1f3
801027bf:	e8 03 fe ff ff       	call   801025c7 <outb>
801027c4:	83 c4 10             	add    $0x10,%esp
  outb(0x1f4, (sector >> 8) & 0xff);
801027c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801027ca:	c1 f8 08             	sar    $0x8,%eax
801027cd:	0f b6 c0             	movzbl %al,%eax
801027d0:	83 ec 08             	sub    $0x8,%esp
801027d3:	50                   	push   %eax
801027d4:	68 f4 01 00 00       	push   $0x1f4
801027d9:	e8 e9 fd ff ff       	call   801025c7 <outb>
801027de:	83 c4 10             	add    $0x10,%esp
  outb(0x1f5, (sector >> 16) & 0xff);
801027e1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801027e4:	c1 f8 10             	sar    $0x10,%eax
801027e7:	0f b6 c0             	movzbl %al,%eax
801027ea:	83 ec 08             	sub    $0x8,%esp
801027ed:	50                   	push   %eax
801027ee:	68 f5 01 00 00       	push   $0x1f5
801027f3:	e8 cf fd ff ff       	call   801025c7 <outb>
801027f8:	83 c4 10             	add    $0x10,%esp
  outb(0x1f6, 0xe0 | ((b->dev&1)<<4) | ((sector>>24)&0x0f));
801027fb:	8b 45 08             	mov    0x8(%ebp),%eax
801027fe:	8b 40 04             	mov    0x4(%eax),%eax
80102801:	c1 e0 04             	shl    $0x4,%eax
80102804:	83 e0 10             	and    $0x10,%eax
80102807:	89 c2                	mov    %eax,%edx
80102809:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010280c:	c1 f8 18             	sar    $0x18,%eax
8010280f:	83 e0 0f             	and    $0xf,%eax
80102812:	09 d0                	or     %edx,%eax
80102814:	83 c8 e0             	or     $0xffffffe0,%eax
80102817:	0f b6 c0             	movzbl %al,%eax
8010281a:	83 ec 08             	sub    $0x8,%esp
8010281d:	50                   	push   %eax
8010281e:	68 f6 01 00 00       	push   $0x1f6
80102823:	e8 9f fd ff ff       	call   801025c7 <outb>
80102828:	83 c4 10             	add    $0x10,%esp
  if(b->flags & B_DIRTY){
8010282b:	8b 45 08             	mov    0x8(%ebp),%eax
8010282e:	8b 00                	mov    (%eax),%eax
80102830:	83 e0 04             	and    $0x4,%eax
80102833:	85 c0                	test   %eax,%eax
80102835:	74 35                	je     8010286c <idestart+0x178>
    outb(0x1f7, write_cmd);
80102837:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010283a:	0f b6 c0             	movzbl %al,%eax
8010283d:	83 ec 08             	sub    $0x8,%esp
80102840:	50                   	push   %eax
80102841:	68 f7 01 00 00       	push   $0x1f7
80102846:	e8 7c fd ff ff       	call   801025c7 <outb>
8010284b:	83 c4 10             	add    $0x10,%esp
    outsl(0x1f0, b->data, BSIZE/4);
8010284e:	8b 45 08             	mov    0x8(%ebp),%eax
80102851:	83 c0 5c             	add    $0x5c,%eax
80102854:	83 ec 04             	sub    $0x4,%esp
80102857:	68 80 00 00 00       	push   $0x80
8010285c:	50                   	push   %eax
8010285d:	68 f0 01 00 00       	push   $0x1f0
80102862:	e8 81 fd ff ff       	call   801025e8 <outsl>
80102867:	83 c4 10             	add    $0x10,%esp
  } else {
    outb(0x1f7, read_cmd);
  }
}
8010286a:	eb 17                	jmp    80102883 <idestart+0x18f>
    outb(0x1f7, read_cmd);
8010286c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010286f:	0f b6 c0             	movzbl %al,%eax
80102872:	83 ec 08             	sub    $0x8,%esp
80102875:	50                   	push   %eax
80102876:	68 f7 01 00 00       	push   $0x1f7
8010287b:	e8 47 fd ff ff       	call   801025c7 <outb>
80102880:	83 c4 10             	add    $0x10,%esp
}
80102883:	90                   	nop
80102884:	c9                   	leave  
80102885:	c3                   	ret    

80102886 <ideintr>:

// Interrupt handler.
void
ideintr(void)
{
80102886:	55                   	push   %ebp
80102887:	89 e5                	mov    %esp,%ebp
80102889:	83 ec 18             	sub    $0x18,%esp
  struct buf *b;

  // First queued buffer is the active request.
  acquire(&idelock);
8010288c:	83 ec 0c             	sub    $0xc,%esp
8010288f:	68 60 36 11 80       	push   $0x80113660
80102894:	e8 94 37 00 00       	call   8010602d <acquire>
80102899:	83 c4 10             	add    $0x10,%esp

  if((b = idequeue) == 0){
8010289c:	a1 94 36 11 80       	mov    0x80113694,%eax
801028a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
801028a4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801028a8:	75 15                	jne    801028bf <ideintr+0x39>
    release(&idelock);
801028aa:	83 ec 0c             	sub    $0xc,%esp
801028ad:	68 60 36 11 80       	push   $0x80113660
801028b2:	e8 e4 37 00 00       	call   8010609b <release>
801028b7:	83 c4 10             	add    $0x10,%esp
    return;
801028ba:	e9 9a 00 00 00       	jmp    80102959 <ideintr+0xd3>
  }
  idequeue = b->qnext;
801028bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028c2:	8b 40 58             	mov    0x58(%eax),%eax
801028c5:	a3 94 36 11 80       	mov    %eax,0x80113694

  // Read data if needed.
  if(!(b->flags & B_DIRTY) && idewait(1) >= 0)
801028ca:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028cd:	8b 00                	mov    (%eax),%eax
801028cf:	83 e0 04             	and    $0x4,%eax
801028d2:	85 c0                	test   %eax,%eax
801028d4:	75 2d                	jne    80102903 <ideintr+0x7d>
801028d6:	83 ec 0c             	sub    $0xc,%esp
801028d9:	6a 01                	push   $0x1
801028db:	e8 2e fd ff ff       	call   8010260e <idewait>
801028e0:	83 c4 10             	add    $0x10,%esp
801028e3:	85 c0                	test   %eax,%eax
801028e5:	78 1c                	js     80102903 <ideintr+0x7d>
    insl(0x1f0, b->data, BSIZE/4);
801028e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028ea:	83 c0 5c             	add    $0x5c,%eax
801028ed:	83 ec 04             	sub    $0x4,%esp
801028f0:	68 80 00 00 00       	push   $0x80
801028f5:	50                   	push   %eax
801028f6:	68 f0 01 00 00       	push   $0x1f0
801028fb:	e8 a1 fc ff ff       	call   801025a1 <insl>
80102900:	83 c4 10             	add    $0x10,%esp

  // Wake process waiting for this buf.
  b->flags |= B_VALID;
80102903:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102906:	8b 00                	mov    (%eax),%eax
80102908:	83 c8 02             	or     $0x2,%eax
8010290b:	89 c2                	mov    %eax,%edx
8010290d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102910:	89 10                	mov    %edx,(%eax)
  b->flags &= ~B_DIRTY;
80102912:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102915:	8b 00                	mov    (%eax),%eax
80102917:	83 e0 fb             	and    $0xfffffffb,%eax
8010291a:	89 c2                	mov    %eax,%edx
8010291c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010291f:	89 10                	mov    %edx,(%eax)
  wakeup(b);
80102921:	83 ec 0c             	sub    $0xc,%esp
80102924:	ff 75 f4             	push   -0xc(%ebp)
80102927:	e8 9e 2a 00 00       	call   801053ca <wakeup>
8010292c:	83 c4 10             	add    $0x10,%esp

  // Start disk on next buf in queue.
  if(idequeue != 0)
8010292f:	a1 94 36 11 80       	mov    0x80113694,%eax
80102934:	85 c0                	test   %eax,%eax
80102936:	74 11                	je     80102949 <ideintr+0xc3>
    idestart(idequeue);
80102938:	a1 94 36 11 80       	mov    0x80113694,%eax
8010293d:	83 ec 0c             	sub    $0xc,%esp
80102940:	50                   	push   %eax
80102941:	e8 ae fd ff ff       	call   801026f4 <idestart>
80102946:	83 c4 10             	add    $0x10,%esp

  release(&idelock);
80102949:	83 ec 0c             	sub    $0xc,%esp
8010294c:	68 60 36 11 80       	push   $0x80113660
80102951:	e8 45 37 00 00       	call   8010609b <release>
80102956:	83 c4 10             	add    $0x10,%esp
}
80102959:	c9                   	leave  
8010295a:	c3                   	ret    

8010295b <iderw>:
// Sync buf with disk.
// If B_DIRTY is set, write buf to disk, clear B_DIRTY, set B_VALID.
// Else if B_VALID is not set, read buf from disk, set B_VALID.
void
iderw(struct buf *b)
{
8010295b:	55                   	push   %ebp
8010295c:	89 e5                	mov    %esp,%ebp
8010295e:	83 ec 18             	sub    $0x18,%esp
  struct buf **pp;

  if(!holdingsleep(&b->lock))
80102961:	8b 45 08             	mov    0x8(%ebp),%eax
80102964:	83 c0 0c             	add    $0xc,%eax
80102967:	83 ec 0c             	sub    $0xc,%esp
8010296a:	50                   	push   %eax
8010296b:	e8 06 36 00 00       	call   80105f76 <holdingsleep>
80102970:	83 c4 10             	add    $0x10,%esp
80102973:	85 c0                	test   %eax,%eax
80102975:	75 0d                	jne    80102984 <iderw+0x29>
    panic("iderw: buf not locked");
80102977:	83 ec 0c             	sub    $0xc,%esp
8010297a:	68 e2 97 10 80       	push   $0x801097e2
8010297f:	e8 31 dc ff ff       	call   801005b5 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102984:	8b 45 08             	mov    0x8(%ebp),%eax
80102987:	8b 00                	mov    (%eax),%eax
80102989:	83 e0 06             	and    $0x6,%eax
8010298c:	83 f8 02             	cmp    $0x2,%eax
8010298f:	75 0d                	jne    8010299e <iderw+0x43>
    panic("iderw: nothing to do");
80102991:	83 ec 0c             	sub    $0xc,%esp
80102994:	68 f8 97 10 80       	push   $0x801097f8
80102999:	e8 17 dc ff ff       	call   801005b5 <panic>
  if(b->dev != 0 && !havedisk1)
8010299e:	8b 45 08             	mov    0x8(%ebp),%eax
801029a1:	8b 40 04             	mov    0x4(%eax),%eax
801029a4:	85 c0                	test   %eax,%eax
801029a6:	74 16                	je     801029be <iderw+0x63>
801029a8:	a1 98 36 11 80       	mov    0x80113698,%eax
801029ad:	85 c0                	test   %eax,%eax
801029af:	75 0d                	jne    801029be <iderw+0x63>
    panic("iderw: ide disk 1 not present");
801029b1:	83 ec 0c             	sub    $0xc,%esp
801029b4:	68 0d 98 10 80       	push   $0x8010980d
801029b9:	e8 f7 db ff ff       	call   801005b5 <panic>

  acquire(&idelock);  //DOC:acquire-lock
801029be:	83 ec 0c             	sub    $0xc,%esp
801029c1:	68 60 36 11 80       	push   $0x80113660
801029c6:	e8 62 36 00 00       	call   8010602d <acquire>
801029cb:	83 c4 10             	add    $0x10,%esp

  // Append b to idequeue.
  b->qnext = 0;
801029ce:	8b 45 08             	mov    0x8(%ebp),%eax
801029d1:	c7 40 58 00 00 00 00 	movl   $0x0,0x58(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801029d8:	c7 45 f4 94 36 11 80 	movl   $0x80113694,-0xc(%ebp)
801029df:	eb 0b                	jmp    801029ec <iderw+0x91>
801029e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029e4:	8b 00                	mov    (%eax),%eax
801029e6:	83 c0 58             	add    $0x58,%eax
801029e9:	89 45 f4             	mov    %eax,-0xc(%ebp)
801029ec:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029ef:	8b 00                	mov    (%eax),%eax
801029f1:	85 c0                	test   %eax,%eax
801029f3:	75 ec                	jne    801029e1 <iderw+0x86>
    ;
  *pp = b;
801029f5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801029f8:	8b 55 08             	mov    0x8(%ebp),%edx
801029fb:	89 10                	mov    %edx,(%eax)

  // Start disk if necessary.
  if(idequeue == b)
801029fd:	a1 94 36 11 80       	mov    0x80113694,%eax
80102a02:	39 45 08             	cmp    %eax,0x8(%ebp)
80102a05:	75 23                	jne    80102a2a <iderw+0xcf>
    idestart(b);
80102a07:	83 ec 0c             	sub    $0xc,%esp
80102a0a:	ff 75 08             	push   0x8(%ebp)
80102a0d:	e8 e2 fc ff ff       	call   801026f4 <idestart>
80102a12:	83 c4 10             	add    $0x10,%esp

  // Wait for request to finish.
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102a15:	eb 13                	jmp    80102a2a <iderw+0xcf>
    sleep(b, &idelock);
80102a17:	83 ec 08             	sub    $0x8,%esp
80102a1a:	68 60 36 11 80       	push   $0x80113660
80102a1f:	ff 75 08             	push   0x8(%ebp)
80102a22:	e8 25 28 00 00       	call   8010524c <sleep>
80102a27:	83 c4 10             	add    $0x10,%esp
  while((b->flags & (B_VALID|B_DIRTY)) != B_VALID){
80102a2a:	8b 45 08             	mov    0x8(%ebp),%eax
80102a2d:	8b 00                	mov    (%eax),%eax
80102a2f:	83 e0 06             	and    $0x6,%eax
80102a32:	83 f8 02             	cmp    $0x2,%eax
80102a35:	75 e0                	jne    80102a17 <iderw+0xbc>
  }


  release(&idelock);
80102a37:	83 ec 0c             	sub    $0xc,%esp
80102a3a:	68 60 36 11 80       	push   $0x80113660
80102a3f:	e8 57 36 00 00       	call   8010609b <release>
80102a44:	83 c4 10             	add    $0x10,%esp
}
80102a47:	90                   	nop
80102a48:	c9                   	leave  
80102a49:	c3                   	ret    

80102a4a <ioapicread>:
  uint data;
};

static uint
ioapicread(int reg)
{
80102a4a:	55                   	push   %ebp
80102a4b:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102a4d:	a1 9c 36 11 80       	mov    0x8011369c,%eax
80102a52:	8b 55 08             	mov    0x8(%ebp),%edx
80102a55:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
80102a57:	a1 9c 36 11 80       	mov    0x8011369c,%eax
80102a5c:	8b 40 10             	mov    0x10(%eax),%eax
}
80102a5f:	5d                   	pop    %ebp
80102a60:	c3                   	ret    

80102a61 <ioapicwrite>:

static void
ioapicwrite(int reg, uint data)
{
80102a61:	55                   	push   %ebp
80102a62:	89 e5                	mov    %esp,%ebp
  ioapic->reg = reg;
80102a64:	a1 9c 36 11 80       	mov    0x8011369c,%eax
80102a69:	8b 55 08             	mov    0x8(%ebp),%edx
80102a6c:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
80102a6e:	a1 9c 36 11 80       	mov    0x8011369c,%eax
80102a73:	8b 55 0c             	mov    0xc(%ebp),%edx
80102a76:	89 50 10             	mov    %edx,0x10(%eax)
}
80102a79:	90                   	nop
80102a7a:	5d                   	pop    %ebp
80102a7b:	c3                   	ret    

80102a7c <ioapicinit>:

void
ioapicinit(void)
{
80102a7c:	55                   	push   %ebp
80102a7d:	89 e5                	mov    %esp,%ebp
80102a7f:	83 ec 18             	sub    $0x18,%esp
  int i, id, maxintr;

  ioapic = (volatile struct ioapic*)IOAPIC;
80102a82:	c7 05 9c 36 11 80 00 	movl   $0xfec00000,0x8011369c
80102a89:	00 c0 fe 
  maxintr = (ioapicread(REG_VER) >> 16) & 0xFF;
80102a8c:	6a 01                	push   $0x1
80102a8e:	e8 b7 ff ff ff       	call   80102a4a <ioapicread>
80102a93:	83 c4 04             	add    $0x4,%esp
80102a96:	c1 e8 10             	shr    $0x10,%eax
80102a99:	25 ff 00 00 00       	and    $0xff,%eax
80102a9e:	89 45 f0             	mov    %eax,-0x10(%ebp)
  id = ioapicread(REG_ID) >> 24;
80102aa1:	6a 00                	push   $0x0
80102aa3:	e8 a2 ff ff ff       	call   80102a4a <ioapicread>
80102aa8:	83 c4 04             	add    $0x4,%esp
80102aab:	c1 e8 18             	shr    $0x18,%eax
80102aae:	89 45 ec             	mov    %eax,-0x14(%ebp)
  if(id != ioapicid)
80102ab1:	0f b6 05 64 3d 11 80 	movzbl 0x80113d64,%eax
80102ab8:	0f b6 c0             	movzbl %al,%eax
80102abb:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80102abe:	74 10                	je     80102ad0 <ioapicinit+0x54>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102ac0:	83 ec 0c             	sub    $0xc,%esp
80102ac3:	68 2c 98 10 80       	push   $0x8010982c
80102ac8:	e8 33 d9 ff ff       	call   80100400 <cprintf>
80102acd:	83 c4 10             	add    $0x10,%esp

  // Mark all interrupts edge-triggered, active high, disabled,
  // and not routed to any CPUs.
  for(i = 0; i <= maxintr; i++){
80102ad0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80102ad7:	eb 3f                	jmp    80102b18 <ioapicinit+0x9c>
    ioapicwrite(REG_TABLE+2*i, INT_DISABLED | (T_IRQ0 + i));
80102ad9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102adc:	83 c0 20             	add    $0x20,%eax
80102adf:	0d 00 00 01 00       	or     $0x10000,%eax
80102ae4:	89 c2                	mov    %eax,%edx
80102ae6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102ae9:	83 c0 08             	add    $0x8,%eax
80102aec:	01 c0                	add    %eax,%eax
80102aee:	83 ec 08             	sub    $0x8,%esp
80102af1:	52                   	push   %edx
80102af2:	50                   	push   %eax
80102af3:	e8 69 ff ff ff       	call   80102a61 <ioapicwrite>
80102af8:	83 c4 10             	add    $0x10,%esp
    ioapicwrite(REG_TABLE+2*i+1, 0);
80102afb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102afe:	83 c0 08             	add    $0x8,%eax
80102b01:	01 c0                	add    %eax,%eax
80102b03:	83 c0 01             	add    $0x1,%eax
80102b06:	83 ec 08             	sub    $0x8,%esp
80102b09:	6a 00                	push   $0x0
80102b0b:	50                   	push   %eax
80102b0c:	e8 50 ff ff ff       	call   80102a61 <ioapicwrite>
80102b11:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i <= maxintr; i++){
80102b14:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80102b18:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102b1b:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80102b1e:	7e b9                	jle    80102ad9 <ioapicinit+0x5d>
  }
}
80102b20:	90                   	nop
80102b21:	90                   	nop
80102b22:	c9                   	leave  
80102b23:	c3                   	ret    

80102b24 <ioapicenable>:

void
ioapicenable(int irq, int cpunum)
{
80102b24:	55                   	push   %ebp
80102b25:	89 e5                	mov    %esp,%ebp
  // Mark interrupt edge-triggered, active high,
  // enabled, and routed to the given cpunum,
  // which happens to be that cpu's APIC ID.
  ioapicwrite(REG_TABLE+2*irq, T_IRQ0 + irq);
80102b27:	8b 45 08             	mov    0x8(%ebp),%eax
80102b2a:	83 c0 20             	add    $0x20,%eax
80102b2d:	89 c2                	mov    %eax,%edx
80102b2f:	8b 45 08             	mov    0x8(%ebp),%eax
80102b32:	83 c0 08             	add    $0x8,%eax
80102b35:	01 c0                	add    %eax,%eax
80102b37:	52                   	push   %edx
80102b38:	50                   	push   %eax
80102b39:	e8 23 ff ff ff       	call   80102a61 <ioapicwrite>
80102b3e:	83 c4 08             	add    $0x8,%esp
  ioapicwrite(REG_TABLE+2*irq+1, cpunum << 24);
80102b41:	8b 45 0c             	mov    0xc(%ebp),%eax
80102b44:	c1 e0 18             	shl    $0x18,%eax
80102b47:	89 c2                	mov    %eax,%edx
80102b49:	8b 45 08             	mov    0x8(%ebp),%eax
80102b4c:	83 c0 08             	add    $0x8,%eax
80102b4f:	01 c0                	add    %eax,%eax
80102b51:	83 c0 01             	add    $0x1,%eax
80102b54:	52                   	push   %edx
80102b55:	50                   	push   %eax
80102b56:	e8 06 ff ff ff       	call   80102a61 <ioapicwrite>
80102b5b:	83 c4 08             	add    $0x8,%esp
}
80102b5e:	90                   	nop
80102b5f:	c9                   	leave  
80102b60:	c3                   	ret    

80102b61 <kinit1>:
// the pages mapped by entrypgdir on free list.
// 2. main() calls kinit2() with the rest of the physical pages
// after installing a full page table that maps them on all cores.
void
kinit1(void *vstart, void *vend)
{
80102b61:	55                   	push   %ebp
80102b62:	89 e5                	mov    %esp,%ebp
80102b64:	83 ec 08             	sub    $0x8,%esp
  initlock(&kmem.lock, "kmem");
80102b67:	83 ec 08             	sub    $0x8,%esp
80102b6a:	68 5e 98 10 80       	push   $0x8010985e
80102b6f:	68 a0 36 11 80       	push   $0x801136a0
80102b74:	e8 92 34 00 00       	call   8010600b <initlock>
80102b79:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102b7c:	c7 05 d4 36 11 80 00 	movl   $0x0,0x801136d4
80102b83:	00 00 00 
  freerange(vstart, vend);
80102b86:	83 ec 08             	sub    $0x8,%esp
80102b89:	ff 75 0c             	push   0xc(%ebp)
80102b8c:	ff 75 08             	push   0x8(%ebp)
80102b8f:	e8 2a 00 00 00       	call   80102bbe <freerange>
80102b94:	83 c4 10             	add    $0x10,%esp
}
80102b97:	90                   	nop
80102b98:	c9                   	leave  
80102b99:	c3                   	ret    

80102b9a <kinit2>:

void
kinit2(void *vstart, void *vend)
{
80102b9a:	55                   	push   %ebp
80102b9b:	89 e5                	mov    %esp,%ebp
80102b9d:	83 ec 08             	sub    $0x8,%esp
  freerange(vstart, vend);
80102ba0:	83 ec 08             	sub    $0x8,%esp
80102ba3:	ff 75 0c             	push   0xc(%ebp)
80102ba6:	ff 75 08             	push   0x8(%ebp)
80102ba9:	e8 10 00 00 00       	call   80102bbe <freerange>
80102bae:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 1;
80102bb1:	c7 05 d4 36 11 80 01 	movl   $0x1,0x801136d4
80102bb8:	00 00 00 
}
80102bbb:	90                   	nop
80102bbc:	c9                   	leave  
80102bbd:	c3                   	ret    

80102bbe <freerange>:

void
freerange(void *vstart, void *vend)
{
80102bbe:	55                   	push   %ebp
80102bbf:	89 e5                	mov    %esp,%ebp
80102bc1:	83 ec 18             	sub    $0x18,%esp
  char *p;
  p = (char*)PGROUNDUP((uint)vstart);
80102bc4:	8b 45 08             	mov    0x8(%ebp),%eax
80102bc7:	05 ff 0f 00 00       	add    $0xfff,%eax
80102bcc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80102bd1:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102bd4:	eb 15                	jmp    80102beb <freerange+0x2d>
    kfree(p);
80102bd6:	83 ec 0c             	sub    $0xc,%esp
80102bd9:	ff 75 f4             	push   -0xc(%ebp)
80102bdc:	e8 1b 00 00 00       	call   80102bfc <kfree>
80102be1:	83 c4 10             	add    $0x10,%esp
  for(; p + PGSIZE <= (char*)vend; p += PGSIZE)
80102be4:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80102beb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102bee:	05 00 10 00 00       	add    $0x1000,%eax
80102bf3:	39 45 0c             	cmp    %eax,0xc(%ebp)
80102bf6:	73 de                	jae    80102bd6 <freerange+0x18>
}
80102bf8:	90                   	nop
80102bf9:	90                   	nop
80102bfa:	c9                   	leave  
80102bfb:	c3                   	ret    

80102bfc <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(char *v)
{
80102bfc:	55                   	push   %ebp
80102bfd:	89 e5                	mov    %esp,%ebp
80102bff:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if((uint)v % PGSIZE || v < end || V2P(v) >= PHYSTOP)
80102c02:	8b 45 08             	mov    0x8(%ebp),%eax
80102c05:	25 ff 0f 00 00       	and    $0xfff,%eax
80102c0a:	85 c0                	test   %eax,%eax
80102c0c:	75 18                	jne    80102c26 <kfree+0x2a>
80102c0e:	81 7d 08 60 83 11 80 	cmpl   $0x80118360,0x8(%ebp)
80102c15:	72 0f                	jb     80102c26 <kfree+0x2a>
80102c17:	8b 45 08             	mov    0x8(%ebp),%eax
80102c1a:	05 00 00 00 80       	add    $0x80000000,%eax
80102c1f:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102c24:	76 0d                	jbe    80102c33 <kfree+0x37>
    panic("kfree");
80102c26:	83 ec 0c             	sub    $0xc,%esp
80102c29:	68 63 98 10 80       	push   $0x80109863
80102c2e:	e8 82 d9 ff ff       	call   801005b5 <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102c33:	83 ec 04             	sub    $0x4,%esp
80102c36:	68 00 10 00 00       	push   $0x1000
80102c3b:	6a 01                	push   $0x1
80102c3d:	ff 75 08             	push   0x8(%ebp)
80102c40:	e8 6e 36 00 00       	call   801062b3 <memset>
80102c45:	83 c4 10             	add    $0x10,%esp

  if(kmem.use_lock)
80102c48:	a1 d4 36 11 80       	mov    0x801136d4,%eax
80102c4d:	85 c0                	test   %eax,%eax
80102c4f:	74 10                	je     80102c61 <kfree+0x65>
    acquire(&kmem.lock);
80102c51:	83 ec 0c             	sub    $0xc,%esp
80102c54:	68 a0 36 11 80       	push   $0x801136a0
80102c59:	e8 cf 33 00 00       	call   8010602d <acquire>
80102c5e:	83 c4 10             	add    $0x10,%esp
  r = (struct run*)v;
80102c61:	8b 45 08             	mov    0x8(%ebp),%eax
80102c64:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80102c67:	8b 15 d8 36 11 80    	mov    0x801136d8,%edx
80102c6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c70:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80102c72:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c75:	a3 d8 36 11 80       	mov    %eax,0x801136d8
  if(kmem.use_lock)
80102c7a:	a1 d4 36 11 80       	mov    0x801136d4,%eax
80102c7f:	85 c0                	test   %eax,%eax
80102c81:	74 10                	je     80102c93 <kfree+0x97>
    release(&kmem.lock);
80102c83:	83 ec 0c             	sub    $0xc,%esp
80102c86:	68 a0 36 11 80       	push   $0x801136a0
80102c8b:	e8 0b 34 00 00       	call   8010609b <release>
80102c90:	83 c4 10             	add    $0x10,%esp
}
80102c93:	90                   	nop
80102c94:	c9                   	leave  
80102c95:	c3                   	ret    

80102c96 <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
char*
kalloc(void)
{
80102c96:	55                   	push   %ebp
80102c97:	89 e5                	mov    %esp,%ebp
80102c99:	83 ec 18             	sub    $0x18,%esp
  struct run *r;

  if(kmem.use_lock)
80102c9c:	a1 d4 36 11 80       	mov    0x801136d4,%eax
80102ca1:	85 c0                	test   %eax,%eax
80102ca3:	74 10                	je     80102cb5 <kalloc+0x1f>
    acquire(&kmem.lock);
80102ca5:	83 ec 0c             	sub    $0xc,%esp
80102ca8:	68 a0 36 11 80       	push   $0x801136a0
80102cad:	e8 7b 33 00 00       	call   8010602d <acquire>
80102cb2:	83 c4 10             	add    $0x10,%esp
  r = kmem.freelist;
80102cb5:	a1 d8 36 11 80       	mov    0x801136d8,%eax
80102cba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
80102cbd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102cc1:	74 0a                	je     80102ccd <kalloc+0x37>
    kmem.freelist = r->next;
80102cc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102cc6:	8b 00                	mov    (%eax),%eax
80102cc8:	a3 d8 36 11 80       	mov    %eax,0x801136d8
  if(kmem.use_lock)
80102ccd:	a1 d4 36 11 80       	mov    0x801136d4,%eax
80102cd2:	85 c0                	test   %eax,%eax
80102cd4:	74 10                	je     80102ce6 <kalloc+0x50>
    release(&kmem.lock);
80102cd6:	83 ec 0c             	sub    $0xc,%esp
80102cd9:	68 a0 36 11 80       	push   $0x801136a0
80102cde:	e8 b8 33 00 00       	call   8010609b <release>
80102ce3:	83 c4 10             	add    $0x10,%esp
  return (char*)r;
80102ce6:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80102ce9:	c9                   	leave  
80102cea:	c3                   	ret    

80102ceb <inb>:
{
80102ceb:	55                   	push   %ebp
80102cec:	89 e5                	mov    %esp,%ebp
80102cee:	83 ec 14             	sub    $0x14,%esp
80102cf1:	8b 45 08             	mov    0x8(%ebp),%eax
80102cf4:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102cf8:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102cfc:	89 c2                	mov    %eax,%edx
80102cfe:	ec                   	in     (%dx),%al
80102cff:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102d02:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102d06:	c9                   	leave  
80102d07:	c3                   	ret    

80102d08 <kbdgetc>:
#include "defs.h"
#include "kbd.h"

int
kbdgetc(void)
{
80102d08:	55                   	push   %ebp
80102d09:	89 e5                	mov    %esp,%ebp
80102d0b:	83 ec 10             	sub    $0x10,%esp
  static uchar *charcode[4] = {
    normalmap, shiftmap, ctlmap, ctlmap
  };
  uint st, data, c;

  st = inb(KBSTATP);
80102d0e:	6a 64                	push   $0x64
80102d10:	e8 d6 ff ff ff       	call   80102ceb <inb>
80102d15:	83 c4 04             	add    $0x4,%esp
80102d18:	0f b6 c0             	movzbl %al,%eax
80102d1b:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((st & KBS_DIB) == 0)
80102d1e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102d21:	83 e0 01             	and    $0x1,%eax
80102d24:	85 c0                	test   %eax,%eax
80102d26:	75 0a                	jne    80102d32 <kbdgetc+0x2a>
    return -1;
80102d28:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80102d2d:	e9 23 01 00 00       	jmp    80102e55 <kbdgetc+0x14d>
  data = inb(KBDATAP);
80102d32:	6a 60                	push   $0x60
80102d34:	e8 b2 ff ff ff       	call   80102ceb <inb>
80102d39:	83 c4 04             	add    $0x4,%esp
80102d3c:	0f b6 c0             	movzbl %al,%eax
80102d3f:	89 45 fc             	mov    %eax,-0x4(%ebp)

  if(data == 0xE0){
80102d42:	81 7d fc e0 00 00 00 	cmpl   $0xe0,-0x4(%ebp)
80102d49:	75 17                	jne    80102d62 <kbdgetc+0x5a>
    shift |= E0ESC;
80102d4b:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80102d50:	83 c8 40             	or     $0x40,%eax
80102d53:	a3 dc 36 11 80       	mov    %eax,0x801136dc
    return 0;
80102d58:	b8 00 00 00 00       	mov    $0x0,%eax
80102d5d:	e9 f3 00 00 00       	jmp    80102e55 <kbdgetc+0x14d>
  } else if(data & 0x80){
80102d62:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d65:	25 80 00 00 00       	and    $0x80,%eax
80102d6a:	85 c0                	test   %eax,%eax
80102d6c:	74 45                	je     80102db3 <kbdgetc+0xab>
    // Key released
    data = (shift & E0ESC ? data : data & 0x7F);
80102d6e:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80102d73:	83 e0 40             	and    $0x40,%eax
80102d76:	85 c0                	test   %eax,%eax
80102d78:	75 08                	jne    80102d82 <kbdgetc+0x7a>
80102d7a:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d7d:	83 e0 7f             	and    $0x7f,%eax
80102d80:	eb 03                	jmp    80102d85 <kbdgetc+0x7d>
80102d82:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d85:	89 45 fc             	mov    %eax,-0x4(%ebp)
    shift &= ~(shiftcode[data] | E0ESC);
80102d88:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102d8b:	05 20 a0 10 80       	add    $0x8010a020,%eax
80102d90:	0f b6 00             	movzbl (%eax),%eax
80102d93:	83 c8 40             	or     $0x40,%eax
80102d96:	0f b6 c0             	movzbl %al,%eax
80102d99:	f7 d0                	not    %eax
80102d9b:	89 c2                	mov    %eax,%edx
80102d9d:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80102da2:	21 d0                	and    %edx,%eax
80102da4:	a3 dc 36 11 80       	mov    %eax,0x801136dc
    return 0;
80102da9:	b8 00 00 00 00       	mov    $0x0,%eax
80102dae:	e9 a2 00 00 00       	jmp    80102e55 <kbdgetc+0x14d>
  } else if(shift & E0ESC){
80102db3:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80102db8:	83 e0 40             	and    $0x40,%eax
80102dbb:	85 c0                	test   %eax,%eax
80102dbd:	74 14                	je     80102dd3 <kbdgetc+0xcb>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102dbf:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80102dc6:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80102dcb:	83 e0 bf             	and    $0xffffffbf,%eax
80102dce:	a3 dc 36 11 80       	mov    %eax,0x801136dc
  }

  shift |= shiftcode[data];
80102dd3:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102dd6:	05 20 a0 10 80       	add    $0x8010a020,%eax
80102ddb:	0f b6 00             	movzbl (%eax),%eax
80102dde:	0f b6 d0             	movzbl %al,%edx
80102de1:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80102de6:	09 d0                	or     %edx,%eax
80102de8:	a3 dc 36 11 80       	mov    %eax,0x801136dc
  shift ^= togglecode[data];
80102ded:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102df0:	05 20 a1 10 80       	add    $0x8010a120,%eax
80102df5:	0f b6 00             	movzbl (%eax),%eax
80102df8:	0f b6 d0             	movzbl %al,%edx
80102dfb:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80102e00:	31 d0                	xor    %edx,%eax
80102e02:	a3 dc 36 11 80       	mov    %eax,0x801136dc
  c = charcode[shift & (CTL | SHIFT)][data];
80102e07:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80102e0c:	83 e0 03             	and    $0x3,%eax
80102e0f:	8b 14 85 20 a5 10 80 	mov    -0x7fef5ae0(,%eax,4),%edx
80102e16:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102e19:	01 d0                	add    %edx,%eax
80102e1b:	0f b6 00             	movzbl (%eax),%eax
80102e1e:	0f b6 c0             	movzbl %al,%eax
80102e21:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
80102e24:	a1 dc 36 11 80       	mov    0x801136dc,%eax
80102e29:	83 e0 08             	and    $0x8,%eax
80102e2c:	85 c0                	test   %eax,%eax
80102e2e:	74 22                	je     80102e52 <kbdgetc+0x14a>
    if('a' <= c && c <= 'z')
80102e30:	83 7d f8 60          	cmpl   $0x60,-0x8(%ebp)
80102e34:	76 0c                	jbe    80102e42 <kbdgetc+0x13a>
80102e36:	83 7d f8 7a          	cmpl   $0x7a,-0x8(%ebp)
80102e3a:	77 06                	ja     80102e42 <kbdgetc+0x13a>
      c += 'A' - 'a';
80102e3c:	83 6d f8 20          	subl   $0x20,-0x8(%ebp)
80102e40:	eb 10                	jmp    80102e52 <kbdgetc+0x14a>
    else if('A' <= c && c <= 'Z')
80102e42:	83 7d f8 40          	cmpl   $0x40,-0x8(%ebp)
80102e46:	76 0a                	jbe    80102e52 <kbdgetc+0x14a>
80102e48:	83 7d f8 5a          	cmpl   $0x5a,-0x8(%ebp)
80102e4c:	77 04                	ja     80102e52 <kbdgetc+0x14a>
      c += 'a' - 'A';
80102e4e:	83 45 f8 20          	addl   $0x20,-0x8(%ebp)
  }
  return c;
80102e52:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80102e55:	c9                   	leave  
80102e56:	c3                   	ret    

80102e57 <kbdintr>:

void
kbdintr(void)
{
80102e57:	55                   	push   %ebp
80102e58:	89 e5                	mov    %esp,%ebp
80102e5a:	83 ec 08             	sub    $0x8,%esp
  consoleintr(kbdgetc);
80102e5d:	83 ec 0c             	sub    $0xc,%esp
80102e60:	68 08 2d 10 80       	push   $0x80102d08
80102e65:	e8 e5 d9 ff ff       	call   8010084f <consoleintr>
80102e6a:	83 c4 10             	add    $0x10,%esp
}
80102e6d:	90                   	nop
80102e6e:	c9                   	leave  
80102e6f:	c3                   	ret    

80102e70 <inb>:
{
80102e70:	55                   	push   %ebp
80102e71:	89 e5                	mov    %esp,%ebp
80102e73:	83 ec 14             	sub    $0x14,%esp
80102e76:	8b 45 08             	mov    0x8(%ebp),%eax
80102e79:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80102e7d:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80102e81:	89 c2                	mov    %eax,%edx
80102e83:	ec                   	in     (%dx),%al
80102e84:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80102e87:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80102e8b:	c9                   	leave  
80102e8c:	c3                   	ret    

80102e8d <outb>:
{
80102e8d:	55                   	push   %ebp
80102e8e:	89 e5                	mov    %esp,%ebp
80102e90:	83 ec 08             	sub    $0x8,%esp
80102e93:	8b 45 08             	mov    0x8(%ebp),%eax
80102e96:	8b 55 0c             	mov    0xc(%ebp),%edx
80102e99:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80102e9d:	89 d0                	mov    %edx,%eax
80102e9f:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80102ea2:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80102ea6:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80102eaa:	ee                   	out    %al,(%dx)
}
80102eab:	90                   	nop
80102eac:	c9                   	leave  
80102ead:	c3                   	ret    

80102eae <lapicw>:
volatile uint *lapic;  // Initialized in mp.c

//PAGEBREAK!
static void
lapicw(int index, int value)
{
80102eae:	55                   	push   %ebp
80102eaf:	89 e5                	mov    %esp,%ebp
  lapic[index] = value;
80102eb1:	8b 15 e0 36 11 80    	mov    0x801136e0,%edx
80102eb7:	8b 45 08             	mov    0x8(%ebp),%eax
80102eba:	c1 e0 02             	shl    $0x2,%eax
80102ebd:	01 c2                	add    %eax,%edx
80102ebf:	8b 45 0c             	mov    0xc(%ebp),%eax
80102ec2:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
80102ec4:	a1 e0 36 11 80       	mov    0x801136e0,%eax
80102ec9:	83 c0 20             	add    $0x20,%eax
80102ecc:	8b 00                	mov    (%eax),%eax
}
80102ece:	90                   	nop
80102ecf:	5d                   	pop    %ebp
80102ed0:	c3                   	ret    

80102ed1 <lapicinit>:

void
lapicinit(void)
{
80102ed1:	55                   	push   %ebp
80102ed2:	89 e5                	mov    %esp,%ebp
  if(!lapic)
80102ed4:	a1 e0 36 11 80       	mov    0x801136e0,%eax
80102ed9:	85 c0                	test   %eax,%eax
80102edb:	0f 84 0c 01 00 00    	je     80102fed <lapicinit+0x11c>
    return;

  // Enable local APIC; set spurious interrupt vector.
  lapicw(SVR, ENABLE | (T_IRQ0 + IRQ_SPURIOUS));
80102ee1:	68 3f 01 00 00       	push   $0x13f
80102ee6:	6a 3c                	push   $0x3c
80102ee8:	e8 c1 ff ff ff       	call   80102eae <lapicw>
80102eed:	83 c4 08             	add    $0x8,%esp

  // The timer repeatedly counts down at bus frequency
  // from lapic[TICR] and then issues an interrupt.
  // If xv6 cared more about precise timekeeping,
  // TICR would be calibrated using an external time source.
  lapicw(TDCR, X1);
80102ef0:	6a 0b                	push   $0xb
80102ef2:	68 f8 00 00 00       	push   $0xf8
80102ef7:	e8 b2 ff ff ff       	call   80102eae <lapicw>
80102efc:	83 c4 08             	add    $0x8,%esp
  lapicw(TIMER, PERIODIC | (T_IRQ0 + IRQ_TIMER));
80102eff:	68 20 00 02 00       	push   $0x20020
80102f04:	68 c8 00 00 00       	push   $0xc8
80102f09:	e8 a0 ff ff ff       	call   80102eae <lapicw>
80102f0e:	83 c4 08             	add    $0x8,%esp
  lapicw(TICR, 10000000);
80102f11:	68 80 96 98 00       	push   $0x989680
80102f16:	68 e0 00 00 00       	push   $0xe0
80102f1b:	e8 8e ff ff ff       	call   80102eae <lapicw>
80102f20:	83 c4 08             	add    $0x8,%esp

  // Disable logical interrupt lines.
  lapicw(LINT0, MASKED);
80102f23:	68 00 00 01 00       	push   $0x10000
80102f28:	68 d4 00 00 00       	push   $0xd4
80102f2d:	e8 7c ff ff ff       	call   80102eae <lapicw>
80102f32:	83 c4 08             	add    $0x8,%esp
  lapicw(LINT1, MASKED);
80102f35:	68 00 00 01 00       	push   $0x10000
80102f3a:	68 d8 00 00 00       	push   $0xd8
80102f3f:	e8 6a ff ff ff       	call   80102eae <lapicw>
80102f44:	83 c4 08             	add    $0x8,%esp

  // Disable performance counter overflow interrupts
  // on machines that provide that interrupt entry.
  if(((lapic[VER]>>16) & 0xFF) >= 4)
80102f47:	a1 e0 36 11 80       	mov    0x801136e0,%eax
80102f4c:	83 c0 30             	add    $0x30,%eax
80102f4f:	8b 00                	mov    (%eax),%eax
80102f51:	c1 e8 10             	shr    $0x10,%eax
80102f54:	25 fc 00 00 00       	and    $0xfc,%eax
80102f59:	85 c0                	test   %eax,%eax
80102f5b:	74 12                	je     80102f6f <lapicinit+0x9e>
    lapicw(PCINT, MASKED);
80102f5d:	68 00 00 01 00       	push   $0x10000
80102f62:	68 d0 00 00 00       	push   $0xd0
80102f67:	e8 42 ff ff ff       	call   80102eae <lapicw>
80102f6c:	83 c4 08             	add    $0x8,%esp

  // Map error interrupt to IRQ_ERROR.
  lapicw(ERROR, T_IRQ0 + IRQ_ERROR);
80102f6f:	6a 33                	push   $0x33
80102f71:	68 dc 00 00 00       	push   $0xdc
80102f76:	e8 33 ff ff ff       	call   80102eae <lapicw>
80102f7b:	83 c4 08             	add    $0x8,%esp

  // Clear error status register (requires back-to-back writes).
  lapicw(ESR, 0);
80102f7e:	6a 00                	push   $0x0
80102f80:	68 a0 00 00 00       	push   $0xa0
80102f85:	e8 24 ff ff ff       	call   80102eae <lapicw>
80102f8a:	83 c4 08             	add    $0x8,%esp
  lapicw(ESR, 0);
80102f8d:	6a 00                	push   $0x0
80102f8f:	68 a0 00 00 00       	push   $0xa0
80102f94:	e8 15 ff ff ff       	call   80102eae <lapicw>
80102f99:	83 c4 08             	add    $0x8,%esp

  // Ack any outstanding interrupts.
  lapicw(EOI, 0);
80102f9c:	6a 00                	push   $0x0
80102f9e:	6a 2c                	push   $0x2c
80102fa0:	e8 09 ff ff ff       	call   80102eae <lapicw>
80102fa5:	83 c4 08             	add    $0x8,%esp

  // Send an Init Level De-Assert to synchronise arbitration ID's.
  lapicw(ICRHI, 0);
80102fa8:	6a 00                	push   $0x0
80102faa:	68 c4 00 00 00       	push   $0xc4
80102faf:	e8 fa fe ff ff       	call   80102eae <lapicw>
80102fb4:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, BCAST | INIT | LEVEL);
80102fb7:	68 00 85 08 00       	push   $0x88500
80102fbc:	68 c0 00 00 00       	push   $0xc0
80102fc1:	e8 e8 fe ff ff       	call   80102eae <lapicw>
80102fc6:	83 c4 08             	add    $0x8,%esp
  while(lapic[ICRLO] & DELIVS)
80102fc9:	90                   	nop
80102fca:	a1 e0 36 11 80       	mov    0x801136e0,%eax
80102fcf:	05 00 03 00 00       	add    $0x300,%eax
80102fd4:	8b 00                	mov    (%eax),%eax
80102fd6:	25 00 10 00 00       	and    $0x1000,%eax
80102fdb:	85 c0                	test   %eax,%eax
80102fdd:	75 eb                	jne    80102fca <lapicinit+0xf9>
    ;

  // Enable interrupts on the APIC (but not on the processor).
  lapicw(TPR, 0);
80102fdf:	6a 00                	push   $0x0
80102fe1:	6a 20                	push   $0x20
80102fe3:	e8 c6 fe ff ff       	call   80102eae <lapicw>
80102fe8:	83 c4 08             	add    $0x8,%esp
80102feb:	eb 01                	jmp    80102fee <lapicinit+0x11d>
    return;
80102fed:	90                   	nop
}
80102fee:	c9                   	leave  
80102fef:	c3                   	ret    

80102ff0 <lapicid>:

int
lapicid(void)
{
80102ff0:	55                   	push   %ebp
80102ff1:	89 e5                	mov    %esp,%ebp
  if (!lapic)
80102ff3:	a1 e0 36 11 80       	mov    0x801136e0,%eax
80102ff8:	85 c0                	test   %eax,%eax
80102ffa:	75 07                	jne    80103003 <lapicid+0x13>
    return 0;
80102ffc:	b8 00 00 00 00       	mov    $0x0,%eax
80103001:	eb 0d                	jmp    80103010 <lapicid+0x20>
  return lapic[ID] >> 24;
80103003:	a1 e0 36 11 80       	mov    0x801136e0,%eax
80103008:	83 c0 20             	add    $0x20,%eax
8010300b:	8b 00                	mov    (%eax),%eax
8010300d:	c1 e8 18             	shr    $0x18,%eax
}
80103010:	5d                   	pop    %ebp
80103011:	c3                   	ret    

80103012 <lapiceoi>:

// Acknowledge interrupt.
void
lapiceoi(void)
{
80103012:	55                   	push   %ebp
80103013:	89 e5                	mov    %esp,%ebp
  if(lapic)
80103015:	a1 e0 36 11 80       	mov    0x801136e0,%eax
8010301a:	85 c0                	test   %eax,%eax
8010301c:	74 0c                	je     8010302a <lapiceoi+0x18>
    lapicw(EOI, 0);
8010301e:	6a 00                	push   $0x0
80103020:	6a 2c                	push   $0x2c
80103022:	e8 87 fe ff ff       	call   80102eae <lapicw>
80103027:	83 c4 08             	add    $0x8,%esp
}
8010302a:	90                   	nop
8010302b:	c9                   	leave  
8010302c:	c3                   	ret    

8010302d <microdelay>:

// Spin for a given number of microseconds.
// On real hardware would want to tune this dynamically.
void
microdelay(int us)
{
8010302d:	55                   	push   %ebp
8010302e:	89 e5                	mov    %esp,%ebp
}
80103030:	90                   	nop
80103031:	5d                   	pop    %ebp
80103032:	c3                   	ret    

80103033 <lapicstartap>:

// Start additional processor running entry code at addr.
// See Appendix B of MultiProcessor Specification.
void
lapicstartap(uchar apicid, uint addr)
{
80103033:	55                   	push   %ebp
80103034:	89 e5                	mov    %esp,%ebp
80103036:	83 ec 14             	sub    $0x14,%esp
80103039:	8b 45 08             	mov    0x8(%ebp),%eax
8010303c:	88 45 ec             	mov    %al,-0x14(%ebp)
  ushort *wrv;

  // "The BSP must initialize CMOS shutdown code to 0AH
  // and the warm reset vector (DWORD based at 40:67) to point at
  // the AP startup code prior to the [universal startup algorithm]."
  outb(CMOS_PORT, 0xF);  // offset 0xF is shutdown code
8010303f:	6a 0f                	push   $0xf
80103041:	6a 70                	push   $0x70
80103043:	e8 45 fe ff ff       	call   80102e8d <outb>
80103048:	83 c4 08             	add    $0x8,%esp
  outb(CMOS_PORT+1, 0x0A);
8010304b:	6a 0a                	push   $0xa
8010304d:	6a 71                	push   $0x71
8010304f:	e8 39 fe ff ff       	call   80102e8d <outb>
80103054:	83 c4 08             	add    $0x8,%esp
  wrv = (ushort*)P2V((0x40<<4 | 0x67));  // Warm reset vector
80103057:	c7 45 f8 67 04 00 80 	movl   $0x80000467,-0x8(%ebp)
  wrv[0] = 0;
8010305e:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103061:	66 c7 00 00 00       	movw   $0x0,(%eax)
  wrv[1] = addr >> 4;
80103066:	8b 45 0c             	mov    0xc(%ebp),%eax
80103069:	c1 e8 04             	shr    $0x4,%eax
8010306c:	89 c2                	mov    %eax,%edx
8010306e:	8b 45 f8             	mov    -0x8(%ebp),%eax
80103071:	83 c0 02             	add    $0x2,%eax
80103074:	66 89 10             	mov    %dx,(%eax)

  // "Universal startup algorithm."
  // Send INIT (level-triggered) interrupt to reset other CPU.
  lapicw(ICRHI, apicid<<24);
80103077:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
8010307b:	c1 e0 18             	shl    $0x18,%eax
8010307e:	50                   	push   %eax
8010307f:	68 c4 00 00 00       	push   $0xc4
80103084:	e8 25 fe ff ff       	call   80102eae <lapicw>
80103089:	83 c4 08             	add    $0x8,%esp
  lapicw(ICRLO, INIT | LEVEL | ASSERT);
8010308c:	68 00 c5 00 00       	push   $0xc500
80103091:	68 c0 00 00 00       	push   $0xc0
80103096:	e8 13 fe ff ff       	call   80102eae <lapicw>
8010309b:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
8010309e:	68 c8 00 00 00       	push   $0xc8
801030a3:	e8 85 ff ff ff       	call   8010302d <microdelay>
801030a8:	83 c4 04             	add    $0x4,%esp
  lapicw(ICRLO, INIT | LEVEL);
801030ab:	68 00 85 00 00       	push   $0x8500
801030b0:	68 c0 00 00 00       	push   $0xc0
801030b5:	e8 f4 fd ff ff       	call   80102eae <lapicw>
801030ba:	83 c4 08             	add    $0x8,%esp
  microdelay(100);    // should be 10ms, but too slow in Bochs!
801030bd:	6a 64                	push   $0x64
801030bf:	e8 69 ff ff ff       	call   8010302d <microdelay>
801030c4:	83 c4 04             	add    $0x4,%esp
  // Send startup IPI (twice!) to enter code.
  // Regular hardware is supposed to only accept a STARTUP
  // when it is in the halted state due to an INIT.  So the second
  // should be ignored, but it is part of the official Intel algorithm.
  // Bochs complains about the second one.  Too bad for Bochs.
  for(i = 0; i < 2; i++){
801030c7:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
801030ce:	eb 3d                	jmp    8010310d <lapicstartap+0xda>
    lapicw(ICRHI, apicid<<24);
801030d0:	0f b6 45 ec          	movzbl -0x14(%ebp),%eax
801030d4:	c1 e0 18             	shl    $0x18,%eax
801030d7:	50                   	push   %eax
801030d8:	68 c4 00 00 00       	push   $0xc4
801030dd:	e8 cc fd ff ff       	call   80102eae <lapicw>
801030e2:	83 c4 08             	add    $0x8,%esp
    lapicw(ICRLO, STARTUP | (addr>>12));
801030e5:	8b 45 0c             	mov    0xc(%ebp),%eax
801030e8:	c1 e8 0c             	shr    $0xc,%eax
801030eb:	80 cc 06             	or     $0x6,%ah
801030ee:	50                   	push   %eax
801030ef:	68 c0 00 00 00       	push   $0xc0
801030f4:	e8 b5 fd ff ff       	call   80102eae <lapicw>
801030f9:	83 c4 08             	add    $0x8,%esp
    microdelay(200);
801030fc:	68 c8 00 00 00       	push   $0xc8
80103101:	e8 27 ff ff ff       	call   8010302d <microdelay>
80103106:	83 c4 04             	add    $0x4,%esp
  for(i = 0; i < 2; i++){
80103109:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010310d:	83 7d fc 01          	cmpl   $0x1,-0x4(%ebp)
80103111:	7e bd                	jle    801030d0 <lapicstartap+0x9d>
  }
}
80103113:	90                   	nop
80103114:	90                   	nop
80103115:	c9                   	leave  
80103116:	c3                   	ret    

80103117 <cmos_read>:
#define MONTH   0x08
#define YEAR    0x09

static uint
cmos_read(uint reg)
{
80103117:	55                   	push   %ebp
80103118:	89 e5                	mov    %esp,%ebp
  outb(CMOS_PORT,  reg);
8010311a:	8b 45 08             	mov    0x8(%ebp),%eax
8010311d:	0f b6 c0             	movzbl %al,%eax
80103120:	50                   	push   %eax
80103121:	6a 70                	push   $0x70
80103123:	e8 65 fd ff ff       	call   80102e8d <outb>
80103128:	83 c4 08             	add    $0x8,%esp
  microdelay(200);
8010312b:	68 c8 00 00 00       	push   $0xc8
80103130:	e8 f8 fe ff ff       	call   8010302d <microdelay>
80103135:	83 c4 04             	add    $0x4,%esp

  return inb(CMOS_RETURN);
80103138:	6a 71                	push   $0x71
8010313a:	e8 31 fd ff ff       	call   80102e70 <inb>
8010313f:	83 c4 04             	add    $0x4,%esp
80103142:	0f b6 c0             	movzbl %al,%eax
}
80103145:	c9                   	leave  
80103146:	c3                   	ret    

80103147 <fill_rtcdate>:

static void
fill_rtcdate(struct rtcdate *r)
{
80103147:	55                   	push   %ebp
80103148:	89 e5                	mov    %esp,%ebp
  r->second = cmos_read(SECS);
8010314a:	6a 00                	push   $0x0
8010314c:	e8 c6 ff ff ff       	call   80103117 <cmos_read>
80103151:	83 c4 04             	add    $0x4,%esp
80103154:	8b 55 08             	mov    0x8(%ebp),%edx
80103157:	89 02                	mov    %eax,(%edx)
  r->minute = cmos_read(MINS);
80103159:	6a 02                	push   $0x2
8010315b:	e8 b7 ff ff ff       	call   80103117 <cmos_read>
80103160:	83 c4 04             	add    $0x4,%esp
80103163:	8b 55 08             	mov    0x8(%ebp),%edx
80103166:	89 42 04             	mov    %eax,0x4(%edx)
  r->hour   = cmos_read(HOURS);
80103169:	6a 04                	push   $0x4
8010316b:	e8 a7 ff ff ff       	call   80103117 <cmos_read>
80103170:	83 c4 04             	add    $0x4,%esp
80103173:	8b 55 08             	mov    0x8(%ebp),%edx
80103176:	89 42 08             	mov    %eax,0x8(%edx)
  r->day    = cmos_read(DAY);
80103179:	6a 07                	push   $0x7
8010317b:	e8 97 ff ff ff       	call   80103117 <cmos_read>
80103180:	83 c4 04             	add    $0x4,%esp
80103183:	8b 55 08             	mov    0x8(%ebp),%edx
80103186:	89 42 0c             	mov    %eax,0xc(%edx)
  r->month  = cmos_read(MONTH);
80103189:	6a 08                	push   $0x8
8010318b:	e8 87 ff ff ff       	call   80103117 <cmos_read>
80103190:	83 c4 04             	add    $0x4,%esp
80103193:	8b 55 08             	mov    0x8(%ebp),%edx
80103196:	89 42 10             	mov    %eax,0x10(%edx)
  r->year   = cmos_read(YEAR);
80103199:	6a 09                	push   $0x9
8010319b:	e8 77 ff ff ff       	call   80103117 <cmos_read>
801031a0:	83 c4 04             	add    $0x4,%esp
801031a3:	8b 55 08             	mov    0x8(%ebp),%edx
801031a6:	89 42 14             	mov    %eax,0x14(%edx)
}
801031a9:	90                   	nop
801031aa:	c9                   	leave  
801031ab:	c3                   	ret    

801031ac <cmostime>:

// qemu seems to use 24-hour GWT and the values are BCD encoded
void
cmostime(struct rtcdate *r)
{
801031ac:	55                   	push   %ebp
801031ad:	89 e5                	mov    %esp,%ebp
801031af:	83 ec 48             	sub    $0x48,%esp
  struct rtcdate t1, t2;
  int sb, bcd;

  sb = cmos_read(CMOS_STATB);
801031b2:	6a 0b                	push   $0xb
801031b4:	e8 5e ff ff ff       	call   80103117 <cmos_read>
801031b9:	83 c4 04             	add    $0x4,%esp
801031bc:	89 45 f4             	mov    %eax,-0xc(%ebp)

  bcd = (sb & (1 << 2)) == 0;
801031bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801031c2:	83 e0 04             	and    $0x4,%eax
801031c5:	85 c0                	test   %eax,%eax
801031c7:	0f 94 c0             	sete   %al
801031ca:	0f b6 c0             	movzbl %al,%eax
801031cd:	89 45 f0             	mov    %eax,-0x10(%ebp)

  // make sure CMOS doesn't modify time while we read it
  for(;;) {
    fill_rtcdate(&t1);
801031d0:	8d 45 d8             	lea    -0x28(%ebp),%eax
801031d3:	50                   	push   %eax
801031d4:	e8 6e ff ff ff       	call   80103147 <fill_rtcdate>
801031d9:	83 c4 04             	add    $0x4,%esp
    if(cmos_read(CMOS_STATA) & CMOS_UIP)
801031dc:	6a 0a                	push   $0xa
801031de:	e8 34 ff ff ff       	call   80103117 <cmos_read>
801031e3:	83 c4 04             	add    $0x4,%esp
801031e6:	25 80 00 00 00       	and    $0x80,%eax
801031eb:	85 c0                	test   %eax,%eax
801031ed:	75 27                	jne    80103216 <cmostime+0x6a>
        continue;
    fill_rtcdate(&t2);
801031ef:	8d 45 c0             	lea    -0x40(%ebp),%eax
801031f2:	50                   	push   %eax
801031f3:	e8 4f ff ff ff       	call   80103147 <fill_rtcdate>
801031f8:	83 c4 04             	add    $0x4,%esp
    if(memcmp(&t1, &t2, sizeof(t1)) == 0)
801031fb:	83 ec 04             	sub    $0x4,%esp
801031fe:	6a 18                	push   $0x18
80103200:	8d 45 c0             	lea    -0x40(%ebp),%eax
80103203:	50                   	push   %eax
80103204:	8d 45 d8             	lea    -0x28(%ebp),%eax
80103207:	50                   	push   %eax
80103208:	e8 0d 31 00 00       	call   8010631a <memcmp>
8010320d:	83 c4 10             	add    $0x10,%esp
80103210:	85 c0                	test   %eax,%eax
80103212:	74 05                	je     80103219 <cmostime+0x6d>
80103214:	eb ba                	jmp    801031d0 <cmostime+0x24>
        continue;
80103216:	90                   	nop
    fill_rtcdate(&t1);
80103217:	eb b7                	jmp    801031d0 <cmostime+0x24>
      break;
80103219:	90                   	nop
  }

  // convert
  if(bcd) {
8010321a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010321e:	0f 84 b4 00 00 00    	je     801032d8 <cmostime+0x12c>
#define    CONV(x)     (t1.x = ((t1.x >> 4) * 10) + (t1.x & 0xf))
    CONV(second);
80103224:	8b 45 d8             	mov    -0x28(%ebp),%eax
80103227:	c1 e8 04             	shr    $0x4,%eax
8010322a:	89 c2                	mov    %eax,%edx
8010322c:	89 d0                	mov    %edx,%eax
8010322e:	c1 e0 02             	shl    $0x2,%eax
80103231:	01 d0                	add    %edx,%eax
80103233:	01 c0                	add    %eax,%eax
80103235:	89 c2                	mov    %eax,%edx
80103237:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010323a:	83 e0 0f             	and    $0xf,%eax
8010323d:	01 d0                	add    %edx,%eax
8010323f:	89 45 d8             	mov    %eax,-0x28(%ebp)
    CONV(minute);
80103242:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103245:	c1 e8 04             	shr    $0x4,%eax
80103248:	89 c2                	mov    %eax,%edx
8010324a:	89 d0                	mov    %edx,%eax
8010324c:	c1 e0 02             	shl    $0x2,%eax
8010324f:	01 d0                	add    %edx,%eax
80103251:	01 c0                	add    %eax,%eax
80103253:	89 c2                	mov    %eax,%edx
80103255:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103258:	83 e0 0f             	and    $0xf,%eax
8010325b:	01 d0                	add    %edx,%eax
8010325d:	89 45 dc             	mov    %eax,-0x24(%ebp)
    CONV(hour  );
80103260:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103263:	c1 e8 04             	shr    $0x4,%eax
80103266:	89 c2                	mov    %eax,%edx
80103268:	89 d0                	mov    %edx,%eax
8010326a:	c1 e0 02             	shl    $0x2,%eax
8010326d:	01 d0                	add    %edx,%eax
8010326f:	01 c0                	add    %eax,%eax
80103271:	89 c2                	mov    %eax,%edx
80103273:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103276:	83 e0 0f             	and    $0xf,%eax
80103279:	01 d0                	add    %edx,%eax
8010327b:	89 45 e0             	mov    %eax,-0x20(%ebp)
    CONV(day   );
8010327e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103281:	c1 e8 04             	shr    $0x4,%eax
80103284:	89 c2                	mov    %eax,%edx
80103286:	89 d0                	mov    %edx,%eax
80103288:	c1 e0 02             	shl    $0x2,%eax
8010328b:	01 d0                	add    %edx,%eax
8010328d:	01 c0                	add    %eax,%eax
8010328f:	89 c2                	mov    %eax,%edx
80103291:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103294:	83 e0 0f             	and    $0xf,%eax
80103297:	01 d0                	add    %edx,%eax
80103299:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    CONV(month );
8010329c:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010329f:	c1 e8 04             	shr    $0x4,%eax
801032a2:	89 c2                	mov    %eax,%edx
801032a4:	89 d0                	mov    %edx,%eax
801032a6:	c1 e0 02             	shl    $0x2,%eax
801032a9:	01 d0                	add    %edx,%eax
801032ab:	01 c0                	add    %eax,%eax
801032ad:	89 c2                	mov    %eax,%edx
801032af:	8b 45 e8             	mov    -0x18(%ebp),%eax
801032b2:	83 e0 0f             	and    $0xf,%eax
801032b5:	01 d0                	add    %edx,%eax
801032b7:	89 45 e8             	mov    %eax,-0x18(%ebp)
    CONV(year  );
801032ba:	8b 45 ec             	mov    -0x14(%ebp),%eax
801032bd:	c1 e8 04             	shr    $0x4,%eax
801032c0:	89 c2                	mov    %eax,%edx
801032c2:	89 d0                	mov    %edx,%eax
801032c4:	c1 e0 02             	shl    $0x2,%eax
801032c7:	01 d0                	add    %edx,%eax
801032c9:	01 c0                	add    %eax,%eax
801032cb:	89 c2                	mov    %eax,%edx
801032cd:	8b 45 ec             	mov    -0x14(%ebp),%eax
801032d0:	83 e0 0f             	and    $0xf,%eax
801032d3:	01 d0                	add    %edx,%eax
801032d5:	89 45 ec             	mov    %eax,-0x14(%ebp)
#undef     CONV
  }

  *r = t1;
801032d8:	8b 45 08             	mov    0x8(%ebp),%eax
801032db:	8b 55 d8             	mov    -0x28(%ebp),%edx
801032de:	89 10                	mov    %edx,(%eax)
801032e0:	8b 55 dc             	mov    -0x24(%ebp),%edx
801032e3:	89 50 04             	mov    %edx,0x4(%eax)
801032e6:	8b 55 e0             	mov    -0x20(%ebp),%edx
801032e9:	89 50 08             	mov    %edx,0x8(%eax)
801032ec:	8b 55 e4             	mov    -0x1c(%ebp),%edx
801032ef:	89 50 0c             	mov    %edx,0xc(%eax)
801032f2:	8b 55 e8             	mov    -0x18(%ebp),%edx
801032f5:	89 50 10             	mov    %edx,0x10(%eax)
801032f8:	8b 55 ec             	mov    -0x14(%ebp),%edx
801032fb:	89 50 14             	mov    %edx,0x14(%eax)
  r->year += 2000;
801032fe:	8b 45 08             	mov    0x8(%ebp),%eax
80103301:	8b 40 14             	mov    0x14(%eax),%eax
80103304:	8d 90 d0 07 00 00    	lea    0x7d0(%eax),%edx
8010330a:	8b 45 08             	mov    0x8(%ebp),%eax
8010330d:	89 50 14             	mov    %edx,0x14(%eax)
}
80103310:	90                   	nop
80103311:	c9                   	leave  
80103312:	c3                   	ret    

80103313 <initlog>:
static void recover_from_log(void);
static void commit();

void
initlog(int dev)
{
80103313:	55                   	push   %ebp
80103314:	89 e5                	mov    %esp,%ebp
80103316:	83 ec 28             	sub    $0x28,%esp
  if (sizeof(struct logheader) >= BSIZE)
    panic("initlog: too big logheader");

  struct superblock sb;
  initlock(&log.lock, "log");
80103319:	83 ec 08             	sub    $0x8,%esp
8010331c:	68 69 98 10 80       	push   $0x80109869
80103321:	68 00 37 11 80       	push   $0x80113700
80103326:	e8 e0 2c 00 00       	call   8010600b <initlock>
8010332b:	83 c4 10             	add    $0x10,%esp
  readsb(dev, &sb);
8010332e:	83 ec 08             	sub    $0x8,%esp
80103331:	8d 45 dc             	lea    -0x24(%ebp),%eax
80103334:	50                   	push   %eax
80103335:	ff 75 08             	push   0x8(%ebp)
80103338:	e8 d4 e0 ff ff       	call   80101411 <readsb>
8010333d:	83 c4 10             	add    $0x10,%esp
  log.start = sb.logstart;
80103340:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103343:	a3 34 37 11 80       	mov    %eax,0x80113734
  log.size = sb.nlog;
80103348:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010334b:	a3 38 37 11 80       	mov    %eax,0x80113738
  log.dev = dev;
80103350:	8b 45 08             	mov    0x8(%ebp),%eax
80103353:	a3 44 37 11 80       	mov    %eax,0x80113744
  recover_from_log();
80103358:	e8 b3 01 00 00       	call   80103510 <recover_from_log>
}
8010335d:	90                   	nop
8010335e:	c9                   	leave  
8010335f:	c3                   	ret    

80103360 <install_trans>:

// Copy committed blocks from log to their home location
static void
install_trans(void)
{
80103360:	55                   	push   %ebp
80103361:	89 e5                	mov    %esp,%ebp
80103363:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103366:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010336d:	e9 95 00 00 00       	jmp    80103407 <install_trans+0xa7>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
80103372:	8b 15 34 37 11 80    	mov    0x80113734,%edx
80103378:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010337b:	01 d0                	add    %edx,%eax
8010337d:	83 c0 01             	add    $0x1,%eax
80103380:	89 c2                	mov    %eax,%edx
80103382:	a1 44 37 11 80       	mov    0x80113744,%eax
80103387:	83 ec 08             	sub    $0x8,%esp
8010338a:	52                   	push   %edx
8010338b:	50                   	push   %eax
8010338c:	e8 3e ce ff ff       	call   801001cf <bread>
80103391:	83 c4 10             	add    $0x10,%esp
80103394:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103397:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010339a:	83 c0 10             	add    $0x10,%eax
8010339d:	8b 04 85 0c 37 11 80 	mov    -0x7feec8f4(,%eax,4),%eax
801033a4:	89 c2                	mov    %eax,%edx
801033a6:	a1 44 37 11 80       	mov    0x80113744,%eax
801033ab:	83 ec 08             	sub    $0x8,%esp
801033ae:	52                   	push   %edx
801033af:	50                   	push   %eax
801033b0:	e8 1a ce ff ff       	call   801001cf <bread>
801033b5:	83 c4 10             	add    $0x10,%esp
801033b8:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
801033bb:	8b 45 f0             	mov    -0x10(%ebp),%eax
801033be:	8d 50 5c             	lea    0x5c(%eax),%edx
801033c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801033c4:	83 c0 5c             	add    $0x5c,%eax
801033c7:	83 ec 04             	sub    $0x4,%esp
801033ca:	68 00 02 00 00       	push   $0x200
801033cf:	52                   	push   %edx
801033d0:	50                   	push   %eax
801033d1:	e8 9c 2f 00 00       	call   80106372 <memmove>
801033d6:	83 c4 10             	add    $0x10,%esp
    bwrite(dbuf);  // write dst to disk
801033d9:	83 ec 0c             	sub    $0xc,%esp
801033dc:	ff 75 ec             	push   -0x14(%ebp)
801033df:	e8 24 ce ff ff       	call   80100208 <bwrite>
801033e4:	83 c4 10             	add    $0x10,%esp
    brelse(lbuf);
801033e7:	83 ec 0c             	sub    $0xc,%esp
801033ea:	ff 75 f0             	push   -0x10(%ebp)
801033ed:	e8 5f ce ff ff       	call   80100251 <brelse>
801033f2:	83 c4 10             	add    $0x10,%esp
    brelse(dbuf);
801033f5:	83 ec 0c             	sub    $0xc,%esp
801033f8:	ff 75 ec             	push   -0x14(%ebp)
801033fb:	e8 51 ce ff ff       	call   80100251 <brelse>
80103400:	83 c4 10             	add    $0x10,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
80103403:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103407:	a1 48 37 11 80       	mov    0x80113748,%eax
8010340c:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010340f:	0f 8c 5d ff ff ff    	jl     80103372 <install_trans+0x12>
  }
}
80103415:	90                   	nop
80103416:	90                   	nop
80103417:	c9                   	leave  
80103418:	c3                   	ret    

80103419 <read_head>:

// Read the log header from disk into the in-memory log header
static void
read_head(void)
{
80103419:	55                   	push   %ebp
8010341a:	89 e5                	mov    %esp,%ebp
8010341c:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
8010341f:	a1 34 37 11 80       	mov    0x80113734,%eax
80103424:	89 c2                	mov    %eax,%edx
80103426:	a1 44 37 11 80       	mov    0x80113744,%eax
8010342b:	83 ec 08             	sub    $0x8,%esp
8010342e:	52                   	push   %edx
8010342f:	50                   	push   %eax
80103430:	e8 9a cd ff ff       	call   801001cf <bread>
80103435:	83 c4 10             	add    $0x10,%esp
80103438:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *lh = (struct logheader *) (buf->data);
8010343b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010343e:	83 c0 5c             	add    $0x5c,%eax
80103441:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  log.lh.n = lh->n;
80103444:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103447:	8b 00                	mov    (%eax),%eax
80103449:	a3 48 37 11 80       	mov    %eax,0x80113748
  for (i = 0; i < log.lh.n; i++) {
8010344e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103455:	eb 1b                	jmp    80103472 <read_head+0x59>
    log.lh.block[i] = lh->block[i];
80103457:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010345a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010345d:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
80103461:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103464:	83 c2 10             	add    $0x10,%edx
80103467:	89 04 95 0c 37 11 80 	mov    %eax,-0x7feec8f4(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010346e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103472:	a1 48 37 11 80       	mov    0x80113748,%eax
80103477:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010347a:	7c db                	jl     80103457 <read_head+0x3e>
  }
  brelse(buf);
8010347c:	83 ec 0c             	sub    $0xc,%esp
8010347f:	ff 75 f0             	push   -0x10(%ebp)
80103482:	e8 ca cd ff ff       	call   80100251 <brelse>
80103487:	83 c4 10             	add    $0x10,%esp
}
8010348a:	90                   	nop
8010348b:	c9                   	leave  
8010348c:	c3                   	ret    

8010348d <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
8010348d:	55                   	push   %ebp
8010348e:	89 e5                	mov    %esp,%ebp
80103490:	83 ec 18             	sub    $0x18,%esp
  struct buf *buf = bread(log.dev, log.start);
80103493:	a1 34 37 11 80       	mov    0x80113734,%eax
80103498:	89 c2                	mov    %eax,%edx
8010349a:	a1 44 37 11 80       	mov    0x80113744,%eax
8010349f:	83 ec 08             	sub    $0x8,%esp
801034a2:	52                   	push   %edx
801034a3:	50                   	push   %eax
801034a4:	e8 26 cd ff ff       	call   801001cf <bread>
801034a9:	83 c4 10             	add    $0x10,%esp
801034ac:	89 45 f0             	mov    %eax,-0x10(%ebp)
  struct logheader *hb = (struct logheader *) (buf->data);
801034af:	8b 45 f0             	mov    -0x10(%ebp),%eax
801034b2:	83 c0 5c             	add    $0x5c,%eax
801034b5:	89 45 ec             	mov    %eax,-0x14(%ebp)
  int i;
  hb->n = log.lh.n;
801034b8:	8b 15 48 37 11 80    	mov    0x80113748,%edx
801034be:	8b 45 ec             	mov    -0x14(%ebp),%eax
801034c1:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
801034c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801034ca:	eb 1b                	jmp    801034e7 <write_head+0x5a>
    hb->block[i] = log.lh.block[i];
801034cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801034cf:	83 c0 10             	add    $0x10,%eax
801034d2:	8b 0c 85 0c 37 11 80 	mov    -0x7feec8f4(,%eax,4),%ecx
801034d9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801034dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
801034df:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801034e3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801034e7:	a1 48 37 11 80       	mov    0x80113748,%eax
801034ec:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801034ef:	7c db                	jl     801034cc <write_head+0x3f>
  }
  bwrite(buf);
801034f1:	83 ec 0c             	sub    $0xc,%esp
801034f4:	ff 75 f0             	push   -0x10(%ebp)
801034f7:	e8 0c cd ff ff       	call   80100208 <bwrite>
801034fc:	83 c4 10             	add    $0x10,%esp
  brelse(buf);
801034ff:	83 ec 0c             	sub    $0xc,%esp
80103502:	ff 75 f0             	push   -0x10(%ebp)
80103505:	e8 47 cd ff ff       	call   80100251 <brelse>
8010350a:	83 c4 10             	add    $0x10,%esp
}
8010350d:	90                   	nop
8010350e:	c9                   	leave  
8010350f:	c3                   	ret    

80103510 <recover_from_log>:

static void
recover_from_log(void)
{
80103510:	55                   	push   %ebp
80103511:	89 e5                	mov    %esp,%ebp
80103513:	83 ec 08             	sub    $0x8,%esp
  read_head();
80103516:	e8 fe fe ff ff       	call   80103419 <read_head>
  install_trans(); // if committed, copy from log to disk
8010351b:	e8 40 fe ff ff       	call   80103360 <install_trans>
  log.lh.n = 0;
80103520:	c7 05 48 37 11 80 00 	movl   $0x0,0x80113748
80103527:	00 00 00 
  write_head(); // clear the log
8010352a:	e8 5e ff ff ff       	call   8010348d <write_head>
}
8010352f:	90                   	nop
80103530:	c9                   	leave  
80103531:	c3                   	ret    

80103532 <begin_op>:

// called at the start of each FS system call.
void
begin_op(void)
{
80103532:	55                   	push   %ebp
80103533:	89 e5                	mov    %esp,%ebp
80103535:	83 ec 08             	sub    $0x8,%esp
  acquire(&log.lock);
80103538:	83 ec 0c             	sub    $0xc,%esp
8010353b:	68 00 37 11 80       	push   $0x80113700
80103540:	e8 e8 2a 00 00       	call   8010602d <acquire>
80103545:	83 c4 10             	add    $0x10,%esp
  while(1){
    if(log.committing){
80103548:	a1 40 37 11 80       	mov    0x80113740,%eax
8010354d:	85 c0                	test   %eax,%eax
8010354f:	74 17                	je     80103568 <begin_op+0x36>
      sleep(&log, &log.lock);
80103551:	83 ec 08             	sub    $0x8,%esp
80103554:	68 00 37 11 80       	push   $0x80113700
80103559:	68 00 37 11 80       	push   $0x80113700
8010355e:	e8 e9 1c 00 00       	call   8010524c <sleep>
80103563:	83 c4 10             	add    $0x10,%esp
80103566:	eb e0                	jmp    80103548 <begin_op+0x16>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103568:	8b 0d 48 37 11 80    	mov    0x80113748,%ecx
8010356e:	a1 3c 37 11 80       	mov    0x8011373c,%eax
80103573:	8d 50 01             	lea    0x1(%eax),%edx
80103576:	89 d0                	mov    %edx,%eax
80103578:	c1 e0 02             	shl    $0x2,%eax
8010357b:	01 d0                	add    %edx,%eax
8010357d:	01 c0                	add    %eax,%eax
8010357f:	01 c8                	add    %ecx,%eax
80103581:	83 f8 1e             	cmp    $0x1e,%eax
80103584:	7e 17                	jle    8010359d <begin_op+0x6b>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
80103586:	83 ec 08             	sub    $0x8,%esp
80103589:	68 00 37 11 80       	push   $0x80113700
8010358e:	68 00 37 11 80       	push   $0x80113700
80103593:	e8 b4 1c 00 00       	call   8010524c <sleep>
80103598:	83 c4 10             	add    $0x10,%esp
8010359b:	eb ab                	jmp    80103548 <begin_op+0x16>
    } else {
      log.outstanding += 1;
8010359d:	a1 3c 37 11 80       	mov    0x8011373c,%eax
801035a2:	83 c0 01             	add    $0x1,%eax
801035a5:	a3 3c 37 11 80       	mov    %eax,0x8011373c
      release(&log.lock);
801035aa:	83 ec 0c             	sub    $0xc,%esp
801035ad:	68 00 37 11 80       	push   $0x80113700
801035b2:	e8 e4 2a 00 00       	call   8010609b <release>
801035b7:	83 c4 10             	add    $0x10,%esp
      break;
801035ba:	90                   	nop
    }
  }
}
801035bb:	90                   	nop
801035bc:	c9                   	leave  
801035bd:	c3                   	ret    

801035be <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
801035be:	55                   	push   %ebp
801035bf:	89 e5                	mov    %esp,%ebp
801035c1:	83 ec 18             	sub    $0x18,%esp
  int do_commit = 0;
801035c4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&log.lock);
801035cb:	83 ec 0c             	sub    $0xc,%esp
801035ce:	68 00 37 11 80       	push   $0x80113700
801035d3:	e8 55 2a 00 00       	call   8010602d <acquire>
801035d8:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
801035db:	a1 3c 37 11 80       	mov    0x8011373c,%eax
801035e0:	83 e8 01             	sub    $0x1,%eax
801035e3:	a3 3c 37 11 80       	mov    %eax,0x8011373c
  if(log.committing)
801035e8:	a1 40 37 11 80       	mov    0x80113740,%eax
801035ed:	85 c0                	test   %eax,%eax
801035ef:	74 0d                	je     801035fe <end_op+0x40>
    panic("log.committing");
801035f1:	83 ec 0c             	sub    $0xc,%esp
801035f4:	68 6d 98 10 80       	push   $0x8010986d
801035f9:	e8 b7 cf ff ff       	call   801005b5 <panic>
  if(log.outstanding == 0){
801035fe:	a1 3c 37 11 80       	mov    0x8011373c,%eax
80103603:	85 c0                	test   %eax,%eax
80103605:	75 13                	jne    8010361a <end_op+0x5c>
    do_commit = 1;
80103607:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    log.committing = 1;
8010360e:	c7 05 40 37 11 80 01 	movl   $0x1,0x80113740
80103615:	00 00 00 
80103618:	eb 10                	jmp    8010362a <end_op+0x6c>
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
8010361a:	83 ec 0c             	sub    $0xc,%esp
8010361d:	68 00 37 11 80       	push   $0x80113700
80103622:	e8 a3 1d 00 00       	call   801053ca <wakeup>
80103627:	83 c4 10             	add    $0x10,%esp
  }
  release(&log.lock);
8010362a:	83 ec 0c             	sub    $0xc,%esp
8010362d:	68 00 37 11 80       	push   $0x80113700
80103632:	e8 64 2a 00 00       	call   8010609b <release>
80103637:	83 c4 10             	add    $0x10,%esp

  if(do_commit){
8010363a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010363e:	74 3f                	je     8010367f <end_op+0xc1>
    // call commit w/o holding locks, since not allowed
    // to sleep with locks.
    commit();
80103640:	e8 f6 00 00 00       	call   8010373b <commit>
    acquire(&log.lock);
80103645:	83 ec 0c             	sub    $0xc,%esp
80103648:	68 00 37 11 80       	push   $0x80113700
8010364d:	e8 db 29 00 00       	call   8010602d <acquire>
80103652:	83 c4 10             	add    $0x10,%esp
    log.committing = 0;
80103655:	c7 05 40 37 11 80 00 	movl   $0x0,0x80113740
8010365c:	00 00 00 
    wakeup(&log);
8010365f:	83 ec 0c             	sub    $0xc,%esp
80103662:	68 00 37 11 80       	push   $0x80113700
80103667:	e8 5e 1d 00 00       	call   801053ca <wakeup>
8010366c:	83 c4 10             	add    $0x10,%esp
    release(&log.lock);
8010366f:	83 ec 0c             	sub    $0xc,%esp
80103672:	68 00 37 11 80       	push   $0x80113700
80103677:	e8 1f 2a 00 00       	call   8010609b <release>
8010367c:	83 c4 10             	add    $0x10,%esp
  }
}
8010367f:	90                   	nop
80103680:	c9                   	leave  
80103681:	c3                   	ret    

80103682 <write_log>:

// Copy modified blocks from cache to log.
static void
write_log(void)
{
80103682:	55                   	push   %ebp
80103683:	89 e5                	mov    %esp,%ebp
80103685:	83 ec 18             	sub    $0x18,%esp
  int tail;

  for (tail = 0; tail < log.lh.n; tail++) {
80103688:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010368f:	e9 95 00 00 00       	jmp    80103729 <write_log+0xa7>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
80103694:	8b 15 34 37 11 80    	mov    0x80113734,%edx
8010369a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010369d:	01 d0                	add    %edx,%eax
8010369f:	83 c0 01             	add    $0x1,%eax
801036a2:	89 c2                	mov    %eax,%edx
801036a4:	a1 44 37 11 80       	mov    0x80113744,%eax
801036a9:	83 ec 08             	sub    $0x8,%esp
801036ac:	52                   	push   %edx
801036ad:	50                   	push   %eax
801036ae:	e8 1c cb ff ff       	call   801001cf <bread>
801036b3:	83 c4 10             	add    $0x10,%esp
801036b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801036b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036bc:	83 c0 10             	add    $0x10,%eax
801036bf:	8b 04 85 0c 37 11 80 	mov    -0x7feec8f4(,%eax,4),%eax
801036c6:	89 c2                	mov    %eax,%edx
801036c8:	a1 44 37 11 80       	mov    0x80113744,%eax
801036cd:	83 ec 08             	sub    $0x8,%esp
801036d0:	52                   	push   %edx
801036d1:	50                   	push   %eax
801036d2:	e8 f8 ca ff ff       	call   801001cf <bread>
801036d7:	83 c4 10             	add    $0x10,%esp
801036da:	89 45 ec             	mov    %eax,-0x14(%ebp)
    memmove(to->data, from->data, BSIZE);
801036dd:	8b 45 ec             	mov    -0x14(%ebp),%eax
801036e0:	8d 50 5c             	lea    0x5c(%eax),%edx
801036e3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801036e6:	83 c0 5c             	add    $0x5c,%eax
801036e9:	83 ec 04             	sub    $0x4,%esp
801036ec:	68 00 02 00 00       	push   $0x200
801036f1:	52                   	push   %edx
801036f2:	50                   	push   %eax
801036f3:	e8 7a 2c 00 00       	call   80106372 <memmove>
801036f8:	83 c4 10             	add    $0x10,%esp
    bwrite(to);  // write the log
801036fb:	83 ec 0c             	sub    $0xc,%esp
801036fe:	ff 75 f0             	push   -0x10(%ebp)
80103701:	e8 02 cb ff ff       	call   80100208 <bwrite>
80103706:	83 c4 10             	add    $0x10,%esp
    brelse(from);
80103709:	83 ec 0c             	sub    $0xc,%esp
8010370c:	ff 75 ec             	push   -0x14(%ebp)
8010370f:	e8 3d cb ff ff       	call   80100251 <brelse>
80103714:	83 c4 10             	add    $0x10,%esp
    brelse(to);
80103717:	83 ec 0c             	sub    $0xc,%esp
8010371a:	ff 75 f0             	push   -0x10(%ebp)
8010371d:	e8 2f cb ff ff       	call   80100251 <brelse>
80103722:	83 c4 10             	add    $0x10,%esp
  for (tail = 0; tail < log.lh.n; tail++) {
80103725:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103729:	a1 48 37 11 80       	mov    0x80113748,%eax
8010372e:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103731:	0f 8c 5d ff ff ff    	jl     80103694 <write_log+0x12>
  }
}
80103737:	90                   	nop
80103738:	90                   	nop
80103739:	c9                   	leave  
8010373a:	c3                   	ret    

8010373b <commit>:

static void
commit()
{
8010373b:	55                   	push   %ebp
8010373c:	89 e5                	mov    %esp,%ebp
8010373e:	83 ec 08             	sub    $0x8,%esp
  if (log.lh.n > 0) {
80103741:	a1 48 37 11 80       	mov    0x80113748,%eax
80103746:	85 c0                	test   %eax,%eax
80103748:	7e 1e                	jle    80103768 <commit+0x2d>
    write_log();     // Write modified blocks from cache to log
8010374a:	e8 33 ff ff ff       	call   80103682 <write_log>
    write_head();    // Write header to disk -- the real commit
8010374f:	e8 39 fd ff ff       	call   8010348d <write_head>
    install_trans(); // Now install writes to home locations
80103754:	e8 07 fc ff ff       	call   80103360 <install_trans>
    log.lh.n = 0;
80103759:	c7 05 48 37 11 80 00 	movl   $0x0,0x80113748
80103760:	00 00 00 
    write_head();    // Erase the transaction from the log
80103763:	e8 25 fd ff ff       	call   8010348d <write_head>
  }
}
80103768:	90                   	nop
80103769:	c9                   	leave  
8010376a:	c3                   	ret    

8010376b <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
8010376b:	55                   	push   %ebp
8010376c:	89 e5                	mov    %esp,%ebp
8010376e:	83 ec 18             	sub    $0x18,%esp
  int i;

  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
80103771:	a1 48 37 11 80       	mov    0x80113748,%eax
80103776:	83 f8 1d             	cmp    $0x1d,%eax
80103779:	7f 12                	jg     8010378d <log_write+0x22>
8010377b:	a1 48 37 11 80       	mov    0x80113748,%eax
80103780:	8b 15 38 37 11 80    	mov    0x80113738,%edx
80103786:	83 ea 01             	sub    $0x1,%edx
80103789:	39 d0                	cmp    %edx,%eax
8010378b:	7c 0d                	jl     8010379a <log_write+0x2f>
    panic("too big a transaction");
8010378d:	83 ec 0c             	sub    $0xc,%esp
80103790:	68 7c 98 10 80       	push   $0x8010987c
80103795:	e8 1b ce ff ff       	call   801005b5 <panic>
  if (log.outstanding < 1)
8010379a:	a1 3c 37 11 80       	mov    0x8011373c,%eax
8010379f:	85 c0                	test   %eax,%eax
801037a1:	7f 0d                	jg     801037b0 <log_write+0x45>
    panic("log_write outside of trans");
801037a3:	83 ec 0c             	sub    $0xc,%esp
801037a6:	68 92 98 10 80       	push   $0x80109892
801037ab:	e8 05 ce ff ff       	call   801005b5 <panic>

  acquire(&log.lock);
801037b0:	83 ec 0c             	sub    $0xc,%esp
801037b3:	68 00 37 11 80       	push   $0x80113700
801037b8:	e8 70 28 00 00       	call   8010602d <acquire>
801037bd:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < log.lh.n; i++) {
801037c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801037c7:	eb 1d                	jmp    801037e6 <log_write+0x7b>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801037c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037cc:	83 c0 10             	add    $0x10,%eax
801037cf:	8b 04 85 0c 37 11 80 	mov    -0x7feec8f4(,%eax,4),%eax
801037d6:	89 c2                	mov    %eax,%edx
801037d8:	8b 45 08             	mov    0x8(%ebp),%eax
801037db:	8b 40 08             	mov    0x8(%eax),%eax
801037de:	39 c2                	cmp    %eax,%edx
801037e0:	74 10                	je     801037f2 <log_write+0x87>
  for (i = 0; i < log.lh.n; i++) {
801037e2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801037e6:	a1 48 37 11 80       	mov    0x80113748,%eax
801037eb:	39 45 f4             	cmp    %eax,-0xc(%ebp)
801037ee:	7c d9                	jl     801037c9 <log_write+0x5e>
801037f0:	eb 01                	jmp    801037f3 <log_write+0x88>
      break;
801037f2:	90                   	nop
  }
  log.lh.block[i] = b->blockno;
801037f3:	8b 45 08             	mov    0x8(%ebp),%eax
801037f6:	8b 40 08             	mov    0x8(%eax),%eax
801037f9:	89 c2                	mov    %eax,%edx
801037fb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037fe:	83 c0 10             	add    $0x10,%eax
80103801:	89 14 85 0c 37 11 80 	mov    %edx,-0x7feec8f4(,%eax,4)
  if (i == log.lh.n)
80103808:	a1 48 37 11 80       	mov    0x80113748,%eax
8010380d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103810:	75 0d                	jne    8010381f <log_write+0xb4>
    log.lh.n++;
80103812:	a1 48 37 11 80       	mov    0x80113748,%eax
80103817:	83 c0 01             	add    $0x1,%eax
8010381a:	a3 48 37 11 80       	mov    %eax,0x80113748
  b->flags |= B_DIRTY; // prevent eviction
8010381f:	8b 45 08             	mov    0x8(%ebp),%eax
80103822:	8b 00                	mov    (%eax),%eax
80103824:	83 c8 04             	or     $0x4,%eax
80103827:	89 c2                	mov    %eax,%edx
80103829:	8b 45 08             	mov    0x8(%ebp),%eax
8010382c:	89 10                	mov    %edx,(%eax)
  release(&log.lock);
8010382e:	83 ec 0c             	sub    $0xc,%esp
80103831:	68 00 37 11 80       	push   $0x80113700
80103836:	e8 60 28 00 00       	call   8010609b <release>
8010383b:	83 c4 10             	add    $0x10,%esp
}
8010383e:	90                   	nop
8010383f:	c9                   	leave  
80103840:	c3                   	ret    

80103841 <xchg>:
  asm volatile("sti");
}

static inline uint
xchg(volatile uint *addr, uint newval)
{
80103841:	55                   	push   %ebp
80103842:	89 e5                	mov    %esp,%ebp
80103844:	83 ec 10             	sub    $0x10,%esp
  uint result;

  // The + in "+m" denotes a read-modify-write operand.
  asm volatile("lock; xchgl %0, %1" :
80103847:	8b 55 08             	mov    0x8(%ebp),%edx
8010384a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010384d:	8b 4d 08             	mov    0x8(%ebp),%ecx
80103850:	f0 87 02             	lock xchg %eax,(%edx)
80103853:	89 45 fc             	mov    %eax,-0x4(%ebp)
               "+m" (*addr), "=a" (result) :
               "1" (newval) :
               "cc");
  return result;
80103856:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80103859:	c9                   	leave  
8010385a:	c3                   	ret    

8010385b <main>:
// Bootstrap processor starts running C code here.
// Allocate a real stack and switch to it, first
// doing some setup required for memory allocator to work.
int
main(void)
{
8010385b:	8d 4c 24 04          	lea    0x4(%esp),%ecx
8010385f:	83 e4 f0             	and    $0xfffffff0,%esp
80103862:	ff 71 fc             	push   -0x4(%ecx)
80103865:	55                   	push   %ebp
80103866:	89 e5                	mov    %esp,%ebp
80103868:	51                   	push   %ecx
80103869:	83 ec 04             	sub    $0x4,%esp
  kinit1(end, P2V(4*1024*1024)); // phys page allocator
8010386c:	83 ec 08             	sub    $0x8,%esp
8010386f:	68 00 00 40 80       	push   $0x80400000
80103874:	68 60 83 11 80       	push   $0x80118360
80103879:	e8 e3 f2 ff ff       	call   80102b61 <kinit1>
8010387e:	83 c4 10             	add    $0x10,%esp
  kvmalloc();      // kernel page table
80103881:	e8 b5 55 00 00       	call   80108e3b <kvmalloc>
  mpinit();        // detect other processors
80103886:	e8 bd 03 00 00       	call   80103c48 <mpinit>
  lapicinit();     // interrupt controller
8010388b:	e8 41 f6 ff ff       	call   80102ed1 <lapicinit>
  seginit();       // segment descriptors
80103890:	e8 91 50 00 00       	call   80108926 <seginit>
  picinit();       // disable pic
80103895:	e8 15 05 00 00       	call   80103daf <picinit>
  ioapicinit();    // another interrupt controller
8010389a:	e8 dd f1 ff ff       	call   80102a7c <ioapicinit>
  consoleinit();   // console hardware
8010389f:	e8 d4 d2 ff ff       	call   80100b78 <consoleinit>
  uartinit();      // serial port
801038a4:	e8 16 44 00 00       	call   80107cbf <uartinit>
  pinit();         // process table
801038a9:	e8 99 09 00 00       	call   80104247 <pinit>
  tvinit();        // trap vectors
801038ae:	e8 68 3f 00 00       	call   8010781b <tvinit>
  binit();         // buffer cache
801038b3:	e8 7c c7 ff ff       	call   80100034 <binit>
  fileinit();      // file table
801038b8:	e8 45 d7 ff ff       	call   80101002 <fileinit>
  ideinit();       // disk 
801038bd:	e8 91 ed ff ff       	call   80102653 <ideinit>
  startothers();   // start other processors
801038c2:	e8 80 00 00 00       	call   80103947 <startothers>
  kinit2(P2V(4*1024*1024), P2V(PHYSTOP)); // must come after startothers()
801038c7:	83 ec 08             	sub    $0x8,%esp
801038ca:	68 00 00 00 8e       	push   $0x8e000000
801038cf:	68 00 00 40 80       	push   $0x80400000
801038d4:	e8 c1 f2 ff ff       	call   80102b9a <kinit2>
801038d9:	83 c4 10             	add    $0x10,%esp
  userinit();      // first user process
801038dc:	e8 74 0b 00 00       	call   80104455 <userinit>
  mpmain();        // finish this processor's setup
801038e1:	e8 1a 00 00 00       	call   80103900 <mpmain>

801038e6 <mpenter>:
}

// Other CPUs jump here from entryother.S.
static void
mpenter(void)
{
801038e6:	55                   	push   %ebp
801038e7:	89 e5                	mov    %esp,%ebp
801038e9:	83 ec 08             	sub    $0x8,%esp
  switchkvm();
801038ec:	e8 62 55 00 00       	call   80108e53 <switchkvm>
  seginit();
801038f1:	e8 30 50 00 00       	call   80108926 <seginit>
  lapicinit();
801038f6:	e8 d6 f5 ff ff       	call   80102ed1 <lapicinit>
  mpmain();
801038fb:	e8 00 00 00 00       	call   80103900 <mpmain>

80103900 <mpmain>:
}

// Common CPU setup code.
static void
mpmain(void)
{
80103900:	55                   	push   %ebp
80103901:	89 e5                	mov    %esp,%ebp
80103903:	53                   	push   %ebx
80103904:	83 ec 04             	sub    $0x4,%esp
  cprintf("cpu%d: starting %d\n", cpuid(), cpuid());
80103907:	e8 77 09 00 00       	call   80104283 <cpuid>
8010390c:	89 c3                	mov    %eax,%ebx
8010390e:	e8 70 09 00 00       	call   80104283 <cpuid>
80103913:	83 ec 04             	sub    $0x4,%esp
80103916:	53                   	push   %ebx
80103917:	50                   	push   %eax
80103918:	68 ad 98 10 80       	push   $0x801098ad
8010391d:	e8 de ca ff ff       	call   80100400 <cprintf>
80103922:	83 c4 10             	add    $0x10,%esp
  idtinit();       // load idt register
80103925:	e8 67 40 00 00       	call   80107991 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
8010392a:	e8 6f 09 00 00       	call   8010429e <mycpu>
8010392f:	05 a0 00 00 00       	add    $0xa0,%eax
80103934:	83 ec 08             	sub    $0x8,%esp
80103937:	6a 01                	push   $0x1
80103939:	50                   	push   %eax
8010393a:	e8 02 ff ff ff       	call   80103841 <xchg>
8010393f:	83 c4 10             	add    $0x10,%esp
  scheduler();     // start running processes
80103942:	e8 cc 13 00 00       	call   80104d13 <scheduler>

80103947 <startothers>:
pde_t entrypgdir[];  // For entry.S

// Start the non-boot (AP) processors.
static void
startothers(void)
{
80103947:	55                   	push   %ebp
80103948:	89 e5                	mov    %esp,%ebp
8010394a:	83 ec 18             	sub    $0x18,%esp
  char *stack;

  // Write entry code to unused memory at 0x7000.
  // The linker has placed the image of entryother.S in
  // _binary_entryother_start.
  code = P2V(0x7000);
8010394d:	c7 45 f0 00 70 00 80 	movl   $0x80007000,-0x10(%ebp)
  memmove(code, _binary_entryother_start, (uint)_binary_entryother_size);
80103954:	b8 8a 00 00 00       	mov    $0x8a,%eax
80103959:	83 ec 04             	sub    $0x4,%esp
8010395c:	50                   	push   %eax
8010395d:	68 0c c5 10 80       	push   $0x8010c50c
80103962:	ff 75 f0             	push   -0x10(%ebp)
80103965:	e8 08 2a 00 00       	call   80106372 <memmove>
8010396a:	83 c4 10             	add    $0x10,%esp

  for(c = cpus; c < cpus+ncpu; c++){
8010396d:	c7 45 f4 e0 37 11 80 	movl   $0x801137e0,-0xc(%ebp)
80103974:	eb 79                	jmp    801039ef <startothers+0xa8>
    if(c == mycpu())  // We've started already.
80103976:	e8 23 09 00 00       	call   8010429e <mycpu>
8010397b:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010397e:	74 67                	je     801039e7 <startothers+0xa0>
      continue;

    // Tell entryother.S what stack to use, where to enter, and what
    // pgdir to use. We cannot use kpgdir yet, because the AP processor
    // is running in low  memory, so we use entrypgdir for the APs too.
    stack = kalloc();
80103980:	e8 11 f3 ff ff       	call   80102c96 <kalloc>
80103985:	89 45 ec             	mov    %eax,-0x14(%ebp)
    *(void**)(code-4) = stack + KSTACKSIZE;
80103988:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010398b:	83 e8 04             	sub    $0x4,%eax
8010398e:	8b 55 ec             	mov    -0x14(%ebp),%edx
80103991:	81 c2 00 10 00 00    	add    $0x1000,%edx
80103997:	89 10                	mov    %edx,(%eax)
    *(void(**)(void))(code-8) = mpenter;
80103999:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010399c:	83 e8 08             	sub    $0x8,%eax
8010399f:	c7 00 e6 38 10 80    	movl   $0x801038e6,(%eax)
    *(int**)(code-12) = (void *) V2P(entrypgdir);
801039a5:	b8 00 b0 10 80       	mov    $0x8010b000,%eax
801039aa:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
801039b0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801039b3:	83 e8 0c             	sub    $0xc,%eax
801039b6:	89 10                	mov    %edx,(%eax)

    lapicstartap(c->apicid, V2P(code));
801039b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801039bb:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
801039c1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801039c4:	0f b6 00             	movzbl (%eax),%eax
801039c7:	0f b6 c0             	movzbl %al,%eax
801039ca:	83 ec 08             	sub    $0x8,%esp
801039cd:	52                   	push   %edx
801039ce:	50                   	push   %eax
801039cf:	e8 5f f6 ff ff       	call   80103033 <lapicstartap>
801039d4:	83 c4 10             	add    $0x10,%esp

    // wait for cpu to finish mpmain()
    while(c->started == 0)
801039d7:	90                   	nop
801039d8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801039db:	8b 80 a0 00 00 00    	mov    0xa0(%eax),%eax
801039e1:	85 c0                	test   %eax,%eax
801039e3:	74 f3                	je     801039d8 <startothers+0x91>
801039e5:	eb 01                	jmp    801039e8 <startothers+0xa1>
      continue;
801039e7:	90                   	nop
  for(c = cpus; c < cpus+ncpu; c++){
801039e8:	81 45 f4 b0 00 00 00 	addl   $0xb0,-0xc(%ebp)
801039ef:	a1 60 3d 11 80       	mov    0x80113d60,%eax
801039f4:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
801039fa:	05 e0 37 11 80       	add    $0x801137e0,%eax
801039ff:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103a02:	0f 82 6e ff ff ff    	jb     80103976 <startothers+0x2f>
      ;
  }
}
80103a08:	90                   	nop
80103a09:	90                   	nop
80103a0a:	c9                   	leave  
80103a0b:	c3                   	ret    

80103a0c <inb>:
{
80103a0c:	55                   	push   %ebp
80103a0d:	89 e5                	mov    %esp,%ebp
80103a0f:	83 ec 14             	sub    $0x14,%esp
80103a12:	8b 45 08             	mov    0x8(%ebp),%eax
80103a15:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80103a19:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80103a1d:	89 c2                	mov    %eax,%edx
80103a1f:	ec                   	in     (%dx),%al
80103a20:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80103a23:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80103a27:	c9                   	leave  
80103a28:	c3                   	ret    

80103a29 <outb>:
{
80103a29:	55                   	push   %ebp
80103a2a:	89 e5                	mov    %esp,%ebp
80103a2c:	83 ec 08             	sub    $0x8,%esp
80103a2f:	8b 45 08             	mov    0x8(%ebp),%eax
80103a32:	8b 55 0c             	mov    0xc(%ebp),%edx
80103a35:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80103a39:	89 d0                	mov    %edx,%eax
80103a3b:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103a3e:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103a42:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103a46:	ee                   	out    %al,(%dx)
}
80103a47:	90                   	nop
80103a48:	c9                   	leave  
80103a49:	c3                   	ret    

80103a4a <sum>:
int ncpu;
uchar ioapicid;

static uchar
sum(uchar *addr, int len)
{
80103a4a:	55                   	push   %ebp
80103a4b:	89 e5                	mov    %esp,%ebp
80103a4d:	83 ec 10             	sub    $0x10,%esp
  int i, sum;

  sum = 0;
80103a50:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
  for(i=0; i<len; i++)
80103a57:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80103a5e:	eb 15                	jmp    80103a75 <sum+0x2b>
    sum += addr[i];
80103a60:	8b 55 fc             	mov    -0x4(%ebp),%edx
80103a63:	8b 45 08             	mov    0x8(%ebp),%eax
80103a66:	01 d0                	add    %edx,%eax
80103a68:	0f b6 00             	movzbl (%eax),%eax
80103a6b:	0f b6 c0             	movzbl %al,%eax
80103a6e:	01 45 f8             	add    %eax,-0x8(%ebp)
  for(i=0; i<len; i++)
80103a71:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80103a75:	8b 45 fc             	mov    -0x4(%ebp),%eax
80103a78:	3b 45 0c             	cmp    0xc(%ebp),%eax
80103a7b:	7c e3                	jl     80103a60 <sum+0x16>
  return sum;
80103a7d:	8b 45 f8             	mov    -0x8(%ebp),%eax
}
80103a80:	c9                   	leave  
80103a81:	c3                   	ret    

80103a82 <mpsearch1>:

// Look for an MP structure in the len bytes at addr.
static struct mp*
mpsearch1(uint a, int len)
{
80103a82:	55                   	push   %ebp
80103a83:	89 e5                	mov    %esp,%ebp
80103a85:	83 ec 18             	sub    $0x18,%esp
  uchar *e, *p, *addr;

  addr = P2V(a);
80103a88:	8b 45 08             	mov    0x8(%ebp),%eax
80103a8b:	05 00 00 00 80       	add    $0x80000000,%eax
80103a90:	89 45 f0             	mov    %eax,-0x10(%ebp)
  e = addr+len;
80103a93:	8b 55 0c             	mov    0xc(%ebp),%edx
80103a96:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103a99:	01 d0                	add    %edx,%eax
80103a9b:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(p = addr; p < e; p += sizeof(struct mp))
80103a9e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103aa1:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103aa4:	eb 36                	jmp    80103adc <mpsearch1+0x5a>
    if(memcmp(p, "_MP_", 4) == 0 && sum(p, sizeof(struct mp)) == 0)
80103aa6:	83 ec 04             	sub    $0x4,%esp
80103aa9:	6a 04                	push   $0x4
80103aab:	68 c4 98 10 80       	push   $0x801098c4
80103ab0:	ff 75 f4             	push   -0xc(%ebp)
80103ab3:	e8 62 28 00 00       	call   8010631a <memcmp>
80103ab8:	83 c4 10             	add    $0x10,%esp
80103abb:	85 c0                	test   %eax,%eax
80103abd:	75 19                	jne    80103ad8 <mpsearch1+0x56>
80103abf:	83 ec 08             	sub    $0x8,%esp
80103ac2:	6a 10                	push   $0x10
80103ac4:	ff 75 f4             	push   -0xc(%ebp)
80103ac7:	e8 7e ff ff ff       	call   80103a4a <sum>
80103acc:	83 c4 10             	add    $0x10,%esp
80103acf:	84 c0                	test   %al,%al
80103ad1:	75 05                	jne    80103ad8 <mpsearch1+0x56>
      return (struct mp*)p;
80103ad3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ad6:	eb 11                	jmp    80103ae9 <mpsearch1+0x67>
  for(p = addr; p < e; p += sizeof(struct mp))
80103ad8:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80103adc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103adf:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80103ae2:	72 c2                	jb     80103aa6 <mpsearch1+0x24>
  return 0;
80103ae4:	b8 00 00 00 00       	mov    $0x0,%eax
}
80103ae9:	c9                   	leave  
80103aea:	c3                   	ret    

80103aeb <mpsearch>:
// 1) in the first KB of the EBDA;
// 2) in the last KB of system base memory;
// 3) in the BIOS ROM between 0xE0000 and 0xFFFFF.
static struct mp*
mpsearch(void)
{
80103aeb:	55                   	push   %ebp
80103aec:	89 e5                	mov    %esp,%ebp
80103aee:	83 ec 18             	sub    $0x18,%esp
  uchar *bda;
  uint p;
  struct mp *mp;

  bda = (uchar *) P2V(0x400);
80103af1:	c7 45 f4 00 04 00 80 	movl   $0x80000400,-0xc(%ebp)
  if((p = ((bda[0x0F]<<8)| bda[0x0E]) << 4)){
80103af8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103afb:	83 c0 0f             	add    $0xf,%eax
80103afe:	0f b6 00             	movzbl (%eax),%eax
80103b01:	0f b6 c0             	movzbl %al,%eax
80103b04:	c1 e0 08             	shl    $0x8,%eax
80103b07:	89 c2                	mov    %eax,%edx
80103b09:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b0c:	83 c0 0e             	add    $0xe,%eax
80103b0f:	0f b6 00             	movzbl (%eax),%eax
80103b12:	0f b6 c0             	movzbl %al,%eax
80103b15:	09 d0                	or     %edx,%eax
80103b17:	c1 e0 04             	shl    $0x4,%eax
80103b1a:	89 45 f0             	mov    %eax,-0x10(%ebp)
80103b1d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103b21:	74 21                	je     80103b44 <mpsearch+0x59>
    if((mp = mpsearch1(p, 1024)))
80103b23:	83 ec 08             	sub    $0x8,%esp
80103b26:	68 00 04 00 00       	push   $0x400
80103b2b:	ff 75 f0             	push   -0x10(%ebp)
80103b2e:	e8 4f ff ff ff       	call   80103a82 <mpsearch1>
80103b33:	83 c4 10             	add    $0x10,%esp
80103b36:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103b39:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103b3d:	74 51                	je     80103b90 <mpsearch+0xa5>
      return mp;
80103b3f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103b42:	eb 61                	jmp    80103ba5 <mpsearch+0xba>
  } else {
    p = ((bda[0x14]<<8)|bda[0x13])*1024;
80103b44:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b47:	83 c0 14             	add    $0x14,%eax
80103b4a:	0f b6 00             	movzbl (%eax),%eax
80103b4d:	0f b6 c0             	movzbl %al,%eax
80103b50:	c1 e0 08             	shl    $0x8,%eax
80103b53:	89 c2                	mov    %eax,%edx
80103b55:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103b58:	83 c0 13             	add    $0x13,%eax
80103b5b:	0f b6 00             	movzbl (%eax),%eax
80103b5e:	0f b6 c0             	movzbl %al,%eax
80103b61:	09 d0                	or     %edx,%eax
80103b63:	c1 e0 0a             	shl    $0xa,%eax
80103b66:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if((mp = mpsearch1(p-1024, 1024)))
80103b69:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103b6c:	2d 00 04 00 00       	sub    $0x400,%eax
80103b71:	83 ec 08             	sub    $0x8,%esp
80103b74:	68 00 04 00 00       	push   $0x400
80103b79:	50                   	push   %eax
80103b7a:	e8 03 ff ff ff       	call   80103a82 <mpsearch1>
80103b7f:	83 c4 10             	add    $0x10,%esp
80103b82:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103b85:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103b89:	74 05                	je     80103b90 <mpsearch+0xa5>
      return mp;
80103b8b:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103b8e:	eb 15                	jmp    80103ba5 <mpsearch+0xba>
  }
  return mpsearch1(0xF0000, 0x10000);
80103b90:	83 ec 08             	sub    $0x8,%esp
80103b93:	68 00 00 01 00       	push   $0x10000
80103b98:	68 00 00 0f 00       	push   $0xf0000
80103b9d:	e8 e0 fe ff ff       	call   80103a82 <mpsearch1>
80103ba2:	83 c4 10             	add    $0x10,%esp
}
80103ba5:	c9                   	leave  
80103ba6:	c3                   	ret    

80103ba7 <mpconfig>:
// Check for correct signature, calculate the checksum and,
// if correct, check the version.
// To do: check extended table checksum.
static struct mpconf*
mpconfig(struct mp **pmp)
{
80103ba7:	55                   	push   %ebp
80103ba8:	89 e5                	mov    %esp,%ebp
80103baa:	83 ec 18             	sub    $0x18,%esp
  struct mpconf *conf;
  struct mp *mp;

  if((mp = mpsearch()) == 0 || mp->physaddr == 0)
80103bad:	e8 39 ff ff ff       	call   80103aeb <mpsearch>
80103bb2:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103bb5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103bb9:	74 0a                	je     80103bc5 <mpconfig+0x1e>
80103bbb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bbe:	8b 40 04             	mov    0x4(%eax),%eax
80103bc1:	85 c0                	test   %eax,%eax
80103bc3:	75 07                	jne    80103bcc <mpconfig+0x25>
    return 0;
80103bc5:	b8 00 00 00 00       	mov    $0x0,%eax
80103bca:	eb 7a                	jmp    80103c46 <mpconfig+0x9f>
  conf = (struct mpconf*) P2V((uint) mp->physaddr);
80103bcc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103bcf:	8b 40 04             	mov    0x4(%eax),%eax
80103bd2:	05 00 00 00 80       	add    $0x80000000,%eax
80103bd7:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(memcmp(conf, "PCMP", 4) != 0)
80103bda:	83 ec 04             	sub    $0x4,%esp
80103bdd:	6a 04                	push   $0x4
80103bdf:	68 c9 98 10 80       	push   $0x801098c9
80103be4:	ff 75 f0             	push   -0x10(%ebp)
80103be7:	e8 2e 27 00 00       	call   8010631a <memcmp>
80103bec:	83 c4 10             	add    $0x10,%esp
80103bef:	85 c0                	test   %eax,%eax
80103bf1:	74 07                	je     80103bfa <mpconfig+0x53>
    return 0;
80103bf3:	b8 00 00 00 00       	mov    $0x0,%eax
80103bf8:	eb 4c                	jmp    80103c46 <mpconfig+0x9f>
  if(conf->version != 1 && conf->version != 4)
80103bfa:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103bfd:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103c01:	3c 01                	cmp    $0x1,%al
80103c03:	74 12                	je     80103c17 <mpconfig+0x70>
80103c05:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c08:	0f b6 40 06          	movzbl 0x6(%eax),%eax
80103c0c:	3c 04                	cmp    $0x4,%al
80103c0e:	74 07                	je     80103c17 <mpconfig+0x70>
    return 0;
80103c10:	b8 00 00 00 00       	mov    $0x0,%eax
80103c15:	eb 2f                	jmp    80103c46 <mpconfig+0x9f>
  if(sum((uchar*)conf, conf->length) != 0)
80103c17:	8b 45 f0             	mov    -0x10(%ebp),%eax
80103c1a:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103c1e:	0f b7 c0             	movzwl %ax,%eax
80103c21:	83 ec 08             	sub    $0x8,%esp
80103c24:	50                   	push   %eax
80103c25:	ff 75 f0             	push   -0x10(%ebp)
80103c28:	e8 1d fe ff ff       	call   80103a4a <sum>
80103c2d:	83 c4 10             	add    $0x10,%esp
80103c30:	84 c0                	test   %al,%al
80103c32:	74 07                	je     80103c3b <mpconfig+0x94>
    return 0;
80103c34:	b8 00 00 00 00       	mov    $0x0,%eax
80103c39:	eb 0b                	jmp    80103c46 <mpconfig+0x9f>
  *pmp = mp;
80103c3b:	8b 45 08             	mov    0x8(%ebp),%eax
80103c3e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103c41:	89 10                	mov    %edx,(%eax)
  return conf;
80103c43:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80103c46:	c9                   	leave  
80103c47:	c3                   	ret    

80103c48 <mpinit>:

void
mpinit(void)
{
80103c48:	55                   	push   %ebp
80103c49:	89 e5                	mov    %esp,%ebp
80103c4b:	83 ec 28             	sub    $0x28,%esp
  struct mp *mp;
  struct mpconf *conf;
  struct mpproc *proc;
  struct mpioapic *ioapic;

  if((conf = mpconfig(&mp)) == 0)
80103c4e:	83 ec 0c             	sub    $0xc,%esp
80103c51:	8d 45 dc             	lea    -0x24(%ebp),%eax
80103c54:	50                   	push   %eax
80103c55:	e8 4d ff ff ff       	call   80103ba7 <mpconfig>
80103c5a:	83 c4 10             	add    $0x10,%esp
80103c5d:	89 45 ec             	mov    %eax,-0x14(%ebp)
80103c60:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80103c64:	75 0d                	jne    80103c73 <mpinit+0x2b>
    panic("Expect to run on an SMP");
80103c66:	83 ec 0c             	sub    $0xc,%esp
80103c69:	68 ce 98 10 80       	push   $0x801098ce
80103c6e:	e8 42 c9 ff ff       	call   801005b5 <panic>
  ismp = 1;
80103c73:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  lapic = (uint*)conf->lapicaddr;
80103c7a:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103c7d:	8b 40 24             	mov    0x24(%eax),%eax
80103c80:	a3 e0 36 11 80       	mov    %eax,0x801136e0
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103c85:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103c88:	83 c0 2c             	add    $0x2c,%eax
80103c8b:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103c8e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103c91:	0f b7 40 04          	movzwl 0x4(%eax),%eax
80103c95:	0f b7 d0             	movzwl %ax,%edx
80103c98:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103c9b:	01 d0                	add    %edx,%eax
80103c9d:	89 45 e8             	mov    %eax,-0x18(%ebp)
80103ca0:	e9 8c 00 00 00       	jmp    80103d31 <mpinit+0xe9>
    switch(*p){
80103ca5:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103ca8:	0f b6 00             	movzbl (%eax),%eax
80103cab:	0f b6 c0             	movzbl %al,%eax
80103cae:	83 f8 04             	cmp    $0x4,%eax
80103cb1:	7f 76                	jg     80103d29 <mpinit+0xe1>
80103cb3:	83 f8 03             	cmp    $0x3,%eax
80103cb6:	7d 6b                	jge    80103d23 <mpinit+0xdb>
80103cb8:	83 f8 02             	cmp    $0x2,%eax
80103cbb:	74 4e                	je     80103d0b <mpinit+0xc3>
80103cbd:	83 f8 02             	cmp    $0x2,%eax
80103cc0:	7f 67                	jg     80103d29 <mpinit+0xe1>
80103cc2:	85 c0                	test   %eax,%eax
80103cc4:	74 07                	je     80103ccd <mpinit+0x85>
80103cc6:	83 f8 01             	cmp    $0x1,%eax
80103cc9:	74 58                	je     80103d23 <mpinit+0xdb>
80103ccb:	eb 5c                	jmp    80103d29 <mpinit+0xe1>
    case MPPROC:
      proc = (struct mpproc*)p;
80103ccd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103cd0:	89 45 e0             	mov    %eax,-0x20(%ebp)
      if(ncpu < NCPU) {
80103cd3:	a1 60 3d 11 80       	mov    0x80113d60,%eax
80103cd8:	83 f8 07             	cmp    $0x7,%eax
80103cdb:	7f 28                	jg     80103d05 <mpinit+0xbd>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103cdd:	8b 15 60 3d 11 80    	mov    0x80113d60,%edx
80103ce3:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103ce6:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103cea:	69 d2 b0 00 00 00    	imul   $0xb0,%edx,%edx
80103cf0:	81 c2 e0 37 11 80    	add    $0x801137e0,%edx
80103cf6:	88 02                	mov    %al,(%edx)
        ncpu++;
80103cf8:	a1 60 3d 11 80       	mov    0x80113d60,%eax
80103cfd:	83 c0 01             	add    $0x1,%eax
80103d00:	a3 60 3d 11 80       	mov    %eax,0x80113d60
      }
      p += sizeof(struct mpproc);
80103d05:	83 45 f4 14          	addl   $0x14,-0xc(%ebp)
      continue;
80103d09:	eb 26                	jmp    80103d31 <mpinit+0xe9>
    case MPIOAPIC:
      ioapic = (struct mpioapic*)p;
80103d0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d0e:	89 45 e4             	mov    %eax,-0x1c(%ebp)
      ioapicid = ioapic->apicno;
80103d11:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80103d14:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103d18:	a2 64 3d 11 80       	mov    %al,0x80113d64
      p += sizeof(struct mpioapic);
80103d1d:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103d21:	eb 0e                	jmp    80103d31 <mpinit+0xe9>
    case MPBUS:
    case MPIOINTR:
    case MPLINTR:
      p += 8;
80103d23:	83 45 f4 08          	addl   $0x8,-0xc(%ebp)
      continue;
80103d27:	eb 08                	jmp    80103d31 <mpinit+0xe9>
    default:
      ismp = 0;
80103d29:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
      break;
80103d30:	90                   	nop
  for(p=(uchar*)(conf+1), e=(uchar*)conf+conf->length; p<e; ){
80103d31:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103d34:	3b 45 e8             	cmp    -0x18(%ebp),%eax
80103d37:	0f 82 68 ff ff ff    	jb     80103ca5 <mpinit+0x5d>
    }
  }
  if(!ismp)
80103d3d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80103d41:	75 0d                	jne    80103d50 <mpinit+0x108>
    panic("Didn't find a suitable machine");
80103d43:	83 ec 0c             	sub    $0xc,%esp
80103d46:	68 e8 98 10 80       	push   $0x801098e8
80103d4b:	e8 65 c8 ff ff       	call   801005b5 <panic>

  if(mp->imcrp){
80103d50:	8b 45 dc             	mov    -0x24(%ebp),%eax
80103d53:	0f b6 40 0c          	movzbl 0xc(%eax),%eax
80103d57:	84 c0                	test   %al,%al
80103d59:	74 30                	je     80103d8b <mpinit+0x143>
    // Bochs doesn't support IMCR, so this doesn't run on Bochs.
    // But it would on real hardware.
    outb(0x22, 0x70);   // Select IMCR
80103d5b:	83 ec 08             	sub    $0x8,%esp
80103d5e:	6a 70                	push   $0x70
80103d60:	6a 22                	push   $0x22
80103d62:	e8 c2 fc ff ff       	call   80103a29 <outb>
80103d67:	83 c4 10             	add    $0x10,%esp
    outb(0x23, inb(0x23) | 1);  // Mask external interrupts.
80103d6a:	83 ec 0c             	sub    $0xc,%esp
80103d6d:	6a 23                	push   $0x23
80103d6f:	e8 98 fc ff ff       	call   80103a0c <inb>
80103d74:	83 c4 10             	add    $0x10,%esp
80103d77:	83 c8 01             	or     $0x1,%eax
80103d7a:	0f b6 c0             	movzbl %al,%eax
80103d7d:	83 ec 08             	sub    $0x8,%esp
80103d80:	50                   	push   %eax
80103d81:	6a 23                	push   $0x23
80103d83:	e8 a1 fc ff ff       	call   80103a29 <outb>
80103d88:	83 c4 10             	add    $0x10,%esp
  }
}
80103d8b:	90                   	nop
80103d8c:	c9                   	leave  
80103d8d:	c3                   	ret    

80103d8e <outb>:
{
80103d8e:	55                   	push   %ebp
80103d8f:	89 e5                	mov    %esp,%ebp
80103d91:	83 ec 08             	sub    $0x8,%esp
80103d94:	8b 45 08             	mov    0x8(%ebp),%eax
80103d97:	8b 55 0c             	mov    0xc(%ebp),%edx
80103d9a:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80103d9e:	89 d0                	mov    %edx,%eax
80103da0:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80103da3:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80103da7:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80103dab:	ee                   	out    %al,(%dx)
}
80103dac:	90                   	nop
80103dad:	c9                   	leave  
80103dae:	c3                   	ret    

80103daf <picinit>:
#define IO_PIC2         0xA0    // Slave (IRQs 8-15)

// Don't use the 8259A interrupt controllers.  Xv6 assumes SMP hardware.
void
picinit(void)
{
80103daf:	55                   	push   %ebp
80103db0:	89 e5                	mov    %esp,%ebp
  // mask all interrupts
  outb(IO_PIC1+1, 0xFF);
80103db2:	68 ff 00 00 00       	push   $0xff
80103db7:	6a 21                	push   $0x21
80103db9:	e8 d0 ff ff ff       	call   80103d8e <outb>
80103dbe:	83 c4 08             	add    $0x8,%esp
  outb(IO_PIC2+1, 0xFF);
80103dc1:	68 ff 00 00 00       	push   $0xff
80103dc6:	68 a1 00 00 00       	push   $0xa1
80103dcb:	e8 be ff ff ff       	call   80103d8e <outb>
80103dd0:	83 c4 08             	add    $0x8,%esp
}
80103dd3:	90                   	nop
80103dd4:	c9                   	leave  
80103dd5:	c3                   	ret    

80103dd6 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
80103dd6:	55                   	push   %ebp
80103dd7:	89 e5                	mov    %esp,%ebp
80103dd9:	83 ec 18             	sub    $0x18,%esp
  struct pipe *p;

  p = 0;
80103ddc:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  *f0 = *f1 = 0;
80103de3:	8b 45 0c             	mov    0xc(%ebp),%eax
80103de6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
80103dec:	8b 45 0c             	mov    0xc(%ebp),%eax
80103def:	8b 10                	mov    (%eax),%edx
80103df1:	8b 45 08             	mov    0x8(%ebp),%eax
80103df4:	89 10                	mov    %edx,(%eax)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
80103df6:	e8 25 d2 ff ff       	call   80101020 <filealloc>
80103dfb:	8b 55 08             	mov    0x8(%ebp),%edx
80103dfe:	89 02                	mov    %eax,(%edx)
80103e00:	8b 45 08             	mov    0x8(%ebp),%eax
80103e03:	8b 00                	mov    (%eax),%eax
80103e05:	85 c0                	test   %eax,%eax
80103e07:	0f 84 c8 00 00 00    	je     80103ed5 <pipealloc+0xff>
80103e0d:	e8 0e d2 ff ff       	call   80101020 <filealloc>
80103e12:	8b 55 0c             	mov    0xc(%ebp),%edx
80103e15:	89 02                	mov    %eax,(%edx)
80103e17:	8b 45 0c             	mov    0xc(%ebp),%eax
80103e1a:	8b 00                	mov    (%eax),%eax
80103e1c:	85 c0                	test   %eax,%eax
80103e1e:	0f 84 b1 00 00 00    	je     80103ed5 <pipealloc+0xff>
    goto bad;
  if((p = (struct pipe*)kalloc()) == 0)
80103e24:	e8 6d ee ff ff       	call   80102c96 <kalloc>
80103e29:	89 45 f4             	mov    %eax,-0xc(%ebp)
80103e2c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103e30:	0f 84 a2 00 00 00    	je     80103ed8 <pipealloc+0x102>
    goto bad;
  p->readopen = 1;
80103e36:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e39:	c7 80 3c 02 00 00 01 	movl   $0x1,0x23c(%eax)
80103e40:	00 00 00 
  p->writeopen = 1;
80103e43:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e46:	c7 80 40 02 00 00 01 	movl   $0x1,0x240(%eax)
80103e4d:	00 00 00 
  p->nwrite = 0;
80103e50:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e53:	c7 80 38 02 00 00 00 	movl   $0x0,0x238(%eax)
80103e5a:	00 00 00 
  p->nread = 0;
80103e5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e60:	c7 80 34 02 00 00 00 	movl   $0x0,0x234(%eax)
80103e67:	00 00 00 
  initlock(&p->lock, "pipe");
80103e6a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80103e6d:	83 ec 08             	sub    $0x8,%esp
80103e70:	68 07 99 10 80       	push   $0x80109907
80103e75:	50                   	push   %eax
80103e76:	e8 90 21 00 00       	call   8010600b <initlock>
80103e7b:	83 c4 10             	add    $0x10,%esp
  (*f0)->type = FD_PIPE;
80103e7e:	8b 45 08             	mov    0x8(%ebp),%eax
80103e81:	8b 00                	mov    (%eax),%eax
80103e83:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f0)->readable = 1;
80103e89:	8b 45 08             	mov    0x8(%ebp),%eax
80103e8c:	8b 00                	mov    (%eax),%eax
80103e8e:	c6 40 08 01          	movb   $0x1,0x8(%eax)
  (*f0)->writable = 0;
80103e92:	8b 45 08             	mov    0x8(%ebp),%eax
80103e95:	8b 00                	mov    (%eax),%eax
80103e97:	c6 40 09 00          	movb   $0x0,0x9(%eax)
  (*f0)->pipe = p;
80103e9b:	8b 45 08             	mov    0x8(%ebp),%eax
80103e9e:	8b 00                	mov    (%eax),%eax
80103ea0:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103ea3:	89 50 0c             	mov    %edx,0xc(%eax)
  (*f1)->type = FD_PIPE;
80103ea6:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ea9:	8b 00                	mov    (%eax),%eax
80103eab:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  (*f1)->readable = 0;
80103eb1:	8b 45 0c             	mov    0xc(%ebp),%eax
80103eb4:	8b 00                	mov    (%eax),%eax
80103eb6:	c6 40 08 00          	movb   $0x0,0x8(%eax)
  (*f1)->writable = 1;
80103eba:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ebd:	8b 00                	mov    (%eax),%eax
80103ebf:	c6 40 09 01          	movb   $0x1,0x9(%eax)
  (*f1)->pipe = p;
80103ec3:	8b 45 0c             	mov    0xc(%ebp),%eax
80103ec6:	8b 00                	mov    (%eax),%eax
80103ec8:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103ecb:	89 50 0c             	mov    %edx,0xc(%eax)
  return 0;
80103ece:	b8 00 00 00 00       	mov    $0x0,%eax
80103ed3:	eb 51                	jmp    80103f26 <pipealloc+0x150>
    goto bad;
80103ed5:	90                   	nop
80103ed6:	eb 01                	jmp    80103ed9 <pipealloc+0x103>
    goto bad;
80103ed8:	90                   	nop

//PAGEBREAK: 20
 bad:
  if(p)
80103ed9:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80103edd:	74 0e                	je     80103eed <pipealloc+0x117>
    kfree((char*)p);
80103edf:	83 ec 0c             	sub    $0xc,%esp
80103ee2:	ff 75 f4             	push   -0xc(%ebp)
80103ee5:	e8 12 ed ff ff       	call   80102bfc <kfree>
80103eea:	83 c4 10             	add    $0x10,%esp
  if(*f0)
80103eed:	8b 45 08             	mov    0x8(%ebp),%eax
80103ef0:	8b 00                	mov    (%eax),%eax
80103ef2:	85 c0                	test   %eax,%eax
80103ef4:	74 11                	je     80103f07 <pipealloc+0x131>
    fileclose(*f0);
80103ef6:	8b 45 08             	mov    0x8(%ebp),%eax
80103ef9:	8b 00                	mov    (%eax),%eax
80103efb:	83 ec 0c             	sub    $0xc,%esp
80103efe:	50                   	push   %eax
80103eff:	e8 da d1 ff ff       	call   801010de <fileclose>
80103f04:	83 c4 10             	add    $0x10,%esp
  if(*f1)
80103f07:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f0a:	8b 00                	mov    (%eax),%eax
80103f0c:	85 c0                	test   %eax,%eax
80103f0e:	74 11                	je     80103f21 <pipealloc+0x14b>
    fileclose(*f1);
80103f10:	8b 45 0c             	mov    0xc(%ebp),%eax
80103f13:	8b 00                	mov    (%eax),%eax
80103f15:	83 ec 0c             	sub    $0xc,%esp
80103f18:	50                   	push   %eax
80103f19:	e8 c0 d1 ff ff       	call   801010de <fileclose>
80103f1e:	83 c4 10             	add    $0x10,%esp
  return -1;
80103f21:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80103f26:	c9                   	leave  
80103f27:	c3                   	ret    

80103f28 <pipeclose>:

void
pipeclose(struct pipe *p, int writable)
{
80103f28:	55                   	push   %ebp
80103f29:	89 e5                	mov    %esp,%ebp
80103f2b:	83 ec 08             	sub    $0x8,%esp
  acquire(&p->lock);
80103f2e:	8b 45 08             	mov    0x8(%ebp),%eax
80103f31:	83 ec 0c             	sub    $0xc,%esp
80103f34:	50                   	push   %eax
80103f35:	e8 f3 20 00 00       	call   8010602d <acquire>
80103f3a:	83 c4 10             	add    $0x10,%esp
  if(writable){
80103f3d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80103f41:	74 23                	je     80103f66 <pipeclose+0x3e>
    p->writeopen = 0;
80103f43:	8b 45 08             	mov    0x8(%ebp),%eax
80103f46:	c7 80 40 02 00 00 00 	movl   $0x0,0x240(%eax)
80103f4d:	00 00 00 
    wakeup(&p->nread);
80103f50:	8b 45 08             	mov    0x8(%ebp),%eax
80103f53:	05 34 02 00 00       	add    $0x234,%eax
80103f58:	83 ec 0c             	sub    $0xc,%esp
80103f5b:	50                   	push   %eax
80103f5c:	e8 69 14 00 00       	call   801053ca <wakeup>
80103f61:	83 c4 10             	add    $0x10,%esp
80103f64:	eb 21                	jmp    80103f87 <pipeclose+0x5f>
  } else {
    p->readopen = 0;
80103f66:	8b 45 08             	mov    0x8(%ebp),%eax
80103f69:	c7 80 3c 02 00 00 00 	movl   $0x0,0x23c(%eax)
80103f70:	00 00 00 
    wakeup(&p->nwrite);
80103f73:	8b 45 08             	mov    0x8(%ebp),%eax
80103f76:	05 38 02 00 00       	add    $0x238,%eax
80103f7b:	83 ec 0c             	sub    $0xc,%esp
80103f7e:	50                   	push   %eax
80103f7f:	e8 46 14 00 00       	call   801053ca <wakeup>
80103f84:	83 c4 10             	add    $0x10,%esp
  }
  if(p->readopen == 0 && p->writeopen == 0){
80103f87:	8b 45 08             	mov    0x8(%ebp),%eax
80103f8a:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80103f90:	85 c0                	test   %eax,%eax
80103f92:	75 2c                	jne    80103fc0 <pipeclose+0x98>
80103f94:	8b 45 08             	mov    0x8(%ebp),%eax
80103f97:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80103f9d:	85 c0                	test   %eax,%eax
80103f9f:	75 1f                	jne    80103fc0 <pipeclose+0x98>
    release(&p->lock);
80103fa1:	8b 45 08             	mov    0x8(%ebp),%eax
80103fa4:	83 ec 0c             	sub    $0xc,%esp
80103fa7:	50                   	push   %eax
80103fa8:	e8 ee 20 00 00       	call   8010609b <release>
80103fad:	83 c4 10             	add    $0x10,%esp
    kfree((char*)p);
80103fb0:	83 ec 0c             	sub    $0xc,%esp
80103fb3:	ff 75 08             	push   0x8(%ebp)
80103fb6:	e8 41 ec ff ff       	call   80102bfc <kfree>
80103fbb:	83 c4 10             	add    $0x10,%esp
80103fbe:	eb 10                	jmp    80103fd0 <pipeclose+0xa8>
  } else
    release(&p->lock);
80103fc0:	8b 45 08             	mov    0x8(%ebp),%eax
80103fc3:	83 ec 0c             	sub    $0xc,%esp
80103fc6:	50                   	push   %eax
80103fc7:	e8 cf 20 00 00       	call   8010609b <release>
80103fcc:	83 c4 10             	add    $0x10,%esp
}
80103fcf:	90                   	nop
80103fd0:	90                   	nop
80103fd1:	c9                   	leave  
80103fd2:	c3                   	ret    

80103fd3 <pipewrite>:

//PAGEBREAK: 40
int
pipewrite(struct pipe *p, char *addr, int n)
{
80103fd3:	55                   	push   %ebp
80103fd4:	89 e5                	mov    %esp,%ebp
80103fd6:	53                   	push   %ebx
80103fd7:	83 ec 14             	sub    $0x14,%esp
  int i;

  acquire(&p->lock);
80103fda:	8b 45 08             	mov    0x8(%ebp),%eax
80103fdd:	83 ec 0c             	sub    $0xc,%esp
80103fe0:	50                   	push   %eax
80103fe1:	e8 47 20 00 00       	call   8010602d <acquire>
80103fe6:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < n; i++){
80103fe9:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103ff0:	e9 ad 00 00 00       	jmp    801040a2 <pipewrite+0xcf>
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
      if(p->readopen == 0 || myproc()->killed){
80103ff5:	8b 45 08             	mov    0x8(%ebp),%eax
80103ff8:	8b 80 3c 02 00 00    	mov    0x23c(%eax),%eax
80103ffe:	85 c0                	test   %eax,%eax
80104000:	74 0c                	je     8010400e <pipewrite+0x3b>
80104002:	e8 0f 03 00 00       	call   80104316 <myproc>
80104007:	8b 40 24             	mov    0x24(%eax),%eax
8010400a:	85 c0                	test   %eax,%eax
8010400c:	74 19                	je     80104027 <pipewrite+0x54>
        release(&p->lock);
8010400e:	8b 45 08             	mov    0x8(%ebp),%eax
80104011:	83 ec 0c             	sub    $0xc,%esp
80104014:	50                   	push   %eax
80104015:	e8 81 20 00 00       	call   8010609b <release>
8010401a:	83 c4 10             	add    $0x10,%esp
        return -1;
8010401d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104022:	e9 a9 00 00 00       	jmp    801040d0 <pipewrite+0xfd>
      }
      wakeup(&p->nread);
80104027:	8b 45 08             	mov    0x8(%ebp),%eax
8010402a:	05 34 02 00 00       	add    $0x234,%eax
8010402f:	83 ec 0c             	sub    $0xc,%esp
80104032:	50                   	push   %eax
80104033:	e8 92 13 00 00       	call   801053ca <wakeup>
80104038:	83 c4 10             	add    $0x10,%esp
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010403b:	8b 45 08             	mov    0x8(%ebp),%eax
8010403e:	8b 55 08             	mov    0x8(%ebp),%edx
80104041:	81 c2 38 02 00 00    	add    $0x238,%edx
80104047:	83 ec 08             	sub    $0x8,%esp
8010404a:	50                   	push   %eax
8010404b:	52                   	push   %edx
8010404c:	e8 fb 11 00 00       	call   8010524c <sleep>
80104051:	83 c4 10             	add    $0x10,%esp
    while(p->nwrite == p->nread + PIPESIZE){  //DOC: pipewrite-full
80104054:	8b 45 08             	mov    0x8(%ebp),%eax
80104057:	8b 90 38 02 00 00    	mov    0x238(%eax),%edx
8010405d:	8b 45 08             	mov    0x8(%ebp),%eax
80104060:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80104066:	05 00 02 00 00       	add    $0x200,%eax
8010406b:	39 c2                	cmp    %eax,%edx
8010406d:	74 86                	je     80103ff5 <pipewrite+0x22>
    }
    p->data[p->nwrite++ % PIPESIZE] = addr[i];
8010406f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104072:	8b 45 0c             	mov    0xc(%ebp),%eax
80104075:	8d 1c 02             	lea    (%edx,%eax,1),%ebx
80104078:	8b 45 08             	mov    0x8(%ebp),%eax
8010407b:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104081:	8d 48 01             	lea    0x1(%eax),%ecx
80104084:	8b 55 08             	mov    0x8(%ebp),%edx
80104087:	89 8a 38 02 00 00    	mov    %ecx,0x238(%edx)
8010408d:	25 ff 01 00 00       	and    $0x1ff,%eax
80104092:	89 c1                	mov    %eax,%ecx
80104094:	0f b6 13             	movzbl (%ebx),%edx
80104097:	8b 45 08             	mov    0x8(%ebp),%eax
8010409a:	88 54 08 34          	mov    %dl,0x34(%eax,%ecx,1)
  for(i = 0; i < n; i++){
8010409e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801040a2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801040a5:	3b 45 10             	cmp    0x10(%ebp),%eax
801040a8:	7c aa                	jl     80104054 <pipewrite+0x81>
  }
  wakeup(&p->nread);  //DOC: pipewrite-wakeup1
801040aa:	8b 45 08             	mov    0x8(%ebp),%eax
801040ad:	05 34 02 00 00       	add    $0x234,%eax
801040b2:	83 ec 0c             	sub    $0xc,%esp
801040b5:	50                   	push   %eax
801040b6:	e8 0f 13 00 00       	call   801053ca <wakeup>
801040bb:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
801040be:	8b 45 08             	mov    0x8(%ebp),%eax
801040c1:	83 ec 0c             	sub    $0xc,%esp
801040c4:	50                   	push   %eax
801040c5:	e8 d1 1f 00 00       	call   8010609b <release>
801040ca:	83 c4 10             	add    $0x10,%esp
  return n;
801040cd:	8b 45 10             	mov    0x10(%ebp),%eax
}
801040d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801040d3:	c9                   	leave  
801040d4:	c3                   	ret    

801040d5 <piperead>:

int
piperead(struct pipe *p, char *addr, int n)
{
801040d5:	55                   	push   %ebp
801040d6:	89 e5                	mov    %esp,%ebp
801040d8:	83 ec 18             	sub    $0x18,%esp
  int i;

  acquire(&p->lock);
801040db:	8b 45 08             	mov    0x8(%ebp),%eax
801040de:	83 ec 0c             	sub    $0xc,%esp
801040e1:	50                   	push   %eax
801040e2:	e8 46 1f 00 00       	call   8010602d <acquire>
801040e7:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
801040ea:	eb 3e                	jmp    8010412a <piperead+0x55>
    if(myproc()->killed){
801040ec:	e8 25 02 00 00       	call   80104316 <myproc>
801040f1:	8b 40 24             	mov    0x24(%eax),%eax
801040f4:	85 c0                	test   %eax,%eax
801040f6:	74 19                	je     80104111 <piperead+0x3c>
      release(&p->lock);
801040f8:	8b 45 08             	mov    0x8(%ebp),%eax
801040fb:	83 ec 0c             	sub    $0xc,%esp
801040fe:	50                   	push   %eax
801040ff:	e8 97 1f 00 00       	call   8010609b <release>
80104104:	83 c4 10             	add    $0x10,%esp
      return -1;
80104107:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010410c:	e9 be 00 00 00       	jmp    801041cf <piperead+0xfa>
    }
    sleep(&p->nread, &p->lock); //DOC: piperead-sleep
80104111:	8b 45 08             	mov    0x8(%ebp),%eax
80104114:	8b 55 08             	mov    0x8(%ebp),%edx
80104117:	81 c2 34 02 00 00    	add    $0x234,%edx
8010411d:	83 ec 08             	sub    $0x8,%esp
80104120:	50                   	push   %eax
80104121:	52                   	push   %edx
80104122:	e8 25 11 00 00       	call   8010524c <sleep>
80104127:	83 c4 10             	add    $0x10,%esp
  while(p->nread == p->nwrite && p->writeopen){  //DOC: pipe-empty
8010412a:	8b 45 08             	mov    0x8(%ebp),%eax
8010412d:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
80104133:	8b 45 08             	mov    0x8(%ebp),%eax
80104136:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
8010413c:	39 c2                	cmp    %eax,%edx
8010413e:	75 0d                	jne    8010414d <piperead+0x78>
80104140:	8b 45 08             	mov    0x8(%ebp),%eax
80104143:	8b 80 40 02 00 00    	mov    0x240(%eax),%eax
80104149:	85 c0                	test   %eax,%eax
8010414b:	75 9f                	jne    801040ec <piperead+0x17>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010414d:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104154:	eb 48                	jmp    8010419e <piperead+0xc9>
    if(p->nread == p->nwrite)
80104156:	8b 45 08             	mov    0x8(%ebp),%eax
80104159:	8b 90 34 02 00 00    	mov    0x234(%eax),%edx
8010415f:	8b 45 08             	mov    0x8(%ebp),%eax
80104162:	8b 80 38 02 00 00    	mov    0x238(%eax),%eax
80104168:	39 c2                	cmp    %eax,%edx
8010416a:	74 3c                	je     801041a8 <piperead+0xd3>
      break;
    addr[i] = p->data[p->nread++ % PIPESIZE];
8010416c:	8b 45 08             	mov    0x8(%ebp),%eax
8010416f:	8b 80 34 02 00 00    	mov    0x234(%eax),%eax
80104175:	8d 48 01             	lea    0x1(%eax),%ecx
80104178:	8b 55 08             	mov    0x8(%ebp),%edx
8010417b:	89 8a 34 02 00 00    	mov    %ecx,0x234(%edx)
80104181:	25 ff 01 00 00       	and    $0x1ff,%eax
80104186:	89 c1                	mov    %eax,%ecx
80104188:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010418b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010418e:	01 c2                	add    %eax,%edx
80104190:	8b 45 08             	mov    0x8(%ebp),%eax
80104193:	0f b6 44 08 34       	movzbl 0x34(%eax,%ecx,1),%eax
80104198:	88 02                	mov    %al,(%edx)
  for(i = 0; i < n; i++){  //DOC: piperead-copy
8010419a:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010419e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801041a1:	3b 45 10             	cmp    0x10(%ebp),%eax
801041a4:	7c b0                	jl     80104156 <piperead+0x81>
801041a6:	eb 01                	jmp    801041a9 <piperead+0xd4>
      break;
801041a8:	90                   	nop
  }
  wakeup(&p->nwrite);  //DOC: piperead-wakeup
801041a9:	8b 45 08             	mov    0x8(%ebp),%eax
801041ac:	05 38 02 00 00       	add    $0x238,%eax
801041b1:	83 ec 0c             	sub    $0xc,%esp
801041b4:	50                   	push   %eax
801041b5:	e8 10 12 00 00       	call   801053ca <wakeup>
801041ba:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
801041bd:	8b 45 08             	mov    0x8(%ebp),%eax
801041c0:	83 ec 0c             	sub    $0xc,%esp
801041c3:	50                   	push   %eax
801041c4:	e8 d2 1e 00 00       	call   8010609b <release>
801041c9:	83 c4 10             	add    $0x10,%esp
  return i;
801041cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801041cf:	c9                   	leave  
801041d0:	c3                   	ret    

801041d1 <readeflags>:
{
801041d1:	55                   	push   %ebp
801041d2:	89 e5                	mov    %esp,%ebp
801041d4:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
801041d7:	9c                   	pushf  
801041d8:	58                   	pop    %eax
801041d9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
801041dc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801041df:	c9                   	leave  
801041e0:	c3                   	ret    

801041e1 <sti>:
{
801041e1:	55                   	push   %ebp
801041e2:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
801041e4:	fb                   	sti    
}
801041e5:	90                   	nop
801041e6:	5d                   	pop    %ebp
801041e7:	c3                   	ret    

801041e8 <randGen>:
struct queue rr_q;
struct queue lcfs_q;
struct queue bjf_q;

uint randGen(uint seed)
{
801041e8:	55                   	push   %ebp
801041e9:	89 e5                	mov    %esp,%ebp
801041eb:	83 ec 10             	sub    $0x10,%esp
  uint cticks = ticks;
801041ee:	a1 54 73 11 80       	mov    0x80117354,%eax
801041f3:	89 45 fc             	mov    %eax,-0x4(%ebp)
  seed += cticks;
801041f6:	8b 45 fc             	mov    -0x4(%ebp),%eax
801041f9:	01 45 08             	add    %eax,0x8(%ebp)
  seed <<= 5;
801041fc:	c1 65 08 05          	shll   $0x5,0x8(%ebp)
  seed /= 13;
80104200:	8b 45 08             	mov    0x8(%ebp),%eax
80104203:	ba 4f ec c4 4e       	mov    $0x4ec4ec4f,%edx
80104208:	f7 e2                	mul    %edx
8010420a:	89 d0                	mov    %edx,%eax
8010420c:	c1 e8 02             	shr    $0x2,%eax
8010420f:	89 45 08             	mov    %eax,0x8(%ebp)
  seed <<= 1;
80104212:	d1 65 08             	shll   0x8(%ebp)
  seed *= 17;
80104215:	8b 45 08             	mov    0x8(%ebp),%eax
80104218:	89 c2                	mov    %eax,%edx
8010421a:	c1 e2 04             	shl    $0x4,%edx
8010421d:	01 d0                	add    %edx,%eax
8010421f:	89 45 08             	mov    %eax,0x8(%ebp)
  seed >>= 2;
80104222:	c1 6d 08 02          	shrl   $0x2,0x8(%ebp)
  seed -= cticks / 3;
80104226:	8b 45 fc             	mov    -0x4(%ebp),%eax
80104229:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
8010422e:	f7 e2                	mul    %edx
80104230:	89 d0                	mov    %edx,%eax
80104232:	d1 e8                	shr    %eax
80104234:	29 45 08             	sub    %eax,0x8(%ebp)
  return seed / 3;
80104237:	8b 45 08             	mov    0x8(%ebp),%eax
8010423a:	ba ab aa aa aa       	mov    $0xaaaaaaab,%edx
8010423f:	f7 e2                	mul    %edx
80104241:	89 d0                	mov    %edx,%eax
80104243:	d1 e8                	shr    %eax
}
80104245:	c9                   	leave  
80104246:	c3                   	ret    

80104247 <pinit>:
extern void trapret(void);

static void wakeup1(void *chan);

void pinit(void)
{
80104247:	55                   	push   %ebp
80104248:	89 e5                	mov    %esp,%ebp
8010424a:	83 ec 08             	sub    $0x8,%esp
  initlock(&ptable.lock, "ptable");
8010424d:	83 ec 08             	sub    $0x8,%esp
80104250:	68 0c 99 10 80       	push   $0x8010990c
80104255:	68 80 3d 11 80       	push   $0x80113d80
8010425a:	e8 ac 1d 00 00       	call   8010600b <initlock>
8010425f:	83 c4 10             	add    $0x10,%esp

  rr_q.pi = -1;
80104262:	c7 05 c0 68 11 80 ff 	movl   $0xffffffff,0x801168c0
80104269:	ff ff ff 
  lcfs_q.pi = -1;
8010426c:	c7 05 e0 69 11 80 ff 	movl   $0xffffffff,0x801169e0
80104273:	ff ff ff 
  bjf_q.pi = -1;
80104276:	c7 05 00 6b 11 80 ff 	movl   $0xffffffff,0x80116b00
8010427d:	ff ff ff 
}
80104280:	90                   	nop
80104281:	c9                   	leave  
80104282:	c3                   	ret    

80104283 <cpuid>:

// Must be called with interrupts disabled
int cpuid()
{
80104283:	55                   	push   %ebp
80104284:	89 e5                	mov    %esp,%ebp
80104286:	83 ec 08             	sub    $0x8,%esp
  return mycpu() - cpus;
80104289:	e8 10 00 00 00       	call   8010429e <mycpu>
8010428e:	2d e0 37 11 80       	sub    $0x801137e0,%eax
80104293:	c1 f8 04             	sar    $0x4,%eax
80104296:	69 c0 a3 8b 2e ba    	imul   $0xba2e8ba3,%eax,%eax
}
8010429c:	c9                   	leave  
8010429d:	c3                   	ret    

8010429e <mycpu>:

// Must be called with interrupts disabled to avoid the caller being
// rescheduled between reading lapicid and running through the loop.
struct cpu *
mycpu(void)
{
8010429e:	55                   	push   %ebp
8010429f:	89 e5                	mov    %esp,%ebp
801042a1:	83 ec 18             	sub    $0x18,%esp
  int apicid, i;

  if (readeflags() & FL_IF)
801042a4:	e8 28 ff ff ff       	call   801041d1 <readeflags>
801042a9:	25 00 02 00 00       	and    $0x200,%eax
801042ae:	85 c0                	test   %eax,%eax
801042b0:	74 0d                	je     801042bf <mycpu+0x21>
    panic("mycpu called with interrupts enabled\n");
801042b2:	83 ec 0c             	sub    $0xc,%esp
801042b5:	68 14 99 10 80       	push   $0x80109914
801042ba:	e8 f6 c2 ff ff       	call   801005b5 <panic>

  apicid = lapicid();
801042bf:	e8 2c ed ff ff       	call   80102ff0 <lapicid>
801042c4:	89 45 f0             	mov    %eax,-0x10(%ebp)
  // APIC IDs are not guaranteed to be contiguous. Maybe we should have
  // a reverse map, or reserve a register to store &cpus[i].
  for (i = 0; i < ncpu; ++i)
801042c7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801042ce:	eb 2d                	jmp    801042fd <mycpu+0x5f>
  {
    if (cpus[i].apicid == apicid)
801042d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042d3:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
801042d9:	05 e0 37 11 80       	add    $0x801137e0,%eax
801042de:	0f b6 00             	movzbl (%eax),%eax
801042e1:	0f b6 c0             	movzbl %al,%eax
801042e4:	39 45 f0             	cmp    %eax,-0x10(%ebp)
801042e7:	75 10                	jne    801042f9 <mycpu+0x5b>
      return &cpus[i];
801042e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042ec:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
801042f2:	05 e0 37 11 80       	add    $0x801137e0,%eax
801042f7:	eb 1b                	jmp    80104314 <mycpu+0x76>
  for (i = 0; i < ncpu; ++i)
801042f9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801042fd:	a1 60 3d 11 80       	mov    0x80113d60,%eax
80104302:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80104305:	7c c9                	jl     801042d0 <mycpu+0x32>
  }
  panic("unknown apicid\n");
80104307:	83 ec 0c             	sub    $0xc,%esp
8010430a:	68 3a 99 10 80       	push   $0x8010993a
8010430f:	e8 a1 c2 ff ff       	call   801005b5 <panic>
}
80104314:	c9                   	leave  
80104315:	c3                   	ret    

80104316 <myproc>:

// Disable interrupts so that we are not rescheduled
// while reading proc from the cpu structure
struct proc *
myproc(void)
{
80104316:	55                   	push   %ebp
80104317:	89 e5                	mov    %esp,%ebp
80104319:	83 ec 18             	sub    $0x18,%esp
  struct cpu *c;
  struct proc *p;
  pushcli();
8010431c:	e8 87 1e 00 00       	call   801061a8 <pushcli>
  c = mycpu();
80104321:	e8 78 ff ff ff       	call   8010429e <mycpu>
80104326:	89 45 f4             	mov    %eax,-0xc(%ebp)
  p = c->proc;
80104329:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010432c:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104332:	89 45 f0             	mov    %eax,-0x10(%ebp)
  popcli();
80104335:	e8 bb 1e 00 00       	call   801061f5 <popcli>
  return p;
8010433a:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
8010433d:	c9                   	leave  
8010433e:	c3                   	ret    

8010433f <allocproc>:
//  state required to run in the kernel.
//  Otherwise return 0.

static struct proc *
allocproc(void)
{
8010433f:	55                   	push   %ebp
80104340:	89 e5                	mov    %esp,%ebp
80104342:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  char *sp;

  acquire(&ptable.lock);
80104345:	83 ec 0c             	sub    $0xc,%esp
80104348:	68 80 3d 11 80       	push   $0x80113d80
8010434d:	e8 db 1c 00 00       	call   8010602d <acquire>
80104352:	83 c4 10             	add    $0x10,%esp

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104355:	c7 45 f4 b4 3d 11 80 	movl   $0x80113db4,-0xc(%ebp)
8010435c:	eb 11                	jmp    8010436f <allocproc+0x30>
    if (p->state == UNUSED)
8010435e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104361:	8b 40 0c             	mov    0xc(%eax),%eax
80104364:	85 c0                	test   %eax,%eax
80104366:	74 2a                	je     80104392 <allocproc+0x53>
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104368:	81 45 f4 a8 00 00 00 	addl   $0xa8,-0xc(%ebp)
8010436f:	81 7d f4 b4 67 11 80 	cmpl   $0x801167b4,-0xc(%ebp)
80104376:	72 e6                	jb     8010435e <allocproc+0x1f>
      goto found;

  release(&ptable.lock);
80104378:	83 ec 0c             	sub    $0xc,%esp
8010437b:	68 80 3d 11 80       	push   $0x80113d80
80104380:	e8 16 1d 00 00       	call   8010609b <release>
80104385:	83 c4 10             	add    $0x10,%esp
  return 0;
80104388:	b8 00 00 00 00       	mov    $0x0,%eax
8010438d:	e9 c1 00 00 00       	jmp    80104453 <allocproc+0x114>
      goto found;
80104392:	90                   	nop

found:

  p->state = EMBRYO;
80104393:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104396:	c7 40 0c 01 00 00 00 	movl   $0x1,0xc(%eax)
  p->pid = nextpid++;
8010439d:	a1 00 c0 10 80       	mov    0x8010c000,%eax
801043a2:	8d 50 01             	lea    0x1(%eax),%edx
801043a5:	89 15 00 c0 10 80    	mov    %edx,0x8010c000
801043ab:	8b 55 f4             	mov    -0xc(%ebp),%edx
801043ae:	89 42 10             	mov    %eax,0x10(%edx)

  release(&ptable.lock);
801043b1:	83 ec 0c             	sub    $0xc,%esp
801043b4:	68 80 3d 11 80       	push   $0x80113d80
801043b9:	e8 dd 1c 00 00       	call   8010609b <release>
801043be:	83 c4 10             	add    $0x10,%esp

  // Allocate kernel stack.
  if ((p->kstack = kalloc()) == 0)
801043c1:	e8 d0 e8 ff ff       	call   80102c96 <kalloc>
801043c6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801043c9:	89 42 08             	mov    %eax,0x8(%edx)
801043cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043cf:	8b 40 08             	mov    0x8(%eax),%eax
801043d2:	85 c0                	test   %eax,%eax
801043d4:	75 11                	jne    801043e7 <allocproc+0xa8>
  {
    p->state = UNUSED;
801043d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043d9:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return 0;
801043e0:	b8 00 00 00 00       	mov    $0x0,%eax
801043e5:	eb 6c                	jmp    80104453 <allocproc+0x114>
  }
  sp = p->kstack + KSTACKSIZE;
801043e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043ea:	8b 40 08             	mov    0x8(%eax),%eax
801043ed:	05 00 10 00 00       	add    $0x1000,%eax
801043f2:	89 45 f0             	mov    %eax,-0x10(%ebp)

  // Leave room for trap frame.
  sp -= sizeof *p->tf;
801043f5:	83 6d f0 4c          	subl   $0x4c,-0x10(%ebp)
  p->tf = (struct trapframe *)sp;
801043f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801043fc:	8b 55 f0             	mov    -0x10(%ebp),%edx
801043ff:	89 50 18             	mov    %edx,0x18(%eax)

  // Set up new context to start executing at forkret,
  // which returns to trapret.
  sp -= 4;
80104402:	83 6d f0 04          	subl   $0x4,-0x10(%ebp)
  *(uint *)sp = (uint)trapret;
80104406:	ba d5 77 10 80       	mov    $0x801077d5,%edx
8010440b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010440e:	89 10                	mov    %edx,(%eax)

  sp -= sizeof *p->context;
80104410:	83 6d f0 14          	subl   $0x14,-0x10(%ebp)
  p->context = (struct context *)sp;
80104414:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104417:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010441a:	89 50 1c             	mov    %edx,0x1c(%eax)
  memset(p->context, 0, sizeof *p->context);
8010441d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104420:	8b 40 1c             	mov    0x1c(%eax),%eax
80104423:	83 ec 04             	sub    $0x4,%esp
80104426:	6a 14                	push   $0x14
80104428:	6a 00                	push   $0x0
8010442a:	50                   	push   %eax
8010442b:	e8 83 1e 00 00       	call   801062b3 <memset>
80104430:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80104433:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104436:	8b 40 1c             	mov    0x1c(%eax),%eax
80104439:	ba 06 52 10 80       	mov    $0x80105206,%edx
8010443e:	89 50 10             	mov    %edx,0x10(%eax)

  p->arrivetime = ticks;
80104441:	8b 15 54 73 11 80    	mov    0x80117354,%edx
80104447:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010444a:	89 90 90 00 00 00    	mov    %edx,0x90(%eax)

  return p;
80104450:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80104453:	c9                   	leave  
80104454:	c3                   	ret    

80104455 <userinit>:

// PAGEBREAK: 32
//  Set up first user process.
void userinit(void)
{
80104455:	55                   	push   %ebp
80104456:	89 e5                	mov    %esp,%ebp
80104458:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  extern char _binary_initcode_start[], _binary_initcode_size[];

  p = allocproc();
8010445b:	e8 df fe ff ff       	call   8010433f <allocproc>
80104460:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if (p == 0)
80104463:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104467:	75 0d                	jne    80104476 <userinit+0x21>
  {
    panic("userinit allocproc failed\n");
80104469:	83 ec 0c             	sub    $0xc,%esp
8010446c:	68 4a 99 10 80       	push   $0x8010994a
80104471:	e8 3f c1 ff ff       	call   801005b5 <panic>
  }

  initproc = p;
80104476:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104479:	a3 18 6b 11 80       	mov    %eax,0x80116b18
  if ((p->pgdir = setupkvm()) == 0)
8010447e:	e8 1f 49 00 00       	call   80108da2 <setupkvm>
80104483:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104486:	89 42 04             	mov    %eax,0x4(%edx)
80104489:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010448c:	8b 40 04             	mov    0x4(%eax),%eax
8010448f:	85 c0                	test   %eax,%eax
80104491:	75 0d                	jne    801044a0 <userinit+0x4b>
    panic("userinit: out of memory?");
80104493:	83 ec 0c             	sub    $0xc,%esp
80104496:	68 65 99 10 80       	push   $0x80109965
8010449b:	e8 15 c1 ff ff       	call   801005b5 <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801044a0:	ba 2c 00 00 00       	mov    $0x2c,%edx
801044a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044a8:	8b 40 04             	mov    0x4(%eax),%eax
801044ab:	83 ec 04             	sub    $0x4,%esp
801044ae:	52                   	push   %edx
801044af:	68 e0 c4 10 80       	push   $0x8010c4e0
801044b4:	50                   	push   %eax
801044b5:	e8 51 4b 00 00       	call   8010900b <inituvm>
801044ba:	83 c4 10             	add    $0x10,%esp
  p->sz = PGSIZE;
801044bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044c0:	c7 00 00 10 00 00    	movl   $0x1000,(%eax)
  memset(p->tf, 0, sizeof(*p->tf));
801044c6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044c9:	8b 40 18             	mov    0x18(%eax),%eax
801044cc:	83 ec 04             	sub    $0x4,%esp
801044cf:	6a 4c                	push   $0x4c
801044d1:	6a 00                	push   $0x0
801044d3:	50                   	push   %eax
801044d4:	e8 da 1d 00 00       	call   801062b3 <memset>
801044d9:	83 c4 10             	add    $0x10,%esp
  p->tf->cs = (SEG_UCODE << 3) | DPL_USER;
801044dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044df:	8b 40 18             	mov    0x18(%eax),%eax
801044e2:	66 c7 40 3c 1b 00    	movw   $0x1b,0x3c(%eax)
  p->tf->ds = (SEG_UDATA << 3) | DPL_USER;
801044e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044eb:	8b 40 18             	mov    0x18(%eax),%eax
801044ee:	66 c7 40 2c 23 00    	movw   $0x23,0x2c(%eax)
  p->tf->es = p->tf->ds;
801044f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044f7:	8b 50 18             	mov    0x18(%eax),%edx
801044fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044fd:	8b 40 18             	mov    0x18(%eax),%eax
80104500:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80104504:	66 89 50 28          	mov    %dx,0x28(%eax)
  p->tf->ss = p->tf->ds;
80104508:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010450b:	8b 50 18             	mov    0x18(%eax),%edx
8010450e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104511:	8b 40 18             	mov    0x18(%eax),%eax
80104514:	0f b7 52 2c          	movzwl 0x2c(%edx),%edx
80104518:	66 89 50 48          	mov    %dx,0x48(%eax)
  p->tf->eflags = FL_IF;
8010451c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010451f:	8b 40 18             	mov    0x18(%eax),%eax
80104522:	c7 40 40 00 02 00 00 	movl   $0x200,0x40(%eax)
  p->tf->esp = PGSIZE;
80104529:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010452c:	8b 40 18             	mov    0x18(%eax),%eax
8010452f:	c7 40 44 00 10 00 00 	movl   $0x1000,0x44(%eax)
  p->tf->eip = 0; // beginning of initcode.S
80104536:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104539:	8b 40 18             	mov    0x18(%eax),%eax
8010453c:	c7 40 38 00 00 00 00 	movl   $0x0,0x38(%eax)

  safestrcpy(p->name, "initcode", sizeof(p->name));
80104543:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104546:	83 c0 6c             	add    $0x6c,%eax
80104549:	83 ec 04             	sub    $0x4,%esp
8010454c:	6a 10                	push   $0x10
8010454e:	68 7e 99 10 80       	push   $0x8010997e
80104553:	50                   	push   %eax
80104554:	e8 5d 1f 00 00       	call   801064b6 <safestrcpy>
80104559:	83 c4 10             	add    $0x10,%esp
  p->cwd = namei("/");
8010455c:	83 ec 0c             	sub    $0xc,%esp
8010455f:	68 87 99 10 80       	push   $0x80109987
80104564:	e8 e4 df ff ff       	call   8010254d <namei>
80104569:	83 c4 10             	add    $0x10,%esp
8010456c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010456f:	89 42 68             	mov    %eax,0x68(%edx)

  // this assignment to p->state lets other cores
  // run this process. the acquire forces the above
  // writes to be visible, and the lock is also needed
  // because the assignment might not be atomic.
  acquire(&ptable.lock);
80104572:	83 ec 0c             	sub    $0xc,%esp
80104575:	68 80 3d 11 80       	push   $0x80113d80
8010457a:	e8 ae 1a 00 00       	call   8010602d <acquire>
8010457f:	83 c4 10             	add    $0x10,%esp

  // Default scheduling queue
  p->q_type = LCFS;
80104582:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104585:	c7 40 7c 02 00 00 00 	movl   $0x2,0x7c(%eax)
  lcfs_q.pi++;
8010458c:	a1 e0 69 11 80       	mov    0x801169e0,%eax
80104591:	83 c0 01             	add    $0x1,%eax
80104594:	a3 e0 69 11 80       	mov    %eax,0x801169e0
  lcfs_q.proc[lcfs_q.pi] = p;
80104599:	a1 e0 69 11 80       	mov    0x801169e0,%eax
8010459e:	8b 55 f4             	mov    -0xc(%ebp),%edx
801045a1:	89 14 85 e0 68 11 80 	mov    %edx,-0x7fee9720(,%eax,4)

  p->state = RUNNABLE;
801045a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045ab:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)

  release(&ptable.lock);
801045b2:	83 ec 0c             	sub    $0xc,%esp
801045b5:	68 80 3d 11 80       	push   $0x80113d80
801045ba:	e8 dc 1a 00 00       	call   8010609b <release>
801045bf:	83 c4 10             	add    $0x10,%esp
}
801045c2:	90                   	nop
801045c3:	c9                   	leave  
801045c4:	c3                   	ret    

801045c5 <growproc>:

// Grow current process's memory by n bytes.
// Return 0 on success, -1 on failure.
int growproc(int n)
{
801045c5:	55                   	push   %ebp
801045c6:	89 e5                	mov    %esp,%ebp
801045c8:	83 ec 18             	sub    $0x18,%esp
  uint sz;
  struct proc *curproc = myproc();
801045cb:	e8 46 fd ff ff       	call   80104316 <myproc>
801045d0:	89 45 f0             	mov    %eax,-0x10(%ebp)

  sz = curproc->sz;
801045d3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801045d6:	8b 00                	mov    (%eax),%eax
801045d8:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if (n > 0)
801045db:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801045df:	7e 2e                	jle    8010460f <growproc+0x4a>
  {
    if ((sz = allocuvm(curproc->pgdir, sz, sz + n)) == 0)
801045e1:	8b 55 08             	mov    0x8(%ebp),%edx
801045e4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045e7:	01 c2                	add    %eax,%edx
801045e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801045ec:	8b 40 04             	mov    0x4(%eax),%eax
801045ef:	83 ec 04             	sub    $0x4,%esp
801045f2:	52                   	push   %edx
801045f3:	ff 75 f4             	push   -0xc(%ebp)
801045f6:	50                   	push   %eax
801045f7:	e8 4c 4b 00 00       	call   80109148 <allocuvm>
801045fc:	83 c4 10             	add    $0x10,%esp
801045ff:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104602:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80104606:	75 3b                	jne    80104643 <growproc+0x7e>
      return -1;
80104608:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010460d:	eb 4f                	jmp    8010465e <growproc+0x99>
  }
  else if (n < 0)
8010460f:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80104613:	79 2e                	jns    80104643 <growproc+0x7e>
  {
    if ((sz = deallocuvm(curproc->pgdir, sz, sz + n)) == 0)
80104615:	8b 55 08             	mov    0x8(%ebp),%edx
80104618:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010461b:	01 c2                	add    %eax,%edx
8010461d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104620:	8b 40 04             	mov    0x4(%eax),%eax
80104623:	83 ec 04             	sub    $0x4,%esp
80104626:	52                   	push   %edx
80104627:	ff 75 f4             	push   -0xc(%ebp)
8010462a:	50                   	push   %eax
8010462b:	e8 1d 4c 00 00       	call   8010924d <deallocuvm>
80104630:	83 c4 10             	add    $0x10,%esp
80104633:	89 45 f4             	mov    %eax,-0xc(%ebp)
80104636:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010463a:	75 07                	jne    80104643 <growproc+0x7e>
      return -1;
8010463c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104641:	eb 1b                	jmp    8010465e <growproc+0x99>
  }
  curproc->sz = sz;
80104643:	8b 45 f0             	mov    -0x10(%ebp),%eax
80104646:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104649:	89 10                	mov    %edx,(%eax)
  switchuvm(curproc);
8010464b:	83 ec 0c             	sub    $0xc,%esp
8010464e:	ff 75 f0             	push   -0x10(%ebp)
80104651:	e8 16 48 00 00       	call   80108e6c <switchuvm>
80104656:	83 c4 10             	add    $0x10,%esp
  return 0;
80104659:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010465e:	c9                   	leave  
8010465f:	c3                   	ret    

80104660 <fork>:

// Create a new process copying p as the parent.
// Sets up stack to return as if from system call.
// Caller must set state of returned proc to RUNNABLE.
int fork(void)
{
80104660:	55                   	push   %ebp
80104661:	89 e5                	mov    %esp,%ebp
80104663:	57                   	push   %edi
80104664:	56                   	push   %esi
80104665:	53                   	push   %ebx
80104666:	83 ec 1c             	sub    $0x1c,%esp
  int i, pid;
  struct proc *np;
  struct proc *curproc = myproc();
80104669:	e8 a8 fc ff ff       	call   80104316 <myproc>
8010466e:	89 45 e0             	mov    %eax,-0x20(%ebp)

  // Allocate process.
  if ((np = allocproc()) == 0)
80104671:	e8 c9 fc ff ff       	call   8010433f <allocproc>
80104676:	89 45 dc             	mov    %eax,-0x24(%ebp)
80104679:	83 7d dc 00          	cmpl   $0x0,-0x24(%ebp)
8010467d:	75 0a                	jne    80104689 <fork+0x29>
  {
    return -1;
8010467f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104684:	e9 25 02 00 00       	jmp    801048ae <fork+0x24e>
  }

  // Copy process state from proc.
  if ((np->pgdir = copyuvm(curproc->pgdir, curproc->sz)) == 0)
80104689:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010468c:	8b 10                	mov    (%eax),%edx
8010468e:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104691:	8b 40 04             	mov    0x4(%eax),%eax
80104694:	83 ec 08             	sub    $0x8,%esp
80104697:	52                   	push   %edx
80104698:	50                   	push   %eax
80104699:	e8 4d 4d 00 00       	call   801093eb <copyuvm>
8010469e:	83 c4 10             	add    $0x10,%esp
801046a1:	8b 55 dc             	mov    -0x24(%ebp),%edx
801046a4:	89 42 04             	mov    %eax,0x4(%edx)
801046a7:	8b 45 dc             	mov    -0x24(%ebp),%eax
801046aa:	8b 40 04             	mov    0x4(%eax),%eax
801046ad:	85 c0                	test   %eax,%eax
801046af:	75 30                	jne    801046e1 <fork+0x81>
  {
    kfree(np->kstack);
801046b1:	8b 45 dc             	mov    -0x24(%ebp),%eax
801046b4:	8b 40 08             	mov    0x8(%eax),%eax
801046b7:	83 ec 0c             	sub    $0xc,%esp
801046ba:	50                   	push   %eax
801046bb:	e8 3c e5 ff ff       	call   80102bfc <kfree>
801046c0:	83 c4 10             	add    $0x10,%esp
    np->kstack = 0;
801046c3:	8b 45 dc             	mov    -0x24(%ebp),%eax
801046c6:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
    np->state = UNUSED;
801046cd:	8b 45 dc             	mov    -0x24(%ebp),%eax
801046d0:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
    return -1;
801046d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801046dc:	e9 cd 01 00 00       	jmp    801048ae <fork+0x24e>
  }
  np->sz = curproc->sz;
801046e1:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046e4:	8b 10                	mov    (%eax),%edx
801046e6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801046e9:	89 10                	mov    %edx,(%eax)
  np->parent = curproc;
801046eb:	8b 45 dc             	mov    -0x24(%ebp),%eax
801046ee:	8b 55 e0             	mov    -0x20(%ebp),%edx
801046f1:	89 50 14             	mov    %edx,0x14(%eax)
  *np->tf = *curproc->tf;
801046f4:	8b 45 e0             	mov    -0x20(%ebp),%eax
801046f7:	8b 48 18             	mov    0x18(%eax),%ecx
801046fa:	8b 45 dc             	mov    -0x24(%ebp),%eax
801046fd:	8b 40 18             	mov    0x18(%eax),%eax
80104700:	89 c2                	mov    %eax,%edx
80104702:	89 cb                	mov    %ecx,%ebx
80104704:	b8 13 00 00 00       	mov    $0x13,%eax
80104709:	89 d7                	mov    %edx,%edi
8010470b:	89 de                	mov    %ebx,%esi
8010470d:	89 c1                	mov    %eax,%ecx
8010470f:	f3 a5                	rep movsl %ds:(%esi),%es:(%edi)

  // Clear %eax so that fork returns 0 in the child.
  np->tf->eax = 0;
80104711:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104714:	8b 40 18             	mov    0x18(%eax),%eax
80104717:	c7 40 1c 00 00 00 00 	movl   $0x0,0x1c(%eax)

  for (i = 0; i < NOFILE; i++)
8010471e:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
80104725:	eb 3b                	jmp    80104762 <fork+0x102>
    if (curproc->ofile[i])
80104727:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010472a:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010472d:	83 c2 08             	add    $0x8,%edx
80104730:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104734:	85 c0                	test   %eax,%eax
80104736:	74 26                	je     8010475e <fork+0xfe>
      np->ofile[i] = filedup(curproc->ofile[i]);
80104738:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010473b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010473e:	83 c2 08             	add    $0x8,%edx
80104741:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104745:	83 ec 0c             	sub    $0xc,%esp
80104748:	50                   	push   %eax
80104749:	e8 3f c9 ff ff       	call   8010108d <filedup>
8010474e:	83 c4 10             	add    $0x10,%esp
80104751:	8b 55 dc             	mov    -0x24(%ebp),%edx
80104754:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
80104757:	83 c1 08             	add    $0x8,%ecx
8010475a:	89 44 8a 08          	mov    %eax,0x8(%edx,%ecx,4)
  for (i = 0; i < NOFILE; i++)
8010475e:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80104762:	83 7d e4 0f          	cmpl   $0xf,-0x1c(%ebp)
80104766:	7e bf                	jle    80104727 <fork+0xc7>
  np->cwd = idup(curproc->cwd);
80104768:	8b 45 e0             	mov    -0x20(%ebp),%eax
8010476b:	8b 40 68             	mov    0x68(%eax),%eax
8010476e:	83 ec 0c             	sub    $0xc,%esp
80104771:	50                   	push   %eax
80104772:	e8 69 d2 ff ff       	call   801019e0 <idup>
80104777:	83 c4 10             	add    $0x10,%esp
8010477a:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010477d:	89 42 68             	mov    %eax,0x68(%edx)

  safestrcpy(np->name, curproc->name, sizeof(curproc->name));
80104780:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104783:	8d 50 6c             	lea    0x6c(%eax),%edx
80104786:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104789:	83 c0 6c             	add    $0x6c,%eax
8010478c:	83 ec 04             	sub    $0x4,%esp
8010478f:	6a 10                	push   $0x10
80104791:	52                   	push   %edx
80104792:	50                   	push   %eax
80104793:	e8 1e 1d 00 00       	call   801064b6 <safestrcpy>
80104798:	83 c4 10             	add    $0x10,%esp

  pid = np->pid;
8010479b:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010479e:	8b 40 10             	mov    0x10(%eax),%eax
801047a1:	89 45 d8             	mov    %eax,-0x28(%ebp)

  acquire(&ptable.lock);
801047a4:	83 ec 0c             	sub    $0xc,%esp
801047a7:	68 80 3d 11 80       	push   $0x80113d80
801047ac:	e8 7c 18 00 00       	call   8010602d <acquire>
801047b1:	83 c4 10             	add    $0x10,%esp

  // Default scheduling queue
  np->q_type = LCFS;
801047b4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801047b7:	c7 40 7c 02 00 00 00 	movl   $0x2,0x7c(%eax)

  lcfs_q.pi++;
801047be:	a1 e0 69 11 80       	mov    0x801169e0,%eax
801047c3:	83 c0 01             	add    $0x1,%eax
801047c6:	a3 e0 69 11 80       	mov    %eax,0x801169e0
  lcfs_q.proc[lcfs_q.pi] = np;
801047cb:	a1 e0 69 11 80       	mov    0x801169e0,%eax
801047d0:	8b 55 dc             	mov    -0x24(%ebp),%edx
801047d3:	89 14 85 e0 68 11 80 	mov    %edx,-0x7fee9720(,%eax,4)
  np->arrivetime = ticks;
801047da:	8b 15 54 73 11 80    	mov    0x80117354,%edx
801047e0:	8b 45 dc             	mov    -0x24(%ebp),%eax
801047e3:	89 90 90 00 00 00    	mov    %edx,0x90(%eax)
  np->waiting_time = 0;
801047e9:	8b 45 dc             	mov    -0x24(%ebp),%eax
801047ec:	c7 80 a0 00 00 00 00 	movl   $0x0,0xa0(%eax)
801047f3:	00 00 00 
  np->executed_cycle = 0;
801047f6:	8b 45 dc             	mov    -0x24(%ebp),%eax
801047f9:	d9 ee                	fldz   
801047fb:	d9 98 88 00 00 00    	fstps  0x88(%eax)

  acquire(&tickslock);
80104801:	83 ec 0c             	sub    $0xc,%esp
80104804:	68 20 73 11 80       	push   $0x80117320
80104809:	e8 1f 18 00 00       	call   8010602d <acquire>
8010480e:	83 c4 10             	add    $0x10,%esp
  np->priority = (ticks * ticks * 1021) % 100;
80104811:	8b 15 54 73 11 80    	mov    0x80117354,%edx
80104817:	a1 54 73 11 80       	mov    0x80117354,%eax
8010481c:	0f af c2             	imul   %edx,%eax
8010481f:	69 c8 fd 03 00 00    	imul   $0x3fd,%eax,%ecx
80104825:	ba 1f 85 eb 51       	mov    $0x51eb851f,%edx
8010482a:	89 c8                	mov    %ecx,%eax
8010482c:	f7 e2                	mul    %edx
8010482e:	89 d0                	mov    %edx,%eax
80104830:	c1 e8 05             	shr    $0x5,%eax
80104833:	6b d0 64             	imul   $0x64,%eax,%edx
80104836:	89 c8                	mov    %ecx,%eax
80104838:	29 d0                	sub    %edx,%eax
8010483a:	89 c2                	mov    %eax,%edx
8010483c:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010483f:	89 90 80 00 00 00    	mov    %edx,0x80(%eax)
  release(&tickslock);
80104845:	83 ec 0c             	sub    $0xc,%esp
80104848:	68 20 73 11 80       	push   $0x80117320
8010484d:	e8 49 18 00 00       	call   8010609b <release>
80104852:	83 c4 10             	add    $0x10,%esp

  np->priority_ratio = 0.25;
80104855:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104858:	d9 05 28 9c 10 80    	flds   0x80109c28
8010485e:	d9 98 84 00 00 00    	fstps  0x84(%eax)
  np->executed_cycle_ratio = 0.25;
80104864:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104867:	d9 05 28 9c 10 80    	flds   0x80109c28
8010486d:	d9 98 8c 00 00 00    	fstps  0x8c(%eax)
  np->arrivetime_ratio = 0.25;
80104873:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104876:	d9 05 28 9c 10 80    	flds   0x80109c28
8010487c:	d9 98 94 00 00 00    	fstps  0x94(%eax)
  np->size_ratio = 0.25;
80104882:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104885:	d9 05 28 9c 10 80    	flds   0x80109c28
8010488b:	d9 98 98 00 00 00    	fstps  0x98(%eax)

  np->state = RUNNABLE;
80104891:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104894:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)

  release(&ptable.lock);
8010489b:	83 ec 0c             	sub    $0xc,%esp
8010489e:	68 80 3d 11 80       	push   $0x80113d80
801048a3:	e8 f3 17 00 00       	call   8010609b <release>
801048a8:	83 c4 10             	add    $0x10,%esp

  return pid;
801048ab:	8b 45 d8             	mov    -0x28(%ebp),%eax
}
801048ae:	8d 65 f4             	lea    -0xc(%ebp),%esp
801048b1:	5b                   	pop    %ebx
801048b2:	5e                   	pop    %esi
801048b3:	5f                   	pop    %edi
801048b4:	5d                   	pop    %ebp
801048b5:	c3                   	ret    

801048b6 <shiftOutQueue>:
// An exited process remains in the zombie state
// until its parent calls wait() to find out it exited.

// Lock of the q must have been acquired before usage.
void shiftOutQueue(struct queue *q, struct proc *p)
{
801048b6:	55                   	push   %ebp
801048b7:	89 e5                	mov    %esp,%ebp
801048b9:	83 ec 18             	sub    $0x18,%esp
  struct proc *temp;
  if (!holding(&ptable.lock))
801048bc:	83 ec 0c             	sub    $0xc,%esp
801048bf:	68 80 3d 11 80       	push   $0x80113d80
801048c4:	e8 9f 18 00 00       	call   80106168 <holding>
801048c9:	83 c4 10             	add    $0x10,%esp
801048cc:	85 c0                	test   %eax,%eax
801048ce:	75 0d                	jne    801048dd <shiftOutQueue+0x27>
  {
    panic("scheduling queue lock not held");
801048d0:	83 ec 0c             	sub    $0xc,%esp
801048d3:	68 8c 99 10 80       	push   $0x8010998c
801048d8:	e8 d8 bc ff ff       	call   801005b5 <panic>
  }
  int qi;
  for (qi = 0; qi <= q->pi; qi++)
801048dd:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801048e4:	eb 1a                	jmp    80104900 <shiftOutQueue+0x4a>
  {
    if (q->proc[qi]->pid == p->pid)
801048e6:	8b 45 08             	mov    0x8(%ebp),%eax
801048e9:	8b 55 f4             	mov    -0xc(%ebp),%edx
801048ec:	8b 04 90             	mov    (%eax,%edx,4),%eax
801048ef:	8b 50 10             	mov    0x10(%eax),%edx
801048f2:	8b 45 0c             	mov    0xc(%ebp),%eax
801048f5:	8b 40 10             	mov    0x10(%eax),%eax
801048f8:	39 c2                	cmp    %eax,%edx
801048fa:	74 14                	je     80104910 <shiftOutQueue+0x5a>
  for (qi = 0; qi <= q->pi; qi++)
801048fc:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80104900:	8b 45 08             	mov    0x8(%ebp),%eax
80104903:	8b 80 00 01 00 00    	mov    0x100(%eax),%eax
80104909:	39 45 f4             	cmp    %eax,-0xc(%ebp)
8010490c:	7e d8                	jle    801048e6 <shiftOutQueue+0x30>
8010490e:	eb 37                	jmp    80104947 <shiftOutQueue+0x91>
    {
      break;
80104910:	90                   	nop
    }
  }

  while (qi <= q->pi)
80104911:	eb 34                	jmp    80104947 <shiftOutQueue+0x91>
  {
    temp = q->proc[qi];
80104913:	8b 45 08             	mov    0x8(%ebp),%eax
80104916:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104919:	8b 04 90             	mov    (%eax,%edx,4),%eax
8010491c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    q->proc[qi] = q->proc[qi + 1];
8010491f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104922:	8d 50 01             	lea    0x1(%eax),%edx
80104925:	8b 45 08             	mov    0x8(%ebp),%eax
80104928:	8b 0c 90             	mov    (%eax,%edx,4),%ecx
8010492b:	8b 45 08             	mov    0x8(%ebp),%eax
8010492e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104931:	89 0c 90             	mov    %ecx,(%eax,%edx,4)
    q->proc[qi + 1] = temp;
80104934:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104937:	8d 48 01             	lea    0x1(%eax),%ecx
8010493a:	8b 45 08             	mov    0x8(%ebp),%eax
8010493d:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104940:	89 14 88             	mov    %edx,(%eax,%ecx,4)
    qi++;
80104943:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
  while (qi <= q->pi)
80104947:	8b 45 08             	mov    0x8(%ebp),%eax
8010494a:	8b 80 00 01 00 00    	mov    0x100(%eax),%eax
80104950:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80104953:	7e be                	jle    80104913 <shiftOutQueue+0x5d>
  }
  q->proc[qi] = (void *)(0); // NULL
80104955:	8b 45 08             	mov    0x8(%ebp),%eax
80104958:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010495b:	c7 04 90 00 00 00 00 	movl   $0x0,(%eax,%edx,4)
}
80104962:	90                   	nop
80104963:	c9                   	leave  
80104964:	c3                   	ret    

80104965 <cleanupCorresQueue>:

void cleanupCorresQueue(struct proc *p)
{
80104965:	55                   	push   %ebp
80104966:	89 e5                	mov    %esp,%ebp
80104968:	83 ec 08             	sub    $0x8,%esp
  switch (p->q_type)
8010496b:	8b 45 08             	mov    0x8(%ebp),%eax
8010496e:	8b 40 7c             	mov    0x7c(%eax),%eax
80104971:	83 f8 03             	cmp    $0x3,%eax
80104974:	0f 84 88 00 00 00    	je     80104a02 <cleanupCorresQueue+0x9d>
8010497a:	83 f8 03             	cmp    $0x3,%eax
8010497d:	0f 87 b7 00 00 00    	ja     80104a3a <cleanupCorresQueue+0xd5>
80104983:	83 f8 01             	cmp    $0x1,%eax
80104986:	74 0a                	je     80104992 <cleanupCorresQueue+0x2d>
80104988:	83 f8 02             	cmp    $0x2,%eax
8010498b:	74 3d                	je     801049ca <cleanupCorresQueue+0x65>
8010498d:	e9 a8 00 00 00       	jmp    80104a3a <cleanupCorresQueue+0xd5>
  {
  case RR:
    if (rr_q.pi <= -1)
80104992:	a1 c0 68 11 80       	mov    0x801168c0,%eax
80104997:	85 c0                	test   %eax,%eax
80104999:	79 0d                	jns    801049a8 <cleanupCorresQueue+0x43>
    {
      panic("RR: nothing to clean");
8010499b:	83 ec 0c             	sub    $0xc,%esp
8010499e:	68 ab 99 10 80       	push   $0x801099ab
801049a3:	e8 0d bc ff ff       	call   801005b5 <panic>
    }
    shiftOutQueue(&rr_q, p);
801049a8:	83 ec 08             	sub    $0x8,%esp
801049ab:	ff 75 08             	push   0x8(%ebp)
801049ae:	68 c0 67 11 80       	push   $0x801167c0
801049b3:	e8 fe fe ff ff       	call   801048b6 <shiftOutQueue>
801049b8:	83 c4 10             	add    $0x10,%esp
    rr_q.pi--;
801049bb:	a1 c0 68 11 80       	mov    0x801168c0,%eax
801049c0:	83 e8 01             	sub    $0x1,%eax
801049c3:	a3 c0 68 11 80       	mov    %eax,0x801168c0
    break;
801049c8:	eb 7d                	jmp    80104a47 <cleanupCorresQueue+0xe2>
  case LCFS:
    if (lcfs_q.pi <= -1)
801049ca:	a1 e0 69 11 80       	mov    0x801169e0,%eax
801049cf:	85 c0                	test   %eax,%eax
801049d1:	79 0d                	jns    801049e0 <cleanupCorresQueue+0x7b>
    {
      panic("LCFS: nothing to clean");
801049d3:	83 ec 0c             	sub    $0xc,%esp
801049d6:	68 c0 99 10 80       	push   $0x801099c0
801049db:	e8 d5 bb ff ff       	call   801005b5 <panic>
    }
    shiftOutQueue(&lcfs_q, p);
801049e0:	83 ec 08             	sub    $0x8,%esp
801049e3:	ff 75 08             	push   0x8(%ebp)
801049e6:	68 e0 68 11 80       	push   $0x801168e0
801049eb:	e8 c6 fe ff ff       	call   801048b6 <shiftOutQueue>
801049f0:	83 c4 10             	add    $0x10,%esp
    lcfs_q.pi--;
801049f3:	a1 e0 69 11 80       	mov    0x801169e0,%eax
801049f8:	83 e8 01             	sub    $0x1,%eax
801049fb:	a3 e0 69 11 80       	mov    %eax,0x801169e0
    break;
80104a00:	eb 45                	jmp    80104a47 <cleanupCorresQueue+0xe2>
  case BJF:
    if (bjf_q.pi <= -1)
80104a02:	a1 00 6b 11 80       	mov    0x80116b00,%eax
80104a07:	85 c0                	test   %eax,%eax
80104a09:	79 0d                	jns    80104a18 <cleanupCorresQueue+0xb3>
    {
      panic("BJF: nothing to clean");
80104a0b:	83 ec 0c             	sub    $0xc,%esp
80104a0e:	68 d7 99 10 80       	push   $0x801099d7
80104a13:	e8 9d bb ff ff       	call   801005b5 <panic>
    }
    shiftOutQueue(&bjf_q, p);
80104a18:	83 ec 08             	sub    $0x8,%esp
80104a1b:	ff 75 08             	push   0x8(%ebp)
80104a1e:	68 00 6a 11 80       	push   $0x80116a00
80104a23:	e8 8e fe ff ff       	call   801048b6 <shiftOutQueue>
80104a28:	83 c4 10             	add    $0x10,%esp
    bjf_q.pi--;
80104a2b:	a1 00 6b 11 80       	mov    0x80116b00,%eax
80104a30:	83 e8 01             	sub    $0x1,%eax
80104a33:	a3 00 6b 11 80       	mov    %eax,0x80116b00
    break;
80104a38:	eb 0d                	jmp    80104a47 <cleanupCorresQueue+0xe2>
  default:
    panic("defaut scheduling cleanup");
80104a3a:	83 ec 0c             	sub    $0xc,%esp
80104a3d:	68 ed 99 10 80       	push   $0x801099ed
80104a42:	e8 6e bb ff ff       	call   801005b5 <panic>
  }
}
80104a47:	90                   	nop
80104a48:	c9                   	leave  
80104a49:	c3                   	ret    

80104a4a <exit>:

void exit(void)
{
80104a4a:	55                   	push   %ebp
80104a4b:	89 e5                	mov    %esp,%ebp
80104a4d:	83 ec 18             	sub    $0x18,%esp
  struct proc *curproc = myproc();
80104a50:	e8 c1 f8 ff ff       	call   80104316 <myproc>
80104a55:	89 45 ec             	mov    %eax,-0x14(%ebp)
  struct proc *p;
  int fd;

  if (curproc == initproc)
80104a58:	a1 18 6b 11 80       	mov    0x80116b18,%eax
80104a5d:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80104a60:	75 0d                	jne    80104a6f <exit+0x25>
    panic("init exiting");
80104a62:	83 ec 0c             	sub    $0xc,%esp
80104a65:	68 07 9a 10 80       	push   $0x80109a07
80104a6a:	e8 46 bb ff ff       	call   801005b5 <panic>

  // Close all open files.
  for (fd = 0; fd < NOFILE; fd++)
80104a6f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
80104a76:	eb 3f                	jmp    80104ab7 <exit+0x6d>
  {
    if (curproc->ofile[fd])
80104a78:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104a7b:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104a7e:	83 c2 08             	add    $0x8,%edx
80104a81:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104a85:	85 c0                	test   %eax,%eax
80104a87:	74 2a                	je     80104ab3 <exit+0x69>
    {
      fileclose(curproc->ofile[fd]);
80104a89:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104a8c:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104a8f:	83 c2 08             	add    $0x8,%edx
80104a92:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80104a96:	83 ec 0c             	sub    $0xc,%esp
80104a99:	50                   	push   %eax
80104a9a:	e8 3f c6 ff ff       	call   801010de <fileclose>
80104a9f:	83 c4 10             	add    $0x10,%esp
      curproc->ofile[fd] = 0;
80104aa2:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104aa5:	8b 55 f0             	mov    -0x10(%ebp),%edx
80104aa8:	83 c2 08             	add    $0x8,%edx
80104aab:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
80104ab2:	00 
  for (fd = 0; fd < NOFILE; fd++)
80104ab3:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
80104ab7:	83 7d f0 0f          	cmpl   $0xf,-0x10(%ebp)
80104abb:	7e bb                	jle    80104a78 <exit+0x2e>
    }
  }

  begin_op();
80104abd:	e8 70 ea ff ff       	call   80103532 <begin_op>
  iput(curproc->cwd);
80104ac2:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104ac5:	8b 40 68             	mov    0x68(%eax),%eax
80104ac8:	83 ec 0c             	sub    $0xc,%esp
80104acb:	50                   	push   %eax
80104acc:	e8 aa d0 ff ff       	call   80101b7b <iput>
80104ad1:	83 c4 10             	add    $0x10,%esp
  end_op();
80104ad4:	e8 e5 ea ff ff       	call   801035be <end_op>
  curproc->cwd = 0;
80104ad9:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104adc:	c7 40 68 00 00 00 00 	movl   $0x0,0x68(%eax)

  acquire(&ptable.lock);
80104ae3:	83 ec 0c             	sub    $0xc,%esp
80104ae6:	68 80 3d 11 80       	push   $0x80113d80
80104aeb:	e8 3d 15 00 00       	call   8010602d <acquire>
80104af0:	83 c4 10             	add    $0x10,%esp
  // remove from corresponding scheduling queue
  cleanupCorresQueue(curproc);
80104af3:	83 ec 0c             	sub    $0xc,%esp
80104af6:	ff 75 ec             	push   -0x14(%ebp)
80104af9:	e8 67 fe ff ff       	call   80104965 <cleanupCorresQueue>
80104afe:	83 c4 10             	add    $0x10,%esp

  // Parent might be sleeping in wait().
  wakeup1(curproc->parent);
80104b01:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104b04:	8b 40 14             	mov    0x14(%eax),%eax
80104b07:	83 ec 0c             	sub    $0xc,%esp
80104b0a:	50                   	push   %eax
80104b0b:	e8 f1 07 00 00       	call   80105301 <wakeup1>
80104b10:	83 c4 10             	add    $0x10,%esp

  // Pass abandoned children to init.
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104b13:	c7 45 f4 b4 3d 11 80 	movl   $0x80113db4,-0xc(%ebp)
80104b1a:	eb 3a                	jmp    80104b56 <exit+0x10c>
  {
    if (p->parent == curproc)
80104b1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b1f:	8b 40 14             	mov    0x14(%eax),%eax
80104b22:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80104b25:	75 28                	jne    80104b4f <exit+0x105>
    {
      p->parent = initproc;
80104b27:	8b 15 18 6b 11 80    	mov    0x80116b18,%edx
80104b2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b30:	89 50 14             	mov    %edx,0x14(%eax)
      if (p->state == ZOMBIE)
80104b33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b36:	8b 40 0c             	mov    0xc(%eax),%eax
80104b39:	83 f8 05             	cmp    $0x5,%eax
80104b3c:	75 11                	jne    80104b4f <exit+0x105>
        wakeup1(initproc);
80104b3e:	a1 18 6b 11 80       	mov    0x80116b18,%eax
80104b43:	83 ec 0c             	sub    $0xc,%esp
80104b46:	50                   	push   %eax
80104b47:	e8 b5 07 00 00       	call   80105301 <wakeup1>
80104b4c:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104b4f:	81 45 f4 a8 00 00 00 	addl   $0xa8,-0xc(%ebp)
80104b56:	81 7d f4 b4 67 11 80 	cmpl   $0x801167b4,-0xc(%ebp)
80104b5d:	72 bd                	jb     80104b1c <exit+0xd2>
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80104b5f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104b62:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)

  sched();
80104b69:	e8 d4 04 00 00       	call   80105042 <sched>
  panic("zombie exit");
80104b6e:	83 ec 0c             	sub    $0xc,%esp
80104b71:	68 14 9a 10 80       	push   $0x80109a14
80104b76:	e8 3a ba ff ff       	call   801005b5 <panic>

80104b7b <wait>:
}

// Wait for a child process to exit and return its pid.
// Return -1 if this process has no children.
int wait(void)
{
80104b7b:	55                   	push   %ebp
80104b7c:	89 e5                	mov    %esp,%ebp
80104b7e:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  int havekids, pid;
  struct proc *curproc = myproc();
80104b81:	e8 90 f7 ff ff       	call   80104316 <myproc>
80104b86:	89 45 ec             	mov    %eax,-0x14(%ebp)

  acquire(&ptable.lock);
80104b89:	83 ec 0c             	sub    $0xc,%esp
80104b8c:	68 80 3d 11 80       	push   $0x80113d80
80104b91:	e8 97 14 00 00       	call   8010602d <acquire>
80104b96:	83 c4 10             	add    $0x10,%esp
  for (;;)
  {
    // Scan through table looking for exited children.
    havekids = 0;
80104b99:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104ba0:	c7 45 f4 b4 3d 11 80 	movl   $0x80113db4,-0xc(%ebp)
80104ba7:	e9 a4 00 00 00       	jmp    80104c50 <wait+0xd5>
    {
      if (p->parent != curproc)
80104bac:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104baf:	8b 40 14             	mov    0x14(%eax),%eax
80104bb2:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80104bb5:	0f 85 8d 00 00 00    	jne    80104c48 <wait+0xcd>
        continue;
      havekids = 1;
80104bbb:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
      if (p->state == ZOMBIE)
80104bc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bc5:	8b 40 0c             	mov    0xc(%eax),%eax
80104bc8:	83 f8 05             	cmp    $0x5,%eax
80104bcb:	75 7c                	jne    80104c49 <wait+0xce>
      {
        // Found one.
        pid = p->pid;
80104bcd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bd0:	8b 40 10             	mov    0x10(%eax),%eax
80104bd3:	89 45 e8             	mov    %eax,-0x18(%ebp)
        kfree(p->kstack);
80104bd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bd9:	8b 40 08             	mov    0x8(%eax),%eax
80104bdc:	83 ec 0c             	sub    $0xc,%esp
80104bdf:	50                   	push   %eax
80104be0:	e8 17 e0 ff ff       	call   80102bfc <kfree>
80104be5:	83 c4 10             	add    $0x10,%esp
        p->kstack = 0;
80104be8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104beb:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
        freevm(p->pgdir);
80104bf2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104bf5:	8b 40 04             	mov    0x4(%eax),%eax
80104bf8:	83 ec 0c             	sub    $0xc,%esp
80104bfb:	50                   	push   %eax
80104bfc:	e8 10 47 00 00       	call   80109311 <freevm>
80104c01:	83 c4 10             	add    $0x10,%esp
        p->pid = 0;
80104c04:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c07:	c7 40 10 00 00 00 00 	movl   $0x0,0x10(%eax)
        p->parent = 0;
80104c0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c11:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
        p->name[0] = 0;
80104c18:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c1b:	c6 40 6c 00          	movb   $0x0,0x6c(%eax)
        p->killed = 0;
80104c1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c22:	c7 40 24 00 00 00 00 	movl   $0x0,0x24(%eax)
        p->state = UNUSED;
80104c29:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104c2c:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
        release(&ptable.lock);
80104c33:	83 ec 0c             	sub    $0xc,%esp
80104c36:	68 80 3d 11 80       	push   $0x80113d80
80104c3b:	e8 5b 14 00 00       	call   8010609b <release>
80104c40:	83 c4 10             	add    $0x10,%esp
        return pid;
80104c43:	8b 45 e8             	mov    -0x18(%ebp),%eax
80104c46:	eb 54                	jmp    80104c9c <wait+0x121>
        continue;
80104c48:	90                   	nop
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c49:	81 45 f4 a8 00 00 00 	addl   $0xa8,-0xc(%ebp)
80104c50:	81 7d f4 b4 67 11 80 	cmpl   $0x801167b4,-0xc(%ebp)
80104c57:	0f 82 4f ff ff ff    	jb     80104bac <wait+0x31>
      }
    }

    // No point waiting if we don't have any children.
    if (!havekids || curproc->killed)
80104c5d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104c61:	74 0a                	je     80104c6d <wait+0xf2>
80104c63:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104c66:	8b 40 24             	mov    0x24(%eax),%eax
80104c69:	85 c0                	test   %eax,%eax
80104c6b:	74 17                	je     80104c84 <wait+0x109>
    {
      release(&ptable.lock);
80104c6d:	83 ec 0c             	sub    $0xc,%esp
80104c70:	68 80 3d 11 80       	push   $0x80113d80
80104c75:	e8 21 14 00 00       	call   8010609b <release>
80104c7a:	83 c4 10             	add    $0x10,%esp
      return -1;
80104c7d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c82:	eb 18                	jmp    80104c9c <wait+0x121>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock); // DOC: wait-sleep
80104c84:	83 ec 08             	sub    $0x8,%esp
80104c87:	68 80 3d 11 80       	push   $0x80113d80
80104c8c:	ff 75 ec             	push   -0x14(%ebp)
80104c8f:	e8 b8 05 00 00       	call   8010524c <sleep>
80104c94:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80104c97:	e9 fd fe ff ff       	jmp    80104b99 <wait+0x1e>
  }
}
80104c9c:	c9                   	leave  
80104c9d:	c3                   	ret    

80104c9e <calculate_rank>:

int calculate_rank(struct proc *p)
{
80104c9e:	55                   	push   %ebp
80104c9f:	89 e5                	mov    %esp,%ebp
80104ca1:	83 ec 10             	sub    $0x10,%esp
  return ((p->priority * p->priority_ratio) +
80104ca4:	8b 45 08             	mov    0x8(%ebp),%eax
80104ca7:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
80104cad:	89 45 f0             	mov    %eax,-0x10(%ebp)
80104cb0:	db 45 f0             	fildl  -0x10(%ebp)
80104cb3:	8b 45 08             	mov    0x8(%ebp),%eax
80104cb6:	d9 80 84 00 00 00    	flds   0x84(%eax)
80104cbc:	de c9                	fmulp  %st,%st(1)
          (p->arrivetime * p->arrivetime_ratio) +
80104cbe:	8b 45 08             	mov    0x8(%ebp),%eax
80104cc1:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80104cc7:	89 45 f0             	mov    %eax,-0x10(%ebp)
80104cca:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104cd1:	df 6d f0             	fildll -0x10(%ebp)
80104cd4:	8b 45 08             	mov    0x8(%ebp),%eax
80104cd7:	d9 80 94 00 00 00    	flds   0x94(%eax)
80104cdd:	de c9                	fmulp  %st,%st(1)
  return ((p->priority * p->priority_ratio) +
80104cdf:	de c1                	faddp  %st,%st(1)
          (p->executed_cycle * p->executed_cycle_ratio));
80104ce1:	8b 45 08             	mov    0x8(%ebp),%eax
80104ce4:	d9 80 88 00 00 00    	flds   0x88(%eax)
80104cea:	8b 45 08             	mov    0x8(%ebp),%eax
80104ced:	d9 80 8c 00 00 00    	flds   0x8c(%eax)
80104cf3:	de c9                	fmulp  %st,%st(1)
          (p->arrivetime * p->arrivetime_ratio) +
80104cf5:	de c1                	faddp  %st,%st(1)
80104cf7:	d9 7d fe             	fnstcw -0x2(%ebp)
80104cfa:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
80104cfe:	80 cc 0c             	or     $0xc,%ah
80104d01:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80104d05:	d9 6d fc             	fldcw  -0x4(%ebp)
80104d08:	db 5d f0             	fistpl -0x10(%ebp)
80104d0b:	d9 6d fe             	fldcw  -0x2(%ebp)
80104d0e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80104d11:	c9                   	leave  
80104d12:	c3                   	ret    

80104d13 <scheduler>:
//   - choose a process to run
//   - swtch to start running that process
//   - eventually that process transfers control
//       via swtch back to the scheduler.
void scheduler(void)
{
80104d13:	55                   	push   %ebp
80104d14:	89 e5                	mov    %esp,%ebp
80104d16:	83 ec 38             	sub    $0x38,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80104d19:	e8 80 f5 ff ff       	call   8010429e <mycpu>
80104d1e:	89 45 dc             	mov    %eax,-0x24(%ebp)
  c->proc = 0;
80104d21:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104d24:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104d2b:	00 00 00 

  for (;;)
  {
    // Enable interrupts on this processor.
    sti();
80104d2e:	e8 ae f4 ff ff       	call   801041e1 <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80104d33:	83 ec 0c             	sub    $0xc,%esp
80104d36:	68 80 3d 11 80       	push   $0x80113d80
80104d3b:	e8 ed 12 00 00       	call   8010602d <acquire>
80104d40:	83 c4 10             	add    $0x10,%esp
    uint found_runnable = 0;
80104d43:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    if (rr_q.pi >= 0)
80104d4a:	a1 c0 68 11 80       	mov    0x801168c0,%eax
80104d4f:	85 c0                	test   %eax,%eax
80104d51:	0f 88 db 00 00 00    	js     80104e32 <scheduler+0x11f>
    {
      p = rr_q.proc[rr_counter % (rr_q.pi + 1)];
80104d57:	a1 04 6b 11 80       	mov    0x80116b04,%eax
80104d5c:	8b 15 c0 68 11 80    	mov    0x801168c0,%edx
80104d62:	83 c2 01             	add    $0x1,%edx
80104d65:	89 d1                	mov    %edx,%ecx
80104d67:	ba 00 00 00 00       	mov    $0x0,%edx
80104d6c:	f7 f1                	div    %ecx
80104d6e:	89 d0                	mov    %edx,%eax
80104d70:	8b 04 85 c0 67 11 80 	mov    -0x7fee9840(,%eax,4),%eax
80104d77:	89 45 f4             	mov    %eax,-0xc(%ebp)
      if (p->state == RUNNABLE)
80104d7a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d7d:	8b 40 0c             	mov    0xc(%eax),%eax
80104d80:	83 f8 03             	cmp    $0x3,%eax
80104d83:	75 0c                	jne    80104d91 <scheduler+0x7e>
      {
        found_runnable = 1;
80104d85:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
80104d8c:	e9 3a 02 00 00       	jmp    80104fcb <scheduler+0x2b8>
      }
      else if (p->state == RUNNING)
80104d91:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d94:	8b 40 0c             	mov    0xc(%eax),%eax
80104d97:	83 f8 04             	cmp    $0x4,%eax
80104d9a:	0f 85 85 00 00 00    	jne    80104e25 <scheduler+0x112>
      {
        // Find a new process to run for the idle core
        // Loop over queue with amount of its length
        for (int i = 0; i < rr_q.pi; i++)
80104da0:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80104da7:	eb 6d                	jmp    80104e16 <scheduler+0x103>
        {
          if (rr_q.proc[(rr_counter + i + 1) % (rr_q.pi + 1)]->state == RUNNABLE)
80104da9:	8b 15 04 6b 11 80    	mov    0x80116b04,%edx
80104daf:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104db2:	01 d0                	add    %edx,%eax
80104db4:	83 c0 01             	add    $0x1,%eax
80104db7:	8b 15 c0 68 11 80    	mov    0x801168c0,%edx
80104dbd:	83 c2 01             	add    $0x1,%edx
80104dc0:	89 d1                	mov    %edx,%ecx
80104dc2:	ba 00 00 00 00       	mov    $0x0,%edx
80104dc7:	f7 f1                	div    %ecx
80104dc9:	89 d0                	mov    %edx,%eax
80104dcb:	8b 04 85 c0 67 11 80 	mov    -0x7fee9840(,%eax,4),%eax
80104dd2:	8b 40 0c             	mov    0xc(%eax),%eax
80104dd5:	83 f8 03             	cmp    $0x3,%eax
80104dd8:	75 38                	jne    80104e12 <scheduler+0xff>
          {
            p = rr_q.proc[(rr_counter + i + 1) % (rr_q.pi + 1)];
80104dda:	8b 15 04 6b 11 80    	mov    0x80116b04,%edx
80104de0:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104de3:	01 d0                	add    %edx,%eax
80104de5:	83 c0 01             	add    $0x1,%eax
80104de8:	8b 15 c0 68 11 80    	mov    0x801168c0,%edx
80104dee:	83 c2 01             	add    $0x1,%edx
80104df1:	89 d1                	mov    %edx,%ecx
80104df3:	ba 00 00 00 00       	mov    $0x0,%edx
80104df8:	f7 f1                	div    %ecx
80104dfa:	89 d0                	mov    %edx,%eax
80104dfc:	8b 04 85 c0 67 11 80 	mov    -0x7fee9840(,%eax,4),%eax
80104e03:	89 45 f4             	mov    %eax,-0xc(%ebp)
            found_runnable = 1;
80104e06:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
            break;
80104e0d:	e9 b9 01 00 00       	jmp    80104fcb <scheduler+0x2b8>
        for (int i = 0; i < rr_q.pi; i++)
80104e12:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80104e16:	a1 c0 68 11 80       	mov    0x801168c0,%eax
80104e1b:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80104e1e:	7c 89                	jl     80104da9 <scheduler+0x96>
80104e20:	e9 a6 01 00 00       	jmp    80104fcb <scheduler+0x2b8>
          }
        }
      }
      else
      {
        panic("No runnable process\n");
80104e25:	83 ec 0c             	sub    $0xc,%esp
80104e28:	68 20 9a 10 80       	push   $0x80109a20
80104e2d:	e8 83 b7 ff ff       	call   801005b5 <panic>
      }
    }
    else if (lcfs_q.pi >= 0)
80104e32:	a1 e0 69 11 80       	mov    0x801169e0,%eax
80104e37:	85 c0                	test   %eax,%eax
80104e39:	0f 88 88 00 00 00    	js     80104ec7 <scheduler+0x1b4>
    {
      p = lcfs_q.proc[lcfs_q.pi];
80104e3f:	a1 e0 69 11 80       	mov    0x801169e0,%eax
80104e44:	8b 04 85 e0 68 11 80 	mov    -0x7fee9720(,%eax,4),%eax
80104e4b:	89 45 f4             	mov    %eax,-0xc(%ebp)
      if (p->state == RUNNABLE)
80104e4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e51:	8b 40 0c             	mov    0xc(%eax),%eax
80104e54:	83 f8 03             	cmp    $0x3,%eax
80104e57:	75 0c                	jne    80104e65 <scheduler+0x152>
      {
        found_runnable = 1;
80104e59:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
80104e60:	e9 66 01 00 00       	jmp    80104fcb <scheduler+0x2b8>
      }
      else if (p->state == RUNNING)
80104e65:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e68:	8b 40 0c             	mov    0xc(%eax),%eax
80104e6b:	83 f8 04             	cmp    $0x4,%eax
80104e6e:	75 4a                	jne    80104eba <scheduler+0x1a7>
      {
        for (int i = lcfs_q.pi; i > 0; i--)
80104e70:	a1 e0 69 11 80       	mov    0x801169e0,%eax
80104e75:	89 45 e8             	mov    %eax,-0x18(%ebp)
80104e78:	eb 35                	jmp    80104eaf <scheduler+0x19c>
        {
          if (lcfs_q.proc[i - 1]->state == RUNNABLE)
80104e7a:	8b 45 e8             	mov    -0x18(%ebp),%eax
80104e7d:	83 e8 01             	sub    $0x1,%eax
80104e80:	8b 04 85 e0 68 11 80 	mov    -0x7fee9720(,%eax,4),%eax
80104e87:	8b 40 0c             	mov    0xc(%eax),%eax
80104e8a:	83 f8 03             	cmp    $0x3,%eax
80104e8d:	75 1c                	jne    80104eab <scheduler+0x198>
          {
            p = lcfs_q.proc[i - 1];
80104e8f:	8b 45 e8             	mov    -0x18(%ebp),%eax
80104e92:	83 e8 01             	sub    $0x1,%eax
80104e95:	8b 04 85 e0 68 11 80 	mov    -0x7fee9720(,%eax,4),%eax
80104e9c:	89 45 f4             	mov    %eax,-0xc(%ebp)
            found_runnable = 1;
80104e9f:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
            break;
80104ea6:	e9 20 01 00 00       	jmp    80104fcb <scheduler+0x2b8>
        for (int i = lcfs_q.pi; i > 0; i--)
80104eab:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
80104eaf:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80104eb3:	7f c5                	jg     80104e7a <scheduler+0x167>
80104eb5:	e9 11 01 00 00       	jmp    80104fcb <scheduler+0x2b8>
          }
        }
      }
      else
      {
        panic("No runnable process\n");
80104eba:	83 ec 0c             	sub    $0xc,%esp
80104ebd:	68 20 9a 10 80       	push   $0x80109a20
80104ec2:	e8 ee b6 ff ff       	call   801005b5 <panic>
      }
    }
    else if (bjf_q.pi >= 0)
80104ec7:	a1 00 6b 11 80       	mov    0x80116b00,%eax
80104ecc:	85 c0                	test   %eax,%eax
80104ece:	78 78                	js     80104f48 <scheduler+0x235>
    {
      float worst_rank = 999999999;
80104ed0:	d9 05 2c 9c 10 80    	flds   0x80109c2c
80104ed6:	d9 5d e4             	fstps  -0x1c(%ebp)
      float rank;

      for (int i = 0; i < bjf_q.pi; i++)
80104ed9:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80104ee0:	eb 57                	jmp    80104f39 <scheduler+0x226>
      {
        if (bjf_q.proc[i]->state != RUNNABLE)
80104ee2:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104ee5:	8b 04 85 00 6a 11 80 	mov    -0x7fee9600(,%eax,4),%eax
80104eec:	8b 40 0c             	mov    0xc(%eax),%eax
80104eef:	83 f8 03             	cmp    $0x3,%eax
80104ef2:	75 40                	jne    80104f34 <scheduler+0x221>
          continue;

        rank = calculate_rank(bjf_q.proc[i]);
80104ef4:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104ef7:	8b 04 85 00 6a 11 80 	mov    -0x7fee9600(,%eax,4),%eax
80104efe:	83 ec 0c             	sub    $0xc,%esp
80104f01:	50                   	push   %eax
80104f02:	e8 97 fd ff ff       	call   80104c9e <calculate_rank>
80104f07:	83 c4 10             	add    $0x10,%esp
80104f0a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80104f0d:	db 45 d4             	fildl  -0x2c(%ebp)
80104f10:	d9 5d d8             	fstps  -0x28(%ebp)

        if (rank < worst_rank)
80104f13:	d9 45 d8             	flds   -0x28(%ebp)
80104f16:	d9 45 e4             	flds   -0x1c(%ebp)
80104f19:	df f1                	fcomip %st(1),%st
80104f1b:	dd d8                	fstp   %st(0)
80104f1d:	76 16                	jbe    80104f35 <scheduler+0x222>
        {
          p = bjf_q.proc[i];
80104f1f:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104f22:	8b 04 85 00 6a 11 80 	mov    -0x7fee9600(,%eax,4),%eax
80104f29:	89 45 f4             	mov    %eax,-0xc(%ebp)
          worst_rank = rank;
80104f2c:	d9 45 d8             	flds   -0x28(%ebp)
80104f2f:	d9 5d e4             	fstps  -0x1c(%ebp)
80104f32:	eb 01                	jmp    80104f35 <scheduler+0x222>
          continue;
80104f34:	90                   	nop
      for (int i = 0; i < bjf_q.pi; i++)
80104f35:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
80104f39:	a1 00 6b 11 80       	mov    0x80116b00,%eax
80104f3e:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80104f41:	7c 9f                	jl     80104ee2 <scheduler+0x1cf>
80104f43:	e9 83 00 00 00       	jmp    80104fcb <scheduler+0x2b8>
        }
      }
    }
    else
    {
      for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104f48:	c7 45 f4 b4 3d 11 80 	movl   $0x80113db4,-0xc(%ebp)
80104f4f:	eb 71                	jmp    80104fc2 <scheduler+0x2af>
      {
        if (p->state != RUNNABLE)
80104f51:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f54:	8b 40 0c             	mov    0xc(%eax),%eax
80104f57:	83 f8 03             	cmp    $0x3,%eax
80104f5a:	75 5e                	jne    80104fba <scheduler+0x2a7>
          continue;
        }
        // Switch to chosen process.  It is the process's job
        // to release ptable.lock and then reacquire it
        // before jumping back to us.
        p->waiting_time = 0;
80104f5c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f5f:	c7 80 a0 00 00 00 00 	movl   $0x0,0xa0(%eax)
80104f66:	00 00 00 
        c->proc = p;
80104f69:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104f6c:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104f6f:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
        switchuvm(p);
80104f75:	83 ec 0c             	sub    $0xc,%esp
80104f78:	ff 75 f4             	push   -0xc(%ebp)
80104f7b:	e8 ec 3e 00 00       	call   80108e6c <switchuvm>
80104f80:	83 c4 10             	add    $0x10,%esp
        p->state = RUNNING;
80104f83:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f86:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)

        swtch(&(c->scheduler), p->context);
80104f8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f90:	8b 40 1c             	mov    0x1c(%eax),%eax
80104f93:	8b 55 dc             	mov    -0x24(%ebp),%edx
80104f96:	83 c2 04             	add    $0x4,%edx
80104f99:	83 ec 08             	sub    $0x8,%esp
80104f9c:	50                   	push   %eax
80104f9d:	52                   	push   %edx
80104f9e:	e8 85 15 00 00       	call   80106528 <swtch>
80104fa3:	83 c4 10             	add    $0x10,%esp
        switchkvm();
80104fa6:	e8 a8 3e 00 00       	call   80108e53 <switchkvm>

        // Process is done running for now.
        // It should have changed its p->state before coming back.
        c->proc = 0;
80104fab:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104fae:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104fb5:	00 00 00 
80104fb8:	eb 01                	jmp    80104fbb <scheduler+0x2a8>
          continue;
80104fba:	90                   	nop
      for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104fbb:	81 45 f4 a8 00 00 00 	addl   $0xa8,-0xc(%ebp)
80104fc2:	81 7d f4 b4 67 11 80 	cmpl   $0x801167b4,-0xc(%ebp)
80104fc9:	72 86                	jb     80104f51 <scheduler+0x23e>
      }
    }
    if (found_runnable)
80104fcb:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80104fcf:	74 5c                	je     8010502d <scheduler+0x31a>
    {
      p->waiting_time = 0;
80104fd1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104fd4:	c7 80 a0 00 00 00 00 	movl   $0x0,0xa0(%eax)
80104fdb:	00 00 00 
      c->proc = p;
80104fde:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104fe1:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104fe4:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
      switchuvm(p);
80104fea:	83 ec 0c             	sub    $0xc,%esp
80104fed:	ff 75 f4             	push   -0xc(%ebp)
80104ff0:	e8 77 3e 00 00       	call   80108e6c <switchuvm>
80104ff5:	83 c4 10             	add    $0x10,%esp
      p->state = RUNNING;
80104ff8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ffb:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
      swtch(&(c->scheduler), p->context);
80105002:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105005:	8b 40 1c             	mov    0x1c(%eax),%eax
80105008:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010500b:	83 c2 04             	add    $0x4,%edx
8010500e:	83 ec 08             	sub    $0x8,%esp
80105011:	50                   	push   %eax
80105012:	52                   	push   %edx
80105013:	e8 10 15 00 00       	call   80106528 <swtch>
80105018:	83 c4 10             	add    $0x10,%esp
      switchkvm();
8010501b:	e8 33 3e 00 00       	call   80108e53 <switchkvm>
      c->proc = 0;
80105020:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105023:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
8010502a:	00 00 00 
    }
    release(&ptable.lock);
8010502d:	83 ec 0c             	sub    $0xc,%esp
80105030:	68 80 3d 11 80       	push   $0x80113d80
80105035:	e8 61 10 00 00       	call   8010609b <release>
8010503a:	83 c4 10             	add    $0x10,%esp
  {
8010503d:	e9 ec fc ff ff       	jmp    80104d2e <scheduler+0x1b>

80105042 <sched>:
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void sched(void)
{
80105042:	55                   	push   %ebp
80105043:	89 e5                	mov    %esp,%ebp
80105045:	83 ec 18             	sub    $0x18,%esp
  int intena;
  struct proc *p = myproc();
80105048:	e8 c9 f2 ff ff       	call   80104316 <myproc>
8010504d:	89 45 f4             	mov    %eax,-0xc(%ebp)

  if (!holding(&ptable.lock))
80105050:	83 ec 0c             	sub    $0xc,%esp
80105053:	68 80 3d 11 80       	push   $0x80113d80
80105058:	e8 0b 11 00 00       	call   80106168 <holding>
8010505d:	83 c4 10             	add    $0x10,%esp
80105060:	85 c0                	test   %eax,%eax
80105062:	75 0d                	jne    80105071 <sched+0x2f>
    panic("sched ptable.lock");
80105064:	83 ec 0c             	sub    $0xc,%esp
80105067:	68 35 9a 10 80       	push   $0x80109a35
8010506c:	e8 44 b5 ff ff       	call   801005b5 <panic>
  if (mycpu()->ncli != 1)
80105071:	e8 28 f2 ff ff       	call   8010429e <mycpu>
80105076:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
8010507c:	83 f8 01             	cmp    $0x1,%eax
8010507f:	74 0d                	je     8010508e <sched+0x4c>
    panic("sched locks");
80105081:	83 ec 0c             	sub    $0xc,%esp
80105084:	68 47 9a 10 80       	push   $0x80109a47
80105089:	e8 27 b5 ff ff       	call   801005b5 <panic>
  if (p->state == RUNNING)
8010508e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105091:	8b 40 0c             	mov    0xc(%eax),%eax
80105094:	83 f8 04             	cmp    $0x4,%eax
80105097:	75 0d                	jne    801050a6 <sched+0x64>
    panic("sched running");
80105099:	83 ec 0c             	sub    $0xc,%esp
8010509c:	68 53 9a 10 80       	push   $0x80109a53
801050a1:	e8 0f b5 ff ff       	call   801005b5 <panic>
  if (readeflags() & FL_IF)
801050a6:	e8 26 f1 ff ff       	call   801041d1 <readeflags>
801050ab:	25 00 02 00 00       	and    $0x200,%eax
801050b0:	85 c0                	test   %eax,%eax
801050b2:	74 0d                	je     801050c1 <sched+0x7f>
    panic("sched interruptible");
801050b4:	83 ec 0c             	sub    $0xc,%esp
801050b7:	68 61 9a 10 80       	push   $0x80109a61
801050bc:	e8 f4 b4 ff ff       	call   801005b5 <panic>
  intena = mycpu()->intena;
801050c1:	e8 d8 f1 ff ff       	call   8010429e <mycpu>
801050c6:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801050cc:	89 45 f0             	mov    %eax,-0x10(%ebp)
  swtch(&p->context, mycpu()->scheduler);
801050cf:	e8 ca f1 ff ff       	call   8010429e <mycpu>
801050d4:	8b 40 04             	mov    0x4(%eax),%eax
801050d7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801050da:	83 c2 1c             	add    $0x1c,%edx
801050dd:	83 ec 08             	sub    $0x8,%esp
801050e0:	50                   	push   %eax
801050e1:	52                   	push   %edx
801050e2:	e8 41 14 00 00       	call   80106528 <swtch>
801050e7:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
801050ea:	e8 af f1 ff ff       	call   8010429e <mycpu>
801050ef:	8b 55 f0             	mov    -0x10(%ebp),%edx
801050f2:	89 90 a8 00 00 00    	mov    %edx,0xa8(%eax)
}
801050f8:	90                   	nop
801050f9:	c9                   	leave  
801050fa:	c3                   	ret    

801050fb <yield>:

// Give up the CPU for one scheduling round.
void yield(void)
{
801050fb:	55                   	push   %ebp
801050fc:	89 e5                	mov    %esp,%ebp
801050fe:	53                   	push   %ebx
801050ff:	83 ec 04             	sub    $0x4,%esp
  acquire(&ptable.lock); // DOC: yieldlock
80105102:	83 ec 0c             	sub    $0xc,%esp
80105105:	68 80 3d 11 80       	push   $0x80113d80
8010510a:	e8 1e 0f 00 00       	call   8010602d <acquire>
8010510f:	83 c4 10             	add    $0x10,%esp
  // According to TRICKS file
  // Change proc values before RUNNABLE
  myproc()->running_ticks = 0; // reset running ticks to 0
80105112:	e8 ff f1 ff ff       	call   80104316 <myproc>
80105117:	c7 80 9c 00 00 00 00 	movl   $0x0,0x9c(%eax)
8010511e:	00 00 00 
  if (myproc()->q_type == RR)
80105121:	e8 f0 f1 ff ff       	call   80104316 <myproc>
80105126:	8b 40 7c             	mov    0x7c(%eax),%eax
80105129:	83 f8 01             	cmp    $0x1,%eax
8010512c:	75 0d                	jne    8010513b <yield+0x40>
  {
    rr_counter++;
8010512e:	a1 04 6b 11 80       	mov    0x80116b04,%eax
80105133:	83 c0 01             	add    $0x1,%eax
80105136:	a3 04 6b 11 80       	mov    %eax,0x80116b04
  }
  if (myproc()->change_running_queue)
8010513b:	e8 d6 f1 ff ff       	call   80104316 <myproc>
80105140:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105146:	85 c0                	test   %eax,%eax
80105148:	0f 84 91 00 00 00    	je     801051df <yield+0xe4>
  {
    switch (myproc()->q_type)
8010514e:	e8 c3 f1 ff ff       	call   80104316 <myproc>
80105153:	8b 40 7c             	mov    0x7c(%eax),%eax
80105156:	83 f8 03             	cmp    $0x3,%eax
80105159:	74 53                	je     801051ae <yield+0xb3>
8010515b:	83 f8 03             	cmp    $0x3,%eax
8010515e:	77 6f                	ja     801051cf <yield+0xd4>
80105160:	83 f8 01             	cmp    $0x1,%eax
80105163:	74 07                	je     8010516c <yield+0x71>
80105165:	83 f8 02             	cmp    $0x2,%eax
80105168:	74 23                	je     8010518d <yield+0x92>
    case BJF:
      bjf_q.pi++;
      bjf_q.proc[bjf_q.pi] = myproc();
      break;
    default:
      break;
8010516a:	eb 63                	jmp    801051cf <yield+0xd4>
      rr_q.pi++;
8010516c:	a1 c0 68 11 80       	mov    0x801168c0,%eax
80105171:	83 c0 01             	add    $0x1,%eax
80105174:	a3 c0 68 11 80       	mov    %eax,0x801168c0
      rr_q.proc[rr_q.pi] = myproc();
80105179:	8b 1d c0 68 11 80    	mov    0x801168c0,%ebx
8010517f:	e8 92 f1 ff ff       	call   80104316 <myproc>
80105184:	89 04 9d c0 67 11 80 	mov    %eax,-0x7fee9840(,%ebx,4)
      break;
8010518b:	eb 43                	jmp    801051d0 <yield+0xd5>
      lcfs_q.pi++;
8010518d:	a1 e0 69 11 80       	mov    0x801169e0,%eax
80105192:	83 c0 01             	add    $0x1,%eax
80105195:	a3 e0 69 11 80       	mov    %eax,0x801169e0
      lcfs_q.proc[lcfs_q.pi] = myproc();
8010519a:	8b 1d e0 69 11 80    	mov    0x801169e0,%ebx
801051a0:	e8 71 f1 ff ff       	call   80104316 <myproc>
801051a5:	89 04 9d e0 68 11 80 	mov    %eax,-0x7fee9720(,%ebx,4)
      break;
801051ac:	eb 22                	jmp    801051d0 <yield+0xd5>
      bjf_q.pi++;
801051ae:	a1 00 6b 11 80       	mov    0x80116b00,%eax
801051b3:	83 c0 01             	add    $0x1,%eax
801051b6:	a3 00 6b 11 80       	mov    %eax,0x80116b00
      bjf_q.proc[bjf_q.pi] = myproc();
801051bb:	8b 1d 00 6b 11 80    	mov    0x80116b00,%ebx
801051c1:	e8 50 f1 ff ff       	call   80104316 <myproc>
801051c6:	89 04 9d 00 6a 11 80 	mov    %eax,-0x7fee9600(,%ebx,4)
      break;
801051cd:	eb 01                	jmp    801051d0 <yield+0xd5>
      break;
801051cf:	90                   	nop
    }
    // Change has been applied
    myproc()->change_running_queue = 0;
801051d0:	e8 41 f1 ff ff       	call   80104316 <myproc>
801051d5:	c7 80 a4 00 00 00 00 	movl   $0x0,0xa4(%eax)
801051dc:	00 00 00 
  }
  myproc()->state = RUNNABLE;
801051df:	e8 32 f1 ff ff       	call   80104316 <myproc>
801051e4:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
801051eb:	e8 52 fe ff ff       	call   80105042 <sched>
  release(&ptable.lock);
801051f0:	83 ec 0c             	sub    $0xc,%esp
801051f3:	68 80 3d 11 80       	push   $0x80113d80
801051f8:	e8 9e 0e 00 00       	call   8010609b <release>
801051fd:	83 c4 10             	add    $0x10,%esp
}
80105200:	90                   	nop
80105201:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105204:	c9                   	leave  
80105205:	c3                   	ret    

80105206 <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void forkret(void)
{
80105206:	55                   	push   %ebp
80105207:	89 e5                	mov    %esp,%ebp
80105209:	83 ec 08             	sub    $0x8,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
8010520c:	83 ec 0c             	sub    $0xc,%esp
8010520f:	68 80 3d 11 80       	push   $0x80113d80
80105214:	e8 82 0e 00 00       	call   8010609b <release>
80105219:	83 c4 10             	add    $0x10,%esp

  if (first)
8010521c:	a1 04 c0 10 80       	mov    0x8010c004,%eax
80105221:	85 c0                	test   %eax,%eax
80105223:	74 24                	je     80105249 <forkret+0x43>
  {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
80105225:	c7 05 04 c0 10 80 00 	movl   $0x0,0x8010c004
8010522c:	00 00 00 
    iinit(ROOTDEV);
8010522f:	83 ec 0c             	sub    $0xc,%esp
80105232:	6a 01                	push   $0x1
80105234:	e8 6f c4 ff ff       	call   801016a8 <iinit>
80105239:	83 c4 10             	add    $0x10,%esp
    initlog(ROOTDEV);
8010523c:	83 ec 0c             	sub    $0xc,%esp
8010523f:	6a 01                	push   $0x1
80105241:	e8 cd e0 ff ff       	call   80103313 <initlog>
80105246:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
80105249:	90                   	nop
8010524a:	c9                   	leave  
8010524b:	c3                   	ret    

8010524c <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void sleep(void *chan, struct spinlock *lk)
{
8010524c:	55                   	push   %ebp
8010524d:	89 e5                	mov    %esp,%ebp
8010524f:	83 ec 18             	sub    $0x18,%esp
  struct proc *p = myproc();
80105252:	e8 bf f0 ff ff       	call   80104316 <myproc>
80105257:	89 45 f4             	mov    %eax,-0xc(%ebp)

  if (p == 0)
8010525a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010525e:	75 0d                	jne    8010526d <sleep+0x21>
    panic("sleep");
80105260:	83 ec 0c             	sub    $0xc,%esp
80105263:	68 75 9a 10 80       	push   $0x80109a75
80105268:	e8 48 b3 ff ff       	call   801005b5 <panic>

  if (lk == 0)
8010526d:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80105271:	75 0d                	jne    80105280 <sleep+0x34>
    panic("sleep without lk");
80105273:	83 ec 0c             	sub    $0xc,%esp
80105276:	68 7b 9a 10 80       	push   $0x80109a7b
8010527b:	e8 35 b3 ff ff       	call   801005b5 <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if (lk != &ptable.lock)
80105280:	81 7d 0c 80 3d 11 80 	cmpl   $0x80113d80,0xc(%ebp)
80105287:	74 1e                	je     801052a7 <sleep+0x5b>
  {                        // DOC: sleeplock0
    acquire(&ptable.lock); // DOC: sleeplock1
80105289:	83 ec 0c             	sub    $0xc,%esp
8010528c:	68 80 3d 11 80       	push   $0x80113d80
80105291:	e8 97 0d 00 00       	call   8010602d <acquire>
80105296:	83 c4 10             	add    $0x10,%esp
    release(lk);
80105299:	83 ec 0c             	sub    $0xc,%esp
8010529c:	ff 75 0c             	push   0xc(%ebp)
8010529f:	e8 f7 0d 00 00       	call   8010609b <release>
801052a4:	83 c4 10             	add    $0x10,%esp
  }
  cleanupCorresQueue(p);
801052a7:	83 ec 0c             	sub    $0xc,%esp
801052aa:	ff 75 f4             	push   -0xc(%ebp)
801052ad:	e8 b3 f6 ff ff       	call   80104965 <cleanupCorresQueue>
801052b2:	83 c4 10             	add    $0x10,%esp
  // Cleanup from queue on sleep
  // Go to sleep.
  p->chan = chan;
801052b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801052b8:	8b 55 08             	mov    0x8(%ebp),%edx
801052bb:	89 50 20             	mov    %edx,0x20(%eax)
  p->state = SLEEPING;
801052be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801052c1:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)

  sched();
801052c8:	e8 75 fd ff ff       	call   80105042 <sched>

  // Tidy up.
  p->chan = 0;
801052cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801052d0:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if (lk != &ptable.lock)
801052d7:	81 7d 0c 80 3d 11 80 	cmpl   $0x80113d80,0xc(%ebp)
801052de:	74 1e                	je     801052fe <sleep+0xb2>
  { // DOC: sleeplock2
    release(&ptable.lock);
801052e0:	83 ec 0c             	sub    $0xc,%esp
801052e3:	68 80 3d 11 80       	push   $0x80113d80
801052e8:	e8 ae 0d 00 00       	call   8010609b <release>
801052ed:	83 c4 10             	add    $0x10,%esp
    acquire(lk);
801052f0:	83 ec 0c             	sub    $0xc,%esp
801052f3:	ff 75 0c             	push   0xc(%ebp)
801052f6:	e8 32 0d 00 00       	call   8010602d <acquire>
801052fb:	83 c4 10             	add    $0x10,%esp
  }
}
801052fe:	90                   	nop
801052ff:	c9                   	leave  
80105300:	c3                   	ret    

80105301 <wakeup1>:
// PAGEBREAK!
//  Wake up all processes sleeping on chan.
//  The ptable lock must be held.
static void
wakeup1(void *chan)
{
80105301:	55                   	push   %ebp
80105302:	89 e5                	mov    %esp,%ebp
80105304:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105307:	c7 45 fc b4 3d 11 80 	movl   $0x80113db4,-0x4(%ebp)
8010530e:	e9 a6 00 00 00       	jmp    801053b9 <wakeup1+0xb8>
    if (p->state == SLEEPING && p->chan == chan)
80105313:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105316:	8b 40 0c             	mov    0xc(%eax),%eax
80105319:	83 f8 02             	cmp    $0x2,%eax
8010531c:	0f 85 90 00 00 00    	jne    801053b2 <wakeup1+0xb1>
80105322:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105325:	8b 40 20             	mov    0x20(%eax),%eax
80105328:	39 45 08             	cmp    %eax,0x8(%ebp)
8010532b:	0f 85 81 00 00 00    	jne    801053b2 <wakeup1+0xb1>
    {
      // Add to queue once again when woken up
      switch (p->q_type)
80105331:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105334:	8b 40 7c             	mov    0x7c(%eax),%eax
80105337:	83 f8 03             	cmp    $0x3,%eax
8010533a:	74 4d                	je     80105389 <wakeup1+0x88>
8010533c:	83 f8 03             	cmp    $0x3,%eax
8010533f:	77 66                	ja     801053a7 <wakeup1+0xa6>
80105341:	83 f8 01             	cmp    $0x1,%eax
80105344:	74 07                	je     8010534d <wakeup1+0x4c>
80105346:	83 f8 02             	cmp    $0x2,%eax
80105349:	74 20                	je     8010536b <wakeup1+0x6a>
      case BJF:
        bjf_q.pi++;
        bjf_q.proc[bjf_q.pi] = p;
        break;
      default:
        break;
8010534b:	eb 5a                	jmp    801053a7 <wakeup1+0xa6>
        rr_q.pi++;
8010534d:	a1 c0 68 11 80       	mov    0x801168c0,%eax
80105352:	83 c0 01             	add    $0x1,%eax
80105355:	a3 c0 68 11 80       	mov    %eax,0x801168c0
        rr_q.proc[rr_q.pi] = p;
8010535a:	a1 c0 68 11 80       	mov    0x801168c0,%eax
8010535f:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105362:	89 14 85 c0 67 11 80 	mov    %edx,-0x7fee9840(,%eax,4)
        break;
80105369:	eb 3d                	jmp    801053a8 <wakeup1+0xa7>
        lcfs_q.pi++;
8010536b:	a1 e0 69 11 80       	mov    0x801169e0,%eax
80105370:	83 c0 01             	add    $0x1,%eax
80105373:	a3 e0 69 11 80       	mov    %eax,0x801169e0
        lcfs_q.proc[lcfs_q.pi] = p;
80105378:	a1 e0 69 11 80       	mov    0x801169e0,%eax
8010537d:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105380:	89 14 85 e0 68 11 80 	mov    %edx,-0x7fee9720(,%eax,4)
        break;
80105387:	eb 1f                	jmp    801053a8 <wakeup1+0xa7>
        bjf_q.pi++;
80105389:	a1 00 6b 11 80       	mov    0x80116b00,%eax
8010538e:	83 c0 01             	add    $0x1,%eax
80105391:	a3 00 6b 11 80       	mov    %eax,0x80116b00
        bjf_q.proc[bjf_q.pi] = p;
80105396:	a1 00 6b 11 80       	mov    0x80116b00,%eax
8010539b:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010539e:	89 14 85 00 6a 11 80 	mov    %edx,-0x7fee9600(,%eax,4)
        break;
801053a5:	eb 01                	jmp    801053a8 <wakeup1+0xa7>
        break;
801053a7:	90                   	nop
      }
      p->state = RUNNABLE;
801053a8:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053ab:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801053b2:	81 45 fc a8 00 00 00 	addl   $0xa8,-0x4(%ebp)
801053b9:	81 7d fc b4 67 11 80 	cmpl   $0x801167b4,-0x4(%ebp)
801053c0:	0f 82 4d ff ff ff    	jb     80105313 <wakeup1+0x12>
    }
}
801053c6:	90                   	nop
801053c7:	90                   	nop
801053c8:	c9                   	leave  
801053c9:	c3                   	ret    

801053ca <wakeup>:

// Wake up all processes sleeping on chan.
void wakeup(void *chan)
{
801053ca:	55                   	push   %ebp
801053cb:	89 e5                	mov    %esp,%ebp
801053cd:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);
801053d0:	83 ec 0c             	sub    $0xc,%esp
801053d3:	68 80 3d 11 80       	push   $0x80113d80
801053d8:	e8 50 0c 00 00       	call   8010602d <acquire>
801053dd:	83 c4 10             	add    $0x10,%esp
  wakeup1(chan);
801053e0:	83 ec 0c             	sub    $0xc,%esp
801053e3:	ff 75 08             	push   0x8(%ebp)
801053e6:	e8 16 ff ff ff       	call   80105301 <wakeup1>
801053eb:	83 c4 10             	add    $0x10,%esp
  release(&ptable.lock);
801053ee:	83 ec 0c             	sub    $0xc,%esp
801053f1:	68 80 3d 11 80       	push   $0x80113d80
801053f6:	e8 a0 0c 00 00       	call   8010609b <release>
801053fb:	83 c4 10             	add    $0x10,%esp
}
801053fe:	90                   	nop
801053ff:	c9                   	leave  
80105400:	c3                   	ret    

80105401 <kill>:

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int kill(int pid)
{
80105401:	55                   	push   %ebp
80105402:	89 e5                	mov    %esp,%ebp
80105404:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
80105407:	83 ec 0c             	sub    $0xc,%esp
8010540a:	68 80 3d 11 80       	push   $0x80113d80
8010540f:	e8 19 0c 00 00       	call   8010602d <acquire>
80105414:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105417:	c7 45 f4 b4 3d 11 80 	movl   $0x80113db4,-0xc(%ebp)
8010541e:	e9 c9 00 00 00       	jmp    801054ec <kill+0xeb>
  {
    if (p->pid == pid)
80105423:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105426:	8b 40 10             	mov    0x10(%eax),%eax
80105429:	39 45 08             	cmp    %eax,0x8(%ebp)
8010542c:	0f 85 b3 00 00 00    	jne    801054e5 <kill+0xe4>
    {
      p->killed = 1;
80105432:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105435:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if (p->state == SLEEPING)
8010543c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010543f:	8b 40 0c             	mov    0xc(%eax),%eax
80105442:	83 f8 02             	cmp    $0x2,%eax
80105445:	0f 85 83 00 00 00    	jne    801054ce <kill+0xcd>
      {
        if (p->q_type == RR)
8010544b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010544e:	8b 40 7c             	mov    0x7c(%eax),%eax
80105451:	83 f8 01             	cmp    $0x1,%eax
80105454:	75 1e                	jne    80105474 <kill+0x73>
        {
          rr_q.pi++;
80105456:	a1 c0 68 11 80       	mov    0x801168c0,%eax
8010545b:	83 c0 01             	add    $0x1,%eax
8010545e:	a3 c0 68 11 80       	mov    %eax,0x801168c0
          rr_q.proc[rr_q.pi] = p;
80105463:	a1 c0 68 11 80       	mov    0x801168c0,%eax
80105468:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010546b:	89 14 85 c0 67 11 80 	mov    %edx,-0x7fee9840(,%eax,4)
80105472:	eb 50                	jmp    801054c4 <kill+0xc3>
        }
        else if (p->q_type == LCFS)
80105474:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105477:	8b 40 7c             	mov    0x7c(%eax),%eax
8010547a:	83 f8 02             	cmp    $0x2,%eax
8010547d:	75 1e                	jne    8010549d <kill+0x9c>
        {
          lcfs_q.pi++;
8010547f:	a1 e0 69 11 80       	mov    0x801169e0,%eax
80105484:	83 c0 01             	add    $0x1,%eax
80105487:	a3 e0 69 11 80       	mov    %eax,0x801169e0
          lcfs_q.proc[lcfs_q.pi] = p;
8010548c:	a1 e0 69 11 80       	mov    0x801169e0,%eax
80105491:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105494:	89 14 85 e0 68 11 80 	mov    %edx,-0x7fee9720(,%eax,4)
8010549b:	eb 27                	jmp    801054c4 <kill+0xc3>
        }
        else if (p->q_type == BJF)
8010549d:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054a0:	8b 40 7c             	mov    0x7c(%eax),%eax
801054a3:	83 f8 03             	cmp    $0x3,%eax
801054a6:	75 1c                	jne    801054c4 <kill+0xc3>
        {
          bjf_q.pi++;
801054a8:	a1 00 6b 11 80       	mov    0x80116b00,%eax
801054ad:	83 c0 01             	add    $0x1,%eax
801054b0:	a3 00 6b 11 80       	mov    %eax,0x80116b00
          bjf_q.proc[bjf_q.pi] = p;
801054b5:	a1 00 6b 11 80       	mov    0x80116b00,%eax
801054ba:	8b 55 f4             	mov    -0xc(%ebp),%edx
801054bd:	89 14 85 00 6a 11 80 	mov    %edx,-0x7fee9600(,%eax,4)
        }
        p->state = RUNNABLE;
801054c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054c7:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      }
      release(&ptable.lock);
801054ce:	83 ec 0c             	sub    $0xc,%esp
801054d1:	68 80 3d 11 80       	push   $0x80113d80
801054d6:	e8 c0 0b 00 00       	call   8010609b <release>
801054db:	83 c4 10             	add    $0x10,%esp
      return 0;
801054de:	b8 00 00 00 00       	mov    $0x0,%eax
801054e3:	eb 29                	jmp    8010550e <kill+0x10d>
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801054e5:	81 45 f4 a8 00 00 00 	addl   $0xa8,-0xc(%ebp)
801054ec:	81 7d f4 b4 67 11 80 	cmpl   $0x801167b4,-0xc(%ebp)
801054f3:	0f 82 2a ff ff ff    	jb     80105423 <kill+0x22>
    }
  }
  release(&ptable.lock);
801054f9:	83 ec 0c             	sub    $0xc,%esp
801054fc:	68 80 3d 11 80       	push   $0x80113d80
80105501:	e8 95 0b 00 00       	call   8010609b <release>
80105506:	83 c4 10             	add    $0x10,%esp
  return -1;
80105509:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
8010550e:	c9                   	leave  
8010550f:	c3                   	ret    

80105510 <procdump>:
// PAGEBREAK: 36
//  Print a process listing to console.  For debugging.
//  Runs when user types ^P on console.
//  No lock to avoid wedging a stuck machine further.
void procdump(void)
{
80105510:	55                   	push   %ebp
80105511:	89 e5                	mov    %esp,%ebp
80105513:	83 ec 48             	sub    $0x48,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105516:	c7 45 f0 b4 3d 11 80 	movl   $0x80113db4,-0x10(%ebp)
8010551d:	e9 da 00 00 00       	jmp    801055fc <procdump+0xec>
  {
    if (p->state == UNUSED)
80105522:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105525:	8b 40 0c             	mov    0xc(%eax),%eax
80105528:	85 c0                	test   %eax,%eax
8010552a:	0f 84 c4 00 00 00    	je     801055f4 <procdump+0xe4>
      continue;
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
80105530:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105533:	8b 40 0c             	mov    0xc(%eax),%eax
80105536:	83 f8 05             	cmp    $0x5,%eax
80105539:	77 23                	ja     8010555e <procdump+0x4e>
8010553b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010553e:	8b 40 0c             	mov    0xc(%eax),%eax
80105541:	8b 04 85 08 c0 10 80 	mov    -0x7fef3ff8(,%eax,4),%eax
80105548:	85 c0                	test   %eax,%eax
8010554a:	74 12                	je     8010555e <procdump+0x4e>
      state = states[p->state];
8010554c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010554f:	8b 40 0c             	mov    0xc(%eax),%eax
80105552:	8b 04 85 08 c0 10 80 	mov    -0x7fef3ff8(,%eax,4),%eax
80105559:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010555c:	eb 07                	jmp    80105565 <procdump+0x55>
    else
      state = "???";
8010555e:	c7 45 ec 8c 9a 10 80 	movl   $0x80109a8c,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
80105565:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105568:	8d 50 6c             	lea    0x6c(%eax),%edx
8010556b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010556e:	8b 40 10             	mov    0x10(%eax),%eax
80105571:	52                   	push   %edx
80105572:	ff 75 ec             	push   -0x14(%ebp)
80105575:	50                   	push   %eax
80105576:	68 90 9a 10 80       	push   $0x80109a90
8010557b:	e8 80 ae ff ff       	call   80100400 <cprintf>
80105580:	83 c4 10             	add    $0x10,%esp
    if (p->state == SLEEPING)
80105583:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105586:	8b 40 0c             	mov    0xc(%eax),%eax
80105589:	83 f8 02             	cmp    $0x2,%eax
8010558c:	75 54                	jne    801055e2 <procdump+0xd2>
    {
      getcallerpcs((uint *)p->context->ebp + 2, pc);
8010558e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105591:	8b 40 1c             	mov    0x1c(%eax),%eax
80105594:	8b 40 0c             	mov    0xc(%eax),%eax
80105597:	83 c0 08             	add    $0x8,%eax
8010559a:	89 c2                	mov    %eax,%edx
8010559c:	83 ec 08             	sub    $0x8,%esp
8010559f:	8d 45 c4             	lea    -0x3c(%ebp),%eax
801055a2:	50                   	push   %eax
801055a3:	52                   	push   %edx
801055a4:	e8 44 0b 00 00       	call   801060ed <getcallerpcs>
801055a9:	83 c4 10             	add    $0x10,%esp
      for (i = 0; i < 10 && pc[i] != 0; i++)
801055ac:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801055b3:	eb 1c                	jmp    801055d1 <procdump+0xc1>
        cprintf(" %p", pc[i]);
801055b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055b8:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
801055bc:	83 ec 08             	sub    $0x8,%esp
801055bf:	50                   	push   %eax
801055c0:	68 99 9a 10 80       	push   $0x80109a99
801055c5:	e8 36 ae ff ff       	call   80100400 <cprintf>
801055ca:	83 c4 10             	add    $0x10,%esp
      for (i = 0; i < 10 && pc[i] != 0; i++)
801055cd:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801055d1:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
801055d5:	7f 0b                	jg     801055e2 <procdump+0xd2>
801055d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801055da:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
801055de:	85 c0                	test   %eax,%eax
801055e0:	75 d3                	jne    801055b5 <procdump+0xa5>
    }
    cprintf("\n");
801055e2:	83 ec 0c             	sub    $0xc,%esp
801055e5:	68 9d 9a 10 80       	push   $0x80109a9d
801055ea:	e8 11 ae ff ff       	call   80100400 <cprintf>
801055ef:	83 c4 10             	add    $0x10,%esp
801055f2:	eb 01                	jmp    801055f5 <procdump+0xe5>
      continue;
801055f4:	90                   	nop
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801055f5:	81 45 f0 a8 00 00 00 	addl   $0xa8,-0x10(%ebp)
801055fc:	81 7d f0 b4 67 11 80 	cmpl   $0x801167b4,-0x10(%ebp)
80105603:	0f 82 19 ff ff ff    	jb     80105522 <procdump+0x12>
  }
}
80105609:	90                   	nop
8010560a:	90                   	nop
8010560b:	c9                   	leave  
8010560c:	c3                   	ret    

8010560d <wrap_space>:

char *wrap_space(char *inp, char *holder, const int len)
{
8010560d:	55                   	push   %ebp
8010560e:	89 e5                	mov    %esp,%ebp
80105610:	83 ec 18             	sub    $0x18,%esp
  memset(holder, ' ', len);
80105613:	8b 45 10             	mov    0x10(%ebp),%eax
80105616:	83 ec 04             	sub    $0x4,%esp
80105619:	50                   	push   %eax
8010561a:	6a 20                	push   $0x20
8010561c:	ff 75 0c             	push   0xc(%ebp)
8010561f:	e8 8f 0c 00 00       	call   801062b3 <memset>
80105624:	83 c4 10             	add    $0x10,%esp
  holder[len] = 0;
80105627:	8b 55 10             	mov    0x10(%ebp),%edx
8010562a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010562d:	01 d0                	add    %edx,%eax
8010562f:	c6 00 00             	movb   $0x0,(%eax)
  int n = len;
80105632:	8b 45 10             	mov    0x10(%ebp),%eax
80105635:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int i = 0;
80105638:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  while (n-- > 0)
8010563f:	eb 28                	jmp    80105669 <wrap_space+0x5c>
  {
    if (*(inp + i) == 0)
80105641:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105644:	8b 45 08             	mov    0x8(%ebp),%eax
80105647:	01 d0                	add    %edx,%eax
80105649:	0f b6 00             	movzbl (%eax),%eax
8010564c:	84 c0                	test   %al,%al
8010564e:	74 28                	je     80105678 <wrap_space+0x6b>
      break;
    *(holder + i) = *(inp + i);
80105650:	8b 55 f0             	mov    -0x10(%ebp),%edx
80105653:	8b 45 08             	mov    0x8(%ebp),%eax
80105656:	01 d0                	add    %edx,%eax
80105658:	8b 4d f0             	mov    -0x10(%ebp),%ecx
8010565b:	8b 55 0c             	mov    0xc(%ebp),%edx
8010565e:	01 ca                	add    %ecx,%edx
80105660:	0f b6 00             	movzbl (%eax),%eax
80105663:	88 02                	mov    %al,(%edx)
    i++;
80105665:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  while (n-- > 0)
80105669:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010566c:	8d 50 ff             	lea    -0x1(%eax),%edx
8010566f:	89 55 f4             	mov    %edx,-0xc(%ebp)
80105672:	85 c0                	test   %eax,%eax
80105674:	7f cb                	jg     80105641 <wrap_space+0x34>
80105676:	eb 01                	jmp    80105679 <wrap_space+0x6c>
      break;
80105678:	90                   	nop
  }
  return holder;
80105679:	8b 45 0c             	mov    0xc(%ebp),%eax
}
8010567c:	c9                   	leave  
8010567d:	c3                   	ret    

8010567e <wrap_spacei>:

char *wrap_spacei(int inp, char *holder, const int len)
{
8010567e:	55                   	push   %ebp
8010567f:	89 e5                	mov    %esp,%ebp
80105681:	53                   	push   %ebx
80105682:	83 ec 14             	sub    $0x14,%esp
  if (inp < 0)
80105685:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80105689:	79 0d                	jns    80105698 <wrap_spacei+0x1a>
  {
    panic("negative pid or arrive time");
8010568b:	83 ec 0c             	sub    $0xc,%esp
8010568e:	68 9f 9a 10 80       	push   $0x80109a9f
80105693:	e8 1d af ff ff       	call   801005b5 <panic>
  }
  memset(holder, ' ', len);
80105698:	8b 45 10             	mov    0x10(%ebp),%eax
8010569b:	83 ec 04             	sub    $0x4,%esp
8010569e:	50                   	push   %eax
8010569f:	6a 20                	push   $0x20
801056a1:	ff 75 0c             	push   0xc(%ebp)
801056a4:	e8 0a 0c 00 00       	call   801062b3 <memset>
801056a9:	83 c4 10             	add    $0x10,%esp
  holder[len] = 0;
801056ac:	8b 55 10             	mov    0x10(%ebp),%edx
801056af:	8b 45 0c             	mov    0xc(%ebp),%eax
801056b2:	01 d0                	add    %edx,%eax
801056b4:	c6 00 00             	movb   $0x0,(%eax)
  int rev = 0;
801056b7:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  int cnt = 0;
801056be:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  do
  {
    rev *= 10;
801056c5:	8b 55 f4             	mov    -0xc(%ebp),%edx
801056c8:	89 d0                	mov    %edx,%eax
801056ca:	c1 e0 02             	shl    $0x2,%eax
801056cd:	01 d0                	add    %edx,%eax
801056cf:	01 c0                	add    %eax,%eax
801056d1:	89 45 f4             	mov    %eax,-0xc(%ebp)
    rev += (inp % 10);
801056d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
801056d7:	ba 67 66 66 66       	mov    $0x66666667,%edx
801056dc:	89 c8                	mov    %ecx,%eax
801056de:	f7 ea                	imul   %edx
801056e0:	89 d0                	mov    %edx,%eax
801056e2:	c1 f8 02             	sar    $0x2,%eax
801056e5:	89 cb                	mov    %ecx,%ebx
801056e7:	c1 fb 1f             	sar    $0x1f,%ebx
801056ea:	29 d8                	sub    %ebx,%eax
801056ec:	89 c2                	mov    %eax,%edx
801056ee:	89 d0                	mov    %edx,%eax
801056f0:	c1 e0 02             	shl    $0x2,%eax
801056f3:	01 d0                	add    %edx,%eax
801056f5:	01 c0                	add    %eax,%eax
801056f7:	29 c1                	sub    %eax,%ecx
801056f9:	89 ca                	mov    %ecx,%edx
801056fb:	01 55 f4             	add    %edx,-0xc(%ebp)
    inp /= 10;
801056fe:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105701:	ba 67 66 66 66       	mov    $0x66666667,%edx
80105706:	89 c8                	mov    %ecx,%eax
80105708:	f7 ea                	imul   %edx
8010570a:	89 d0                	mov    %edx,%eax
8010570c:	c1 f8 02             	sar    $0x2,%eax
8010570f:	c1 f9 1f             	sar    $0x1f,%ecx
80105712:	89 ca                	mov    %ecx,%edx
80105714:	29 d0                	sub    %edx,%eax
80105716:	89 45 08             	mov    %eax,0x8(%ebp)
    cnt++;
80105719:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  } while (inp > 0);
8010571d:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80105721:	7f a2                	jg     801056c5 <wrap_spacei+0x47>
  for (int i = 0; i < cnt; i++)
80105723:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
8010572a:	eb 57                	jmp    80105783 <wrap_spacei+0x105>
  {
    holder[i] = (rev % 10) + '0';
8010572c:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010572f:	ba 67 66 66 66       	mov    $0x66666667,%edx
80105734:	89 c8                	mov    %ecx,%eax
80105736:	f7 ea                	imul   %edx
80105738:	89 d0                	mov    %edx,%eax
8010573a:	c1 f8 02             	sar    $0x2,%eax
8010573d:	89 cb                	mov    %ecx,%ebx
8010573f:	c1 fb 1f             	sar    $0x1f,%ebx
80105742:	29 d8                	sub    %ebx,%eax
80105744:	89 c2                	mov    %eax,%edx
80105746:	89 d0                	mov    %edx,%eax
80105748:	c1 e0 02             	shl    $0x2,%eax
8010574b:	01 d0                	add    %edx,%eax
8010574d:	01 c0                	add    %eax,%eax
8010574f:	29 c1                	sub    %eax,%ecx
80105751:	89 ca                	mov    %ecx,%edx
80105753:	89 d0                	mov    %edx,%eax
80105755:	8d 48 30             	lea    0x30(%eax),%ecx
80105758:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010575b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010575e:	01 d0                	add    %edx,%eax
80105760:	89 ca                	mov    %ecx,%edx
80105762:	88 10                	mov    %dl,(%eax)
    rev /= 10;
80105764:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80105767:	ba 67 66 66 66       	mov    $0x66666667,%edx
8010576c:	89 c8                	mov    %ecx,%eax
8010576e:	f7 ea                	imul   %edx
80105770:	89 d0                	mov    %edx,%eax
80105772:	c1 f8 02             	sar    $0x2,%eax
80105775:	c1 f9 1f             	sar    $0x1f,%ecx
80105778:	89 ca                	mov    %ecx,%edx
8010577a:	29 d0                	sub    %edx,%eax
8010577c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for (int i = 0; i < cnt; i++)
8010577f:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80105783:	8b 45 ec             	mov    -0x14(%ebp),%eax
80105786:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80105789:	7c a1                	jl     8010572c <wrap_spacei+0xae>
  }
  return holder;
8010578b:	8b 45 0c             	mov    0xc(%ebp),%eax
}
8010578e:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105791:	c9                   	leave  
80105792:	c3                   	ret    

80105793 <print_proc>:
#define SIZER_LEN 2 // Size ratio

#define TICKS_LEN 6

void print_proc(void)
{
80105793:	55                   	push   %ebp
80105794:	89 e5                	mov    %esp,%ebp
80105796:	57                   	push   %edi
80105797:	56                   	push   %esi
80105798:	53                   	push   %ebx
80105799:	81 ec ac 00 00 00    	sub    $0xac,%esp
  struct proc *p;
  char *states[] = {
8010579f:	c7 45 cc bb 9a 10 80 	movl   $0x80109abb,-0x34(%ebp)
801057a6:	c7 45 d0 c4 9a 10 80 	movl   $0x80109ac4,-0x30(%ebp)
801057ad:	c7 45 d4 cd 9a 10 80 	movl   $0x80109acd,-0x2c(%ebp)
801057b4:	c7 45 d8 d6 9a 10 80 	movl   $0x80109ad6,-0x28(%ebp)
801057bb:	c7 45 dc df 9a 10 80 	movl   $0x80109adf,-0x24(%ebp)
801057c2:	c7 45 e0 e8 9a 10 80 	movl   $0x80109ae8,-0x20(%ebp)
      [EMBRYO] "EMBRYO  ",
      [SLEEPING] "SLEEPING",
      [RUNNABLE] "RUNNABLE",
      [RUNNING] "RUNNING ",
      [ZOMBIE] "ZOMBIE  "};
  cprintf("name          pid  state    queue  arr_time  priority Ratio:p a e s  exe_cycle  p_size  ticks\n");
801057c9:	83 ec 0c             	sub    $0xc,%esp
801057cc:	68 f4 9a 10 80       	push   $0x80109af4
801057d1:	e8 2a ac ff ff       	call   80100400 <cprintf>
801057d6:	83 c4 10             	add    $0x10,%esp
  cprintf("..............................................................................\n");
801057d9:	83 ec 0c             	sub    $0xc,%esp
801057dc:	68 54 9b 10 80       	push   $0x80109b54
801057e1:	e8 1a ac ff ff       	call   80100400 <cprintf>
801057e6:	83 c4 10             	add    $0x10,%esp
  acquire(&ptable.lock);
801057e9:	83 ec 0c             	sub    $0xc,%esp
801057ec:	68 80 3d 11 80       	push   $0x80113d80
801057f1:	e8 37 08 00 00       	call   8010602d <acquire>
801057f6:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801057f9:	c7 45 e4 b4 3d 11 80 	movl   $0x80113db4,-0x1c(%ebp)
80105800:	e9 8e 02 00 00       	jmp    80105a93 <print_proc+0x300>
  {
    if (p->state == UNUSED)
80105805:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105808:	8b 40 0c             	mov    0xc(%eax),%eax
8010580b:	85 c0                	test   %eax,%eax
8010580d:	0f 84 78 02 00 00    	je     80105a8b <print_proc+0x2f8>
    char size_holder[SIZE_LEN + 1];
    char sizer_holder[SIZER_LEN + 1];

    char ticks_holder[TICKS_LEN + 1];

    cprintf("%s %s %s   %d   %s %s %s %s %s %s %s %s %s\n",
80105813:	a1 54 73 11 80       	mov    0x80117354,%eax
80105818:	89 c2                	mov    %eax,%edx
8010581a:	83 ec 04             	sub    $0x4,%esp
8010581d:	6a 06                	push   $0x6
8010581f:	8d 85 7c ff ff ff    	lea    -0x84(%ebp),%eax
80105825:	50                   	push   %eax
80105826:	52                   	push   %edx
80105827:	e8 52 fe ff ff       	call   8010567e <wrap_spacei>
8010582c:	83 c4 10             	add    $0x10,%esp
8010582f:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
            wrap_spacei(p->arrivetime_ratio, atr_holder, ATR_LEN),
            wrap_spacei(p->executed_cycle_ratio, exr_holder, EXR_LEN),
            wrap_spacei(p->size_ratio, sizer_holder, SIZER_LEN),

            wrap_spacei(p->running_ticks, ex_holder, EX_LEN),
            wrap_spacei(p->sz, size_holder, SIZE_LEN),
80105835:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105838:	8b 00                	mov    (%eax),%eax
    cprintf("%s %s %s   %d   %s %s %s %s %s %s %s %s %s\n",
8010583a:	89 c2                	mov    %eax,%edx
8010583c:	83 ec 04             	sub    $0x4,%esp
8010583f:	6a 07                	push   $0x7
80105841:	8d 45 86             	lea    -0x7a(%ebp),%eax
80105844:	50                   	push   %eax
80105845:	52                   	push   %edx
80105846:	e8 33 fe ff ff       	call   8010567e <wrap_spacei>
8010584b:	83 c4 10             	add    $0x10,%esp
8010584e:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
            wrap_spacei(p->running_ticks, ex_holder, EX_LEN),
80105854:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105857:	8b 80 9c 00 00 00    	mov    0x9c(%eax),%eax
    cprintf("%s %s %s   %d   %s %s %s %s %s %s %s %s %s\n",
8010585d:	89 c2                	mov    %eax,%edx
8010585f:	83 ec 04             	sub    $0x4,%esp
80105862:	6a 0a                	push   $0xa
80105864:	8d 45 90             	lea    -0x70(%ebp),%eax
80105867:	50                   	push   %eax
80105868:	52                   	push   %edx
80105869:	e8 10 fe ff ff       	call   8010567e <wrap_spacei>
8010586e:	83 c4 10             	add    $0x10,%esp
80105871:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
            wrap_spacei(p->size_ratio, sizer_holder, SIZER_LEN),
80105877:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010587a:	d9 80 98 00 00 00    	flds   0x98(%eax)
    cprintf("%s %s %s   %d   %s %s %s %s %s %s %s %s %s\n",
80105880:	d9 bd 76 ff ff ff    	fnstcw -0x8a(%ebp)
80105886:	0f b7 85 76 ff ff ff 	movzwl -0x8a(%ebp),%eax
8010588d:	80 cc 0c             	or     $0xc,%ah
80105890:	66 89 85 74 ff ff ff 	mov    %ax,-0x8c(%ebp)
80105897:	d9 ad 74 ff ff ff    	fldcw  -0x8c(%ebp)
8010589d:	db 9d 64 ff ff ff    	fistpl -0x9c(%ebp)
801058a3:	d9 ad 76 ff ff ff    	fldcw  -0x8a(%ebp)
801058a9:	8b 95 64 ff ff ff    	mov    -0x9c(%ebp),%edx
801058af:	83 ec 04             	sub    $0x4,%esp
801058b2:	6a 02                	push   $0x2
801058b4:	8d 45 83             	lea    -0x7d(%ebp),%eax
801058b7:	50                   	push   %eax
801058b8:	52                   	push   %edx
801058b9:	e8 c0 fd ff ff       	call   8010567e <wrap_spacei>
801058be:	83 c4 10             	add    $0x10,%esp
801058c1:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
            wrap_spacei(p->executed_cycle_ratio, exr_holder, EXR_LEN),
801058c7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801058ca:	d9 80 8c 00 00 00    	flds   0x8c(%eax)
    cprintf("%s %s %s   %d   %s %s %s %s %s %s %s %s %s\n",
801058d0:	d9 bd 76 ff ff ff    	fnstcw -0x8a(%ebp)
801058d6:	0f b7 85 76 ff ff ff 	movzwl -0x8a(%ebp),%eax
801058dd:	80 cc 0c             	or     $0xc,%ah
801058e0:	66 89 85 74 ff ff ff 	mov    %ax,-0x8c(%ebp)
801058e7:	d9 ad 74 ff ff ff    	fldcw  -0x8c(%ebp)
801058ed:	db 9d 60 ff ff ff    	fistpl -0xa0(%ebp)
801058f3:	d9 ad 76 ff ff ff    	fldcw  -0x8a(%ebp)
801058f9:	8b 95 60 ff ff ff    	mov    -0xa0(%ebp),%edx
801058ff:	83 ec 04             	sub    $0x4,%esp
80105902:	6a 01                	push   $0x1
80105904:	8d 45 8e             	lea    -0x72(%ebp),%eax
80105907:	50                   	push   %eax
80105908:	52                   	push   %edx
80105909:	e8 70 fd ff ff       	call   8010567e <wrap_spacei>
8010590e:	83 c4 10             	add    $0x10,%esp
80105911:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
            wrap_spacei(p->arrivetime_ratio, atr_holder, ATR_LEN),
80105917:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010591a:	d9 80 94 00 00 00    	flds   0x94(%eax)
    cprintf("%s %s %s   %d   %s %s %s %s %s %s %s %s %s\n",
80105920:	d9 bd 76 ff ff ff    	fnstcw -0x8a(%ebp)
80105926:	0f b7 85 76 ff ff ff 	movzwl -0x8a(%ebp),%eax
8010592d:	80 cc 0c             	or     $0xc,%ah
80105930:	66 89 85 74 ff ff ff 	mov    %ax,-0x8c(%ebp)
80105937:	d9 ad 74 ff ff ff    	fldcw  -0x8c(%ebp)
8010593d:	db 9d 5c ff ff ff    	fistpl -0xa4(%ebp)
80105943:	d9 ad 76 ff ff ff    	fldcw  -0x8a(%ebp)
80105949:	8b 95 5c ff ff ff    	mov    -0xa4(%ebp),%edx
8010594f:	83 ec 04             	sub    $0x4,%esp
80105952:	6a 01                	push   $0x1
80105954:	8d 45 ab             	lea    -0x55(%ebp),%eax
80105957:	50                   	push   %eax
80105958:	52                   	push   %edx
80105959:	e8 20 fd ff ff       	call   8010567e <wrap_spacei>
8010595e:	83 c4 10             	add    $0x10,%esp
80105961:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
            wrap_spacei(p->priority_ratio, prr_holder, PRR_LEN),
80105967:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010596a:	d9 80 84 00 00 00    	flds   0x84(%eax)
    cprintf("%s %s %s   %d   %s %s %s %s %s %s %s %s %s\n",
80105970:	d9 bd 76 ff ff ff    	fnstcw -0x8a(%ebp)
80105976:	0f b7 85 76 ff ff ff 	movzwl -0x8a(%ebp),%eax
8010597d:	80 cc 0c             	or     $0xc,%ah
80105980:	66 89 85 74 ff ff ff 	mov    %ax,-0x8c(%ebp)
80105987:	d9 ad 74 ff ff ff    	fldcw  -0x8c(%ebp)
8010598d:	db 9d 58 ff ff ff    	fistpl -0xa8(%ebp)
80105993:	d9 ad 76 ff ff ff    	fldcw  -0x8a(%ebp)
80105999:	8b 95 58 ff ff ff    	mov    -0xa8(%ebp),%edx
8010599f:	83 ec 04             	sub    $0x4,%esp
801059a2:	6a 01                	push   $0x1
801059a4:	8d 45 9b             	lea    -0x65(%ebp),%eax
801059a7:	50                   	push   %eax
801059a8:	52                   	push   %edx
801059a9:	e8 d0 fc ff ff       	call   8010567e <wrap_spacei>
801059ae:	83 c4 10             	add    $0x10,%esp
801059b1:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
801059b7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801059ba:	8b 90 80 00 00 00    	mov    0x80(%eax),%edx
801059c0:	83 ec 04             	sub    $0x4,%esp
801059c3:	6a 0d                	push   $0xd
801059c5:	8d 45 9d             	lea    -0x63(%ebp),%eax
801059c8:	50                   	push   %eax
801059c9:	52                   	push   %edx
801059ca:	e8 af fc ff ff       	call   8010567e <wrap_spacei>
801059cf:	83 c4 10             	add    $0x10,%esp
801059d2:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
            wrap_spacei(p->arrivetime, at_holder, AT_LEN),
801059d8:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801059db:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
    cprintf("%s %s %s   %d   %s %s %s %s %s %s %s %s %s\n",
801059e1:	89 c2                	mov    %eax,%edx
801059e3:	83 ec 04             	sub    $0x4,%esp
801059e6:	6a 0a                	push   $0xa
801059e8:	8d 45 ad             	lea    -0x53(%ebp),%eax
801059eb:	50                   	push   %eax
801059ec:	52                   	push   %edx
801059ed:	e8 8c fc ff ff       	call   8010567e <wrap_spacei>
801059f2:	83 c4 10             	add    $0x10,%esp
801059f5:	89 c7                	mov    %eax,%edi
            p->q_type,
801059f7:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801059fa:	8b 48 7c             	mov    0x7c(%eax),%ecx
801059fd:	89 8d 50 ff ff ff    	mov    %ecx,-0xb0(%ebp)
            states[p->state],
80105a03:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105a06:	8b 40 0c             	mov    0xc(%eax),%eax
    cprintf("%s %s %s   %d   %s %s %s %s %s %s %s %s %s\n",
80105a09:	8b 74 85 cc          	mov    -0x34(%ebp,%eax,4),%esi
80105a0d:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105a10:	8b 50 10             	mov    0x10(%eax),%edx
80105a13:	83 ec 04             	sub    $0x4,%esp
80105a16:	6a 03                	push   $0x3
80105a18:	8d 45 b8             	lea    -0x48(%ebp),%eax
80105a1b:	50                   	push   %eax
80105a1c:	52                   	push   %edx
80105a1d:	e8 5c fc ff ff       	call   8010567e <wrap_spacei>
80105a22:	83 c4 10             	add    $0x10,%esp
80105a25:	89 c3                	mov    %eax,%ebx
            wrap_space(p->name, name_holder, NAME_LEN),
80105a27:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105a2a:	8d 50 6c             	lea    0x6c(%eax),%edx
    cprintf("%s %s %s   %d   %s %s %s %s %s %s %s %s %s\n",
80105a2d:	83 ec 04             	sub    $0x4,%esp
80105a30:	6a 0f                	push   $0xf
80105a32:	8d 45 bc             	lea    -0x44(%ebp),%eax
80105a35:	50                   	push   %eax
80105a36:	52                   	push   %edx
80105a37:	e8 d1 fb ff ff       	call   8010560d <wrap_space>
80105a3c:	83 c4 10             	add    $0x10,%esp
80105a3f:	83 ec 08             	sub    $0x8,%esp
80105a42:	ff b5 70 ff ff ff    	push   -0x90(%ebp)
80105a48:	ff b5 6c ff ff ff    	push   -0x94(%ebp)
80105a4e:	ff b5 68 ff ff ff    	push   -0x98(%ebp)
80105a54:	ff b5 64 ff ff ff    	push   -0x9c(%ebp)
80105a5a:	ff b5 60 ff ff ff    	push   -0xa0(%ebp)
80105a60:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80105a66:	ff b5 58 ff ff ff    	push   -0xa8(%ebp)
80105a6c:	ff b5 54 ff ff ff    	push   -0xac(%ebp)
80105a72:	57                   	push   %edi
80105a73:	ff b5 50 ff ff ff    	push   -0xb0(%ebp)
80105a79:	56                   	push   %esi
80105a7a:	53                   	push   %ebx
80105a7b:	50                   	push   %eax
80105a7c:	68 a4 9b 10 80       	push   $0x80109ba4
80105a81:	e8 7a a9 ff ff       	call   80100400 <cprintf>
80105a86:	83 c4 40             	add    $0x40,%esp
80105a89:	eb 01                	jmp    80105a8c <print_proc+0x2f9>
      continue;
80105a8b:	90                   	nop
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105a8c:	81 45 e4 a8 00 00 00 	addl   $0xa8,-0x1c(%ebp)
80105a93:	81 7d e4 b4 67 11 80 	cmpl   $0x801167b4,-0x1c(%ebp)
80105a9a:	0f 82 65 fd ff ff    	jb     80105805 <print_proc+0x72>
            wrap_spacei(ticks, ticks_holder, TICKS_LEN));
  }
  release(&ptable.lock);
80105aa0:	83 ec 0c             	sub    $0xc,%esp
80105aa3:	68 80 3d 11 80       	push   $0x80113d80
80105aa8:	e8 ee 05 00 00       	call   8010609b <release>
80105aad:	83 c4 10             	add    $0x10,%esp
}
80105ab0:	90                   	nop
80105ab1:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105ab4:	5b                   	pop    %ebx
80105ab5:	5e                   	pop    %esi
80105ab6:	5f                   	pop    %edi
80105ab7:	5d                   	pop    %ebp
80105ab8:	c3                   	ret    

80105ab9 <agingMechanism>:

void agingMechanism(void)
{
80105ab9:	55                   	push   %ebp
80105aba:	89 e5                	mov    %esp,%ebp
80105abc:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  if (!holding(&ptable.lock))
80105abf:	83 ec 0c             	sub    $0xc,%esp
80105ac2:	68 80 3d 11 80       	push   $0x80113d80
80105ac7:	e8 9c 06 00 00       	call   80106168 <holding>
80105acc:	83 c4 10             	add    $0x10,%esp
80105acf:	85 c0                	test   %eax,%eax
80105ad1:	75 10                	jne    80105ae3 <agingMechanism+0x2a>
  {
    acquire(&ptable.lock);
80105ad3:	83 ec 0c             	sub    $0xc,%esp
80105ad6:	68 80 3d 11 80       	push   $0x80113d80
80105adb:	e8 4d 05 00 00       	call   8010602d <acquire>
80105ae0:	83 c4 10             	add    $0x10,%esp
  }
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105ae3:	c7 45 f4 b4 3d 11 80 	movl   $0x80113db4,-0xc(%ebp)
80105aea:	eb 76                	jmp    80105b62 <agingMechanism+0xa9>
  {
    if (p->state == RUNNABLE)
80105aec:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105aef:	8b 40 0c             	mov    0xc(%eax),%eax
80105af2:	83 f8 03             	cmp    $0x3,%eax
80105af5:	75 64                	jne    80105b5b <agingMechanism+0xa2>
    {
      p->waiting_time++;
80105af7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105afa:	8b 80 a0 00 00 00    	mov    0xa0(%eax),%eax
80105b00:	8d 50 01             	lea    0x1(%eax),%edx
80105b03:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b06:	89 90 a0 00 00 00    	mov    %edx,0xa0(%eax)
      if (p->waiting_time > AGING_BOUND && p->q_type != RR)
80105b0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b0f:	8b 80 a0 00 00 00    	mov    0xa0(%eax),%eax
80105b15:	3d d0 07 00 00       	cmp    $0x7d0,%eax
80105b1a:	76 3f                	jbe    80105b5b <agingMechanism+0xa2>
80105b1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b1f:	8b 40 7c             	mov    0x7c(%eax),%eax
80105b22:	83 f8 01             	cmp    $0x1,%eax
80105b25:	74 34                	je     80105b5b <agingMechanism+0xa2>
      {
        cleanupCorresQueue(p);
80105b27:	83 ec 0c             	sub    $0xc,%esp
80105b2a:	ff 75 f4             	push   -0xc(%ebp)
80105b2d:	e8 33 ee ff ff       	call   80104965 <cleanupCorresQueue>
80105b32:	83 c4 10             	add    $0x10,%esp
        p->q_type = RR;
80105b35:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105b38:	c7 40 7c 01 00 00 00 	movl   $0x1,0x7c(%eax)
        rr_q.pi++;
80105b3f:	a1 c0 68 11 80       	mov    0x801168c0,%eax
80105b44:	83 c0 01             	add    $0x1,%eax
80105b47:	a3 c0 68 11 80       	mov    %eax,0x801168c0
        rr_q.proc[rr_q.pi] = p;
80105b4c:	a1 c0 68 11 80       	mov    0x801168c0,%eax
80105b51:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105b54:	89 14 85 c0 67 11 80 	mov    %edx,-0x7fee9840(,%eax,4)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105b5b:	81 45 f4 a8 00 00 00 	addl   $0xa8,-0xc(%ebp)
80105b62:	81 7d f4 b4 67 11 80 	cmpl   $0x801167b4,-0xc(%ebp)
80105b69:	72 81                	jb     80105aec <agingMechanism+0x33>
      }
    }
  }
  release(&ptable.lock);
80105b6b:	83 ec 0c             	sub    $0xc,%esp
80105b6e:	68 80 3d 11 80       	push   $0x80113d80
80105b73:	e8 23 05 00 00       	call   8010609b <release>
80105b78:	83 c4 10             	add    $0x10,%esp
}
80105b7b:	90                   	nop
80105b7c:	c9                   	leave  
80105b7d:	c3                   	ret    

80105b7e <change_queue>:

void change_queue(int pid, int queueID)
{
80105b7e:	55                   	push   %ebp
80105b7f:	89 e5                	mov    %esp,%ebp
80105b81:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  acquire(&ptable.lock);
80105b84:	83 ec 0c             	sub    $0xc,%esp
80105b87:	68 80 3d 11 80       	push   $0x80113d80
80105b8c:	e8 9c 04 00 00       	call   8010602d <acquire>
80105b91:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105b94:	c7 45 f4 b4 3d 11 80 	movl   $0x80113db4,-0xc(%ebp)
80105b9b:	eb 12                	jmp    80105baf <change_queue+0x31>
  {
    if (p->pid == pid)
80105b9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105ba0:	8b 40 10             	mov    0x10(%eax),%eax
80105ba3:	39 45 08             	cmp    %eax,0x8(%ebp)
80105ba6:	74 12                	je     80105bba <change_queue+0x3c>
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105ba8:	81 45 f4 a8 00 00 00 	addl   $0xa8,-0xc(%ebp)
80105baf:	81 7d f4 b4 67 11 80 	cmpl   $0x801167b4,-0xc(%ebp)
80105bb6:	72 e5                	jb     80105b9d <change_queue+0x1f>
80105bb8:	eb 01                	jmp    80105bbb <change_queue+0x3d>
    {
      break;
80105bba:	90                   	nop
    }
  }
  if (p->pid != pid)
80105bbb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bbe:	8b 40 10             	mov    0x10(%eax),%eax
80105bc1:	39 45 08             	cmp    %eax,0x8(%ebp)
80105bc4:	74 25                	je     80105beb <change_queue+0x6d>
  {
    cprintf("incorrect pid");
80105bc6:	83 ec 0c             	sub    $0xc,%esp
80105bc9:	68 d0 9b 10 80       	push   $0x80109bd0
80105bce:	e8 2d a8 ff ff       	call   80100400 <cprintf>
80105bd3:	83 c4 10             	add    $0x10,%esp
    release(&ptable.lock);
80105bd6:	83 ec 0c             	sub    $0xc,%esp
80105bd9:	68 80 3d 11 80       	push   $0x80113d80
80105bde:	e8 b8 04 00 00       	call   8010609b <release>
80105be3:	83 c4 10             	add    $0x10,%esp
    return;
80105be6:	e9 46 01 00 00       	jmp    80105d31 <change_queue+0x1b3>
  }
  if (p->state == RUNNING || p->state == RUNNABLE)
80105beb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bee:	8b 40 0c             	mov    0xc(%eax),%eax
80105bf1:	83 f8 04             	cmp    $0x4,%eax
80105bf4:	74 0b                	je     80105c01 <change_queue+0x83>
80105bf6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bf9:	8b 40 0c             	mov    0xc(%eax),%eax
80105bfc:	83 f8 03             	cmp    $0x3,%eax
80105bff:	75 0e                	jne    80105c0f <change_queue+0x91>
  {
    cleanupCorresQueue(p);
80105c01:	83 ec 0c             	sub    $0xc,%esp
80105c04:	ff 75 f4             	push   -0xc(%ebp)
80105c07:	e8 59 ed ff ff       	call   80104965 <cleanupCorresQueue>
80105c0c:	83 c4 10             	add    $0x10,%esp
  }
  switch (queueID)
80105c0f:	83 7d 0c 03          	cmpl   $0x3,0xc(%ebp)
80105c13:	0f 84 a4 00 00 00    	je     80105cbd <change_queue+0x13f>
80105c19:	83 7d 0c 03          	cmpl   $0x3,0xc(%ebp)
80105c1d:	0f 8f cd 00 00 00    	jg     80105cf0 <change_queue+0x172>
80105c23:	83 7d 0c 02          	cmpl   $0x2,0xc(%ebp)
80105c27:	74 61                	je     80105c8a <change_queue+0x10c>
80105c29:	83 7d 0c 02          	cmpl   $0x2,0xc(%ebp)
80105c2d:	0f 8f bd 00 00 00    	jg     80105cf0 <change_queue+0x172>
80105c33:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80105c37:	74 0b                	je     80105c44 <change_queue+0xc6>
80105c39:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
80105c3d:	74 14                	je     80105c53 <change_queue+0xd5>
80105c3f:	e9 ac 00 00 00       	jmp    80105cf0 <change_queue+0x172>
  {
  case DEF:
    p->q_type = DEF;
80105c44:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c47:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%eax)
    break;
80105c4e:	e9 b6 00 00 00       	jmp    80105d09 <change_queue+0x18b>
  case RR:
    p->q_type = RR;
80105c53:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c56:	c7 40 7c 01 00 00 00 	movl   $0x1,0x7c(%eax)
    if (p->state == RUNNABLE)
80105c5d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c60:	8b 40 0c             	mov    0xc(%eax),%eax
80105c63:	83 f8 03             	cmp    $0x3,%eax
80105c66:	0f 85 96 00 00 00    	jne    80105d02 <change_queue+0x184>
    {
      rr_q.pi++;
80105c6c:	a1 c0 68 11 80       	mov    0x801168c0,%eax
80105c71:	83 c0 01             	add    $0x1,%eax
80105c74:	a3 c0 68 11 80       	mov    %eax,0x801168c0
      rr_q.proc[rr_q.pi] = p;
80105c79:	a1 c0 68 11 80       	mov    0x801168c0,%eax
80105c7e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105c81:	89 14 85 c0 67 11 80 	mov    %edx,-0x7fee9840(,%eax,4)
    }
    break;
80105c88:	eb 78                	jmp    80105d02 <change_queue+0x184>
  case LCFS:
    p->q_type = LCFS;
80105c8a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c8d:	c7 40 7c 02 00 00 00 	movl   $0x2,0x7c(%eax)
    if (p->state == RUNNABLE)
80105c94:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c97:	8b 40 0c             	mov    0xc(%eax),%eax
80105c9a:	83 f8 03             	cmp    $0x3,%eax
80105c9d:	75 66                	jne    80105d05 <change_queue+0x187>
    {
      lcfs_q.pi++;
80105c9f:	a1 e0 69 11 80       	mov    0x801169e0,%eax
80105ca4:	83 c0 01             	add    $0x1,%eax
80105ca7:	a3 e0 69 11 80       	mov    %eax,0x801169e0
      lcfs_q.proc[lcfs_q.pi] = p;
80105cac:	a1 e0 69 11 80       	mov    0x801169e0,%eax
80105cb1:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105cb4:	89 14 85 e0 68 11 80 	mov    %edx,-0x7fee9720(,%eax,4)
    }
    break;
80105cbb:	eb 48                	jmp    80105d05 <change_queue+0x187>
  case BJF:
    p->q_type = BJF;
80105cbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cc0:	c7 40 7c 03 00 00 00 	movl   $0x3,0x7c(%eax)
    if (p->state == RUNNABLE)
80105cc7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cca:	8b 40 0c             	mov    0xc(%eax),%eax
80105ccd:	83 f8 03             	cmp    $0x3,%eax
80105cd0:	75 36                	jne    80105d08 <change_queue+0x18a>
    {
      bjf_q.pi++;
80105cd2:	a1 00 6b 11 80       	mov    0x80116b00,%eax
80105cd7:	83 c0 01             	add    $0x1,%eax
80105cda:	a3 00 6b 11 80       	mov    %eax,0x80116b00
      bjf_q.proc[bjf_q.pi] = p;
80105cdf:	a1 00 6b 11 80       	mov    0x80116b00,%eax
80105ce4:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105ce7:	89 14 85 00 6a 11 80 	mov    %edx,-0x7fee9600(,%eax,4)
    }
    break;
80105cee:	eb 18                	jmp    80105d08 <change_queue+0x18a>
  default:
    cprintf("undefined queue");
80105cf0:	83 ec 0c             	sub    $0xc,%esp
80105cf3:	68 de 9b 10 80       	push   $0x80109bde
80105cf8:	e8 03 a7 ff ff       	call   80100400 <cprintf>
80105cfd:	83 c4 10             	add    $0x10,%esp
80105d00:	eb 07                	jmp    80105d09 <change_queue+0x18b>
    break;
80105d02:	90                   	nop
80105d03:	eb 04                	jmp    80105d09 <change_queue+0x18b>
    break;
80105d05:	90                   	nop
80105d06:	eb 01                	jmp    80105d09 <change_queue+0x18b>
    break;
80105d08:	90                   	nop
  }

  if (p->state == RUNNING)
80105d09:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d0c:	8b 40 0c             	mov    0xc(%eax),%eax
80105d0f:	83 f8 04             	cmp    $0x4,%eax
80105d12:	75 0d                	jne    80105d21 <change_queue+0x1a3>
  {
    p->change_running_queue = 1;
80105d14:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d17:	c7 80 a4 00 00 00 01 	movl   $0x1,0xa4(%eax)
80105d1e:	00 00 00 
  }
  release(&ptable.lock);
80105d21:	83 ec 0c             	sub    $0xc,%esp
80105d24:	68 80 3d 11 80       	push   $0x80113d80
80105d29:	e8 6d 03 00 00       	call   8010609b <release>
80105d2e:	83 c4 10             	add    $0x10,%esp
}
80105d31:	c9                   	leave  
80105d32:	c3                   	ret    

80105d33 <change_local_bjf>:

int change_local_bjf(int pid, int pRatio, int aRatio, int eRatio, int sRatio)
{
80105d33:	55                   	push   %ebp
80105d34:	89 e5                	mov    %esp,%ebp
80105d36:	83 ec 18             	sub    $0x18,%esp
  struct proc *p = 0;
80105d39:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&ptable.lock);
80105d40:	83 ec 0c             	sub    $0xc,%esp
80105d43:	68 80 3d 11 80       	push   $0x80113d80
80105d48:	e8 e0 02 00 00       	call   8010602d <acquire>
80105d4d:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105d50:	c7 45 f4 b4 3d 11 80 	movl   $0x80113db4,-0xc(%ebp)
80105d57:	eb 12                	jmp    80105d6b <change_local_bjf+0x38>
  {
    if (p->pid == pid)
80105d59:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d5c:	8b 40 10             	mov    0x10(%eax),%eax
80105d5f:	39 45 08             	cmp    %eax,0x8(%ebp)
80105d62:	74 12                	je     80105d76 <change_local_bjf+0x43>
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105d64:	81 45 f4 a8 00 00 00 	addl   $0xa8,-0xc(%ebp)
80105d6b:	81 7d f4 b4 67 11 80 	cmpl   $0x801167b4,-0xc(%ebp)
80105d72:	72 e5                	jb     80105d59 <change_local_bjf+0x26>
80105d74:	eb 01                	jmp    80105d77 <change_local_bjf+0x44>
      break;
80105d76:	90                   	nop
  }
  if (p == 0)
80105d77:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105d7b:	75 27                	jne    80105da4 <change_local_bjf+0x71>
  {
    release(&ptable.lock);
80105d7d:	83 ec 0c             	sub    $0xc,%esp
80105d80:	68 80 3d 11 80       	push   $0x80113d80
80105d85:	e8 11 03 00 00       	call   8010609b <release>
80105d8a:	83 c4 10             	add    $0x10,%esp
    cprintf("pid not found");
80105d8d:	83 ec 0c             	sub    $0xc,%esp
80105d90:	68 ee 9b 10 80       	push   $0x80109bee
80105d95:	e8 66 a6 ff ff       	call   80100400 <cprintf>
80105d9a:	83 c4 10             	add    $0x10,%esp
    return -1;
80105d9d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80105da2:	eb 45                	jmp    80105de9 <change_local_bjf+0xb6>
  }
  else
  {
    p->priority_ratio = pRatio;
80105da4:	db 45 0c             	fildl  0xc(%ebp)
80105da7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105daa:	d9 98 84 00 00 00    	fstps  0x84(%eax)
    p->arrivetime_ratio = aRatio;
80105db0:	db 45 10             	fildl  0x10(%ebp)
80105db3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105db6:	d9 98 94 00 00 00    	fstps  0x94(%eax)
    p->executed_cycle_ratio = eRatio;
80105dbc:	db 45 14             	fildl  0x14(%ebp)
80105dbf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dc2:	d9 98 8c 00 00 00    	fstps  0x8c(%eax)
    p->size_ratio = sRatio;
80105dc8:	db 45 18             	fildl  0x18(%ebp)
80105dcb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dce:	d9 98 98 00 00 00    	fstps  0x98(%eax)

    release(&ptable.lock);
80105dd4:	83 ec 0c             	sub    $0xc,%esp
80105dd7:	68 80 3d 11 80       	push   $0x80113d80
80105ddc:	e8 ba 02 00 00       	call   8010609b <release>
80105de1:	83 c4 10             	add    $0x10,%esp
    return 0;
80105de4:	b8 00 00 00 00       	mov    $0x0,%eax
  }
}
80105de9:	c9                   	leave  
80105dea:	c3                   	ret    

80105deb <change_global_bjf>:

int change_global_bjf(int pRatio, int aRatio, int eRatio, int sRatio)
{
80105deb:	55                   	push   %ebp
80105dec:	89 e5                	mov    %esp,%ebp
80105dee:	83 ec 18             	sub    $0x18,%esp
  struct proc *p = 0;
80105df1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)

  acquire(&ptable.lock);
80105df8:	83 ec 0c             	sub    $0xc,%esp
80105dfb:	68 80 3d 11 80       	push   $0x80113d80
80105e00:	e8 28 02 00 00       	call   8010602d <acquire>
80105e05:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105e08:	c7 45 f4 b4 3d 11 80 	movl   $0x80113db4,-0xc(%ebp)
80105e0f:	eb 37                	jmp    80105e48 <change_global_bjf+0x5d>
  {
    p->priority_ratio = pRatio;
80105e11:	db 45 08             	fildl  0x8(%ebp)
80105e14:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e17:	d9 98 84 00 00 00    	fstps  0x84(%eax)
    p->arrivetime_ratio = aRatio;
80105e1d:	db 45 0c             	fildl  0xc(%ebp)
80105e20:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e23:	d9 98 94 00 00 00    	fstps  0x94(%eax)
    p->executed_cycle_ratio = eRatio;
80105e29:	db 45 10             	fildl  0x10(%ebp)
80105e2c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e2f:	d9 98 8c 00 00 00    	fstps  0x8c(%eax)
    p->size_ratio = sRatio;
80105e35:	db 45 14             	fildl  0x14(%ebp)
80105e38:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105e3b:	d9 98 98 00 00 00    	fstps  0x98(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105e41:	81 45 f4 a8 00 00 00 	addl   $0xa8,-0xc(%ebp)
80105e48:	81 7d f4 b4 67 11 80 	cmpl   $0x801167b4,-0xc(%ebp)
80105e4f:	72 c0                	jb     80105e11 <change_global_bjf+0x26>

  }
  release(&ptable.lock);
80105e51:	83 ec 0c             	sub    $0xc,%esp
80105e54:	68 80 3d 11 80       	push   $0x80113d80
80105e59:	e8 3d 02 00 00       	call   8010609b <release>
80105e5e:	83 c4 10             	add    $0x10,%esp

  

  priority_ratio = pRatio;
80105e61:	8b 45 08             	mov    0x8(%ebp),%eax
80105e64:	a3 08 6b 11 80       	mov    %eax,0x80116b08
  arrivetime_ratio = aRatio;
80105e69:	8b 45 0c             	mov    0xc(%ebp),%eax
80105e6c:	a3 0c 6b 11 80       	mov    %eax,0x80116b0c
  executed_cycle_ratio = eRatio;
80105e71:	8b 45 10             	mov    0x10(%ebp),%eax
80105e74:	a3 10 6b 11 80       	mov    %eax,0x80116b10
  size_ratio = sRatio;
80105e79:	8b 45 14             	mov    0x14(%ebp),%eax
80105e7c:	a3 14 6b 11 80       	mov    %eax,0x80116b14
  return 0;
80105e81:	b8 00 00 00 00       	mov    $0x0,%eax
}
80105e86:	c9                   	leave  
80105e87:	c3                   	ret    

80105e88 <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80105e88:	55                   	push   %ebp
80105e89:	89 e5                	mov    %esp,%ebp
80105e8b:	83 ec 08             	sub    $0x8,%esp
  initlock(&lk->lk, "sleep lock");
80105e8e:	8b 45 08             	mov    0x8(%ebp),%eax
80105e91:	83 c0 04             	add    $0x4,%eax
80105e94:	83 ec 08             	sub    $0x8,%esp
80105e97:	68 30 9c 10 80       	push   $0x80109c30
80105e9c:	50                   	push   %eax
80105e9d:	e8 69 01 00 00       	call   8010600b <initlock>
80105ea2:	83 c4 10             	add    $0x10,%esp
  lk->name = name;
80105ea5:	8b 45 08             	mov    0x8(%ebp),%eax
80105ea8:	8b 55 0c             	mov    0xc(%ebp),%edx
80105eab:	89 50 38             	mov    %edx,0x38(%eax)
  lk->locked = 0;
80105eae:	8b 45 08             	mov    0x8(%ebp),%eax
80105eb1:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->pid = 0;
80105eb7:	8b 45 08             	mov    0x8(%ebp),%eax
80105eba:	c7 40 3c 00 00 00 00 	movl   $0x0,0x3c(%eax)
}
80105ec1:	90                   	nop
80105ec2:	c9                   	leave  
80105ec3:	c3                   	ret    

80105ec4 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80105ec4:	55                   	push   %ebp
80105ec5:	89 e5                	mov    %esp,%ebp
80105ec7:	83 ec 08             	sub    $0x8,%esp
  acquire(&lk->lk);
80105eca:	8b 45 08             	mov    0x8(%ebp),%eax
80105ecd:	83 c0 04             	add    $0x4,%eax
80105ed0:	83 ec 0c             	sub    $0xc,%esp
80105ed3:	50                   	push   %eax
80105ed4:	e8 54 01 00 00       	call   8010602d <acquire>
80105ed9:	83 c4 10             	add    $0x10,%esp
  while (lk->locked) {
80105edc:	eb 15                	jmp    80105ef3 <acquiresleep+0x2f>
    sleep(lk, &lk->lk);
80105ede:	8b 45 08             	mov    0x8(%ebp),%eax
80105ee1:	83 c0 04             	add    $0x4,%eax
80105ee4:	83 ec 08             	sub    $0x8,%esp
80105ee7:	50                   	push   %eax
80105ee8:	ff 75 08             	push   0x8(%ebp)
80105eeb:	e8 5c f3 ff ff       	call   8010524c <sleep>
80105ef0:	83 c4 10             	add    $0x10,%esp
  while (lk->locked) {
80105ef3:	8b 45 08             	mov    0x8(%ebp),%eax
80105ef6:	8b 00                	mov    (%eax),%eax
80105ef8:	85 c0                	test   %eax,%eax
80105efa:	75 e2                	jne    80105ede <acquiresleep+0x1a>
  }
  lk->locked = 1;
80105efc:	8b 45 08             	mov    0x8(%ebp),%eax
80105eff:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  lk->pid = myproc()->pid;
80105f05:	e8 0c e4 ff ff       	call   80104316 <myproc>
80105f0a:	8b 50 10             	mov    0x10(%eax),%edx
80105f0d:	8b 45 08             	mov    0x8(%ebp),%eax
80105f10:	89 50 3c             	mov    %edx,0x3c(%eax)
  release(&lk->lk);
80105f13:	8b 45 08             	mov    0x8(%ebp),%eax
80105f16:	83 c0 04             	add    $0x4,%eax
80105f19:	83 ec 0c             	sub    $0xc,%esp
80105f1c:	50                   	push   %eax
80105f1d:	e8 79 01 00 00       	call   8010609b <release>
80105f22:	83 c4 10             	add    $0x10,%esp
}
80105f25:	90                   	nop
80105f26:	c9                   	leave  
80105f27:	c3                   	ret    

80105f28 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80105f28:	55                   	push   %ebp
80105f29:	89 e5                	mov    %esp,%ebp
80105f2b:	83 ec 08             	sub    $0x8,%esp
  acquire(&lk->lk);
80105f2e:	8b 45 08             	mov    0x8(%ebp),%eax
80105f31:	83 c0 04             	add    $0x4,%eax
80105f34:	83 ec 0c             	sub    $0xc,%esp
80105f37:	50                   	push   %eax
80105f38:	e8 f0 00 00 00       	call   8010602d <acquire>
80105f3d:	83 c4 10             	add    $0x10,%esp
  lk->locked = 0;
80105f40:	8b 45 08             	mov    0x8(%ebp),%eax
80105f43:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->pid = 0;
80105f49:	8b 45 08             	mov    0x8(%ebp),%eax
80105f4c:	c7 40 3c 00 00 00 00 	movl   $0x0,0x3c(%eax)
  wakeup(lk);
80105f53:	83 ec 0c             	sub    $0xc,%esp
80105f56:	ff 75 08             	push   0x8(%ebp)
80105f59:	e8 6c f4 ff ff       	call   801053ca <wakeup>
80105f5e:	83 c4 10             	add    $0x10,%esp
  release(&lk->lk);
80105f61:	8b 45 08             	mov    0x8(%ebp),%eax
80105f64:	83 c0 04             	add    $0x4,%eax
80105f67:	83 ec 0c             	sub    $0xc,%esp
80105f6a:	50                   	push   %eax
80105f6b:	e8 2b 01 00 00       	call   8010609b <release>
80105f70:	83 c4 10             	add    $0x10,%esp
}
80105f73:	90                   	nop
80105f74:	c9                   	leave  
80105f75:	c3                   	ret    

80105f76 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80105f76:	55                   	push   %ebp
80105f77:	89 e5                	mov    %esp,%ebp
80105f79:	53                   	push   %ebx
80105f7a:	83 ec 14             	sub    $0x14,%esp
  int r;
  
  acquire(&lk->lk);
80105f7d:	8b 45 08             	mov    0x8(%ebp),%eax
80105f80:	83 c0 04             	add    $0x4,%eax
80105f83:	83 ec 0c             	sub    $0xc,%esp
80105f86:	50                   	push   %eax
80105f87:	e8 a1 00 00 00       	call   8010602d <acquire>
80105f8c:	83 c4 10             	add    $0x10,%esp
  r = lk->locked && (lk->pid == myproc()->pid);
80105f8f:	8b 45 08             	mov    0x8(%ebp),%eax
80105f92:	8b 00                	mov    (%eax),%eax
80105f94:	85 c0                	test   %eax,%eax
80105f96:	74 19                	je     80105fb1 <holdingsleep+0x3b>
80105f98:	8b 45 08             	mov    0x8(%ebp),%eax
80105f9b:	8b 58 3c             	mov    0x3c(%eax),%ebx
80105f9e:	e8 73 e3 ff ff       	call   80104316 <myproc>
80105fa3:	8b 40 10             	mov    0x10(%eax),%eax
80105fa6:	39 c3                	cmp    %eax,%ebx
80105fa8:	75 07                	jne    80105fb1 <holdingsleep+0x3b>
80105faa:	b8 01 00 00 00       	mov    $0x1,%eax
80105faf:	eb 05                	jmp    80105fb6 <holdingsleep+0x40>
80105fb1:	b8 00 00 00 00       	mov    $0x0,%eax
80105fb6:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&lk->lk);
80105fb9:	8b 45 08             	mov    0x8(%ebp),%eax
80105fbc:	83 c0 04             	add    $0x4,%eax
80105fbf:	83 ec 0c             	sub    $0xc,%esp
80105fc2:	50                   	push   %eax
80105fc3:	e8 d3 00 00 00       	call   8010609b <release>
80105fc8:	83 c4 10             	add    $0x10,%esp
  return r;
80105fcb:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80105fce:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105fd1:	c9                   	leave  
80105fd2:	c3                   	ret    

80105fd3 <readeflags>:
{
80105fd3:	55                   	push   %ebp
80105fd4:	89 e5                	mov    %esp,%ebp
80105fd6:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105fd9:	9c                   	pushf  
80105fda:	58                   	pop    %eax
80105fdb:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80105fde:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105fe1:	c9                   	leave  
80105fe2:	c3                   	ret    

80105fe3 <cli>:
{
80105fe3:	55                   	push   %ebp
80105fe4:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80105fe6:	fa                   	cli    
}
80105fe7:	90                   	nop
80105fe8:	5d                   	pop    %ebp
80105fe9:	c3                   	ret    

80105fea <sti>:
{
80105fea:	55                   	push   %ebp
80105feb:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80105fed:	fb                   	sti    
}
80105fee:	90                   	nop
80105fef:	5d                   	pop    %ebp
80105ff0:	c3                   	ret    

80105ff1 <xchg>:
{
80105ff1:	55                   	push   %ebp
80105ff2:	89 e5                	mov    %esp,%ebp
80105ff4:	83 ec 10             	sub    $0x10,%esp
  asm volatile("lock; xchgl %0, %1" :
80105ff7:	8b 55 08             	mov    0x8(%ebp),%edx
80105ffa:	8b 45 0c             	mov    0xc(%ebp),%eax
80105ffd:	8b 4d 08             	mov    0x8(%ebp),%ecx
80106000:	f0 87 02             	lock xchg %eax,(%edx)
80106003:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return result;
80106006:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80106009:	c9                   	leave  
8010600a:	c3                   	ret    

8010600b <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
8010600b:	55                   	push   %ebp
8010600c:	89 e5                	mov    %esp,%ebp
  lk->name = name;
8010600e:	8b 45 08             	mov    0x8(%ebp),%eax
80106011:	8b 55 0c             	mov    0xc(%ebp),%edx
80106014:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80106017:	8b 45 08             	mov    0x8(%ebp),%eax
8010601a:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80106020:	8b 45 08             	mov    0x8(%ebp),%eax
80106023:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
8010602a:	90                   	nop
8010602b:	5d                   	pop    %ebp
8010602c:	c3                   	ret    

8010602d <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
8010602d:	55                   	push   %ebp
8010602e:	89 e5                	mov    %esp,%ebp
80106030:	53                   	push   %ebx
80106031:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80106034:	e8 6f 01 00 00       	call   801061a8 <pushcli>
  if(holding(lk))
80106039:	8b 45 08             	mov    0x8(%ebp),%eax
8010603c:	83 ec 0c             	sub    $0xc,%esp
8010603f:	50                   	push   %eax
80106040:	e8 23 01 00 00       	call   80106168 <holding>
80106045:	83 c4 10             	add    $0x10,%esp
80106048:	85 c0                	test   %eax,%eax
8010604a:	74 0d                	je     80106059 <acquire+0x2c>
    panic("acquire");
8010604c:	83 ec 0c             	sub    $0xc,%esp
8010604f:	68 3b 9c 10 80       	push   $0x80109c3b
80106054:	e8 5c a5 ff ff       	call   801005b5 <panic>

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80106059:	90                   	nop
8010605a:	8b 45 08             	mov    0x8(%ebp),%eax
8010605d:	83 ec 08             	sub    $0x8,%esp
80106060:	6a 01                	push   $0x1
80106062:	50                   	push   %eax
80106063:	e8 89 ff ff ff       	call   80105ff1 <xchg>
80106068:	83 c4 10             	add    $0x10,%esp
8010606b:	85 c0                	test   %eax,%eax
8010606d:	75 eb                	jne    8010605a <acquire+0x2d>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
8010606f:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80106074:	8b 5d 08             	mov    0x8(%ebp),%ebx
80106077:	e8 22 e2 ff ff       	call   8010429e <mycpu>
8010607c:	89 43 08             	mov    %eax,0x8(%ebx)
  getcallerpcs(&lk, lk->pcs);
8010607f:	8b 45 08             	mov    0x8(%ebp),%eax
80106082:	83 c0 0c             	add    $0xc,%eax
80106085:	83 ec 08             	sub    $0x8,%esp
80106088:	50                   	push   %eax
80106089:	8d 45 08             	lea    0x8(%ebp),%eax
8010608c:	50                   	push   %eax
8010608d:	e8 5b 00 00 00       	call   801060ed <getcallerpcs>
80106092:	83 c4 10             	add    $0x10,%esp
}
80106095:	90                   	nop
80106096:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106099:	c9                   	leave  
8010609a:	c3                   	ret    

8010609b <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
8010609b:	55                   	push   %ebp
8010609c:	89 e5                	mov    %esp,%ebp
8010609e:	83 ec 08             	sub    $0x8,%esp
  if(!holding(lk))
801060a1:	83 ec 0c             	sub    $0xc,%esp
801060a4:	ff 75 08             	push   0x8(%ebp)
801060a7:	e8 bc 00 00 00       	call   80106168 <holding>
801060ac:	83 c4 10             	add    $0x10,%esp
801060af:	85 c0                	test   %eax,%eax
801060b1:	75 0d                	jne    801060c0 <release+0x25>
    panic("release");
801060b3:	83 ec 0c             	sub    $0xc,%esp
801060b6:	68 43 9c 10 80       	push   $0x80109c43
801060bb:	e8 f5 a4 ff ff       	call   801005b5 <panic>

  lk->pcs[0] = 0;
801060c0:	8b 45 08             	mov    0x8(%ebp),%eax
801060c3:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
801060ca:	8b 45 08             	mov    0x8(%ebp),%eax
801060cd:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
801060d4:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
801060d9:	8b 45 08             	mov    0x8(%ebp),%eax
801060dc:	8b 55 08             	mov    0x8(%ebp),%edx
801060df:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  popcli();
801060e5:	e8 0b 01 00 00       	call   801061f5 <popcli>
}
801060ea:	90                   	nop
801060eb:	c9                   	leave  
801060ec:	c3                   	ret    

801060ed <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
801060ed:	55                   	push   %ebp
801060ee:	89 e5                	mov    %esp,%ebp
801060f0:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
801060f3:	8b 45 08             	mov    0x8(%ebp),%eax
801060f6:	83 e8 08             	sub    $0x8,%eax
801060f9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
801060fc:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80106103:	eb 38                	jmp    8010613d <getcallerpcs+0x50>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80106105:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
80106109:	74 53                	je     8010615e <getcallerpcs+0x71>
8010610b:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
80106112:	76 4a                	jbe    8010615e <getcallerpcs+0x71>
80106114:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
80106118:	74 44                	je     8010615e <getcallerpcs+0x71>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010611a:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010611d:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80106124:	8b 45 0c             	mov    0xc(%ebp),%eax
80106127:	01 c2                	add    %eax,%edx
80106129:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010612c:	8b 40 04             	mov    0x4(%eax),%eax
8010612f:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
80106131:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106134:	8b 00                	mov    (%eax),%eax
80106136:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
80106139:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
8010613d:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80106141:	7e c2                	jle    80106105 <getcallerpcs+0x18>
  }
  for(; i < 10; i++)
80106143:	eb 19                	jmp    8010615e <getcallerpcs+0x71>
    pcs[i] = 0;
80106145:	8b 45 f8             	mov    -0x8(%ebp),%eax
80106148:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010614f:	8b 45 0c             	mov    0xc(%ebp),%eax
80106152:	01 d0                	add    %edx,%eax
80106154:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
8010615a:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
8010615e:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
80106162:	7e e1                	jle    80106145 <getcallerpcs+0x58>
}
80106164:	90                   	nop
80106165:	90                   	nop
80106166:	c9                   	leave  
80106167:	c3                   	ret    

80106168 <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
80106168:	55                   	push   %ebp
80106169:	89 e5                	mov    %esp,%ebp
8010616b:	53                   	push   %ebx
8010616c:	83 ec 14             	sub    $0x14,%esp
  int r;
  pushcli();
8010616f:	e8 34 00 00 00       	call   801061a8 <pushcli>
  r = lock->locked && lock->cpu == mycpu();
80106174:	8b 45 08             	mov    0x8(%ebp),%eax
80106177:	8b 00                	mov    (%eax),%eax
80106179:	85 c0                	test   %eax,%eax
8010617b:	74 16                	je     80106193 <holding+0x2b>
8010617d:	8b 45 08             	mov    0x8(%ebp),%eax
80106180:	8b 58 08             	mov    0x8(%eax),%ebx
80106183:	e8 16 e1 ff ff       	call   8010429e <mycpu>
80106188:	39 c3                	cmp    %eax,%ebx
8010618a:	75 07                	jne    80106193 <holding+0x2b>
8010618c:	b8 01 00 00 00       	mov    $0x1,%eax
80106191:	eb 05                	jmp    80106198 <holding+0x30>
80106193:	b8 00 00 00 00       	mov    $0x0,%eax
80106198:	89 45 f4             	mov    %eax,-0xc(%ebp)
  popcli();
8010619b:	e8 55 00 00 00       	call   801061f5 <popcli>
  return r;
801061a0:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
801061a3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801061a6:	c9                   	leave  
801061a7:	c3                   	ret    

801061a8 <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
801061a8:	55                   	push   %ebp
801061a9:	89 e5                	mov    %esp,%ebp
801061ab:	83 ec 18             	sub    $0x18,%esp
  int eflags;

  eflags = readeflags();
801061ae:	e8 20 fe ff ff       	call   80105fd3 <readeflags>
801061b3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cli();
801061b6:	e8 28 fe ff ff       	call   80105fe3 <cli>
  if(mycpu()->ncli == 0)
801061bb:	e8 de e0 ff ff       	call   8010429e <mycpu>
801061c0:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801061c6:	85 c0                	test   %eax,%eax
801061c8:	75 14                	jne    801061de <pushcli+0x36>
    mycpu()->intena = eflags & FL_IF;
801061ca:	e8 cf e0 ff ff       	call   8010429e <mycpu>
801061cf:	8b 55 f4             	mov    -0xc(%ebp),%edx
801061d2:	81 e2 00 02 00 00    	and    $0x200,%edx
801061d8:	89 90 a8 00 00 00    	mov    %edx,0xa8(%eax)
  mycpu()->ncli += 1;
801061de:	e8 bb e0 ff ff       	call   8010429e <mycpu>
801061e3:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801061e9:	83 c2 01             	add    $0x1,%edx
801061ec:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
}
801061f2:	90                   	nop
801061f3:	c9                   	leave  
801061f4:	c3                   	ret    

801061f5 <popcli>:

void
popcli(void)
{
801061f5:	55                   	push   %ebp
801061f6:	89 e5                	mov    %esp,%ebp
801061f8:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
801061fb:	e8 d3 fd ff ff       	call   80105fd3 <readeflags>
80106200:	25 00 02 00 00       	and    $0x200,%eax
80106205:	85 c0                	test   %eax,%eax
80106207:	74 0d                	je     80106216 <popcli+0x21>
    panic("popcli - interruptible");
80106209:	83 ec 0c             	sub    $0xc,%esp
8010620c:	68 4b 9c 10 80       	push   $0x80109c4b
80106211:	e8 9f a3 ff ff       	call   801005b5 <panic>
  if(--mycpu()->ncli < 0)
80106216:	e8 83 e0 ff ff       	call   8010429e <mycpu>
8010621b:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
80106221:	83 ea 01             	sub    $0x1,%edx
80106224:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
8010622a:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80106230:	85 c0                	test   %eax,%eax
80106232:	79 0d                	jns    80106241 <popcli+0x4c>
    panic("popcli");
80106234:	83 ec 0c             	sub    $0xc,%esp
80106237:	68 62 9c 10 80       	push   $0x80109c62
8010623c:	e8 74 a3 ff ff       	call   801005b5 <panic>
  if(mycpu()->ncli == 0 && mycpu()->intena)
80106241:	e8 58 e0 ff ff       	call   8010429e <mycpu>
80106246:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
8010624c:	85 c0                	test   %eax,%eax
8010624e:	75 14                	jne    80106264 <popcli+0x6f>
80106250:	e8 49 e0 ff ff       	call   8010429e <mycpu>
80106255:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
8010625b:	85 c0                	test   %eax,%eax
8010625d:	74 05                	je     80106264 <popcli+0x6f>
    sti();
8010625f:	e8 86 fd ff ff       	call   80105fea <sti>
}
80106264:	90                   	nop
80106265:	c9                   	leave  
80106266:	c3                   	ret    

80106267 <stosb>:
{
80106267:	55                   	push   %ebp
80106268:	89 e5                	mov    %esp,%ebp
8010626a:	57                   	push   %edi
8010626b:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
8010626c:	8b 4d 08             	mov    0x8(%ebp),%ecx
8010626f:	8b 55 10             	mov    0x10(%ebp),%edx
80106272:	8b 45 0c             	mov    0xc(%ebp),%eax
80106275:	89 cb                	mov    %ecx,%ebx
80106277:	89 df                	mov    %ebx,%edi
80106279:	89 d1                	mov    %edx,%ecx
8010627b:	fc                   	cld    
8010627c:	f3 aa                	rep stos %al,%es:(%edi)
8010627e:	89 ca                	mov    %ecx,%edx
80106280:	89 fb                	mov    %edi,%ebx
80106282:	89 5d 08             	mov    %ebx,0x8(%ebp)
80106285:	89 55 10             	mov    %edx,0x10(%ebp)
}
80106288:	90                   	nop
80106289:	5b                   	pop    %ebx
8010628a:	5f                   	pop    %edi
8010628b:	5d                   	pop    %ebp
8010628c:	c3                   	ret    

8010628d <stosl>:
{
8010628d:	55                   	push   %ebp
8010628e:	89 e5                	mov    %esp,%ebp
80106290:	57                   	push   %edi
80106291:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
80106292:	8b 4d 08             	mov    0x8(%ebp),%ecx
80106295:	8b 55 10             	mov    0x10(%ebp),%edx
80106298:	8b 45 0c             	mov    0xc(%ebp),%eax
8010629b:	89 cb                	mov    %ecx,%ebx
8010629d:	89 df                	mov    %ebx,%edi
8010629f:	89 d1                	mov    %edx,%ecx
801062a1:	fc                   	cld    
801062a2:	f3 ab                	rep stos %eax,%es:(%edi)
801062a4:	89 ca                	mov    %ecx,%edx
801062a6:	89 fb                	mov    %edi,%ebx
801062a8:	89 5d 08             	mov    %ebx,0x8(%ebp)
801062ab:	89 55 10             	mov    %edx,0x10(%ebp)
}
801062ae:	90                   	nop
801062af:	5b                   	pop    %ebx
801062b0:	5f                   	pop    %edi
801062b1:	5d                   	pop    %ebp
801062b2:	c3                   	ret    

801062b3 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
801062b3:	55                   	push   %ebp
801062b4:	89 e5                	mov    %esp,%ebp
  if ((int)dst%4 == 0 && n%4 == 0){
801062b6:	8b 45 08             	mov    0x8(%ebp),%eax
801062b9:	83 e0 03             	and    $0x3,%eax
801062bc:	85 c0                	test   %eax,%eax
801062be:	75 43                	jne    80106303 <memset+0x50>
801062c0:	8b 45 10             	mov    0x10(%ebp),%eax
801062c3:	83 e0 03             	and    $0x3,%eax
801062c6:	85 c0                	test   %eax,%eax
801062c8:	75 39                	jne    80106303 <memset+0x50>
    c &= 0xFF;
801062ca:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
801062d1:	8b 45 10             	mov    0x10(%ebp),%eax
801062d4:	c1 e8 02             	shr    $0x2,%eax
801062d7:	89 c2                	mov    %eax,%edx
801062d9:	8b 45 0c             	mov    0xc(%ebp),%eax
801062dc:	c1 e0 18             	shl    $0x18,%eax
801062df:	89 c1                	mov    %eax,%ecx
801062e1:	8b 45 0c             	mov    0xc(%ebp),%eax
801062e4:	c1 e0 10             	shl    $0x10,%eax
801062e7:	09 c1                	or     %eax,%ecx
801062e9:	8b 45 0c             	mov    0xc(%ebp),%eax
801062ec:	c1 e0 08             	shl    $0x8,%eax
801062ef:	09 c8                	or     %ecx,%eax
801062f1:	0b 45 0c             	or     0xc(%ebp),%eax
801062f4:	52                   	push   %edx
801062f5:	50                   	push   %eax
801062f6:	ff 75 08             	push   0x8(%ebp)
801062f9:	e8 8f ff ff ff       	call   8010628d <stosl>
801062fe:	83 c4 0c             	add    $0xc,%esp
80106301:	eb 12                	jmp    80106315 <memset+0x62>
  } else
    stosb(dst, c, n);
80106303:	8b 45 10             	mov    0x10(%ebp),%eax
80106306:	50                   	push   %eax
80106307:	ff 75 0c             	push   0xc(%ebp)
8010630a:	ff 75 08             	push   0x8(%ebp)
8010630d:	e8 55 ff ff ff       	call   80106267 <stosb>
80106312:	83 c4 0c             	add    $0xc,%esp
  return dst;
80106315:	8b 45 08             	mov    0x8(%ebp),%eax
}
80106318:	c9                   	leave  
80106319:	c3                   	ret    

8010631a <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
8010631a:	55                   	push   %ebp
8010631b:	89 e5                	mov    %esp,%ebp
8010631d:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;

  s1 = v1;
80106320:	8b 45 08             	mov    0x8(%ebp),%eax
80106323:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
80106326:	8b 45 0c             	mov    0xc(%ebp),%eax
80106329:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
8010632c:	eb 30                	jmp    8010635e <memcmp+0x44>
    if(*s1 != *s2)
8010632e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106331:	0f b6 10             	movzbl (%eax),%edx
80106334:	8b 45 f8             	mov    -0x8(%ebp),%eax
80106337:	0f b6 00             	movzbl (%eax),%eax
8010633a:	38 c2                	cmp    %al,%dl
8010633c:	74 18                	je     80106356 <memcmp+0x3c>
      return *s1 - *s2;
8010633e:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106341:	0f b6 00             	movzbl (%eax),%eax
80106344:	0f b6 d0             	movzbl %al,%edx
80106347:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010634a:	0f b6 00             	movzbl (%eax),%eax
8010634d:	0f b6 c8             	movzbl %al,%ecx
80106350:	89 d0                	mov    %edx,%eax
80106352:	29 c8                	sub    %ecx,%eax
80106354:	eb 1a                	jmp    80106370 <memcmp+0x56>
    s1++, s2++;
80106356:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
8010635a:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  while(n-- > 0){
8010635e:	8b 45 10             	mov    0x10(%ebp),%eax
80106361:	8d 50 ff             	lea    -0x1(%eax),%edx
80106364:	89 55 10             	mov    %edx,0x10(%ebp)
80106367:	85 c0                	test   %eax,%eax
80106369:	75 c3                	jne    8010632e <memcmp+0x14>
  }

  return 0;
8010636b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106370:	c9                   	leave  
80106371:	c3                   	ret    

80106372 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
80106372:	55                   	push   %ebp
80106373:	89 e5                	mov    %esp,%ebp
80106375:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
80106378:	8b 45 0c             	mov    0xc(%ebp),%eax
8010637b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
8010637e:	8b 45 08             	mov    0x8(%ebp),%eax
80106381:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
80106384:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106387:	3b 45 f8             	cmp    -0x8(%ebp),%eax
8010638a:	73 54                	jae    801063e0 <memmove+0x6e>
8010638c:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010638f:	8b 45 10             	mov    0x10(%ebp),%eax
80106392:	01 d0                	add    %edx,%eax
80106394:	39 45 f8             	cmp    %eax,-0x8(%ebp)
80106397:	73 47                	jae    801063e0 <memmove+0x6e>
    s += n;
80106399:	8b 45 10             	mov    0x10(%ebp),%eax
8010639c:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
8010639f:	8b 45 10             	mov    0x10(%ebp),%eax
801063a2:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
801063a5:	eb 13                	jmp    801063ba <memmove+0x48>
      *--d = *--s;
801063a7:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
801063ab:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
801063af:	8b 45 fc             	mov    -0x4(%ebp),%eax
801063b2:	0f b6 10             	movzbl (%eax),%edx
801063b5:	8b 45 f8             	mov    -0x8(%ebp),%eax
801063b8:	88 10                	mov    %dl,(%eax)
    while(n-- > 0)
801063ba:	8b 45 10             	mov    0x10(%ebp),%eax
801063bd:	8d 50 ff             	lea    -0x1(%eax),%edx
801063c0:	89 55 10             	mov    %edx,0x10(%ebp)
801063c3:	85 c0                	test   %eax,%eax
801063c5:	75 e0                	jne    801063a7 <memmove+0x35>
  if(s < d && s + n > d){
801063c7:	eb 24                	jmp    801063ed <memmove+0x7b>
  } else
    while(n-- > 0)
      *d++ = *s++;
801063c9:	8b 55 fc             	mov    -0x4(%ebp),%edx
801063cc:	8d 42 01             	lea    0x1(%edx),%eax
801063cf:	89 45 fc             	mov    %eax,-0x4(%ebp)
801063d2:	8b 45 f8             	mov    -0x8(%ebp),%eax
801063d5:	8d 48 01             	lea    0x1(%eax),%ecx
801063d8:	89 4d f8             	mov    %ecx,-0x8(%ebp)
801063db:	0f b6 12             	movzbl (%edx),%edx
801063de:	88 10                	mov    %dl,(%eax)
    while(n-- > 0)
801063e0:	8b 45 10             	mov    0x10(%ebp),%eax
801063e3:	8d 50 ff             	lea    -0x1(%eax),%edx
801063e6:	89 55 10             	mov    %edx,0x10(%ebp)
801063e9:	85 c0                	test   %eax,%eax
801063eb:	75 dc                	jne    801063c9 <memmove+0x57>

  return dst;
801063ed:	8b 45 08             	mov    0x8(%ebp),%eax
}
801063f0:	c9                   	leave  
801063f1:	c3                   	ret    

801063f2 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
801063f2:	55                   	push   %ebp
801063f3:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
801063f5:	ff 75 10             	push   0x10(%ebp)
801063f8:	ff 75 0c             	push   0xc(%ebp)
801063fb:	ff 75 08             	push   0x8(%ebp)
801063fe:	e8 6f ff ff ff       	call   80106372 <memmove>
80106403:	83 c4 0c             	add    $0xc,%esp
}
80106406:	c9                   	leave  
80106407:	c3                   	ret    

80106408 <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
80106408:	55                   	push   %ebp
80106409:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
8010640b:	eb 0c                	jmp    80106419 <strncmp+0x11>
    n--, p++, q++;
8010640d:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80106411:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80106415:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(n > 0 && *p && *p == *q)
80106419:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010641d:	74 1a                	je     80106439 <strncmp+0x31>
8010641f:	8b 45 08             	mov    0x8(%ebp),%eax
80106422:	0f b6 00             	movzbl (%eax),%eax
80106425:	84 c0                	test   %al,%al
80106427:	74 10                	je     80106439 <strncmp+0x31>
80106429:	8b 45 08             	mov    0x8(%ebp),%eax
8010642c:	0f b6 10             	movzbl (%eax),%edx
8010642f:	8b 45 0c             	mov    0xc(%ebp),%eax
80106432:	0f b6 00             	movzbl (%eax),%eax
80106435:	38 c2                	cmp    %al,%dl
80106437:	74 d4                	je     8010640d <strncmp+0x5>
  if(n == 0)
80106439:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010643d:	75 07                	jne    80106446 <strncmp+0x3e>
    return 0;
8010643f:	b8 00 00 00 00       	mov    $0x0,%eax
80106444:	eb 16                	jmp    8010645c <strncmp+0x54>
  return (uchar)*p - (uchar)*q;
80106446:	8b 45 08             	mov    0x8(%ebp),%eax
80106449:	0f b6 00             	movzbl (%eax),%eax
8010644c:	0f b6 d0             	movzbl %al,%edx
8010644f:	8b 45 0c             	mov    0xc(%ebp),%eax
80106452:	0f b6 00             	movzbl (%eax),%eax
80106455:	0f b6 c8             	movzbl %al,%ecx
80106458:	89 d0                	mov    %edx,%eax
8010645a:	29 c8                	sub    %ecx,%eax
}
8010645c:	5d                   	pop    %ebp
8010645d:	c3                   	ret    

8010645e <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
8010645e:	55                   	push   %ebp
8010645f:	89 e5                	mov    %esp,%ebp
80106461:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
80106464:	8b 45 08             	mov    0x8(%ebp),%eax
80106467:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
8010646a:	90                   	nop
8010646b:	8b 45 10             	mov    0x10(%ebp),%eax
8010646e:	8d 50 ff             	lea    -0x1(%eax),%edx
80106471:	89 55 10             	mov    %edx,0x10(%ebp)
80106474:	85 c0                	test   %eax,%eax
80106476:	7e 2c                	jle    801064a4 <strncpy+0x46>
80106478:	8b 55 0c             	mov    0xc(%ebp),%edx
8010647b:	8d 42 01             	lea    0x1(%edx),%eax
8010647e:	89 45 0c             	mov    %eax,0xc(%ebp)
80106481:	8b 45 08             	mov    0x8(%ebp),%eax
80106484:	8d 48 01             	lea    0x1(%eax),%ecx
80106487:	89 4d 08             	mov    %ecx,0x8(%ebp)
8010648a:	0f b6 12             	movzbl (%edx),%edx
8010648d:	88 10                	mov    %dl,(%eax)
8010648f:	0f b6 00             	movzbl (%eax),%eax
80106492:	84 c0                	test   %al,%al
80106494:	75 d5                	jne    8010646b <strncpy+0xd>
    ;
  while(n-- > 0)
80106496:	eb 0c                	jmp    801064a4 <strncpy+0x46>
    *s++ = 0;
80106498:	8b 45 08             	mov    0x8(%ebp),%eax
8010649b:	8d 50 01             	lea    0x1(%eax),%edx
8010649e:	89 55 08             	mov    %edx,0x8(%ebp)
801064a1:	c6 00 00             	movb   $0x0,(%eax)
  while(n-- > 0)
801064a4:	8b 45 10             	mov    0x10(%ebp),%eax
801064a7:	8d 50 ff             	lea    -0x1(%eax),%edx
801064aa:	89 55 10             	mov    %edx,0x10(%ebp)
801064ad:	85 c0                	test   %eax,%eax
801064af:	7f e7                	jg     80106498 <strncpy+0x3a>
  return os;
801064b1:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801064b4:	c9                   	leave  
801064b5:	c3                   	ret    

801064b6 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
801064b6:	55                   	push   %ebp
801064b7:	89 e5                	mov    %esp,%ebp
801064b9:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
801064bc:	8b 45 08             	mov    0x8(%ebp),%eax
801064bf:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
801064c2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801064c6:	7f 05                	jg     801064cd <safestrcpy+0x17>
    return os;
801064c8:	8b 45 fc             	mov    -0x4(%ebp),%eax
801064cb:	eb 32                	jmp    801064ff <safestrcpy+0x49>
  while(--n > 0 && (*s++ = *t++) != 0)
801064cd:	90                   	nop
801064ce:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
801064d2:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801064d6:	7e 1e                	jle    801064f6 <safestrcpy+0x40>
801064d8:	8b 55 0c             	mov    0xc(%ebp),%edx
801064db:	8d 42 01             	lea    0x1(%edx),%eax
801064de:	89 45 0c             	mov    %eax,0xc(%ebp)
801064e1:	8b 45 08             	mov    0x8(%ebp),%eax
801064e4:	8d 48 01             	lea    0x1(%eax),%ecx
801064e7:	89 4d 08             	mov    %ecx,0x8(%ebp)
801064ea:	0f b6 12             	movzbl (%edx),%edx
801064ed:	88 10                	mov    %dl,(%eax)
801064ef:	0f b6 00             	movzbl (%eax),%eax
801064f2:	84 c0                	test   %al,%al
801064f4:	75 d8                	jne    801064ce <safestrcpy+0x18>
    ;
  *s = 0;
801064f6:	8b 45 08             	mov    0x8(%ebp),%eax
801064f9:	c6 00 00             	movb   $0x0,(%eax)
  return os;
801064fc:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801064ff:	c9                   	leave  
80106500:	c3                   	ret    

80106501 <strlen>:

int
strlen(const char *s)
{
80106501:	55                   	push   %ebp
80106502:	89 e5                	mov    %esp,%ebp
80106504:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
80106507:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
8010650e:	eb 04                	jmp    80106514 <strlen+0x13>
80106510:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80106514:	8b 55 fc             	mov    -0x4(%ebp),%edx
80106517:	8b 45 08             	mov    0x8(%ebp),%eax
8010651a:	01 d0                	add    %edx,%eax
8010651c:	0f b6 00             	movzbl (%eax),%eax
8010651f:	84 c0                	test   %al,%al
80106521:	75 ed                	jne    80106510 <strlen+0xf>
    ;
  return n;
80106523:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80106526:	c9                   	leave  
80106527:	c3                   	ret    

80106528 <swtch>:
80106528:	8b 44 24 04          	mov    0x4(%esp),%eax
8010652c:	8b 54 24 08          	mov    0x8(%esp),%edx
80106530:	55                   	push   %ebp
80106531:	53                   	push   %ebx
80106532:	56                   	push   %esi
80106533:	57                   	push   %edi
80106534:	89 20                	mov    %esp,(%eax)
80106536:	89 d4                	mov    %edx,%esp
80106538:	5f                   	pop    %edi
80106539:	5e                   	pop    %esi
8010653a:	5b                   	pop    %ebx
8010653b:	5d                   	pop    %ebp
8010653c:	c3                   	ret    

8010653d <fetchint>:
// to a saved program counter, and then the first argument.

// Fetch the int at addr from the current process.
int
fetchint(uint addr, int *ip)
{
8010653d:	55                   	push   %ebp
8010653e:	89 e5                	mov    %esp,%ebp
80106540:	83 ec 18             	sub    $0x18,%esp
  struct proc *curproc = myproc();
80106543:	e8 ce dd ff ff       	call   80104316 <myproc>
80106548:	89 45 f4             	mov    %eax,-0xc(%ebp)

  if(addr >= curproc->sz || addr+4 > curproc->sz)
8010654b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010654e:	8b 00                	mov    (%eax),%eax
80106550:	39 45 08             	cmp    %eax,0x8(%ebp)
80106553:	73 0f                	jae    80106564 <fetchint+0x27>
80106555:	8b 45 08             	mov    0x8(%ebp),%eax
80106558:	8d 50 04             	lea    0x4(%eax),%edx
8010655b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010655e:	8b 00                	mov    (%eax),%eax
80106560:	39 c2                	cmp    %eax,%edx
80106562:	76 07                	jbe    8010656b <fetchint+0x2e>
    return -1;
80106564:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106569:	eb 0f                	jmp    8010657a <fetchint+0x3d>
  *ip = *(int*)(addr);
8010656b:	8b 45 08             	mov    0x8(%ebp),%eax
8010656e:	8b 10                	mov    (%eax),%edx
80106570:	8b 45 0c             	mov    0xc(%ebp),%eax
80106573:	89 10                	mov    %edx,(%eax)
  return 0;
80106575:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010657a:	c9                   	leave  
8010657b:	c3                   	ret    

8010657c <fetchstr>:
// Fetch the nul-terminated string at addr from the current process.
// Doesn't actually copy the string - just sets *pp to point at it.
// Returns length of string, not including nul.
int
fetchstr(uint addr, char **pp)
{
8010657c:	55                   	push   %ebp
8010657d:	89 e5                	mov    %esp,%ebp
8010657f:	83 ec 18             	sub    $0x18,%esp
  char *s, *ep;
  struct proc *curproc = myproc();
80106582:	e8 8f dd ff ff       	call   80104316 <myproc>
80106587:	89 45 f0             	mov    %eax,-0x10(%ebp)

  if(addr >= curproc->sz)
8010658a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010658d:	8b 00                	mov    (%eax),%eax
8010658f:	39 45 08             	cmp    %eax,0x8(%ebp)
80106592:	72 07                	jb     8010659b <fetchstr+0x1f>
    return -1;
80106594:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106599:	eb 41                	jmp    801065dc <fetchstr+0x60>
  *pp = (char*)addr;
8010659b:	8b 55 08             	mov    0x8(%ebp),%edx
8010659e:	8b 45 0c             	mov    0xc(%ebp),%eax
801065a1:	89 10                	mov    %edx,(%eax)
  ep = (char*)curproc->sz;
801065a3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801065a6:	8b 00                	mov    (%eax),%eax
801065a8:	89 45 ec             	mov    %eax,-0x14(%ebp)
  for(s = *pp; s < ep; s++){
801065ab:	8b 45 0c             	mov    0xc(%ebp),%eax
801065ae:	8b 00                	mov    (%eax),%eax
801065b0:	89 45 f4             	mov    %eax,-0xc(%ebp)
801065b3:	eb 1a                	jmp    801065cf <fetchstr+0x53>
    if(*s == 0)
801065b5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065b8:	0f b6 00             	movzbl (%eax),%eax
801065bb:	84 c0                	test   %al,%al
801065bd:	75 0c                	jne    801065cb <fetchstr+0x4f>
      return s - *pp;
801065bf:	8b 45 0c             	mov    0xc(%ebp),%eax
801065c2:	8b 10                	mov    (%eax),%edx
801065c4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065c7:	29 d0                	sub    %edx,%eax
801065c9:	eb 11                	jmp    801065dc <fetchstr+0x60>
  for(s = *pp; s < ep; s++){
801065cb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801065cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065d2:	3b 45 ec             	cmp    -0x14(%ebp),%eax
801065d5:	72 de                	jb     801065b5 <fetchstr+0x39>
  }
  return -1;
801065d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801065dc:	c9                   	leave  
801065dd:	c3                   	ret    

801065de <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
801065de:	55                   	push   %ebp
801065df:	89 e5                	mov    %esp,%ebp
801065e1:	83 ec 08             	sub    $0x8,%esp
  return fetchint((myproc()->tf->esp) + 4 + 4*n, ip);
801065e4:	e8 2d dd ff ff       	call   80104316 <myproc>
801065e9:	8b 40 18             	mov    0x18(%eax),%eax
801065ec:	8b 50 44             	mov    0x44(%eax),%edx
801065ef:	8b 45 08             	mov    0x8(%ebp),%eax
801065f2:	c1 e0 02             	shl    $0x2,%eax
801065f5:	01 d0                	add    %edx,%eax
801065f7:	83 c0 04             	add    $0x4,%eax
801065fa:	83 ec 08             	sub    $0x8,%esp
801065fd:	ff 75 0c             	push   0xc(%ebp)
80106600:	50                   	push   %eax
80106601:	e8 37 ff ff ff       	call   8010653d <fetchint>
80106606:	83 c4 10             	add    $0x10,%esp
}
80106609:	c9                   	leave  
8010660a:	c3                   	ret    

8010660b <argptr>:
// Fetch the nth word-sized system call argument as a pointer
// to a block of memory of size bytes.  Check that the pointer
// lies within the process address space.
int
argptr(int n, char **pp, int size)
{
8010660b:	55                   	push   %ebp
8010660c:	89 e5                	mov    %esp,%ebp
8010660e:	83 ec 18             	sub    $0x18,%esp
  int i;
  struct proc *curproc = myproc();
80106611:	e8 00 dd ff ff       	call   80104316 <myproc>
80106616:	89 45 f4             	mov    %eax,-0xc(%ebp)
 
  if(argint(n, &i) < 0)
80106619:	83 ec 08             	sub    $0x8,%esp
8010661c:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010661f:	50                   	push   %eax
80106620:	ff 75 08             	push   0x8(%ebp)
80106623:	e8 b6 ff ff ff       	call   801065de <argint>
80106628:	83 c4 10             	add    $0x10,%esp
8010662b:	85 c0                	test   %eax,%eax
8010662d:	79 07                	jns    80106636 <argptr+0x2b>
    return -1;
8010662f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106634:	eb 3b                	jmp    80106671 <argptr+0x66>
  if(size < 0 || (uint)i >= curproc->sz || (uint)i+size > curproc->sz)
80106636:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010663a:	78 1f                	js     8010665b <argptr+0x50>
8010663c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010663f:	8b 00                	mov    (%eax),%eax
80106641:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106644:	39 d0                	cmp    %edx,%eax
80106646:	76 13                	jbe    8010665b <argptr+0x50>
80106648:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010664b:	89 c2                	mov    %eax,%edx
8010664d:	8b 45 10             	mov    0x10(%ebp),%eax
80106650:	01 c2                	add    %eax,%edx
80106652:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106655:	8b 00                	mov    (%eax),%eax
80106657:	39 c2                	cmp    %eax,%edx
80106659:	76 07                	jbe    80106662 <argptr+0x57>
    return -1;
8010665b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106660:	eb 0f                	jmp    80106671 <argptr+0x66>
  *pp = (char*)i;
80106662:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106665:	89 c2                	mov    %eax,%edx
80106667:	8b 45 0c             	mov    0xc(%ebp),%eax
8010666a:	89 10                	mov    %edx,(%eax)
  return 0;
8010666c:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106671:	c9                   	leave  
80106672:	c3                   	ret    

80106673 <argstr>:
// Check that the pointer is valid and the string is nul-terminated.
// (There is no shared writable memory, so the string can't change
// between this check and being used by the kernel.)
int
argstr(int n, char **pp)
{
80106673:	55                   	push   %ebp
80106674:	89 e5                	mov    %esp,%ebp
80106676:	83 ec 18             	sub    $0x18,%esp
  int addr;
  if(argint(n, &addr) < 0)
80106679:	83 ec 08             	sub    $0x8,%esp
8010667c:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010667f:	50                   	push   %eax
80106680:	ff 75 08             	push   0x8(%ebp)
80106683:	e8 56 ff ff ff       	call   801065de <argint>
80106688:	83 c4 10             	add    $0x10,%esp
8010668b:	85 c0                	test   %eax,%eax
8010668d:	79 07                	jns    80106696 <argstr+0x23>
    return -1;
8010668f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106694:	eb 12                	jmp    801066a8 <argstr+0x35>
  return fetchstr(addr, pp);
80106696:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106699:	83 ec 08             	sub    $0x8,%esp
8010669c:	ff 75 0c             	push   0xc(%ebp)
8010669f:	50                   	push   %eax
801066a0:	e8 d7 fe ff ff       	call   8010657c <fetchstr>
801066a5:	83 c4 10             	add    $0x10,%esp
}
801066a8:	c9                   	leave  
801066a9:	c3                   	ret    

801066aa <syscall>:

};

void
syscall(void)
{
801066aa:	55                   	push   %ebp
801066ab:	89 e5                	mov    %esp,%ebp
801066ad:	83 ec 18             	sub    $0x18,%esp
  int num;
  struct proc *curproc = myproc();
801066b0:	e8 61 dc ff ff       	call   80104316 <myproc>
801066b5:	89 45 f4             	mov    %eax,-0xc(%ebp)

  num = curproc->tf->eax;
801066b8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066bb:	8b 40 18             	mov    0x18(%eax),%eax
801066be:	8b 40 1c             	mov    0x1c(%eax),%eax
801066c1:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
801066c4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801066c8:	7e 2f                	jle    801066f9 <syscall+0x4f>
801066ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
801066cd:	83 f8 19             	cmp    $0x19,%eax
801066d0:	77 27                	ja     801066f9 <syscall+0x4f>
801066d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801066d5:	8b 04 85 20 c0 10 80 	mov    -0x7fef3fe0(,%eax,4),%eax
801066dc:	85 c0                	test   %eax,%eax
801066de:	74 19                	je     801066f9 <syscall+0x4f>
    curproc->tf->eax = syscalls[num]();
801066e0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801066e3:	8b 04 85 20 c0 10 80 	mov    -0x7fef3fe0(,%eax,4),%eax
801066ea:	ff d0                	call   *%eax
801066ec:	89 c2                	mov    %eax,%edx
801066ee:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066f1:	8b 40 18             	mov    0x18(%eax),%eax
801066f4:	89 50 1c             	mov    %edx,0x1c(%eax)
801066f7:	eb 2c                	jmp    80106725 <syscall+0x7b>
  } else {
    cprintf("%d %s: unknown sys call %d\n",
            curproc->pid, curproc->name, num);
801066f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801066fc:	8d 50 6c             	lea    0x6c(%eax),%edx
    cprintf("%d %s: unknown sys call %d\n",
801066ff:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106702:	8b 40 10             	mov    0x10(%eax),%eax
80106705:	ff 75 f0             	push   -0x10(%ebp)
80106708:	52                   	push   %edx
80106709:	50                   	push   %eax
8010670a:	68 69 9c 10 80       	push   $0x80109c69
8010670f:	e8 ec 9c ff ff       	call   80100400 <cprintf>
80106714:	83 c4 10             	add    $0x10,%esp
    curproc->tf->eax = -1;
80106717:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010671a:	8b 40 18             	mov    0x18(%eax),%eax
8010671d:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
  }
}
80106724:	90                   	nop
80106725:	90                   	nop
80106726:	c9                   	leave  
80106727:	c3                   	ret    

80106728 <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
80106728:	55                   	push   %ebp
80106729:	89 e5                	mov    %esp,%ebp
8010672b:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
8010672e:	83 ec 08             	sub    $0x8,%esp
80106731:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106734:	50                   	push   %eax
80106735:	ff 75 08             	push   0x8(%ebp)
80106738:	e8 a1 fe ff ff       	call   801065de <argint>
8010673d:	83 c4 10             	add    $0x10,%esp
80106740:	85 c0                	test   %eax,%eax
80106742:	79 07                	jns    8010674b <argfd+0x23>
    return -1;
80106744:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106749:	eb 4f                	jmp    8010679a <argfd+0x72>
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
8010674b:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010674e:	85 c0                	test   %eax,%eax
80106750:	78 20                	js     80106772 <argfd+0x4a>
80106752:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106755:	83 f8 0f             	cmp    $0xf,%eax
80106758:	7f 18                	jg     80106772 <argfd+0x4a>
8010675a:	e8 b7 db ff ff       	call   80104316 <myproc>
8010675f:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106762:	83 c2 08             	add    $0x8,%edx
80106765:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80106769:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010676c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106770:	75 07                	jne    80106779 <argfd+0x51>
    return -1;
80106772:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106777:	eb 21                	jmp    8010679a <argfd+0x72>
  if(pfd)
80106779:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
8010677d:	74 08                	je     80106787 <argfd+0x5f>
    *pfd = fd;
8010677f:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106782:	8b 45 0c             	mov    0xc(%ebp),%eax
80106785:	89 10                	mov    %edx,(%eax)
  if(pf)
80106787:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010678b:	74 08                	je     80106795 <argfd+0x6d>
    *pf = f;
8010678d:	8b 45 10             	mov    0x10(%ebp),%eax
80106790:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106793:	89 10                	mov    %edx,(%eax)
  return 0;
80106795:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010679a:	c9                   	leave  
8010679b:	c3                   	ret    

8010679c <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
8010679c:	55                   	push   %ebp
8010679d:	89 e5                	mov    %esp,%ebp
8010679f:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct proc *curproc = myproc();
801067a2:	e8 6f db ff ff       	call   80104316 <myproc>
801067a7:	89 45 f0             	mov    %eax,-0x10(%ebp)

  for(fd = 0; fd < NOFILE; fd++){
801067aa:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801067b1:	eb 2a                	jmp    801067dd <fdalloc+0x41>
    if(curproc->ofile[fd] == 0){
801067b3:	8b 45 f0             	mov    -0x10(%ebp),%eax
801067b6:	8b 55 f4             	mov    -0xc(%ebp),%edx
801067b9:	83 c2 08             	add    $0x8,%edx
801067bc:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801067c0:	85 c0                	test   %eax,%eax
801067c2:	75 15                	jne    801067d9 <fdalloc+0x3d>
      curproc->ofile[fd] = f;
801067c4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801067c7:	8b 55 f4             	mov    -0xc(%ebp),%edx
801067ca:	8d 4a 08             	lea    0x8(%edx),%ecx
801067cd:	8b 55 08             	mov    0x8(%ebp),%edx
801067d0:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
      return fd;
801067d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067d7:	eb 0f                	jmp    801067e8 <fdalloc+0x4c>
  for(fd = 0; fd < NOFILE; fd++){
801067d9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801067dd:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
801067e1:	7e d0                	jle    801067b3 <fdalloc+0x17>
    }
  }
  return -1;
801067e3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801067e8:	c9                   	leave  
801067e9:	c3                   	ret    

801067ea <sys_dup>:

int
sys_dup(void)
{
801067ea:	55                   	push   %ebp
801067eb:	89 e5                	mov    %esp,%ebp
801067ed:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int fd;

  if(argfd(0, 0, &f) < 0)
801067f0:	83 ec 04             	sub    $0x4,%esp
801067f3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801067f6:	50                   	push   %eax
801067f7:	6a 00                	push   $0x0
801067f9:	6a 00                	push   $0x0
801067fb:	e8 28 ff ff ff       	call   80106728 <argfd>
80106800:	83 c4 10             	add    $0x10,%esp
80106803:	85 c0                	test   %eax,%eax
80106805:	79 07                	jns    8010680e <sys_dup+0x24>
    return -1;
80106807:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010680c:	eb 31                	jmp    8010683f <sys_dup+0x55>
  if((fd=fdalloc(f)) < 0)
8010680e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106811:	83 ec 0c             	sub    $0xc,%esp
80106814:	50                   	push   %eax
80106815:	e8 82 ff ff ff       	call   8010679c <fdalloc>
8010681a:	83 c4 10             	add    $0x10,%esp
8010681d:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106820:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106824:	79 07                	jns    8010682d <sys_dup+0x43>
    return -1;
80106826:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010682b:	eb 12                	jmp    8010683f <sys_dup+0x55>
  filedup(f);
8010682d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106830:	83 ec 0c             	sub    $0xc,%esp
80106833:	50                   	push   %eax
80106834:	e8 54 a8 ff ff       	call   8010108d <filedup>
80106839:	83 c4 10             	add    $0x10,%esp
  return fd;
8010683c:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
8010683f:	c9                   	leave  
80106840:	c3                   	ret    

80106841 <sys_read>:

int
sys_read(void)
{
80106841:	55                   	push   %ebp
80106842:	89 e5                	mov    %esp,%ebp
80106844:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
80106847:	83 ec 04             	sub    $0x4,%esp
8010684a:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010684d:	50                   	push   %eax
8010684e:	6a 00                	push   $0x0
80106850:	6a 00                	push   $0x0
80106852:	e8 d1 fe ff ff       	call   80106728 <argfd>
80106857:	83 c4 10             	add    $0x10,%esp
8010685a:	85 c0                	test   %eax,%eax
8010685c:	78 2e                	js     8010688c <sys_read+0x4b>
8010685e:	83 ec 08             	sub    $0x8,%esp
80106861:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106864:	50                   	push   %eax
80106865:	6a 02                	push   $0x2
80106867:	e8 72 fd ff ff       	call   801065de <argint>
8010686c:	83 c4 10             	add    $0x10,%esp
8010686f:	85 c0                	test   %eax,%eax
80106871:	78 19                	js     8010688c <sys_read+0x4b>
80106873:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106876:	83 ec 04             	sub    $0x4,%esp
80106879:	50                   	push   %eax
8010687a:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010687d:	50                   	push   %eax
8010687e:	6a 01                	push   $0x1
80106880:	e8 86 fd ff ff       	call   8010660b <argptr>
80106885:	83 c4 10             	add    $0x10,%esp
80106888:	85 c0                	test   %eax,%eax
8010688a:	79 07                	jns    80106893 <sys_read+0x52>
    return -1;
8010688c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106891:	eb 17                	jmp    801068aa <sys_read+0x69>
  return fileread(f, p, n);
80106893:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80106896:	8b 55 ec             	mov    -0x14(%ebp),%edx
80106899:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010689c:	83 ec 04             	sub    $0x4,%esp
8010689f:	51                   	push   %ecx
801068a0:	52                   	push   %edx
801068a1:	50                   	push   %eax
801068a2:	e8 76 a9 ff ff       	call   8010121d <fileread>
801068a7:	83 c4 10             	add    $0x10,%esp
}
801068aa:	c9                   	leave  
801068ab:	c3                   	ret    

801068ac <sys_write>:

int
sys_write(void)
{
801068ac:	55                   	push   %ebp
801068ad:	89 e5                	mov    %esp,%ebp
801068af:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  int n;
  char *p;

  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argptr(1, &p, n) < 0)
801068b2:	83 ec 04             	sub    $0x4,%esp
801068b5:	8d 45 f4             	lea    -0xc(%ebp),%eax
801068b8:	50                   	push   %eax
801068b9:	6a 00                	push   $0x0
801068bb:	6a 00                	push   $0x0
801068bd:	e8 66 fe ff ff       	call   80106728 <argfd>
801068c2:	83 c4 10             	add    $0x10,%esp
801068c5:	85 c0                	test   %eax,%eax
801068c7:	78 2e                	js     801068f7 <sys_write+0x4b>
801068c9:	83 ec 08             	sub    $0x8,%esp
801068cc:	8d 45 f0             	lea    -0x10(%ebp),%eax
801068cf:	50                   	push   %eax
801068d0:	6a 02                	push   $0x2
801068d2:	e8 07 fd ff ff       	call   801065de <argint>
801068d7:	83 c4 10             	add    $0x10,%esp
801068da:	85 c0                	test   %eax,%eax
801068dc:	78 19                	js     801068f7 <sys_write+0x4b>
801068de:	8b 45 f0             	mov    -0x10(%ebp),%eax
801068e1:	83 ec 04             	sub    $0x4,%esp
801068e4:	50                   	push   %eax
801068e5:	8d 45 ec             	lea    -0x14(%ebp),%eax
801068e8:	50                   	push   %eax
801068e9:	6a 01                	push   $0x1
801068eb:	e8 1b fd ff ff       	call   8010660b <argptr>
801068f0:	83 c4 10             	add    $0x10,%esp
801068f3:	85 c0                	test   %eax,%eax
801068f5:	79 07                	jns    801068fe <sys_write+0x52>
    return -1;
801068f7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801068fc:	eb 17                	jmp    80106915 <sys_write+0x69>
  return filewrite(f, p, n);
801068fe:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80106901:	8b 55 ec             	mov    -0x14(%ebp),%edx
80106904:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106907:	83 ec 04             	sub    $0x4,%esp
8010690a:	51                   	push   %ecx
8010690b:	52                   	push   %edx
8010690c:	50                   	push   %eax
8010690d:	e8 c3 a9 ff ff       	call   801012d5 <filewrite>
80106912:	83 c4 10             	add    $0x10,%esp
}
80106915:	c9                   	leave  
80106916:	c3                   	ret    

80106917 <sys_close>:

int
sys_close(void)
{
80106917:	55                   	push   %ebp
80106918:	89 e5                	mov    %esp,%ebp
8010691a:	83 ec 18             	sub    $0x18,%esp
  int fd;
  struct file *f;

  if(argfd(0, &fd, &f) < 0)
8010691d:	83 ec 04             	sub    $0x4,%esp
80106920:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106923:	50                   	push   %eax
80106924:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106927:	50                   	push   %eax
80106928:	6a 00                	push   $0x0
8010692a:	e8 f9 fd ff ff       	call   80106728 <argfd>
8010692f:	83 c4 10             	add    $0x10,%esp
80106932:	85 c0                	test   %eax,%eax
80106934:	79 07                	jns    8010693d <sys_close+0x26>
    return -1;
80106936:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010693b:	eb 27                	jmp    80106964 <sys_close+0x4d>
  myproc()->ofile[fd] = 0;
8010693d:	e8 d4 d9 ff ff       	call   80104316 <myproc>
80106942:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106945:	83 c2 08             	add    $0x8,%edx
80106948:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
8010694f:	00 
  fileclose(f);
80106950:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106953:	83 ec 0c             	sub    $0xc,%esp
80106956:	50                   	push   %eax
80106957:	e8 82 a7 ff ff       	call   801010de <fileclose>
8010695c:	83 c4 10             	add    $0x10,%esp
  return 0;
8010695f:	b8 00 00 00 00       	mov    $0x0,%eax
}
80106964:	c9                   	leave  
80106965:	c3                   	ret    

80106966 <sys_fstat>:

int
sys_fstat(void)
{
80106966:	55                   	push   %ebp
80106967:	89 e5                	mov    %esp,%ebp
80106969:	83 ec 18             	sub    $0x18,%esp
  struct file *f;
  struct stat *st;

  if(argfd(0, 0, &f) < 0 || argptr(1, (void*)&st, sizeof(*st)) < 0)
8010696c:	83 ec 04             	sub    $0x4,%esp
8010696f:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106972:	50                   	push   %eax
80106973:	6a 00                	push   $0x0
80106975:	6a 00                	push   $0x0
80106977:	e8 ac fd ff ff       	call   80106728 <argfd>
8010697c:	83 c4 10             	add    $0x10,%esp
8010697f:	85 c0                	test   %eax,%eax
80106981:	78 17                	js     8010699a <sys_fstat+0x34>
80106983:	83 ec 04             	sub    $0x4,%esp
80106986:	6a 14                	push   $0x14
80106988:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010698b:	50                   	push   %eax
8010698c:	6a 01                	push   $0x1
8010698e:	e8 78 fc ff ff       	call   8010660b <argptr>
80106993:	83 c4 10             	add    $0x10,%esp
80106996:	85 c0                	test   %eax,%eax
80106998:	79 07                	jns    801069a1 <sys_fstat+0x3b>
    return -1;
8010699a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010699f:	eb 13                	jmp    801069b4 <sys_fstat+0x4e>
  return filestat(f, st);
801069a1:	8b 55 f0             	mov    -0x10(%ebp),%edx
801069a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069a7:	83 ec 08             	sub    $0x8,%esp
801069aa:	52                   	push   %edx
801069ab:	50                   	push   %eax
801069ac:	e8 15 a8 ff ff       	call   801011c6 <filestat>
801069b1:	83 c4 10             	add    $0x10,%esp
}
801069b4:	c9                   	leave  
801069b5:	c3                   	ret    

801069b6 <sys_link>:

// Create the path new as a link to the same inode as old.
int
sys_link(void)
{
801069b6:	55                   	push   %ebp
801069b7:	89 e5                	mov    %esp,%ebp
801069b9:	83 ec 28             	sub    $0x28,%esp
  char name[DIRSIZ], *new, *old;
  struct inode *dp, *ip;

  if(argstr(0, &old) < 0 || argstr(1, &new) < 0)
801069bc:	83 ec 08             	sub    $0x8,%esp
801069bf:	8d 45 d8             	lea    -0x28(%ebp),%eax
801069c2:	50                   	push   %eax
801069c3:	6a 00                	push   $0x0
801069c5:	e8 a9 fc ff ff       	call   80106673 <argstr>
801069ca:	83 c4 10             	add    $0x10,%esp
801069cd:	85 c0                	test   %eax,%eax
801069cf:	78 15                	js     801069e6 <sys_link+0x30>
801069d1:	83 ec 08             	sub    $0x8,%esp
801069d4:	8d 45 dc             	lea    -0x24(%ebp),%eax
801069d7:	50                   	push   %eax
801069d8:	6a 01                	push   $0x1
801069da:	e8 94 fc ff ff       	call   80106673 <argstr>
801069df:	83 c4 10             	add    $0x10,%esp
801069e2:	85 c0                	test   %eax,%eax
801069e4:	79 0a                	jns    801069f0 <sys_link+0x3a>
    return -1;
801069e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801069eb:	e9 68 01 00 00       	jmp    80106b58 <sys_link+0x1a2>

  begin_op();
801069f0:	e8 3d cb ff ff       	call   80103532 <begin_op>
  if((ip = namei(old)) == 0){
801069f5:	8b 45 d8             	mov    -0x28(%ebp),%eax
801069f8:	83 ec 0c             	sub    $0xc,%esp
801069fb:	50                   	push   %eax
801069fc:	e8 4c bb ff ff       	call   8010254d <namei>
80106a01:	83 c4 10             	add    $0x10,%esp
80106a04:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106a07:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106a0b:	75 0f                	jne    80106a1c <sys_link+0x66>
    end_op();
80106a0d:	e8 ac cb ff ff       	call   801035be <end_op>
    return -1;
80106a12:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a17:	e9 3c 01 00 00       	jmp    80106b58 <sys_link+0x1a2>
  }

  ilock(ip);
80106a1c:	83 ec 0c             	sub    $0xc,%esp
80106a1f:	ff 75 f4             	push   -0xc(%ebp)
80106a22:	e8 f3 af ff ff       	call   80101a1a <ilock>
80106a27:	83 c4 10             	add    $0x10,%esp
  if(ip->type == T_DIR){
80106a2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a2d:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80106a31:	66 83 f8 01          	cmp    $0x1,%ax
80106a35:	75 1d                	jne    80106a54 <sys_link+0x9e>
    iunlockput(ip);
80106a37:	83 ec 0c             	sub    $0xc,%esp
80106a3a:	ff 75 f4             	push   -0xc(%ebp)
80106a3d:	e8 09 b2 ff ff       	call   80101c4b <iunlockput>
80106a42:	83 c4 10             	add    $0x10,%esp
    end_op();
80106a45:	e8 74 cb ff ff       	call   801035be <end_op>
    return -1;
80106a4a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106a4f:	e9 04 01 00 00       	jmp    80106b58 <sys_link+0x1a2>
  }

  ip->nlink++;
80106a54:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a57:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80106a5b:	83 c0 01             	add    $0x1,%eax
80106a5e:	89 c2                	mov    %eax,%edx
80106a60:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a63:	66 89 50 56          	mov    %dx,0x56(%eax)
  iupdate(ip);
80106a67:	83 ec 0c             	sub    $0xc,%esp
80106a6a:	ff 75 f4             	push   -0xc(%ebp)
80106a6d:	e8 cb ad ff ff       	call   8010183d <iupdate>
80106a72:	83 c4 10             	add    $0x10,%esp
  iunlock(ip);
80106a75:	83 ec 0c             	sub    $0xc,%esp
80106a78:	ff 75 f4             	push   -0xc(%ebp)
80106a7b:	e8 ad b0 ff ff       	call   80101b2d <iunlock>
80106a80:	83 c4 10             	add    $0x10,%esp

  if((dp = nameiparent(new, name)) == 0)
80106a83:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106a86:	83 ec 08             	sub    $0x8,%esp
80106a89:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80106a8c:	52                   	push   %edx
80106a8d:	50                   	push   %eax
80106a8e:	e8 d6 ba ff ff       	call   80102569 <nameiparent>
80106a93:	83 c4 10             	add    $0x10,%esp
80106a96:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106a99:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106a9d:	74 71                	je     80106b10 <sys_link+0x15a>
    goto bad;
  ilock(dp);
80106a9f:	83 ec 0c             	sub    $0xc,%esp
80106aa2:	ff 75 f0             	push   -0x10(%ebp)
80106aa5:	e8 70 af ff ff       	call   80101a1a <ilock>
80106aaa:	83 c4 10             	add    $0x10,%esp
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
80106aad:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106ab0:	8b 10                	mov    (%eax),%edx
80106ab2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ab5:	8b 00                	mov    (%eax),%eax
80106ab7:	39 c2                	cmp    %eax,%edx
80106ab9:	75 1d                	jne    80106ad8 <sys_link+0x122>
80106abb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106abe:	8b 40 04             	mov    0x4(%eax),%eax
80106ac1:	83 ec 04             	sub    $0x4,%esp
80106ac4:	50                   	push   %eax
80106ac5:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80106ac8:	50                   	push   %eax
80106ac9:	ff 75 f0             	push   -0x10(%ebp)
80106acc:	e8 e5 b7 ff ff       	call   801022b6 <dirlink>
80106ad1:	83 c4 10             	add    $0x10,%esp
80106ad4:	85 c0                	test   %eax,%eax
80106ad6:	79 10                	jns    80106ae8 <sys_link+0x132>
    iunlockput(dp);
80106ad8:	83 ec 0c             	sub    $0xc,%esp
80106adb:	ff 75 f0             	push   -0x10(%ebp)
80106ade:	e8 68 b1 ff ff       	call   80101c4b <iunlockput>
80106ae3:	83 c4 10             	add    $0x10,%esp
    goto bad;
80106ae6:	eb 29                	jmp    80106b11 <sys_link+0x15b>
  }
  iunlockput(dp);
80106ae8:	83 ec 0c             	sub    $0xc,%esp
80106aeb:	ff 75 f0             	push   -0x10(%ebp)
80106aee:	e8 58 b1 ff ff       	call   80101c4b <iunlockput>
80106af3:	83 c4 10             	add    $0x10,%esp
  iput(ip);
80106af6:	83 ec 0c             	sub    $0xc,%esp
80106af9:	ff 75 f4             	push   -0xc(%ebp)
80106afc:	e8 7a b0 ff ff       	call   80101b7b <iput>
80106b01:	83 c4 10             	add    $0x10,%esp

  end_op();
80106b04:	e8 b5 ca ff ff       	call   801035be <end_op>

  return 0;
80106b09:	b8 00 00 00 00       	mov    $0x0,%eax
80106b0e:	eb 48                	jmp    80106b58 <sys_link+0x1a2>
    goto bad;
80106b10:	90                   	nop

bad:
  ilock(ip);
80106b11:	83 ec 0c             	sub    $0xc,%esp
80106b14:	ff 75 f4             	push   -0xc(%ebp)
80106b17:	e8 fe ae ff ff       	call   80101a1a <ilock>
80106b1c:	83 c4 10             	add    $0x10,%esp
  ip->nlink--;
80106b1f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b22:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80106b26:	83 e8 01             	sub    $0x1,%eax
80106b29:	89 c2                	mov    %eax,%edx
80106b2b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b2e:	66 89 50 56          	mov    %dx,0x56(%eax)
  iupdate(ip);
80106b32:	83 ec 0c             	sub    $0xc,%esp
80106b35:	ff 75 f4             	push   -0xc(%ebp)
80106b38:	e8 00 ad ff ff       	call   8010183d <iupdate>
80106b3d:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80106b40:	83 ec 0c             	sub    $0xc,%esp
80106b43:	ff 75 f4             	push   -0xc(%ebp)
80106b46:	e8 00 b1 ff ff       	call   80101c4b <iunlockput>
80106b4b:	83 c4 10             	add    $0x10,%esp
  end_op();
80106b4e:	e8 6b ca ff ff       	call   801035be <end_op>
  return -1;
80106b53:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106b58:	c9                   	leave  
80106b59:	c3                   	ret    

80106b5a <isdirempty>:

// Is the directory dp empty except for "." and ".." ?
static int
isdirempty(struct inode *dp)
{
80106b5a:	55                   	push   %ebp
80106b5b:	89 e5                	mov    %esp,%ebp
80106b5d:	83 ec 28             	sub    $0x28,%esp
  int off;
  struct dirent de;

  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80106b60:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
80106b67:	eb 40                	jmp    80106ba9 <isdirempty+0x4f>
    if(readi(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106b69:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b6c:	6a 10                	push   $0x10
80106b6e:	50                   	push   %eax
80106b6f:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106b72:	50                   	push   %eax
80106b73:	ff 75 08             	push   0x8(%ebp)
80106b76:	e8 8b b3 ff ff       	call   80101f06 <readi>
80106b7b:	83 c4 10             	add    $0x10,%esp
80106b7e:	83 f8 10             	cmp    $0x10,%eax
80106b81:	74 0d                	je     80106b90 <isdirempty+0x36>
      panic("isdirempty: readi");
80106b83:	83 ec 0c             	sub    $0xc,%esp
80106b86:	68 85 9c 10 80       	push   $0x80109c85
80106b8b:	e8 25 9a ff ff       	call   801005b5 <panic>
    if(de.inum != 0)
80106b90:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80106b94:	66 85 c0             	test   %ax,%ax
80106b97:	74 07                	je     80106ba0 <isdirempty+0x46>
      return 0;
80106b99:	b8 00 00 00 00       	mov    $0x0,%eax
80106b9e:	eb 1b                	jmp    80106bbb <isdirempty+0x61>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
80106ba0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ba3:	83 c0 10             	add    $0x10,%eax
80106ba6:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106ba9:	8b 45 08             	mov    0x8(%ebp),%eax
80106bac:	8b 50 58             	mov    0x58(%eax),%edx
80106baf:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106bb2:	39 c2                	cmp    %eax,%edx
80106bb4:	77 b3                	ja     80106b69 <isdirempty+0xf>
  }
  return 1;
80106bb6:	b8 01 00 00 00       	mov    $0x1,%eax
}
80106bbb:	c9                   	leave  
80106bbc:	c3                   	ret    

80106bbd <sys_unlink>:

//PAGEBREAK!
int
sys_unlink(void)
{
80106bbd:	55                   	push   %ebp
80106bbe:	89 e5                	mov    %esp,%ebp
80106bc0:	83 ec 38             	sub    $0x38,%esp
  struct inode *ip, *dp;
  struct dirent de;
  char name[DIRSIZ], *path;
  uint off;

  if(argstr(0, &path) < 0)
80106bc3:	83 ec 08             	sub    $0x8,%esp
80106bc6:	8d 45 cc             	lea    -0x34(%ebp),%eax
80106bc9:	50                   	push   %eax
80106bca:	6a 00                	push   $0x0
80106bcc:	e8 a2 fa ff ff       	call   80106673 <argstr>
80106bd1:	83 c4 10             	add    $0x10,%esp
80106bd4:	85 c0                	test   %eax,%eax
80106bd6:	79 0a                	jns    80106be2 <sys_unlink+0x25>
    return -1;
80106bd8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106bdd:	e9 bf 01 00 00       	jmp    80106da1 <sys_unlink+0x1e4>

  begin_op();
80106be2:	e8 4b c9 ff ff       	call   80103532 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
80106be7:	8b 45 cc             	mov    -0x34(%ebp),%eax
80106bea:	83 ec 08             	sub    $0x8,%esp
80106bed:	8d 55 d2             	lea    -0x2e(%ebp),%edx
80106bf0:	52                   	push   %edx
80106bf1:	50                   	push   %eax
80106bf2:	e8 72 b9 ff ff       	call   80102569 <nameiparent>
80106bf7:	83 c4 10             	add    $0x10,%esp
80106bfa:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106bfd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106c01:	75 0f                	jne    80106c12 <sys_unlink+0x55>
    end_op();
80106c03:	e8 b6 c9 ff ff       	call   801035be <end_op>
    return -1;
80106c08:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106c0d:	e9 8f 01 00 00       	jmp    80106da1 <sys_unlink+0x1e4>
  }

  ilock(dp);
80106c12:	83 ec 0c             	sub    $0xc,%esp
80106c15:	ff 75 f4             	push   -0xc(%ebp)
80106c18:	e8 fd ad ff ff       	call   80101a1a <ilock>
80106c1d:	83 c4 10             	add    $0x10,%esp

  // Cannot unlink "." or "..".
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
80106c20:	83 ec 08             	sub    $0x8,%esp
80106c23:	68 97 9c 10 80       	push   $0x80109c97
80106c28:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80106c2b:	50                   	push   %eax
80106c2c:	e8 b0 b5 ff ff       	call   801021e1 <namecmp>
80106c31:	83 c4 10             	add    $0x10,%esp
80106c34:	85 c0                	test   %eax,%eax
80106c36:	0f 84 49 01 00 00    	je     80106d85 <sys_unlink+0x1c8>
80106c3c:	83 ec 08             	sub    $0x8,%esp
80106c3f:	68 99 9c 10 80       	push   $0x80109c99
80106c44:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80106c47:	50                   	push   %eax
80106c48:	e8 94 b5 ff ff       	call   801021e1 <namecmp>
80106c4d:	83 c4 10             	add    $0x10,%esp
80106c50:	85 c0                	test   %eax,%eax
80106c52:	0f 84 2d 01 00 00    	je     80106d85 <sys_unlink+0x1c8>
    goto bad;

  if((ip = dirlookup(dp, name, &off)) == 0)
80106c58:	83 ec 04             	sub    $0x4,%esp
80106c5b:	8d 45 c8             	lea    -0x38(%ebp),%eax
80106c5e:	50                   	push   %eax
80106c5f:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80106c62:	50                   	push   %eax
80106c63:	ff 75 f4             	push   -0xc(%ebp)
80106c66:	e8 91 b5 ff ff       	call   801021fc <dirlookup>
80106c6b:	83 c4 10             	add    $0x10,%esp
80106c6e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106c71:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106c75:	0f 84 0d 01 00 00    	je     80106d88 <sys_unlink+0x1cb>
    goto bad;
  ilock(ip);
80106c7b:	83 ec 0c             	sub    $0xc,%esp
80106c7e:	ff 75 f0             	push   -0x10(%ebp)
80106c81:	e8 94 ad ff ff       	call   80101a1a <ilock>
80106c86:	83 c4 10             	add    $0x10,%esp

  if(ip->nlink < 1)
80106c89:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106c8c:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80106c90:	66 85 c0             	test   %ax,%ax
80106c93:	7f 0d                	jg     80106ca2 <sys_unlink+0xe5>
    panic("unlink: nlink < 1");
80106c95:	83 ec 0c             	sub    $0xc,%esp
80106c98:	68 9c 9c 10 80       	push   $0x80109c9c
80106c9d:	e8 13 99 ff ff       	call   801005b5 <panic>
  if(ip->type == T_DIR && !isdirempty(ip)){
80106ca2:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106ca5:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80106ca9:	66 83 f8 01          	cmp    $0x1,%ax
80106cad:	75 25                	jne    80106cd4 <sys_unlink+0x117>
80106caf:	83 ec 0c             	sub    $0xc,%esp
80106cb2:	ff 75 f0             	push   -0x10(%ebp)
80106cb5:	e8 a0 fe ff ff       	call   80106b5a <isdirempty>
80106cba:	83 c4 10             	add    $0x10,%esp
80106cbd:	85 c0                	test   %eax,%eax
80106cbf:	75 13                	jne    80106cd4 <sys_unlink+0x117>
    iunlockput(ip);
80106cc1:	83 ec 0c             	sub    $0xc,%esp
80106cc4:	ff 75 f0             	push   -0x10(%ebp)
80106cc7:	e8 7f af ff ff       	call   80101c4b <iunlockput>
80106ccc:	83 c4 10             	add    $0x10,%esp
    goto bad;
80106ccf:	e9 b5 00 00 00       	jmp    80106d89 <sys_unlink+0x1cc>
  }

  memset(&de, 0, sizeof(de));
80106cd4:	83 ec 04             	sub    $0x4,%esp
80106cd7:	6a 10                	push   $0x10
80106cd9:	6a 00                	push   $0x0
80106cdb:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106cde:	50                   	push   %eax
80106cdf:	e8 cf f5 ff ff       	call   801062b3 <memset>
80106ce4:	83 c4 10             	add    $0x10,%esp
  if(writei(dp, (char*)&de, off, sizeof(de)) != sizeof(de))
80106ce7:	8b 45 c8             	mov    -0x38(%ebp),%eax
80106cea:	6a 10                	push   $0x10
80106cec:	50                   	push   %eax
80106ced:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106cf0:	50                   	push   %eax
80106cf1:	ff 75 f4             	push   -0xc(%ebp)
80106cf4:	e8 62 b3 ff ff       	call   8010205b <writei>
80106cf9:	83 c4 10             	add    $0x10,%esp
80106cfc:	83 f8 10             	cmp    $0x10,%eax
80106cff:	74 0d                	je     80106d0e <sys_unlink+0x151>
    panic("unlink: writei");
80106d01:	83 ec 0c             	sub    $0xc,%esp
80106d04:	68 ae 9c 10 80       	push   $0x80109cae
80106d09:	e8 a7 98 ff ff       	call   801005b5 <panic>
  if(ip->type == T_DIR){
80106d0e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106d11:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80106d15:	66 83 f8 01          	cmp    $0x1,%ax
80106d19:	75 21                	jne    80106d3c <sys_unlink+0x17f>
    dp->nlink--;
80106d1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d1e:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80106d22:	83 e8 01             	sub    $0x1,%eax
80106d25:	89 c2                	mov    %eax,%edx
80106d27:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106d2a:	66 89 50 56          	mov    %dx,0x56(%eax)
    iupdate(dp);
80106d2e:	83 ec 0c             	sub    $0xc,%esp
80106d31:	ff 75 f4             	push   -0xc(%ebp)
80106d34:	e8 04 ab ff ff       	call   8010183d <iupdate>
80106d39:	83 c4 10             	add    $0x10,%esp
  }
  iunlockput(dp);
80106d3c:	83 ec 0c             	sub    $0xc,%esp
80106d3f:	ff 75 f4             	push   -0xc(%ebp)
80106d42:	e8 04 af ff ff       	call   80101c4b <iunlockput>
80106d47:	83 c4 10             	add    $0x10,%esp

  ip->nlink--;
80106d4a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106d4d:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80106d51:	83 e8 01             	sub    $0x1,%eax
80106d54:	89 c2                	mov    %eax,%edx
80106d56:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106d59:	66 89 50 56          	mov    %dx,0x56(%eax)
  iupdate(ip);
80106d5d:	83 ec 0c             	sub    $0xc,%esp
80106d60:	ff 75 f0             	push   -0x10(%ebp)
80106d63:	e8 d5 aa ff ff       	call   8010183d <iupdate>
80106d68:	83 c4 10             	add    $0x10,%esp
  iunlockput(ip);
80106d6b:	83 ec 0c             	sub    $0xc,%esp
80106d6e:	ff 75 f0             	push   -0x10(%ebp)
80106d71:	e8 d5 ae ff ff       	call   80101c4b <iunlockput>
80106d76:	83 c4 10             	add    $0x10,%esp

  end_op();
80106d79:	e8 40 c8 ff ff       	call   801035be <end_op>

  return 0;
80106d7e:	b8 00 00 00 00       	mov    $0x0,%eax
80106d83:	eb 1c                	jmp    80106da1 <sys_unlink+0x1e4>
    goto bad;
80106d85:	90                   	nop
80106d86:	eb 01                	jmp    80106d89 <sys_unlink+0x1cc>
    goto bad;
80106d88:	90                   	nop

bad:
  iunlockput(dp);
80106d89:	83 ec 0c             	sub    $0xc,%esp
80106d8c:	ff 75 f4             	push   -0xc(%ebp)
80106d8f:	e8 b7 ae ff ff       	call   80101c4b <iunlockput>
80106d94:	83 c4 10             	add    $0x10,%esp
  end_op();
80106d97:	e8 22 c8 ff ff       	call   801035be <end_op>
  return -1;
80106d9c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
80106da1:	c9                   	leave  
80106da2:	c3                   	ret    

80106da3 <create>:

static struct inode*
create(char *path, short type, short major, short minor)
{
80106da3:	55                   	push   %ebp
80106da4:	89 e5                	mov    %esp,%ebp
80106da6:	83 ec 38             	sub    $0x38,%esp
80106da9:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106dac:	8b 55 10             	mov    0x10(%ebp),%edx
80106daf:	8b 45 14             	mov    0x14(%ebp),%eax
80106db2:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80106db6:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80106dba:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
80106dbe:	83 ec 08             	sub    $0x8,%esp
80106dc1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80106dc4:	50                   	push   %eax
80106dc5:	ff 75 08             	push   0x8(%ebp)
80106dc8:	e8 9c b7 ff ff       	call   80102569 <nameiparent>
80106dcd:	83 c4 10             	add    $0x10,%esp
80106dd0:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106dd3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106dd7:	75 0a                	jne    80106de3 <create+0x40>
    return 0;
80106dd9:	b8 00 00 00 00       	mov    $0x0,%eax
80106dde:	e9 8e 01 00 00       	jmp    80106f71 <create+0x1ce>
  ilock(dp);
80106de3:	83 ec 0c             	sub    $0xc,%esp
80106de6:	ff 75 f4             	push   -0xc(%ebp)
80106de9:	e8 2c ac ff ff       	call   80101a1a <ilock>
80106dee:	83 c4 10             	add    $0x10,%esp

  if((ip = dirlookup(dp, name, 0)) != 0){
80106df1:	83 ec 04             	sub    $0x4,%esp
80106df4:	6a 00                	push   $0x0
80106df6:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80106df9:	50                   	push   %eax
80106dfa:	ff 75 f4             	push   -0xc(%ebp)
80106dfd:	e8 fa b3 ff ff       	call   801021fc <dirlookup>
80106e02:	83 c4 10             	add    $0x10,%esp
80106e05:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106e08:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106e0c:	74 50                	je     80106e5e <create+0xbb>
    iunlockput(dp);
80106e0e:	83 ec 0c             	sub    $0xc,%esp
80106e11:	ff 75 f4             	push   -0xc(%ebp)
80106e14:	e8 32 ae ff ff       	call   80101c4b <iunlockput>
80106e19:	83 c4 10             	add    $0x10,%esp
    ilock(ip);
80106e1c:	83 ec 0c             	sub    $0xc,%esp
80106e1f:	ff 75 f0             	push   -0x10(%ebp)
80106e22:	e8 f3 ab ff ff       	call   80101a1a <ilock>
80106e27:	83 c4 10             	add    $0x10,%esp
    if(type == T_FILE && ip->type == T_FILE)
80106e2a:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80106e2f:	75 15                	jne    80106e46 <create+0xa3>
80106e31:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106e34:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80106e38:	66 83 f8 02          	cmp    $0x2,%ax
80106e3c:	75 08                	jne    80106e46 <create+0xa3>
      return ip;
80106e3e:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106e41:	e9 2b 01 00 00       	jmp    80106f71 <create+0x1ce>
    iunlockput(ip);
80106e46:	83 ec 0c             	sub    $0xc,%esp
80106e49:	ff 75 f0             	push   -0x10(%ebp)
80106e4c:	e8 fa ad ff ff       	call   80101c4b <iunlockput>
80106e51:	83 c4 10             	add    $0x10,%esp
    return 0;
80106e54:	b8 00 00 00 00       	mov    $0x0,%eax
80106e59:	e9 13 01 00 00       	jmp    80106f71 <create+0x1ce>
  }

  if((ip = ialloc(dp->dev, type)) == 0)
80106e5e:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80106e62:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e65:	8b 00                	mov    (%eax),%eax
80106e67:	83 ec 08             	sub    $0x8,%esp
80106e6a:	52                   	push   %edx
80106e6b:	50                   	push   %eax
80106e6c:	e8 f5 a8 ff ff       	call   80101766 <ialloc>
80106e71:	83 c4 10             	add    $0x10,%esp
80106e74:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106e77:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106e7b:	75 0d                	jne    80106e8a <create+0xe7>
    panic("create: ialloc");
80106e7d:	83 ec 0c             	sub    $0xc,%esp
80106e80:	68 bd 9c 10 80       	push   $0x80109cbd
80106e85:	e8 2b 97 ff ff       	call   801005b5 <panic>

  ilock(ip);
80106e8a:	83 ec 0c             	sub    $0xc,%esp
80106e8d:	ff 75 f0             	push   -0x10(%ebp)
80106e90:	e8 85 ab ff ff       	call   80101a1a <ilock>
80106e95:	83 c4 10             	add    $0x10,%esp
  ip->major = major;
80106e98:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106e9b:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80106e9f:	66 89 50 52          	mov    %dx,0x52(%eax)
  ip->minor = minor;
80106ea3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106ea6:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80106eaa:	66 89 50 54          	mov    %dx,0x54(%eax)
  ip->nlink = 1;
80106eae:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106eb1:	66 c7 40 56 01 00    	movw   $0x1,0x56(%eax)
  iupdate(ip);
80106eb7:	83 ec 0c             	sub    $0xc,%esp
80106eba:	ff 75 f0             	push   -0x10(%ebp)
80106ebd:	e8 7b a9 ff ff       	call   8010183d <iupdate>
80106ec2:	83 c4 10             	add    $0x10,%esp

  if(type == T_DIR){  // Create . and .. entries.
80106ec5:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80106eca:	75 6a                	jne    80106f36 <create+0x193>
    dp->nlink++;  // for ".."
80106ecc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ecf:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80106ed3:	83 c0 01             	add    $0x1,%eax
80106ed6:	89 c2                	mov    %eax,%edx
80106ed8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106edb:	66 89 50 56          	mov    %dx,0x56(%eax)
    iupdate(dp);
80106edf:	83 ec 0c             	sub    $0xc,%esp
80106ee2:	ff 75 f4             	push   -0xc(%ebp)
80106ee5:	e8 53 a9 ff ff       	call   8010183d <iupdate>
80106eea:	83 c4 10             	add    $0x10,%esp
    // No ip->nlink++ for ".": avoid cyclic ref count.
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
80106eed:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106ef0:	8b 40 04             	mov    0x4(%eax),%eax
80106ef3:	83 ec 04             	sub    $0x4,%esp
80106ef6:	50                   	push   %eax
80106ef7:	68 97 9c 10 80       	push   $0x80109c97
80106efc:	ff 75 f0             	push   -0x10(%ebp)
80106eff:	e8 b2 b3 ff ff       	call   801022b6 <dirlink>
80106f04:	83 c4 10             	add    $0x10,%esp
80106f07:	85 c0                	test   %eax,%eax
80106f09:	78 1e                	js     80106f29 <create+0x186>
80106f0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106f0e:	8b 40 04             	mov    0x4(%eax),%eax
80106f11:	83 ec 04             	sub    $0x4,%esp
80106f14:	50                   	push   %eax
80106f15:	68 99 9c 10 80       	push   $0x80109c99
80106f1a:	ff 75 f0             	push   -0x10(%ebp)
80106f1d:	e8 94 b3 ff ff       	call   801022b6 <dirlink>
80106f22:	83 c4 10             	add    $0x10,%esp
80106f25:	85 c0                	test   %eax,%eax
80106f27:	79 0d                	jns    80106f36 <create+0x193>
      panic("create dots");
80106f29:	83 ec 0c             	sub    $0xc,%esp
80106f2c:	68 cc 9c 10 80       	push   $0x80109ccc
80106f31:	e8 7f 96 ff ff       	call   801005b5 <panic>
  }

  if(dirlink(dp, name, ip->inum) < 0)
80106f36:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106f39:	8b 40 04             	mov    0x4(%eax),%eax
80106f3c:	83 ec 04             	sub    $0x4,%esp
80106f3f:	50                   	push   %eax
80106f40:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80106f43:	50                   	push   %eax
80106f44:	ff 75 f4             	push   -0xc(%ebp)
80106f47:	e8 6a b3 ff ff       	call   801022b6 <dirlink>
80106f4c:	83 c4 10             	add    $0x10,%esp
80106f4f:	85 c0                	test   %eax,%eax
80106f51:	79 0d                	jns    80106f60 <create+0x1bd>
    panic("create: dirlink");
80106f53:	83 ec 0c             	sub    $0xc,%esp
80106f56:	68 d8 9c 10 80       	push   $0x80109cd8
80106f5b:	e8 55 96 ff ff       	call   801005b5 <panic>

  iunlockput(dp);
80106f60:	83 ec 0c             	sub    $0xc,%esp
80106f63:	ff 75 f4             	push   -0xc(%ebp)
80106f66:	e8 e0 ac ff ff       	call   80101c4b <iunlockput>
80106f6b:	83 c4 10             	add    $0x10,%esp

  return ip;
80106f6e:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80106f71:	c9                   	leave  
80106f72:	c3                   	ret    

80106f73 <sys_open>:

int
sys_open(void)
{
80106f73:	55                   	push   %ebp
80106f74:	89 e5                	mov    %esp,%ebp
80106f76:	83 ec 28             	sub    $0x28,%esp
  char *path;
  int fd, omode;
  struct file *f;
  struct inode *ip;

  if(argstr(0, &path) < 0 || argint(1, &omode) < 0)
80106f79:	83 ec 08             	sub    $0x8,%esp
80106f7c:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106f7f:	50                   	push   %eax
80106f80:	6a 00                	push   $0x0
80106f82:	e8 ec f6 ff ff       	call   80106673 <argstr>
80106f87:	83 c4 10             	add    $0x10,%esp
80106f8a:	85 c0                	test   %eax,%eax
80106f8c:	78 15                	js     80106fa3 <sys_open+0x30>
80106f8e:	83 ec 08             	sub    $0x8,%esp
80106f91:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106f94:	50                   	push   %eax
80106f95:	6a 01                	push   $0x1
80106f97:	e8 42 f6 ff ff       	call   801065de <argint>
80106f9c:	83 c4 10             	add    $0x10,%esp
80106f9f:	85 c0                	test   %eax,%eax
80106fa1:	79 0a                	jns    80106fad <sys_open+0x3a>
    return -1;
80106fa3:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106fa8:	e9 61 01 00 00       	jmp    8010710e <sys_open+0x19b>

  begin_op();
80106fad:	e8 80 c5 ff ff       	call   80103532 <begin_op>

  if(omode & O_CREATE){
80106fb2:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106fb5:	25 00 02 00 00       	and    $0x200,%eax
80106fba:	85 c0                	test   %eax,%eax
80106fbc:	74 2a                	je     80106fe8 <sys_open+0x75>
    ip = create(path, T_FILE, 0, 0);
80106fbe:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106fc1:	6a 00                	push   $0x0
80106fc3:	6a 00                	push   $0x0
80106fc5:	6a 02                	push   $0x2
80106fc7:	50                   	push   %eax
80106fc8:	e8 d6 fd ff ff       	call   80106da3 <create>
80106fcd:	83 c4 10             	add    $0x10,%esp
80106fd0:	89 45 f4             	mov    %eax,-0xc(%ebp)
    if(ip == 0){
80106fd3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106fd7:	75 75                	jne    8010704e <sys_open+0xdb>
      end_op();
80106fd9:	e8 e0 c5 ff ff       	call   801035be <end_op>
      return -1;
80106fde:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106fe3:	e9 26 01 00 00       	jmp    8010710e <sys_open+0x19b>
    }
  } else {
    if((ip = namei(path)) == 0){
80106fe8:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106feb:	83 ec 0c             	sub    $0xc,%esp
80106fee:	50                   	push   %eax
80106fef:	e8 59 b5 ff ff       	call   8010254d <namei>
80106ff4:	83 c4 10             	add    $0x10,%esp
80106ff7:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106ffa:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106ffe:	75 0f                	jne    8010700f <sys_open+0x9c>
      end_op();
80107000:	e8 b9 c5 ff ff       	call   801035be <end_op>
      return -1;
80107005:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010700a:	e9 ff 00 00 00       	jmp    8010710e <sys_open+0x19b>
    }
    ilock(ip);
8010700f:	83 ec 0c             	sub    $0xc,%esp
80107012:	ff 75 f4             	push   -0xc(%ebp)
80107015:	e8 00 aa ff ff       	call   80101a1a <ilock>
8010701a:	83 c4 10             	add    $0x10,%esp
    if(ip->type == T_DIR && omode != O_RDONLY){
8010701d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107020:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80107024:	66 83 f8 01          	cmp    $0x1,%ax
80107028:	75 24                	jne    8010704e <sys_open+0xdb>
8010702a:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010702d:	85 c0                	test   %eax,%eax
8010702f:	74 1d                	je     8010704e <sys_open+0xdb>
      iunlockput(ip);
80107031:	83 ec 0c             	sub    $0xc,%esp
80107034:	ff 75 f4             	push   -0xc(%ebp)
80107037:	e8 0f ac ff ff       	call   80101c4b <iunlockput>
8010703c:	83 c4 10             	add    $0x10,%esp
      end_op();
8010703f:	e8 7a c5 ff ff       	call   801035be <end_op>
      return -1;
80107044:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107049:	e9 c0 00 00 00       	jmp    8010710e <sys_open+0x19b>
    }
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
8010704e:	e8 cd 9f ff ff       	call   80101020 <filealloc>
80107053:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107056:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010705a:	74 17                	je     80107073 <sys_open+0x100>
8010705c:	83 ec 0c             	sub    $0xc,%esp
8010705f:	ff 75 f0             	push   -0x10(%ebp)
80107062:	e8 35 f7 ff ff       	call   8010679c <fdalloc>
80107067:	83 c4 10             	add    $0x10,%esp
8010706a:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010706d:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80107071:	79 2e                	jns    801070a1 <sys_open+0x12e>
    if(f)
80107073:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107077:	74 0e                	je     80107087 <sys_open+0x114>
      fileclose(f);
80107079:	83 ec 0c             	sub    $0xc,%esp
8010707c:	ff 75 f0             	push   -0x10(%ebp)
8010707f:	e8 5a a0 ff ff       	call   801010de <fileclose>
80107084:	83 c4 10             	add    $0x10,%esp
    iunlockput(ip);
80107087:	83 ec 0c             	sub    $0xc,%esp
8010708a:	ff 75 f4             	push   -0xc(%ebp)
8010708d:	e8 b9 ab ff ff       	call   80101c4b <iunlockput>
80107092:	83 c4 10             	add    $0x10,%esp
    end_op();
80107095:	e8 24 c5 ff ff       	call   801035be <end_op>
    return -1;
8010709a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010709f:	eb 6d                	jmp    8010710e <sys_open+0x19b>
  }
  iunlock(ip);
801070a1:	83 ec 0c             	sub    $0xc,%esp
801070a4:	ff 75 f4             	push   -0xc(%ebp)
801070a7:	e8 81 aa ff ff       	call   80101b2d <iunlock>
801070ac:	83 c4 10             	add    $0x10,%esp
  end_op();
801070af:	e8 0a c5 ff ff       	call   801035be <end_op>

  f->type = FD_INODE;
801070b4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801070b7:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
  f->ip = ip;
801070bd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801070c0:	8b 55 f4             	mov    -0xc(%ebp),%edx
801070c3:	89 50 10             	mov    %edx,0x10(%eax)
  f->off = 0;
801070c6:	8b 45 f0             	mov    -0x10(%ebp),%eax
801070c9:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
  f->readable = !(omode & O_WRONLY);
801070d0:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801070d3:	83 e0 01             	and    $0x1,%eax
801070d6:	85 c0                	test   %eax,%eax
801070d8:	0f 94 c0             	sete   %al
801070db:	89 c2                	mov    %eax,%edx
801070dd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801070e0:	88 50 08             	mov    %dl,0x8(%eax)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
801070e3:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801070e6:	83 e0 01             	and    $0x1,%eax
801070e9:	85 c0                	test   %eax,%eax
801070eb:	75 0a                	jne    801070f7 <sys_open+0x184>
801070ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801070f0:	83 e0 02             	and    $0x2,%eax
801070f3:	85 c0                	test   %eax,%eax
801070f5:	74 07                	je     801070fe <sys_open+0x18b>
801070f7:	b8 01 00 00 00       	mov    $0x1,%eax
801070fc:	eb 05                	jmp    80107103 <sys_open+0x190>
801070fe:	b8 00 00 00 00       	mov    $0x0,%eax
80107103:	89 c2                	mov    %eax,%edx
80107105:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107108:	88 50 09             	mov    %dl,0x9(%eax)
  return fd;
8010710b:	8b 45 ec             	mov    -0x14(%ebp),%eax
}
8010710e:	c9                   	leave  
8010710f:	c3                   	ret    

80107110 <sys_mkdir>:

int
sys_mkdir(void)
{
80107110:	55                   	push   %ebp
80107111:	89 e5                	mov    %esp,%ebp
80107113:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;

  begin_op();
80107116:	e8 17 c4 ff ff       	call   80103532 <begin_op>
  if(argstr(0, &path) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
8010711b:	83 ec 08             	sub    $0x8,%esp
8010711e:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107121:	50                   	push   %eax
80107122:	6a 00                	push   $0x0
80107124:	e8 4a f5 ff ff       	call   80106673 <argstr>
80107129:	83 c4 10             	add    $0x10,%esp
8010712c:	85 c0                	test   %eax,%eax
8010712e:	78 1b                	js     8010714b <sys_mkdir+0x3b>
80107130:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107133:	6a 00                	push   $0x0
80107135:	6a 00                	push   $0x0
80107137:	6a 01                	push   $0x1
80107139:	50                   	push   %eax
8010713a:	e8 64 fc ff ff       	call   80106da3 <create>
8010713f:	83 c4 10             	add    $0x10,%esp
80107142:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107145:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107149:	75 0c                	jne    80107157 <sys_mkdir+0x47>
    end_op();
8010714b:	e8 6e c4 ff ff       	call   801035be <end_op>
    return -1;
80107150:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107155:	eb 18                	jmp    8010716f <sys_mkdir+0x5f>
  }
  iunlockput(ip);
80107157:	83 ec 0c             	sub    $0xc,%esp
8010715a:	ff 75 f4             	push   -0xc(%ebp)
8010715d:	e8 e9 aa ff ff       	call   80101c4b <iunlockput>
80107162:	83 c4 10             	add    $0x10,%esp
  end_op();
80107165:	e8 54 c4 ff ff       	call   801035be <end_op>
  return 0;
8010716a:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010716f:	c9                   	leave  
80107170:	c3                   	ret    

80107171 <sys_mknod>:

int
sys_mknod(void)
{
80107171:	55                   	push   %ebp
80107172:	89 e5                	mov    %esp,%ebp
80107174:	83 ec 18             	sub    $0x18,%esp
  struct inode *ip;
  char *path;
  int major, minor;

  begin_op();
80107177:	e8 b6 c3 ff ff       	call   80103532 <begin_op>
  if((argstr(0, &path)) < 0 ||
8010717c:	83 ec 08             	sub    $0x8,%esp
8010717f:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107182:	50                   	push   %eax
80107183:	6a 00                	push   $0x0
80107185:	e8 e9 f4 ff ff       	call   80106673 <argstr>
8010718a:	83 c4 10             	add    $0x10,%esp
8010718d:	85 c0                	test   %eax,%eax
8010718f:	78 4f                	js     801071e0 <sys_mknod+0x6f>
     argint(1, &major) < 0 ||
80107191:	83 ec 08             	sub    $0x8,%esp
80107194:	8d 45 ec             	lea    -0x14(%ebp),%eax
80107197:	50                   	push   %eax
80107198:	6a 01                	push   $0x1
8010719a:	e8 3f f4 ff ff       	call   801065de <argint>
8010719f:	83 c4 10             	add    $0x10,%esp
  if((argstr(0, &path)) < 0 ||
801071a2:	85 c0                	test   %eax,%eax
801071a4:	78 3a                	js     801071e0 <sys_mknod+0x6f>
     argint(2, &minor) < 0 ||
801071a6:	83 ec 08             	sub    $0x8,%esp
801071a9:	8d 45 e8             	lea    -0x18(%ebp),%eax
801071ac:	50                   	push   %eax
801071ad:	6a 02                	push   $0x2
801071af:	e8 2a f4 ff ff       	call   801065de <argint>
801071b4:	83 c4 10             	add    $0x10,%esp
     argint(1, &major) < 0 ||
801071b7:	85 c0                	test   %eax,%eax
801071b9:	78 25                	js     801071e0 <sys_mknod+0x6f>
     (ip = create(path, T_DEV, major, minor)) == 0){
801071bb:	8b 45 e8             	mov    -0x18(%ebp),%eax
801071be:	0f bf c8             	movswl %ax,%ecx
801071c1:	8b 45 ec             	mov    -0x14(%ebp),%eax
801071c4:	0f bf d0             	movswl %ax,%edx
801071c7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801071ca:	51                   	push   %ecx
801071cb:	52                   	push   %edx
801071cc:	6a 03                	push   $0x3
801071ce:	50                   	push   %eax
801071cf:	e8 cf fb ff ff       	call   80106da3 <create>
801071d4:	83 c4 10             	add    $0x10,%esp
801071d7:	89 45 f4             	mov    %eax,-0xc(%ebp)
     argint(2, &minor) < 0 ||
801071da:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801071de:	75 0c                	jne    801071ec <sys_mknod+0x7b>
    end_op();
801071e0:	e8 d9 c3 ff ff       	call   801035be <end_op>
    return -1;
801071e5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801071ea:	eb 18                	jmp    80107204 <sys_mknod+0x93>
  }
  iunlockput(ip);
801071ec:	83 ec 0c             	sub    $0xc,%esp
801071ef:	ff 75 f4             	push   -0xc(%ebp)
801071f2:	e8 54 aa ff ff       	call   80101c4b <iunlockput>
801071f7:	83 c4 10             	add    $0x10,%esp
  end_op();
801071fa:	e8 bf c3 ff ff       	call   801035be <end_op>
  return 0;
801071ff:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107204:	c9                   	leave  
80107205:	c3                   	ret    

80107206 <sys_chdir>:

int
sys_chdir(void)
{
80107206:	55                   	push   %ebp
80107207:	89 e5                	mov    %esp,%ebp
80107209:	83 ec 18             	sub    $0x18,%esp
  char *path;
  struct inode *ip;
  struct proc *curproc = myproc();
8010720c:	e8 05 d1 ff ff       	call   80104316 <myproc>
80107211:	89 45 f4             	mov    %eax,-0xc(%ebp)
  
  begin_op();
80107214:	e8 19 c3 ff ff       	call   80103532 <begin_op>
  if(argstr(0, &path) < 0 || (ip = namei(path)) == 0){
80107219:	83 ec 08             	sub    $0x8,%esp
8010721c:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010721f:	50                   	push   %eax
80107220:	6a 00                	push   $0x0
80107222:	e8 4c f4 ff ff       	call   80106673 <argstr>
80107227:	83 c4 10             	add    $0x10,%esp
8010722a:	85 c0                	test   %eax,%eax
8010722c:	78 18                	js     80107246 <sys_chdir+0x40>
8010722e:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107231:	83 ec 0c             	sub    $0xc,%esp
80107234:	50                   	push   %eax
80107235:	e8 13 b3 ff ff       	call   8010254d <namei>
8010723a:	83 c4 10             	add    $0x10,%esp
8010723d:	89 45 f0             	mov    %eax,-0x10(%ebp)
80107240:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107244:	75 0c                	jne    80107252 <sys_chdir+0x4c>
    end_op();
80107246:	e8 73 c3 ff ff       	call   801035be <end_op>
    return -1;
8010724b:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107250:	eb 68                	jmp    801072ba <sys_chdir+0xb4>
  }
  ilock(ip);
80107252:	83 ec 0c             	sub    $0xc,%esp
80107255:	ff 75 f0             	push   -0x10(%ebp)
80107258:	e8 bd a7 ff ff       	call   80101a1a <ilock>
8010725d:	83 c4 10             	add    $0x10,%esp
  if(ip->type != T_DIR){
80107260:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107263:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80107267:	66 83 f8 01          	cmp    $0x1,%ax
8010726b:	74 1a                	je     80107287 <sys_chdir+0x81>
    iunlockput(ip);
8010726d:	83 ec 0c             	sub    $0xc,%esp
80107270:	ff 75 f0             	push   -0x10(%ebp)
80107273:	e8 d3 a9 ff ff       	call   80101c4b <iunlockput>
80107278:	83 c4 10             	add    $0x10,%esp
    end_op();
8010727b:	e8 3e c3 ff ff       	call   801035be <end_op>
    return -1;
80107280:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107285:	eb 33                	jmp    801072ba <sys_chdir+0xb4>
  }
  iunlock(ip);
80107287:	83 ec 0c             	sub    $0xc,%esp
8010728a:	ff 75 f0             	push   -0x10(%ebp)
8010728d:	e8 9b a8 ff ff       	call   80101b2d <iunlock>
80107292:	83 c4 10             	add    $0x10,%esp
  iput(curproc->cwd);
80107295:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107298:	8b 40 68             	mov    0x68(%eax),%eax
8010729b:	83 ec 0c             	sub    $0xc,%esp
8010729e:	50                   	push   %eax
8010729f:	e8 d7 a8 ff ff       	call   80101b7b <iput>
801072a4:	83 c4 10             	add    $0x10,%esp
  end_op();
801072a7:	e8 12 c3 ff ff       	call   801035be <end_op>
  curproc->cwd = ip;
801072ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801072af:	8b 55 f0             	mov    -0x10(%ebp),%edx
801072b2:	89 50 68             	mov    %edx,0x68(%eax)
  return 0;
801072b5:	b8 00 00 00 00       	mov    $0x0,%eax
}
801072ba:	c9                   	leave  
801072bb:	c3                   	ret    

801072bc <sys_exec>:

int
sys_exec(void)
{
801072bc:	55                   	push   %ebp
801072bd:	89 e5                	mov    %esp,%ebp
801072bf:	81 ec 98 00 00 00    	sub    $0x98,%esp
  char *path, *argv[MAXARG];
  int i;
  uint uargv, uarg;

  if(argstr(0, &path) < 0 || argint(1, (int*)&uargv) < 0){
801072c5:	83 ec 08             	sub    $0x8,%esp
801072c8:	8d 45 f0             	lea    -0x10(%ebp),%eax
801072cb:	50                   	push   %eax
801072cc:	6a 00                	push   $0x0
801072ce:	e8 a0 f3 ff ff       	call   80106673 <argstr>
801072d3:	83 c4 10             	add    $0x10,%esp
801072d6:	85 c0                	test   %eax,%eax
801072d8:	78 18                	js     801072f2 <sys_exec+0x36>
801072da:	83 ec 08             	sub    $0x8,%esp
801072dd:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
801072e3:	50                   	push   %eax
801072e4:	6a 01                	push   $0x1
801072e6:	e8 f3 f2 ff ff       	call   801065de <argint>
801072eb:	83 c4 10             	add    $0x10,%esp
801072ee:	85 c0                	test   %eax,%eax
801072f0:	79 0a                	jns    801072fc <sys_exec+0x40>
    return -1;
801072f2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801072f7:	e9 c6 00 00 00       	jmp    801073c2 <sys_exec+0x106>
  }
  memset(argv, 0, sizeof(argv));
801072fc:	83 ec 04             	sub    $0x4,%esp
801072ff:	68 80 00 00 00       	push   $0x80
80107304:	6a 00                	push   $0x0
80107306:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
8010730c:	50                   	push   %eax
8010730d:	e8 a1 ef ff ff       	call   801062b3 <memset>
80107312:	83 c4 10             	add    $0x10,%esp
  for(i=0;; i++){
80107315:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
    if(i >= NELEM(argv))
8010731c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010731f:	83 f8 1f             	cmp    $0x1f,%eax
80107322:	76 0a                	jbe    8010732e <sys_exec+0x72>
      return -1;
80107324:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107329:	e9 94 00 00 00       	jmp    801073c2 <sys_exec+0x106>
    if(fetchint(uargv+4*i, (int*)&uarg) < 0)
8010732e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107331:	c1 e0 02             	shl    $0x2,%eax
80107334:	89 c2                	mov    %eax,%edx
80107336:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
8010733c:	01 c2                	add    %eax,%edx
8010733e:	83 ec 08             	sub    $0x8,%esp
80107341:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
80107347:	50                   	push   %eax
80107348:	52                   	push   %edx
80107349:	e8 ef f1 ff ff       	call   8010653d <fetchint>
8010734e:	83 c4 10             	add    $0x10,%esp
80107351:	85 c0                	test   %eax,%eax
80107353:	79 07                	jns    8010735c <sys_exec+0xa0>
      return -1;
80107355:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010735a:	eb 66                	jmp    801073c2 <sys_exec+0x106>
    if(uarg == 0){
8010735c:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80107362:	85 c0                	test   %eax,%eax
80107364:	75 27                	jne    8010738d <sys_exec+0xd1>
      argv[i] = 0;
80107366:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107369:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
80107370:	00 00 00 00 
      break;
80107374:	90                   	nop
    }
    if(fetchstr(uarg, &argv[i]) < 0)
      return -1;
  }
  return exec(path, argv);
80107375:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107378:	83 ec 08             	sub    $0x8,%esp
8010737b:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
80107381:	52                   	push   %edx
80107382:	50                   	push   %eax
80107383:	e8 3b 98 ff ff       	call   80100bc3 <exec>
80107388:	83 c4 10             	add    $0x10,%esp
8010738b:	eb 35                	jmp    801073c2 <sys_exec+0x106>
    if(fetchstr(uarg, &argv[i]) < 0)
8010738d:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
80107393:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107396:	c1 e0 02             	shl    $0x2,%eax
80107399:	01 c2                	add    %eax,%edx
8010739b:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
801073a1:	83 ec 08             	sub    $0x8,%esp
801073a4:	52                   	push   %edx
801073a5:	50                   	push   %eax
801073a6:	e8 d1 f1 ff ff       	call   8010657c <fetchstr>
801073ab:	83 c4 10             	add    $0x10,%esp
801073ae:	85 c0                	test   %eax,%eax
801073b0:	79 07                	jns    801073b9 <sys_exec+0xfd>
      return -1;
801073b2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801073b7:	eb 09                	jmp    801073c2 <sys_exec+0x106>
  for(i=0;; i++){
801073b9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
    if(i >= NELEM(argv))
801073bd:	e9 5a ff ff ff       	jmp    8010731c <sys_exec+0x60>
}
801073c2:	c9                   	leave  
801073c3:	c3                   	ret    

801073c4 <sys_pipe>:

int
sys_pipe(void)
{
801073c4:	55                   	push   %ebp
801073c5:	89 e5                	mov    %esp,%ebp
801073c7:	83 ec 28             	sub    $0x28,%esp
  int *fd;
  struct file *rf, *wf;
  int fd0, fd1;

  if(argptr(0, (void*)&fd, 2*sizeof(fd[0])) < 0)
801073ca:	83 ec 04             	sub    $0x4,%esp
801073cd:	6a 08                	push   $0x8
801073cf:	8d 45 ec             	lea    -0x14(%ebp),%eax
801073d2:	50                   	push   %eax
801073d3:	6a 00                	push   $0x0
801073d5:	e8 31 f2 ff ff       	call   8010660b <argptr>
801073da:	83 c4 10             	add    $0x10,%esp
801073dd:	85 c0                	test   %eax,%eax
801073df:	79 0a                	jns    801073eb <sys_pipe+0x27>
    return -1;
801073e1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801073e6:	e9 ae 00 00 00       	jmp    80107499 <sys_pipe+0xd5>
  if(pipealloc(&rf, &wf) < 0)
801073eb:	83 ec 08             	sub    $0x8,%esp
801073ee:	8d 45 e4             	lea    -0x1c(%ebp),%eax
801073f1:	50                   	push   %eax
801073f2:	8d 45 e8             	lea    -0x18(%ebp),%eax
801073f5:	50                   	push   %eax
801073f6:	e8 db c9 ff ff       	call   80103dd6 <pipealloc>
801073fb:	83 c4 10             	add    $0x10,%esp
801073fe:	85 c0                	test   %eax,%eax
80107400:	79 0a                	jns    8010740c <sys_pipe+0x48>
    return -1;
80107402:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107407:	e9 8d 00 00 00       	jmp    80107499 <sys_pipe+0xd5>
  fd0 = -1;
8010740c:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
80107413:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107416:	83 ec 0c             	sub    $0xc,%esp
80107419:	50                   	push   %eax
8010741a:	e8 7d f3 ff ff       	call   8010679c <fdalloc>
8010741f:	83 c4 10             	add    $0x10,%esp
80107422:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107425:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107429:	78 18                	js     80107443 <sys_pipe+0x7f>
8010742b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010742e:	83 ec 0c             	sub    $0xc,%esp
80107431:	50                   	push   %eax
80107432:	e8 65 f3 ff ff       	call   8010679c <fdalloc>
80107437:	83 c4 10             	add    $0x10,%esp
8010743a:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010743d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80107441:	79 3e                	jns    80107481 <sys_pipe+0xbd>
    if(fd0 >= 0)
80107443:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107447:	78 13                	js     8010745c <sys_pipe+0x98>
      myproc()->ofile[fd0] = 0;
80107449:	e8 c8 ce ff ff       	call   80104316 <myproc>
8010744e:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107451:	83 c2 08             	add    $0x8,%edx
80107454:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
8010745b:	00 
    fileclose(rf);
8010745c:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010745f:	83 ec 0c             	sub    $0xc,%esp
80107462:	50                   	push   %eax
80107463:	e8 76 9c ff ff       	call   801010de <fileclose>
80107468:	83 c4 10             	add    $0x10,%esp
    fileclose(wf);
8010746b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010746e:	83 ec 0c             	sub    $0xc,%esp
80107471:	50                   	push   %eax
80107472:	e8 67 9c ff ff       	call   801010de <fileclose>
80107477:	83 c4 10             	add    $0x10,%esp
    return -1;
8010747a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010747f:	eb 18                	jmp    80107499 <sys_pipe+0xd5>
  }
  fd[0] = fd0;
80107481:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107484:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107487:	89 10                	mov    %edx,(%eax)
  fd[1] = fd1;
80107489:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010748c:	8d 50 04             	lea    0x4(%eax),%edx
8010748f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107492:	89 02                	mov    %eax,(%edx)
  return 0;
80107494:	b8 00 00 00 00       	mov    $0x0,%eax
}
80107499:	c9                   	leave  
8010749a:	c3                   	ret    

8010749b <sys_fork>:
#include "mmu.h"
#include "proc.h"

int
sys_fork(void)
{
8010749b:	55                   	push   %ebp
8010749c:	89 e5                	mov    %esp,%ebp
8010749e:	83 ec 08             	sub    $0x8,%esp
  return fork();
801074a1:	e8 ba d1 ff ff       	call   80104660 <fork>
}
801074a6:	c9                   	leave  
801074a7:	c3                   	ret    

801074a8 <sys_exit>:

int
sys_exit(void)
{
801074a8:	55                   	push   %ebp
801074a9:	89 e5                	mov    %esp,%ebp
801074ab:	83 ec 08             	sub    $0x8,%esp
  exit();
801074ae:	e8 97 d5 ff ff       	call   80104a4a <exit>
  return 0;  // not reached
801074b3:	b8 00 00 00 00       	mov    $0x0,%eax
}
801074b8:	c9                   	leave  
801074b9:	c3                   	ret    

801074ba <sys_wait>:

int
sys_wait(void)
{
801074ba:	55                   	push   %ebp
801074bb:	89 e5                	mov    %esp,%ebp
801074bd:	83 ec 08             	sub    $0x8,%esp
  return wait();
801074c0:	e8 b6 d6 ff ff       	call   80104b7b <wait>
}
801074c5:	c9                   	leave  
801074c6:	c3                   	ret    

801074c7 <sys_kill>:

int
sys_kill(void)
{
801074c7:	55                   	push   %ebp
801074c8:	89 e5                	mov    %esp,%ebp
801074ca:	83 ec 18             	sub    $0x18,%esp
  int pid;

  if(argint(0, &pid) < 0)
801074cd:	83 ec 08             	sub    $0x8,%esp
801074d0:	8d 45 f4             	lea    -0xc(%ebp),%eax
801074d3:	50                   	push   %eax
801074d4:	6a 00                	push   $0x0
801074d6:	e8 03 f1 ff ff       	call   801065de <argint>
801074db:	83 c4 10             	add    $0x10,%esp
801074de:	85 c0                	test   %eax,%eax
801074e0:	79 07                	jns    801074e9 <sys_kill+0x22>
    return -1;
801074e2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801074e7:	eb 0f                	jmp    801074f8 <sys_kill+0x31>
  return kill(pid);
801074e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074ec:	83 ec 0c             	sub    $0xc,%esp
801074ef:	50                   	push   %eax
801074f0:	e8 0c df ff ff       	call   80105401 <kill>
801074f5:	83 c4 10             	add    $0x10,%esp
}
801074f8:	c9                   	leave  
801074f9:	c3                   	ret    

801074fa <sys_getpid>:

int
sys_getpid(void)
{
801074fa:	55                   	push   %ebp
801074fb:	89 e5                	mov    %esp,%ebp
801074fd:	83 ec 08             	sub    $0x8,%esp
  return myproc()->pid;
80107500:	e8 11 ce ff ff       	call   80104316 <myproc>
80107505:	8b 40 10             	mov    0x10(%eax),%eax
}
80107508:	c9                   	leave  
80107509:	c3                   	ret    

8010750a <sys_sbrk>:

int
sys_sbrk(void)
{
8010750a:	55                   	push   %ebp
8010750b:	89 e5                	mov    %esp,%ebp
8010750d:	83 ec 18             	sub    $0x18,%esp
  int addr;
  int n;

  if(argint(0, &n) < 0)
80107510:	83 ec 08             	sub    $0x8,%esp
80107513:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107516:	50                   	push   %eax
80107517:	6a 00                	push   $0x0
80107519:	e8 c0 f0 ff ff       	call   801065de <argint>
8010751e:	83 c4 10             	add    $0x10,%esp
80107521:	85 c0                	test   %eax,%eax
80107523:	79 07                	jns    8010752c <sys_sbrk+0x22>
    return -1;
80107525:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010752a:	eb 27                	jmp    80107553 <sys_sbrk+0x49>
  addr = myproc()->sz;
8010752c:	e8 e5 cd ff ff       	call   80104316 <myproc>
80107531:	8b 00                	mov    (%eax),%eax
80107533:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(growproc(n) < 0)
80107536:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107539:	83 ec 0c             	sub    $0xc,%esp
8010753c:	50                   	push   %eax
8010753d:	e8 83 d0 ff ff       	call   801045c5 <growproc>
80107542:	83 c4 10             	add    $0x10,%esp
80107545:	85 c0                	test   %eax,%eax
80107547:	79 07                	jns    80107550 <sys_sbrk+0x46>
    return -1;
80107549:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010754e:	eb 03                	jmp    80107553 <sys_sbrk+0x49>
  return addr;
80107550:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80107553:	c9                   	leave  
80107554:	c3                   	ret    

80107555 <sys_sleep>:

int
sys_sleep(void)
{
80107555:	55                   	push   %ebp
80107556:	89 e5                	mov    %esp,%ebp
80107558:	83 ec 18             	sub    $0x18,%esp
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
8010755b:	83 ec 08             	sub    $0x8,%esp
8010755e:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107561:	50                   	push   %eax
80107562:	6a 00                	push   $0x0
80107564:	e8 75 f0 ff ff       	call   801065de <argint>
80107569:	83 c4 10             	add    $0x10,%esp
8010756c:	85 c0                	test   %eax,%eax
8010756e:	79 07                	jns    80107577 <sys_sleep+0x22>
    return -1;
80107570:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107575:	eb 76                	jmp    801075ed <sys_sleep+0x98>
  acquire(&tickslock);
80107577:	83 ec 0c             	sub    $0xc,%esp
8010757a:	68 20 73 11 80       	push   $0x80117320
8010757f:	e8 a9 ea ff ff       	call   8010602d <acquire>
80107584:	83 c4 10             	add    $0x10,%esp
  ticks0 = ticks;
80107587:	a1 54 73 11 80       	mov    0x80117354,%eax
8010758c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(ticks - ticks0 < n){
8010758f:	eb 38                	jmp    801075c9 <sys_sleep+0x74>
    if(myproc()->killed){
80107591:	e8 80 cd ff ff       	call   80104316 <myproc>
80107596:	8b 40 24             	mov    0x24(%eax),%eax
80107599:	85 c0                	test   %eax,%eax
8010759b:	74 17                	je     801075b4 <sys_sleep+0x5f>
      release(&tickslock);
8010759d:	83 ec 0c             	sub    $0xc,%esp
801075a0:	68 20 73 11 80       	push   $0x80117320
801075a5:	e8 f1 ea ff ff       	call   8010609b <release>
801075aa:	83 c4 10             	add    $0x10,%esp
      return -1;
801075ad:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801075b2:	eb 39                	jmp    801075ed <sys_sleep+0x98>
    }
    sleep(&ticks, &tickslock);
801075b4:	83 ec 08             	sub    $0x8,%esp
801075b7:	68 20 73 11 80       	push   $0x80117320
801075bc:	68 54 73 11 80       	push   $0x80117354
801075c1:	e8 86 dc ff ff       	call   8010524c <sleep>
801075c6:	83 c4 10             	add    $0x10,%esp
  while(ticks - ticks0 < n){
801075c9:	a1 54 73 11 80       	mov    0x80117354,%eax
801075ce:	2b 45 f4             	sub    -0xc(%ebp),%eax
801075d1:	8b 55 f0             	mov    -0x10(%ebp),%edx
801075d4:	39 d0                	cmp    %edx,%eax
801075d6:	72 b9                	jb     80107591 <sys_sleep+0x3c>
  }
  release(&tickslock);
801075d8:	83 ec 0c             	sub    $0xc,%esp
801075db:	68 20 73 11 80       	push   $0x80117320
801075e0:	e8 b6 ea ff ff       	call   8010609b <release>
801075e5:	83 c4 10             	add    $0x10,%esp
  return 0;
801075e8:	b8 00 00 00 00       	mov    $0x0,%eax
}
801075ed:	c9                   	leave  
801075ee:	c3                   	ret    

801075ef <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
int
sys_uptime(void)
{
801075ef:	55                   	push   %ebp
801075f0:	89 e5                	mov    %esp,%ebp
801075f2:	83 ec 18             	sub    $0x18,%esp
  uint xticks;

  acquire(&tickslock);
801075f5:	83 ec 0c             	sub    $0xc,%esp
801075f8:	68 20 73 11 80       	push   $0x80117320
801075fd:	e8 2b ea ff ff       	call   8010602d <acquire>
80107602:	83 c4 10             	add    $0x10,%esp
  xticks = ticks;
80107605:	a1 54 73 11 80       	mov    0x80117354,%eax
8010760a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&tickslock);
8010760d:	83 ec 0c             	sub    $0xc,%esp
80107610:	68 20 73 11 80       	push   $0x80117320
80107615:	e8 81 ea ff ff       	call   8010609b <release>
8010761a:	83 c4 10             	add    $0x10,%esp
  return xticks;
8010761d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80107620:	c9                   	leave  
80107621:	c3                   	ret    

80107622 <sys_print_proc>:

void
sys_print_proc(void)
{
80107622:	55                   	push   %ebp
80107623:	89 e5                	mov    %esp,%ebp
80107625:	83 ec 08             	sub    $0x8,%esp
  // since ptable is only accessible in proc.c
  // we need yet another wrapper or
  // could've used extern keyword
  print_proc();
80107628:	e8 66 e1 ff ff       	call   80105793 <print_proc>
}
8010762d:	90                   	nop
8010762e:	c9                   	leave  
8010762f:	c3                   	ret    

80107630 <sys_change_queue>:

int
sys_change_queue(void)
{
80107630:	55                   	push   %ebp
80107631:	89 e5                	mov    %esp,%ebp
80107633:	83 ec 18             	sub    $0x18,%esp
  int pid;
  int queueID;
  if(argint(0, &pid) < 0 ||
80107636:	83 ec 08             	sub    $0x8,%esp
80107639:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010763c:	50                   	push   %eax
8010763d:	6a 00                	push   $0x0
8010763f:	e8 9a ef ff ff       	call   801065de <argint>
80107644:	83 c4 10             	add    $0x10,%esp
80107647:	85 c0                	test   %eax,%eax
80107649:	78 34                	js     8010767f <sys_change_queue+0x4f>
    argint(1, &queueID) < 0 ||
8010764b:	83 ec 08             	sub    $0x8,%esp
8010764e:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107651:	50                   	push   %eax
80107652:	6a 01                	push   $0x1
80107654:	e8 85 ef ff ff       	call   801065de <argint>
80107659:	83 c4 10             	add    $0x10,%esp
  if(argint(0, &pid) < 0 ||
8010765c:	85 c0                	test   %eax,%eax
8010765e:	78 1f                	js     8010767f <sys_change_queue+0x4f>
    (queueID != DEF &&
80107660:	8b 45 f0             	mov    -0x10(%ebp),%eax
    argint(1, &queueID) < 0 ||
80107663:	85 c0                	test   %eax,%eax
80107665:	74 1f                	je     80107686 <sys_change_queue+0x56>
    queueID != RR &&
80107667:	8b 45 f0             	mov    -0x10(%ebp),%eax
    (queueID != DEF &&
8010766a:	83 f8 01             	cmp    $0x1,%eax
8010766d:	74 17                	je     80107686 <sys_change_queue+0x56>
    queueID != LCFS &&
8010766f:	8b 45 f0             	mov    -0x10(%ebp),%eax
    queueID != RR &&
80107672:	83 f8 02             	cmp    $0x2,%eax
80107675:	74 0f                	je     80107686 <sys_change_queue+0x56>
    queueID != BJF))
80107677:	8b 45 f0             	mov    -0x10(%ebp),%eax
    queueID != LCFS &&
8010767a:	83 f8 03             	cmp    $0x3,%eax
8010767d:	74 07                	je     80107686 <sys_change_queue+0x56>
  {
    return -1;
8010767f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107684:	eb 18                	jmp    8010769e <sys_change_queue+0x6e>
  }
  change_queue(pid, queueID);
80107686:	8b 55 f0             	mov    -0x10(%ebp),%edx
80107689:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010768c:	83 ec 08             	sub    $0x8,%esp
8010768f:	52                   	push   %edx
80107690:	50                   	push   %eax
80107691:	e8 e8 e4 ff ff       	call   80105b7e <change_queue>
80107696:	83 c4 10             	add    $0x10,%esp
  return 0;
80107699:	b8 00 00 00 00       	mov    $0x0,%eax
}
8010769e:	c9                   	leave  
8010769f:	c3                   	ret    

801076a0 <sys_change_local_bjf>:

int
sys_change_local_bjf(void)
{
801076a0:	55                   	push   %ebp
801076a1:	89 e5                	mov    %esp,%ebp
801076a3:	56                   	push   %esi
801076a4:	53                   	push   %ebx
801076a5:	83 ec 20             	sub    $0x20,%esp
  int pRatio;
  int aRatio;
  int eRatio;
  int sRatio;

  if(argint(0, &pid) < 0 || argint(1, &pRatio) < 0 || argint(2, &aRatio) < 0 || argint(3, &eRatio) < 0 || argint(4, &sRatio) < 0)
801076a8:	83 ec 08             	sub    $0x8,%esp
801076ab:	8d 45 f4             	lea    -0xc(%ebp),%eax
801076ae:	50                   	push   %eax
801076af:	6a 00                	push   $0x0
801076b1:	e8 28 ef ff ff       	call   801065de <argint>
801076b6:	83 c4 10             	add    $0x10,%esp
801076b9:	85 c0                	test   %eax,%eax
801076bb:	78 54                	js     80107711 <sys_change_local_bjf+0x71>
801076bd:	83 ec 08             	sub    $0x8,%esp
801076c0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801076c3:	50                   	push   %eax
801076c4:	6a 01                	push   $0x1
801076c6:	e8 13 ef ff ff       	call   801065de <argint>
801076cb:	83 c4 10             	add    $0x10,%esp
801076ce:	85 c0                	test   %eax,%eax
801076d0:	78 3f                	js     80107711 <sys_change_local_bjf+0x71>
801076d2:	83 ec 08             	sub    $0x8,%esp
801076d5:	8d 45 ec             	lea    -0x14(%ebp),%eax
801076d8:	50                   	push   %eax
801076d9:	6a 02                	push   $0x2
801076db:	e8 fe ee ff ff       	call   801065de <argint>
801076e0:	83 c4 10             	add    $0x10,%esp
801076e3:	85 c0                	test   %eax,%eax
801076e5:	78 2a                	js     80107711 <sys_change_local_bjf+0x71>
801076e7:	83 ec 08             	sub    $0x8,%esp
801076ea:	8d 45 e8             	lea    -0x18(%ebp),%eax
801076ed:	50                   	push   %eax
801076ee:	6a 03                	push   $0x3
801076f0:	e8 e9 ee ff ff       	call   801065de <argint>
801076f5:	83 c4 10             	add    $0x10,%esp
801076f8:	85 c0                	test   %eax,%eax
801076fa:	78 15                	js     80107711 <sys_change_local_bjf+0x71>
801076fc:	83 ec 08             	sub    $0x8,%esp
801076ff:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80107702:	50                   	push   %eax
80107703:	6a 04                	push   $0x4
80107705:	e8 d4 ee ff ff       	call   801065de <argint>
8010770a:	83 c4 10             	add    $0x10,%esp
8010770d:	85 c0                	test   %eax,%eax
8010770f:	79 07                	jns    80107718 <sys_change_local_bjf+0x78>
    return -1;
80107711:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107716:	eb 1f                	jmp    80107737 <sys_change_local_bjf+0x97>

  return change_local_bjf(pid, pRatio, aRatio, eRatio, sRatio);
80107718:	8b 75 e4             	mov    -0x1c(%ebp),%esi
8010771b:	8b 5d e8             	mov    -0x18(%ebp),%ebx
8010771e:	8b 4d ec             	mov    -0x14(%ebp),%ecx
80107721:	8b 55 f0             	mov    -0x10(%ebp),%edx
80107724:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107727:	83 ec 0c             	sub    $0xc,%esp
8010772a:	56                   	push   %esi
8010772b:	53                   	push   %ebx
8010772c:	51                   	push   %ecx
8010772d:	52                   	push   %edx
8010772e:	50                   	push   %eax
8010772f:	e8 ff e5 ff ff       	call   80105d33 <change_local_bjf>
80107734:	83 c4 20             	add    $0x20,%esp
}
80107737:	8d 65 f8             	lea    -0x8(%ebp),%esp
8010773a:	5b                   	pop    %ebx
8010773b:	5e                   	pop    %esi
8010773c:	5d                   	pop    %ebp
8010773d:	c3                   	ret    

8010773e <sys_change_global_bjf>:
int
sys_change_global_bjf(void)
{
8010773e:	55                   	push   %ebp
8010773f:	89 e5                	mov    %esp,%ebp
80107741:	53                   	push   %ebx
80107742:	83 ec 14             	sub    $0x14,%esp
  int pRatio;
  int aRatio;
  int eRatio;
  int sRatio;

  if(argint(0, &pRatio) < 0 || argint(1, &aRatio) < 0 || argint(2, &eRatio) < 0 || argint(3, &sRatio) < 0)
80107745:	83 ec 08             	sub    $0x8,%esp
80107748:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010774b:	50                   	push   %eax
8010774c:	6a 00                	push   $0x0
8010774e:	e8 8b ee ff ff       	call   801065de <argint>
80107753:	83 c4 10             	add    $0x10,%esp
80107756:	85 c0                	test   %eax,%eax
80107758:	78 3f                	js     80107799 <sys_change_global_bjf+0x5b>
8010775a:	83 ec 08             	sub    $0x8,%esp
8010775d:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107760:	50                   	push   %eax
80107761:	6a 01                	push   $0x1
80107763:	e8 76 ee ff ff       	call   801065de <argint>
80107768:	83 c4 10             	add    $0x10,%esp
8010776b:	85 c0                	test   %eax,%eax
8010776d:	78 2a                	js     80107799 <sys_change_global_bjf+0x5b>
8010776f:	83 ec 08             	sub    $0x8,%esp
80107772:	8d 45 ec             	lea    -0x14(%ebp),%eax
80107775:	50                   	push   %eax
80107776:	6a 02                	push   $0x2
80107778:	e8 61 ee ff ff       	call   801065de <argint>
8010777d:	83 c4 10             	add    $0x10,%esp
80107780:	85 c0                	test   %eax,%eax
80107782:	78 15                	js     80107799 <sys_change_global_bjf+0x5b>
80107784:	83 ec 08             	sub    $0x8,%esp
80107787:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010778a:	50                   	push   %eax
8010778b:	6a 03                	push   $0x3
8010778d:	e8 4c ee ff ff       	call   801065de <argint>
80107792:	83 c4 10             	add    $0x10,%esp
80107795:	85 c0                	test   %eax,%eax
80107797:	79 07                	jns    801077a0 <sys_change_global_bjf+0x62>
    return -1;
80107799:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010779e:	eb 18                	jmp    801077b8 <sys_change_global_bjf+0x7a>

  return change_global_bjf(pRatio, aRatio, eRatio, sRatio);
801077a0:	8b 5d e8             	mov    -0x18(%ebp),%ebx
801077a3:	8b 4d ec             	mov    -0x14(%ebp),%ecx
801077a6:	8b 55 f0             	mov    -0x10(%ebp),%edx
801077a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801077ac:	53                   	push   %ebx
801077ad:	51                   	push   %ecx
801077ae:	52                   	push   %edx
801077af:	50                   	push   %eax
801077b0:	e8 36 e6 ff ff       	call   80105deb <change_global_bjf>
801077b5:	83 c4 10             	add    $0x10,%esp
801077b8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801077bb:	c9                   	leave  
801077bc:	c3                   	ret    

801077bd <alltraps>:
801077bd:	1e                   	push   %ds
801077be:	06                   	push   %es
801077bf:	0f a0                	push   %fs
801077c1:	0f a8                	push   %gs
801077c3:	60                   	pusha  
801077c4:	66 b8 10 00          	mov    $0x10,%ax
801077c8:	8e d8                	mov    %eax,%ds
801077ca:	8e c0                	mov    %eax,%es
801077cc:	54                   	push   %esp
801077cd:	e8 d7 01 00 00       	call   801079a9 <trap>
801077d2:	83 c4 04             	add    $0x4,%esp

801077d5 <trapret>:
801077d5:	61                   	popa   
801077d6:	0f a9                	pop    %gs
801077d8:	0f a1                	pop    %fs
801077da:	07                   	pop    %es
801077db:	1f                   	pop    %ds
801077dc:	83 c4 08             	add    $0x8,%esp
801077df:	cf                   	iret   

801077e0 <lidt>:
{
801077e0:	55                   	push   %ebp
801077e1:	89 e5                	mov    %esp,%ebp
801077e3:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
801077e6:	8b 45 0c             	mov    0xc(%ebp),%eax
801077e9:	83 e8 01             	sub    $0x1,%eax
801077ec:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801077f0:	8b 45 08             	mov    0x8(%ebp),%eax
801077f3:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801077f7:	8b 45 08             	mov    0x8(%ebp),%eax
801077fa:	c1 e8 10             	shr    $0x10,%eax
801077fd:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lidt (%0)" : : "r" (pd));
80107801:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107804:	0f 01 18             	lidtl  (%eax)
}
80107807:	90                   	nop
80107808:	c9                   	leave  
80107809:	c3                   	ret    

8010780a <rcr2>:

static inline uint
rcr2(void)
{
8010780a:	55                   	push   %ebp
8010780b:	89 e5                	mov    %esp,%ebp
8010780d:	83 ec 10             	sub    $0x10,%esp
  uint val;
  asm volatile("movl %%cr2,%0" : "=r" (val));
80107810:	0f 20 d0             	mov    %cr2,%eax
80107813:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return val;
80107816:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80107819:	c9                   	leave  
8010781a:	c3                   	ret    

8010781b <tvinit>:
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
8010781b:	55                   	push   %ebp
8010781c:	89 e5                	mov    %esp,%ebp
8010781e:	83 ec 18             	sub    $0x18,%esp
  int i;

  for(i = 0; i < 256; i++)
80107821:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80107828:	e9 c3 00 00 00       	jmp    801078f0 <tvinit+0xd5>
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
8010782d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107830:	8b 04 85 88 c0 10 80 	mov    -0x7fef3f78(,%eax,4),%eax
80107837:	89 c2                	mov    %eax,%edx
80107839:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010783c:	66 89 14 c5 20 6b 11 	mov    %dx,-0x7fee94e0(,%eax,8)
80107843:	80 
80107844:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107847:	66 c7 04 c5 22 6b 11 	movw   $0x8,-0x7fee94de(,%eax,8)
8010784e:	80 08 00 
80107851:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107854:	0f b6 14 c5 24 6b 11 	movzbl -0x7fee94dc(,%eax,8),%edx
8010785b:	80 
8010785c:	83 e2 e0             	and    $0xffffffe0,%edx
8010785f:	88 14 c5 24 6b 11 80 	mov    %dl,-0x7fee94dc(,%eax,8)
80107866:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107869:	0f b6 14 c5 24 6b 11 	movzbl -0x7fee94dc(,%eax,8),%edx
80107870:	80 
80107871:	83 e2 1f             	and    $0x1f,%edx
80107874:	88 14 c5 24 6b 11 80 	mov    %dl,-0x7fee94dc(,%eax,8)
8010787b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010787e:	0f b6 14 c5 25 6b 11 	movzbl -0x7fee94db(,%eax,8),%edx
80107885:	80 
80107886:	83 e2 f0             	and    $0xfffffff0,%edx
80107889:	83 ca 0e             	or     $0xe,%edx
8010788c:	88 14 c5 25 6b 11 80 	mov    %dl,-0x7fee94db(,%eax,8)
80107893:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107896:	0f b6 14 c5 25 6b 11 	movzbl -0x7fee94db(,%eax,8),%edx
8010789d:	80 
8010789e:	83 e2 ef             	and    $0xffffffef,%edx
801078a1:	88 14 c5 25 6b 11 80 	mov    %dl,-0x7fee94db(,%eax,8)
801078a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078ab:	0f b6 14 c5 25 6b 11 	movzbl -0x7fee94db(,%eax,8),%edx
801078b2:	80 
801078b3:	83 e2 9f             	and    $0xffffff9f,%edx
801078b6:	88 14 c5 25 6b 11 80 	mov    %dl,-0x7fee94db(,%eax,8)
801078bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078c0:	0f b6 14 c5 25 6b 11 	movzbl -0x7fee94db(,%eax,8),%edx
801078c7:	80 
801078c8:	83 ca 80             	or     $0xffffff80,%edx
801078cb:	88 14 c5 25 6b 11 80 	mov    %dl,-0x7fee94db(,%eax,8)
801078d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078d5:	8b 04 85 88 c0 10 80 	mov    -0x7fef3f78(,%eax,4),%eax
801078dc:	c1 e8 10             	shr    $0x10,%eax
801078df:	89 c2                	mov    %eax,%edx
801078e1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801078e4:	66 89 14 c5 26 6b 11 	mov    %dx,-0x7fee94da(,%eax,8)
801078eb:	80 
  for(i = 0; i < 256; i++)
801078ec:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801078f0:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
801078f7:	0f 8e 30 ff ff ff    	jle    8010782d <tvinit+0x12>
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);
801078fd:	a1 88 c1 10 80       	mov    0x8010c188,%eax
80107902:	66 a3 20 6d 11 80    	mov    %ax,0x80116d20
80107908:	66 c7 05 22 6d 11 80 	movw   $0x8,0x80116d22
8010790f:	08 00 
80107911:	0f b6 05 24 6d 11 80 	movzbl 0x80116d24,%eax
80107918:	83 e0 e0             	and    $0xffffffe0,%eax
8010791b:	a2 24 6d 11 80       	mov    %al,0x80116d24
80107920:	0f b6 05 24 6d 11 80 	movzbl 0x80116d24,%eax
80107927:	83 e0 1f             	and    $0x1f,%eax
8010792a:	a2 24 6d 11 80       	mov    %al,0x80116d24
8010792f:	0f b6 05 25 6d 11 80 	movzbl 0x80116d25,%eax
80107936:	83 c8 0f             	or     $0xf,%eax
80107939:	a2 25 6d 11 80       	mov    %al,0x80116d25
8010793e:	0f b6 05 25 6d 11 80 	movzbl 0x80116d25,%eax
80107945:	83 e0 ef             	and    $0xffffffef,%eax
80107948:	a2 25 6d 11 80       	mov    %al,0x80116d25
8010794d:	0f b6 05 25 6d 11 80 	movzbl 0x80116d25,%eax
80107954:	83 c8 60             	or     $0x60,%eax
80107957:	a2 25 6d 11 80       	mov    %al,0x80116d25
8010795c:	0f b6 05 25 6d 11 80 	movzbl 0x80116d25,%eax
80107963:	83 c8 80             	or     $0xffffff80,%eax
80107966:	a2 25 6d 11 80       	mov    %al,0x80116d25
8010796b:	a1 88 c1 10 80       	mov    0x8010c188,%eax
80107970:	c1 e8 10             	shr    $0x10,%eax
80107973:	66 a3 26 6d 11 80    	mov    %ax,0x80116d26

  initlock(&tickslock, "time");
80107979:	83 ec 08             	sub    $0x8,%esp
8010797c:	68 e8 9c 10 80       	push   $0x80109ce8
80107981:	68 20 73 11 80       	push   $0x80117320
80107986:	e8 80 e6 ff ff       	call   8010600b <initlock>
8010798b:	83 c4 10             	add    $0x10,%esp
}
8010798e:	90                   	nop
8010798f:	c9                   	leave  
80107990:	c3                   	ret    

80107991 <idtinit>:

void
idtinit(void)
{
80107991:	55                   	push   %ebp
80107992:	89 e5                	mov    %esp,%ebp
  lidt(idt, sizeof(idt));
80107994:	68 00 08 00 00       	push   $0x800
80107999:	68 20 6b 11 80       	push   $0x80116b20
8010799e:	e8 3d fe ff ff       	call   801077e0 <lidt>
801079a3:	83 c4 08             	add    $0x8,%esp
}
801079a6:	90                   	nop
801079a7:	c9                   	leave  
801079a8:	c3                   	ret    

801079a9 <trap>:

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
801079a9:	55                   	push   %ebp
801079aa:	89 e5                	mov    %esp,%ebp
801079ac:	57                   	push   %edi
801079ad:	56                   	push   %esi
801079ae:	53                   	push   %ebx
801079af:	83 ec 1c             	sub    $0x1c,%esp
  if(tf->trapno == T_SYSCALL){
801079b2:	8b 45 08             	mov    0x8(%ebp),%eax
801079b5:	8b 40 30             	mov    0x30(%eax),%eax
801079b8:	83 f8 40             	cmp    $0x40,%eax
801079bb:	75 3b                	jne    801079f8 <trap+0x4f>
    if(myproc()->killed)
801079bd:	e8 54 c9 ff ff       	call   80104316 <myproc>
801079c2:	8b 40 24             	mov    0x24(%eax),%eax
801079c5:	85 c0                	test   %eax,%eax
801079c7:	74 05                	je     801079ce <trap+0x25>
      exit();
801079c9:	e8 7c d0 ff ff       	call   80104a4a <exit>
    myproc()->tf = tf;
801079ce:	e8 43 c9 ff ff       	call   80104316 <myproc>
801079d3:	8b 55 08             	mov    0x8(%ebp),%edx
801079d6:	89 50 18             	mov    %edx,0x18(%eax)
    syscall();
801079d9:	e8 cc ec ff ff       	call   801066aa <syscall>
    if(myproc()->killed)
801079de:	e8 33 c9 ff ff       	call   80104316 <myproc>
801079e3:	8b 40 24             	mov    0x24(%eax),%eax
801079e6:	85 c0                	test   %eax,%eax
801079e8:	0f 84 8a 02 00 00    	je     80107c78 <trap+0x2cf>
      exit();
801079ee:	e8 57 d0 ff ff       	call   80104a4a <exit>
    return;
801079f3:	e9 80 02 00 00       	jmp    80107c78 <trap+0x2cf>
  }

  switch(tf->trapno){
801079f8:	8b 45 08             	mov    0x8(%ebp),%eax
801079fb:	8b 40 30             	mov    0x30(%eax),%eax
801079fe:	83 e8 20             	sub    $0x20,%eax
80107a01:	83 f8 1f             	cmp    $0x1f,%eax
80107a04:	0f 87 ba 00 00 00    	ja     80107ac4 <trap+0x11b>
80107a0a:	8b 04 85 90 9d 10 80 	mov    -0x7fef6270(,%eax,4),%eax
80107a11:	ff e0                	jmp    *%eax
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
80107a13:	e8 6b c8 ff ff       	call   80104283 <cpuid>
80107a18:	85 c0                	test   %eax,%eax
80107a1a:	75 42                	jne    80107a5e <trap+0xb5>
      acquire(&tickslock);
80107a1c:	83 ec 0c             	sub    $0xc,%esp
80107a1f:	68 20 73 11 80       	push   $0x80117320
80107a24:	e8 04 e6 ff ff       	call   8010602d <acquire>
80107a29:	83 c4 10             	add    $0x10,%esp
      ticks++;
80107a2c:	a1 54 73 11 80       	mov    0x80117354,%eax
80107a31:	83 c0 01             	add    $0x1,%eax
80107a34:	a3 54 73 11 80       	mov    %eax,0x80117354
      agingMechanism();
80107a39:	e8 7b e0 ff ff       	call   80105ab9 <agingMechanism>
      wakeup(&ticks);
80107a3e:	83 ec 0c             	sub    $0xc,%esp
80107a41:	68 54 73 11 80       	push   $0x80117354
80107a46:	e8 7f d9 ff ff       	call   801053ca <wakeup>
80107a4b:	83 c4 10             	add    $0x10,%esp
      release(&tickslock);
80107a4e:	83 ec 0c             	sub    $0xc,%esp
80107a51:	68 20 73 11 80       	push   $0x80117320
80107a56:	e8 40 e6 ff ff       	call   8010609b <release>
80107a5b:	83 c4 10             	add    $0x10,%esp
    }
    lapiceoi();
80107a5e:	e8 af b5 ff ff       	call   80103012 <lapiceoi>
    break;
80107a63:	e9 11 01 00 00       	jmp    80107b79 <trap+0x1d0>
  case T_IRQ0 + IRQ_IDE:
    ideintr();
80107a68:	e8 19 ae ff ff       	call   80102886 <ideintr>
    lapiceoi();
80107a6d:	e8 a0 b5 ff ff       	call   80103012 <lapiceoi>
    break;
80107a72:	e9 02 01 00 00       	jmp    80107b79 <trap+0x1d0>
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
80107a77:	e8 db b3 ff ff       	call   80102e57 <kbdintr>
    lapiceoi();
80107a7c:	e8 91 b5 ff ff       	call   80103012 <lapiceoi>
    break;
80107a81:	e9 f3 00 00 00       	jmp    80107b79 <trap+0x1d0>
  case T_IRQ0 + IRQ_COM1:
    uartintr();
80107a86:	e8 c3 03 00 00       	call   80107e4e <uartintr>
    lapiceoi();
80107a8b:	e8 82 b5 ff ff       	call   80103012 <lapiceoi>
    break;
80107a90:	e9 e4 00 00 00       	jmp    80107b79 <trap+0x1d0>
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_SPURIOUS:
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80107a95:	8b 45 08             	mov    0x8(%ebp),%eax
80107a98:	8b 70 38             	mov    0x38(%eax),%esi
            cpuid(), tf->cs, tf->eip);
80107a9b:	8b 45 08             	mov    0x8(%ebp),%eax
80107a9e:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
    cprintf("cpu%d: spurious interrupt at %x:%x\n",
80107aa2:	0f b7 d8             	movzwl %ax,%ebx
80107aa5:	e8 d9 c7 ff ff       	call   80104283 <cpuid>
80107aaa:	56                   	push   %esi
80107aab:	53                   	push   %ebx
80107aac:	50                   	push   %eax
80107aad:	68 f0 9c 10 80       	push   $0x80109cf0
80107ab2:	e8 49 89 ff ff       	call   80100400 <cprintf>
80107ab7:	83 c4 10             	add    $0x10,%esp
    lapiceoi();
80107aba:	e8 53 b5 ff ff       	call   80103012 <lapiceoi>
    break;
80107abf:	e9 b5 00 00 00       	jmp    80107b79 <trap+0x1d0>

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
80107ac4:	e8 4d c8 ff ff       	call   80104316 <myproc>
80107ac9:	85 c0                	test   %eax,%eax
80107acb:	74 11                	je     80107ade <trap+0x135>
80107acd:	8b 45 08             	mov    0x8(%ebp),%eax
80107ad0:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80107ad4:	0f b7 c0             	movzwl %ax,%eax
80107ad7:	83 e0 03             	and    $0x3,%eax
80107ada:	85 c0                	test   %eax,%eax
80107adc:	75 39                	jne    80107b17 <trap+0x16e>
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
80107ade:	e8 27 fd ff ff       	call   8010780a <rcr2>
80107ae3:	89 c3                	mov    %eax,%ebx
80107ae5:	8b 45 08             	mov    0x8(%ebp),%eax
80107ae8:	8b 70 38             	mov    0x38(%eax),%esi
80107aeb:	e8 93 c7 ff ff       	call   80104283 <cpuid>
80107af0:	8b 55 08             	mov    0x8(%ebp),%edx
80107af3:	8b 52 30             	mov    0x30(%edx),%edx
80107af6:	83 ec 0c             	sub    $0xc,%esp
80107af9:	53                   	push   %ebx
80107afa:	56                   	push   %esi
80107afb:	50                   	push   %eax
80107afc:	52                   	push   %edx
80107afd:	68 14 9d 10 80       	push   $0x80109d14
80107b02:	e8 f9 88 ff ff       	call   80100400 <cprintf>
80107b07:	83 c4 20             	add    $0x20,%esp
              tf->trapno, cpuid(), tf->eip, rcr2());
      panic("trap");
80107b0a:	83 ec 0c             	sub    $0xc,%esp
80107b0d:	68 46 9d 10 80       	push   $0x80109d46
80107b12:	e8 9e 8a ff ff       	call   801005b5 <panic>
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107b17:	e8 ee fc ff ff       	call   8010780a <rcr2>
80107b1c:	89 c6                	mov    %eax,%esi
80107b1e:	8b 45 08             	mov    0x8(%ebp),%eax
80107b21:	8b 40 38             	mov    0x38(%eax),%eax
80107b24:	89 45 e4             	mov    %eax,-0x1c(%ebp)
80107b27:	e8 57 c7 ff ff       	call   80104283 <cpuid>
80107b2c:	89 c3                	mov    %eax,%ebx
80107b2e:	8b 45 08             	mov    0x8(%ebp),%eax
80107b31:	8b 48 34             	mov    0x34(%eax),%ecx
80107b34:	89 4d e0             	mov    %ecx,-0x20(%ebp)
80107b37:	8b 45 08             	mov    0x8(%ebp),%eax
80107b3a:	8b 78 30             	mov    0x30(%eax),%edi
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
80107b3d:	e8 d4 c7 ff ff       	call   80104316 <myproc>
80107b42:	8d 50 6c             	lea    0x6c(%eax),%edx
80107b45:	89 55 dc             	mov    %edx,-0x24(%ebp)
80107b48:	e8 c9 c7 ff ff       	call   80104316 <myproc>
    cprintf("pid %d %s: trap %d err %d on cpu %d "
80107b4d:	8b 40 10             	mov    0x10(%eax),%eax
80107b50:	56                   	push   %esi
80107b51:	ff 75 e4             	push   -0x1c(%ebp)
80107b54:	53                   	push   %ebx
80107b55:	ff 75 e0             	push   -0x20(%ebp)
80107b58:	57                   	push   %edi
80107b59:	ff 75 dc             	push   -0x24(%ebp)
80107b5c:	50                   	push   %eax
80107b5d:	68 4c 9d 10 80       	push   $0x80109d4c
80107b62:	e8 99 88 ff ff       	call   80100400 <cprintf>
80107b67:	83 c4 20             	add    $0x20,%esp
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
80107b6a:	e8 a7 c7 ff ff       	call   80104316 <myproc>
80107b6f:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
80107b76:	eb 01                	jmp    80107b79 <trap+0x1d0>
    break;
80107b78:	90                   	nop
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107b79:	e8 98 c7 ff ff       	call   80104316 <myproc>
80107b7e:	85 c0                	test   %eax,%eax
80107b80:	74 23                	je     80107ba5 <trap+0x1fc>
80107b82:	e8 8f c7 ff ff       	call   80104316 <myproc>
80107b87:	8b 40 24             	mov    0x24(%eax),%eax
80107b8a:	85 c0                	test   %eax,%eax
80107b8c:	74 17                	je     80107ba5 <trap+0x1fc>
80107b8e:	8b 45 08             	mov    0x8(%ebp),%eax
80107b91:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80107b95:	0f b7 c0             	movzwl %ax,%eax
80107b98:	83 e0 03             	and    $0x3,%eax
80107b9b:	83 f8 03             	cmp    $0x3,%eax
80107b9e:	75 05                	jne    80107ba5 <trap+0x1fc>
    exit();
80107ba0:	e8 a5 ce ff ff       	call   80104a4a <exit>

  // Force process to give up CPU on clock tick.
  // If interrupts were on while locks held, would need to check nlock.
  if(myproc() && myproc()->state == RUNNING &&
80107ba5:	e8 6c c7 ff ff       	call   80104316 <myproc>
80107baa:	85 c0                	test   %eax,%eax
80107bac:	0f 84 98 00 00 00    	je     80107c4a <trap+0x2a1>
80107bb2:	e8 5f c7 ff ff       	call   80104316 <myproc>
80107bb7:	8b 40 0c             	mov    0xc(%eax),%eax
80107bba:	83 f8 04             	cmp    $0x4,%eax
80107bbd:	0f 85 87 00 00 00    	jne    80107c4a <trap+0x2a1>
     tf->trapno == T_IRQ0+IRQ_TIMER)
80107bc3:	8b 45 08             	mov    0x8(%ebp),%eax
80107bc6:	8b 40 30             	mov    0x30(%eax),%eax
  if(myproc() && myproc()->state == RUNNING &&
80107bc9:	83 f8 20             	cmp    $0x20,%eax
80107bcc:	75 7c                	jne    80107c4a <trap+0x2a1>
    {
      myproc()->running_ticks++;
80107bce:	e8 43 c7 ff ff       	call   80104316 <myproc>
80107bd3:	8b 90 9c 00 00 00    	mov    0x9c(%eax),%edx
80107bd9:	83 c2 01             	add    $0x1,%edx
80107bdc:	89 90 9c 00 00 00    	mov    %edx,0x9c(%eax)
      if(myproc()->q_type == RR && myproc()->running_ticks >= TIME_SLOT)
80107be2:	e8 2f c7 ff ff       	call   80104316 <myproc>
80107be7:	8b 40 7c             	mov    0x7c(%eax),%eax
80107bea:	83 f8 01             	cmp    $0x1,%eax
80107bed:	75 17                	jne    80107c06 <trap+0x25d>
80107bef:	e8 22 c7 ff ff       	call   80104316 <myproc>
80107bf4:	8b 80 9c 00 00 00    	mov    0x9c(%eax),%eax
80107bfa:	83 f8 04             	cmp    $0x4,%eax
80107bfd:	76 07                	jbe    80107c06 <trap+0x25d>
      {
        yield();
80107bff:	e8 f7 d4 ff ff       	call   801050fb <yield>
80107c04:	eb 44                	jmp    80107c4a <trap+0x2a1>
      }
      else if(myproc()->q_type == DEF || myproc()->q_type == LCFS)
80107c06:	e8 0b c7 ff ff       	call   80104316 <myproc>
80107c0b:	8b 40 7c             	mov    0x7c(%eax),%eax
80107c0e:	85 c0                	test   %eax,%eax
80107c10:	74 0d                	je     80107c1f <trap+0x276>
80107c12:	e8 ff c6 ff ff       	call   80104316 <myproc>
80107c17:	8b 40 7c             	mov    0x7c(%eax),%eax
80107c1a:	83 f8 02             	cmp    $0x2,%eax
80107c1d:	75 07                	jne    80107c26 <trap+0x27d>
      {
        yield();
80107c1f:	e8 d7 d4 ff ff       	call   801050fb <yield>
80107c24:	eb 24                	jmp    80107c4a <trap+0x2a1>
      }
      else if(myproc()->q_type == BJF && myproc()->running_ticks > BJF_UPPER_BOUND)
80107c26:	e8 eb c6 ff ff       	call   80104316 <myproc>
80107c2b:	8b 40 7c             	mov    0x7c(%eax),%eax
80107c2e:	83 f8 03             	cmp    $0x3,%eax
80107c31:	75 17                	jne    80107c4a <trap+0x2a1>
80107c33:	e8 de c6 ff ff       	call   80104316 <myproc>
80107c38:	8b 80 9c 00 00 00    	mov    0x9c(%eax),%eax
80107c3e:	3d f4 01 00 00       	cmp    $0x1f4,%eax
80107c43:	76 05                	jbe    80107c4a <trap+0x2a1>
      {
        yield();
80107c45:	e8 b1 d4 ff ff       	call   801050fb <yield>
      }
      // else let the process to be done or finish its time slot --> do not yield!
    }

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
80107c4a:	e8 c7 c6 ff ff       	call   80104316 <myproc>
80107c4f:	85 c0                	test   %eax,%eax
80107c51:	74 26                	je     80107c79 <trap+0x2d0>
80107c53:	e8 be c6 ff ff       	call   80104316 <myproc>
80107c58:	8b 40 24             	mov    0x24(%eax),%eax
80107c5b:	85 c0                	test   %eax,%eax
80107c5d:	74 1a                	je     80107c79 <trap+0x2d0>
80107c5f:	8b 45 08             	mov    0x8(%ebp),%eax
80107c62:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80107c66:	0f b7 c0             	movzwl %ax,%eax
80107c69:	83 e0 03             	and    $0x3,%eax
80107c6c:	83 f8 03             	cmp    $0x3,%eax
80107c6f:	75 08                	jne    80107c79 <trap+0x2d0>
    exit();
80107c71:	e8 d4 cd ff ff       	call   80104a4a <exit>
80107c76:	eb 01                	jmp    80107c79 <trap+0x2d0>
    return;
80107c78:	90                   	nop
80107c79:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107c7c:	5b                   	pop    %ebx
80107c7d:	5e                   	pop    %esi
80107c7e:	5f                   	pop    %edi
80107c7f:	5d                   	pop    %ebp
80107c80:	c3                   	ret    

80107c81 <inb>:
{
80107c81:	55                   	push   %ebp
80107c82:	89 e5                	mov    %esp,%ebp
80107c84:	83 ec 14             	sub    $0x14,%esp
80107c87:	8b 45 08             	mov    0x8(%ebp),%eax
80107c8a:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
  asm volatile("in %1,%0" : "=a" (data) : "d" (port));
80107c8e:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80107c92:	89 c2                	mov    %eax,%edx
80107c94:	ec                   	in     (%dx),%al
80107c95:	88 45 ff             	mov    %al,-0x1(%ebp)
  return data;
80107c98:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
}
80107c9c:	c9                   	leave  
80107c9d:	c3                   	ret    

80107c9e <outb>:
{
80107c9e:	55                   	push   %ebp
80107c9f:	89 e5                	mov    %esp,%ebp
80107ca1:	83 ec 08             	sub    $0x8,%esp
80107ca4:	8b 45 08             	mov    0x8(%ebp),%eax
80107ca7:	8b 55 0c             	mov    0xc(%ebp),%edx
80107caa:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80107cae:	89 d0                	mov    %edx,%eax
80107cb0:	88 45 f8             	mov    %al,-0x8(%ebp)
  asm volatile("out %0,%1" : : "a" (data), "d" (port));
80107cb3:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80107cb7:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80107cbb:	ee                   	out    %al,(%dx)
}
80107cbc:	90                   	nop
80107cbd:	c9                   	leave  
80107cbe:	c3                   	ret    

80107cbf <uartinit>:

static int uart;    // is there a uart?

void
uartinit(void)
{
80107cbf:	55                   	push   %ebp
80107cc0:	89 e5                	mov    %esp,%ebp
80107cc2:	83 ec 18             	sub    $0x18,%esp
  char *p;

  // Turn off the FIFO
  outb(COM1+2, 0);
80107cc5:	6a 00                	push   $0x0
80107cc7:	68 fa 03 00 00       	push   $0x3fa
80107ccc:	e8 cd ff ff ff       	call   80107c9e <outb>
80107cd1:	83 c4 08             	add    $0x8,%esp

  // 9600 baud, 8 data bits, 1 stop bit, parity off.
  outb(COM1+3, 0x80);    // Unlock divisor
80107cd4:	68 80 00 00 00       	push   $0x80
80107cd9:	68 fb 03 00 00       	push   $0x3fb
80107cde:	e8 bb ff ff ff       	call   80107c9e <outb>
80107ce3:	83 c4 08             	add    $0x8,%esp
  outb(COM1+0, 115200/9600);
80107ce6:	6a 0c                	push   $0xc
80107ce8:	68 f8 03 00 00       	push   $0x3f8
80107ced:	e8 ac ff ff ff       	call   80107c9e <outb>
80107cf2:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0);
80107cf5:	6a 00                	push   $0x0
80107cf7:	68 f9 03 00 00       	push   $0x3f9
80107cfc:	e8 9d ff ff ff       	call   80107c9e <outb>
80107d01:	83 c4 08             	add    $0x8,%esp
  outb(COM1+3, 0x03);    // Lock divisor, 8 data bits.
80107d04:	6a 03                	push   $0x3
80107d06:	68 fb 03 00 00       	push   $0x3fb
80107d0b:	e8 8e ff ff ff       	call   80107c9e <outb>
80107d10:	83 c4 08             	add    $0x8,%esp
  outb(COM1+4, 0);
80107d13:	6a 00                	push   $0x0
80107d15:	68 fc 03 00 00       	push   $0x3fc
80107d1a:	e8 7f ff ff ff       	call   80107c9e <outb>
80107d1f:	83 c4 08             	add    $0x8,%esp
  outb(COM1+1, 0x01);    // Enable receive interrupts.
80107d22:	6a 01                	push   $0x1
80107d24:	68 f9 03 00 00       	push   $0x3f9
80107d29:	e8 70 ff ff ff       	call   80107c9e <outb>
80107d2e:	83 c4 08             	add    $0x8,%esp

  // If status is 0xFF, no serial port.
  if(inb(COM1+5) == 0xFF)
80107d31:	68 fd 03 00 00       	push   $0x3fd
80107d36:	e8 46 ff ff ff       	call   80107c81 <inb>
80107d3b:	83 c4 04             	add    $0x4,%esp
80107d3e:	3c ff                	cmp    $0xff,%al
80107d40:	74 61                	je     80107da3 <uartinit+0xe4>
    return;
  uart = 1;
80107d42:	c7 05 58 73 11 80 01 	movl   $0x1,0x80117358
80107d49:	00 00 00 

  // Acknowledge pre-existing interrupt conditions;
  // enable interrupts.
  inb(COM1+2);
80107d4c:	68 fa 03 00 00       	push   $0x3fa
80107d51:	e8 2b ff ff ff       	call   80107c81 <inb>
80107d56:	83 c4 04             	add    $0x4,%esp
  inb(COM1+0);
80107d59:	68 f8 03 00 00       	push   $0x3f8
80107d5e:	e8 1e ff ff ff       	call   80107c81 <inb>
80107d63:	83 c4 04             	add    $0x4,%esp
  ioapicenable(IRQ_COM1, 0);
80107d66:	83 ec 08             	sub    $0x8,%esp
80107d69:	6a 00                	push   $0x0
80107d6b:	6a 04                	push   $0x4
80107d6d:	e8 b2 ad ff ff       	call   80102b24 <ioapicenable>
80107d72:	83 c4 10             	add    $0x10,%esp

  // Announce that we're here.
  for(p="xv6...\n"; *p; p++)
80107d75:	c7 45 f4 10 9e 10 80 	movl   $0x80109e10,-0xc(%ebp)
80107d7c:	eb 19                	jmp    80107d97 <uartinit+0xd8>
    uartputc(*p);
80107d7e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d81:	0f b6 00             	movzbl (%eax),%eax
80107d84:	0f be c0             	movsbl %al,%eax
80107d87:	83 ec 0c             	sub    $0xc,%esp
80107d8a:	50                   	push   %eax
80107d8b:	e8 16 00 00 00       	call   80107da6 <uartputc>
80107d90:	83 c4 10             	add    $0x10,%esp
  for(p="xv6...\n"; *p; p++)
80107d93:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80107d97:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107d9a:	0f b6 00             	movzbl (%eax),%eax
80107d9d:	84 c0                	test   %al,%al
80107d9f:	75 dd                	jne    80107d7e <uartinit+0xbf>
80107da1:	eb 01                	jmp    80107da4 <uartinit+0xe5>
    return;
80107da3:	90                   	nop
}
80107da4:	c9                   	leave  
80107da5:	c3                   	ret    

80107da6 <uartputc>:

void
uartputc(int c)
{
80107da6:	55                   	push   %ebp
80107da7:	89 e5                	mov    %esp,%ebp
80107da9:	83 ec 18             	sub    $0x18,%esp
  int i;

  if(!uart)
80107dac:	a1 58 73 11 80       	mov    0x80117358,%eax
80107db1:	85 c0                	test   %eax,%eax
80107db3:	74 53                	je     80107e08 <uartputc+0x62>
    return;
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80107db5:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80107dbc:	eb 11                	jmp    80107dcf <uartputc+0x29>
    microdelay(10);
80107dbe:	83 ec 0c             	sub    $0xc,%esp
80107dc1:	6a 0a                	push   $0xa
80107dc3:	e8 65 b2 ff ff       	call   8010302d <microdelay>
80107dc8:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < 128 && !(inb(COM1+5) & 0x20); i++)
80107dcb:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80107dcf:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80107dd3:	7f 1a                	jg     80107def <uartputc+0x49>
80107dd5:	83 ec 0c             	sub    $0xc,%esp
80107dd8:	68 fd 03 00 00       	push   $0x3fd
80107ddd:	e8 9f fe ff ff       	call   80107c81 <inb>
80107de2:	83 c4 10             	add    $0x10,%esp
80107de5:	0f b6 c0             	movzbl %al,%eax
80107de8:	83 e0 20             	and    $0x20,%eax
80107deb:	85 c0                	test   %eax,%eax
80107ded:	74 cf                	je     80107dbe <uartputc+0x18>
  outb(COM1+0, c);
80107def:	8b 45 08             	mov    0x8(%ebp),%eax
80107df2:	0f b6 c0             	movzbl %al,%eax
80107df5:	83 ec 08             	sub    $0x8,%esp
80107df8:	50                   	push   %eax
80107df9:	68 f8 03 00 00       	push   $0x3f8
80107dfe:	e8 9b fe ff ff       	call   80107c9e <outb>
80107e03:	83 c4 10             	add    $0x10,%esp
80107e06:	eb 01                	jmp    80107e09 <uartputc+0x63>
    return;
80107e08:	90                   	nop
}
80107e09:	c9                   	leave  
80107e0a:	c3                   	ret    

80107e0b <uartgetc>:

static int
uartgetc(void)
{
80107e0b:	55                   	push   %ebp
80107e0c:	89 e5                	mov    %esp,%ebp
  if(!uart)
80107e0e:	a1 58 73 11 80       	mov    0x80117358,%eax
80107e13:	85 c0                	test   %eax,%eax
80107e15:	75 07                	jne    80107e1e <uartgetc+0x13>
    return -1;
80107e17:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107e1c:	eb 2e                	jmp    80107e4c <uartgetc+0x41>
  if(!(inb(COM1+5) & 0x01))
80107e1e:	68 fd 03 00 00       	push   $0x3fd
80107e23:	e8 59 fe ff ff       	call   80107c81 <inb>
80107e28:	83 c4 04             	add    $0x4,%esp
80107e2b:	0f b6 c0             	movzbl %al,%eax
80107e2e:	83 e0 01             	and    $0x1,%eax
80107e31:	85 c0                	test   %eax,%eax
80107e33:	75 07                	jne    80107e3c <uartgetc+0x31>
    return -1;
80107e35:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107e3a:	eb 10                	jmp    80107e4c <uartgetc+0x41>
  return inb(COM1+0);
80107e3c:	68 f8 03 00 00       	push   $0x3f8
80107e41:	e8 3b fe ff ff       	call   80107c81 <inb>
80107e46:	83 c4 04             	add    $0x4,%esp
80107e49:	0f b6 c0             	movzbl %al,%eax
}
80107e4c:	c9                   	leave  
80107e4d:	c3                   	ret    

80107e4e <uartintr>:

void
uartintr(void)
{
80107e4e:	55                   	push   %ebp
80107e4f:	89 e5                	mov    %esp,%ebp
80107e51:	83 ec 08             	sub    $0x8,%esp
  consoleintr(uartgetc);
80107e54:	83 ec 0c             	sub    $0xc,%esp
80107e57:	68 0b 7e 10 80       	push   $0x80107e0b
80107e5c:	e8 ee 89 ff ff       	call   8010084f <consoleintr>
80107e61:	83 c4 10             	add    $0x10,%esp
}
80107e64:	90                   	nop
80107e65:	c9                   	leave  
80107e66:	c3                   	ret    

80107e67 <vector0>:
80107e67:	6a 00                	push   $0x0
80107e69:	6a 00                	push   $0x0
80107e6b:	e9 4d f9 ff ff       	jmp    801077bd <alltraps>

80107e70 <vector1>:
80107e70:	6a 00                	push   $0x0
80107e72:	6a 01                	push   $0x1
80107e74:	e9 44 f9 ff ff       	jmp    801077bd <alltraps>

80107e79 <vector2>:
80107e79:	6a 00                	push   $0x0
80107e7b:	6a 02                	push   $0x2
80107e7d:	e9 3b f9 ff ff       	jmp    801077bd <alltraps>

80107e82 <vector3>:
80107e82:	6a 00                	push   $0x0
80107e84:	6a 03                	push   $0x3
80107e86:	e9 32 f9 ff ff       	jmp    801077bd <alltraps>

80107e8b <vector4>:
80107e8b:	6a 00                	push   $0x0
80107e8d:	6a 04                	push   $0x4
80107e8f:	e9 29 f9 ff ff       	jmp    801077bd <alltraps>

80107e94 <vector5>:
80107e94:	6a 00                	push   $0x0
80107e96:	6a 05                	push   $0x5
80107e98:	e9 20 f9 ff ff       	jmp    801077bd <alltraps>

80107e9d <vector6>:
80107e9d:	6a 00                	push   $0x0
80107e9f:	6a 06                	push   $0x6
80107ea1:	e9 17 f9 ff ff       	jmp    801077bd <alltraps>

80107ea6 <vector7>:
80107ea6:	6a 00                	push   $0x0
80107ea8:	6a 07                	push   $0x7
80107eaa:	e9 0e f9 ff ff       	jmp    801077bd <alltraps>

80107eaf <vector8>:
80107eaf:	6a 08                	push   $0x8
80107eb1:	e9 07 f9 ff ff       	jmp    801077bd <alltraps>

80107eb6 <vector9>:
80107eb6:	6a 00                	push   $0x0
80107eb8:	6a 09                	push   $0x9
80107eba:	e9 fe f8 ff ff       	jmp    801077bd <alltraps>

80107ebf <vector10>:
80107ebf:	6a 0a                	push   $0xa
80107ec1:	e9 f7 f8 ff ff       	jmp    801077bd <alltraps>

80107ec6 <vector11>:
80107ec6:	6a 0b                	push   $0xb
80107ec8:	e9 f0 f8 ff ff       	jmp    801077bd <alltraps>

80107ecd <vector12>:
80107ecd:	6a 0c                	push   $0xc
80107ecf:	e9 e9 f8 ff ff       	jmp    801077bd <alltraps>

80107ed4 <vector13>:
80107ed4:	6a 0d                	push   $0xd
80107ed6:	e9 e2 f8 ff ff       	jmp    801077bd <alltraps>

80107edb <vector14>:
80107edb:	6a 0e                	push   $0xe
80107edd:	e9 db f8 ff ff       	jmp    801077bd <alltraps>

80107ee2 <vector15>:
80107ee2:	6a 00                	push   $0x0
80107ee4:	6a 0f                	push   $0xf
80107ee6:	e9 d2 f8 ff ff       	jmp    801077bd <alltraps>

80107eeb <vector16>:
80107eeb:	6a 00                	push   $0x0
80107eed:	6a 10                	push   $0x10
80107eef:	e9 c9 f8 ff ff       	jmp    801077bd <alltraps>

80107ef4 <vector17>:
80107ef4:	6a 11                	push   $0x11
80107ef6:	e9 c2 f8 ff ff       	jmp    801077bd <alltraps>

80107efb <vector18>:
80107efb:	6a 00                	push   $0x0
80107efd:	6a 12                	push   $0x12
80107eff:	e9 b9 f8 ff ff       	jmp    801077bd <alltraps>

80107f04 <vector19>:
80107f04:	6a 00                	push   $0x0
80107f06:	6a 13                	push   $0x13
80107f08:	e9 b0 f8 ff ff       	jmp    801077bd <alltraps>

80107f0d <vector20>:
80107f0d:	6a 00                	push   $0x0
80107f0f:	6a 14                	push   $0x14
80107f11:	e9 a7 f8 ff ff       	jmp    801077bd <alltraps>

80107f16 <vector21>:
80107f16:	6a 00                	push   $0x0
80107f18:	6a 15                	push   $0x15
80107f1a:	e9 9e f8 ff ff       	jmp    801077bd <alltraps>

80107f1f <vector22>:
80107f1f:	6a 00                	push   $0x0
80107f21:	6a 16                	push   $0x16
80107f23:	e9 95 f8 ff ff       	jmp    801077bd <alltraps>

80107f28 <vector23>:
80107f28:	6a 00                	push   $0x0
80107f2a:	6a 17                	push   $0x17
80107f2c:	e9 8c f8 ff ff       	jmp    801077bd <alltraps>

80107f31 <vector24>:
80107f31:	6a 00                	push   $0x0
80107f33:	6a 18                	push   $0x18
80107f35:	e9 83 f8 ff ff       	jmp    801077bd <alltraps>

80107f3a <vector25>:
80107f3a:	6a 00                	push   $0x0
80107f3c:	6a 19                	push   $0x19
80107f3e:	e9 7a f8 ff ff       	jmp    801077bd <alltraps>

80107f43 <vector26>:
80107f43:	6a 00                	push   $0x0
80107f45:	6a 1a                	push   $0x1a
80107f47:	e9 71 f8 ff ff       	jmp    801077bd <alltraps>

80107f4c <vector27>:
80107f4c:	6a 00                	push   $0x0
80107f4e:	6a 1b                	push   $0x1b
80107f50:	e9 68 f8 ff ff       	jmp    801077bd <alltraps>

80107f55 <vector28>:
80107f55:	6a 00                	push   $0x0
80107f57:	6a 1c                	push   $0x1c
80107f59:	e9 5f f8 ff ff       	jmp    801077bd <alltraps>

80107f5e <vector29>:
80107f5e:	6a 00                	push   $0x0
80107f60:	6a 1d                	push   $0x1d
80107f62:	e9 56 f8 ff ff       	jmp    801077bd <alltraps>

80107f67 <vector30>:
80107f67:	6a 00                	push   $0x0
80107f69:	6a 1e                	push   $0x1e
80107f6b:	e9 4d f8 ff ff       	jmp    801077bd <alltraps>

80107f70 <vector31>:
80107f70:	6a 00                	push   $0x0
80107f72:	6a 1f                	push   $0x1f
80107f74:	e9 44 f8 ff ff       	jmp    801077bd <alltraps>

80107f79 <vector32>:
80107f79:	6a 00                	push   $0x0
80107f7b:	6a 20                	push   $0x20
80107f7d:	e9 3b f8 ff ff       	jmp    801077bd <alltraps>

80107f82 <vector33>:
80107f82:	6a 00                	push   $0x0
80107f84:	6a 21                	push   $0x21
80107f86:	e9 32 f8 ff ff       	jmp    801077bd <alltraps>

80107f8b <vector34>:
80107f8b:	6a 00                	push   $0x0
80107f8d:	6a 22                	push   $0x22
80107f8f:	e9 29 f8 ff ff       	jmp    801077bd <alltraps>

80107f94 <vector35>:
80107f94:	6a 00                	push   $0x0
80107f96:	6a 23                	push   $0x23
80107f98:	e9 20 f8 ff ff       	jmp    801077bd <alltraps>

80107f9d <vector36>:
80107f9d:	6a 00                	push   $0x0
80107f9f:	6a 24                	push   $0x24
80107fa1:	e9 17 f8 ff ff       	jmp    801077bd <alltraps>

80107fa6 <vector37>:
80107fa6:	6a 00                	push   $0x0
80107fa8:	6a 25                	push   $0x25
80107faa:	e9 0e f8 ff ff       	jmp    801077bd <alltraps>

80107faf <vector38>:
80107faf:	6a 00                	push   $0x0
80107fb1:	6a 26                	push   $0x26
80107fb3:	e9 05 f8 ff ff       	jmp    801077bd <alltraps>

80107fb8 <vector39>:
80107fb8:	6a 00                	push   $0x0
80107fba:	6a 27                	push   $0x27
80107fbc:	e9 fc f7 ff ff       	jmp    801077bd <alltraps>

80107fc1 <vector40>:
80107fc1:	6a 00                	push   $0x0
80107fc3:	6a 28                	push   $0x28
80107fc5:	e9 f3 f7 ff ff       	jmp    801077bd <alltraps>

80107fca <vector41>:
80107fca:	6a 00                	push   $0x0
80107fcc:	6a 29                	push   $0x29
80107fce:	e9 ea f7 ff ff       	jmp    801077bd <alltraps>

80107fd3 <vector42>:
80107fd3:	6a 00                	push   $0x0
80107fd5:	6a 2a                	push   $0x2a
80107fd7:	e9 e1 f7 ff ff       	jmp    801077bd <alltraps>

80107fdc <vector43>:
80107fdc:	6a 00                	push   $0x0
80107fde:	6a 2b                	push   $0x2b
80107fe0:	e9 d8 f7 ff ff       	jmp    801077bd <alltraps>

80107fe5 <vector44>:
80107fe5:	6a 00                	push   $0x0
80107fe7:	6a 2c                	push   $0x2c
80107fe9:	e9 cf f7 ff ff       	jmp    801077bd <alltraps>

80107fee <vector45>:
80107fee:	6a 00                	push   $0x0
80107ff0:	6a 2d                	push   $0x2d
80107ff2:	e9 c6 f7 ff ff       	jmp    801077bd <alltraps>

80107ff7 <vector46>:
80107ff7:	6a 00                	push   $0x0
80107ff9:	6a 2e                	push   $0x2e
80107ffb:	e9 bd f7 ff ff       	jmp    801077bd <alltraps>

80108000 <vector47>:
80108000:	6a 00                	push   $0x0
80108002:	6a 2f                	push   $0x2f
80108004:	e9 b4 f7 ff ff       	jmp    801077bd <alltraps>

80108009 <vector48>:
80108009:	6a 00                	push   $0x0
8010800b:	6a 30                	push   $0x30
8010800d:	e9 ab f7 ff ff       	jmp    801077bd <alltraps>

80108012 <vector49>:
80108012:	6a 00                	push   $0x0
80108014:	6a 31                	push   $0x31
80108016:	e9 a2 f7 ff ff       	jmp    801077bd <alltraps>

8010801b <vector50>:
8010801b:	6a 00                	push   $0x0
8010801d:	6a 32                	push   $0x32
8010801f:	e9 99 f7 ff ff       	jmp    801077bd <alltraps>

80108024 <vector51>:
80108024:	6a 00                	push   $0x0
80108026:	6a 33                	push   $0x33
80108028:	e9 90 f7 ff ff       	jmp    801077bd <alltraps>

8010802d <vector52>:
8010802d:	6a 00                	push   $0x0
8010802f:	6a 34                	push   $0x34
80108031:	e9 87 f7 ff ff       	jmp    801077bd <alltraps>

80108036 <vector53>:
80108036:	6a 00                	push   $0x0
80108038:	6a 35                	push   $0x35
8010803a:	e9 7e f7 ff ff       	jmp    801077bd <alltraps>

8010803f <vector54>:
8010803f:	6a 00                	push   $0x0
80108041:	6a 36                	push   $0x36
80108043:	e9 75 f7 ff ff       	jmp    801077bd <alltraps>

80108048 <vector55>:
80108048:	6a 00                	push   $0x0
8010804a:	6a 37                	push   $0x37
8010804c:	e9 6c f7 ff ff       	jmp    801077bd <alltraps>

80108051 <vector56>:
80108051:	6a 00                	push   $0x0
80108053:	6a 38                	push   $0x38
80108055:	e9 63 f7 ff ff       	jmp    801077bd <alltraps>

8010805a <vector57>:
8010805a:	6a 00                	push   $0x0
8010805c:	6a 39                	push   $0x39
8010805e:	e9 5a f7 ff ff       	jmp    801077bd <alltraps>

80108063 <vector58>:
80108063:	6a 00                	push   $0x0
80108065:	6a 3a                	push   $0x3a
80108067:	e9 51 f7 ff ff       	jmp    801077bd <alltraps>

8010806c <vector59>:
8010806c:	6a 00                	push   $0x0
8010806e:	6a 3b                	push   $0x3b
80108070:	e9 48 f7 ff ff       	jmp    801077bd <alltraps>

80108075 <vector60>:
80108075:	6a 00                	push   $0x0
80108077:	6a 3c                	push   $0x3c
80108079:	e9 3f f7 ff ff       	jmp    801077bd <alltraps>

8010807e <vector61>:
8010807e:	6a 00                	push   $0x0
80108080:	6a 3d                	push   $0x3d
80108082:	e9 36 f7 ff ff       	jmp    801077bd <alltraps>

80108087 <vector62>:
80108087:	6a 00                	push   $0x0
80108089:	6a 3e                	push   $0x3e
8010808b:	e9 2d f7 ff ff       	jmp    801077bd <alltraps>

80108090 <vector63>:
80108090:	6a 00                	push   $0x0
80108092:	6a 3f                	push   $0x3f
80108094:	e9 24 f7 ff ff       	jmp    801077bd <alltraps>

80108099 <vector64>:
80108099:	6a 00                	push   $0x0
8010809b:	6a 40                	push   $0x40
8010809d:	e9 1b f7 ff ff       	jmp    801077bd <alltraps>

801080a2 <vector65>:
801080a2:	6a 00                	push   $0x0
801080a4:	6a 41                	push   $0x41
801080a6:	e9 12 f7 ff ff       	jmp    801077bd <alltraps>

801080ab <vector66>:
801080ab:	6a 00                	push   $0x0
801080ad:	6a 42                	push   $0x42
801080af:	e9 09 f7 ff ff       	jmp    801077bd <alltraps>

801080b4 <vector67>:
801080b4:	6a 00                	push   $0x0
801080b6:	6a 43                	push   $0x43
801080b8:	e9 00 f7 ff ff       	jmp    801077bd <alltraps>

801080bd <vector68>:
801080bd:	6a 00                	push   $0x0
801080bf:	6a 44                	push   $0x44
801080c1:	e9 f7 f6 ff ff       	jmp    801077bd <alltraps>

801080c6 <vector69>:
801080c6:	6a 00                	push   $0x0
801080c8:	6a 45                	push   $0x45
801080ca:	e9 ee f6 ff ff       	jmp    801077bd <alltraps>

801080cf <vector70>:
801080cf:	6a 00                	push   $0x0
801080d1:	6a 46                	push   $0x46
801080d3:	e9 e5 f6 ff ff       	jmp    801077bd <alltraps>

801080d8 <vector71>:
801080d8:	6a 00                	push   $0x0
801080da:	6a 47                	push   $0x47
801080dc:	e9 dc f6 ff ff       	jmp    801077bd <alltraps>

801080e1 <vector72>:
801080e1:	6a 00                	push   $0x0
801080e3:	6a 48                	push   $0x48
801080e5:	e9 d3 f6 ff ff       	jmp    801077bd <alltraps>

801080ea <vector73>:
801080ea:	6a 00                	push   $0x0
801080ec:	6a 49                	push   $0x49
801080ee:	e9 ca f6 ff ff       	jmp    801077bd <alltraps>

801080f3 <vector74>:
801080f3:	6a 00                	push   $0x0
801080f5:	6a 4a                	push   $0x4a
801080f7:	e9 c1 f6 ff ff       	jmp    801077bd <alltraps>

801080fc <vector75>:
801080fc:	6a 00                	push   $0x0
801080fe:	6a 4b                	push   $0x4b
80108100:	e9 b8 f6 ff ff       	jmp    801077bd <alltraps>

80108105 <vector76>:
80108105:	6a 00                	push   $0x0
80108107:	6a 4c                	push   $0x4c
80108109:	e9 af f6 ff ff       	jmp    801077bd <alltraps>

8010810e <vector77>:
8010810e:	6a 00                	push   $0x0
80108110:	6a 4d                	push   $0x4d
80108112:	e9 a6 f6 ff ff       	jmp    801077bd <alltraps>

80108117 <vector78>:
80108117:	6a 00                	push   $0x0
80108119:	6a 4e                	push   $0x4e
8010811b:	e9 9d f6 ff ff       	jmp    801077bd <alltraps>

80108120 <vector79>:
80108120:	6a 00                	push   $0x0
80108122:	6a 4f                	push   $0x4f
80108124:	e9 94 f6 ff ff       	jmp    801077bd <alltraps>

80108129 <vector80>:
80108129:	6a 00                	push   $0x0
8010812b:	6a 50                	push   $0x50
8010812d:	e9 8b f6 ff ff       	jmp    801077bd <alltraps>

80108132 <vector81>:
80108132:	6a 00                	push   $0x0
80108134:	6a 51                	push   $0x51
80108136:	e9 82 f6 ff ff       	jmp    801077bd <alltraps>

8010813b <vector82>:
8010813b:	6a 00                	push   $0x0
8010813d:	6a 52                	push   $0x52
8010813f:	e9 79 f6 ff ff       	jmp    801077bd <alltraps>

80108144 <vector83>:
80108144:	6a 00                	push   $0x0
80108146:	6a 53                	push   $0x53
80108148:	e9 70 f6 ff ff       	jmp    801077bd <alltraps>

8010814d <vector84>:
8010814d:	6a 00                	push   $0x0
8010814f:	6a 54                	push   $0x54
80108151:	e9 67 f6 ff ff       	jmp    801077bd <alltraps>

80108156 <vector85>:
80108156:	6a 00                	push   $0x0
80108158:	6a 55                	push   $0x55
8010815a:	e9 5e f6 ff ff       	jmp    801077bd <alltraps>

8010815f <vector86>:
8010815f:	6a 00                	push   $0x0
80108161:	6a 56                	push   $0x56
80108163:	e9 55 f6 ff ff       	jmp    801077bd <alltraps>

80108168 <vector87>:
80108168:	6a 00                	push   $0x0
8010816a:	6a 57                	push   $0x57
8010816c:	e9 4c f6 ff ff       	jmp    801077bd <alltraps>

80108171 <vector88>:
80108171:	6a 00                	push   $0x0
80108173:	6a 58                	push   $0x58
80108175:	e9 43 f6 ff ff       	jmp    801077bd <alltraps>

8010817a <vector89>:
8010817a:	6a 00                	push   $0x0
8010817c:	6a 59                	push   $0x59
8010817e:	e9 3a f6 ff ff       	jmp    801077bd <alltraps>

80108183 <vector90>:
80108183:	6a 00                	push   $0x0
80108185:	6a 5a                	push   $0x5a
80108187:	e9 31 f6 ff ff       	jmp    801077bd <alltraps>

8010818c <vector91>:
8010818c:	6a 00                	push   $0x0
8010818e:	6a 5b                	push   $0x5b
80108190:	e9 28 f6 ff ff       	jmp    801077bd <alltraps>

80108195 <vector92>:
80108195:	6a 00                	push   $0x0
80108197:	6a 5c                	push   $0x5c
80108199:	e9 1f f6 ff ff       	jmp    801077bd <alltraps>

8010819e <vector93>:
8010819e:	6a 00                	push   $0x0
801081a0:	6a 5d                	push   $0x5d
801081a2:	e9 16 f6 ff ff       	jmp    801077bd <alltraps>

801081a7 <vector94>:
801081a7:	6a 00                	push   $0x0
801081a9:	6a 5e                	push   $0x5e
801081ab:	e9 0d f6 ff ff       	jmp    801077bd <alltraps>

801081b0 <vector95>:
801081b0:	6a 00                	push   $0x0
801081b2:	6a 5f                	push   $0x5f
801081b4:	e9 04 f6 ff ff       	jmp    801077bd <alltraps>

801081b9 <vector96>:
801081b9:	6a 00                	push   $0x0
801081bb:	6a 60                	push   $0x60
801081bd:	e9 fb f5 ff ff       	jmp    801077bd <alltraps>

801081c2 <vector97>:
801081c2:	6a 00                	push   $0x0
801081c4:	6a 61                	push   $0x61
801081c6:	e9 f2 f5 ff ff       	jmp    801077bd <alltraps>

801081cb <vector98>:
801081cb:	6a 00                	push   $0x0
801081cd:	6a 62                	push   $0x62
801081cf:	e9 e9 f5 ff ff       	jmp    801077bd <alltraps>

801081d4 <vector99>:
801081d4:	6a 00                	push   $0x0
801081d6:	6a 63                	push   $0x63
801081d8:	e9 e0 f5 ff ff       	jmp    801077bd <alltraps>

801081dd <vector100>:
801081dd:	6a 00                	push   $0x0
801081df:	6a 64                	push   $0x64
801081e1:	e9 d7 f5 ff ff       	jmp    801077bd <alltraps>

801081e6 <vector101>:
801081e6:	6a 00                	push   $0x0
801081e8:	6a 65                	push   $0x65
801081ea:	e9 ce f5 ff ff       	jmp    801077bd <alltraps>

801081ef <vector102>:
801081ef:	6a 00                	push   $0x0
801081f1:	6a 66                	push   $0x66
801081f3:	e9 c5 f5 ff ff       	jmp    801077bd <alltraps>

801081f8 <vector103>:
801081f8:	6a 00                	push   $0x0
801081fa:	6a 67                	push   $0x67
801081fc:	e9 bc f5 ff ff       	jmp    801077bd <alltraps>

80108201 <vector104>:
80108201:	6a 00                	push   $0x0
80108203:	6a 68                	push   $0x68
80108205:	e9 b3 f5 ff ff       	jmp    801077bd <alltraps>

8010820a <vector105>:
8010820a:	6a 00                	push   $0x0
8010820c:	6a 69                	push   $0x69
8010820e:	e9 aa f5 ff ff       	jmp    801077bd <alltraps>

80108213 <vector106>:
80108213:	6a 00                	push   $0x0
80108215:	6a 6a                	push   $0x6a
80108217:	e9 a1 f5 ff ff       	jmp    801077bd <alltraps>

8010821c <vector107>:
8010821c:	6a 00                	push   $0x0
8010821e:	6a 6b                	push   $0x6b
80108220:	e9 98 f5 ff ff       	jmp    801077bd <alltraps>

80108225 <vector108>:
80108225:	6a 00                	push   $0x0
80108227:	6a 6c                	push   $0x6c
80108229:	e9 8f f5 ff ff       	jmp    801077bd <alltraps>

8010822e <vector109>:
8010822e:	6a 00                	push   $0x0
80108230:	6a 6d                	push   $0x6d
80108232:	e9 86 f5 ff ff       	jmp    801077bd <alltraps>

80108237 <vector110>:
80108237:	6a 00                	push   $0x0
80108239:	6a 6e                	push   $0x6e
8010823b:	e9 7d f5 ff ff       	jmp    801077bd <alltraps>

80108240 <vector111>:
80108240:	6a 00                	push   $0x0
80108242:	6a 6f                	push   $0x6f
80108244:	e9 74 f5 ff ff       	jmp    801077bd <alltraps>

80108249 <vector112>:
80108249:	6a 00                	push   $0x0
8010824b:	6a 70                	push   $0x70
8010824d:	e9 6b f5 ff ff       	jmp    801077bd <alltraps>

80108252 <vector113>:
80108252:	6a 00                	push   $0x0
80108254:	6a 71                	push   $0x71
80108256:	e9 62 f5 ff ff       	jmp    801077bd <alltraps>

8010825b <vector114>:
8010825b:	6a 00                	push   $0x0
8010825d:	6a 72                	push   $0x72
8010825f:	e9 59 f5 ff ff       	jmp    801077bd <alltraps>

80108264 <vector115>:
80108264:	6a 00                	push   $0x0
80108266:	6a 73                	push   $0x73
80108268:	e9 50 f5 ff ff       	jmp    801077bd <alltraps>

8010826d <vector116>:
8010826d:	6a 00                	push   $0x0
8010826f:	6a 74                	push   $0x74
80108271:	e9 47 f5 ff ff       	jmp    801077bd <alltraps>

80108276 <vector117>:
80108276:	6a 00                	push   $0x0
80108278:	6a 75                	push   $0x75
8010827a:	e9 3e f5 ff ff       	jmp    801077bd <alltraps>

8010827f <vector118>:
8010827f:	6a 00                	push   $0x0
80108281:	6a 76                	push   $0x76
80108283:	e9 35 f5 ff ff       	jmp    801077bd <alltraps>

80108288 <vector119>:
80108288:	6a 00                	push   $0x0
8010828a:	6a 77                	push   $0x77
8010828c:	e9 2c f5 ff ff       	jmp    801077bd <alltraps>

80108291 <vector120>:
80108291:	6a 00                	push   $0x0
80108293:	6a 78                	push   $0x78
80108295:	e9 23 f5 ff ff       	jmp    801077bd <alltraps>

8010829a <vector121>:
8010829a:	6a 00                	push   $0x0
8010829c:	6a 79                	push   $0x79
8010829e:	e9 1a f5 ff ff       	jmp    801077bd <alltraps>

801082a3 <vector122>:
801082a3:	6a 00                	push   $0x0
801082a5:	6a 7a                	push   $0x7a
801082a7:	e9 11 f5 ff ff       	jmp    801077bd <alltraps>

801082ac <vector123>:
801082ac:	6a 00                	push   $0x0
801082ae:	6a 7b                	push   $0x7b
801082b0:	e9 08 f5 ff ff       	jmp    801077bd <alltraps>

801082b5 <vector124>:
801082b5:	6a 00                	push   $0x0
801082b7:	6a 7c                	push   $0x7c
801082b9:	e9 ff f4 ff ff       	jmp    801077bd <alltraps>

801082be <vector125>:
801082be:	6a 00                	push   $0x0
801082c0:	6a 7d                	push   $0x7d
801082c2:	e9 f6 f4 ff ff       	jmp    801077bd <alltraps>

801082c7 <vector126>:
801082c7:	6a 00                	push   $0x0
801082c9:	6a 7e                	push   $0x7e
801082cb:	e9 ed f4 ff ff       	jmp    801077bd <alltraps>

801082d0 <vector127>:
801082d0:	6a 00                	push   $0x0
801082d2:	6a 7f                	push   $0x7f
801082d4:	e9 e4 f4 ff ff       	jmp    801077bd <alltraps>

801082d9 <vector128>:
801082d9:	6a 00                	push   $0x0
801082db:	68 80 00 00 00       	push   $0x80
801082e0:	e9 d8 f4 ff ff       	jmp    801077bd <alltraps>

801082e5 <vector129>:
801082e5:	6a 00                	push   $0x0
801082e7:	68 81 00 00 00       	push   $0x81
801082ec:	e9 cc f4 ff ff       	jmp    801077bd <alltraps>

801082f1 <vector130>:
801082f1:	6a 00                	push   $0x0
801082f3:	68 82 00 00 00       	push   $0x82
801082f8:	e9 c0 f4 ff ff       	jmp    801077bd <alltraps>

801082fd <vector131>:
801082fd:	6a 00                	push   $0x0
801082ff:	68 83 00 00 00       	push   $0x83
80108304:	e9 b4 f4 ff ff       	jmp    801077bd <alltraps>

80108309 <vector132>:
80108309:	6a 00                	push   $0x0
8010830b:	68 84 00 00 00       	push   $0x84
80108310:	e9 a8 f4 ff ff       	jmp    801077bd <alltraps>

80108315 <vector133>:
80108315:	6a 00                	push   $0x0
80108317:	68 85 00 00 00       	push   $0x85
8010831c:	e9 9c f4 ff ff       	jmp    801077bd <alltraps>

80108321 <vector134>:
80108321:	6a 00                	push   $0x0
80108323:	68 86 00 00 00       	push   $0x86
80108328:	e9 90 f4 ff ff       	jmp    801077bd <alltraps>

8010832d <vector135>:
8010832d:	6a 00                	push   $0x0
8010832f:	68 87 00 00 00       	push   $0x87
80108334:	e9 84 f4 ff ff       	jmp    801077bd <alltraps>

80108339 <vector136>:
80108339:	6a 00                	push   $0x0
8010833b:	68 88 00 00 00       	push   $0x88
80108340:	e9 78 f4 ff ff       	jmp    801077bd <alltraps>

80108345 <vector137>:
80108345:	6a 00                	push   $0x0
80108347:	68 89 00 00 00       	push   $0x89
8010834c:	e9 6c f4 ff ff       	jmp    801077bd <alltraps>

80108351 <vector138>:
80108351:	6a 00                	push   $0x0
80108353:	68 8a 00 00 00       	push   $0x8a
80108358:	e9 60 f4 ff ff       	jmp    801077bd <alltraps>

8010835d <vector139>:
8010835d:	6a 00                	push   $0x0
8010835f:	68 8b 00 00 00       	push   $0x8b
80108364:	e9 54 f4 ff ff       	jmp    801077bd <alltraps>

80108369 <vector140>:
80108369:	6a 00                	push   $0x0
8010836b:	68 8c 00 00 00       	push   $0x8c
80108370:	e9 48 f4 ff ff       	jmp    801077bd <alltraps>

80108375 <vector141>:
80108375:	6a 00                	push   $0x0
80108377:	68 8d 00 00 00       	push   $0x8d
8010837c:	e9 3c f4 ff ff       	jmp    801077bd <alltraps>

80108381 <vector142>:
80108381:	6a 00                	push   $0x0
80108383:	68 8e 00 00 00       	push   $0x8e
80108388:	e9 30 f4 ff ff       	jmp    801077bd <alltraps>

8010838d <vector143>:
8010838d:	6a 00                	push   $0x0
8010838f:	68 8f 00 00 00       	push   $0x8f
80108394:	e9 24 f4 ff ff       	jmp    801077bd <alltraps>

80108399 <vector144>:
80108399:	6a 00                	push   $0x0
8010839b:	68 90 00 00 00       	push   $0x90
801083a0:	e9 18 f4 ff ff       	jmp    801077bd <alltraps>

801083a5 <vector145>:
801083a5:	6a 00                	push   $0x0
801083a7:	68 91 00 00 00       	push   $0x91
801083ac:	e9 0c f4 ff ff       	jmp    801077bd <alltraps>

801083b1 <vector146>:
801083b1:	6a 00                	push   $0x0
801083b3:	68 92 00 00 00       	push   $0x92
801083b8:	e9 00 f4 ff ff       	jmp    801077bd <alltraps>

801083bd <vector147>:
801083bd:	6a 00                	push   $0x0
801083bf:	68 93 00 00 00       	push   $0x93
801083c4:	e9 f4 f3 ff ff       	jmp    801077bd <alltraps>

801083c9 <vector148>:
801083c9:	6a 00                	push   $0x0
801083cb:	68 94 00 00 00       	push   $0x94
801083d0:	e9 e8 f3 ff ff       	jmp    801077bd <alltraps>

801083d5 <vector149>:
801083d5:	6a 00                	push   $0x0
801083d7:	68 95 00 00 00       	push   $0x95
801083dc:	e9 dc f3 ff ff       	jmp    801077bd <alltraps>

801083e1 <vector150>:
801083e1:	6a 00                	push   $0x0
801083e3:	68 96 00 00 00       	push   $0x96
801083e8:	e9 d0 f3 ff ff       	jmp    801077bd <alltraps>

801083ed <vector151>:
801083ed:	6a 00                	push   $0x0
801083ef:	68 97 00 00 00       	push   $0x97
801083f4:	e9 c4 f3 ff ff       	jmp    801077bd <alltraps>

801083f9 <vector152>:
801083f9:	6a 00                	push   $0x0
801083fb:	68 98 00 00 00       	push   $0x98
80108400:	e9 b8 f3 ff ff       	jmp    801077bd <alltraps>

80108405 <vector153>:
80108405:	6a 00                	push   $0x0
80108407:	68 99 00 00 00       	push   $0x99
8010840c:	e9 ac f3 ff ff       	jmp    801077bd <alltraps>

80108411 <vector154>:
80108411:	6a 00                	push   $0x0
80108413:	68 9a 00 00 00       	push   $0x9a
80108418:	e9 a0 f3 ff ff       	jmp    801077bd <alltraps>

8010841d <vector155>:
8010841d:	6a 00                	push   $0x0
8010841f:	68 9b 00 00 00       	push   $0x9b
80108424:	e9 94 f3 ff ff       	jmp    801077bd <alltraps>

80108429 <vector156>:
80108429:	6a 00                	push   $0x0
8010842b:	68 9c 00 00 00       	push   $0x9c
80108430:	e9 88 f3 ff ff       	jmp    801077bd <alltraps>

80108435 <vector157>:
80108435:	6a 00                	push   $0x0
80108437:	68 9d 00 00 00       	push   $0x9d
8010843c:	e9 7c f3 ff ff       	jmp    801077bd <alltraps>

80108441 <vector158>:
80108441:	6a 00                	push   $0x0
80108443:	68 9e 00 00 00       	push   $0x9e
80108448:	e9 70 f3 ff ff       	jmp    801077bd <alltraps>

8010844d <vector159>:
8010844d:	6a 00                	push   $0x0
8010844f:	68 9f 00 00 00       	push   $0x9f
80108454:	e9 64 f3 ff ff       	jmp    801077bd <alltraps>

80108459 <vector160>:
80108459:	6a 00                	push   $0x0
8010845b:	68 a0 00 00 00       	push   $0xa0
80108460:	e9 58 f3 ff ff       	jmp    801077bd <alltraps>

80108465 <vector161>:
80108465:	6a 00                	push   $0x0
80108467:	68 a1 00 00 00       	push   $0xa1
8010846c:	e9 4c f3 ff ff       	jmp    801077bd <alltraps>

80108471 <vector162>:
80108471:	6a 00                	push   $0x0
80108473:	68 a2 00 00 00       	push   $0xa2
80108478:	e9 40 f3 ff ff       	jmp    801077bd <alltraps>

8010847d <vector163>:
8010847d:	6a 00                	push   $0x0
8010847f:	68 a3 00 00 00       	push   $0xa3
80108484:	e9 34 f3 ff ff       	jmp    801077bd <alltraps>

80108489 <vector164>:
80108489:	6a 00                	push   $0x0
8010848b:	68 a4 00 00 00       	push   $0xa4
80108490:	e9 28 f3 ff ff       	jmp    801077bd <alltraps>

80108495 <vector165>:
80108495:	6a 00                	push   $0x0
80108497:	68 a5 00 00 00       	push   $0xa5
8010849c:	e9 1c f3 ff ff       	jmp    801077bd <alltraps>

801084a1 <vector166>:
801084a1:	6a 00                	push   $0x0
801084a3:	68 a6 00 00 00       	push   $0xa6
801084a8:	e9 10 f3 ff ff       	jmp    801077bd <alltraps>

801084ad <vector167>:
801084ad:	6a 00                	push   $0x0
801084af:	68 a7 00 00 00       	push   $0xa7
801084b4:	e9 04 f3 ff ff       	jmp    801077bd <alltraps>

801084b9 <vector168>:
801084b9:	6a 00                	push   $0x0
801084bb:	68 a8 00 00 00       	push   $0xa8
801084c0:	e9 f8 f2 ff ff       	jmp    801077bd <alltraps>

801084c5 <vector169>:
801084c5:	6a 00                	push   $0x0
801084c7:	68 a9 00 00 00       	push   $0xa9
801084cc:	e9 ec f2 ff ff       	jmp    801077bd <alltraps>

801084d1 <vector170>:
801084d1:	6a 00                	push   $0x0
801084d3:	68 aa 00 00 00       	push   $0xaa
801084d8:	e9 e0 f2 ff ff       	jmp    801077bd <alltraps>

801084dd <vector171>:
801084dd:	6a 00                	push   $0x0
801084df:	68 ab 00 00 00       	push   $0xab
801084e4:	e9 d4 f2 ff ff       	jmp    801077bd <alltraps>

801084e9 <vector172>:
801084e9:	6a 00                	push   $0x0
801084eb:	68 ac 00 00 00       	push   $0xac
801084f0:	e9 c8 f2 ff ff       	jmp    801077bd <alltraps>

801084f5 <vector173>:
801084f5:	6a 00                	push   $0x0
801084f7:	68 ad 00 00 00       	push   $0xad
801084fc:	e9 bc f2 ff ff       	jmp    801077bd <alltraps>

80108501 <vector174>:
80108501:	6a 00                	push   $0x0
80108503:	68 ae 00 00 00       	push   $0xae
80108508:	e9 b0 f2 ff ff       	jmp    801077bd <alltraps>

8010850d <vector175>:
8010850d:	6a 00                	push   $0x0
8010850f:	68 af 00 00 00       	push   $0xaf
80108514:	e9 a4 f2 ff ff       	jmp    801077bd <alltraps>

80108519 <vector176>:
80108519:	6a 00                	push   $0x0
8010851b:	68 b0 00 00 00       	push   $0xb0
80108520:	e9 98 f2 ff ff       	jmp    801077bd <alltraps>

80108525 <vector177>:
80108525:	6a 00                	push   $0x0
80108527:	68 b1 00 00 00       	push   $0xb1
8010852c:	e9 8c f2 ff ff       	jmp    801077bd <alltraps>

80108531 <vector178>:
80108531:	6a 00                	push   $0x0
80108533:	68 b2 00 00 00       	push   $0xb2
80108538:	e9 80 f2 ff ff       	jmp    801077bd <alltraps>

8010853d <vector179>:
8010853d:	6a 00                	push   $0x0
8010853f:	68 b3 00 00 00       	push   $0xb3
80108544:	e9 74 f2 ff ff       	jmp    801077bd <alltraps>

80108549 <vector180>:
80108549:	6a 00                	push   $0x0
8010854b:	68 b4 00 00 00       	push   $0xb4
80108550:	e9 68 f2 ff ff       	jmp    801077bd <alltraps>

80108555 <vector181>:
80108555:	6a 00                	push   $0x0
80108557:	68 b5 00 00 00       	push   $0xb5
8010855c:	e9 5c f2 ff ff       	jmp    801077bd <alltraps>

80108561 <vector182>:
80108561:	6a 00                	push   $0x0
80108563:	68 b6 00 00 00       	push   $0xb6
80108568:	e9 50 f2 ff ff       	jmp    801077bd <alltraps>

8010856d <vector183>:
8010856d:	6a 00                	push   $0x0
8010856f:	68 b7 00 00 00       	push   $0xb7
80108574:	e9 44 f2 ff ff       	jmp    801077bd <alltraps>

80108579 <vector184>:
80108579:	6a 00                	push   $0x0
8010857b:	68 b8 00 00 00       	push   $0xb8
80108580:	e9 38 f2 ff ff       	jmp    801077bd <alltraps>

80108585 <vector185>:
80108585:	6a 00                	push   $0x0
80108587:	68 b9 00 00 00       	push   $0xb9
8010858c:	e9 2c f2 ff ff       	jmp    801077bd <alltraps>

80108591 <vector186>:
80108591:	6a 00                	push   $0x0
80108593:	68 ba 00 00 00       	push   $0xba
80108598:	e9 20 f2 ff ff       	jmp    801077bd <alltraps>

8010859d <vector187>:
8010859d:	6a 00                	push   $0x0
8010859f:	68 bb 00 00 00       	push   $0xbb
801085a4:	e9 14 f2 ff ff       	jmp    801077bd <alltraps>

801085a9 <vector188>:
801085a9:	6a 00                	push   $0x0
801085ab:	68 bc 00 00 00       	push   $0xbc
801085b0:	e9 08 f2 ff ff       	jmp    801077bd <alltraps>

801085b5 <vector189>:
801085b5:	6a 00                	push   $0x0
801085b7:	68 bd 00 00 00       	push   $0xbd
801085bc:	e9 fc f1 ff ff       	jmp    801077bd <alltraps>

801085c1 <vector190>:
801085c1:	6a 00                	push   $0x0
801085c3:	68 be 00 00 00       	push   $0xbe
801085c8:	e9 f0 f1 ff ff       	jmp    801077bd <alltraps>

801085cd <vector191>:
801085cd:	6a 00                	push   $0x0
801085cf:	68 bf 00 00 00       	push   $0xbf
801085d4:	e9 e4 f1 ff ff       	jmp    801077bd <alltraps>

801085d9 <vector192>:
801085d9:	6a 00                	push   $0x0
801085db:	68 c0 00 00 00       	push   $0xc0
801085e0:	e9 d8 f1 ff ff       	jmp    801077bd <alltraps>

801085e5 <vector193>:
801085e5:	6a 00                	push   $0x0
801085e7:	68 c1 00 00 00       	push   $0xc1
801085ec:	e9 cc f1 ff ff       	jmp    801077bd <alltraps>

801085f1 <vector194>:
801085f1:	6a 00                	push   $0x0
801085f3:	68 c2 00 00 00       	push   $0xc2
801085f8:	e9 c0 f1 ff ff       	jmp    801077bd <alltraps>

801085fd <vector195>:
801085fd:	6a 00                	push   $0x0
801085ff:	68 c3 00 00 00       	push   $0xc3
80108604:	e9 b4 f1 ff ff       	jmp    801077bd <alltraps>

80108609 <vector196>:
80108609:	6a 00                	push   $0x0
8010860b:	68 c4 00 00 00       	push   $0xc4
80108610:	e9 a8 f1 ff ff       	jmp    801077bd <alltraps>

80108615 <vector197>:
80108615:	6a 00                	push   $0x0
80108617:	68 c5 00 00 00       	push   $0xc5
8010861c:	e9 9c f1 ff ff       	jmp    801077bd <alltraps>

80108621 <vector198>:
80108621:	6a 00                	push   $0x0
80108623:	68 c6 00 00 00       	push   $0xc6
80108628:	e9 90 f1 ff ff       	jmp    801077bd <alltraps>

8010862d <vector199>:
8010862d:	6a 00                	push   $0x0
8010862f:	68 c7 00 00 00       	push   $0xc7
80108634:	e9 84 f1 ff ff       	jmp    801077bd <alltraps>

80108639 <vector200>:
80108639:	6a 00                	push   $0x0
8010863b:	68 c8 00 00 00       	push   $0xc8
80108640:	e9 78 f1 ff ff       	jmp    801077bd <alltraps>

80108645 <vector201>:
80108645:	6a 00                	push   $0x0
80108647:	68 c9 00 00 00       	push   $0xc9
8010864c:	e9 6c f1 ff ff       	jmp    801077bd <alltraps>

80108651 <vector202>:
80108651:	6a 00                	push   $0x0
80108653:	68 ca 00 00 00       	push   $0xca
80108658:	e9 60 f1 ff ff       	jmp    801077bd <alltraps>

8010865d <vector203>:
8010865d:	6a 00                	push   $0x0
8010865f:	68 cb 00 00 00       	push   $0xcb
80108664:	e9 54 f1 ff ff       	jmp    801077bd <alltraps>

80108669 <vector204>:
80108669:	6a 00                	push   $0x0
8010866b:	68 cc 00 00 00       	push   $0xcc
80108670:	e9 48 f1 ff ff       	jmp    801077bd <alltraps>

80108675 <vector205>:
80108675:	6a 00                	push   $0x0
80108677:	68 cd 00 00 00       	push   $0xcd
8010867c:	e9 3c f1 ff ff       	jmp    801077bd <alltraps>

80108681 <vector206>:
80108681:	6a 00                	push   $0x0
80108683:	68 ce 00 00 00       	push   $0xce
80108688:	e9 30 f1 ff ff       	jmp    801077bd <alltraps>

8010868d <vector207>:
8010868d:	6a 00                	push   $0x0
8010868f:	68 cf 00 00 00       	push   $0xcf
80108694:	e9 24 f1 ff ff       	jmp    801077bd <alltraps>

80108699 <vector208>:
80108699:	6a 00                	push   $0x0
8010869b:	68 d0 00 00 00       	push   $0xd0
801086a0:	e9 18 f1 ff ff       	jmp    801077bd <alltraps>

801086a5 <vector209>:
801086a5:	6a 00                	push   $0x0
801086a7:	68 d1 00 00 00       	push   $0xd1
801086ac:	e9 0c f1 ff ff       	jmp    801077bd <alltraps>

801086b1 <vector210>:
801086b1:	6a 00                	push   $0x0
801086b3:	68 d2 00 00 00       	push   $0xd2
801086b8:	e9 00 f1 ff ff       	jmp    801077bd <alltraps>

801086bd <vector211>:
801086bd:	6a 00                	push   $0x0
801086bf:	68 d3 00 00 00       	push   $0xd3
801086c4:	e9 f4 f0 ff ff       	jmp    801077bd <alltraps>

801086c9 <vector212>:
801086c9:	6a 00                	push   $0x0
801086cb:	68 d4 00 00 00       	push   $0xd4
801086d0:	e9 e8 f0 ff ff       	jmp    801077bd <alltraps>

801086d5 <vector213>:
801086d5:	6a 00                	push   $0x0
801086d7:	68 d5 00 00 00       	push   $0xd5
801086dc:	e9 dc f0 ff ff       	jmp    801077bd <alltraps>

801086e1 <vector214>:
801086e1:	6a 00                	push   $0x0
801086e3:	68 d6 00 00 00       	push   $0xd6
801086e8:	e9 d0 f0 ff ff       	jmp    801077bd <alltraps>

801086ed <vector215>:
801086ed:	6a 00                	push   $0x0
801086ef:	68 d7 00 00 00       	push   $0xd7
801086f4:	e9 c4 f0 ff ff       	jmp    801077bd <alltraps>

801086f9 <vector216>:
801086f9:	6a 00                	push   $0x0
801086fb:	68 d8 00 00 00       	push   $0xd8
80108700:	e9 b8 f0 ff ff       	jmp    801077bd <alltraps>

80108705 <vector217>:
80108705:	6a 00                	push   $0x0
80108707:	68 d9 00 00 00       	push   $0xd9
8010870c:	e9 ac f0 ff ff       	jmp    801077bd <alltraps>

80108711 <vector218>:
80108711:	6a 00                	push   $0x0
80108713:	68 da 00 00 00       	push   $0xda
80108718:	e9 a0 f0 ff ff       	jmp    801077bd <alltraps>

8010871d <vector219>:
8010871d:	6a 00                	push   $0x0
8010871f:	68 db 00 00 00       	push   $0xdb
80108724:	e9 94 f0 ff ff       	jmp    801077bd <alltraps>

80108729 <vector220>:
80108729:	6a 00                	push   $0x0
8010872b:	68 dc 00 00 00       	push   $0xdc
80108730:	e9 88 f0 ff ff       	jmp    801077bd <alltraps>

80108735 <vector221>:
80108735:	6a 00                	push   $0x0
80108737:	68 dd 00 00 00       	push   $0xdd
8010873c:	e9 7c f0 ff ff       	jmp    801077bd <alltraps>

80108741 <vector222>:
80108741:	6a 00                	push   $0x0
80108743:	68 de 00 00 00       	push   $0xde
80108748:	e9 70 f0 ff ff       	jmp    801077bd <alltraps>

8010874d <vector223>:
8010874d:	6a 00                	push   $0x0
8010874f:	68 df 00 00 00       	push   $0xdf
80108754:	e9 64 f0 ff ff       	jmp    801077bd <alltraps>

80108759 <vector224>:
80108759:	6a 00                	push   $0x0
8010875b:	68 e0 00 00 00       	push   $0xe0
80108760:	e9 58 f0 ff ff       	jmp    801077bd <alltraps>

80108765 <vector225>:
80108765:	6a 00                	push   $0x0
80108767:	68 e1 00 00 00       	push   $0xe1
8010876c:	e9 4c f0 ff ff       	jmp    801077bd <alltraps>

80108771 <vector226>:
80108771:	6a 00                	push   $0x0
80108773:	68 e2 00 00 00       	push   $0xe2
80108778:	e9 40 f0 ff ff       	jmp    801077bd <alltraps>

8010877d <vector227>:
8010877d:	6a 00                	push   $0x0
8010877f:	68 e3 00 00 00       	push   $0xe3
80108784:	e9 34 f0 ff ff       	jmp    801077bd <alltraps>

80108789 <vector228>:
80108789:	6a 00                	push   $0x0
8010878b:	68 e4 00 00 00       	push   $0xe4
80108790:	e9 28 f0 ff ff       	jmp    801077bd <alltraps>

80108795 <vector229>:
80108795:	6a 00                	push   $0x0
80108797:	68 e5 00 00 00       	push   $0xe5
8010879c:	e9 1c f0 ff ff       	jmp    801077bd <alltraps>

801087a1 <vector230>:
801087a1:	6a 00                	push   $0x0
801087a3:	68 e6 00 00 00       	push   $0xe6
801087a8:	e9 10 f0 ff ff       	jmp    801077bd <alltraps>

801087ad <vector231>:
801087ad:	6a 00                	push   $0x0
801087af:	68 e7 00 00 00       	push   $0xe7
801087b4:	e9 04 f0 ff ff       	jmp    801077bd <alltraps>

801087b9 <vector232>:
801087b9:	6a 00                	push   $0x0
801087bb:	68 e8 00 00 00       	push   $0xe8
801087c0:	e9 f8 ef ff ff       	jmp    801077bd <alltraps>

801087c5 <vector233>:
801087c5:	6a 00                	push   $0x0
801087c7:	68 e9 00 00 00       	push   $0xe9
801087cc:	e9 ec ef ff ff       	jmp    801077bd <alltraps>

801087d1 <vector234>:
801087d1:	6a 00                	push   $0x0
801087d3:	68 ea 00 00 00       	push   $0xea
801087d8:	e9 e0 ef ff ff       	jmp    801077bd <alltraps>

801087dd <vector235>:
801087dd:	6a 00                	push   $0x0
801087df:	68 eb 00 00 00       	push   $0xeb
801087e4:	e9 d4 ef ff ff       	jmp    801077bd <alltraps>

801087e9 <vector236>:
801087e9:	6a 00                	push   $0x0
801087eb:	68 ec 00 00 00       	push   $0xec
801087f0:	e9 c8 ef ff ff       	jmp    801077bd <alltraps>

801087f5 <vector237>:
801087f5:	6a 00                	push   $0x0
801087f7:	68 ed 00 00 00       	push   $0xed
801087fc:	e9 bc ef ff ff       	jmp    801077bd <alltraps>

80108801 <vector238>:
80108801:	6a 00                	push   $0x0
80108803:	68 ee 00 00 00       	push   $0xee
80108808:	e9 b0 ef ff ff       	jmp    801077bd <alltraps>

8010880d <vector239>:
8010880d:	6a 00                	push   $0x0
8010880f:	68 ef 00 00 00       	push   $0xef
80108814:	e9 a4 ef ff ff       	jmp    801077bd <alltraps>

80108819 <vector240>:
80108819:	6a 00                	push   $0x0
8010881b:	68 f0 00 00 00       	push   $0xf0
80108820:	e9 98 ef ff ff       	jmp    801077bd <alltraps>

80108825 <vector241>:
80108825:	6a 00                	push   $0x0
80108827:	68 f1 00 00 00       	push   $0xf1
8010882c:	e9 8c ef ff ff       	jmp    801077bd <alltraps>

80108831 <vector242>:
80108831:	6a 00                	push   $0x0
80108833:	68 f2 00 00 00       	push   $0xf2
80108838:	e9 80 ef ff ff       	jmp    801077bd <alltraps>

8010883d <vector243>:
8010883d:	6a 00                	push   $0x0
8010883f:	68 f3 00 00 00       	push   $0xf3
80108844:	e9 74 ef ff ff       	jmp    801077bd <alltraps>

80108849 <vector244>:
80108849:	6a 00                	push   $0x0
8010884b:	68 f4 00 00 00       	push   $0xf4
80108850:	e9 68 ef ff ff       	jmp    801077bd <alltraps>

80108855 <vector245>:
80108855:	6a 00                	push   $0x0
80108857:	68 f5 00 00 00       	push   $0xf5
8010885c:	e9 5c ef ff ff       	jmp    801077bd <alltraps>

80108861 <vector246>:
80108861:	6a 00                	push   $0x0
80108863:	68 f6 00 00 00       	push   $0xf6
80108868:	e9 50 ef ff ff       	jmp    801077bd <alltraps>

8010886d <vector247>:
8010886d:	6a 00                	push   $0x0
8010886f:	68 f7 00 00 00       	push   $0xf7
80108874:	e9 44 ef ff ff       	jmp    801077bd <alltraps>

80108879 <vector248>:
80108879:	6a 00                	push   $0x0
8010887b:	68 f8 00 00 00       	push   $0xf8
80108880:	e9 38 ef ff ff       	jmp    801077bd <alltraps>

80108885 <vector249>:
80108885:	6a 00                	push   $0x0
80108887:	68 f9 00 00 00       	push   $0xf9
8010888c:	e9 2c ef ff ff       	jmp    801077bd <alltraps>

80108891 <vector250>:
80108891:	6a 00                	push   $0x0
80108893:	68 fa 00 00 00       	push   $0xfa
80108898:	e9 20 ef ff ff       	jmp    801077bd <alltraps>

8010889d <vector251>:
8010889d:	6a 00                	push   $0x0
8010889f:	68 fb 00 00 00       	push   $0xfb
801088a4:	e9 14 ef ff ff       	jmp    801077bd <alltraps>

801088a9 <vector252>:
801088a9:	6a 00                	push   $0x0
801088ab:	68 fc 00 00 00       	push   $0xfc
801088b0:	e9 08 ef ff ff       	jmp    801077bd <alltraps>

801088b5 <vector253>:
801088b5:	6a 00                	push   $0x0
801088b7:	68 fd 00 00 00       	push   $0xfd
801088bc:	e9 fc ee ff ff       	jmp    801077bd <alltraps>

801088c1 <vector254>:
801088c1:	6a 00                	push   $0x0
801088c3:	68 fe 00 00 00       	push   $0xfe
801088c8:	e9 f0 ee ff ff       	jmp    801077bd <alltraps>

801088cd <vector255>:
801088cd:	6a 00                	push   $0x0
801088cf:	68 ff 00 00 00       	push   $0xff
801088d4:	e9 e4 ee ff ff       	jmp    801077bd <alltraps>

801088d9 <lgdt>:
{
801088d9:	55                   	push   %ebp
801088da:	89 e5                	mov    %esp,%ebp
801088dc:	83 ec 10             	sub    $0x10,%esp
  pd[0] = size-1;
801088df:	8b 45 0c             	mov    0xc(%ebp),%eax
801088e2:	83 e8 01             	sub    $0x1,%eax
801088e5:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
  pd[1] = (uint)p;
801088e9:	8b 45 08             	mov    0x8(%ebp),%eax
801088ec:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  pd[2] = (uint)p >> 16;
801088f0:	8b 45 08             	mov    0x8(%ebp),%eax
801088f3:	c1 e8 10             	shr    $0x10,%eax
801088f6:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
  asm volatile("lgdt (%0)" : : "r" (pd));
801088fa:	8d 45 fa             	lea    -0x6(%ebp),%eax
801088fd:	0f 01 10             	lgdtl  (%eax)
}
80108900:	90                   	nop
80108901:	c9                   	leave  
80108902:	c3                   	ret    

80108903 <ltr>:
{
80108903:	55                   	push   %ebp
80108904:	89 e5                	mov    %esp,%ebp
80108906:	83 ec 04             	sub    $0x4,%esp
80108909:	8b 45 08             	mov    0x8(%ebp),%eax
8010890c:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
  asm volatile("ltr %0" : : "r" (sel));
80108910:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80108914:	0f 00 d8             	ltr    %ax
}
80108917:	90                   	nop
80108918:	c9                   	leave  
80108919:	c3                   	ret    

8010891a <lcr3>:

static inline void
lcr3(uint val)
{
8010891a:	55                   	push   %ebp
8010891b:	89 e5                	mov    %esp,%ebp
  asm volatile("movl %0,%%cr3" : : "r" (val));
8010891d:	8b 45 08             	mov    0x8(%ebp),%eax
80108920:	0f 22 d8             	mov    %eax,%cr3
}
80108923:	90                   	nop
80108924:	5d                   	pop    %ebp
80108925:	c3                   	ret    

80108926 <seginit>:

// Set up CPU's kernel segment descriptors.
// Run once on entry on each CPU.
void
seginit(void)
{
80108926:	55                   	push   %ebp
80108927:	89 e5                	mov    %esp,%ebp
80108929:	83 ec 18             	sub    $0x18,%esp

  // Map "logical" addresses to virtual addresses using identity map.
  // Cannot share a CODE descriptor for both kernel and user
  // because it would have to have DPL_USR, but the CPU forbids
  // an interrupt from CPL=0 to DPL=3.
  c = &cpus[cpuid()];
8010892c:	e8 52 b9 ff ff       	call   80104283 <cpuid>
80108931:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
80108937:	05 e0 37 11 80       	add    $0x801137e0,%eax
8010893c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  c->gdt[SEG_KCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, 0);
8010893f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108942:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
80108948:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010894b:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
80108951:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108954:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
80108958:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010895b:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
8010895f:	83 e2 f0             	and    $0xfffffff0,%edx
80108962:	83 ca 0a             	or     $0xa,%edx
80108965:	88 50 7d             	mov    %dl,0x7d(%eax)
80108968:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010896b:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
8010896f:	83 ca 10             	or     $0x10,%edx
80108972:	88 50 7d             	mov    %dl,0x7d(%eax)
80108975:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108978:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
8010897c:	83 e2 9f             	and    $0xffffff9f,%edx
8010897f:	88 50 7d             	mov    %dl,0x7d(%eax)
80108982:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108985:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
80108989:	83 ca 80             	or     $0xffffff80,%edx
8010898c:	88 50 7d             	mov    %dl,0x7d(%eax)
8010898f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108992:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80108996:	83 ca 0f             	or     $0xf,%edx
80108999:	88 50 7e             	mov    %dl,0x7e(%eax)
8010899c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010899f:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801089a3:	83 e2 ef             	and    $0xffffffef,%edx
801089a6:	88 50 7e             	mov    %dl,0x7e(%eax)
801089a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801089ac:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801089b0:	83 e2 df             	and    $0xffffffdf,%edx
801089b3:	88 50 7e             	mov    %dl,0x7e(%eax)
801089b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801089b9:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801089bd:	83 ca 40             	or     $0x40,%edx
801089c0:	88 50 7e             	mov    %dl,0x7e(%eax)
801089c3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801089c6:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801089ca:	83 ca 80             	or     $0xffffff80,%edx
801089cd:	88 50 7e             	mov    %dl,0x7e(%eax)
801089d0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801089d3:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
  c->gdt[SEG_KDATA] = SEG(STA_W, 0, 0xffffffff, 0);
801089d7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801089da:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
801089e1:	ff ff 
801089e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801089e6:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
801089ed:	00 00 
801089ef:	8b 45 f4             	mov    -0xc(%ebp),%eax
801089f2:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
801089f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801089fc:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80108a03:	83 e2 f0             	and    $0xfffffff0,%edx
80108a06:	83 ca 02             	or     $0x2,%edx
80108a09:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80108a0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a12:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80108a19:	83 ca 10             	or     $0x10,%edx
80108a1c:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80108a22:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a25:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80108a2c:	83 e2 9f             	and    $0xffffff9f,%edx
80108a2f:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80108a35:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a38:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80108a3f:	83 ca 80             	or     $0xffffff80,%edx
80108a42:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80108a48:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a4b:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80108a52:	83 ca 0f             	or     $0xf,%edx
80108a55:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80108a5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a5e:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80108a65:	83 e2 ef             	and    $0xffffffef,%edx
80108a68:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80108a6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a71:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80108a78:	83 e2 df             	and    $0xffffffdf,%edx
80108a7b:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80108a81:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a84:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80108a8b:	83 ca 40             	or     $0x40,%edx
80108a8e:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80108a94:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a97:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80108a9e:	83 ca 80             	or     $0xffffff80,%edx
80108aa1:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
80108aa7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108aaa:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
  c->gdt[SEG_UCODE] = SEG(STA_X|STA_R, 0, 0xffffffff, DPL_USER);
80108ab1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108ab4:	66 c7 80 88 00 00 00 	movw   $0xffff,0x88(%eax)
80108abb:	ff ff 
80108abd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108ac0:	66 c7 80 8a 00 00 00 	movw   $0x0,0x8a(%eax)
80108ac7:	00 00 
80108ac9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108acc:	c6 80 8c 00 00 00 00 	movb   $0x0,0x8c(%eax)
80108ad3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108ad6:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80108add:	83 e2 f0             	and    $0xfffffff0,%edx
80108ae0:	83 ca 0a             	or     $0xa,%edx
80108ae3:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80108ae9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108aec:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80108af3:	83 ca 10             	or     $0x10,%edx
80108af6:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80108afc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108aff:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80108b06:	83 ca 60             	or     $0x60,%edx
80108b09:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80108b0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b12:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80108b19:	83 ca 80             	or     $0xffffff80,%edx
80108b1c:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80108b22:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b25:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80108b2c:	83 ca 0f             	or     $0xf,%edx
80108b2f:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80108b35:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b38:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80108b3f:	83 e2 ef             	and    $0xffffffef,%edx
80108b42:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80108b48:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b4b:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80108b52:	83 e2 df             	and    $0xffffffdf,%edx
80108b55:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80108b5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b5e:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80108b65:	83 ca 40             	or     $0x40,%edx
80108b68:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80108b6e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b71:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80108b78:	83 ca 80             	or     $0xffffff80,%edx
80108b7b:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
80108b81:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b84:	c6 80 8f 00 00 00 00 	movb   $0x0,0x8f(%eax)
  c->gdt[SEG_UDATA] = SEG(STA_W, 0, 0xffffffff, DPL_USER);
80108b8b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b8e:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
80108b95:	ff ff 
80108b97:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b9a:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80108ba1:	00 00 
80108ba3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108ba6:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80108bad:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108bb0:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80108bb7:	83 e2 f0             	and    $0xfffffff0,%edx
80108bba:	83 ca 02             	or     $0x2,%edx
80108bbd:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80108bc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108bc6:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80108bcd:	83 ca 10             	or     $0x10,%edx
80108bd0:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80108bd6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108bd9:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80108be0:	83 ca 60             	or     $0x60,%edx
80108be3:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80108be9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108bec:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80108bf3:	83 ca 80             	or     $0xffffff80,%edx
80108bf6:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80108bfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108bff:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80108c06:	83 ca 0f             	or     $0xf,%edx
80108c09:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80108c0f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108c12:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80108c19:	83 e2 ef             	and    $0xffffffef,%edx
80108c1c:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80108c22:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108c25:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80108c2c:	83 e2 df             	and    $0xffffffdf,%edx
80108c2f:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80108c35:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108c38:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80108c3f:	83 ca 40             	or     $0x40,%edx
80108c42:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80108c48:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108c4b:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80108c52:	83 ca 80             	or     $0xffffff80,%edx
80108c55:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80108c5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108c5e:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
  lgdt(c->gdt, sizeof(c->gdt));
80108c65:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108c68:	83 c0 70             	add    $0x70,%eax
80108c6b:	83 ec 08             	sub    $0x8,%esp
80108c6e:	6a 30                	push   $0x30
80108c70:	50                   	push   %eax
80108c71:	e8 63 fc ff ff       	call   801088d9 <lgdt>
80108c76:	83 c4 10             	add    $0x10,%esp
}
80108c79:	90                   	nop
80108c7a:	c9                   	leave  
80108c7b:	c3                   	ret    

80108c7c <walkpgdir>:
// Return the address of the PTE in page table pgdir
// that corresponds to virtual address va.  If alloc!=0,
// create any required page table pages.
static pte_t *
walkpgdir(pde_t *pgdir, const void *va, int alloc)
{
80108c7c:	55                   	push   %ebp
80108c7d:	89 e5                	mov    %esp,%ebp
80108c7f:	83 ec 18             	sub    $0x18,%esp
  pde_t *pde;
  pte_t *pgtab;

  pde = &pgdir[PDX(va)];
80108c82:	8b 45 0c             	mov    0xc(%ebp),%eax
80108c85:	c1 e8 16             	shr    $0x16,%eax
80108c88:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108c8f:	8b 45 08             	mov    0x8(%ebp),%eax
80108c92:	01 d0                	add    %edx,%eax
80108c94:	89 45 f0             	mov    %eax,-0x10(%ebp)
  if(*pde & PTE_P){
80108c97:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108c9a:	8b 00                	mov    (%eax),%eax
80108c9c:	83 e0 01             	and    $0x1,%eax
80108c9f:	85 c0                	test   %eax,%eax
80108ca1:	74 14                	je     80108cb7 <walkpgdir+0x3b>
    pgtab = (pte_t*)P2V(PTE_ADDR(*pde));
80108ca3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108ca6:	8b 00                	mov    (%eax),%eax
80108ca8:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108cad:	05 00 00 00 80       	add    $0x80000000,%eax
80108cb2:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108cb5:	eb 42                	jmp    80108cf9 <walkpgdir+0x7d>
  } else {
    if(!alloc || (pgtab = (pte_t*)kalloc()) == 0)
80108cb7:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80108cbb:	74 0e                	je     80108ccb <walkpgdir+0x4f>
80108cbd:	e8 d4 9f ff ff       	call   80102c96 <kalloc>
80108cc2:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108cc5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80108cc9:	75 07                	jne    80108cd2 <walkpgdir+0x56>
      return 0;
80108ccb:	b8 00 00 00 00       	mov    $0x0,%eax
80108cd0:	eb 3e                	jmp    80108d10 <walkpgdir+0x94>
    // Make sure all those PTE_P bits are zero.
    memset(pgtab, 0, PGSIZE);
80108cd2:	83 ec 04             	sub    $0x4,%esp
80108cd5:	68 00 10 00 00       	push   $0x1000
80108cda:	6a 00                	push   $0x0
80108cdc:	ff 75 f4             	push   -0xc(%ebp)
80108cdf:	e8 cf d5 ff ff       	call   801062b3 <memset>
80108ce4:	83 c4 10             	add    $0x10,%esp
    // The permissions here are overly generous, but they can
    // be further restricted by the permissions in the page table
    // entries, if necessary.
    *pde = V2P(pgtab) | PTE_P | PTE_W | PTE_U;
80108ce7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108cea:	05 00 00 00 80       	add    $0x80000000,%eax
80108cef:	83 c8 07             	or     $0x7,%eax
80108cf2:	89 c2                	mov    %eax,%edx
80108cf4:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108cf7:	89 10                	mov    %edx,(%eax)
  }
  return &pgtab[PTX(va)];
80108cf9:	8b 45 0c             	mov    0xc(%ebp),%eax
80108cfc:	c1 e8 0c             	shr    $0xc,%eax
80108cff:	25 ff 03 00 00       	and    $0x3ff,%eax
80108d04:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108d0b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108d0e:	01 d0                	add    %edx,%eax
}
80108d10:	c9                   	leave  
80108d11:	c3                   	ret    

80108d12 <mappages>:
// Create PTEs for virtual addresses starting at va that refer to
// physical addresses starting at pa. va and size might not
// be page-aligned.
static int
mappages(pde_t *pgdir, void *va, uint size, uint pa, int perm)
{
80108d12:	55                   	push   %ebp
80108d13:	89 e5                	mov    %esp,%ebp
80108d15:	83 ec 18             	sub    $0x18,%esp
  char *a, *last;
  pte_t *pte;

  a = (char*)PGROUNDDOWN((uint)va);
80108d18:	8b 45 0c             	mov    0xc(%ebp),%eax
80108d1b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108d20:	89 45 f4             	mov    %eax,-0xc(%ebp)
  last = (char*)PGROUNDDOWN(((uint)va) + size - 1);
80108d23:	8b 55 0c             	mov    0xc(%ebp),%edx
80108d26:	8b 45 10             	mov    0x10(%ebp),%eax
80108d29:	01 d0                	add    %edx,%eax
80108d2b:	83 e8 01             	sub    $0x1,%eax
80108d2e:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108d33:	89 45 f0             	mov    %eax,-0x10(%ebp)
  for(;;){
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80108d36:	83 ec 04             	sub    $0x4,%esp
80108d39:	6a 01                	push   $0x1
80108d3b:	ff 75 f4             	push   -0xc(%ebp)
80108d3e:	ff 75 08             	push   0x8(%ebp)
80108d41:	e8 36 ff ff ff       	call   80108c7c <walkpgdir>
80108d46:	83 c4 10             	add    $0x10,%esp
80108d49:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108d4c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108d50:	75 07                	jne    80108d59 <mappages+0x47>
      return -1;
80108d52:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108d57:	eb 47                	jmp    80108da0 <mappages+0x8e>
    if(*pte & PTE_P)
80108d59:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108d5c:	8b 00                	mov    (%eax),%eax
80108d5e:	83 e0 01             	and    $0x1,%eax
80108d61:	85 c0                	test   %eax,%eax
80108d63:	74 0d                	je     80108d72 <mappages+0x60>
      panic("remap");
80108d65:	83 ec 0c             	sub    $0xc,%esp
80108d68:	68 18 9e 10 80       	push   $0x80109e18
80108d6d:	e8 43 78 ff ff       	call   801005b5 <panic>
    *pte = pa | perm | PTE_P;
80108d72:	8b 45 18             	mov    0x18(%ebp),%eax
80108d75:	0b 45 14             	or     0x14(%ebp),%eax
80108d78:	83 c8 01             	or     $0x1,%eax
80108d7b:	89 c2                	mov    %eax,%edx
80108d7d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108d80:	89 10                	mov    %edx,(%eax)
    if(a == last)
80108d82:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108d85:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80108d88:	74 10                	je     80108d9a <mappages+0x88>
      break;
    a += PGSIZE;
80108d8a:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
    pa += PGSIZE;
80108d91:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
    if((pte = walkpgdir(pgdir, a, 1)) == 0)
80108d98:	eb 9c                	jmp    80108d36 <mappages+0x24>
      break;
80108d9a:	90                   	nop
  }
  return 0;
80108d9b:	b8 00 00 00 00       	mov    $0x0,%eax
}
80108da0:	c9                   	leave  
80108da1:	c3                   	ret    

80108da2 <setupkvm>:
};

// Set up kernel part of a page table.
pde_t*
setupkvm(void)
{
80108da2:	55                   	push   %ebp
80108da3:	89 e5                	mov    %esp,%ebp
80108da5:	53                   	push   %ebx
80108da6:	83 ec 14             	sub    $0x14,%esp
  pde_t *pgdir;
  struct kmap *k;

  if((pgdir = (pde_t*)kalloc()) == 0)
80108da9:	e8 e8 9e ff ff       	call   80102c96 <kalloc>
80108dae:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108db1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108db5:	75 07                	jne    80108dbe <setupkvm+0x1c>
    return 0;
80108db7:	b8 00 00 00 00       	mov    $0x0,%eax
80108dbc:	eb 78                	jmp    80108e36 <setupkvm+0x94>
  memset(pgdir, 0, PGSIZE);
80108dbe:	83 ec 04             	sub    $0x4,%esp
80108dc1:	68 00 10 00 00       	push   $0x1000
80108dc6:	6a 00                	push   $0x0
80108dc8:	ff 75 f0             	push   -0x10(%ebp)
80108dcb:	e8 e3 d4 ff ff       	call   801062b3 <memset>
80108dd0:	83 c4 10             	add    $0x10,%esp
  if (P2V(PHYSTOP) > (void*)DEVSPACE)
    panic("PHYSTOP too high");
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108dd3:	c7 45 f4 a0 c4 10 80 	movl   $0x8010c4a0,-0xc(%ebp)
80108dda:	eb 4e                	jmp    80108e2a <setupkvm+0x88>
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80108ddc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108ddf:	8b 48 0c             	mov    0xc(%eax),%ecx
                (uint)k->phys_start, k->perm) < 0) {
80108de2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108de5:	8b 50 04             	mov    0x4(%eax),%edx
    if(mappages(pgdir, k->virt, k->phys_end - k->phys_start,
80108de8:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108deb:	8b 58 08             	mov    0x8(%eax),%ebx
80108dee:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108df1:	8b 40 04             	mov    0x4(%eax),%eax
80108df4:	29 c3                	sub    %eax,%ebx
80108df6:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108df9:	8b 00                	mov    (%eax),%eax
80108dfb:	83 ec 0c             	sub    $0xc,%esp
80108dfe:	51                   	push   %ecx
80108dff:	52                   	push   %edx
80108e00:	53                   	push   %ebx
80108e01:	50                   	push   %eax
80108e02:	ff 75 f0             	push   -0x10(%ebp)
80108e05:	e8 08 ff ff ff       	call   80108d12 <mappages>
80108e0a:	83 c4 20             	add    $0x20,%esp
80108e0d:	85 c0                	test   %eax,%eax
80108e0f:	79 15                	jns    80108e26 <setupkvm+0x84>
      freevm(pgdir);
80108e11:	83 ec 0c             	sub    $0xc,%esp
80108e14:	ff 75 f0             	push   -0x10(%ebp)
80108e17:	e8 f5 04 00 00       	call   80109311 <freevm>
80108e1c:	83 c4 10             	add    $0x10,%esp
      return 0;
80108e1f:	b8 00 00 00 00       	mov    $0x0,%eax
80108e24:	eb 10                	jmp    80108e36 <setupkvm+0x94>
  for(k = kmap; k < &kmap[NELEM(kmap)]; k++)
80108e26:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80108e2a:	81 7d f4 e0 c4 10 80 	cmpl   $0x8010c4e0,-0xc(%ebp)
80108e31:	72 a9                	jb     80108ddc <setupkvm+0x3a>
    }
  return pgdir;
80108e33:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80108e36:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80108e39:	c9                   	leave  
80108e3a:	c3                   	ret    

80108e3b <kvmalloc>:

// Allocate one page table for the machine for the kernel address
// space for scheduler processes.
void
kvmalloc(void)
{
80108e3b:	55                   	push   %ebp
80108e3c:	89 e5                	mov    %esp,%ebp
80108e3e:	83 ec 08             	sub    $0x8,%esp
  kpgdir = setupkvm();
80108e41:	e8 5c ff ff ff       	call   80108da2 <setupkvm>
80108e46:	a3 5c 73 11 80       	mov    %eax,0x8011735c
  switchkvm();
80108e4b:	e8 03 00 00 00       	call   80108e53 <switchkvm>
}
80108e50:	90                   	nop
80108e51:	c9                   	leave  
80108e52:	c3                   	ret    

80108e53 <switchkvm>:

// Switch h/w page table register to the kernel-only page table,
// for when no process is running.
void
switchkvm(void)
{
80108e53:	55                   	push   %ebp
80108e54:	89 e5                	mov    %esp,%ebp
  lcr3(V2P(kpgdir));   // switch to the kernel page table
80108e56:	a1 5c 73 11 80       	mov    0x8011735c,%eax
80108e5b:	05 00 00 00 80       	add    $0x80000000,%eax
80108e60:	50                   	push   %eax
80108e61:	e8 b4 fa ff ff       	call   8010891a <lcr3>
80108e66:	83 c4 04             	add    $0x4,%esp
}
80108e69:	90                   	nop
80108e6a:	c9                   	leave  
80108e6b:	c3                   	ret    

80108e6c <switchuvm>:

// Switch TSS and h/w page table to correspond to process p.
void
switchuvm(struct proc *p)
{
80108e6c:	55                   	push   %ebp
80108e6d:	89 e5                	mov    %esp,%ebp
80108e6f:	56                   	push   %esi
80108e70:	53                   	push   %ebx
80108e71:	83 ec 10             	sub    $0x10,%esp
  if(p == 0)
80108e74:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80108e78:	75 0d                	jne    80108e87 <switchuvm+0x1b>
    panic("switchuvm: no process");
80108e7a:	83 ec 0c             	sub    $0xc,%esp
80108e7d:	68 1e 9e 10 80       	push   $0x80109e1e
80108e82:	e8 2e 77 ff ff       	call   801005b5 <panic>
  if(p->kstack == 0)
80108e87:	8b 45 08             	mov    0x8(%ebp),%eax
80108e8a:	8b 40 08             	mov    0x8(%eax),%eax
80108e8d:	85 c0                	test   %eax,%eax
80108e8f:	75 0d                	jne    80108e9e <switchuvm+0x32>
    panic("switchuvm: no kstack");
80108e91:	83 ec 0c             	sub    $0xc,%esp
80108e94:	68 34 9e 10 80       	push   $0x80109e34
80108e99:	e8 17 77 ff ff       	call   801005b5 <panic>
  if(p->pgdir == 0)
80108e9e:	8b 45 08             	mov    0x8(%ebp),%eax
80108ea1:	8b 40 04             	mov    0x4(%eax),%eax
80108ea4:	85 c0                	test   %eax,%eax
80108ea6:	75 0d                	jne    80108eb5 <switchuvm+0x49>
    panic("switchuvm: no pgdir");
80108ea8:	83 ec 0c             	sub    $0xc,%esp
80108eab:	68 49 9e 10 80       	push   $0x80109e49
80108eb0:	e8 00 77 ff ff       	call   801005b5 <panic>

  pushcli();
80108eb5:	e8 ee d2 ff ff       	call   801061a8 <pushcli>
  mycpu()->gdt[SEG_TSS] = SEG16(STS_T32A, &mycpu()->ts,
80108eba:	e8 df b3 ff ff       	call   8010429e <mycpu>
80108ebf:	89 c3                	mov    %eax,%ebx
80108ec1:	e8 d8 b3 ff ff       	call   8010429e <mycpu>
80108ec6:	83 c0 08             	add    $0x8,%eax
80108ec9:	89 c6                	mov    %eax,%esi
80108ecb:	e8 ce b3 ff ff       	call   8010429e <mycpu>
80108ed0:	83 c0 08             	add    $0x8,%eax
80108ed3:	c1 e8 10             	shr    $0x10,%eax
80108ed6:	88 45 f7             	mov    %al,-0x9(%ebp)
80108ed9:	e8 c0 b3 ff ff       	call   8010429e <mycpu>
80108ede:	83 c0 08             	add    $0x8,%eax
80108ee1:	c1 e8 18             	shr    $0x18,%eax
80108ee4:	89 c2                	mov    %eax,%edx
80108ee6:	66 c7 83 98 00 00 00 	movw   $0x67,0x98(%ebx)
80108eed:	67 00 
80108eef:	66 89 b3 9a 00 00 00 	mov    %si,0x9a(%ebx)
80108ef6:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
80108efa:	88 83 9c 00 00 00    	mov    %al,0x9c(%ebx)
80108f00:	0f b6 83 9d 00 00 00 	movzbl 0x9d(%ebx),%eax
80108f07:	83 e0 f0             	and    $0xfffffff0,%eax
80108f0a:	83 c8 09             	or     $0x9,%eax
80108f0d:	88 83 9d 00 00 00    	mov    %al,0x9d(%ebx)
80108f13:	0f b6 83 9d 00 00 00 	movzbl 0x9d(%ebx),%eax
80108f1a:	83 c8 10             	or     $0x10,%eax
80108f1d:	88 83 9d 00 00 00    	mov    %al,0x9d(%ebx)
80108f23:	0f b6 83 9d 00 00 00 	movzbl 0x9d(%ebx),%eax
80108f2a:	83 e0 9f             	and    $0xffffff9f,%eax
80108f2d:	88 83 9d 00 00 00    	mov    %al,0x9d(%ebx)
80108f33:	0f b6 83 9d 00 00 00 	movzbl 0x9d(%ebx),%eax
80108f3a:	83 c8 80             	or     $0xffffff80,%eax
80108f3d:	88 83 9d 00 00 00    	mov    %al,0x9d(%ebx)
80108f43:	0f b6 83 9e 00 00 00 	movzbl 0x9e(%ebx),%eax
80108f4a:	83 e0 f0             	and    $0xfffffff0,%eax
80108f4d:	88 83 9e 00 00 00    	mov    %al,0x9e(%ebx)
80108f53:	0f b6 83 9e 00 00 00 	movzbl 0x9e(%ebx),%eax
80108f5a:	83 e0 ef             	and    $0xffffffef,%eax
80108f5d:	88 83 9e 00 00 00    	mov    %al,0x9e(%ebx)
80108f63:	0f b6 83 9e 00 00 00 	movzbl 0x9e(%ebx),%eax
80108f6a:	83 e0 df             	and    $0xffffffdf,%eax
80108f6d:	88 83 9e 00 00 00    	mov    %al,0x9e(%ebx)
80108f73:	0f b6 83 9e 00 00 00 	movzbl 0x9e(%ebx),%eax
80108f7a:	83 c8 40             	or     $0x40,%eax
80108f7d:	88 83 9e 00 00 00    	mov    %al,0x9e(%ebx)
80108f83:	0f b6 83 9e 00 00 00 	movzbl 0x9e(%ebx),%eax
80108f8a:	83 e0 7f             	and    $0x7f,%eax
80108f8d:	88 83 9e 00 00 00    	mov    %al,0x9e(%ebx)
80108f93:	88 93 9f 00 00 00    	mov    %dl,0x9f(%ebx)
                                sizeof(mycpu()->ts)-1, 0);
  mycpu()->gdt[SEG_TSS].s = 0;
80108f99:	e8 00 b3 ff ff       	call   8010429e <mycpu>
80108f9e:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80108fa5:	83 e2 ef             	and    $0xffffffef,%edx
80108fa8:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
  mycpu()->ts.ss0 = SEG_KDATA << 3;
80108fae:	e8 eb b2 ff ff       	call   8010429e <mycpu>
80108fb3:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
  mycpu()->ts.esp0 = (uint)p->kstack + KSTACKSIZE;
80108fb9:	8b 45 08             	mov    0x8(%ebp),%eax
80108fbc:	8b 40 08             	mov    0x8(%eax),%eax
80108fbf:	89 c3                	mov    %eax,%ebx
80108fc1:	e8 d8 b2 ff ff       	call   8010429e <mycpu>
80108fc6:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
80108fcc:	89 50 0c             	mov    %edx,0xc(%eax)
  // setting IOPL=0 in eflags *and* iomb beyond the tss segment limit
  // forbids I/O instructions (e.g., inb and outb) from user space
  mycpu()->ts.iomb = (ushort) 0xFFFF;
80108fcf:	e8 ca b2 ff ff       	call   8010429e <mycpu>
80108fd4:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
  ltr(SEG_TSS << 3);
80108fda:	83 ec 0c             	sub    $0xc,%esp
80108fdd:	6a 28                	push   $0x28
80108fdf:	e8 1f f9 ff ff       	call   80108903 <ltr>
80108fe4:	83 c4 10             	add    $0x10,%esp
  lcr3(V2P(p->pgdir));  // switch to process's address space
80108fe7:	8b 45 08             	mov    0x8(%ebp),%eax
80108fea:	8b 40 04             	mov    0x4(%eax),%eax
80108fed:	05 00 00 00 80       	add    $0x80000000,%eax
80108ff2:	83 ec 0c             	sub    $0xc,%esp
80108ff5:	50                   	push   %eax
80108ff6:	e8 1f f9 ff ff       	call   8010891a <lcr3>
80108ffb:	83 c4 10             	add    $0x10,%esp
  popcli();
80108ffe:	e8 f2 d1 ff ff       	call   801061f5 <popcli>
}
80109003:	90                   	nop
80109004:	8d 65 f8             	lea    -0x8(%ebp),%esp
80109007:	5b                   	pop    %ebx
80109008:	5e                   	pop    %esi
80109009:	5d                   	pop    %ebp
8010900a:	c3                   	ret    

8010900b <inituvm>:

// Load the initcode into address 0 of pgdir.
// sz must be less than a page.
void
inituvm(pde_t *pgdir, char *init, uint sz)
{
8010900b:	55                   	push   %ebp
8010900c:	89 e5                	mov    %esp,%ebp
8010900e:	83 ec 18             	sub    $0x18,%esp
  char *mem;

  if(sz >= PGSIZE)
80109011:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80109018:	76 0d                	jbe    80109027 <inituvm+0x1c>
    panic("inituvm: more than a page");
8010901a:	83 ec 0c             	sub    $0xc,%esp
8010901d:	68 5d 9e 10 80       	push   $0x80109e5d
80109022:	e8 8e 75 ff ff       	call   801005b5 <panic>
  mem = kalloc();
80109027:	e8 6a 9c ff ff       	call   80102c96 <kalloc>
8010902c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  memset(mem, 0, PGSIZE);
8010902f:	83 ec 04             	sub    $0x4,%esp
80109032:	68 00 10 00 00       	push   $0x1000
80109037:	6a 00                	push   $0x0
80109039:	ff 75 f4             	push   -0xc(%ebp)
8010903c:	e8 72 d2 ff ff       	call   801062b3 <memset>
80109041:	83 c4 10             	add    $0x10,%esp
  mappages(pgdir, 0, PGSIZE, V2P(mem), PTE_W|PTE_U);
80109044:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109047:	05 00 00 00 80       	add    $0x80000000,%eax
8010904c:	83 ec 0c             	sub    $0xc,%esp
8010904f:	6a 06                	push   $0x6
80109051:	50                   	push   %eax
80109052:	68 00 10 00 00       	push   $0x1000
80109057:	6a 00                	push   $0x0
80109059:	ff 75 08             	push   0x8(%ebp)
8010905c:	e8 b1 fc ff ff       	call   80108d12 <mappages>
80109061:	83 c4 20             	add    $0x20,%esp
  memmove(mem, init, sz);
80109064:	83 ec 04             	sub    $0x4,%esp
80109067:	ff 75 10             	push   0x10(%ebp)
8010906a:	ff 75 0c             	push   0xc(%ebp)
8010906d:	ff 75 f4             	push   -0xc(%ebp)
80109070:	e8 fd d2 ff ff       	call   80106372 <memmove>
80109075:	83 c4 10             	add    $0x10,%esp
}
80109078:	90                   	nop
80109079:	c9                   	leave  
8010907a:	c3                   	ret    

8010907b <loaduvm>:

// Load a program segment into pgdir.  addr must be page-aligned
// and the pages from addr to addr+sz must already be mapped.
int
loaduvm(pde_t *pgdir, char *addr, struct inode *ip, uint offset, uint sz)
{
8010907b:	55                   	push   %ebp
8010907c:	89 e5                	mov    %esp,%ebp
8010907e:	83 ec 18             	sub    $0x18,%esp
  uint i, pa, n;
  pte_t *pte;

  if((uint) addr % PGSIZE != 0)
80109081:	8b 45 0c             	mov    0xc(%ebp),%eax
80109084:	25 ff 0f 00 00       	and    $0xfff,%eax
80109089:	85 c0                	test   %eax,%eax
8010908b:	74 0d                	je     8010909a <loaduvm+0x1f>
    panic("loaduvm: addr must be page aligned");
8010908d:	83 ec 0c             	sub    $0xc,%esp
80109090:	68 78 9e 10 80       	push   $0x80109e78
80109095:	e8 1b 75 ff ff       	call   801005b5 <panic>
  for(i = 0; i < sz; i += PGSIZE){
8010909a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801090a1:	e9 8f 00 00 00       	jmp    80109135 <loaduvm+0xba>
    if((pte = walkpgdir(pgdir, addr+i, 0)) == 0)
801090a6:	8b 55 0c             	mov    0xc(%ebp),%edx
801090a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801090ac:	01 d0                	add    %edx,%eax
801090ae:	83 ec 04             	sub    $0x4,%esp
801090b1:	6a 00                	push   $0x0
801090b3:	50                   	push   %eax
801090b4:	ff 75 08             	push   0x8(%ebp)
801090b7:	e8 c0 fb ff ff       	call   80108c7c <walkpgdir>
801090bc:	83 c4 10             	add    $0x10,%esp
801090bf:	89 45 ec             	mov    %eax,-0x14(%ebp)
801090c2:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801090c6:	75 0d                	jne    801090d5 <loaduvm+0x5a>
      panic("loaduvm: address should exist");
801090c8:	83 ec 0c             	sub    $0xc,%esp
801090cb:	68 9b 9e 10 80       	push   $0x80109e9b
801090d0:	e8 e0 74 ff ff       	call   801005b5 <panic>
    pa = PTE_ADDR(*pte);
801090d5:	8b 45 ec             	mov    -0x14(%ebp),%eax
801090d8:	8b 00                	mov    (%eax),%eax
801090da:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801090df:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(sz - i < PGSIZE)
801090e2:	8b 45 18             	mov    0x18(%ebp),%eax
801090e5:	2b 45 f4             	sub    -0xc(%ebp),%eax
801090e8:	3d ff 0f 00 00       	cmp    $0xfff,%eax
801090ed:	77 0b                	ja     801090fa <loaduvm+0x7f>
      n = sz - i;
801090ef:	8b 45 18             	mov    0x18(%ebp),%eax
801090f2:	2b 45 f4             	sub    -0xc(%ebp),%eax
801090f5:	89 45 f0             	mov    %eax,-0x10(%ebp)
801090f8:	eb 07                	jmp    80109101 <loaduvm+0x86>
    else
      n = PGSIZE;
801090fa:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
    if(readi(ip, P2V(pa), offset+i, n) != n)
80109101:	8b 55 14             	mov    0x14(%ebp),%edx
80109104:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109107:	01 d0                	add    %edx,%eax
80109109:	8b 55 e8             	mov    -0x18(%ebp),%edx
8010910c:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80109112:	ff 75 f0             	push   -0x10(%ebp)
80109115:	50                   	push   %eax
80109116:	52                   	push   %edx
80109117:	ff 75 10             	push   0x10(%ebp)
8010911a:	e8 e7 8d ff ff       	call   80101f06 <readi>
8010911f:	83 c4 10             	add    $0x10,%esp
80109122:	39 45 f0             	cmp    %eax,-0x10(%ebp)
80109125:	74 07                	je     8010912e <loaduvm+0xb3>
      return -1;
80109127:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010912c:	eb 18                	jmp    80109146 <loaduvm+0xcb>
  for(i = 0; i < sz; i += PGSIZE){
8010912e:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80109135:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109138:	3b 45 18             	cmp    0x18(%ebp),%eax
8010913b:	0f 82 65 ff ff ff    	jb     801090a6 <loaduvm+0x2b>
  }
  return 0;
80109141:	b8 00 00 00 00       	mov    $0x0,%eax
}
80109146:	c9                   	leave  
80109147:	c3                   	ret    

80109148 <allocuvm>:

// Allocate page tables and physical memory to grow process from oldsz to
// newsz, which need not be page aligned.  Returns new size or 0 on error.
int
allocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
80109148:	55                   	push   %ebp
80109149:	89 e5                	mov    %esp,%ebp
8010914b:	83 ec 18             	sub    $0x18,%esp
  char *mem;
  uint a;

  if(newsz >= KERNBASE)
8010914e:	8b 45 10             	mov    0x10(%ebp),%eax
80109151:	85 c0                	test   %eax,%eax
80109153:	79 0a                	jns    8010915f <allocuvm+0x17>
    return 0;
80109155:	b8 00 00 00 00       	mov    $0x0,%eax
8010915a:	e9 ec 00 00 00       	jmp    8010924b <allocuvm+0x103>
  if(newsz < oldsz)
8010915f:	8b 45 10             	mov    0x10(%ebp),%eax
80109162:	3b 45 0c             	cmp    0xc(%ebp),%eax
80109165:	73 08                	jae    8010916f <allocuvm+0x27>
    return oldsz;
80109167:	8b 45 0c             	mov    0xc(%ebp),%eax
8010916a:	e9 dc 00 00 00       	jmp    8010924b <allocuvm+0x103>

  a = PGROUNDUP(oldsz);
8010916f:	8b 45 0c             	mov    0xc(%ebp),%eax
80109172:	05 ff 0f 00 00       	add    $0xfff,%eax
80109177:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010917c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a < newsz; a += PGSIZE){
8010917f:	e9 b8 00 00 00       	jmp    8010923c <allocuvm+0xf4>
    mem = kalloc();
80109184:	e8 0d 9b ff ff       	call   80102c96 <kalloc>
80109189:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(mem == 0){
8010918c:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80109190:	75 2e                	jne    801091c0 <allocuvm+0x78>
      cprintf("allocuvm out of memory\n");
80109192:	83 ec 0c             	sub    $0xc,%esp
80109195:	68 b9 9e 10 80       	push   $0x80109eb9
8010919a:	e8 61 72 ff ff       	call   80100400 <cprintf>
8010919f:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
801091a2:	83 ec 04             	sub    $0x4,%esp
801091a5:	ff 75 0c             	push   0xc(%ebp)
801091a8:	ff 75 10             	push   0x10(%ebp)
801091ab:	ff 75 08             	push   0x8(%ebp)
801091ae:	e8 9a 00 00 00       	call   8010924d <deallocuvm>
801091b3:	83 c4 10             	add    $0x10,%esp
      return 0;
801091b6:	b8 00 00 00 00       	mov    $0x0,%eax
801091bb:	e9 8b 00 00 00       	jmp    8010924b <allocuvm+0x103>
    }
    memset(mem, 0, PGSIZE);
801091c0:	83 ec 04             	sub    $0x4,%esp
801091c3:	68 00 10 00 00       	push   $0x1000
801091c8:	6a 00                	push   $0x0
801091ca:	ff 75 f0             	push   -0x10(%ebp)
801091cd:	e8 e1 d0 ff ff       	call   801062b3 <memset>
801091d2:	83 c4 10             	add    $0x10,%esp
    if(mappages(pgdir, (char*)a, PGSIZE, V2P(mem), PTE_W|PTE_U) < 0){
801091d5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801091d8:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
801091de:	8b 45 f4             	mov    -0xc(%ebp),%eax
801091e1:	83 ec 0c             	sub    $0xc,%esp
801091e4:	6a 06                	push   $0x6
801091e6:	52                   	push   %edx
801091e7:	68 00 10 00 00       	push   $0x1000
801091ec:	50                   	push   %eax
801091ed:	ff 75 08             	push   0x8(%ebp)
801091f0:	e8 1d fb ff ff       	call   80108d12 <mappages>
801091f5:	83 c4 20             	add    $0x20,%esp
801091f8:	85 c0                	test   %eax,%eax
801091fa:	79 39                	jns    80109235 <allocuvm+0xed>
      cprintf("allocuvm out of memory (2)\n");
801091fc:	83 ec 0c             	sub    $0xc,%esp
801091ff:	68 d1 9e 10 80       	push   $0x80109ed1
80109204:	e8 f7 71 ff ff       	call   80100400 <cprintf>
80109209:	83 c4 10             	add    $0x10,%esp
      deallocuvm(pgdir, newsz, oldsz);
8010920c:	83 ec 04             	sub    $0x4,%esp
8010920f:	ff 75 0c             	push   0xc(%ebp)
80109212:	ff 75 10             	push   0x10(%ebp)
80109215:	ff 75 08             	push   0x8(%ebp)
80109218:	e8 30 00 00 00       	call   8010924d <deallocuvm>
8010921d:	83 c4 10             	add    $0x10,%esp
      kfree(mem);
80109220:	83 ec 0c             	sub    $0xc,%esp
80109223:	ff 75 f0             	push   -0x10(%ebp)
80109226:	e8 d1 99 ff ff       	call   80102bfc <kfree>
8010922b:	83 c4 10             	add    $0x10,%esp
      return 0;
8010922e:	b8 00 00 00 00       	mov    $0x0,%eax
80109233:	eb 16                	jmp    8010924b <allocuvm+0x103>
  for(; a < newsz; a += PGSIZE){
80109235:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
8010923c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010923f:	3b 45 10             	cmp    0x10(%ebp),%eax
80109242:	0f 82 3c ff ff ff    	jb     80109184 <allocuvm+0x3c>
    }
  }
  return newsz;
80109248:	8b 45 10             	mov    0x10(%ebp),%eax
}
8010924b:	c9                   	leave  
8010924c:	c3                   	ret    

8010924d <deallocuvm>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
int
deallocuvm(pde_t *pgdir, uint oldsz, uint newsz)
{
8010924d:	55                   	push   %ebp
8010924e:	89 e5                	mov    %esp,%ebp
80109250:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;
  uint a, pa;

  if(newsz >= oldsz)
80109253:	8b 45 10             	mov    0x10(%ebp),%eax
80109256:	3b 45 0c             	cmp    0xc(%ebp),%eax
80109259:	72 08                	jb     80109263 <deallocuvm+0x16>
    return oldsz;
8010925b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010925e:	e9 ac 00 00 00       	jmp    8010930f <deallocuvm+0xc2>

  a = PGROUNDUP(newsz);
80109263:	8b 45 10             	mov    0x10(%ebp),%eax
80109266:	05 ff 0f 00 00       	add    $0xfff,%eax
8010926b:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80109270:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for(; a  < oldsz; a += PGSIZE){
80109273:	e9 88 00 00 00       	jmp    80109300 <deallocuvm+0xb3>
    pte = walkpgdir(pgdir, (char*)a, 0);
80109278:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010927b:	83 ec 04             	sub    $0x4,%esp
8010927e:	6a 00                	push   $0x0
80109280:	50                   	push   %eax
80109281:	ff 75 08             	push   0x8(%ebp)
80109284:	e8 f3 f9 ff ff       	call   80108c7c <walkpgdir>
80109289:	83 c4 10             	add    $0x10,%esp
8010928c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(!pte)
8010928f:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80109293:	75 16                	jne    801092ab <deallocuvm+0x5e>
      a = PGADDR(PDX(a) + 1, 0, 0) - PGSIZE;
80109295:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109298:	c1 e8 16             	shr    $0x16,%eax
8010929b:	83 c0 01             	add    $0x1,%eax
8010929e:	c1 e0 16             	shl    $0x16,%eax
801092a1:	2d 00 10 00 00       	sub    $0x1000,%eax
801092a6:	89 45 f4             	mov    %eax,-0xc(%ebp)
801092a9:	eb 4e                	jmp    801092f9 <deallocuvm+0xac>
    else if((*pte & PTE_P) != 0){
801092ab:	8b 45 f0             	mov    -0x10(%ebp),%eax
801092ae:	8b 00                	mov    (%eax),%eax
801092b0:	83 e0 01             	and    $0x1,%eax
801092b3:	85 c0                	test   %eax,%eax
801092b5:	74 42                	je     801092f9 <deallocuvm+0xac>
      pa = PTE_ADDR(*pte);
801092b7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801092ba:	8b 00                	mov    (%eax),%eax
801092bc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801092c1:	89 45 ec             	mov    %eax,-0x14(%ebp)
      if(pa == 0)
801092c4:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
801092c8:	75 0d                	jne    801092d7 <deallocuvm+0x8a>
        panic("kfree");
801092ca:	83 ec 0c             	sub    $0xc,%esp
801092cd:	68 ed 9e 10 80       	push   $0x80109eed
801092d2:	e8 de 72 ff ff       	call   801005b5 <panic>
      char *v = P2V(pa);
801092d7:	8b 45 ec             	mov    -0x14(%ebp),%eax
801092da:	05 00 00 00 80       	add    $0x80000000,%eax
801092df:	89 45 e8             	mov    %eax,-0x18(%ebp)
      kfree(v);
801092e2:	83 ec 0c             	sub    $0xc,%esp
801092e5:	ff 75 e8             	push   -0x18(%ebp)
801092e8:	e8 0f 99 ff ff       	call   80102bfc <kfree>
801092ed:	83 c4 10             	add    $0x10,%esp
      *pte = 0;
801092f0:	8b 45 f0             	mov    -0x10(%ebp),%eax
801092f3:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; a  < oldsz; a += PGSIZE){
801092f9:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80109300:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109303:	3b 45 0c             	cmp    0xc(%ebp),%eax
80109306:	0f 82 6c ff ff ff    	jb     80109278 <deallocuvm+0x2b>
    }
  }
  return newsz;
8010930c:	8b 45 10             	mov    0x10(%ebp),%eax
}
8010930f:	c9                   	leave  
80109310:	c3                   	ret    

80109311 <freevm>:

// Free a page table and all the physical memory pages
// in the user part.
void
freevm(pde_t *pgdir)
{
80109311:	55                   	push   %ebp
80109312:	89 e5                	mov    %esp,%ebp
80109314:	83 ec 18             	sub    $0x18,%esp
  uint i;

  if(pgdir == 0)
80109317:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
8010931b:	75 0d                	jne    8010932a <freevm+0x19>
    panic("freevm: no pgdir");
8010931d:	83 ec 0c             	sub    $0xc,%esp
80109320:	68 f3 9e 10 80       	push   $0x80109ef3
80109325:	e8 8b 72 ff ff       	call   801005b5 <panic>
  deallocuvm(pgdir, KERNBASE, 0);
8010932a:	83 ec 04             	sub    $0x4,%esp
8010932d:	6a 00                	push   $0x0
8010932f:	68 00 00 00 80       	push   $0x80000000
80109334:	ff 75 08             	push   0x8(%ebp)
80109337:	e8 11 ff ff ff       	call   8010924d <deallocuvm>
8010933c:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
8010933f:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80109346:	eb 48                	jmp    80109390 <freevm+0x7f>
    if(pgdir[i] & PTE_P){
80109348:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010934b:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80109352:	8b 45 08             	mov    0x8(%ebp),%eax
80109355:	01 d0                	add    %edx,%eax
80109357:	8b 00                	mov    (%eax),%eax
80109359:	83 e0 01             	and    $0x1,%eax
8010935c:	85 c0                	test   %eax,%eax
8010935e:	74 2c                	je     8010938c <freevm+0x7b>
      char * v = P2V(PTE_ADDR(pgdir[i]));
80109360:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109363:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
8010936a:	8b 45 08             	mov    0x8(%ebp),%eax
8010936d:	01 d0                	add    %edx,%eax
8010936f:	8b 00                	mov    (%eax),%eax
80109371:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80109376:	05 00 00 00 80       	add    $0x80000000,%eax
8010937b:	89 45 f0             	mov    %eax,-0x10(%ebp)
      kfree(v);
8010937e:	83 ec 0c             	sub    $0xc,%esp
80109381:	ff 75 f0             	push   -0x10(%ebp)
80109384:	e8 73 98 ff ff       	call   80102bfc <kfree>
80109389:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NPDENTRIES; i++){
8010938c:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80109390:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
80109397:	76 af                	jbe    80109348 <freevm+0x37>
    }
  }
  kfree((char*)pgdir);
80109399:	83 ec 0c             	sub    $0xc,%esp
8010939c:	ff 75 08             	push   0x8(%ebp)
8010939f:	e8 58 98 ff ff       	call   80102bfc <kfree>
801093a4:	83 c4 10             	add    $0x10,%esp
}
801093a7:	90                   	nop
801093a8:	c9                   	leave  
801093a9:	c3                   	ret    

801093aa <clearpteu>:

// Clear PTE_U on a page. Used to create an inaccessible
// page beneath the user stack.
void
clearpteu(pde_t *pgdir, char *uva)
{
801093aa:	55                   	push   %ebp
801093ab:	89 e5                	mov    %esp,%ebp
801093ad:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
801093b0:	83 ec 04             	sub    $0x4,%esp
801093b3:	6a 00                	push   $0x0
801093b5:	ff 75 0c             	push   0xc(%ebp)
801093b8:	ff 75 08             	push   0x8(%ebp)
801093bb:	e8 bc f8 ff ff       	call   80108c7c <walkpgdir>
801093c0:	83 c4 10             	add    $0x10,%esp
801093c3:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(pte == 0)
801093c6:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801093ca:	75 0d                	jne    801093d9 <clearpteu+0x2f>
    panic("clearpteu");
801093cc:	83 ec 0c             	sub    $0xc,%esp
801093cf:	68 04 9f 10 80       	push   $0x80109f04
801093d4:	e8 dc 71 ff ff       	call   801005b5 <panic>
  *pte &= ~PTE_U;
801093d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801093dc:	8b 00                	mov    (%eax),%eax
801093de:	83 e0 fb             	and    $0xfffffffb,%eax
801093e1:	89 c2                	mov    %eax,%edx
801093e3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801093e6:	89 10                	mov    %edx,(%eax)
}
801093e8:	90                   	nop
801093e9:	c9                   	leave  
801093ea:	c3                   	ret    

801093eb <copyuvm>:

// Given a parent process's page table, create a copy
// of it for a child.
pde_t*
copyuvm(pde_t *pgdir, uint sz)
{
801093eb:	55                   	push   %ebp
801093ec:	89 e5                	mov    %esp,%ebp
801093ee:	83 ec 28             	sub    $0x28,%esp
  pde_t *d;
  pte_t *pte;
  uint pa, i, flags;
  char *mem;

  if((d = setupkvm()) == 0)
801093f1:	e8 ac f9 ff ff       	call   80108da2 <setupkvm>
801093f6:	89 45 f0             	mov    %eax,-0x10(%ebp)
801093f9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801093fd:	75 0a                	jne    80109409 <copyuvm+0x1e>
    return 0;
801093ff:	b8 00 00 00 00       	mov    $0x0,%eax
80109404:	e9 f8 00 00 00       	jmp    80109501 <copyuvm+0x116>
  for(i = 0; i < sz; i += PGSIZE){
80109409:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80109410:	e9 c7 00 00 00       	jmp    801094dc <copyuvm+0xf1>
    if((pte = walkpgdir(pgdir, (void *) i, 0)) == 0)
80109415:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109418:	83 ec 04             	sub    $0x4,%esp
8010941b:	6a 00                	push   $0x0
8010941d:	50                   	push   %eax
8010941e:	ff 75 08             	push   0x8(%ebp)
80109421:	e8 56 f8 ff ff       	call   80108c7c <walkpgdir>
80109426:	83 c4 10             	add    $0x10,%esp
80109429:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010942c:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80109430:	75 0d                	jne    8010943f <copyuvm+0x54>
      panic("copyuvm: pte should exist");
80109432:	83 ec 0c             	sub    $0xc,%esp
80109435:	68 0e 9f 10 80       	push   $0x80109f0e
8010943a:	e8 76 71 ff ff       	call   801005b5 <panic>
    if(!(*pte & PTE_P))
8010943f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109442:	8b 00                	mov    (%eax),%eax
80109444:	83 e0 01             	and    $0x1,%eax
80109447:	85 c0                	test   %eax,%eax
80109449:	75 0d                	jne    80109458 <copyuvm+0x6d>
      panic("copyuvm: page not present");
8010944b:	83 ec 0c             	sub    $0xc,%esp
8010944e:	68 28 9f 10 80       	push   $0x80109f28
80109453:	e8 5d 71 ff ff       	call   801005b5 <panic>
    pa = PTE_ADDR(*pte);
80109458:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010945b:	8b 00                	mov    (%eax),%eax
8010945d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80109462:	89 45 e8             	mov    %eax,-0x18(%ebp)
    flags = PTE_FLAGS(*pte);
80109465:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109468:	8b 00                	mov    (%eax),%eax
8010946a:	25 ff 0f 00 00       	and    $0xfff,%eax
8010946f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
    if((mem = kalloc()) == 0)
80109472:	e8 1f 98 ff ff       	call   80102c96 <kalloc>
80109477:	89 45 e0             	mov    %eax,-0x20(%ebp)
8010947a:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
8010947e:	74 6d                	je     801094ed <copyuvm+0x102>
      goto bad;
    memmove(mem, (char*)P2V(pa), PGSIZE);
80109480:	8b 45 e8             	mov    -0x18(%ebp),%eax
80109483:	05 00 00 00 80       	add    $0x80000000,%eax
80109488:	83 ec 04             	sub    $0x4,%esp
8010948b:	68 00 10 00 00       	push   $0x1000
80109490:	50                   	push   %eax
80109491:	ff 75 e0             	push   -0x20(%ebp)
80109494:	e8 d9 ce ff ff       	call   80106372 <memmove>
80109499:	83 c4 10             	add    $0x10,%esp
    if(mappages(d, (void*)i, PGSIZE, V2P(mem), flags) < 0) {
8010949c:	8b 55 e4             	mov    -0x1c(%ebp),%edx
8010949f:	8b 45 e0             	mov    -0x20(%ebp),%eax
801094a2:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
801094a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801094ab:	83 ec 0c             	sub    $0xc,%esp
801094ae:	52                   	push   %edx
801094af:	51                   	push   %ecx
801094b0:	68 00 10 00 00       	push   $0x1000
801094b5:	50                   	push   %eax
801094b6:	ff 75 f0             	push   -0x10(%ebp)
801094b9:	e8 54 f8 ff ff       	call   80108d12 <mappages>
801094be:	83 c4 20             	add    $0x20,%esp
801094c1:	85 c0                	test   %eax,%eax
801094c3:	79 10                	jns    801094d5 <copyuvm+0xea>
      kfree(mem);
801094c5:	83 ec 0c             	sub    $0xc,%esp
801094c8:	ff 75 e0             	push   -0x20(%ebp)
801094cb:	e8 2c 97 ff ff       	call   80102bfc <kfree>
801094d0:	83 c4 10             	add    $0x10,%esp
      goto bad;
801094d3:	eb 19                	jmp    801094ee <copyuvm+0x103>
  for(i = 0; i < sz; i += PGSIZE){
801094d5:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801094dc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801094df:	3b 45 0c             	cmp    0xc(%ebp),%eax
801094e2:	0f 82 2d ff ff ff    	jb     80109415 <copyuvm+0x2a>
    }
  }
  return d;
801094e8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801094eb:	eb 14                	jmp    80109501 <copyuvm+0x116>
      goto bad;
801094ed:	90                   	nop

bad:
  freevm(d);
801094ee:	83 ec 0c             	sub    $0xc,%esp
801094f1:	ff 75 f0             	push   -0x10(%ebp)
801094f4:	e8 18 fe ff ff       	call   80109311 <freevm>
801094f9:	83 c4 10             	add    $0x10,%esp
  return 0;
801094fc:	b8 00 00 00 00       	mov    $0x0,%eax
}
80109501:	c9                   	leave  
80109502:	c3                   	ret    

80109503 <uva2ka>:

//PAGEBREAK!
// Map user virtual address to kernel address.
char*
uva2ka(pde_t *pgdir, char *uva)
{
80109503:	55                   	push   %ebp
80109504:	89 e5                	mov    %esp,%ebp
80109506:	83 ec 18             	sub    $0x18,%esp
  pte_t *pte;

  pte = walkpgdir(pgdir, uva, 0);
80109509:	83 ec 04             	sub    $0x4,%esp
8010950c:	6a 00                	push   $0x0
8010950e:	ff 75 0c             	push   0xc(%ebp)
80109511:	ff 75 08             	push   0x8(%ebp)
80109514:	e8 63 f7 ff ff       	call   80108c7c <walkpgdir>
80109519:	83 c4 10             	add    $0x10,%esp
8010951c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if((*pte & PTE_P) == 0)
8010951f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109522:	8b 00                	mov    (%eax),%eax
80109524:	83 e0 01             	and    $0x1,%eax
80109527:	85 c0                	test   %eax,%eax
80109529:	75 07                	jne    80109532 <uva2ka+0x2f>
    return 0;
8010952b:	b8 00 00 00 00       	mov    $0x0,%eax
80109530:	eb 22                	jmp    80109554 <uva2ka+0x51>
  if((*pte & PTE_U) == 0)
80109532:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109535:	8b 00                	mov    (%eax),%eax
80109537:	83 e0 04             	and    $0x4,%eax
8010953a:	85 c0                	test   %eax,%eax
8010953c:	75 07                	jne    80109545 <uva2ka+0x42>
    return 0;
8010953e:	b8 00 00 00 00       	mov    $0x0,%eax
80109543:	eb 0f                	jmp    80109554 <uva2ka+0x51>
  return (char*)P2V(PTE_ADDR(*pte));
80109545:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109548:	8b 00                	mov    (%eax),%eax
8010954a:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010954f:	05 00 00 00 80       	add    $0x80000000,%eax
}
80109554:	c9                   	leave  
80109555:	c3                   	ret    

80109556 <copyout>:
// Copy len bytes from p to user address va in page table pgdir.
// Most useful when pgdir is not the current page table.
// uva2ka ensures this only works for PTE_U pages.
int
copyout(pde_t *pgdir, uint va, void *p, uint len)
{
80109556:	55                   	push   %ebp
80109557:	89 e5                	mov    %esp,%ebp
80109559:	83 ec 18             	sub    $0x18,%esp
  char *buf, *pa0;
  uint n, va0;

  buf = (char*)p;
8010955c:	8b 45 10             	mov    0x10(%ebp),%eax
8010955f:	89 45 f4             	mov    %eax,-0xc(%ebp)
  while(len > 0){
80109562:	eb 7f                	jmp    801095e3 <copyout+0x8d>
    va0 = (uint)PGROUNDDOWN(va);
80109564:	8b 45 0c             	mov    0xc(%ebp),%eax
80109567:	25 00 f0 ff ff       	and    $0xfffff000,%eax
8010956c:	89 45 ec             	mov    %eax,-0x14(%ebp)
    pa0 = uva2ka(pgdir, (char*)va0);
8010956f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109572:	83 ec 08             	sub    $0x8,%esp
80109575:	50                   	push   %eax
80109576:	ff 75 08             	push   0x8(%ebp)
80109579:	e8 85 ff ff ff       	call   80109503 <uva2ka>
8010957e:	83 c4 10             	add    $0x10,%esp
80109581:	89 45 e8             	mov    %eax,-0x18(%ebp)
    if(pa0 == 0)
80109584:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80109588:	75 07                	jne    80109591 <copyout+0x3b>
      return -1;
8010958a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010958f:	eb 61                	jmp    801095f2 <copyout+0x9c>
    n = PGSIZE - (va - va0);
80109591:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109594:	2b 45 0c             	sub    0xc(%ebp),%eax
80109597:	05 00 10 00 00       	add    $0x1000,%eax
8010959c:	89 45 f0             	mov    %eax,-0x10(%ebp)
    if(n > len)
8010959f:	8b 45 f0             	mov    -0x10(%ebp),%eax
801095a2:	3b 45 14             	cmp    0x14(%ebp),%eax
801095a5:	76 06                	jbe    801095ad <copyout+0x57>
      n = len;
801095a7:	8b 45 14             	mov    0x14(%ebp),%eax
801095aa:	89 45 f0             	mov    %eax,-0x10(%ebp)
    memmove(pa0 + (va - va0), buf, n);
801095ad:	8b 45 0c             	mov    0xc(%ebp),%eax
801095b0:	2b 45 ec             	sub    -0x14(%ebp),%eax
801095b3:	89 c2                	mov    %eax,%edx
801095b5:	8b 45 e8             	mov    -0x18(%ebp),%eax
801095b8:	01 d0                	add    %edx,%eax
801095ba:	83 ec 04             	sub    $0x4,%esp
801095bd:	ff 75 f0             	push   -0x10(%ebp)
801095c0:	ff 75 f4             	push   -0xc(%ebp)
801095c3:	50                   	push   %eax
801095c4:	e8 a9 cd ff ff       	call   80106372 <memmove>
801095c9:	83 c4 10             	add    $0x10,%esp
    len -= n;
801095cc:	8b 45 f0             	mov    -0x10(%ebp),%eax
801095cf:	29 45 14             	sub    %eax,0x14(%ebp)
    buf += n;
801095d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801095d5:	01 45 f4             	add    %eax,-0xc(%ebp)
    va = va0 + PGSIZE;
801095d8:	8b 45 ec             	mov    -0x14(%ebp),%eax
801095db:	05 00 10 00 00       	add    $0x1000,%eax
801095e0:	89 45 0c             	mov    %eax,0xc(%ebp)
  while(len > 0){
801095e3:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
801095e7:	0f 85 77 ff ff ff    	jne    80109564 <copyout+0xe>
  }
  return 0;
801095ed:	b8 00 00 00 00       	mov    $0x0,%eax
}
801095f2:	c9                   	leave  
801095f3:	c3                   	ret    
