
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
80100028:	bc 40 83 11 80       	mov    $0x80118340,%esp
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
8010003d:	68 5c 94 10 80       	push   $0x8010945c
80100042:	68 80 c5 10 80       	push   $0x8010c580
80100047:	e8 41 5f 00 00       	call   80105f8d <initlock>
8010004c:	83 c4 10             	add    $0x10,%esp

//PAGEBREAK!
  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
8010004f:	c7 05 cc 0c 11 80 7c 	movl   $0x80110c7c,0x80110ccc
80100056:	0c 11 80 
  bcache.head.next = &bcache.head;
80100059:	c7 05 d0 0c 11 80 7c 	movl   $0x80110c7c,0x80110cd0
80100060:	0c 11 80 
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
80100063:	c7 45 f4 b4 c5 10 80 	movl   $0x8010c5b4,-0xc(%ebp)
8010006a:	eb 47                	jmp    801000b3 <binit+0x7f>
    b->next = bcache.head.next;
8010006c:	8b 15 d0 0c 11 80    	mov    0x80110cd0,%edx
80100072:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100075:	89 50 54             	mov    %edx,0x54(%eax)
    b->prev = &bcache.head;
80100078:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010007b:	c7 40 50 7c 0c 11 80 	movl   $0x80110c7c,0x50(%eax)
    initsleeplock(&b->lock, "buffer");
80100082:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100085:	83 c0 0c             	add    $0xc,%eax
80100088:	83 ec 08             	sub    $0x8,%esp
8010008b:	68 63 94 10 80       	push   $0x80109463
80100090:	50                   	push   %eax
80100091:	e8 74 5d 00 00       	call   80105e0a <initsleeplock>
80100096:	83 c4 10             	add    $0x10,%esp
    bcache.head.next->prev = b;
80100099:	a1 d0 0c 11 80       	mov    0x80110cd0,%eax
8010009e:	8b 55 f4             	mov    -0xc(%ebp),%edx
801000a1:	89 50 50             	mov    %edx,0x50(%eax)
    bcache.head.next = b;
801000a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801000a7:	a3 d0 0c 11 80       	mov    %eax,0x80110cd0
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
801000ac:	81 45 f4 5c 02 00 00 	addl   $0x25c,-0xc(%ebp)
801000b3:	b8 7c 0c 11 80       	mov    $0x80110c7c,%eax
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
801000ca:	68 80 c5 10 80       	push   $0x8010c580
801000cf:	e8 db 5e 00 00       	call   80105faf <acquire>
801000d4:	83 c4 10             	add    $0x10,%esp

  // Is the block already cached?
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
801000d7:	a1 d0 0c 11 80       	mov    0x80110cd0,%eax
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
80100109:	68 80 c5 10 80       	push   $0x8010c580
8010010e:	e8 0a 5f 00 00       	call   8010601d <release>
80100113:	83 c4 10             	add    $0x10,%esp
      acquiresleep(&b->lock);
80100116:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100119:	83 c0 0c             	add    $0xc,%eax
8010011c:	83 ec 0c             	sub    $0xc,%esp
8010011f:	50                   	push   %eax
80100120:	e8 21 5d 00 00       	call   80105e46 <acquiresleep>
80100125:	83 c4 10             	add    $0x10,%esp
      return b;
80100128:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010012b:	e9 9d 00 00 00       	jmp    801001cd <bget+0x10c>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
80100130:	8b 45 f4             	mov    -0xc(%ebp),%eax
80100133:	8b 40 54             	mov    0x54(%eax),%eax
80100136:	89 45 f4             	mov    %eax,-0xc(%ebp)
80100139:	81 7d f4 7c 0c 11 80 	cmpl   $0x80110c7c,-0xc(%ebp)
80100140:	75 9f                	jne    801000e1 <bget+0x20>
  }

  // Not cached; recycle an unused buffer.
  // Even if refcnt==0, B_DIRTY indicates a buffer is in use
  // because log.c has modified it but not yet committed it.
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
80100142:	a1 cc 0c 11 80       	mov    0x80110ccc,%eax
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
8010018a:	68 80 c5 10 80       	push   $0x8010c580
8010018f:	e8 89 5e 00 00       	call   8010601d <release>
80100194:	83 c4 10             	add    $0x10,%esp
      acquiresleep(&b->lock);
80100197:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010019a:	83 c0 0c             	add    $0xc,%eax
8010019d:	83 ec 0c             	sub    $0xc,%esp
801001a0:	50                   	push   %eax
801001a1:	e8 a0 5c 00 00       	call   80105e46 <acquiresleep>
801001a6:	83 c4 10             	add    $0x10,%esp
      return b;
801001a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001ac:	eb 1f                	jmp    801001cd <bget+0x10c>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
801001ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801001b1:	8b 40 50             	mov    0x50(%eax),%eax
801001b4:	89 45 f4             	mov    %eax,-0xc(%ebp)
801001b7:	81 7d f4 7c 0c 11 80 	cmpl   $0x80110c7c,-0xc(%ebp)
801001be:	75 8c                	jne    8010014c <bget+0x8b>
    }
  }
  panic("bget: no buffers");
801001c0:	83 ec 0c             	sub    $0xc,%esp
801001c3:	68 6a 94 10 80       	push   $0x8010946a
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
80100218:	e8 db 5c 00 00       	call   80105ef8 <holdingsleep>
8010021d:	83 c4 10             	add    $0x10,%esp
80100220:	85 c0                	test   %eax,%eax
80100222:	75 0d                	jne    80100231 <bwrite+0x29>
    panic("bwrite");
80100224:	83 ec 0c             	sub    $0xc,%esp
80100227:	68 7b 94 10 80       	push   $0x8010947b
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
80100261:	e8 92 5c 00 00       	call   80105ef8 <holdingsleep>
80100266:	83 c4 10             	add    $0x10,%esp
80100269:	85 c0                	test   %eax,%eax
8010026b:	75 0d                	jne    8010027a <brelse+0x29>
    panic("brelse");
8010026d:	83 ec 0c             	sub    $0xc,%esp
80100270:	68 82 94 10 80       	push   $0x80109482
80100275:	e8 3b 03 00 00       	call   801005b5 <panic>

  releasesleep(&b->lock);
8010027a:	8b 45 08             	mov    0x8(%ebp),%eax
8010027d:	83 c0 0c             	add    $0xc,%eax
80100280:	83 ec 0c             	sub    $0xc,%esp
80100283:	50                   	push   %eax
80100284:	e8 21 5c 00 00       	call   80105eaa <releasesleep>
80100289:	83 c4 10             	add    $0x10,%esp

  acquire(&bcache.lock);
8010028c:	83 ec 0c             	sub    $0xc,%esp
8010028f:	68 80 c5 10 80       	push   $0x8010c580
80100294:	e8 16 5d 00 00       	call   80105faf <acquire>
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
801002d3:	8b 15 d0 0c 11 80    	mov    0x80110cd0,%edx
801002d9:	8b 45 08             	mov    0x8(%ebp),%eax
801002dc:	89 50 54             	mov    %edx,0x54(%eax)
    b->prev = &bcache.head;
801002df:	8b 45 08             	mov    0x8(%ebp),%eax
801002e2:	c7 40 50 7c 0c 11 80 	movl   $0x80110c7c,0x50(%eax)
    bcache.head.next->prev = b;
801002e9:	a1 d0 0c 11 80       	mov    0x80110cd0,%eax
801002ee:	8b 55 08             	mov    0x8(%ebp),%edx
801002f1:	89 50 50             	mov    %edx,0x50(%eax)
    bcache.head.next = b;
801002f4:	8b 45 08             	mov    0x8(%ebp),%eax
801002f7:	a3 d0 0c 11 80       	mov    %eax,0x80110cd0
  }
  
  release(&bcache.lock);
801002fc:	83 ec 0c             	sub    $0xc,%esp
801002ff:	68 80 c5 10 80       	push   $0x8010c580
80100304:	e8 14 5d 00 00       	call   8010601d <release>
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
80100406:	a1 b4 0f 11 80       	mov    0x80110fb4,%eax
8010040b:	89 45 e8             	mov    %eax,-0x18(%ebp)
  if(locking)
8010040e:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80100412:	74 10                	je     80100424 <cprintf+0x24>
    acquire(&cons.lock);
80100414:	83 ec 0c             	sub    $0xc,%esp
80100417:	68 80 0f 11 80       	push   $0x80110f80
8010041c:	e8 8e 5b 00 00       	call   80105faf <acquire>
80100421:	83 c4 10             	add    $0x10,%esp

  if (fmt == 0)
80100424:	8b 45 08             	mov    0x8(%ebp),%eax
80100427:	85 c0                	test   %eax,%eax
80100429:	75 0d                	jne    80100438 <cprintf+0x38>
    panic("null fmt");
8010042b:	83 ec 0c             	sub    $0xc,%esp
8010042e:	68 89 94 10 80       	push   $0x80109489
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
8010051c:	c7 45 ec 92 94 10 80 	movl   $0x80109492,-0x14(%ebp)
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
801005a5:	68 80 0f 11 80       	push   $0x80110f80
801005aa:	e8 6e 5a 00 00       	call   8010601d <release>
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
801005c0:	c7 05 b4 0f 11 80 00 	movl   $0x0,0x80110fb4
801005c7:	00 00 00 
  // use lapiccpunum so that we can call panic from mycpu()
  cprintf("lapicid %d: panic: ", lapicid());
801005ca:	e8 21 2a 00 00       	call   80102ff0 <lapicid>
801005cf:	83 ec 08             	sub    $0x8,%esp
801005d2:	50                   	push   %eax
801005d3:	68 99 94 10 80       	push   $0x80109499
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
801005f2:	68 ad 94 10 80       	push   $0x801094ad
801005f7:	e8 04 fe ff ff       	call   80100400 <cprintf>
801005fc:	83 c4 10             	add    $0x10,%esp
  getcallerpcs(&s, pcs);
801005ff:	83 ec 08             	sub    $0x8,%esp
80100602:	8d 45 cc             	lea    -0x34(%ebp),%eax
80100605:	50                   	push   %eax
80100606:	8d 45 08             	lea    0x8(%ebp),%eax
80100609:	50                   	push   %eax
8010060a:	e8 60 5a 00 00       	call   8010606f <getcallerpcs>
8010060f:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
80100612:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80100619:	eb 1c                	jmp    80100637 <panic+0x82>
    cprintf(" %p", pcs[i]);
8010061b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010061e:	8b 44 85 cc          	mov    -0x34(%ebp,%eax,4),%eax
80100622:	83 ec 08             	sub    $0x8,%esp
80100625:	50                   	push   %eax
80100626:	68 af 94 10 80       	push   $0x801094af
8010062b:	e8 d0 fd ff ff       	call   80100400 <cprintf>
80100630:	83 c4 10             	add    $0x10,%esp
  for(i=0; i<10; i++)
80100633:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80100637:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
8010063b:	7e de                	jle    8010061b <panic+0x66>
  panicked = 1; // freeze other CPU
8010063d:	c7 05 6c 0f 11 80 01 	movl   $0x1,0x80110f6c
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
8010071b:	68 b3 94 10 80       	push   $0x801094b3
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
80100748:	e8 a7 5b 00 00       	call   801062f4 <memmove>
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
80100773:	e8 bd 5a 00 00       	call   80106235 <memset>
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
801007ee:	a1 6c 0f 11 80       	mov    0x80110f6c,%eax
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
8010080c:	e8 fa 73 00 00       	call   80107c0b <uartputc>
80100811:	83 c4 10             	add    $0x10,%esp
80100814:	83 ec 0c             	sub    $0xc,%esp
80100817:	6a 20                	push   $0x20
80100819:	e8 ed 73 00 00       	call   80107c0b <uartputc>
8010081e:	83 c4 10             	add    $0x10,%esp
80100821:	83 ec 0c             	sub    $0xc,%esp
80100824:	6a 08                	push   $0x8
80100826:	e8 e0 73 00 00       	call   80107c0b <uartputc>
8010082b:	83 c4 10             	add    $0x10,%esp
8010082e:	eb 0e                	jmp    8010083e <consputc+0x56>
  } else
    uartputc(c);
80100830:	83 ec 0c             	sub    $0xc,%esp
80100833:	ff 75 08             	push   0x8(%ebp)
80100836:	e8 d0 73 00 00       	call   80107c0b <uartputc>
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
8010085f:	68 80 0f 11 80       	push   $0x80110f80
80100864:	e8 46 57 00 00       	call   80105faf <acquire>
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
801008b1:	a1 68 0f 11 80       	mov    0x80110f68,%eax
801008b6:	83 e8 01             	sub    $0x1,%eax
801008b9:	a3 68 0f 11 80       	mov    %eax,0x80110f68
        consputc(BACKSPACE);
801008be:	83 ec 0c             	sub    $0xc,%esp
801008c1:	68 00 01 00 00       	push   $0x100
801008c6:	e8 1d ff ff ff       	call   801007e8 <consputc>
801008cb:	83 c4 10             	add    $0x10,%esp
      while(input.e != input.w &&
801008ce:	8b 15 68 0f 11 80    	mov    0x80110f68,%edx
801008d4:	a1 64 0f 11 80       	mov    0x80110f64,%eax
801008d9:	39 c2                	cmp    %eax,%edx
801008db:	0f 84 e0 00 00 00    	je     801009c1 <consoleintr+0x172>
            input.buf[(input.e-1) % INPUT_BUF] != '\n'){
801008e1:	a1 68 0f 11 80       	mov    0x80110f68,%eax
801008e6:	83 e8 01             	sub    $0x1,%eax
801008e9:	83 e0 7f             	and    $0x7f,%eax
801008ec:	0f b6 80 e0 0e 11 80 	movzbl -0x7feef120(%eax),%eax
      while(input.e != input.w &&
801008f3:	3c 0a                	cmp    $0xa,%al
801008f5:	75 ba                	jne    801008b1 <consoleintr+0x62>
      }
      break;
801008f7:	e9 c5 00 00 00       	jmp    801009c1 <consoleintr+0x172>
    case C('H'): case '\x7f':  // Backspace
      if(input.e != input.w){
801008fc:	8b 15 68 0f 11 80    	mov    0x80110f68,%edx
80100902:	a1 64 0f 11 80       	mov    0x80110f64,%eax
80100907:	39 c2                	cmp    %eax,%edx
80100909:	0f 84 b2 00 00 00    	je     801009c1 <consoleintr+0x172>
        input.e--;
8010090f:	a1 68 0f 11 80       	mov    0x80110f68,%eax
80100914:	83 e8 01             	sub    $0x1,%eax
80100917:	a3 68 0f 11 80       	mov    %eax,0x80110f68
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
8010093b:	a1 68 0f 11 80       	mov    0x80110f68,%eax
80100940:	8b 15 60 0f 11 80    	mov    0x80110f60,%edx
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
80100960:	a1 68 0f 11 80       	mov    0x80110f68,%eax
80100965:	8d 50 01             	lea    0x1(%eax),%edx
80100968:	89 15 68 0f 11 80    	mov    %edx,0x80110f68
8010096e:	83 e0 7f             	and    $0x7f,%eax
80100971:	8b 55 f0             	mov    -0x10(%ebp),%edx
80100974:	88 90 e0 0e 11 80    	mov    %dl,-0x7feef120(%eax)
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
80100994:	a1 68 0f 11 80       	mov    0x80110f68,%eax
80100999:	8b 15 60 0f 11 80    	mov    0x80110f60,%edx
8010099f:	83 ea 80             	sub    $0xffffff80,%edx
801009a2:	39 d0                	cmp    %edx,%eax
801009a4:	75 1a                	jne    801009c0 <consoleintr+0x171>
          input.w = input.e;
801009a6:	a1 68 0f 11 80       	mov    0x80110f68,%eax
801009ab:	a3 64 0f 11 80       	mov    %eax,0x80110f64
          wakeup(&input.r);
801009b0:	83 ec 0c             	sub    $0xc,%esp
801009b3:	68 60 0f 11 80       	push   $0x80110f60
801009b8:	e8 e4 4a 00 00       	call   801054a1 <wakeup>
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
801009d6:	68 80 0f 11 80       	push   $0x80110f80
801009db:	e8 3d 56 00 00       	call   8010601d <release>
801009e0:	83 c4 10             	add    $0x10,%esp
  if(doprocdump) {
801009e3:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801009e7:	74 05                	je     801009ee <consoleintr+0x19f>
    procdump();  // now call procdump() wo. cons.lock held
801009e9:	e8 f9 4b 00 00       	call   801055e7 <procdump>
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
80100a0e:	68 80 0f 11 80       	push   $0x80110f80
80100a13:	e8 97 55 00 00       	call   80105faf <acquire>
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
80100a2f:	68 80 0f 11 80       	push   $0x80110f80
80100a34:	e8 e4 55 00 00       	call   8010601d <release>
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
80100a57:	68 80 0f 11 80       	push   $0x80110f80
80100a5c:	68 60 0f 11 80       	push   $0x80110f60
80100a61:	e8 bd 48 00 00       	call   80105323 <sleep>
80100a66:	83 c4 10             	add    $0x10,%esp
    while(input.r == input.w){
80100a69:	8b 15 60 0f 11 80    	mov    0x80110f60,%edx
80100a6f:	a1 64 0f 11 80       	mov    0x80110f64,%eax
80100a74:	39 c2                	cmp    %eax,%edx
80100a76:	74 a8                	je     80100a20 <consoleread+0x2f>
    }
    c = input.buf[input.r++ % INPUT_BUF];
80100a78:	a1 60 0f 11 80       	mov    0x80110f60,%eax
80100a7d:	8d 50 01             	lea    0x1(%eax),%edx
80100a80:	89 15 60 0f 11 80    	mov    %edx,0x80110f60
80100a86:	83 e0 7f             	and    $0x7f,%eax
80100a89:	0f b6 80 e0 0e 11 80 	movzbl -0x7feef120(%eax),%eax
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
80100aa4:	a1 60 0f 11 80       	mov    0x80110f60,%eax
80100aa9:	83 e8 01             	sub    $0x1,%eax
80100aac:	a3 60 0f 11 80       	mov    %eax,0x80110f60
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
80100ada:	68 80 0f 11 80       	push   $0x80110f80
80100adf:	e8 39 55 00 00       	call   8010601d <release>
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
80100b16:	68 80 0f 11 80       	push   $0x80110f80
80100b1b:	e8 8f 54 00 00       	call   80105faf <acquire>
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
80100b58:	68 80 0f 11 80       	push   $0x80110f80
80100b5d:	e8 bb 54 00 00       	call   8010601d <release>
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
80100b81:	68 c6 94 10 80       	push   $0x801094c6
80100b86:	68 80 0f 11 80       	push   $0x80110f80
80100b8b:	e8 fd 53 00 00       	call   80105f8d <initlock>
80100b90:	83 c4 10             	add    $0x10,%esp

  devsw[CONSOLE].write = consolewrite;
80100b93:	c7 05 cc 0f 11 80 ff 	movl   $0x80100aff,0x80110fcc
80100b9a:	0a 10 80 
  devsw[CONSOLE].read = consoleread;
80100b9d:	c7 05 c8 0f 11 80 f1 	movl   $0x801009f1,0x80110fc8
80100ba4:	09 10 80 
  cons.locking = 1;
80100ba7:	c7 05 b4 0f 11 80 01 	movl   $0x1,0x80110fb4
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
80100bf8:	68 ce 94 10 80       	push   $0x801094ce
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
80100c54:	e8 ae 7f 00 00       	call   80108c07 <setupkvm>
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
80100cfa:	e8 ae 82 00 00       	call   80108fad <allocuvm>
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
80100d40:	e8 9b 81 00 00       	call   80108ee0 <loaduvm>
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
80100daf:	e8 f9 81 00 00       	call   80108fad <allocuvm>
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
80100dd3:	e8 37 84 00 00       	call   8010920f <clearpteu>
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
80100e0c:	e8 72 56 00 00       	call   80106483 <strlen>
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
80100e39:	e8 45 56 00 00       	call   80106483 <strlen>
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
80100e5f:	e8 57 85 00 00       	call   801093bb <copyout>
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
80100efb:	e8 bb 84 00 00       	call   801093bb <copyout>
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
80100f49:	e8 ea 54 00 00       	call   80106438 <safestrcpy>
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
80100f8c:	e8 40 7d 00 00       	call   80108cd1 <switchuvm>
80100f91:	83 c4 10             	add    $0x10,%esp
  freevm(oldpgdir);
80100f94:	83 ec 0c             	sub    $0xc,%esp
80100f97:	ff 75 cc             	push   -0x34(%ebp)
80100f9a:	e8 d7 81 00 00       	call   80109176 <freevm>
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
80100fda:	e8 97 81 00 00       	call   80109176 <freevm>
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
8010100b:	68 da 94 10 80       	push   $0x801094da
80101010:	68 20 10 11 80       	push   $0x80111020
80101015:	e8 73 4f 00 00       	call   80105f8d <initlock>
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
80101029:	68 20 10 11 80       	push   $0x80111020
8010102e:	e8 7c 4f 00 00       	call   80105faf <acquire>
80101033:	83 c4 10             	add    $0x10,%esp
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101036:	c7 45 f4 54 10 11 80 	movl   $0x80111054,-0xc(%ebp)
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
80101056:	68 20 10 11 80       	push   $0x80111020
8010105b:	e8 bd 4f 00 00       	call   8010601d <release>
80101060:	83 c4 10             	add    $0x10,%esp
      return f;
80101063:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101066:	eb 23                	jmp    8010108b <filealloc+0x6b>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
80101068:	83 45 f4 18          	addl   $0x18,-0xc(%ebp)
8010106c:	b8 b4 19 11 80       	mov    $0x801119b4,%eax
80101071:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80101074:	72 c9                	jb     8010103f <filealloc+0x1f>
    }
  }
  release(&ftable.lock);
80101076:	83 ec 0c             	sub    $0xc,%esp
80101079:	68 20 10 11 80       	push   $0x80111020
8010107e:	e8 9a 4f 00 00       	call   8010601d <release>
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
80101096:	68 20 10 11 80       	push   $0x80111020
8010109b:	e8 0f 4f 00 00       	call   80105faf <acquire>
801010a0:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
801010a3:	8b 45 08             	mov    0x8(%ebp),%eax
801010a6:	8b 40 04             	mov    0x4(%eax),%eax
801010a9:	85 c0                	test   %eax,%eax
801010ab:	7f 0d                	jg     801010ba <filedup+0x2d>
    panic("filedup");
801010ad:	83 ec 0c             	sub    $0xc,%esp
801010b0:	68 e1 94 10 80       	push   $0x801094e1
801010b5:	e8 fb f4 ff ff       	call   801005b5 <panic>
  f->ref++;
801010ba:	8b 45 08             	mov    0x8(%ebp),%eax
801010bd:	8b 40 04             	mov    0x4(%eax),%eax
801010c0:	8d 50 01             	lea    0x1(%eax),%edx
801010c3:	8b 45 08             	mov    0x8(%ebp),%eax
801010c6:	89 50 04             	mov    %edx,0x4(%eax)
  release(&ftable.lock);
801010c9:	83 ec 0c             	sub    $0xc,%esp
801010cc:	68 20 10 11 80       	push   $0x80111020
801010d1:	e8 47 4f 00 00       	call   8010601d <release>
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
801010e7:	68 20 10 11 80       	push   $0x80111020
801010ec:	e8 be 4e 00 00       	call   80105faf <acquire>
801010f1:	83 c4 10             	add    $0x10,%esp
  if(f->ref < 1)
801010f4:	8b 45 08             	mov    0x8(%ebp),%eax
801010f7:	8b 40 04             	mov    0x4(%eax),%eax
801010fa:	85 c0                	test   %eax,%eax
801010fc:	7f 0d                	jg     8010110b <fileclose+0x2d>
    panic("fileclose");
801010fe:	83 ec 0c             	sub    $0xc,%esp
80101101:	68 e9 94 10 80       	push   $0x801094e9
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
80101127:	68 20 10 11 80       	push   $0x80111020
8010112c:	e8 ec 4e 00 00       	call   8010601d <release>
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
80101175:	68 20 10 11 80       	push   $0x80111020
8010117a:	e8 9e 4e 00 00       	call   8010601d <release>
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
801012c9:	68 f3 94 10 80       	push   $0x801094f3
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
801013cc:	68 fc 94 10 80       	push   $0x801094fc
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
80101402:	68 0c 95 10 80       	push   $0x8010950c
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
8010143a:	e8 b5 4e 00 00       	call   801062f4 <memmove>
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
80101480:	e8 b0 4d 00 00       	call   80106235 <memset>
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
801014d3:	a1 d8 19 11 80       	mov    0x801119d8,%eax
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
801015a9:	a1 c0 19 11 80       	mov    0x801119c0,%eax
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
801015cb:	8b 15 c0 19 11 80    	mov    0x801119c0,%edx
801015d1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801015d4:	39 c2                	cmp    %eax,%edx
801015d6:	0f 87 e4 fe ff ff    	ja     801014c0 <balloc+0x19>
  }
  panic("balloc: out of blocks");
801015dc:	83 ec 0c             	sub    $0xc,%esp
801015df:	68 18 95 10 80       	push   $0x80109518
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
801015f9:	a1 d8 19 11 80       	mov    0x801119d8,%eax
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
80101657:	68 2e 95 10 80       	push   $0x8010952e
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
801016bb:	68 41 95 10 80       	push   $0x80109541
801016c0:	68 e0 19 11 80       	push   $0x801119e0
801016c5:	e8 c3 48 00 00       	call   80105f8d <initlock>
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
801016e6:	05 e0 19 11 80       	add    $0x801119e0,%eax
801016eb:	83 c0 10             	add    $0x10,%eax
801016ee:	83 ec 08             	sub    $0x8,%esp
801016f1:	68 48 95 10 80       	push   $0x80109548
801016f6:	50                   	push   %eax
801016f7:	e8 0e 47 00 00       	call   80105e0a <initsleeplock>
801016fc:	83 c4 10             	add    $0x10,%esp
  for(i = 0; i < NINODE; i++) {
801016ff:	83 45 e4 01          	addl   $0x1,-0x1c(%ebp)
80101703:	83 7d e4 31          	cmpl   $0x31,-0x1c(%ebp)
80101707:	7e cd                	jle    801016d6 <iinit+0x2e>
  }

  readsb(dev, &sb);
80101709:	83 ec 08             	sub    $0x8,%esp
8010170c:	68 c0 19 11 80       	push   $0x801119c0
80101711:	ff 75 08             	push   0x8(%ebp)
80101714:	e8 f8 fc ff ff       	call   80101411 <readsb>
80101719:	83 c4 10             	add    $0x10,%esp
  cprintf("sb: size %d nblocks %d ninodes %d nlog %d logstart %d\
8010171c:	a1 d8 19 11 80       	mov    0x801119d8,%eax
80101721:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80101724:	8b 3d d4 19 11 80    	mov    0x801119d4,%edi
8010172a:	8b 35 d0 19 11 80    	mov    0x801119d0,%esi
80101730:	8b 1d cc 19 11 80    	mov    0x801119cc,%ebx
80101736:	8b 0d c8 19 11 80    	mov    0x801119c8,%ecx
8010173c:	8b 15 c4 19 11 80    	mov    0x801119c4,%edx
80101742:	a1 c0 19 11 80       	mov    0x801119c0,%eax
80101747:	ff 75 d4             	push   -0x2c(%ebp)
8010174a:	57                   	push   %edi
8010174b:	56                   	push   %esi
8010174c:	53                   	push   %ebx
8010174d:	51                   	push   %ecx
8010174e:	52                   	push   %edx
8010174f:	50                   	push   %eax
80101750:	68 50 95 10 80       	push   $0x80109550
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
80101787:	a1 d4 19 11 80       	mov    0x801119d4,%eax
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
801017c9:	e8 67 4a 00 00       	call   80106235 <memset>
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
8010181d:	8b 15 c8 19 11 80    	mov    0x801119c8,%edx
80101823:	8b 45 f4             	mov    -0xc(%ebp),%eax
80101826:	39 c2                	cmp    %eax,%edx
80101828:	0f 87 51 ff ff ff    	ja     8010177f <ialloc+0x19>
  }
  panic("ialloc: no inodes");
8010182e:	83 ec 0c             	sub    $0xc,%esp
80101831:	68 a3 95 10 80       	push   $0x801095a3
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
8010184e:	a1 d4 19 11 80       	mov    0x801119d4,%eax
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
801018d7:	e8 18 4a 00 00       	call   801062f4 <memmove>
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
80101907:	68 e0 19 11 80       	push   $0x801119e0
8010190c:	e8 9e 46 00 00       	call   80105faf <acquire>
80101911:	83 c4 10             	add    $0x10,%esp

  // Is the inode already cached?
  empty = 0;
80101914:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  for(ip = &icache.inode[0]; ip < &icache.inode[NINODE]; ip++){
8010191b:	c7 45 f4 14 1a 11 80 	movl   $0x80111a14,-0xc(%ebp)
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
80101955:	68 e0 19 11 80       	push   $0x801119e0
8010195a:	e8 be 46 00 00       	call   8010601d <release>
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
80101984:	81 7d f4 34 36 11 80 	cmpl   $0x80113634,-0xc(%ebp)
8010198b:	72 97                	jb     80101924 <iget+0x26>
  }

  // Recycle an inode cache entry.
  if(empty == 0)
8010198d:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80101991:	75 0d                	jne    801019a0 <iget+0xa2>
    panic("iget: no inodes");
80101993:	83 ec 0c             	sub    $0xc,%esp
80101996:	68 b5 95 10 80       	push   $0x801095b5
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
801019ce:	68 e0 19 11 80       	push   $0x801119e0
801019d3:	e8 45 46 00 00       	call   8010601d <release>
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
801019e9:	68 e0 19 11 80       	push   $0x801119e0
801019ee:	e8 bc 45 00 00       	call   80105faf <acquire>
801019f3:	83 c4 10             	add    $0x10,%esp
  ip->ref++;
801019f6:	8b 45 08             	mov    0x8(%ebp),%eax
801019f9:	8b 40 08             	mov    0x8(%eax),%eax
801019fc:	8d 50 01             	lea    0x1(%eax),%edx
801019ff:	8b 45 08             	mov    0x8(%ebp),%eax
80101a02:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101a05:	83 ec 0c             	sub    $0xc,%esp
80101a08:	68 e0 19 11 80       	push   $0x801119e0
80101a0d:	e8 0b 46 00 00       	call   8010601d <release>
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
80101a33:	68 c5 95 10 80       	push   $0x801095c5
80101a38:	e8 78 eb ff ff       	call   801005b5 <panic>

  acquiresleep(&ip->lock);
80101a3d:	8b 45 08             	mov    0x8(%ebp),%eax
80101a40:	83 c0 0c             	add    $0xc,%eax
80101a43:	83 ec 0c             	sub    $0xc,%esp
80101a46:	50                   	push   %eax
80101a47:	e8 fa 43 00 00       	call   80105e46 <acquiresleep>
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
80101a68:	a1 d4 19 11 80       	mov    0x801119d4,%eax
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
80101af1:	e8 fe 47 00 00       	call   801062f4 <memmove>
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
80101b20:	68 cb 95 10 80       	push   $0x801095cb
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
80101b43:	e8 b0 43 00 00       	call   80105ef8 <holdingsleep>
80101b48:	83 c4 10             	add    $0x10,%esp
80101b4b:	85 c0                	test   %eax,%eax
80101b4d:	74 0a                	je     80101b59 <iunlock+0x2c>
80101b4f:	8b 45 08             	mov    0x8(%ebp),%eax
80101b52:	8b 40 08             	mov    0x8(%eax),%eax
80101b55:	85 c0                	test   %eax,%eax
80101b57:	7f 0d                	jg     80101b66 <iunlock+0x39>
    panic("iunlock");
80101b59:	83 ec 0c             	sub    $0xc,%esp
80101b5c:	68 da 95 10 80       	push   $0x801095da
80101b61:	e8 4f ea ff ff       	call   801005b5 <panic>

  releasesleep(&ip->lock);
80101b66:	8b 45 08             	mov    0x8(%ebp),%eax
80101b69:	83 c0 0c             	add    $0xc,%eax
80101b6c:	83 ec 0c             	sub    $0xc,%esp
80101b6f:	50                   	push   %eax
80101b70:	e8 35 43 00 00       	call   80105eaa <releasesleep>
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
80101b8b:	e8 b6 42 00 00       	call   80105e46 <acquiresleep>
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
80101bac:	68 e0 19 11 80       	push   $0x801119e0
80101bb1:	e8 f9 43 00 00       	call   80105faf <acquire>
80101bb6:	83 c4 10             	add    $0x10,%esp
    int r = ip->ref;
80101bb9:	8b 45 08             	mov    0x8(%ebp),%eax
80101bbc:	8b 40 08             	mov    0x8(%eax),%eax
80101bbf:	89 45 f4             	mov    %eax,-0xc(%ebp)
    release(&icache.lock);
80101bc2:	83 ec 0c             	sub    $0xc,%esp
80101bc5:	68 e0 19 11 80       	push   $0x801119e0
80101bca:	e8 4e 44 00 00       	call   8010601d <release>
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
80101c11:	e8 94 42 00 00       	call   80105eaa <releasesleep>
80101c16:	83 c4 10             	add    $0x10,%esp

  acquire(&icache.lock);
80101c19:	83 ec 0c             	sub    $0xc,%esp
80101c1c:	68 e0 19 11 80       	push   $0x801119e0
80101c21:	e8 89 43 00 00       	call   80105faf <acquire>
80101c26:	83 c4 10             	add    $0x10,%esp
  ip->ref--;
80101c29:	8b 45 08             	mov    0x8(%ebp),%eax
80101c2c:	8b 40 08             	mov    0x8(%eax),%eax
80101c2f:	8d 50 ff             	lea    -0x1(%eax),%edx
80101c32:	8b 45 08             	mov    0x8(%ebp),%eax
80101c35:	89 50 08             	mov    %edx,0x8(%eax)
  release(&icache.lock);
80101c38:	83 ec 0c             	sub    $0xc,%esp
80101c3b:	68 e0 19 11 80       	push   $0x801119e0
80101c40:	e8 d8 43 00 00       	call   8010601d <release>
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
80101d84:	68 e2 95 10 80       	push   $0x801095e2
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
80101f3a:	8b 04 c5 c0 0f 11 80 	mov    -0x7feef040(,%eax,8),%eax
80101f41:	85 c0                	test   %eax,%eax
80101f43:	75 0a                	jne    80101f4f <readi+0x49>
      return -1;
80101f45:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80101f4a:	e9 0a 01 00 00       	jmp    80102059 <readi+0x153>
    return devsw[ip->major].read(ip, dst, n);
80101f4f:	8b 45 08             	mov    0x8(%ebp),%eax
80101f52:	0f b7 40 52          	movzwl 0x52(%eax),%eax
80101f56:	98                   	cwtl   
80101f57:	8b 04 c5 c0 0f 11 80 	mov    -0x7feef040(,%eax,8),%eax
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
80102022:	e8 cd 42 00 00       	call   801062f4 <memmove>
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
8010208f:	8b 04 c5 c4 0f 11 80 	mov    -0x7feef03c(,%eax,8),%eax
80102096:	85 c0                	test   %eax,%eax
80102098:	75 0a                	jne    801020a4 <writei+0x49>
      return -1;
8010209a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010209f:	e9 3b 01 00 00       	jmp    801021df <writei+0x184>
    return devsw[ip->major].write(ip, src, n);
801020a4:	8b 45 08             	mov    0x8(%ebp),%eax
801020a7:	0f b7 40 52          	movzwl 0x52(%eax),%eax
801020ab:	98                   	cwtl   
801020ac:	8b 04 c5 c4 0f 11 80 	mov    -0x7feef03c(,%eax,8),%eax
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
80102172:	e8 7d 41 00 00       	call   801062f4 <memmove>
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
801021f2:	e8 93 41 00 00       	call   8010638a <strncmp>
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
80102212:	68 f5 95 10 80       	push   $0x801095f5
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
80102241:	68 07 96 10 80       	push   $0x80109607
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
80102316:	68 16 96 10 80       	push   $0x80109616
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
80102351:	e8 8a 40 00 00       	call   801063e0 <strncpy>
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
8010237d:	68 23 96 10 80       	push   $0x80109623
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
801023ef:	e8 00 3f 00 00       	call   801062f4 <memmove>
801023f4:	83 c4 10             	add    $0x10,%esp
801023f7:	eb 26                	jmp    8010241f <skipelem+0x91>
  else {
    memmove(name, s, len);
801023f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801023fc:	83 ec 04             	sub    $0x4,%esp
801023ff:	50                   	push   %eax
80102400:	ff 75 f4             	push   -0xc(%ebp)
80102403:	ff 75 0c             	push   0xc(%ebp)
80102406:	e8 e9 3e 00 00       	call   801062f4 <memmove>
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
8010265c:	68 2b 96 10 80       	push   $0x8010962b
80102661:	68 40 36 11 80       	push   $0x80113640
80102666:	e8 22 39 00 00       	call   80105f8d <initlock>
8010266b:	83 c4 10             	add    $0x10,%esp
  ioapicenable(IRQ_IDE, ncpu - 1);
8010266e:	a1 40 3d 11 80       	mov    0x80113d40,%eax
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
801026c3:	c7 05 78 36 11 80 01 	movl   $0x1,0x80113678
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
80102703:	68 2f 96 10 80       	push   $0x8010962f
80102708:	e8 a8 de ff ff       	call   801005b5 <panic>
  if(b->blockno >= FSSIZE)
8010270d:	8b 45 08             	mov    0x8(%ebp),%eax
80102710:	8b 40 08             	mov    0x8(%eax),%eax
80102713:	3d e7 03 00 00       	cmp    $0x3e7,%eax
80102718:	76 0d                	jbe    80102727 <idestart+0x33>
    panic("incorrect blockno");
8010271a:	83 ec 0c             	sub    $0xc,%esp
8010271d:	68 38 96 10 80       	push   $0x80109638
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
80102770:	68 2f 96 10 80       	push   $0x8010962f
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
8010288f:	68 40 36 11 80       	push   $0x80113640
80102894:	e8 16 37 00 00       	call   80105faf <acquire>
80102899:	83 c4 10             	add    $0x10,%esp

  if((b = idequeue) == 0){
8010289c:	a1 74 36 11 80       	mov    0x80113674,%eax
801028a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
801028a4:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801028a8:	75 15                	jne    801028bf <ideintr+0x39>
    release(&idelock);
801028aa:	83 ec 0c             	sub    $0xc,%esp
801028ad:	68 40 36 11 80       	push   $0x80113640
801028b2:	e8 66 37 00 00       	call   8010601d <release>
801028b7:	83 c4 10             	add    $0x10,%esp
    return;
801028ba:	e9 9a 00 00 00       	jmp    80102959 <ideintr+0xd3>
  }
  idequeue = b->qnext;
801028bf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801028c2:	8b 40 58             	mov    0x58(%eax),%eax
801028c5:	a3 74 36 11 80       	mov    %eax,0x80113674

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
80102927:	e8 75 2b 00 00       	call   801054a1 <wakeup>
8010292c:	83 c4 10             	add    $0x10,%esp

  // Start disk on next buf in queue.
  if(idequeue != 0)
8010292f:	a1 74 36 11 80       	mov    0x80113674,%eax
80102934:	85 c0                	test   %eax,%eax
80102936:	74 11                	je     80102949 <ideintr+0xc3>
    idestart(idequeue);
80102938:	a1 74 36 11 80       	mov    0x80113674,%eax
8010293d:	83 ec 0c             	sub    $0xc,%esp
80102940:	50                   	push   %eax
80102941:	e8 ae fd ff ff       	call   801026f4 <idestart>
80102946:	83 c4 10             	add    $0x10,%esp

  release(&idelock);
80102949:	83 ec 0c             	sub    $0xc,%esp
8010294c:	68 40 36 11 80       	push   $0x80113640
80102951:	e8 c7 36 00 00       	call   8010601d <release>
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
8010296b:	e8 88 35 00 00       	call   80105ef8 <holdingsleep>
80102970:	83 c4 10             	add    $0x10,%esp
80102973:	85 c0                	test   %eax,%eax
80102975:	75 0d                	jne    80102984 <iderw+0x29>
    panic("iderw: buf not locked");
80102977:	83 ec 0c             	sub    $0xc,%esp
8010297a:	68 4a 96 10 80       	push   $0x8010964a
8010297f:	e8 31 dc ff ff       	call   801005b5 <panic>
  if((b->flags & (B_VALID|B_DIRTY)) == B_VALID)
80102984:	8b 45 08             	mov    0x8(%ebp),%eax
80102987:	8b 00                	mov    (%eax),%eax
80102989:	83 e0 06             	and    $0x6,%eax
8010298c:	83 f8 02             	cmp    $0x2,%eax
8010298f:	75 0d                	jne    8010299e <iderw+0x43>
    panic("iderw: nothing to do");
80102991:	83 ec 0c             	sub    $0xc,%esp
80102994:	68 60 96 10 80       	push   $0x80109660
80102999:	e8 17 dc ff ff       	call   801005b5 <panic>
  if(b->dev != 0 && !havedisk1)
8010299e:	8b 45 08             	mov    0x8(%ebp),%eax
801029a1:	8b 40 04             	mov    0x4(%eax),%eax
801029a4:	85 c0                	test   %eax,%eax
801029a6:	74 16                	je     801029be <iderw+0x63>
801029a8:	a1 78 36 11 80       	mov    0x80113678,%eax
801029ad:	85 c0                	test   %eax,%eax
801029af:	75 0d                	jne    801029be <iderw+0x63>
    panic("iderw: ide disk 1 not present");
801029b1:	83 ec 0c             	sub    $0xc,%esp
801029b4:	68 75 96 10 80       	push   $0x80109675
801029b9:	e8 f7 db ff ff       	call   801005b5 <panic>

  acquire(&idelock);  //DOC:acquire-lock
801029be:	83 ec 0c             	sub    $0xc,%esp
801029c1:	68 40 36 11 80       	push   $0x80113640
801029c6:	e8 e4 35 00 00       	call   80105faf <acquire>
801029cb:	83 c4 10             	add    $0x10,%esp

  // Append b to idequeue.
  b->qnext = 0;
801029ce:	8b 45 08             	mov    0x8(%ebp),%eax
801029d1:	c7 40 58 00 00 00 00 	movl   $0x0,0x58(%eax)
  for(pp=&idequeue; *pp; pp=&(*pp)->qnext)  //DOC:insert-queue
801029d8:	c7 45 f4 74 36 11 80 	movl   $0x80113674,-0xc(%ebp)
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
801029fd:	a1 74 36 11 80       	mov    0x80113674,%eax
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
80102a1a:	68 40 36 11 80       	push   $0x80113640
80102a1f:	ff 75 08             	push   0x8(%ebp)
80102a22:	e8 fc 28 00 00       	call   80105323 <sleep>
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
80102a3a:	68 40 36 11 80       	push   $0x80113640
80102a3f:	e8 d9 35 00 00       	call   8010601d <release>
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
80102a4d:	a1 7c 36 11 80       	mov    0x8011367c,%eax
80102a52:	8b 55 08             	mov    0x8(%ebp),%edx
80102a55:	89 10                	mov    %edx,(%eax)
  return ioapic->data;
80102a57:	a1 7c 36 11 80       	mov    0x8011367c,%eax
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
80102a64:	a1 7c 36 11 80       	mov    0x8011367c,%eax
80102a69:	8b 55 08             	mov    0x8(%ebp),%edx
80102a6c:	89 10                	mov    %edx,(%eax)
  ioapic->data = data;
80102a6e:	a1 7c 36 11 80       	mov    0x8011367c,%eax
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
80102a82:	c7 05 7c 36 11 80 00 	movl   $0xfec00000,0x8011367c
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
80102ab1:	0f b6 05 44 3d 11 80 	movzbl 0x80113d44,%eax
80102ab8:	0f b6 c0             	movzbl %al,%eax
80102abb:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80102abe:	74 10                	je     80102ad0 <ioapicinit+0x54>
    cprintf("ioapicinit: id isn't equal to ioapicid; not a MP\n");
80102ac0:	83 ec 0c             	sub    $0xc,%esp
80102ac3:	68 94 96 10 80       	push   $0x80109694
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
80102b6a:	68 c6 96 10 80       	push   $0x801096c6
80102b6f:	68 80 36 11 80       	push   $0x80113680
80102b74:	e8 14 34 00 00       	call   80105f8d <initlock>
80102b79:	83 c4 10             	add    $0x10,%esp
  kmem.use_lock = 0;
80102b7c:	c7 05 b4 36 11 80 00 	movl   $0x0,0x801136b4
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
80102bb1:	c7 05 b4 36 11 80 01 	movl   $0x1,0x801136b4
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
80102c0e:	81 7d 08 40 83 11 80 	cmpl   $0x80118340,0x8(%ebp)
80102c15:	72 0f                	jb     80102c26 <kfree+0x2a>
80102c17:	8b 45 08             	mov    0x8(%ebp),%eax
80102c1a:	05 00 00 00 80       	add    $0x80000000,%eax
80102c1f:	3d ff ff ff 0d       	cmp    $0xdffffff,%eax
80102c24:	76 0d                	jbe    80102c33 <kfree+0x37>
    panic("kfree");
80102c26:	83 ec 0c             	sub    $0xc,%esp
80102c29:	68 cb 96 10 80       	push   $0x801096cb
80102c2e:	e8 82 d9 ff ff       	call   801005b5 <panic>

  // Fill with junk to catch dangling refs.
  memset(v, 1, PGSIZE);
80102c33:	83 ec 04             	sub    $0x4,%esp
80102c36:	68 00 10 00 00       	push   $0x1000
80102c3b:	6a 01                	push   $0x1
80102c3d:	ff 75 08             	push   0x8(%ebp)
80102c40:	e8 f0 35 00 00       	call   80106235 <memset>
80102c45:	83 c4 10             	add    $0x10,%esp

  if(kmem.use_lock)
80102c48:	a1 b4 36 11 80       	mov    0x801136b4,%eax
80102c4d:	85 c0                	test   %eax,%eax
80102c4f:	74 10                	je     80102c61 <kfree+0x65>
    acquire(&kmem.lock);
80102c51:	83 ec 0c             	sub    $0xc,%esp
80102c54:	68 80 36 11 80       	push   $0x80113680
80102c59:	e8 51 33 00 00       	call   80105faf <acquire>
80102c5e:	83 c4 10             	add    $0x10,%esp
  r = (struct run*)v;
80102c61:	8b 45 08             	mov    0x8(%ebp),%eax
80102c64:	89 45 f4             	mov    %eax,-0xc(%ebp)
  r->next = kmem.freelist;
80102c67:	8b 15 b8 36 11 80    	mov    0x801136b8,%edx
80102c6d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c70:	89 10                	mov    %edx,(%eax)
  kmem.freelist = r;
80102c72:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102c75:	a3 b8 36 11 80       	mov    %eax,0x801136b8
  if(kmem.use_lock)
80102c7a:	a1 b4 36 11 80       	mov    0x801136b4,%eax
80102c7f:	85 c0                	test   %eax,%eax
80102c81:	74 10                	je     80102c93 <kfree+0x97>
    release(&kmem.lock);
80102c83:	83 ec 0c             	sub    $0xc,%esp
80102c86:	68 80 36 11 80       	push   $0x80113680
80102c8b:	e8 8d 33 00 00       	call   8010601d <release>
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
80102c9c:	a1 b4 36 11 80       	mov    0x801136b4,%eax
80102ca1:	85 c0                	test   %eax,%eax
80102ca3:	74 10                	je     80102cb5 <kalloc+0x1f>
    acquire(&kmem.lock);
80102ca5:	83 ec 0c             	sub    $0xc,%esp
80102ca8:	68 80 36 11 80       	push   $0x80113680
80102cad:	e8 fd 32 00 00       	call   80105faf <acquire>
80102cb2:	83 c4 10             	add    $0x10,%esp
  r = kmem.freelist;
80102cb5:	a1 b8 36 11 80       	mov    0x801136b8,%eax
80102cba:	89 45 f4             	mov    %eax,-0xc(%ebp)
  if(r)
80102cbd:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80102cc1:	74 0a                	je     80102ccd <kalloc+0x37>
    kmem.freelist = r->next;
80102cc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80102cc6:	8b 00                	mov    (%eax),%eax
80102cc8:	a3 b8 36 11 80       	mov    %eax,0x801136b8
  if(kmem.use_lock)
80102ccd:	a1 b4 36 11 80       	mov    0x801136b4,%eax
80102cd2:	85 c0                	test   %eax,%eax
80102cd4:	74 10                	je     80102ce6 <kalloc+0x50>
    release(&kmem.lock);
80102cd6:	83 ec 0c             	sub    $0xc,%esp
80102cd9:	68 80 36 11 80       	push   $0x80113680
80102cde:	e8 3a 33 00 00       	call   8010601d <release>
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
80102d4b:	a1 bc 36 11 80       	mov    0x801136bc,%eax
80102d50:	83 c8 40             	or     $0x40,%eax
80102d53:	a3 bc 36 11 80       	mov    %eax,0x801136bc
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
80102d6e:	a1 bc 36 11 80       	mov    0x801136bc,%eax
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
80102d9d:	a1 bc 36 11 80       	mov    0x801136bc,%eax
80102da2:	21 d0                	and    %edx,%eax
80102da4:	a3 bc 36 11 80       	mov    %eax,0x801136bc
    return 0;
80102da9:	b8 00 00 00 00       	mov    $0x0,%eax
80102dae:	e9 a2 00 00 00       	jmp    80102e55 <kbdgetc+0x14d>
  } else if(shift & E0ESC){
80102db3:	a1 bc 36 11 80       	mov    0x801136bc,%eax
80102db8:	83 e0 40             	and    $0x40,%eax
80102dbb:	85 c0                	test   %eax,%eax
80102dbd:	74 14                	je     80102dd3 <kbdgetc+0xcb>
    // Last character was an E0 escape; or with 0x80
    data |= 0x80;
80102dbf:	81 4d fc 80 00 00 00 	orl    $0x80,-0x4(%ebp)
    shift &= ~E0ESC;
80102dc6:	a1 bc 36 11 80       	mov    0x801136bc,%eax
80102dcb:	83 e0 bf             	and    $0xffffffbf,%eax
80102dce:	a3 bc 36 11 80       	mov    %eax,0x801136bc
  }

  shift |= shiftcode[data];
80102dd3:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102dd6:	05 20 a0 10 80       	add    $0x8010a020,%eax
80102ddb:	0f b6 00             	movzbl (%eax),%eax
80102dde:	0f b6 d0             	movzbl %al,%edx
80102de1:	a1 bc 36 11 80       	mov    0x801136bc,%eax
80102de6:	09 d0                	or     %edx,%eax
80102de8:	a3 bc 36 11 80       	mov    %eax,0x801136bc
  shift ^= togglecode[data];
80102ded:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102df0:	05 20 a1 10 80       	add    $0x8010a120,%eax
80102df5:	0f b6 00             	movzbl (%eax),%eax
80102df8:	0f b6 d0             	movzbl %al,%edx
80102dfb:	a1 bc 36 11 80       	mov    0x801136bc,%eax
80102e00:	31 d0                	xor    %edx,%eax
80102e02:	a3 bc 36 11 80       	mov    %eax,0x801136bc
  c = charcode[shift & (CTL | SHIFT)][data];
80102e07:	a1 bc 36 11 80       	mov    0x801136bc,%eax
80102e0c:	83 e0 03             	and    $0x3,%eax
80102e0f:	8b 14 85 20 a5 10 80 	mov    -0x7fef5ae0(,%eax,4),%edx
80102e16:	8b 45 fc             	mov    -0x4(%ebp),%eax
80102e19:	01 d0                	add    %edx,%eax
80102e1b:	0f b6 00             	movzbl (%eax),%eax
80102e1e:	0f b6 c0             	movzbl %al,%eax
80102e21:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(shift & CAPSLOCK){
80102e24:	a1 bc 36 11 80       	mov    0x801136bc,%eax
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
80102eb1:	8b 15 c0 36 11 80    	mov    0x801136c0,%edx
80102eb7:	8b 45 08             	mov    0x8(%ebp),%eax
80102eba:	c1 e0 02             	shl    $0x2,%eax
80102ebd:	01 c2                	add    %eax,%edx
80102ebf:	8b 45 0c             	mov    0xc(%ebp),%eax
80102ec2:	89 02                	mov    %eax,(%edx)
  lapic[ID];  // wait for write to finish, by reading
80102ec4:	a1 c0 36 11 80       	mov    0x801136c0,%eax
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
80102ed4:	a1 c0 36 11 80       	mov    0x801136c0,%eax
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
80102f47:	a1 c0 36 11 80       	mov    0x801136c0,%eax
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
80102fca:	a1 c0 36 11 80       	mov    0x801136c0,%eax
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
80102ff3:	a1 c0 36 11 80       	mov    0x801136c0,%eax
80102ff8:	85 c0                	test   %eax,%eax
80102ffa:	75 07                	jne    80103003 <lapicid+0x13>
    return 0;
80102ffc:	b8 00 00 00 00       	mov    $0x0,%eax
80103001:	eb 0d                	jmp    80103010 <lapicid+0x20>
  return lapic[ID] >> 24;
80103003:	a1 c0 36 11 80       	mov    0x801136c0,%eax
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
80103015:	a1 c0 36 11 80       	mov    0x801136c0,%eax
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
80103208:	e8 8f 30 00 00       	call   8010629c <memcmp>
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
8010331c:	68 d1 96 10 80       	push   $0x801096d1
80103321:	68 e0 36 11 80       	push   $0x801136e0
80103326:	e8 62 2c 00 00       	call   80105f8d <initlock>
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
80103343:	a3 14 37 11 80       	mov    %eax,0x80113714
  log.size = sb.nlog;
80103348:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010334b:	a3 18 37 11 80       	mov    %eax,0x80113718
  log.dev = dev;
80103350:	8b 45 08             	mov    0x8(%ebp),%eax
80103353:	a3 24 37 11 80       	mov    %eax,0x80113724
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
80103372:	8b 15 14 37 11 80    	mov    0x80113714,%edx
80103378:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010337b:	01 d0                	add    %edx,%eax
8010337d:	83 c0 01             	add    $0x1,%eax
80103380:	89 c2                	mov    %eax,%edx
80103382:	a1 24 37 11 80       	mov    0x80113724,%eax
80103387:	83 ec 08             	sub    $0x8,%esp
8010338a:	52                   	push   %edx
8010338b:	50                   	push   %eax
8010338c:	e8 3e ce ff ff       	call   801001cf <bread>
80103391:	83 c4 10             	add    $0x10,%esp
80103394:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
80103397:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010339a:	83 c0 10             	add    $0x10,%eax
8010339d:	8b 04 85 ec 36 11 80 	mov    -0x7feec914(,%eax,4),%eax
801033a4:	89 c2                	mov    %eax,%edx
801033a6:	a1 24 37 11 80       	mov    0x80113724,%eax
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
801033d1:	e8 1e 2f 00 00       	call   801062f4 <memmove>
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
80103407:	a1 28 37 11 80       	mov    0x80113728,%eax
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
8010341f:	a1 14 37 11 80       	mov    0x80113714,%eax
80103424:	89 c2                	mov    %eax,%edx
80103426:	a1 24 37 11 80       	mov    0x80113724,%eax
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
80103449:	a3 28 37 11 80       	mov    %eax,0x80113728
  for (i = 0; i < log.lh.n; i++) {
8010344e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80103455:	eb 1b                	jmp    80103472 <read_head+0x59>
    log.lh.block[i] = lh->block[i];
80103457:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010345a:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010345d:	8b 44 90 04          	mov    0x4(%eax,%edx,4),%eax
80103461:	8b 55 f4             	mov    -0xc(%ebp),%edx
80103464:	83 c2 10             	add    $0x10,%edx
80103467:	89 04 95 ec 36 11 80 	mov    %eax,-0x7feec914(,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
8010346e:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80103472:	a1 28 37 11 80       	mov    0x80113728,%eax
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
80103493:	a1 14 37 11 80       	mov    0x80113714,%eax
80103498:	89 c2                	mov    %eax,%edx
8010349a:	a1 24 37 11 80       	mov    0x80113724,%eax
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
801034b8:	8b 15 28 37 11 80    	mov    0x80113728,%edx
801034be:	8b 45 ec             	mov    -0x14(%ebp),%eax
801034c1:	89 10                	mov    %edx,(%eax)
  for (i = 0; i < log.lh.n; i++) {
801034c3:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801034ca:	eb 1b                	jmp    801034e7 <write_head+0x5a>
    hb->block[i] = log.lh.block[i];
801034cc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801034cf:	83 c0 10             	add    $0x10,%eax
801034d2:	8b 0c 85 ec 36 11 80 	mov    -0x7feec914(,%eax,4),%ecx
801034d9:	8b 45 ec             	mov    -0x14(%ebp),%eax
801034dc:	8b 55 f4             	mov    -0xc(%ebp),%edx
801034df:	89 4c 90 04          	mov    %ecx,0x4(%eax,%edx,4)
  for (i = 0; i < log.lh.n; i++) {
801034e3:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801034e7:	a1 28 37 11 80       	mov    0x80113728,%eax
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
80103520:	c7 05 28 37 11 80 00 	movl   $0x0,0x80113728
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
8010353b:	68 e0 36 11 80       	push   $0x801136e0
80103540:	e8 6a 2a 00 00       	call   80105faf <acquire>
80103545:	83 c4 10             	add    $0x10,%esp
  while(1){
    if(log.committing){
80103548:	a1 20 37 11 80       	mov    0x80113720,%eax
8010354d:	85 c0                	test   %eax,%eax
8010354f:	74 17                	je     80103568 <begin_op+0x36>
      sleep(&log, &log.lock);
80103551:	83 ec 08             	sub    $0x8,%esp
80103554:	68 e0 36 11 80       	push   $0x801136e0
80103559:	68 e0 36 11 80       	push   $0x801136e0
8010355e:	e8 c0 1d 00 00       	call   80105323 <sleep>
80103563:	83 c4 10             	add    $0x10,%esp
80103566:	eb e0                	jmp    80103548 <begin_op+0x16>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
80103568:	8b 0d 28 37 11 80    	mov    0x80113728,%ecx
8010356e:	a1 1c 37 11 80       	mov    0x8011371c,%eax
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
80103589:	68 e0 36 11 80       	push   $0x801136e0
8010358e:	68 e0 36 11 80       	push   $0x801136e0
80103593:	e8 8b 1d 00 00       	call   80105323 <sleep>
80103598:	83 c4 10             	add    $0x10,%esp
8010359b:	eb ab                	jmp    80103548 <begin_op+0x16>
    } else {
      log.outstanding += 1;
8010359d:	a1 1c 37 11 80       	mov    0x8011371c,%eax
801035a2:	83 c0 01             	add    $0x1,%eax
801035a5:	a3 1c 37 11 80       	mov    %eax,0x8011371c
      release(&log.lock);
801035aa:	83 ec 0c             	sub    $0xc,%esp
801035ad:	68 e0 36 11 80       	push   $0x801136e0
801035b2:	e8 66 2a 00 00       	call   8010601d <release>
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
801035ce:	68 e0 36 11 80       	push   $0x801136e0
801035d3:	e8 d7 29 00 00       	call   80105faf <acquire>
801035d8:	83 c4 10             	add    $0x10,%esp
  log.outstanding -= 1;
801035db:	a1 1c 37 11 80       	mov    0x8011371c,%eax
801035e0:	83 e8 01             	sub    $0x1,%eax
801035e3:	a3 1c 37 11 80       	mov    %eax,0x8011371c
  if(log.committing)
801035e8:	a1 20 37 11 80       	mov    0x80113720,%eax
801035ed:	85 c0                	test   %eax,%eax
801035ef:	74 0d                	je     801035fe <end_op+0x40>
    panic("log.committing");
801035f1:	83 ec 0c             	sub    $0xc,%esp
801035f4:	68 d5 96 10 80       	push   $0x801096d5
801035f9:	e8 b7 cf ff ff       	call   801005b5 <panic>
  if(log.outstanding == 0){
801035fe:	a1 1c 37 11 80       	mov    0x8011371c,%eax
80103603:	85 c0                	test   %eax,%eax
80103605:	75 13                	jne    8010361a <end_op+0x5c>
    do_commit = 1;
80103607:	c7 45 f4 01 00 00 00 	movl   $0x1,-0xc(%ebp)
    log.committing = 1;
8010360e:	c7 05 20 37 11 80 01 	movl   $0x1,0x80113720
80103615:	00 00 00 
80103618:	eb 10                	jmp    8010362a <end_op+0x6c>
  } else {
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
8010361a:	83 ec 0c             	sub    $0xc,%esp
8010361d:	68 e0 36 11 80       	push   $0x801136e0
80103622:	e8 7a 1e 00 00       	call   801054a1 <wakeup>
80103627:	83 c4 10             	add    $0x10,%esp
  }
  release(&log.lock);
8010362a:	83 ec 0c             	sub    $0xc,%esp
8010362d:	68 e0 36 11 80       	push   $0x801136e0
80103632:	e8 e6 29 00 00       	call   8010601d <release>
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
80103648:	68 e0 36 11 80       	push   $0x801136e0
8010364d:	e8 5d 29 00 00       	call   80105faf <acquire>
80103652:	83 c4 10             	add    $0x10,%esp
    log.committing = 0;
80103655:	c7 05 20 37 11 80 00 	movl   $0x0,0x80113720
8010365c:	00 00 00 
    wakeup(&log);
8010365f:	83 ec 0c             	sub    $0xc,%esp
80103662:	68 e0 36 11 80       	push   $0x801136e0
80103667:	e8 35 1e 00 00       	call   801054a1 <wakeup>
8010366c:	83 c4 10             	add    $0x10,%esp
    release(&log.lock);
8010366f:	83 ec 0c             	sub    $0xc,%esp
80103672:	68 e0 36 11 80       	push   $0x801136e0
80103677:	e8 a1 29 00 00       	call   8010601d <release>
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
80103694:	8b 15 14 37 11 80    	mov    0x80113714,%edx
8010369a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010369d:	01 d0                	add    %edx,%eax
8010369f:	83 c0 01             	add    $0x1,%eax
801036a2:	89 c2                	mov    %eax,%edx
801036a4:	a1 24 37 11 80       	mov    0x80113724,%eax
801036a9:	83 ec 08             	sub    $0x8,%esp
801036ac:	52                   	push   %edx
801036ad:	50                   	push   %eax
801036ae:	e8 1c cb ff ff       	call   801001cf <bread>
801036b3:	83 c4 10             	add    $0x10,%esp
801036b6:	89 45 f0             	mov    %eax,-0x10(%ebp)
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
801036b9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801036bc:	83 c0 10             	add    $0x10,%eax
801036bf:	8b 04 85 ec 36 11 80 	mov    -0x7feec914(,%eax,4),%eax
801036c6:	89 c2                	mov    %eax,%edx
801036c8:	a1 24 37 11 80       	mov    0x80113724,%eax
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
801036f3:	e8 fc 2b 00 00       	call   801062f4 <memmove>
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
80103729:	a1 28 37 11 80       	mov    0x80113728,%eax
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
80103741:	a1 28 37 11 80       	mov    0x80113728,%eax
80103746:	85 c0                	test   %eax,%eax
80103748:	7e 1e                	jle    80103768 <commit+0x2d>
    write_log();     // Write modified blocks from cache to log
8010374a:	e8 33 ff ff ff       	call   80103682 <write_log>
    write_head();    // Write header to disk -- the real commit
8010374f:	e8 39 fd ff ff       	call   8010348d <write_head>
    install_trans(); // Now install writes to home locations
80103754:	e8 07 fc ff ff       	call   80103360 <install_trans>
    log.lh.n = 0;
80103759:	c7 05 28 37 11 80 00 	movl   $0x0,0x80113728
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
80103771:	a1 28 37 11 80       	mov    0x80113728,%eax
80103776:	83 f8 1d             	cmp    $0x1d,%eax
80103779:	7f 12                	jg     8010378d <log_write+0x22>
8010377b:	a1 28 37 11 80       	mov    0x80113728,%eax
80103780:	8b 15 18 37 11 80    	mov    0x80113718,%edx
80103786:	83 ea 01             	sub    $0x1,%edx
80103789:	39 d0                	cmp    %edx,%eax
8010378b:	7c 0d                	jl     8010379a <log_write+0x2f>
    panic("too big a transaction");
8010378d:	83 ec 0c             	sub    $0xc,%esp
80103790:	68 e4 96 10 80       	push   $0x801096e4
80103795:	e8 1b ce ff ff       	call   801005b5 <panic>
  if (log.outstanding < 1)
8010379a:	a1 1c 37 11 80       	mov    0x8011371c,%eax
8010379f:	85 c0                	test   %eax,%eax
801037a1:	7f 0d                	jg     801037b0 <log_write+0x45>
    panic("log_write outside of trans");
801037a3:	83 ec 0c             	sub    $0xc,%esp
801037a6:	68 fa 96 10 80       	push   $0x801096fa
801037ab:	e8 05 ce ff ff       	call   801005b5 <panic>

  acquire(&log.lock);
801037b0:	83 ec 0c             	sub    $0xc,%esp
801037b3:	68 e0 36 11 80       	push   $0x801136e0
801037b8:	e8 f2 27 00 00       	call   80105faf <acquire>
801037bd:	83 c4 10             	add    $0x10,%esp
  for (i = 0; i < log.lh.n; i++) {
801037c0:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801037c7:	eb 1d                	jmp    801037e6 <log_write+0x7b>
    if (log.lh.block[i] == b->blockno)   // log absorbtion
801037c9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801037cc:	83 c0 10             	add    $0x10,%eax
801037cf:	8b 04 85 ec 36 11 80 	mov    -0x7feec914(,%eax,4),%eax
801037d6:	89 c2                	mov    %eax,%edx
801037d8:	8b 45 08             	mov    0x8(%ebp),%eax
801037db:	8b 40 08             	mov    0x8(%eax),%eax
801037de:	39 c2                	cmp    %eax,%edx
801037e0:	74 10                	je     801037f2 <log_write+0x87>
  for (i = 0; i < log.lh.n; i++) {
801037e2:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801037e6:	a1 28 37 11 80       	mov    0x80113728,%eax
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
80103801:	89 14 85 ec 36 11 80 	mov    %edx,-0x7feec914(,%eax,4)
  if (i == log.lh.n)
80103808:	a1 28 37 11 80       	mov    0x80113728,%eax
8010380d:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80103810:	75 0d                	jne    8010381f <log_write+0xb4>
    log.lh.n++;
80103812:	a1 28 37 11 80       	mov    0x80113728,%eax
80103817:	83 c0 01             	add    $0x1,%eax
8010381a:	a3 28 37 11 80       	mov    %eax,0x80113728
  b->flags |= B_DIRTY; // prevent eviction
8010381f:	8b 45 08             	mov    0x8(%ebp),%eax
80103822:	8b 00                	mov    (%eax),%eax
80103824:	83 c8 04             	or     $0x4,%eax
80103827:	89 c2                	mov    %eax,%edx
80103829:	8b 45 08             	mov    0x8(%ebp),%eax
8010382c:	89 10                	mov    %edx,(%eax)
  release(&log.lock);
8010382e:	83 ec 0c             	sub    $0xc,%esp
80103831:	68 e0 36 11 80       	push   $0x801136e0
80103836:	e8 e2 27 00 00       	call   8010601d <release>
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
80103874:	68 40 83 11 80       	push   $0x80118340
80103879:	e8 e3 f2 ff ff       	call   80102b61 <kinit1>
8010387e:	83 c4 10             	add    $0x10,%esp
  kvmalloc();      // kernel page table
80103881:	e8 1a 54 00 00       	call   80108ca0 <kvmalloc>
  mpinit();        // detect other processors
80103886:	e8 bd 03 00 00       	call   80103c48 <mpinit>
  lapicinit();     // interrupt controller
8010388b:	e8 41 f6 ff ff       	call   80102ed1 <lapicinit>
  seginit();       // segment descriptors
80103890:	e8 f6 4e 00 00       	call   8010878b <seginit>
  picinit();       // disable pic
80103895:	e8 15 05 00 00       	call   80103daf <picinit>
  ioapicinit();    // another interrupt controller
8010389a:	e8 dd f1 ff ff       	call   80102a7c <ioapicinit>
  consoleinit();   // console hardware
8010389f:	e8 d4 d2 ff ff       	call   80100b78 <consoleinit>
  uartinit();      // serial port
801038a4:	e8 7b 42 00 00       	call   80107b24 <uartinit>
  pinit();         // process table
801038a9:	e8 99 09 00 00       	call   80104247 <pinit>
  tvinit();        // trap vectors
801038ae:	e8 cd 3d 00 00       	call   80107680 <tvinit>
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
801038ec:	e8 c7 53 00 00       	call   80108cb8 <switchkvm>
  seginit();
801038f1:	e8 95 4e 00 00       	call   8010878b <seginit>
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
80103918:	68 15 97 10 80       	push   $0x80109715
8010391d:	e8 de ca ff ff       	call   80100400 <cprintf>
80103922:	83 c4 10             	add    $0x10,%esp
  idtinit();       // load idt register
80103925:	e8 cc 3e 00 00       	call   801077f6 <idtinit>
  xchg(&(mycpu()->started), 1); // tell startothers() we're up
8010392a:	e8 6f 09 00 00       	call   8010429e <mycpu>
8010392f:	05 a0 00 00 00       	add    $0xa0,%eax
80103934:	83 ec 08             	sub    $0x8,%esp
80103937:	6a 01                	push   $0x1
80103939:	50                   	push   %eax
8010393a:	e8 02 ff ff ff       	call   80103841 <xchg>
8010393f:	83 c4 10             	add    $0x10,%esp
  scheduler();     // start running processes
80103942:	e8 a3 14 00 00       	call   80104dea <scheduler>

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
8010395d:	68 ec c4 10 80       	push   $0x8010c4ec
80103962:	ff 75 f0             	push   -0x10(%ebp)
80103965:	e8 8a 29 00 00       	call   801062f4 <memmove>
8010396a:	83 c4 10             	add    $0x10,%esp

  for(c = cpus; c < cpus+ncpu; c++){
8010396d:	c7 45 f4 c0 37 11 80 	movl   $0x801137c0,-0xc(%ebp)
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
801039ef:	a1 40 3d 11 80       	mov    0x80113d40,%eax
801039f4:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
801039fa:	05 c0 37 11 80       	add    $0x801137c0,%eax
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
80103aab:	68 2c 97 10 80       	push   $0x8010972c
80103ab0:	ff 75 f4             	push   -0xc(%ebp)
80103ab3:	e8 e4 27 00 00       	call   8010629c <memcmp>
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
80103bdf:	68 31 97 10 80       	push   $0x80109731
80103be4:	ff 75 f0             	push   -0x10(%ebp)
80103be7:	e8 b0 26 00 00       	call   8010629c <memcmp>
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
80103c69:	68 36 97 10 80       	push   $0x80109736
80103c6e:	e8 42 c9 ff ff       	call   801005b5 <panic>
  ismp = 1;
80103c73:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
  lapic = (uint*)conf->lapicaddr;
80103c7a:	8b 45 ec             	mov    -0x14(%ebp),%eax
80103c7d:	8b 40 24             	mov    0x24(%eax),%eax
80103c80:	a3 c0 36 11 80       	mov    %eax,0x801136c0
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
80103cd3:	a1 40 3d 11 80       	mov    0x80113d40,%eax
80103cd8:	83 f8 07             	cmp    $0x7,%eax
80103cdb:	7f 28                	jg     80103d05 <mpinit+0xbd>
        cpus[ncpu].apicid = proc->apicid;  // apicid may differ from ncpu
80103cdd:	8b 15 40 3d 11 80    	mov    0x80113d40,%edx
80103ce3:	8b 45 e0             	mov    -0x20(%ebp),%eax
80103ce6:	0f b6 40 01          	movzbl 0x1(%eax),%eax
80103cea:	69 d2 b0 00 00 00    	imul   $0xb0,%edx,%edx
80103cf0:	81 c2 c0 37 11 80    	add    $0x801137c0,%edx
80103cf6:	88 02                	mov    %al,(%edx)
        ncpu++;
80103cf8:	a1 40 3d 11 80       	mov    0x80113d40,%eax
80103cfd:	83 c0 01             	add    $0x1,%eax
80103d00:	a3 40 3d 11 80       	mov    %eax,0x80113d40
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
80103d18:	a2 44 3d 11 80       	mov    %al,0x80113d44
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
80103d46:	68 50 97 10 80       	push   $0x80109750
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
80103e70:	68 6f 97 10 80       	push   $0x8010976f
80103e75:	50                   	push   %eax
80103e76:	e8 12 21 00 00       	call   80105f8d <initlock>
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
80103f35:	e8 75 20 00 00       	call   80105faf <acquire>
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
80103f5c:	e8 40 15 00 00       	call   801054a1 <wakeup>
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
80103f7f:	e8 1d 15 00 00       	call   801054a1 <wakeup>
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
80103fa8:	e8 70 20 00 00       	call   8010601d <release>
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
80103fc7:	e8 51 20 00 00       	call   8010601d <release>
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
80103fe1:	e8 c9 1f 00 00       	call   80105faf <acquire>
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
80104015:	e8 03 20 00 00       	call   8010601d <release>
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
80104033:	e8 69 14 00 00       	call   801054a1 <wakeup>
80104038:	83 c4 10             	add    $0x10,%esp
      sleep(&p->nwrite, &p->lock);  //DOC: pipewrite-sleep
8010403b:	8b 45 08             	mov    0x8(%ebp),%eax
8010403e:	8b 55 08             	mov    0x8(%ebp),%edx
80104041:	81 c2 38 02 00 00    	add    $0x238,%edx
80104047:	83 ec 08             	sub    $0x8,%esp
8010404a:	50                   	push   %eax
8010404b:	52                   	push   %edx
8010404c:	e8 d2 12 00 00       	call   80105323 <sleep>
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
801040b6:	e8 e6 13 00 00       	call   801054a1 <wakeup>
801040bb:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
801040be:	8b 45 08             	mov    0x8(%ebp),%eax
801040c1:	83 ec 0c             	sub    $0xc,%esp
801040c4:	50                   	push   %eax
801040c5:	e8 53 1f 00 00       	call   8010601d <release>
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
801040e2:	e8 c8 1e 00 00       	call   80105faf <acquire>
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
801040ff:	e8 19 1f 00 00       	call   8010601d <release>
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
80104122:	e8 fc 11 00 00       	call   80105323 <sleep>
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
801041b5:	e8 e7 12 00 00       	call   801054a1 <wakeup>
801041ba:	83 c4 10             	add    $0x10,%esp
  release(&p->lock);
801041bd:	8b 45 08             	mov    0x8(%ebp),%eax
801041c0:	83 ec 0c             	sub    $0xc,%esp
801041c3:	50                   	push   %eax
801041c4:	e8 54 1e 00 00       	call   8010601d <release>
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
801041ee:	a1 34 73 11 80       	mov    0x80117334,%eax
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
80104250:	68 74 97 10 80       	push   $0x80109774
80104255:	68 60 3d 11 80       	push   $0x80113d60
8010425a:	e8 2e 1d 00 00       	call   80105f8d <initlock>
8010425f:	83 c4 10             	add    $0x10,%esp

  rr_q.pi = -1;
80104262:	c7 05 a0 68 11 80 ff 	movl   $0xffffffff,0x801168a0
80104269:	ff ff ff 
  lcfs_q.pi = -1;
8010426c:	c7 05 c0 69 11 80 ff 	movl   $0xffffffff,0x801169c0
80104273:	ff ff ff 
  bjf_q.pi = -1;
80104276:	c7 05 e0 6a 11 80 ff 	movl   $0xffffffff,0x80116ae0
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
8010428e:	2d c0 37 11 80       	sub    $0x801137c0,%eax
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
801042b5:	68 7c 97 10 80       	push   $0x8010977c
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
801042d9:	05 c0 37 11 80       	add    $0x801137c0,%eax
801042de:	0f b6 00             	movzbl (%eax),%eax
801042e1:	0f b6 c0             	movzbl %al,%eax
801042e4:	39 45 f0             	cmp    %eax,-0x10(%ebp)
801042e7:	75 10                	jne    801042f9 <mycpu+0x5b>
      return &cpus[i];
801042e9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801042ec:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
801042f2:	05 c0 37 11 80       	add    $0x801137c0,%eax
801042f7:	eb 1b                	jmp    80104314 <mycpu+0x76>
  for (i = 0; i < ncpu; ++i)
801042f9:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801042fd:	a1 40 3d 11 80       	mov    0x80113d40,%eax
80104302:	39 45 f4             	cmp    %eax,-0xc(%ebp)
80104305:	7c c9                	jl     801042d0 <mycpu+0x32>
  }
  panic("unknown apicid\n");
80104307:	83 ec 0c             	sub    $0xc,%esp
8010430a:	68 a2 97 10 80       	push   $0x801097a2
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
8010431c:	e8 09 1e 00 00       	call   8010612a <pushcli>
  c = mycpu();
80104321:	e8 78 ff ff ff       	call   8010429e <mycpu>
80104326:	89 45 f4             	mov    %eax,-0xc(%ebp)
  p = c->proc;
80104329:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010432c:	8b 80 ac 00 00 00    	mov    0xac(%eax),%eax
80104332:	89 45 f0             	mov    %eax,-0x10(%ebp)
  popcli();
80104335:	e8 3d 1e 00 00       	call   80106177 <popcli>
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
80104348:	68 60 3d 11 80       	push   $0x80113d60
8010434d:	e8 5d 1c 00 00       	call   80105faf <acquire>
80104352:	83 c4 10             	add    $0x10,%esp

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104355:	c7 45 f4 94 3d 11 80 	movl   $0x80113d94,-0xc(%ebp)
8010435c:	eb 11                	jmp    8010436f <allocproc+0x30>
    if (p->state == UNUSED)
8010435e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104361:	8b 40 0c             	mov    0xc(%eax),%eax
80104364:	85 c0                	test   %eax,%eax
80104366:	74 2a                	je     80104392 <allocproc+0x53>
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104368:	81 45 f4 a8 00 00 00 	addl   $0xa8,-0xc(%ebp)
8010436f:	81 7d f4 94 67 11 80 	cmpl   $0x80116794,-0xc(%ebp)
80104376:	72 e6                	jb     8010435e <allocproc+0x1f>
      goto found;

  release(&ptable.lock);
80104378:	83 ec 0c             	sub    $0xc,%esp
8010437b:	68 60 3d 11 80       	push   $0x80113d60
80104380:	e8 98 1c 00 00       	call   8010601d <release>
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
801043b4:	68 60 3d 11 80       	push   $0x80113d60
801043b9:	e8 5f 1c 00 00       	call   8010601d <release>
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
80104406:	ba 3a 76 10 80       	mov    $0x8010763a,%edx
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
8010442b:	e8 05 1e 00 00       	call   80106235 <memset>
80104430:	83 c4 10             	add    $0x10,%esp
  p->context->eip = (uint)forkret;
80104433:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104436:	8b 40 1c             	mov    0x1c(%eax),%eax
80104439:	ba dd 52 10 80       	mov    $0x801052dd,%edx
8010443e:	89 50 10             	mov    %edx,0x10(%eax)

  p->arrivetime = ticks;
80104441:	8b 15 34 73 11 80    	mov    0x80117334,%edx
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
8010446c:	68 b2 97 10 80       	push   $0x801097b2
80104471:	e8 3f c1 ff ff       	call   801005b5 <panic>
  }

  initproc = p;
80104476:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104479:	a3 e8 6a 11 80       	mov    %eax,0x80116ae8
  if ((p->pgdir = setupkvm()) == 0)
8010447e:	e8 84 47 00 00       	call   80108c07 <setupkvm>
80104483:	8b 55 f4             	mov    -0xc(%ebp),%edx
80104486:	89 42 04             	mov    %eax,0x4(%edx)
80104489:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010448c:	8b 40 04             	mov    0x4(%eax),%eax
8010448f:	85 c0                	test   %eax,%eax
80104491:	75 0d                	jne    801044a0 <userinit+0x4b>
    panic("userinit: out of memory?");
80104493:	83 ec 0c             	sub    $0xc,%esp
80104496:	68 cd 97 10 80       	push   $0x801097cd
8010449b:	e8 15 c1 ff ff       	call   801005b5 <panic>
  inituvm(p->pgdir, _binary_initcode_start, (int)_binary_initcode_size);
801044a0:	ba 2c 00 00 00       	mov    $0x2c,%edx
801044a5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801044a8:	8b 40 04             	mov    0x4(%eax),%eax
801044ab:	83 ec 04             	sub    $0x4,%esp
801044ae:	52                   	push   %edx
801044af:	68 c0 c4 10 80       	push   $0x8010c4c0
801044b4:	50                   	push   %eax
801044b5:	e8 b6 49 00 00       	call   80108e70 <inituvm>
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
801044d4:	e8 5c 1d 00 00       	call   80106235 <memset>
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
8010454e:	68 e6 97 10 80       	push   $0x801097e6
80104553:	50                   	push   %eax
80104554:	e8 df 1e 00 00       	call   80106438 <safestrcpy>
80104559:	83 c4 10             	add    $0x10,%esp
  p->cwd = namei("/");
8010455c:	83 ec 0c             	sub    $0xc,%esp
8010455f:	68 ef 97 10 80       	push   $0x801097ef
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
80104575:	68 60 3d 11 80       	push   $0x80113d60
8010457a:	e8 30 1a 00 00       	call   80105faf <acquire>
8010457f:	83 c4 10             	add    $0x10,%esp

  // Default scheduling queue
  p->q_type = LCFS;
80104582:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104585:	c7 40 7c 02 00 00 00 	movl   $0x2,0x7c(%eax)
  lcfs_q.pi++;
8010458c:	a1 c0 69 11 80       	mov    0x801169c0,%eax
80104591:	83 c0 01             	add    $0x1,%eax
80104594:	a3 c0 69 11 80       	mov    %eax,0x801169c0
  lcfs_q.proc[lcfs_q.pi] = p;
80104599:	a1 c0 69 11 80       	mov    0x801169c0,%eax
8010459e:	8b 55 f4             	mov    -0xc(%ebp),%edx
801045a1:	89 14 85 c0 68 11 80 	mov    %edx,-0x7fee9740(,%eax,4)

  p->state = RUNNABLE;
801045a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801045ab:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)

  release(&ptable.lock);
801045b2:	83 ec 0c             	sub    $0xc,%esp
801045b5:	68 60 3d 11 80       	push   $0x80113d60
801045ba:	e8 5e 1a 00 00       	call   8010601d <release>
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
801045f7:	e8 b1 49 00 00       	call   80108fad <allocuvm>
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
8010462b:	e8 82 4a 00 00       	call   801090b2 <deallocuvm>
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
80104651:	e8 7b 46 00 00       	call   80108cd1 <switchuvm>
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
80104699:	e8 b2 4b 00 00       	call   80109250 <copyuvm>
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
80104793:	e8 a0 1c 00 00       	call   80106438 <safestrcpy>
80104798:	83 c4 10             	add    $0x10,%esp

  pid = np->pid;
8010479b:	8b 45 dc             	mov    -0x24(%ebp),%eax
8010479e:	8b 40 10             	mov    0x10(%eax),%eax
801047a1:	89 45 d8             	mov    %eax,-0x28(%ebp)

  acquire(&ptable.lock);
801047a4:	83 ec 0c             	sub    $0xc,%esp
801047a7:	68 60 3d 11 80       	push   $0x80113d60
801047ac:	e8 fe 17 00 00       	call   80105faf <acquire>
801047b1:	83 c4 10             	add    $0x10,%esp

  // Default scheduling queue
  np->q_type = LCFS;
801047b4:	8b 45 dc             	mov    -0x24(%ebp),%eax
801047b7:	c7 40 7c 02 00 00 00 	movl   $0x2,0x7c(%eax)

  lcfs_q.pi++;
801047be:	a1 c0 69 11 80       	mov    0x801169c0,%eax
801047c3:	83 c0 01             	add    $0x1,%eax
801047c6:	a3 c0 69 11 80       	mov    %eax,0x801169c0
  lcfs_q.proc[lcfs_q.pi] = np;
801047cb:	a1 c0 69 11 80       	mov    0x801169c0,%eax
801047d0:	8b 55 dc             	mov    -0x24(%ebp),%edx
801047d3:	89 14 85 c0 68 11 80 	mov    %edx,-0x7fee9740(,%eax,4)
  np->arrivetime = ticks;
801047da:	8b 15 34 73 11 80    	mov    0x80117334,%edx
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
80104804:	68 00 73 11 80       	push   $0x80117300
80104809:	e8 a1 17 00 00       	call   80105faf <acquire>
8010480e:	83 c4 10             	add    $0x10,%esp
  np->priority = (ticks * ticks * 1021) % 100;
80104811:	8b 15 34 73 11 80    	mov    0x80117334,%edx
80104817:	a1 34 73 11 80       	mov    0x80117334,%eax
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
80104848:	68 00 73 11 80       	push   $0x80117300
8010484d:	e8 cb 17 00 00       	call   8010601d <release>
80104852:	83 c4 10             	add    $0x10,%esp

  np->priority_ratio = 0.25;
80104855:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104858:	d9 05 80 9a 10 80    	flds   0x80109a80
8010485e:	d9 98 84 00 00 00    	fstps  0x84(%eax)
  np->executed_cycle_ratio = 0.25;
80104864:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104867:	d9 05 80 9a 10 80    	flds   0x80109a80
8010486d:	d9 98 8c 00 00 00    	fstps  0x8c(%eax)
  np->arrivetime_ratio = 0.25;
80104873:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104876:	d9 05 80 9a 10 80    	flds   0x80109a80
8010487c:	d9 98 94 00 00 00    	fstps  0x94(%eax)
  np->size_ratio = 0.25;
80104882:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104885:	d9 05 80 9a 10 80    	flds   0x80109a80
8010488b:	d9 98 98 00 00 00    	fstps  0x98(%eax)

  np->state = RUNNABLE;
80104891:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104894:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)

  release(&ptable.lock);
8010489b:	83 ec 0c             	sub    $0xc,%esp
8010489e:	68 60 3d 11 80       	push   $0x80113d60
801048a3:	e8 75 17 00 00       	call   8010601d <release>
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
801048bf:	68 60 3d 11 80       	push   $0x80113d60
801048c4:	e8 21 18 00 00       	call   801060ea <holding>
801048c9:	83 c4 10             	add    $0x10,%esp
801048cc:	85 c0                	test   %eax,%eax
801048ce:	75 0d                	jne    801048dd <shiftOutQueue+0x27>
  {
    panic("scheduling queue lock not held");
801048d0:	83 ec 0c             	sub    $0xc,%esp
801048d3:	68 f4 97 10 80       	push   $0x801097f4
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
80104992:	a1 a0 68 11 80       	mov    0x801168a0,%eax
80104997:	85 c0                	test   %eax,%eax
80104999:	79 0d                	jns    801049a8 <cleanupCorresQueue+0x43>
    {
      panic("RR: nothing to clean");
8010499b:	83 ec 0c             	sub    $0xc,%esp
8010499e:	68 13 98 10 80       	push   $0x80109813
801049a3:	e8 0d bc ff ff       	call   801005b5 <panic>
    }
    shiftOutQueue(&rr_q, p);
801049a8:	83 ec 08             	sub    $0x8,%esp
801049ab:	ff 75 08             	push   0x8(%ebp)
801049ae:	68 a0 67 11 80       	push   $0x801167a0
801049b3:	e8 fe fe ff ff       	call   801048b6 <shiftOutQueue>
801049b8:	83 c4 10             	add    $0x10,%esp
    rr_q.pi--;
801049bb:	a1 a0 68 11 80       	mov    0x801168a0,%eax
801049c0:	83 e8 01             	sub    $0x1,%eax
801049c3:	a3 a0 68 11 80       	mov    %eax,0x801168a0
    break;
801049c8:	eb 7d                	jmp    80104a47 <cleanupCorresQueue+0xe2>
  case LCFS:
    if (lcfs_q.pi <= -1)
801049ca:	a1 c0 69 11 80       	mov    0x801169c0,%eax
801049cf:	85 c0                	test   %eax,%eax
801049d1:	79 0d                	jns    801049e0 <cleanupCorresQueue+0x7b>
    {
      panic("LCFS: nothing to clean");
801049d3:	83 ec 0c             	sub    $0xc,%esp
801049d6:	68 28 98 10 80       	push   $0x80109828
801049db:	e8 d5 bb ff ff       	call   801005b5 <panic>
    }
    shiftOutQueue(&lcfs_q, p);
801049e0:	83 ec 08             	sub    $0x8,%esp
801049e3:	ff 75 08             	push   0x8(%ebp)
801049e6:	68 c0 68 11 80       	push   $0x801168c0
801049eb:	e8 c6 fe ff ff       	call   801048b6 <shiftOutQueue>
801049f0:	83 c4 10             	add    $0x10,%esp
    lcfs_q.pi--;
801049f3:	a1 c0 69 11 80       	mov    0x801169c0,%eax
801049f8:	83 e8 01             	sub    $0x1,%eax
801049fb:	a3 c0 69 11 80       	mov    %eax,0x801169c0
    break;
80104a00:	eb 45                	jmp    80104a47 <cleanupCorresQueue+0xe2>
  case BJF:
    if (bjf_q.pi <= -1)
80104a02:	a1 e0 6a 11 80       	mov    0x80116ae0,%eax
80104a07:	85 c0                	test   %eax,%eax
80104a09:	79 0d                	jns    80104a18 <cleanupCorresQueue+0xb3>
    {
      panic("BJF: nothing to clean");
80104a0b:	83 ec 0c             	sub    $0xc,%esp
80104a0e:	68 3f 98 10 80       	push   $0x8010983f
80104a13:	e8 9d bb ff ff       	call   801005b5 <panic>
    }
    shiftOutQueue(&bjf_q, p);
80104a18:	83 ec 08             	sub    $0x8,%esp
80104a1b:	ff 75 08             	push   0x8(%ebp)
80104a1e:	68 e0 69 11 80       	push   $0x801169e0
80104a23:	e8 8e fe ff ff       	call   801048b6 <shiftOutQueue>
80104a28:	83 c4 10             	add    $0x10,%esp
    bjf_q.pi--;
80104a2b:	a1 e0 6a 11 80       	mov    0x80116ae0,%eax
80104a30:	83 e8 01             	sub    $0x1,%eax
80104a33:	a3 e0 6a 11 80       	mov    %eax,0x80116ae0
    break;
80104a38:	eb 0d                	jmp    80104a47 <cleanupCorresQueue+0xe2>
  default:
    panic("defaut scheduling cleanup");
80104a3a:	83 ec 0c             	sub    $0xc,%esp
80104a3d:	68 55 98 10 80       	push   $0x80109855
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
80104a58:	a1 e8 6a 11 80       	mov    0x80116ae8,%eax
80104a5d:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80104a60:	75 0d                	jne    80104a6f <exit+0x25>
    panic("init exiting");
80104a62:	83 ec 0c             	sub    $0xc,%esp
80104a65:	68 6f 98 10 80       	push   $0x8010986f
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
80104ae6:	68 60 3d 11 80       	push   $0x80113d60
80104aeb:	e8 bf 14 00 00       	call   80105faf <acquire>
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
80104b0b:	e8 c8 08 00 00       	call   801053d8 <wakeup1>
80104b10:	83 c4 10             	add    $0x10,%esp

  // Pass abandoned children to init.
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104b13:	c7 45 f4 94 3d 11 80 	movl   $0x80113d94,-0xc(%ebp)
80104b1a:	eb 3a                	jmp    80104b56 <exit+0x10c>
  {
    if (p->parent == curproc)
80104b1c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b1f:	8b 40 14             	mov    0x14(%eax),%eax
80104b22:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80104b25:	75 28                	jne    80104b4f <exit+0x105>
    {
      p->parent = initproc;
80104b27:	8b 15 e8 6a 11 80    	mov    0x80116ae8,%edx
80104b2d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b30:	89 50 14             	mov    %edx,0x14(%eax)
      if (p->state == ZOMBIE)
80104b33:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104b36:	8b 40 0c             	mov    0xc(%eax),%eax
80104b39:	83 f8 05             	cmp    $0x5,%eax
80104b3c:	75 11                	jne    80104b4f <exit+0x105>
        wakeup1(initproc);
80104b3e:	a1 e8 6a 11 80       	mov    0x80116ae8,%eax
80104b43:	83 ec 0c             	sub    $0xc,%esp
80104b46:	50                   	push   %eax
80104b47:	e8 8c 08 00 00       	call   801053d8 <wakeup1>
80104b4c:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104b4f:	81 45 f4 a8 00 00 00 	addl   $0xa8,-0xc(%ebp)
80104b56:	81 7d f4 94 67 11 80 	cmpl   $0x80116794,-0xc(%ebp)
80104b5d:	72 bd                	jb     80104b1c <exit+0xd2>
    }
  }

  // Jump into the scheduler, never to return.
  curproc->state = ZOMBIE;
80104b5f:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104b62:	c7 40 0c 05 00 00 00 	movl   $0x5,0xc(%eax)

  sched();
80104b69:	e8 ab 05 00 00       	call   80105119 <sched>
  panic("zombie exit");
80104b6e:	83 ec 0c             	sub    $0xc,%esp
80104b71:	68 7c 98 10 80       	push   $0x8010987c
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
80104b8c:	68 60 3d 11 80       	push   $0x80113d60
80104b91:	e8 19 14 00 00       	call   80105faf <acquire>
80104b96:	83 c4 10             	add    $0x10,%esp
  for (;;)
  {
    // Scan through table looking for exited children.
    havekids = 0;
80104b99:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104ba0:	c7 45 f4 94 3d 11 80 	movl   $0x80113d94,-0xc(%ebp)
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
80104bfc:	e8 75 45 00 00       	call   80109176 <freevm>
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
80104c36:	68 60 3d 11 80       	push   $0x80113d60
80104c3b:	e8 dd 13 00 00       	call   8010601d <release>
80104c40:	83 c4 10             	add    $0x10,%esp
        return pid;
80104c43:	8b 45 e8             	mov    -0x18(%ebp),%eax
80104c46:	eb 54                	jmp    80104c9c <wait+0x121>
        continue;
80104c48:	90                   	nop
    for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104c49:	81 45 f4 a8 00 00 00 	addl   $0xa8,-0xc(%ebp)
80104c50:	81 7d f4 94 67 11 80 	cmpl   $0x80116794,-0xc(%ebp)
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
80104c70:	68 60 3d 11 80       	push   $0x80113d60
80104c75:	e8 a3 13 00 00       	call   8010601d <release>
80104c7a:	83 c4 10             	add    $0x10,%esp
      return -1;
80104c7d:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80104c82:	eb 18                	jmp    80104c9c <wait+0x121>
    }

    // Wait for children to exit.  (See wakeup1 call in proc_exit.)
    sleep(curproc, &ptable.lock); // DOC: wait-sleep
80104c84:	83 ec 08             	sub    $0x8,%esp
80104c87:	68 60 3d 11 80       	push   $0x80113d60
80104c8c:	ff 75 ec             	push   -0x14(%ebp)
80104c8f:	e8 8f 06 00 00       	call   80105323 <sleep>
80104c94:	83 c4 10             	add    $0x10,%esp
    havekids = 0;
80104c97:	e9 fd fe ff ff       	jmp    80104b99 <wait+0x1e>
  }
}
80104c9c:	c9                   	leave  
80104c9d:	c3                   	ret    

80104c9e <set_bjf_params>:
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

void set_bjf_params(int pid, int priority_ratio, int arrival_time_ratio, int executed_cycle_ratio)
{
80104c9e:	55                   	push   %ebp
80104c9f:	89 e5                	mov    %esp,%ebp
80104ca1:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104ca4:	83 ec 0c             	sub    $0xc,%esp
80104ca7:	68 60 3d 11 80       	push   $0x80113d60
80104cac:	e8 fe 12 00 00       	call   80105faf <acquire>
80104cb1:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104cb4:	c7 45 f4 94 3d 11 80 	movl   $0x80113d94,-0xc(%ebp)
80104cbb:	eb 36                	jmp    80104cf3 <set_bjf_params+0x55>
  {
    if (p->pid == pid)
80104cbd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cc0:	8b 40 10             	mov    0x10(%eax),%eax
80104cc3:	39 45 08             	cmp    %eax,0x8(%ebp)
80104cc6:	75 24                	jne    80104cec <set_bjf_params+0x4e>
    {
      p->priority_ratio = priority_ratio;
80104cc8:	db 45 0c             	fildl  0xc(%ebp)
80104ccb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cce:	d9 98 84 00 00 00    	fstps  0x84(%eax)
      p->arrivetime = arrival_time_ratio;
80104cd4:	8b 55 10             	mov    0x10(%ebp),%edx
80104cd7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104cda:	89 90 90 00 00 00    	mov    %edx,0x90(%eax)
      p->executed_cycle_ratio = executed_cycle_ratio;
80104ce0:	db 45 14             	fildl  0x14(%ebp)
80104ce3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104ce6:	d9 98 8c 00 00 00    	fstps  0x8c(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104cec:	81 45 f4 a8 00 00 00 	addl   $0xa8,-0xc(%ebp)
80104cf3:	81 7d f4 94 67 11 80 	cmpl   $0x80116794,-0xc(%ebp)
80104cfa:	72 c1                	jb     80104cbd <set_bjf_params+0x1f>
    }
  }
  release(&ptable.lock);
80104cfc:	83 ec 0c             	sub    $0xc,%esp
80104cff:	68 60 3d 11 80       	push   $0x80113d60
80104d04:	e8 14 13 00 00       	call   8010601d <release>
80104d09:	83 c4 10             	add    $0x10,%esp
}
80104d0c:	90                   	nop
80104d0d:	c9                   	leave  
80104d0e:	c3                   	ret    

80104d0f <set_all_bjf_params>:

void set_all_bjf_params(int priority_ratio, int arrival_time_ratio, int executed_cycle_ratio)
{
80104d0f:	55                   	push   %ebp
80104d10:	89 e5                	mov    %esp,%ebp
80104d12:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
80104d15:	83 ec 0c             	sub    $0xc,%esp
80104d18:	68 60 3d 11 80       	push   $0x80113d60
80104d1d:	e8 8d 12 00 00       	call   80105faf <acquire>
80104d22:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104d25:	c7 45 f4 94 3d 11 80 	movl   $0x80113d94,-0xc(%ebp)
80104d2c:	eb 2b                	jmp    80104d59 <set_all_bjf_params+0x4a>
  {
    p->priority_ratio = priority_ratio;
80104d2e:	db 45 08             	fildl  0x8(%ebp)
80104d31:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d34:	d9 98 84 00 00 00    	fstps  0x84(%eax)
    p->arrivetime = arrival_time_ratio;
80104d3a:	8b 55 0c             	mov    0xc(%ebp),%edx
80104d3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d40:	89 90 90 00 00 00    	mov    %edx,0x90(%eax)
    p->executed_cycle_ratio = executed_cycle_ratio;
80104d46:	db 45 10             	fildl  0x10(%ebp)
80104d49:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104d4c:	d9 98 8c 00 00 00    	fstps  0x8c(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80104d52:	81 45 f4 a8 00 00 00 	addl   $0xa8,-0xc(%ebp)
80104d59:	81 7d f4 94 67 11 80 	cmpl   $0x80116794,-0xc(%ebp)
80104d60:	72 cc                	jb     80104d2e <set_all_bjf_params+0x1f>
  }
  release(&ptable.lock);
80104d62:	83 ec 0c             	sub    $0xc,%esp
80104d65:	68 60 3d 11 80       	push   $0x80113d60
80104d6a:	e8 ae 12 00 00       	call   8010601d <release>
80104d6f:	83 c4 10             	add    $0x10,%esp
}
80104d72:	90                   	nop
80104d73:	c9                   	leave  
80104d74:	c3                   	ret    

80104d75 <calculate_rank>:

int calculate_rank(struct proc *p)
{
80104d75:	55                   	push   %ebp
80104d76:	89 e5                	mov    %esp,%ebp
80104d78:	83 ec 10             	sub    $0x10,%esp
  return ((p->priority * p->priority_ratio) +
80104d7b:	8b 45 08             	mov    0x8(%ebp),%eax
80104d7e:	8b 80 80 00 00 00    	mov    0x80(%eax),%eax
80104d84:	89 45 f0             	mov    %eax,-0x10(%ebp)
80104d87:	db 45 f0             	fildl  -0x10(%ebp)
80104d8a:	8b 45 08             	mov    0x8(%ebp),%eax
80104d8d:	d9 80 84 00 00 00    	flds   0x84(%eax)
80104d93:	de c9                	fmulp  %st,%st(1)
          (p->arrivetime * p->arrivetime_ratio) +
80104d95:	8b 45 08             	mov    0x8(%ebp),%eax
80104d98:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
80104d9e:	89 45 f0             	mov    %eax,-0x10(%ebp)
80104da1:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80104da8:	df 6d f0             	fildll -0x10(%ebp)
80104dab:	8b 45 08             	mov    0x8(%ebp),%eax
80104dae:	d9 80 94 00 00 00    	flds   0x94(%eax)
80104db4:	de c9                	fmulp  %st,%st(1)
  return ((p->priority * p->priority_ratio) +
80104db6:	de c1                	faddp  %st,%st(1)
          (p->executed_cycle * p->executed_cycle_ratio));
80104db8:	8b 45 08             	mov    0x8(%ebp),%eax
80104dbb:	d9 80 88 00 00 00    	flds   0x88(%eax)
80104dc1:	8b 45 08             	mov    0x8(%ebp),%eax
80104dc4:	d9 80 8c 00 00 00    	flds   0x8c(%eax)
80104dca:	de c9                	fmulp  %st,%st(1)
          (p->arrivetime * p->arrivetime_ratio) +
80104dcc:	de c1                	faddp  %st,%st(1)
80104dce:	d9 7d fe             	fnstcw -0x2(%ebp)
80104dd1:	0f b7 45 fe          	movzwl -0x2(%ebp),%eax
80104dd5:	80 cc 0c             	or     $0xc,%ah
80104dd8:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80104ddc:	d9 6d fc             	fldcw  -0x4(%ebp)
80104ddf:	db 5d f0             	fistpl -0x10(%ebp)
80104de2:	d9 6d fe             	fldcw  -0x2(%ebp)
80104de5:	8b 45 f0             	mov    -0x10(%ebp),%eax
}
80104de8:	c9                   	leave  
80104de9:	c3                   	ret    

80104dea <scheduler>:
//   - choose a process to run
//   - swtch to start running that process
//   - eventually that process transfers control
//       via swtch back to the scheduler.
void scheduler(void)
{
80104dea:	55                   	push   %ebp
80104deb:	89 e5                	mov    %esp,%ebp
80104ded:	83 ec 38             	sub    $0x38,%esp
  struct proc *p;
  struct cpu *c = mycpu();
80104df0:	e8 a9 f4 ff ff       	call   8010429e <mycpu>
80104df5:	89 45 dc             	mov    %eax,-0x24(%ebp)
  c->proc = 0;
80104df8:	8b 45 dc             	mov    -0x24(%ebp),%eax
80104dfb:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80104e02:	00 00 00 

  for (;;)
  {
    // Enable interrupts on this processor.
    sti();
80104e05:	e8 d7 f3 ff ff       	call   801041e1 <sti>

    // Loop over process table looking for process to run.
    acquire(&ptable.lock);
80104e0a:	83 ec 0c             	sub    $0xc,%esp
80104e0d:	68 60 3d 11 80       	push   $0x80113d60
80104e12:	e8 98 11 00 00       	call   80105faf <acquire>
80104e17:	83 c4 10             	add    $0x10,%esp
    uint found_runnable = 0;
80104e1a:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
    if (rr_q.pi >= 0)
80104e21:	a1 a0 68 11 80       	mov    0x801168a0,%eax
80104e26:	85 c0                	test   %eax,%eax
80104e28:	0f 88 db 00 00 00    	js     80104f09 <scheduler+0x11f>
    {
      p = rr_q.proc[rr_counter % (rr_q.pi + 1)];
80104e2e:	a1 e4 6a 11 80       	mov    0x80116ae4,%eax
80104e33:	8b 15 a0 68 11 80    	mov    0x801168a0,%edx
80104e39:	83 c2 01             	add    $0x1,%edx
80104e3c:	89 d1                	mov    %edx,%ecx
80104e3e:	ba 00 00 00 00       	mov    $0x0,%edx
80104e43:	f7 f1                	div    %ecx
80104e45:	89 d0                	mov    %edx,%eax
80104e47:	8b 04 85 a0 67 11 80 	mov    -0x7fee9860(,%eax,4),%eax
80104e4e:	89 45 f4             	mov    %eax,-0xc(%ebp)
      if (p->state == RUNNABLE)
80104e51:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e54:	8b 40 0c             	mov    0xc(%eax),%eax
80104e57:	83 f8 03             	cmp    $0x3,%eax
80104e5a:	75 0c                	jne    80104e68 <scheduler+0x7e>
      {
        found_runnable = 1;
80104e5c:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
80104e63:	e9 3a 02 00 00       	jmp    801050a2 <scheduler+0x2b8>
      }
      else if (p->state == RUNNING)
80104e68:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104e6b:	8b 40 0c             	mov    0xc(%eax),%eax
80104e6e:	83 f8 04             	cmp    $0x4,%eax
80104e71:	0f 85 85 00 00 00    	jne    80104efc <scheduler+0x112>
      {
        // Find a new process to run for the idle core
        // Loop over queue with amount of its length
        for (int i = 0; i < rr_q.pi; i++)
80104e77:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80104e7e:	eb 6d                	jmp    80104eed <scheduler+0x103>
        {
          if (rr_q.proc[(rr_counter + i + 1) % (rr_q.pi + 1)]->state == RUNNABLE)
80104e80:	8b 15 e4 6a 11 80    	mov    0x80116ae4,%edx
80104e86:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104e89:	01 d0                	add    %edx,%eax
80104e8b:	83 c0 01             	add    $0x1,%eax
80104e8e:	8b 15 a0 68 11 80    	mov    0x801168a0,%edx
80104e94:	83 c2 01             	add    $0x1,%edx
80104e97:	89 d1                	mov    %edx,%ecx
80104e99:	ba 00 00 00 00       	mov    $0x0,%edx
80104e9e:	f7 f1                	div    %ecx
80104ea0:	89 d0                	mov    %edx,%eax
80104ea2:	8b 04 85 a0 67 11 80 	mov    -0x7fee9860(,%eax,4),%eax
80104ea9:	8b 40 0c             	mov    0xc(%eax),%eax
80104eac:	83 f8 03             	cmp    $0x3,%eax
80104eaf:	75 38                	jne    80104ee9 <scheduler+0xff>
          {
            p = rr_q.proc[(rr_counter + i + 1) % (rr_q.pi + 1)];
80104eb1:	8b 15 e4 6a 11 80    	mov    0x80116ae4,%edx
80104eb7:	8b 45 ec             	mov    -0x14(%ebp),%eax
80104eba:	01 d0                	add    %edx,%eax
80104ebc:	83 c0 01             	add    $0x1,%eax
80104ebf:	8b 15 a0 68 11 80    	mov    0x801168a0,%edx
80104ec5:	83 c2 01             	add    $0x1,%edx
80104ec8:	89 d1                	mov    %edx,%ecx
80104eca:	ba 00 00 00 00       	mov    $0x0,%edx
80104ecf:	f7 f1                	div    %ecx
80104ed1:	89 d0                	mov    %edx,%eax
80104ed3:	8b 04 85 a0 67 11 80 	mov    -0x7fee9860(,%eax,4),%eax
80104eda:	89 45 f4             	mov    %eax,-0xc(%ebp)
            found_runnable = 1;
80104edd:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
            break;
80104ee4:	e9 b9 01 00 00       	jmp    801050a2 <scheduler+0x2b8>
        for (int i = 0; i < rr_q.pi; i++)
80104ee9:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
80104eed:	a1 a0 68 11 80       	mov    0x801168a0,%eax
80104ef2:	39 45 ec             	cmp    %eax,-0x14(%ebp)
80104ef5:	7c 89                	jl     80104e80 <scheduler+0x96>
80104ef7:	e9 a6 01 00 00       	jmp    801050a2 <scheduler+0x2b8>
          }
        }
      }
      else
      {
        panic("No runnable process\n");
80104efc:	83 ec 0c             	sub    $0xc,%esp
80104eff:	68 88 98 10 80       	push   $0x80109888
80104f04:	e8 ac b6 ff ff       	call   801005b5 <panic>
      }
    }
    else if (lcfs_q.pi >= 0)
80104f09:	a1 c0 69 11 80       	mov    0x801169c0,%eax
80104f0e:	85 c0                	test   %eax,%eax
80104f10:	0f 88 88 00 00 00    	js     80104f9e <scheduler+0x1b4>
    {
      p = lcfs_q.proc[lcfs_q.pi];
80104f16:	a1 c0 69 11 80       	mov    0x801169c0,%eax
80104f1b:	8b 04 85 c0 68 11 80 	mov    -0x7fee9740(,%eax,4),%eax
80104f22:	89 45 f4             	mov    %eax,-0xc(%ebp)
      if (p->state == RUNNABLE)
80104f25:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f28:	8b 40 0c             	mov    0xc(%eax),%eax
80104f2b:	83 f8 03             	cmp    $0x3,%eax
80104f2e:	75 0c                	jne    80104f3c <scheduler+0x152>
      {
        found_runnable = 1;
80104f30:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
80104f37:	e9 66 01 00 00       	jmp    801050a2 <scheduler+0x2b8>
      }
      else if (p->state == RUNNING)
80104f3c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80104f3f:	8b 40 0c             	mov    0xc(%eax),%eax
80104f42:	83 f8 04             	cmp    $0x4,%eax
80104f45:	75 4a                	jne    80104f91 <scheduler+0x1a7>
      {
        for (int i = lcfs_q.pi; i > 0; i--)
80104f47:	a1 c0 69 11 80       	mov    0x801169c0,%eax
80104f4c:	89 45 e8             	mov    %eax,-0x18(%ebp)
80104f4f:	eb 35                	jmp    80104f86 <scheduler+0x19c>
        {
          if (lcfs_q.proc[i - 1]->state == RUNNABLE)
80104f51:	8b 45 e8             	mov    -0x18(%ebp),%eax
80104f54:	83 e8 01             	sub    $0x1,%eax
80104f57:	8b 04 85 c0 68 11 80 	mov    -0x7fee9740(,%eax,4),%eax
80104f5e:	8b 40 0c             	mov    0xc(%eax),%eax
80104f61:	83 f8 03             	cmp    $0x3,%eax
80104f64:	75 1c                	jne    80104f82 <scheduler+0x198>
          {
            p = lcfs_q.proc[i - 1];
80104f66:	8b 45 e8             	mov    -0x18(%ebp),%eax
80104f69:	83 e8 01             	sub    $0x1,%eax
80104f6c:	8b 04 85 c0 68 11 80 	mov    -0x7fee9740(,%eax,4),%eax
80104f73:	89 45 f4             	mov    %eax,-0xc(%ebp)
            found_runnable = 1;
80104f76:	c7 45 f0 01 00 00 00 	movl   $0x1,-0x10(%ebp)
            break;
80104f7d:	e9 20 01 00 00       	jmp    801050a2 <scheduler+0x2b8>
        for (int i = lcfs_q.pi; i > 0; i--)
80104f82:	83 6d e8 01          	subl   $0x1,-0x18(%ebp)
80104f86:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
80104f8a:	7f c5                	jg     80104f51 <scheduler+0x167>
80104f8c:	e9 11 01 00 00       	jmp    801050a2 <scheduler+0x2b8>
          }
        }
      }
      else
      {
        panic("No runnable process\n");
80104f91:	83 ec 0c             	sub    $0xc,%esp
80104f94:	68 88 98 10 80       	push   $0x80109888
80104f99:	e8 17 b6 ff ff       	call   801005b5 <panic>
      }
    }
    else if (bjf_q.pi >= 0)
80104f9e:	a1 e0 6a 11 80       	mov    0x80116ae0,%eax
80104fa3:	85 c0                	test   %eax,%eax
80104fa5:	78 78                	js     8010501f <scheduler+0x235>
    {
      float worst_rank = 999999999;
80104fa7:	d9 05 84 9a 10 80    	flds   0x80109a84
80104fad:	d9 5d e4             	fstps  -0x1c(%ebp)
      float rank;

      for (int i = 0; i < bjf_q.pi; i++)
80104fb0:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
80104fb7:	eb 57                	jmp    80105010 <scheduler+0x226>
      {
        if (bjf_q.proc[i]->state != RUNNABLE)
80104fb9:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104fbc:	8b 04 85 e0 69 11 80 	mov    -0x7fee9620(,%eax,4),%eax
80104fc3:	8b 40 0c             	mov    0xc(%eax),%eax
80104fc6:	83 f8 03             	cmp    $0x3,%eax
80104fc9:	75 40                	jne    8010500b <scheduler+0x221>
          continue;

        rank = calculate_rank(bjf_q.proc[i]);
80104fcb:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104fce:	8b 04 85 e0 69 11 80 	mov    -0x7fee9620(,%eax,4),%eax
80104fd5:	83 ec 0c             	sub    $0xc,%esp
80104fd8:	50                   	push   %eax
80104fd9:	e8 97 fd ff ff       	call   80104d75 <calculate_rank>
80104fde:	83 c4 10             	add    $0x10,%esp
80104fe1:	89 45 d4             	mov    %eax,-0x2c(%ebp)
80104fe4:	db 45 d4             	fildl  -0x2c(%ebp)
80104fe7:	d9 5d d8             	fstps  -0x28(%ebp)

        if (rank < worst_rank)
80104fea:	d9 45 d8             	flds   -0x28(%ebp)
80104fed:	d9 45 e4             	flds   -0x1c(%ebp)
80104ff0:	df f1                	fcomip %st(1),%st
80104ff2:	dd d8                	fstp   %st(0)
80104ff4:	76 16                	jbe    8010500c <scheduler+0x222>
        {
          p = bjf_q.proc[i];
80104ff6:	8b 45 e0             	mov    -0x20(%ebp),%eax
80104ff9:	8b 04 85 e0 69 11 80 	mov    -0x7fee9620(,%eax,4),%eax
80105000:	89 45 f4             	mov    %eax,-0xc(%ebp)
          worst_rank = rank;
80105003:	d9 45 d8             	flds   -0x28(%ebp)
80105006:	d9 5d e4             	fstps  -0x1c(%ebp)
80105009:	eb 01                	jmp    8010500c <scheduler+0x222>
          continue;
8010500b:	90                   	nop
      for (int i = 0; i < bjf_q.pi; i++)
8010500c:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
80105010:	a1 e0 6a 11 80       	mov    0x80116ae0,%eax
80105015:	39 45 e0             	cmp    %eax,-0x20(%ebp)
80105018:	7c 9f                	jl     80104fb9 <scheduler+0x1cf>
8010501a:	e9 83 00 00 00       	jmp    801050a2 <scheduler+0x2b8>
        }
      }
    }
    else
    {
      for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
8010501f:	c7 45 f4 94 3d 11 80 	movl   $0x80113d94,-0xc(%ebp)
80105026:	eb 71                	jmp    80105099 <scheduler+0x2af>
      {
        if (p->state != RUNNABLE)
80105028:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010502b:	8b 40 0c             	mov    0xc(%eax),%eax
8010502e:	83 f8 03             	cmp    $0x3,%eax
80105031:	75 5e                	jne    80105091 <scheduler+0x2a7>
          continue;
        }
        // Switch to chosen process.  It is the process's job
        // to release ptable.lock and then reacquire it
        // before jumping back to us.
        p->waiting_time = 0;
80105033:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105036:	c7 80 a0 00 00 00 00 	movl   $0x0,0xa0(%eax)
8010503d:	00 00 00 
        c->proc = p;
80105040:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105043:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105046:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
        switchuvm(p);
8010504c:	83 ec 0c             	sub    $0xc,%esp
8010504f:	ff 75 f4             	push   -0xc(%ebp)
80105052:	e8 7a 3c 00 00       	call   80108cd1 <switchuvm>
80105057:	83 c4 10             	add    $0x10,%esp
        p->state = RUNNING;
8010505a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010505d:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)

        swtch(&(c->scheduler), p->context);
80105064:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105067:	8b 40 1c             	mov    0x1c(%eax),%eax
8010506a:	8b 55 dc             	mov    -0x24(%ebp),%edx
8010506d:	83 c2 04             	add    $0x4,%edx
80105070:	83 ec 08             	sub    $0x8,%esp
80105073:	50                   	push   %eax
80105074:	52                   	push   %edx
80105075:	e8 30 14 00 00       	call   801064aa <swtch>
8010507a:	83 c4 10             	add    $0x10,%esp
        switchkvm();
8010507d:	e8 36 3c 00 00       	call   80108cb8 <switchkvm>

        // Process is done running for now.
        // It should have changed its p->state before coming back.
        c->proc = 0;
80105082:	8b 45 dc             	mov    -0x24(%ebp),%eax
80105085:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
8010508c:	00 00 00 
8010508f:	eb 01                	jmp    80105092 <scheduler+0x2a8>
          continue;
80105091:	90                   	nop
      for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105092:	81 45 f4 a8 00 00 00 	addl   $0xa8,-0xc(%ebp)
80105099:	81 7d f4 94 67 11 80 	cmpl   $0x80116794,-0xc(%ebp)
801050a0:	72 86                	jb     80105028 <scheduler+0x23e>
      }
    }
    if (found_runnable)
801050a2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801050a6:	74 5c                	je     80105104 <scheduler+0x31a>
    {
      p->waiting_time = 0;
801050a8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050ab:	c7 80 a0 00 00 00 00 	movl   $0x0,0xa0(%eax)
801050b2:	00 00 00 
      c->proc = p;
801050b5:	8b 45 dc             	mov    -0x24(%ebp),%eax
801050b8:	8b 55 f4             	mov    -0xc(%ebp),%edx
801050bb:	89 90 ac 00 00 00    	mov    %edx,0xac(%eax)
      switchuvm(p);
801050c1:	83 ec 0c             	sub    $0xc,%esp
801050c4:	ff 75 f4             	push   -0xc(%ebp)
801050c7:	e8 05 3c 00 00       	call   80108cd1 <switchuvm>
801050cc:	83 c4 10             	add    $0x10,%esp
      p->state = RUNNING;
801050cf:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050d2:	c7 40 0c 04 00 00 00 	movl   $0x4,0xc(%eax)
      swtch(&(c->scheduler), p->context);
801050d9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801050dc:	8b 40 1c             	mov    0x1c(%eax),%eax
801050df:	8b 55 dc             	mov    -0x24(%ebp),%edx
801050e2:	83 c2 04             	add    $0x4,%edx
801050e5:	83 ec 08             	sub    $0x8,%esp
801050e8:	50                   	push   %eax
801050e9:	52                   	push   %edx
801050ea:	e8 bb 13 00 00       	call   801064aa <swtch>
801050ef:	83 c4 10             	add    $0x10,%esp
      switchkvm();
801050f2:	e8 c1 3b 00 00       	call   80108cb8 <switchkvm>
      c->proc = 0;
801050f7:	8b 45 dc             	mov    -0x24(%ebp),%eax
801050fa:	c7 80 ac 00 00 00 00 	movl   $0x0,0xac(%eax)
80105101:	00 00 00 
    }
    release(&ptable.lock);
80105104:	83 ec 0c             	sub    $0xc,%esp
80105107:	68 60 3d 11 80       	push   $0x80113d60
8010510c:	e8 0c 0f 00 00       	call   8010601d <release>
80105111:	83 c4 10             	add    $0x10,%esp
  {
80105114:	e9 ec fc ff ff       	jmp    80104e05 <scheduler+0x1b>

80105119 <sched>:
// kernel thread, not this CPU. It should
// be proc->intena and proc->ncli, but that would
// break in the few places where a lock is held but
// there's no process.
void sched(void)
{
80105119:	55                   	push   %ebp
8010511a:	89 e5                	mov    %esp,%ebp
8010511c:	83 ec 18             	sub    $0x18,%esp
  int intena;
  struct proc *p = myproc();
8010511f:	e8 f2 f1 ff ff       	call   80104316 <myproc>
80105124:	89 45 f4             	mov    %eax,-0xc(%ebp)

  if (!holding(&ptable.lock))
80105127:	83 ec 0c             	sub    $0xc,%esp
8010512a:	68 60 3d 11 80       	push   $0x80113d60
8010512f:	e8 b6 0f 00 00       	call   801060ea <holding>
80105134:	83 c4 10             	add    $0x10,%esp
80105137:	85 c0                	test   %eax,%eax
80105139:	75 0d                	jne    80105148 <sched+0x2f>
    panic("sched ptable.lock");
8010513b:	83 ec 0c             	sub    $0xc,%esp
8010513e:	68 9d 98 10 80       	push   $0x8010989d
80105143:	e8 6d b4 ff ff       	call   801005b5 <panic>
  if (mycpu()->ncli != 1)
80105148:	e8 51 f1 ff ff       	call   8010429e <mycpu>
8010514d:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80105153:	83 f8 01             	cmp    $0x1,%eax
80105156:	74 0d                	je     80105165 <sched+0x4c>
    panic("sched locks");
80105158:	83 ec 0c             	sub    $0xc,%esp
8010515b:	68 af 98 10 80       	push   $0x801098af
80105160:	e8 50 b4 ff ff       	call   801005b5 <panic>
  if (p->state == RUNNING)
80105165:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105168:	8b 40 0c             	mov    0xc(%eax),%eax
8010516b:	83 f8 04             	cmp    $0x4,%eax
8010516e:	75 0d                	jne    8010517d <sched+0x64>
    panic("sched running");
80105170:	83 ec 0c             	sub    $0xc,%esp
80105173:	68 bb 98 10 80       	push   $0x801098bb
80105178:	e8 38 b4 ff ff       	call   801005b5 <panic>
  if (readeflags() & FL_IF)
8010517d:	e8 4f f0 ff ff       	call   801041d1 <readeflags>
80105182:	25 00 02 00 00       	and    $0x200,%eax
80105187:	85 c0                	test   %eax,%eax
80105189:	74 0d                	je     80105198 <sched+0x7f>
    panic("sched interruptible");
8010518b:	83 ec 0c             	sub    $0xc,%esp
8010518e:	68 c9 98 10 80       	push   $0x801098c9
80105193:	e8 1d b4 ff ff       	call   801005b5 <panic>
  intena = mycpu()->intena;
80105198:	e8 01 f1 ff ff       	call   8010429e <mycpu>
8010519d:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801051a3:	89 45 f0             	mov    %eax,-0x10(%ebp)
  swtch(&p->context, mycpu()->scheduler);
801051a6:	e8 f3 f0 ff ff       	call   8010429e <mycpu>
801051ab:	8b 40 04             	mov    0x4(%eax),%eax
801051ae:	8b 55 f4             	mov    -0xc(%ebp),%edx
801051b1:	83 c2 1c             	add    $0x1c,%edx
801051b4:	83 ec 08             	sub    $0x8,%esp
801051b7:	50                   	push   %eax
801051b8:	52                   	push   %edx
801051b9:	e8 ec 12 00 00       	call   801064aa <swtch>
801051be:	83 c4 10             	add    $0x10,%esp
  mycpu()->intena = intena;
801051c1:	e8 d8 f0 ff ff       	call   8010429e <mycpu>
801051c6:	8b 55 f0             	mov    -0x10(%ebp),%edx
801051c9:	89 90 a8 00 00 00    	mov    %edx,0xa8(%eax)
}
801051cf:	90                   	nop
801051d0:	c9                   	leave  
801051d1:	c3                   	ret    

801051d2 <yield>:

// Give up the CPU for one scheduling round.
void yield(void)
{
801051d2:	55                   	push   %ebp
801051d3:	89 e5                	mov    %esp,%ebp
801051d5:	53                   	push   %ebx
801051d6:	83 ec 04             	sub    $0x4,%esp
  acquire(&ptable.lock); // DOC: yieldlock
801051d9:	83 ec 0c             	sub    $0xc,%esp
801051dc:	68 60 3d 11 80       	push   $0x80113d60
801051e1:	e8 c9 0d 00 00       	call   80105faf <acquire>
801051e6:	83 c4 10             	add    $0x10,%esp
  // According to TRICKS file
  // Change proc values before RUNNABLE
  myproc()->running_ticks = 0; // reset running ticks to 0
801051e9:	e8 28 f1 ff ff       	call   80104316 <myproc>
801051ee:	c7 80 9c 00 00 00 00 	movl   $0x0,0x9c(%eax)
801051f5:	00 00 00 
  if (myproc()->q_type == RR)
801051f8:	e8 19 f1 ff ff       	call   80104316 <myproc>
801051fd:	8b 40 7c             	mov    0x7c(%eax),%eax
80105200:	83 f8 01             	cmp    $0x1,%eax
80105203:	75 0d                	jne    80105212 <yield+0x40>
  {
    rr_counter++;
80105205:	a1 e4 6a 11 80       	mov    0x80116ae4,%eax
8010520a:	83 c0 01             	add    $0x1,%eax
8010520d:	a3 e4 6a 11 80       	mov    %eax,0x80116ae4
  }
  if (myproc()->change_running_queue)
80105212:	e8 ff f0 ff ff       	call   80104316 <myproc>
80105217:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
8010521d:	85 c0                	test   %eax,%eax
8010521f:	0f 84 91 00 00 00    	je     801052b6 <yield+0xe4>
  {
    switch (myproc()->q_type)
80105225:	e8 ec f0 ff ff       	call   80104316 <myproc>
8010522a:	8b 40 7c             	mov    0x7c(%eax),%eax
8010522d:	83 f8 03             	cmp    $0x3,%eax
80105230:	74 53                	je     80105285 <yield+0xb3>
80105232:	83 f8 03             	cmp    $0x3,%eax
80105235:	77 6f                	ja     801052a6 <yield+0xd4>
80105237:	83 f8 01             	cmp    $0x1,%eax
8010523a:	74 07                	je     80105243 <yield+0x71>
8010523c:	83 f8 02             	cmp    $0x2,%eax
8010523f:	74 23                	je     80105264 <yield+0x92>
    case BJF:
      bjf_q.pi++;
      bjf_q.proc[bjf_q.pi] = myproc();
      break;
    default:
      break;
80105241:	eb 63                	jmp    801052a6 <yield+0xd4>
      rr_q.pi++;
80105243:	a1 a0 68 11 80       	mov    0x801168a0,%eax
80105248:	83 c0 01             	add    $0x1,%eax
8010524b:	a3 a0 68 11 80       	mov    %eax,0x801168a0
      rr_q.proc[rr_q.pi] = myproc();
80105250:	8b 1d a0 68 11 80    	mov    0x801168a0,%ebx
80105256:	e8 bb f0 ff ff       	call   80104316 <myproc>
8010525b:	89 04 9d a0 67 11 80 	mov    %eax,-0x7fee9860(,%ebx,4)
      break;
80105262:	eb 43                	jmp    801052a7 <yield+0xd5>
      lcfs_q.pi++;
80105264:	a1 c0 69 11 80       	mov    0x801169c0,%eax
80105269:	83 c0 01             	add    $0x1,%eax
8010526c:	a3 c0 69 11 80       	mov    %eax,0x801169c0
      lcfs_q.proc[lcfs_q.pi] = myproc();
80105271:	8b 1d c0 69 11 80    	mov    0x801169c0,%ebx
80105277:	e8 9a f0 ff ff       	call   80104316 <myproc>
8010527c:	89 04 9d c0 68 11 80 	mov    %eax,-0x7fee9740(,%ebx,4)
      break;
80105283:	eb 22                	jmp    801052a7 <yield+0xd5>
      bjf_q.pi++;
80105285:	a1 e0 6a 11 80       	mov    0x80116ae0,%eax
8010528a:	83 c0 01             	add    $0x1,%eax
8010528d:	a3 e0 6a 11 80       	mov    %eax,0x80116ae0
      bjf_q.proc[bjf_q.pi] = myproc();
80105292:	8b 1d e0 6a 11 80    	mov    0x80116ae0,%ebx
80105298:	e8 79 f0 ff ff       	call   80104316 <myproc>
8010529d:	89 04 9d e0 69 11 80 	mov    %eax,-0x7fee9620(,%ebx,4)
      break;
801052a4:	eb 01                	jmp    801052a7 <yield+0xd5>
      break;
801052a6:	90                   	nop
    }
    // Change has been applied
    myproc()->change_running_queue = 0;
801052a7:	e8 6a f0 ff ff       	call   80104316 <myproc>
801052ac:	c7 80 a4 00 00 00 00 	movl   $0x0,0xa4(%eax)
801052b3:	00 00 00 
  }
  myproc()->state = RUNNABLE;
801052b6:	e8 5b f0 ff ff       	call   80104316 <myproc>
801052bb:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  sched();
801052c2:	e8 52 fe ff ff       	call   80105119 <sched>
  release(&ptable.lock);
801052c7:	83 ec 0c             	sub    $0xc,%esp
801052ca:	68 60 3d 11 80       	push   $0x80113d60
801052cf:	e8 49 0d 00 00       	call   8010601d <release>
801052d4:	83 c4 10             	add    $0x10,%esp
}
801052d7:	90                   	nop
801052d8:	8b 5d fc             	mov    -0x4(%ebp),%ebx
801052db:	c9                   	leave  
801052dc:	c3                   	ret    

801052dd <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch here.  "Return" to user space.
void forkret(void)
{
801052dd:	55                   	push   %ebp
801052de:	89 e5                	mov    %esp,%ebp
801052e0:	83 ec 08             	sub    $0x8,%esp
  static int first = 1;
  // Still holding ptable.lock from scheduler.
  release(&ptable.lock);
801052e3:	83 ec 0c             	sub    $0xc,%esp
801052e6:	68 60 3d 11 80       	push   $0x80113d60
801052eb:	e8 2d 0d 00 00       	call   8010601d <release>
801052f0:	83 c4 10             	add    $0x10,%esp

  if (first)
801052f3:	a1 04 c0 10 80       	mov    0x8010c004,%eax
801052f8:	85 c0                	test   %eax,%eax
801052fa:	74 24                	je     80105320 <forkret+0x43>
  {
    // Some initialization functions must be run in the context
    // of a regular process (e.g., they call sleep), and thus cannot
    // be run from main().
    first = 0;
801052fc:	c7 05 04 c0 10 80 00 	movl   $0x0,0x8010c004
80105303:	00 00 00 
    iinit(ROOTDEV);
80105306:	83 ec 0c             	sub    $0xc,%esp
80105309:	6a 01                	push   $0x1
8010530b:	e8 98 c3 ff ff       	call   801016a8 <iinit>
80105310:	83 c4 10             	add    $0x10,%esp
    initlog(ROOTDEV);
80105313:	83 ec 0c             	sub    $0xc,%esp
80105316:	6a 01                	push   $0x1
80105318:	e8 f6 df ff ff       	call   80103313 <initlog>
8010531d:	83 c4 10             	add    $0x10,%esp
  }

  // Return to "caller", actually trapret (see allocproc).
}
80105320:	90                   	nop
80105321:	c9                   	leave  
80105322:	c3                   	ret    

80105323 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void sleep(void *chan, struct spinlock *lk)
{
80105323:	55                   	push   %ebp
80105324:	89 e5                	mov    %esp,%ebp
80105326:	83 ec 18             	sub    $0x18,%esp
  struct proc *p = myproc();
80105329:	e8 e8 ef ff ff       	call   80104316 <myproc>
8010532e:	89 45 f4             	mov    %eax,-0xc(%ebp)

  if (p == 0)
80105331:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80105335:	75 0d                	jne    80105344 <sleep+0x21>
    panic("sleep");
80105337:	83 ec 0c             	sub    $0xc,%esp
8010533a:	68 dd 98 10 80       	push   $0x801098dd
8010533f:	e8 71 b2 ff ff       	call   801005b5 <panic>

  if (lk == 0)
80105344:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80105348:	75 0d                	jne    80105357 <sleep+0x34>
    panic("sleep without lk");
8010534a:	83 ec 0c             	sub    $0xc,%esp
8010534d:	68 e3 98 10 80       	push   $0x801098e3
80105352:	e8 5e b2 ff ff       	call   801005b5 <panic>
  // change p->state and then call sched.
  // Once we hold ptable.lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup runs with ptable.lock locked),
  // so it's okay to release lk.
  if (lk != &ptable.lock)
80105357:	81 7d 0c 60 3d 11 80 	cmpl   $0x80113d60,0xc(%ebp)
8010535e:	74 1e                	je     8010537e <sleep+0x5b>
  {                        // DOC: sleeplock0
    acquire(&ptable.lock); // DOC: sleeplock1
80105360:	83 ec 0c             	sub    $0xc,%esp
80105363:	68 60 3d 11 80       	push   $0x80113d60
80105368:	e8 42 0c 00 00       	call   80105faf <acquire>
8010536d:	83 c4 10             	add    $0x10,%esp
    release(lk);
80105370:	83 ec 0c             	sub    $0xc,%esp
80105373:	ff 75 0c             	push   0xc(%ebp)
80105376:	e8 a2 0c 00 00       	call   8010601d <release>
8010537b:	83 c4 10             	add    $0x10,%esp
  }
  cleanupCorresQueue(p);
8010537e:	83 ec 0c             	sub    $0xc,%esp
80105381:	ff 75 f4             	push   -0xc(%ebp)
80105384:	e8 dc f5 ff ff       	call   80104965 <cleanupCorresQueue>
80105389:	83 c4 10             	add    $0x10,%esp
  // Cleanup from queue on sleep
  // Go to sleep.
  p->chan = chan;
8010538c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010538f:	8b 55 08             	mov    0x8(%ebp),%edx
80105392:	89 50 20             	mov    %edx,0x20(%eax)
  p->state = SLEEPING;
80105395:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105398:	c7 40 0c 02 00 00 00 	movl   $0x2,0xc(%eax)

  sched();
8010539f:	e8 75 fd ff ff       	call   80105119 <sched>

  // Tidy up.
  p->chan = 0;
801053a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801053a7:	c7 40 20 00 00 00 00 	movl   $0x0,0x20(%eax)

  // Reacquire original lock.
  if (lk != &ptable.lock)
801053ae:	81 7d 0c 60 3d 11 80 	cmpl   $0x80113d60,0xc(%ebp)
801053b5:	74 1e                	je     801053d5 <sleep+0xb2>
  { // DOC: sleeplock2
    release(&ptable.lock);
801053b7:	83 ec 0c             	sub    $0xc,%esp
801053ba:	68 60 3d 11 80       	push   $0x80113d60
801053bf:	e8 59 0c 00 00       	call   8010601d <release>
801053c4:	83 c4 10             	add    $0x10,%esp
    acquire(lk);
801053c7:	83 ec 0c             	sub    $0xc,%esp
801053ca:	ff 75 0c             	push   0xc(%ebp)
801053cd:	e8 dd 0b 00 00       	call   80105faf <acquire>
801053d2:	83 c4 10             	add    $0x10,%esp
  }
}
801053d5:	90                   	nop
801053d6:	c9                   	leave  
801053d7:	c3                   	ret    

801053d8 <wakeup1>:
// PAGEBREAK!
//  Wake up all processes sleeping on chan.
//  The ptable lock must be held.
static void
wakeup1(void *chan)
{
801053d8:	55                   	push   %ebp
801053d9:	89 e5                	mov    %esp,%ebp
801053db:	83 ec 10             	sub    $0x10,%esp
  struct proc *p;

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801053de:	c7 45 fc 94 3d 11 80 	movl   $0x80113d94,-0x4(%ebp)
801053e5:	e9 a6 00 00 00       	jmp    80105490 <wakeup1+0xb8>
    if (p->state == SLEEPING && p->chan == chan)
801053ea:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053ed:	8b 40 0c             	mov    0xc(%eax),%eax
801053f0:	83 f8 02             	cmp    $0x2,%eax
801053f3:	0f 85 90 00 00 00    	jne    80105489 <wakeup1+0xb1>
801053f9:	8b 45 fc             	mov    -0x4(%ebp),%eax
801053fc:	8b 40 20             	mov    0x20(%eax),%eax
801053ff:	39 45 08             	cmp    %eax,0x8(%ebp)
80105402:	0f 85 81 00 00 00    	jne    80105489 <wakeup1+0xb1>
    {
      // Add to queue once again when woken up
      switch (p->q_type)
80105408:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010540b:	8b 40 7c             	mov    0x7c(%eax),%eax
8010540e:	83 f8 03             	cmp    $0x3,%eax
80105411:	74 4d                	je     80105460 <wakeup1+0x88>
80105413:	83 f8 03             	cmp    $0x3,%eax
80105416:	77 66                	ja     8010547e <wakeup1+0xa6>
80105418:	83 f8 01             	cmp    $0x1,%eax
8010541b:	74 07                	je     80105424 <wakeup1+0x4c>
8010541d:	83 f8 02             	cmp    $0x2,%eax
80105420:	74 20                	je     80105442 <wakeup1+0x6a>
      case BJF:
        bjf_q.pi++;
        bjf_q.proc[bjf_q.pi] = p;
        break;
      default:
        break;
80105422:	eb 5a                	jmp    8010547e <wakeup1+0xa6>
        rr_q.pi++;
80105424:	a1 a0 68 11 80       	mov    0x801168a0,%eax
80105429:	83 c0 01             	add    $0x1,%eax
8010542c:	a3 a0 68 11 80       	mov    %eax,0x801168a0
        rr_q.proc[rr_q.pi] = p;
80105431:	a1 a0 68 11 80       	mov    0x801168a0,%eax
80105436:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105439:	89 14 85 a0 67 11 80 	mov    %edx,-0x7fee9860(,%eax,4)
        break;
80105440:	eb 3d                	jmp    8010547f <wakeup1+0xa7>
        lcfs_q.pi++;
80105442:	a1 c0 69 11 80       	mov    0x801169c0,%eax
80105447:	83 c0 01             	add    $0x1,%eax
8010544a:	a3 c0 69 11 80       	mov    %eax,0x801169c0
        lcfs_q.proc[lcfs_q.pi] = p;
8010544f:	a1 c0 69 11 80       	mov    0x801169c0,%eax
80105454:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105457:	89 14 85 c0 68 11 80 	mov    %edx,-0x7fee9740(,%eax,4)
        break;
8010545e:	eb 1f                	jmp    8010547f <wakeup1+0xa7>
        bjf_q.pi++;
80105460:	a1 e0 6a 11 80       	mov    0x80116ae0,%eax
80105465:	83 c0 01             	add    $0x1,%eax
80105468:	a3 e0 6a 11 80       	mov    %eax,0x80116ae0
        bjf_q.proc[bjf_q.pi] = p;
8010546d:	a1 e0 6a 11 80       	mov    0x80116ae0,%eax
80105472:	8b 55 fc             	mov    -0x4(%ebp),%edx
80105475:	89 14 85 e0 69 11 80 	mov    %edx,-0x7fee9620(,%eax,4)
        break;
8010547c:	eb 01                	jmp    8010547f <wakeup1+0xa7>
        break;
8010547e:	90                   	nop
      }
      p->state = RUNNABLE;
8010547f:	8b 45 fc             	mov    -0x4(%ebp),%eax
80105482:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105489:	81 45 fc a8 00 00 00 	addl   $0xa8,-0x4(%ebp)
80105490:	81 7d fc 94 67 11 80 	cmpl   $0x80116794,-0x4(%ebp)
80105497:	0f 82 4d ff ff ff    	jb     801053ea <wakeup1+0x12>
    }
}
8010549d:	90                   	nop
8010549e:	90                   	nop
8010549f:	c9                   	leave  
801054a0:	c3                   	ret    

801054a1 <wakeup>:

// Wake up all processes sleeping on chan.
void wakeup(void *chan)
{
801054a1:	55                   	push   %ebp
801054a2:	89 e5                	mov    %esp,%ebp
801054a4:	83 ec 08             	sub    $0x8,%esp
  acquire(&ptable.lock);
801054a7:	83 ec 0c             	sub    $0xc,%esp
801054aa:	68 60 3d 11 80       	push   $0x80113d60
801054af:	e8 fb 0a 00 00       	call   80105faf <acquire>
801054b4:	83 c4 10             	add    $0x10,%esp
  wakeup1(chan);
801054b7:	83 ec 0c             	sub    $0xc,%esp
801054ba:	ff 75 08             	push   0x8(%ebp)
801054bd:	e8 16 ff ff ff       	call   801053d8 <wakeup1>
801054c2:	83 c4 10             	add    $0x10,%esp
  release(&ptable.lock);
801054c5:	83 ec 0c             	sub    $0xc,%esp
801054c8:	68 60 3d 11 80       	push   $0x80113d60
801054cd:	e8 4b 0b 00 00       	call   8010601d <release>
801054d2:	83 c4 10             	add    $0x10,%esp
}
801054d5:	90                   	nop
801054d6:	c9                   	leave  
801054d7:	c3                   	ret    

801054d8 <kill>:

// Kill the process with the given pid.
// Process won't exit until it returns
// to user space (see trap in trap.c).
int kill(int pid)
{
801054d8:	55                   	push   %ebp
801054d9:	89 e5                	mov    %esp,%ebp
801054db:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;

  acquire(&ptable.lock);
801054de:	83 ec 0c             	sub    $0xc,%esp
801054e1:	68 60 3d 11 80       	push   $0x80113d60
801054e6:	e8 c4 0a 00 00       	call   80105faf <acquire>
801054eb:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801054ee:	c7 45 f4 94 3d 11 80 	movl   $0x80113d94,-0xc(%ebp)
801054f5:	e9 c9 00 00 00       	jmp    801055c3 <kill+0xeb>
  {
    if (p->pid == pid)
801054fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801054fd:	8b 40 10             	mov    0x10(%eax),%eax
80105500:	39 45 08             	cmp    %eax,0x8(%ebp)
80105503:	0f 85 b3 00 00 00    	jne    801055bc <kill+0xe4>
    {
      p->killed = 1;
80105509:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010550c:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
      // Wake process from sleep if necessary.
      if (p->state == SLEEPING)
80105513:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105516:	8b 40 0c             	mov    0xc(%eax),%eax
80105519:	83 f8 02             	cmp    $0x2,%eax
8010551c:	0f 85 83 00 00 00    	jne    801055a5 <kill+0xcd>
      {
        if (p->q_type == RR)
80105522:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105525:	8b 40 7c             	mov    0x7c(%eax),%eax
80105528:	83 f8 01             	cmp    $0x1,%eax
8010552b:	75 1e                	jne    8010554b <kill+0x73>
        {
          rr_q.pi++;
8010552d:	a1 a0 68 11 80       	mov    0x801168a0,%eax
80105532:	83 c0 01             	add    $0x1,%eax
80105535:	a3 a0 68 11 80       	mov    %eax,0x801168a0
          rr_q.proc[rr_q.pi] = p;
8010553a:	a1 a0 68 11 80       	mov    0x801168a0,%eax
8010553f:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105542:	89 14 85 a0 67 11 80 	mov    %edx,-0x7fee9860(,%eax,4)
80105549:	eb 50                	jmp    8010559b <kill+0xc3>
        }
        else if (p->q_type == LCFS)
8010554b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010554e:	8b 40 7c             	mov    0x7c(%eax),%eax
80105551:	83 f8 02             	cmp    $0x2,%eax
80105554:	75 1e                	jne    80105574 <kill+0x9c>
        {
          lcfs_q.pi++;
80105556:	a1 c0 69 11 80       	mov    0x801169c0,%eax
8010555b:	83 c0 01             	add    $0x1,%eax
8010555e:	a3 c0 69 11 80       	mov    %eax,0x801169c0
          lcfs_q.proc[lcfs_q.pi] = p;
80105563:	a1 c0 69 11 80       	mov    0x801169c0,%eax
80105568:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010556b:	89 14 85 c0 68 11 80 	mov    %edx,-0x7fee9740(,%eax,4)
80105572:	eb 27                	jmp    8010559b <kill+0xc3>
        }
        else if (p->q_type == BJF)
80105574:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105577:	8b 40 7c             	mov    0x7c(%eax),%eax
8010557a:	83 f8 03             	cmp    $0x3,%eax
8010557d:	75 1c                	jne    8010559b <kill+0xc3>
        {
          bjf_q.pi++;
8010557f:	a1 e0 6a 11 80       	mov    0x80116ae0,%eax
80105584:	83 c0 01             	add    $0x1,%eax
80105587:	a3 e0 6a 11 80       	mov    %eax,0x80116ae0
          bjf_q.proc[bjf_q.pi] = p;
8010558c:	a1 e0 6a 11 80       	mov    0x80116ae0,%eax
80105591:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105594:	89 14 85 e0 69 11 80 	mov    %edx,-0x7fee9620(,%eax,4)
        }
        p->state = RUNNABLE;
8010559b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010559e:	c7 40 0c 03 00 00 00 	movl   $0x3,0xc(%eax)
      }
      release(&ptable.lock);
801055a5:	83 ec 0c             	sub    $0xc,%esp
801055a8:	68 60 3d 11 80       	push   $0x80113d60
801055ad:	e8 6b 0a 00 00       	call   8010601d <release>
801055b2:	83 c4 10             	add    $0x10,%esp
      return 0;
801055b5:	b8 00 00 00 00       	mov    $0x0,%eax
801055ba:	eb 29                	jmp    801055e5 <kill+0x10d>
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801055bc:	81 45 f4 a8 00 00 00 	addl   $0xa8,-0xc(%ebp)
801055c3:	81 7d f4 94 67 11 80 	cmpl   $0x80116794,-0xc(%ebp)
801055ca:	0f 82 2a ff ff ff    	jb     801054fa <kill+0x22>
    }
  }
  release(&ptable.lock);
801055d0:	83 ec 0c             	sub    $0xc,%esp
801055d3:	68 60 3d 11 80       	push   $0x80113d60
801055d8:	e8 40 0a 00 00       	call   8010601d <release>
801055dd:	83 c4 10             	add    $0x10,%esp
  return -1;
801055e0:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
}
801055e5:	c9                   	leave  
801055e6:	c3                   	ret    

801055e7 <procdump>:
// PAGEBREAK: 36
//  Print a process listing to console.  For debugging.
//  Runs when user types ^P on console.
//  No lock to avoid wedging a stuck machine further.
void procdump(void)
{
801055e7:	55                   	push   %ebp
801055e8:	89 e5                	mov    %esp,%ebp
801055ea:	83 ec 48             	sub    $0x48,%esp
  int i;
  struct proc *p;
  char *state;
  uint pc[10];

  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801055ed:	c7 45 f0 94 3d 11 80 	movl   $0x80113d94,-0x10(%ebp)
801055f4:	e9 da 00 00 00       	jmp    801056d3 <procdump+0xec>
  {
    if (p->state == UNUSED)
801055f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801055fc:	8b 40 0c             	mov    0xc(%eax),%eax
801055ff:	85 c0                	test   %eax,%eax
80105601:	0f 84 c4 00 00 00    	je     801056cb <procdump+0xe4>
      continue;
    if (p->state >= 0 && p->state < NELEM(states) && states[p->state])
80105607:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010560a:	8b 40 0c             	mov    0xc(%eax),%eax
8010560d:	83 f8 05             	cmp    $0x5,%eax
80105610:	77 23                	ja     80105635 <procdump+0x4e>
80105612:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105615:	8b 40 0c             	mov    0xc(%eax),%eax
80105618:	8b 04 85 08 c0 10 80 	mov    -0x7fef3ff8(,%eax,4),%eax
8010561f:	85 c0                	test   %eax,%eax
80105621:	74 12                	je     80105635 <procdump+0x4e>
      state = states[p->state];
80105623:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105626:	8b 40 0c             	mov    0xc(%eax),%eax
80105629:	8b 04 85 08 c0 10 80 	mov    -0x7fef3ff8(,%eax,4),%eax
80105630:	89 45 ec             	mov    %eax,-0x14(%ebp)
80105633:	eb 07                	jmp    8010563c <procdump+0x55>
    else
      state = "???";
80105635:	c7 45 ec f4 98 10 80 	movl   $0x801098f4,-0x14(%ebp)
    cprintf("%d %s %s", p->pid, state, p->name);
8010563c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010563f:	8d 50 6c             	lea    0x6c(%eax),%edx
80105642:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105645:	8b 40 10             	mov    0x10(%eax),%eax
80105648:	52                   	push   %edx
80105649:	ff 75 ec             	push   -0x14(%ebp)
8010564c:	50                   	push   %eax
8010564d:	68 f8 98 10 80       	push   $0x801098f8
80105652:	e8 a9 ad ff ff       	call   80100400 <cprintf>
80105657:	83 c4 10             	add    $0x10,%esp
    if (p->state == SLEEPING)
8010565a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010565d:	8b 40 0c             	mov    0xc(%eax),%eax
80105660:	83 f8 02             	cmp    $0x2,%eax
80105663:	75 54                	jne    801056b9 <procdump+0xd2>
    {
      getcallerpcs((uint *)p->context->ebp + 2, pc);
80105665:	8b 45 f0             	mov    -0x10(%ebp),%eax
80105668:	8b 40 1c             	mov    0x1c(%eax),%eax
8010566b:	8b 40 0c             	mov    0xc(%eax),%eax
8010566e:	83 c0 08             	add    $0x8,%eax
80105671:	89 c2                	mov    %eax,%edx
80105673:	83 ec 08             	sub    $0x8,%esp
80105676:	8d 45 c4             	lea    -0x3c(%ebp),%eax
80105679:	50                   	push   %eax
8010567a:	52                   	push   %edx
8010567b:	e8 ef 09 00 00       	call   8010606f <getcallerpcs>
80105680:	83 c4 10             	add    $0x10,%esp
      for (i = 0; i < 10 && pc[i] != 0; i++)
80105683:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010568a:	eb 1c                	jmp    801056a8 <procdump+0xc1>
        cprintf(" %p", pc[i]);
8010568c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010568f:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
80105693:	83 ec 08             	sub    $0x8,%esp
80105696:	50                   	push   %eax
80105697:	68 01 99 10 80       	push   $0x80109901
8010569c:	e8 5f ad ff ff       	call   80100400 <cprintf>
801056a1:	83 c4 10             	add    $0x10,%esp
      for (i = 0; i < 10 && pc[i] != 0; i++)
801056a4:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801056a8:	83 7d f4 09          	cmpl   $0x9,-0xc(%ebp)
801056ac:	7f 0b                	jg     801056b9 <procdump+0xd2>
801056ae:	8b 45 f4             	mov    -0xc(%ebp),%eax
801056b1:	8b 44 85 c4          	mov    -0x3c(%ebp,%eax,4),%eax
801056b5:	85 c0                	test   %eax,%eax
801056b7:	75 d3                	jne    8010568c <procdump+0xa5>
    }
    cprintf("\n");
801056b9:	83 ec 0c             	sub    $0xc,%esp
801056bc:	68 05 99 10 80       	push   $0x80109905
801056c1:	e8 3a ad ff ff       	call   80100400 <cprintf>
801056c6:	83 c4 10             	add    $0x10,%esp
801056c9:	eb 01                	jmp    801056cc <procdump+0xe5>
      continue;
801056cb:	90                   	nop
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801056cc:	81 45 f0 a8 00 00 00 	addl   $0xa8,-0x10(%ebp)
801056d3:	81 7d f0 94 67 11 80 	cmpl   $0x80116794,-0x10(%ebp)
801056da:	0f 82 19 ff ff ff    	jb     801055f9 <procdump+0x12>
  }
}
801056e0:	90                   	nop
801056e1:	90                   	nop
801056e2:	c9                   	leave  
801056e3:	c3                   	ret    

801056e4 <wrap_space>:

char *wrap_space(char *inp, char *holder, const int len)
{
801056e4:	55                   	push   %ebp
801056e5:	89 e5                	mov    %esp,%ebp
801056e7:	83 ec 18             	sub    $0x18,%esp
  memset(holder, ' ', len);
801056ea:	8b 45 10             	mov    0x10(%ebp),%eax
801056ed:	83 ec 04             	sub    $0x4,%esp
801056f0:	50                   	push   %eax
801056f1:	6a 20                	push   $0x20
801056f3:	ff 75 0c             	push   0xc(%ebp)
801056f6:	e8 3a 0b 00 00       	call   80106235 <memset>
801056fb:	83 c4 10             	add    $0x10,%esp
  holder[len] = 0;
801056fe:	8b 55 10             	mov    0x10(%ebp),%edx
80105701:	8b 45 0c             	mov    0xc(%ebp),%eax
80105704:	01 d0                	add    %edx,%eax
80105706:	c6 00 00             	movb   $0x0,(%eax)
  int n = len;
80105709:	8b 45 10             	mov    0x10(%ebp),%eax
8010570c:	89 45 f4             	mov    %eax,-0xc(%ebp)
  int i = 0;
8010570f:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  while (n-- > 0)
80105716:	eb 28                	jmp    80105740 <wrap_space+0x5c>
  {
    if (*(inp + i) == 0)
80105718:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010571b:	8b 45 08             	mov    0x8(%ebp),%eax
8010571e:	01 d0                	add    %edx,%eax
80105720:	0f b6 00             	movzbl (%eax),%eax
80105723:	84 c0                	test   %al,%al
80105725:	74 28                	je     8010574f <wrap_space+0x6b>
      break;
    *(holder + i) = *(inp + i);
80105727:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010572a:	8b 45 08             	mov    0x8(%ebp),%eax
8010572d:	01 d0                	add    %edx,%eax
8010572f:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80105732:	8b 55 0c             	mov    0xc(%ebp),%edx
80105735:	01 ca                	add    %ecx,%edx
80105737:	0f b6 00             	movzbl (%eax),%eax
8010573a:	88 02                	mov    %al,(%edx)
    i++;
8010573c:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  while (n-- > 0)
80105740:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105743:	8d 50 ff             	lea    -0x1(%eax),%edx
80105746:	89 55 f4             	mov    %edx,-0xc(%ebp)
80105749:	85 c0                	test   %eax,%eax
8010574b:	7f cb                	jg     80105718 <wrap_space+0x34>
8010574d:	eb 01                	jmp    80105750 <wrap_space+0x6c>
      break;
8010574f:	90                   	nop
  }
  return holder;
80105750:	8b 45 0c             	mov    0xc(%ebp),%eax
}
80105753:	c9                   	leave  
80105754:	c3                   	ret    

80105755 <wrap_spacei>:

char *wrap_spacei(int inp, char *holder, const int len)
{
80105755:	55                   	push   %ebp
80105756:	89 e5                	mov    %esp,%ebp
80105758:	53                   	push   %ebx
80105759:	83 ec 14             	sub    $0x14,%esp
  if (inp < 0)
8010575c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80105760:	79 0d                	jns    8010576f <wrap_spacei+0x1a>
  {
    panic("negative pid or arrive time");
80105762:	83 ec 0c             	sub    $0xc,%esp
80105765:	68 07 99 10 80       	push   $0x80109907
8010576a:	e8 46 ae ff ff       	call   801005b5 <panic>
  }
  memset(holder, ' ', len);
8010576f:	8b 45 10             	mov    0x10(%ebp),%eax
80105772:	83 ec 04             	sub    $0x4,%esp
80105775:	50                   	push   %eax
80105776:	6a 20                	push   $0x20
80105778:	ff 75 0c             	push   0xc(%ebp)
8010577b:	e8 b5 0a 00 00       	call   80106235 <memset>
80105780:	83 c4 10             	add    $0x10,%esp
  holder[len] = 0;
80105783:	8b 55 10             	mov    0x10(%ebp),%edx
80105786:	8b 45 0c             	mov    0xc(%ebp),%eax
80105789:	01 d0                	add    %edx,%eax
8010578b:	c6 00 00             	movb   $0x0,(%eax)
  int rev = 0;
8010578e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
  int cnt = 0;
80105795:	c7 45 f0 00 00 00 00 	movl   $0x0,-0x10(%ebp)
  do
  {
    rev *= 10;
8010579c:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010579f:	89 d0                	mov    %edx,%eax
801057a1:	c1 e0 02             	shl    $0x2,%eax
801057a4:	01 d0                	add    %edx,%eax
801057a6:	01 c0                	add    %eax,%eax
801057a8:	89 45 f4             	mov    %eax,-0xc(%ebp)
    rev += (inp % 10);
801057ab:	8b 4d 08             	mov    0x8(%ebp),%ecx
801057ae:	ba 67 66 66 66       	mov    $0x66666667,%edx
801057b3:	89 c8                	mov    %ecx,%eax
801057b5:	f7 ea                	imul   %edx
801057b7:	89 d0                	mov    %edx,%eax
801057b9:	c1 f8 02             	sar    $0x2,%eax
801057bc:	89 cb                	mov    %ecx,%ebx
801057be:	c1 fb 1f             	sar    $0x1f,%ebx
801057c1:	29 d8                	sub    %ebx,%eax
801057c3:	89 c2                	mov    %eax,%edx
801057c5:	89 d0                	mov    %edx,%eax
801057c7:	c1 e0 02             	shl    $0x2,%eax
801057ca:	01 d0                	add    %edx,%eax
801057cc:	01 c0                	add    %eax,%eax
801057ce:	29 c1                	sub    %eax,%ecx
801057d0:	89 ca                	mov    %ecx,%edx
801057d2:	01 55 f4             	add    %edx,-0xc(%ebp)
    inp /= 10;
801057d5:	8b 4d 08             	mov    0x8(%ebp),%ecx
801057d8:	ba 67 66 66 66       	mov    $0x66666667,%edx
801057dd:	89 c8                	mov    %ecx,%eax
801057df:	f7 ea                	imul   %edx
801057e1:	89 d0                	mov    %edx,%eax
801057e3:	c1 f8 02             	sar    $0x2,%eax
801057e6:	c1 f9 1f             	sar    $0x1f,%ecx
801057e9:	89 ca                	mov    %ecx,%edx
801057eb:	29 d0                	sub    %edx,%eax
801057ed:	89 45 08             	mov    %eax,0x8(%ebp)
    cnt++;
801057f0:	83 45 f0 01          	addl   $0x1,-0x10(%ebp)
  } while (inp > 0);
801057f4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
801057f8:	7f a2                	jg     8010579c <wrap_spacei+0x47>
  for (int i = 0; i < cnt; i++)
801057fa:	c7 45 ec 00 00 00 00 	movl   $0x0,-0x14(%ebp)
80105801:	eb 57                	jmp    8010585a <wrap_spacei+0x105>
  {
    holder[i] = (rev % 10) + '0';
80105803:	8b 4d f4             	mov    -0xc(%ebp),%ecx
80105806:	ba 67 66 66 66       	mov    $0x66666667,%edx
8010580b:	89 c8                	mov    %ecx,%eax
8010580d:	f7 ea                	imul   %edx
8010580f:	89 d0                	mov    %edx,%eax
80105811:	c1 f8 02             	sar    $0x2,%eax
80105814:	89 cb                	mov    %ecx,%ebx
80105816:	c1 fb 1f             	sar    $0x1f,%ebx
80105819:	29 d8                	sub    %ebx,%eax
8010581b:	89 c2                	mov    %eax,%edx
8010581d:	89 d0                	mov    %edx,%eax
8010581f:	c1 e0 02             	shl    $0x2,%eax
80105822:	01 d0                	add    %edx,%eax
80105824:	01 c0                	add    %eax,%eax
80105826:	29 c1                	sub    %eax,%ecx
80105828:	89 ca                	mov    %ecx,%edx
8010582a:	89 d0                	mov    %edx,%eax
8010582c:	8d 48 30             	lea    0x30(%eax),%ecx
8010582f:	8b 55 ec             	mov    -0x14(%ebp),%edx
80105832:	8b 45 0c             	mov    0xc(%ebp),%eax
80105835:	01 d0                	add    %edx,%eax
80105837:	89 ca                	mov    %ecx,%edx
80105839:	88 10                	mov    %dl,(%eax)
    rev /= 10;
8010583b:	8b 4d f4             	mov    -0xc(%ebp),%ecx
8010583e:	ba 67 66 66 66       	mov    $0x66666667,%edx
80105843:	89 c8                	mov    %ecx,%eax
80105845:	f7 ea                	imul   %edx
80105847:	89 d0                	mov    %edx,%eax
80105849:	c1 f8 02             	sar    $0x2,%eax
8010584c:	c1 f9 1f             	sar    $0x1f,%ecx
8010584f:	89 ca                	mov    %ecx,%edx
80105851:	29 d0                	sub    %edx,%eax
80105853:	89 45 f4             	mov    %eax,-0xc(%ebp)
  for (int i = 0; i < cnt; i++)
80105856:	83 45 ec 01          	addl   $0x1,-0x14(%ebp)
8010585a:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010585d:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80105860:	7c a1                	jl     80105803 <wrap_spacei+0xae>
  }
  return holder;
80105862:	8b 45 0c             	mov    0xc(%ebp),%eax
}
80105865:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105868:	c9                   	leave  
80105869:	c3                   	ret    

8010586a <print_proc>:
#define SIZER_LEN 2 //Size ratio

#define TICKS_LEN 6

void print_proc(void)
{
8010586a:	55                   	push   %ebp
8010586b:	89 e5                	mov    %esp,%ebp
8010586d:	57                   	push   %edi
8010586e:	56                   	push   %esi
8010586f:	53                   	push   %ebx
80105870:	81 ec ac 00 00 00    	sub    $0xac,%esp
  struct proc *p;
  char *states[] = {
80105876:	c7 45 cc 23 99 10 80 	movl   $0x80109923,-0x34(%ebp)
8010587d:	c7 45 d0 2c 99 10 80 	movl   $0x8010992c,-0x30(%ebp)
80105884:	c7 45 d4 35 99 10 80 	movl   $0x80109935,-0x2c(%ebp)
8010588b:	c7 45 d8 3e 99 10 80 	movl   $0x8010993e,-0x28(%ebp)
80105892:	c7 45 dc 47 99 10 80 	movl   $0x80109947,-0x24(%ebp)
80105899:	c7 45 e0 50 99 10 80 	movl   $0x80109950,-0x20(%ebp)
      [EMBRYO] "EMBRYO  ",
      [SLEEPING] "SLEEPING",
      [RUNNABLE] "RUNNABLE",
      [RUNNING] "RUNNING ",
      [ZOMBIE] "ZOMBIE  "};
  cprintf("name          pid  state    queue  arr_time  priority Ratio:p a e s  exe_cycle  p_size  ticks\n");
801058a0:	83 ec 0c             	sub    $0xc,%esp
801058a3:	68 5c 99 10 80       	push   $0x8010995c
801058a8:	e8 53 ab ff ff       	call   80100400 <cprintf>
801058ad:	83 c4 10             	add    $0x10,%esp
  cprintf("..............................................................................\n");
801058b0:	83 ec 0c             	sub    $0xc,%esp
801058b3:	68 bc 99 10 80       	push   $0x801099bc
801058b8:	e8 43 ab ff ff       	call   80100400 <cprintf>
801058bd:	83 c4 10             	add    $0x10,%esp
  acquire(&ptable.lock);
801058c0:	83 ec 0c             	sub    $0xc,%esp
801058c3:	68 60 3d 11 80       	push   $0x80113d60
801058c8:	e8 e2 06 00 00       	call   80105faf <acquire>
801058cd:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
801058d0:	c7 45 e4 94 3d 11 80 	movl   $0x80113d94,-0x1c(%ebp)
801058d7:	e9 8e 02 00 00       	jmp    80105b6a <print_proc+0x300>
  {
    if (p->state == UNUSED)
801058dc:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801058df:	8b 40 0c             	mov    0xc(%eax),%eax
801058e2:	85 c0                	test   %eax,%eax
801058e4:	0f 84 78 02 00 00    	je     80105b62 <print_proc+0x2f8>
    char size_holder[SIZE_LEN + 1];
    char sizer_holder[SIZER_LEN + 1];

    char ticks_holder[TICKS_LEN + 1];

    cprintf("%s %s %s   %d   %s %s %s %s %s %s %s %s %s\n",
801058ea:	a1 34 73 11 80       	mov    0x80117334,%eax
801058ef:	89 c2                	mov    %eax,%edx
801058f1:	83 ec 04             	sub    $0x4,%esp
801058f4:	6a 06                	push   $0x6
801058f6:	8d 85 7c ff ff ff    	lea    -0x84(%ebp),%eax
801058fc:	50                   	push   %eax
801058fd:	52                   	push   %edx
801058fe:	e8 52 fe ff ff       	call   80105755 <wrap_spacei>
80105903:	83 c4 10             	add    $0x10,%esp
80105906:	89 85 70 ff ff ff    	mov    %eax,-0x90(%ebp)
            wrap_spacei(p->arrivetime_ratio, atr_holder, ATR_LEN),
            wrap_spacei(p->executed_cycle_ratio, exr_holder, EXR_LEN),
            wrap_spacei(p->size_ratio, sizer_holder, SIZER_LEN),
          
            wrap_spacei(p->running_ticks, ex_holder, EX_LEN),
            wrap_spacei(p->sz, size_holder, SIZE_LEN),
8010590c:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010590f:	8b 00                	mov    (%eax),%eax
    cprintf("%s %s %s   %d   %s %s %s %s %s %s %s %s %s\n",
80105911:	89 c2                	mov    %eax,%edx
80105913:	83 ec 04             	sub    $0x4,%esp
80105916:	6a 07                	push   $0x7
80105918:	8d 45 86             	lea    -0x7a(%ebp),%eax
8010591b:	50                   	push   %eax
8010591c:	52                   	push   %edx
8010591d:	e8 33 fe ff ff       	call   80105755 <wrap_spacei>
80105922:	83 c4 10             	add    $0x10,%esp
80105925:	89 85 6c ff ff ff    	mov    %eax,-0x94(%ebp)
            wrap_spacei(p->running_ticks, ex_holder, EX_LEN),
8010592b:	8b 45 e4             	mov    -0x1c(%ebp),%eax
8010592e:	8b 80 9c 00 00 00    	mov    0x9c(%eax),%eax
    cprintf("%s %s %s   %d   %s %s %s %s %s %s %s %s %s\n",
80105934:	89 c2                	mov    %eax,%edx
80105936:	83 ec 04             	sub    $0x4,%esp
80105939:	6a 0a                	push   $0xa
8010593b:	8d 45 90             	lea    -0x70(%ebp),%eax
8010593e:	50                   	push   %eax
8010593f:	52                   	push   %edx
80105940:	e8 10 fe ff ff       	call   80105755 <wrap_spacei>
80105945:	83 c4 10             	add    $0x10,%esp
80105948:	89 85 68 ff ff ff    	mov    %eax,-0x98(%ebp)
            wrap_spacei(p->size_ratio, sizer_holder, SIZER_LEN),
8010594e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105951:	d9 80 98 00 00 00    	flds   0x98(%eax)
    cprintf("%s %s %s   %d   %s %s %s %s %s %s %s %s %s\n",
80105957:	d9 bd 76 ff ff ff    	fnstcw -0x8a(%ebp)
8010595d:	0f b7 85 76 ff ff ff 	movzwl -0x8a(%ebp),%eax
80105964:	80 cc 0c             	or     $0xc,%ah
80105967:	66 89 85 74 ff ff ff 	mov    %ax,-0x8c(%ebp)
8010596e:	d9 ad 74 ff ff ff    	fldcw  -0x8c(%ebp)
80105974:	db 9d 64 ff ff ff    	fistpl -0x9c(%ebp)
8010597a:	d9 ad 76 ff ff ff    	fldcw  -0x8a(%ebp)
80105980:	8b 95 64 ff ff ff    	mov    -0x9c(%ebp),%edx
80105986:	83 ec 04             	sub    $0x4,%esp
80105989:	6a 02                	push   $0x2
8010598b:	8d 45 83             	lea    -0x7d(%ebp),%eax
8010598e:	50                   	push   %eax
8010598f:	52                   	push   %edx
80105990:	e8 c0 fd ff ff       	call   80105755 <wrap_spacei>
80105995:	83 c4 10             	add    $0x10,%esp
80105998:	89 85 64 ff ff ff    	mov    %eax,-0x9c(%ebp)
            wrap_spacei(p->executed_cycle_ratio, exr_holder, EXR_LEN),
8010599e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801059a1:	d9 80 8c 00 00 00    	flds   0x8c(%eax)
    cprintf("%s %s %s   %d   %s %s %s %s %s %s %s %s %s\n",
801059a7:	d9 bd 76 ff ff ff    	fnstcw -0x8a(%ebp)
801059ad:	0f b7 85 76 ff ff ff 	movzwl -0x8a(%ebp),%eax
801059b4:	80 cc 0c             	or     $0xc,%ah
801059b7:	66 89 85 74 ff ff ff 	mov    %ax,-0x8c(%ebp)
801059be:	d9 ad 74 ff ff ff    	fldcw  -0x8c(%ebp)
801059c4:	db 9d 60 ff ff ff    	fistpl -0xa0(%ebp)
801059ca:	d9 ad 76 ff ff ff    	fldcw  -0x8a(%ebp)
801059d0:	8b 95 60 ff ff ff    	mov    -0xa0(%ebp),%edx
801059d6:	83 ec 04             	sub    $0x4,%esp
801059d9:	6a 01                	push   $0x1
801059db:	8d 45 8e             	lea    -0x72(%ebp),%eax
801059de:	50                   	push   %eax
801059df:	52                   	push   %edx
801059e0:	e8 70 fd ff ff       	call   80105755 <wrap_spacei>
801059e5:	83 c4 10             	add    $0x10,%esp
801059e8:	89 85 60 ff ff ff    	mov    %eax,-0xa0(%ebp)
            wrap_spacei(p->arrivetime_ratio, atr_holder, ATR_LEN),
801059ee:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801059f1:	d9 80 94 00 00 00    	flds   0x94(%eax)
    cprintf("%s %s %s   %d   %s %s %s %s %s %s %s %s %s\n",
801059f7:	d9 bd 76 ff ff ff    	fnstcw -0x8a(%ebp)
801059fd:	0f b7 85 76 ff ff ff 	movzwl -0x8a(%ebp),%eax
80105a04:	80 cc 0c             	or     $0xc,%ah
80105a07:	66 89 85 74 ff ff ff 	mov    %ax,-0x8c(%ebp)
80105a0e:	d9 ad 74 ff ff ff    	fldcw  -0x8c(%ebp)
80105a14:	db 9d 5c ff ff ff    	fistpl -0xa4(%ebp)
80105a1a:	d9 ad 76 ff ff ff    	fldcw  -0x8a(%ebp)
80105a20:	8b 95 5c ff ff ff    	mov    -0xa4(%ebp),%edx
80105a26:	83 ec 04             	sub    $0x4,%esp
80105a29:	6a 01                	push   $0x1
80105a2b:	8d 45 ab             	lea    -0x55(%ebp),%eax
80105a2e:	50                   	push   %eax
80105a2f:	52                   	push   %edx
80105a30:	e8 20 fd ff ff       	call   80105755 <wrap_spacei>
80105a35:	83 c4 10             	add    $0x10,%esp
80105a38:	89 85 5c ff ff ff    	mov    %eax,-0xa4(%ebp)
            wrap_spacei(p->priority_ratio, prr_holder, PRR_LEN),
80105a3e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105a41:	d9 80 84 00 00 00    	flds   0x84(%eax)
    cprintf("%s %s %s   %d   %s %s %s %s %s %s %s %s %s\n",
80105a47:	d9 bd 76 ff ff ff    	fnstcw -0x8a(%ebp)
80105a4d:	0f b7 85 76 ff ff ff 	movzwl -0x8a(%ebp),%eax
80105a54:	80 cc 0c             	or     $0xc,%ah
80105a57:	66 89 85 74 ff ff ff 	mov    %ax,-0x8c(%ebp)
80105a5e:	d9 ad 74 ff ff ff    	fldcw  -0x8c(%ebp)
80105a64:	db 9d 58 ff ff ff    	fistpl -0xa8(%ebp)
80105a6a:	d9 ad 76 ff ff ff    	fldcw  -0x8a(%ebp)
80105a70:	8b 95 58 ff ff ff    	mov    -0xa8(%ebp),%edx
80105a76:	83 ec 04             	sub    $0x4,%esp
80105a79:	6a 01                	push   $0x1
80105a7b:	8d 45 9b             	lea    -0x65(%ebp),%eax
80105a7e:	50                   	push   %eax
80105a7f:	52                   	push   %edx
80105a80:	e8 d0 fc ff ff       	call   80105755 <wrap_spacei>
80105a85:	83 c4 10             	add    $0x10,%esp
80105a88:	89 85 58 ff ff ff    	mov    %eax,-0xa8(%ebp)
80105a8e:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105a91:	8b 90 80 00 00 00    	mov    0x80(%eax),%edx
80105a97:	83 ec 04             	sub    $0x4,%esp
80105a9a:	6a 0d                	push   $0xd
80105a9c:	8d 45 9d             	lea    -0x63(%ebp),%eax
80105a9f:	50                   	push   %eax
80105aa0:	52                   	push   %edx
80105aa1:	e8 af fc ff ff       	call   80105755 <wrap_spacei>
80105aa6:	83 c4 10             	add    $0x10,%esp
80105aa9:	89 85 54 ff ff ff    	mov    %eax,-0xac(%ebp)
            wrap_spacei(p->arrivetime, at_holder, AT_LEN),
80105aaf:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105ab2:	8b 80 90 00 00 00    	mov    0x90(%eax),%eax
    cprintf("%s %s %s   %d   %s %s %s %s %s %s %s %s %s\n",
80105ab8:	89 c2                	mov    %eax,%edx
80105aba:	83 ec 04             	sub    $0x4,%esp
80105abd:	6a 0a                	push   $0xa
80105abf:	8d 45 ad             	lea    -0x53(%ebp),%eax
80105ac2:	50                   	push   %eax
80105ac3:	52                   	push   %edx
80105ac4:	e8 8c fc ff ff       	call   80105755 <wrap_spacei>
80105ac9:	83 c4 10             	add    $0x10,%esp
80105acc:	89 c7                	mov    %eax,%edi
            p->q_type,
80105ace:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105ad1:	8b 48 7c             	mov    0x7c(%eax),%ecx
80105ad4:	89 8d 50 ff ff ff    	mov    %ecx,-0xb0(%ebp)
            states[p->state],
80105ada:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105add:	8b 40 0c             	mov    0xc(%eax),%eax
    cprintf("%s %s %s   %d   %s %s %s %s %s %s %s %s %s\n",
80105ae0:	8b 74 85 cc          	mov    -0x34(%ebp,%eax,4),%esi
80105ae4:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105ae7:	8b 50 10             	mov    0x10(%eax),%edx
80105aea:	83 ec 04             	sub    $0x4,%esp
80105aed:	6a 03                	push   $0x3
80105aef:	8d 45 b8             	lea    -0x48(%ebp),%eax
80105af2:	50                   	push   %eax
80105af3:	52                   	push   %edx
80105af4:	e8 5c fc ff ff       	call   80105755 <wrap_spacei>
80105af9:	83 c4 10             	add    $0x10,%esp
80105afc:	89 c3                	mov    %eax,%ebx
            wrap_space(p->name, name_holder, NAME_LEN),
80105afe:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80105b01:	8d 50 6c             	lea    0x6c(%eax),%edx
    cprintf("%s %s %s   %d   %s %s %s %s %s %s %s %s %s\n",
80105b04:	83 ec 04             	sub    $0x4,%esp
80105b07:	6a 0f                	push   $0xf
80105b09:	8d 45 bc             	lea    -0x44(%ebp),%eax
80105b0c:	50                   	push   %eax
80105b0d:	52                   	push   %edx
80105b0e:	e8 d1 fb ff ff       	call   801056e4 <wrap_space>
80105b13:	83 c4 10             	add    $0x10,%esp
80105b16:	83 ec 08             	sub    $0x8,%esp
80105b19:	ff b5 70 ff ff ff    	push   -0x90(%ebp)
80105b1f:	ff b5 6c ff ff ff    	push   -0x94(%ebp)
80105b25:	ff b5 68 ff ff ff    	push   -0x98(%ebp)
80105b2b:	ff b5 64 ff ff ff    	push   -0x9c(%ebp)
80105b31:	ff b5 60 ff ff ff    	push   -0xa0(%ebp)
80105b37:	ff b5 5c ff ff ff    	push   -0xa4(%ebp)
80105b3d:	ff b5 58 ff ff ff    	push   -0xa8(%ebp)
80105b43:	ff b5 54 ff ff ff    	push   -0xac(%ebp)
80105b49:	57                   	push   %edi
80105b4a:	ff b5 50 ff ff ff    	push   -0xb0(%ebp)
80105b50:	56                   	push   %esi
80105b51:	53                   	push   %ebx
80105b52:	50                   	push   %eax
80105b53:	68 0c 9a 10 80       	push   $0x80109a0c
80105b58:	e8 a3 a8 ff ff       	call   80100400 <cprintf>
80105b5d:	83 c4 40             	add    $0x40,%esp
80105b60:	eb 01                	jmp    80105b63 <print_proc+0x2f9>
      continue;
80105b62:	90                   	nop
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105b63:	81 45 e4 a8 00 00 00 	addl   $0xa8,-0x1c(%ebp)
80105b6a:	81 7d e4 94 67 11 80 	cmpl   $0x80116794,-0x1c(%ebp)
80105b71:	0f 82 65 fd ff ff    	jb     801058dc <print_proc+0x72>
            wrap_spacei(ticks, ticks_holder, TICKS_LEN));
  }
  release(&ptable.lock);
80105b77:	83 ec 0c             	sub    $0xc,%esp
80105b7a:	68 60 3d 11 80       	push   $0x80113d60
80105b7f:	e8 99 04 00 00       	call   8010601d <release>
80105b84:	83 c4 10             	add    $0x10,%esp
}
80105b87:	90                   	nop
80105b88:	8d 65 f4             	lea    -0xc(%ebp),%esp
80105b8b:	5b                   	pop    %ebx
80105b8c:	5e                   	pop    %esi
80105b8d:	5f                   	pop    %edi
80105b8e:	5d                   	pop    %ebp
80105b8f:	c3                   	ret    

80105b90 <agingMechanism>:

void agingMechanism(void)
{
80105b90:	55                   	push   %ebp
80105b91:	89 e5                	mov    %esp,%ebp
80105b93:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  if (!holding(&ptable.lock))
80105b96:	83 ec 0c             	sub    $0xc,%esp
80105b99:	68 60 3d 11 80       	push   $0x80113d60
80105b9e:	e8 47 05 00 00       	call   801060ea <holding>
80105ba3:	83 c4 10             	add    $0x10,%esp
80105ba6:	85 c0                	test   %eax,%eax
80105ba8:	75 10                	jne    80105bba <agingMechanism+0x2a>
  {
    acquire(&ptable.lock);
80105baa:	83 ec 0c             	sub    $0xc,%esp
80105bad:	68 60 3d 11 80       	push   $0x80113d60
80105bb2:	e8 f8 03 00 00       	call   80105faf <acquire>
80105bb7:	83 c4 10             	add    $0x10,%esp
  }
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105bba:	c7 45 f4 94 3d 11 80 	movl   $0x80113d94,-0xc(%ebp)
80105bc1:	eb 76                	jmp    80105c39 <agingMechanism+0xa9>
  {
    if (p->state == RUNNABLE)
80105bc3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bc6:	8b 40 0c             	mov    0xc(%eax),%eax
80105bc9:	83 f8 03             	cmp    $0x3,%eax
80105bcc:	75 64                	jne    80105c32 <agingMechanism+0xa2>
    {
      p->waiting_time++;
80105bce:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bd1:	8b 80 a0 00 00 00    	mov    0xa0(%eax),%eax
80105bd7:	8d 50 01             	lea    0x1(%eax),%edx
80105bda:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bdd:	89 90 a0 00 00 00    	mov    %edx,0xa0(%eax)
      if (p->waiting_time > AGING_BOUND && p->q_type != RR)
80105be3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105be6:	8b 80 a0 00 00 00    	mov    0xa0(%eax),%eax
80105bec:	3d d0 07 00 00       	cmp    $0x7d0,%eax
80105bf1:	76 3f                	jbe    80105c32 <agingMechanism+0xa2>
80105bf3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105bf6:	8b 40 7c             	mov    0x7c(%eax),%eax
80105bf9:	83 f8 01             	cmp    $0x1,%eax
80105bfc:	74 34                	je     80105c32 <agingMechanism+0xa2>
      {
        cleanupCorresQueue(p);
80105bfe:	83 ec 0c             	sub    $0xc,%esp
80105c01:	ff 75 f4             	push   -0xc(%ebp)
80105c04:	e8 5c ed ff ff       	call   80104965 <cleanupCorresQueue>
80105c09:	83 c4 10             	add    $0x10,%esp
        p->q_type = RR;
80105c0c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c0f:	c7 40 7c 01 00 00 00 	movl   $0x1,0x7c(%eax)
        rr_q.pi++;
80105c16:	a1 a0 68 11 80       	mov    0x801168a0,%eax
80105c1b:	83 c0 01             	add    $0x1,%eax
80105c1e:	a3 a0 68 11 80       	mov    %eax,0x801168a0
        rr_q.proc[rr_q.pi] = p;
80105c23:	a1 a0 68 11 80       	mov    0x801168a0,%eax
80105c28:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105c2b:	89 14 85 a0 67 11 80 	mov    %edx,-0x7fee9860(,%eax,4)
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105c32:	81 45 f4 a8 00 00 00 	addl   $0xa8,-0xc(%ebp)
80105c39:	81 7d f4 94 67 11 80 	cmpl   $0x80116794,-0xc(%ebp)
80105c40:	72 81                	jb     80105bc3 <agingMechanism+0x33>
      }
    }
  }
  release(&ptable.lock);
80105c42:	83 ec 0c             	sub    $0xc,%esp
80105c45:	68 60 3d 11 80       	push   $0x80113d60
80105c4a:	e8 ce 03 00 00       	call   8010601d <release>
80105c4f:	83 c4 10             	add    $0x10,%esp
}
80105c52:	90                   	nop
80105c53:	c9                   	leave  
80105c54:	c3                   	ret    

80105c55 <change_queue>:

void change_queue(int pid, int queueID)
{
80105c55:	55                   	push   %ebp
80105c56:	89 e5                	mov    %esp,%ebp
80105c58:	83 ec 18             	sub    $0x18,%esp
  struct proc *p;
  acquire(&ptable.lock);
80105c5b:	83 ec 0c             	sub    $0xc,%esp
80105c5e:	68 60 3d 11 80       	push   $0x80113d60
80105c63:	e8 47 03 00 00       	call   80105faf <acquire>
80105c68:	83 c4 10             	add    $0x10,%esp
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105c6b:	c7 45 f4 94 3d 11 80 	movl   $0x80113d94,-0xc(%ebp)
80105c72:	eb 12                	jmp    80105c86 <change_queue+0x31>
  {
    if (p->pid == pid)
80105c74:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c77:	8b 40 10             	mov    0x10(%eax),%eax
80105c7a:	39 45 08             	cmp    %eax,0x8(%ebp)
80105c7d:	74 12                	je     80105c91 <change_queue+0x3c>
  for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
80105c7f:	81 45 f4 a8 00 00 00 	addl   $0xa8,-0xc(%ebp)
80105c86:	81 7d f4 94 67 11 80 	cmpl   $0x80116794,-0xc(%ebp)
80105c8d:	72 e5                	jb     80105c74 <change_queue+0x1f>
80105c8f:	eb 01                	jmp    80105c92 <change_queue+0x3d>
    {
      break;
80105c91:	90                   	nop
    }
  }
  if (p->pid != pid)
80105c92:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105c95:	8b 40 10             	mov    0x10(%eax),%eax
80105c98:	39 45 08             	cmp    %eax,0x8(%ebp)
80105c9b:	74 25                	je     80105cc2 <change_queue+0x6d>
  {
    cprintf("incorrect pid");
80105c9d:	83 ec 0c             	sub    $0xc,%esp
80105ca0:	68 38 9a 10 80       	push   $0x80109a38
80105ca5:	e8 56 a7 ff ff       	call   80100400 <cprintf>
80105caa:	83 c4 10             	add    $0x10,%esp
    release(&ptable.lock);
80105cad:	83 ec 0c             	sub    $0xc,%esp
80105cb0:	68 60 3d 11 80       	push   $0x80113d60
80105cb5:	e8 63 03 00 00       	call   8010601d <release>
80105cba:	83 c4 10             	add    $0x10,%esp
    return;
80105cbd:	e9 46 01 00 00       	jmp    80105e08 <change_queue+0x1b3>
  }
  if (p->state == RUNNING || p->state == RUNNABLE)
80105cc2:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cc5:	8b 40 0c             	mov    0xc(%eax),%eax
80105cc8:	83 f8 04             	cmp    $0x4,%eax
80105ccb:	74 0b                	je     80105cd8 <change_queue+0x83>
80105ccd:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105cd0:	8b 40 0c             	mov    0xc(%eax),%eax
80105cd3:	83 f8 03             	cmp    $0x3,%eax
80105cd6:	75 0e                	jne    80105ce6 <change_queue+0x91>
  {
    cleanupCorresQueue(p);
80105cd8:	83 ec 0c             	sub    $0xc,%esp
80105cdb:	ff 75 f4             	push   -0xc(%ebp)
80105cde:	e8 82 ec ff ff       	call   80104965 <cleanupCorresQueue>
80105ce3:	83 c4 10             	add    $0x10,%esp
  }
  switch (queueID)
80105ce6:	83 7d 0c 03          	cmpl   $0x3,0xc(%ebp)
80105cea:	0f 84 a4 00 00 00    	je     80105d94 <change_queue+0x13f>
80105cf0:	83 7d 0c 03          	cmpl   $0x3,0xc(%ebp)
80105cf4:	0f 8f cd 00 00 00    	jg     80105dc7 <change_queue+0x172>
80105cfa:	83 7d 0c 02          	cmpl   $0x2,0xc(%ebp)
80105cfe:	74 61                	je     80105d61 <change_queue+0x10c>
80105d00:	83 7d 0c 02          	cmpl   $0x2,0xc(%ebp)
80105d04:	0f 8f bd 00 00 00    	jg     80105dc7 <change_queue+0x172>
80105d0a:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
80105d0e:	74 0b                	je     80105d1b <change_queue+0xc6>
80105d10:	83 7d 0c 01          	cmpl   $0x1,0xc(%ebp)
80105d14:	74 14                	je     80105d2a <change_queue+0xd5>
80105d16:	e9 ac 00 00 00       	jmp    80105dc7 <change_queue+0x172>
  {
  case DEF:
    p->q_type = DEF;
80105d1b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d1e:	c7 40 7c 00 00 00 00 	movl   $0x0,0x7c(%eax)
    break;
80105d25:	e9 b6 00 00 00       	jmp    80105de0 <change_queue+0x18b>
  case RR:
    p->q_type = RR;
80105d2a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d2d:	c7 40 7c 01 00 00 00 	movl   $0x1,0x7c(%eax)
    if (p->state == RUNNABLE)
80105d34:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d37:	8b 40 0c             	mov    0xc(%eax),%eax
80105d3a:	83 f8 03             	cmp    $0x3,%eax
80105d3d:	0f 85 96 00 00 00    	jne    80105dd9 <change_queue+0x184>
    {
      rr_q.pi++;
80105d43:	a1 a0 68 11 80       	mov    0x801168a0,%eax
80105d48:	83 c0 01             	add    $0x1,%eax
80105d4b:	a3 a0 68 11 80       	mov    %eax,0x801168a0
      rr_q.proc[rr_q.pi] = p;
80105d50:	a1 a0 68 11 80       	mov    0x801168a0,%eax
80105d55:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105d58:	89 14 85 a0 67 11 80 	mov    %edx,-0x7fee9860(,%eax,4)
    }
    break;
80105d5f:	eb 78                	jmp    80105dd9 <change_queue+0x184>
  case LCFS:
    p->q_type = LCFS;
80105d61:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d64:	c7 40 7c 02 00 00 00 	movl   $0x2,0x7c(%eax)
    if (p->state == RUNNABLE)
80105d6b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d6e:	8b 40 0c             	mov    0xc(%eax),%eax
80105d71:	83 f8 03             	cmp    $0x3,%eax
80105d74:	75 66                	jne    80105ddc <change_queue+0x187>
    {
      lcfs_q.pi++;
80105d76:	a1 c0 69 11 80       	mov    0x801169c0,%eax
80105d7b:	83 c0 01             	add    $0x1,%eax
80105d7e:	a3 c0 69 11 80       	mov    %eax,0x801169c0
      lcfs_q.proc[lcfs_q.pi] = p;
80105d83:	a1 c0 69 11 80       	mov    0x801169c0,%eax
80105d88:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105d8b:	89 14 85 c0 68 11 80 	mov    %edx,-0x7fee9740(,%eax,4)
    }
    break;
80105d92:	eb 48                	jmp    80105ddc <change_queue+0x187>
  case BJF:
    p->q_type = BJF;
80105d94:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105d97:	c7 40 7c 03 00 00 00 	movl   $0x3,0x7c(%eax)
    if (p->state == RUNNABLE)
80105d9e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105da1:	8b 40 0c             	mov    0xc(%eax),%eax
80105da4:	83 f8 03             	cmp    $0x3,%eax
80105da7:	75 36                	jne    80105ddf <change_queue+0x18a>
    {
      bjf_q.pi++;
80105da9:	a1 e0 6a 11 80       	mov    0x80116ae0,%eax
80105dae:	83 c0 01             	add    $0x1,%eax
80105db1:	a3 e0 6a 11 80       	mov    %eax,0x80116ae0
      bjf_q.proc[bjf_q.pi] = p;
80105db6:	a1 e0 6a 11 80       	mov    0x80116ae0,%eax
80105dbb:	8b 55 f4             	mov    -0xc(%ebp),%edx
80105dbe:	89 14 85 e0 69 11 80 	mov    %edx,-0x7fee9620(,%eax,4)
    }
    break;
80105dc5:	eb 18                	jmp    80105ddf <change_queue+0x18a>
  default:
    cprintf("undefined queue");
80105dc7:	83 ec 0c             	sub    $0xc,%esp
80105dca:	68 46 9a 10 80       	push   $0x80109a46
80105dcf:	e8 2c a6 ff ff       	call   80100400 <cprintf>
80105dd4:	83 c4 10             	add    $0x10,%esp
80105dd7:	eb 07                	jmp    80105de0 <change_queue+0x18b>
    break;
80105dd9:	90                   	nop
80105dda:	eb 04                	jmp    80105de0 <change_queue+0x18b>
    break;
80105ddc:	90                   	nop
80105ddd:	eb 01                	jmp    80105de0 <change_queue+0x18b>
    break;
80105ddf:	90                   	nop
  }

  if (p->state == RUNNING)
80105de0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105de3:	8b 40 0c             	mov    0xc(%eax),%eax
80105de6:	83 f8 04             	cmp    $0x4,%eax
80105de9:	75 0d                	jne    80105df8 <change_queue+0x1a3>
  {
    p->change_running_queue = 1;
80105deb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80105dee:	c7 80 a4 00 00 00 01 	movl   $0x1,0xa4(%eax)
80105df5:	00 00 00 
  }
  release(&ptable.lock);
80105df8:	83 ec 0c             	sub    $0xc,%esp
80105dfb:	68 60 3d 11 80       	push   $0x80113d60
80105e00:	e8 18 02 00 00       	call   8010601d <release>
80105e05:	83 c4 10             	add    $0x10,%esp
80105e08:	c9                   	leave  
80105e09:	c3                   	ret    

80105e0a <initsleeplock>:
#include "spinlock.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
80105e0a:	55                   	push   %ebp
80105e0b:	89 e5                	mov    %esp,%ebp
80105e0d:	83 ec 08             	sub    $0x8,%esp
  initlock(&lk->lk, "sleep lock");
80105e10:	8b 45 08             	mov    0x8(%ebp),%eax
80105e13:	83 c0 04             	add    $0x4,%eax
80105e16:	83 ec 08             	sub    $0x8,%esp
80105e19:	68 88 9a 10 80       	push   $0x80109a88
80105e1e:	50                   	push   %eax
80105e1f:	e8 69 01 00 00       	call   80105f8d <initlock>
80105e24:	83 c4 10             	add    $0x10,%esp
  lk->name = name;
80105e27:	8b 45 08             	mov    0x8(%ebp),%eax
80105e2a:	8b 55 0c             	mov    0xc(%ebp),%edx
80105e2d:	89 50 38             	mov    %edx,0x38(%eax)
  lk->locked = 0;
80105e30:	8b 45 08             	mov    0x8(%ebp),%eax
80105e33:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->pid = 0;
80105e39:	8b 45 08             	mov    0x8(%ebp),%eax
80105e3c:	c7 40 3c 00 00 00 00 	movl   $0x0,0x3c(%eax)
}
80105e43:	90                   	nop
80105e44:	c9                   	leave  
80105e45:	c3                   	ret    

80105e46 <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
80105e46:	55                   	push   %ebp
80105e47:	89 e5                	mov    %esp,%ebp
80105e49:	83 ec 08             	sub    $0x8,%esp
  acquire(&lk->lk);
80105e4c:	8b 45 08             	mov    0x8(%ebp),%eax
80105e4f:	83 c0 04             	add    $0x4,%eax
80105e52:	83 ec 0c             	sub    $0xc,%esp
80105e55:	50                   	push   %eax
80105e56:	e8 54 01 00 00       	call   80105faf <acquire>
80105e5b:	83 c4 10             	add    $0x10,%esp
  while (lk->locked) {
80105e5e:	eb 15                	jmp    80105e75 <acquiresleep+0x2f>
    sleep(lk, &lk->lk);
80105e60:	8b 45 08             	mov    0x8(%ebp),%eax
80105e63:	83 c0 04             	add    $0x4,%eax
80105e66:	83 ec 08             	sub    $0x8,%esp
80105e69:	50                   	push   %eax
80105e6a:	ff 75 08             	push   0x8(%ebp)
80105e6d:	e8 b1 f4 ff ff       	call   80105323 <sleep>
80105e72:	83 c4 10             	add    $0x10,%esp
  while (lk->locked) {
80105e75:	8b 45 08             	mov    0x8(%ebp),%eax
80105e78:	8b 00                	mov    (%eax),%eax
80105e7a:	85 c0                	test   %eax,%eax
80105e7c:	75 e2                	jne    80105e60 <acquiresleep+0x1a>
  }
  lk->locked = 1;
80105e7e:	8b 45 08             	mov    0x8(%ebp),%eax
80105e81:	c7 00 01 00 00 00    	movl   $0x1,(%eax)
  lk->pid = myproc()->pid;
80105e87:	e8 8a e4 ff ff       	call   80104316 <myproc>
80105e8c:	8b 50 10             	mov    0x10(%eax),%edx
80105e8f:	8b 45 08             	mov    0x8(%ebp),%eax
80105e92:	89 50 3c             	mov    %edx,0x3c(%eax)
  release(&lk->lk);
80105e95:	8b 45 08             	mov    0x8(%ebp),%eax
80105e98:	83 c0 04             	add    $0x4,%eax
80105e9b:	83 ec 0c             	sub    $0xc,%esp
80105e9e:	50                   	push   %eax
80105e9f:	e8 79 01 00 00       	call   8010601d <release>
80105ea4:	83 c4 10             	add    $0x10,%esp
}
80105ea7:	90                   	nop
80105ea8:	c9                   	leave  
80105ea9:	c3                   	ret    

80105eaa <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
80105eaa:	55                   	push   %ebp
80105eab:	89 e5                	mov    %esp,%ebp
80105ead:	83 ec 08             	sub    $0x8,%esp
  acquire(&lk->lk);
80105eb0:	8b 45 08             	mov    0x8(%ebp),%eax
80105eb3:	83 c0 04             	add    $0x4,%eax
80105eb6:	83 ec 0c             	sub    $0xc,%esp
80105eb9:	50                   	push   %eax
80105eba:	e8 f0 00 00 00       	call   80105faf <acquire>
80105ebf:	83 c4 10             	add    $0x10,%esp
  lk->locked = 0;
80105ec2:	8b 45 08             	mov    0x8(%ebp),%eax
80105ec5:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->pid = 0;
80105ecb:	8b 45 08             	mov    0x8(%ebp),%eax
80105ece:	c7 40 3c 00 00 00 00 	movl   $0x0,0x3c(%eax)
  wakeup(lk);
80105ed5:	83 ec 0c             	sub    $0xc,%esp
80105ed8:	ff 75 08             	push   0x8(%ebp)
80105edb:	e8 c1 f5 ff ff       	call   801054a1 <wakeup>
80105ee0:	83 c4 10             	add    $0x10,%esp
  release(&lk->lk);
80105ee3:	8b 45 08             	mov    0x8(%ebp),%eax
80105ee6:	83 c0 04             	add    $0x4,%eax
80105ee9:	83 ec 0c             	sub    $0xc,%esp
80105eec:	50                   	push   %eax
80105eed:	e8 2b 01 00 00       	call   8010601d <release>
80105ef2:	83 c4 10             	add    $0x10,%esp
}
80105ef5:	90                   	nop
80105ef6:	c9                   	leave  
80105ef7:	c3                   	ret    

80105ef8 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
80105ef8:	55                   	push   %ebp
80105ef9:	89 e5                	mov    %esp,%ebp
80105efb:	53                   	push   %ebx
80105efc:	83 ec 14             	sub    $0x14,%esp
  int r;
  
  acquire(&lk->lk);
80105eff:	8b 45 08             	mov    0x8(%ebp),%eax
80105f02:	83 c0 04             	add    $0x4,%eax
80105f05:	83 ec 0c             	sub    $0xc,%esp
80105f08:	50                   	push   %eax
80105f09:	e8 a1 00 00 00       	call   80105faf <acquire>
80105f0e:	83 c4 10             	add    $0x10,%esp
  r = lk->locked && (lk->pid == myproc()->pid);
80105f11:	8b 45 08             	mov    0x8(%ebp),%eax
80105f14:	8b 00                	mov    (%eax),%eax
80105f16:	85 c0                	test   %eax,%eax
80105f18:	74 19                	je     80105f33 <holdingsleep+0x3b>
80105f1a:	8b 45 08             	mov    0x8(%ebp),%eax
80105f1d:	8b 58 3c             	mov    0x3c(%eax),%ebx
80105f20:	e8 f1 e3 ff ff       	call   80104316 <myproc>
80105f25:	8b 40 10             	mov    0x10(%eax),%eax
80105f28:	39 c3                	cmp    %eax,%ebx
80105f2a:	75 07                	jne    80105f33 <holdingsleep+0x3b>
80105f2c:	b8 01 00 00 00       	mov    $0x1,%eax
80105f31:	eb 05                	jmp    80105f38 <holdingsleep+0x40>
80105f33:	b8 00 00 00 00       	mov    $0x0,%eax
80105f38:	89 45 f4             	mov    %eax,-0xc(%ebp)
  release(&lk->lk);
80105f3b:	8b 45 08             	mov    0x8(%ebp),%eax
80105f3e:	83 c0 04             	add    $0x4,%eax
80105f41:	83 ec 0c             	sub    $0xc,%esp
80105f44:	50                   	push   %eax
80105f45:	e8 d3 00 00 00       	call   8010601d <release>
80105f4a:	83 c4 10             	add    $0x10,%esp
  return r;
80105f4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80105f50:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80105f53:	c9                   	leave  
80105f54:	c3                   	ret    

80105f55 <readeflags>:
{
80105f55:	55                   	push   %ebp
80105f56:	89 e5                	mov    %esp,%ebp
80105f58:	83 ec 10             	sub    $0x10,%esp
  asm volatile("pushfl; popl %0" : "=r" (eflags));
80105f5b:	9c                   	pushf  
80105f5c:	58                   	pop    %eax
80105f5d:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return eflags;
80105f60:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105f63:	c9                   	leave  
80105f64:	c3                   	ret    

80105f65 <cli>:
{
80105f65:	55                   	push   %ebp
80105f66:	89 e5                	mov    %esp,%ebp
  asm volatile("cli");
80105f68:	fa                   	cli    
}
80105f69:	90                   	nop
80105f6a:	5d                   	pop    %ebp
80105f6b:	c3                   	ret    

80105f6c <sti>:
{
80105f6c:	55                   	push   %ebp
80105f6d:	89 e5                	mov    %esp,%ebp
  asm volatile("sti");
80105f6f:	fb                   	sti    
}
80105f70:	90                   	nop
80105f71:	5d                   	pop    %ebp
80105f72:	c3                   	ret    

80105f73 <xchg>:
{
80105f73:	55                   	push   %ebp
80105f74:	89 e5                	mov    %esp,%ebp
80105f76:	83 ec 10             	sub    $0x10,%esp
  asm volatile("lock; xchgl %0, %1" :
80105f79:	8b 55 08             	mov    0x8(%ebp),%edx
80105f7c:	8b 45 0c             	mov    0xc(%ebp),%eax
80105f7f:	8b 4d 08             	mov    0x8(%ebp),%ecx
80105f82:	f0 87 02             	lock xchg %eax,(%edx)
80105f85:	89 45 fc             	mov    %eax,-0x4(%ebp)
  return result;
80105f88:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80105f8b:	c9                   	leave  
80105f8c:	c3                   	ret    

80105f8d <initlock>:
#include "proc.h"
#include "spinlock.h"

void
initlock(struct spinlock *lk, char *name)
{
80105f8d:	55                   	push   %ebp
80105f8e:	89 e5                	mov    %esp,%ebp
  lk->name = name;
80105f90:	8b 45 08             	mov    0x8(%ebp),%eax
80105f93:	8b 55 0c             	mov    0xc(%ebp),%edx
80105f96:	89 50 04             	mov    %edx,0x4(%eax)
  lk->locked = 0;
80105f99:	8b 45 08             	mov    0x8(%ebp),%eax
80105f9c:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  lk->cpu = 0;
80105fa2:	8b 45 08             	mov    0x8(%ebp),%eax
80105fa5:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
}
80105fac:	90                   	nop
80105fad:	5d                   	pop    %ebp
80105fae:	c3                   	ret    

80105faf <acquire>:
// Loops (spins) until the lock is acquired.
// Holding a lock for a long time may cause
// other CPUs to waste time spinning to acquire it.
void
acquire(struct spinlock *lk)
{
80105faf:	55                   	push   %ebp
80105fb0:	89 e5                	mov    %esp,%ebp
80105fb2:	53                   	push   %ebx
80105fb3:	83 ec 04             	sub    $0x4,%esp
  pushcli(); // disable interrupts to avoid deadlock.
80105fb6:	e8 6f 01 00 00       	call   8010612a <pushcli>
  if(holding(lk))
80105fbb:	8b 45 08             	mov    0x8(%ebp),%eax
80105fbe:	83 ec 0c             	sub    $0xc,%esp
80105fc1:	50                   	push   %eax
80105fc2:	e8 23 01 00 00       	call   801060ea <holding>
80105fc7:	83 c4 10             	add    $0x10,%esp
80105fca:	85 c0                	test   %eax,%eax
80105fcc:	74 0d                	je     80105fdb <acquire+0x2c>
    panic("acquire");
80105fce:	83 ec 0c             	sub    $0xc,%esp
80105fd1:	68 93 9a 10 80       	push   $0x80109a93
80105fd6:	e8 da a5 ff ff       	call   801005b5 <panic>

  // The xchg is atomic.
  while(xchg(&lk->locked, 1) != 0)
80105fdb:	90                   	nop
80105fdc:	8b 45 08             	mov    0x8(%ebp),%eax
80105fdf:	83 ec 08             	sub    $0x8,%esp
80105fe2:	6a 01                	push   $0x1
80105fe4:	50                   	push   %eax
80105fe5:	e8 89 ff ff ff       	call   80105f73 <xchg>
80105fea:	83 c4 10             	add    $0x10,%esp
80105fed:	85 c0                	test   %eax,%eax
80105fef:	75 eb                	jne    80105fdc <acquire+0x2d>
    ;

  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that the critical section's memory
  // references happen after the lock is acquired.
  __sync_synchronize();
80105ff1:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Record info about lock acquisition for debugging.
  lk->cpu = mycpu();
80105ff6:	8b 5d 08             	mov    0x8(%ebp),%ebx
80105ff9:	e8 a0 e2 ff ff       	call   8010429e <mycpu>
80105ffe:	89 43 08             	mov    %eax,0x8(%ebx)
  getcallerpcs(&lk, lk->pcs);
80106001:	8b 45 08             	mov    0x8(%ebp),%eax
80106004:	83 c0 0c             	add    $0xc,%eax
80106007:	83 ec 08             	sub    $0x8,%esp
8010600a:	50                   	push   %eax
8010600b:	8d 45 08             	lea    0x8(%ebp),%eax
8010600e:	50                   	push   %eax
8010600f:	e8 5b 00 00 00       	call   8010606f <getcallerpcs>
80106014:	83 c4 10             	add    $0x10,%esp
}
80106017:	90                   	nop
80106018:	8b 5d fc             	mov    -0x4(%ebp),%ebx
8010601b:	c9                   	leave  
8010601c:	c3                   	ret    

8010601d <release>:

// Release the lock.
void
release(struct spinlock *lk)
{
8010601d:	55                   	push   %ebp
8010601e:	89 e5                	mov    %esp,%ebp
80106020:	83 ec 08             	sub    $0x8,%esp
  if(!holding(lk))
80106023:	83 ec 0c             	sub    $0xc,%esp
80106026:	ff 75 08             	push   0x8(%ebp)
80106029:	e8 bc 00 00 00       	call   801060ea <holding>
8010602e:	83 c4 10             	add    $0x10,%esp
80106031:	85 c0                	test   %eax,%eax
80106033:	75 0d                	jne    80106042 <release+0x25>
    panic("release");
80106035:	83 ec 0c             	sub    $0xc,%esp
80106038:	68 9b 9a 10 80       	push   $0x80109a9b
8010603d:	e8 73 a5 ff ff       	call   801005b5 <panic>

  lk->pcs[0] = 0;
80106042:	8b 45 08             	mov    0x8(%ebp),%eax
80106045:	c7 40 0c 00 00 00 00 	movl   $0x0,0xc(%eax)
  lk->cpu = 0;
8010604c:	8b 45 08             	mov    0x8(%ebp),%eax
8010604f:	c7 40 08 00 00 00 00 	movl   $0x0,0x8(%eax)
  // Tell the C compiler and the processor to not move loads or stores
  // past this point, to ensure that all the stores in the critical
  // section are visible to other cores before the lock is released.
  // Both the C compiler and the hardware may re-order loads and
  // stores; __sync_synchronize() tells them both not to.
  __sync_synchronize();
80106056:	f0 83 0c 24 00       	lock orl $0x0,(%esp)

  // Release the lock, equivalent to lk->locked = 0.
  // This code can't use a C assignment, since it might
  // not be atomic. A real OS would use C atomics here.
  asm volatile("movl $0, %0" : "+m" (lk->locked) : );
8010605b:	8b 45 08             	mov    0x8(%ebp),%eax
8010605e:	8b 55 08             	mov    0x8(%ebp),%edx
80106061:	c7 00 00 00 00 00    	movl   $0x0,(%eax)

  popcli();
80106067:	e8 0b 01 00 00       	call   80106177 <popcli>
}
8010606c:	90                   	nop
8010606d:	c9                   	leave  
8010606e:	c3                   	ret    

8010606f <getcallerpcs>:

// Record the current call stack in pcs[] by following the %ebp chain.
void
getcallerpcs(void *v, uint pcs[])
{
8010606f:	55                   	push   %ebp
80106070:	89 e5                	mov    %esp,%ebp
80106072:	83 ec 10             	sub    $0x10,%esp
  uint *ebp;
  int i;

  ebp = (uint*)v - 2;
80106075:	8b 45 08             	mov    0x8(%ebp),%eax
80106078:	83 e8 08             	sub    $0x8,%eax
8010607b:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
8010607e:	c7 45 f8 00 00 00 00 	movl   $0x0,-0x8(%ebp)
80106085:	eb 38                	jmp    801060bf <getcallerpcs+0x50>
    if(ebp == 0 || ebp < (uint*)KERNBASE || ebp == (uint*)0xffffffff)
80106087:	83 7d fc 00          	cmpl   $0x0,-0x4(%ebp)
8010608b:	74 53                	je     801060e0 <getcallerpcs+0x71>
8010608d:	81 7d fc ff ff ff 7f 	cmpl   $0x7fffffff,-0x4(%ebp)
80106094:	76 4a                	jbe    801060e0 <getcallerpcs+0x71>
80106096:	83 7d fc ff          	cmpl   $0xffffffff,-0x4(%ebp)
8010609a:	74 44                	je     801060e0 <getcallerpcs+0x71>
      break;
    pcs[i] = ebp[1];     // saved %eip
8010609c:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010609f:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801060a6:	8b 45 0c             	mov    0xc(%ebp),%eax
801060a9:	01 c2                	add    %eax,%edx
801060ab:	8b 45 fc             	mov    -0x4(%ebp),%eax
801060ae:	8b 40 04             	mov    0x4(%eax),%eax
801060b1:	89 02                	mov    %eax,(%edx)
    ebp = (uint*)ebp[0]; // saved %ebp
801060b3:	8b 45 fc             	mov    -0x4(%ebp),%eax
801060b6:	8b 00                	mov    (%eax),%eax
801060b8:	89 45 fc             	mov    %eax,-0x4(%ebp)
  for(i = 0; i < 10; i++){
801060bb:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
801060bf:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
801060c3:	7e c2                	jle    80106087 <getcallerpcs+0x18>
  }
  for(; i < 10; i++)
801060c5:	eb 19                	jmp    801060e0 <getcallerpcs+0x71>
    pcs[i] = 0;
801060c7:	8b 45 f8             	mov    -0x8(%ebp),%eax
801060ca:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801060d1:	8b 45 0c             	mov    0xc(%ebp),%eax
801060d4:	01 d0                	add    %edx,%eax
801060d6:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
  for(; i < 10; i++)
801060dc:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
801060e0:	83 7d f8 09          	cmpl   $0x9,-0x8(%ebp)
801060e4:	7e e1                	jle    801060c7 <getcallerpcs+0x58>
}
801060e6:	90                   	nop
801060e7:	90                   	nop
801060e8:	c9                   	leave  
801060e9:	c3                   	ret    

801060ea <holding>:

// Check whether this cpu is holding the lock.
int
holding(struct spinlock *lock)
{
801060ea:	55                   	push   %ebp
801060eb:	89 e5                	mov    %esp,%ebp
801060ed:	53                   	push   %ebx
801060ee:	83 ec 14             	sub    $0x14,%esp
  int r;
  pushcli();
801060f1:	e8 34 00 00 00       	call   8010612a <pushcli>
  r = lock->locked && lock->cpu == mycpu();
801060f6:	8b 45 08             	mov    0x8(%ebp),%eax
801060f9:	8b 00                	mov    (%eax),%eax
801060fb:	85 c0                	test   %eax,%eax
801060fd:	74 16                	je     80106115 <holding+0x2b>
801060ff:	8b 45 08             	mov    0x8(%ebp),%eax
80106102:	8b 58 08             	mov    0x8(%eax),%ebx
80106105:	e8 94 e1 ff ff       	call   8010429e <mycpu>
8010610a:	39 c3                	cmp    %eax,%ebx
8010610c:	75 07                	jne    80106115 <holding+0x2b>
8010610e:	b8 01 00 00 00       	mov    $0x1,%eax
80106113:	eb 05                	jmp    8010611a <holding+0x30>
80106115:	b8 00 00 00 00       	mov    $0x0,%eax
8010611a:	89 45 f4             	mov    %eax,-0xc(%ebp)
  popcli();
8010611d:	e8 55 00 00 00       	call   80106177 <popcli>
  return r;
80106122:	8b 45 f4             	mov    -0xc(%ebp),%eax
}
80106125:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80106128:	c9                   	leave  
80106129:	c3                   	ret    

8010612a <pushcli>:
// it takes two popcli to undo two pushcli.  Also, if interrupts
// are off, then pushcli, popcli leaves them off.

void
pushcli(void)
{
8010612a:	55                   	push   %ebp
8010612b:	89 e5                	mov    %esp,%ebp
8010612d:	83 ec 18             	sub    $0x18,%esp
  int eflags;

  eflags = readeflags();
80106130:	e8 20 fe ff ff       	call   80105f55 <readeflags>
80106135:	89 45 f4             	mov    %eax,-0xc(%ebp)
  cli();
80106138:	e8 28 fe ff ff       	call   80105f65 <cli>
  if(mycpu()->ncli == 0)
8010613d:	e8 5c e1 ff ff       	call   8010429e <mycpu>
80106142:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
80106148:	85 c0                	test   %eax,%eax
8010614a:	75 14                	jne    80106160 <pushcli+0x36>
    mycpu()->intena = eflags & FL_IF;
8010614c:	e8 4d e1 ff ff       	call   8010429e <mycpu>
80106151:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106154:	81 e2 00 02 00 00    	and    $0x200,%edx
8010615a:	89 90 a8 00 00 00    	mov    %edx,0xa8(%eax)
  mycpu()->ncli += 1;
80106160:	e8 39 e1 ff ff       	call   8010429e <mycpu>
80106165:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
8010616b:	83 c2 01             	add    $0x1,%edx
8010616e:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
}
80106174:	90                   	nop
80106175:	c9                   	leave  
80106176:	c3                   	ret    

80106177 <popcli>:

void
popcli(void)
{
80106177:	55                   	push   %ebp
80106178:	89 e5                	mov    %esp,%ebp
8010617a:	83 ec 08             	sub    $0x8,%esp
  if(readeflags()&FL_IF)
8010617d:	e8 d3 fd ff ff       	call   80105f55 <readeflags>
80106182:	25 00 02 00 00       	and    $0x200,%eax
80106187:	85 c0                	test   %eax,%eax
80106189:	74 0d                	je     80106198 <popcli+0x21>
    panic("popcli - interruptible");
8010618b:	83 ec 0c             	sub    $0xc,%esp
8010618e:	68 a3 9a 10 80       	push   $0x80109aa3
80106193:	e8 1d a4 ff ff       	call   801005b5 <panic>
  if(--mycpu()->ncli < 0)
80106198:	e8 01 e1 ff ff       	call   8010429e <mycpu>
8010619d:	8b 90 a4 00 00 00    	mov    0xa4(%eax),%edx
801061a3:	83 ea 01             	sub    $0x1,%edx
801061a6:	89 90 a4 00 00 00    	mov    %edx,0xa4(%eax)
801061ac:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801061b2:	85 c0                	test   %eax,%eax
801061b4:	79 0d                	jns    801061c3 <popcli+0x4c>
    panic("popcli");
801061b6:	83 ec 0c             	sub    $0xc,%esp
801061b9:	68 ba 9a 10 80       	push   $0x80109aba
801061be:	e8 f2 a3 ff ff       	call   801005b5 <panic>
  if(mycpu()->ncli == 0 && mycpu()->intena)
801061c3:	e8 d6 e0 ff ff       	call   8010429e <mycpu>
801061c8:	8b 80 a4 00 00 00    	mov    0xa4(%eax),%eax
801061ce:	85 c0                	test   %eax,%eax
801061d0:	75 14                	jne    801061e6 <popcli+0x6f>
801061d2:	e8 c7 e0 ff ff       	call   8010429e <mycpu>
801061d7:	8b 80 a8 00 00 00    	mov    0xa8(%eax),%eax
801061dd:	85 c0                	test   %eax,%eax
801061df:	74 05                	je     801061e6 <popcli+0x6f>
    sti();
801061e1:	e8 86 fd ff ff       	call   80105f6c <sti>
}
801061e6:	90                   	nop
801061e7:	c9                   	leave  
801061e8:	c3                   	ret    

801061e9 <stosb>:
{
801061e9:	55                   	push   %ebp
801061ea:	89 e5                	mov    %esp,%ebp
801061ec:	57                   	push   %edi
801061ed:	53                   	push   %ebx
  asm volatile("cld; rep stosb" :
801061ee:	8b 4d 08             	mov    0x8(%ebp),%ecx
801061f1:	8b 55 10             	mov    0x10(%ebp),%edx
801061f4:	8b 45 0c             	mov    0xc(%ebp),%eax
801061f7:	89 cb                	mov    %ecx,%ebx
801061f9:	89 df                	mov    %ebx,%edi
801061fb:	89 d1                	mov    %edx,%ecx
801061fd:	fc                   	cld    
801061fe:	f3 aa                	rep stos %al,%es:(%edi)
80106200:	89 ca                	mov    %ecx,%edx
80106202:	89 fb                	mov    %edi,%ebx
80106204:	89 5d 08             	mov    %ebx,0x8(%ebp)
80106207:	89 55 10             	mov    %edx,0x10(%ebp)
}
8010620a:	90                   	nop
8010620b:	5b                   	pop    %ebx
8010620c:	5f                   	pop    %edi
8010620d:	5d                   	pop    %ebp
8010620e:	c3                   	ret    

8010620f <stosl>:
{
8010620f:	55                   	push   %ebp
80106210:	89 e5                	mov    %esp,%ebp
80106212:	57                   	push   %edi
80106213:	53                   	push   %ebx
  asm volatile("cld; rep stosl" :
80106214:	8b 4d 08             	mov    0x8(%ebp),%ecx
80106217:	8b 55 10             	mov    0x10(%ebp),%edx
8010621a:	8b 45 0c             	mov    0xc(%ebp),%eax
8010621d:	89 cb                	mov    %ecx,%ebx
8010621f:	89 df                	mov    %ebx,%edi
80106221:	89 d1                	mov    %edx,%ecx
80106223:	fc                   	cld    
80106224:	f3 ab                	rep stos %eax,%es:(%edi)
80106226:	89 ca                	mov    %ecx,%edx
80106228:	89 fb                	mov    %edi,%ebx
8010622a:	89 5d 08             	mov    %ebx,0x8(%ebp)
8010622d:	89 55 10             	mov    %edx,0x10(%ebp)
}
80106230:	90                   	nop
80106231:	5b                   	pop    %ebx
80106232:	5f                   	pop    %edi
80106233:	5d                   	pop    %ebp
80106234:	c3                   	ret    

80106235 <memset>:
#include "types.h"
#include "x86.h"

void*
memset(void *dst, int c, uint n)
{
80106235:	55                   	push   %ebp
80106236:	89 e5                	mov    %esp,%ebp
  if ((int)dst%4 == 0 && n%4 == 0){
80106238:	8b 45 08             	mov    0x8(%ebp),%eax
8010623b:	83 e0 03             	and    $0x3,%eax
8010623e:	85 c0                	test   %eax,%eax
80106240:	75 43                	jne    80106285 <memset+0x50>
80106242:	8b 45 10             	mov    0x10(%ebp),%eax
80106245:	83 e0 03             	and    $0x3,%eax
80106248:	85 c0                	test   %eax,%eax
8010624a:	75 39                	jne    80106285 <memset+0x50>
    c &= 0xFF;
8010624c:	81 65 0c ff 00 00 00 	andl   $0xff,0xc(%ebp)
    stosl(dst, (c<<24)|(c<<16)|(c<<8)|c, n/4);
80106253:	8b 45 10             	mov    0x10(%ebp),%eax
80106256:	c1 e8 02             	shr    $0x2,%eax
80106259:	89 c2                	mov    %eax,%edx
8010625b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010625e:	c1 e0 18             	shl    $0x18,%eax
80106261:	89 c1                	mov    %eax,%ecx
80106263:	8b 45 0c             	mov    0xc(%ebp),%eax
80106266:	c1 e0 10             	shl    $0x10,%eax
80106269:	09 c1                	or     %eax,%ecx
8010626b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010626e:	c1 e0 08             	shl    $0x8,%eax
80106271:	09 c8                	or     %ecx,%eax
80106273:	0b 45 0c             	or     0xc(%ebp),%eax
80106276:	52                   	push   %edx
80106277:	50                   	push   %eax
80106278:	ff 75 08             	push   0x8(%ebp)
8010627b:	e8 8f ff ff ff       	call   8010620f <stosl>
80106280:	83 c4 0c             	add    $0xc,%esp
80106283:	eb 12                	jmp    80106297 <memset+0x62>
  } else
    stosb(dst, c, n);
80106285:	8b 45 10             	mov    0x10(%ebp),%eax
80106288:	50                   	push   %eax
80106289:	ff 75 0c             	push   0xc(%ebp)
8010628c:	ff 75 08             	push   0x8(%ebp)
8010628f:	e8 55 ff ff ff       	call   801061e9 <stosb>
80106294:	83 c4 0c             	add    $0xc,%esp
  return dst;
80106297:	8b 45 08             	mov    0x8(%ebp),%eax
}
8010629a:	c9                   	leave  
8010629b:	c3                   	ret    

8010629c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
8010629c:	55                   	push   %ebp
8010629d:	89 e5                	mov    %esp,%ebp
8010629f:	83 ec 10             	sub    $0x10,%esp
  const uchar *s1, *s2;

  s1 = v1;
801062a2:	8b 45 08             	mov    0x8(%ebp),%eax
801062a5:	89 45 fc             	mov    %eax,-0x4(%ebp)
  s2 = v2;
801062a8:	8b 45 0c             	mov    0xc(%ebp),%eax
801062ab:	89 45 f8             	mov    %eax,-0x8(%ebp)
  while(n-- > 0){
801062ae:	eb 30                	jmp    801062e0 <memcmp+0x44>
    if(*s1 != *s2)
801062b0:	8b 45 fc             	mov    -0x4(%ebp),%eax
801062b3:	0f b6 10             	movzbl (%eax),%edx
801062b6:	8b 45 f8             	mov    -0x8(%ebp),%eax
801062b9:	0f b6 00             	movzbl (%eax),%eax
801062bc:	38 c2                	cmp    %al,%dl
801062be:	74 18                	je     801062d8 <memcmp+0x3c>
      return *s1 - *s2;
801062c0:	8b 45 fc             	mov    -0x4(%ebp),%eax
801062c3:	0f b6 00             	movzbl (%eax),%eax
801062c6:	0f b6 d0             	movzbl %al,%edx
801062c9:	8b 45 f8             	mov    -0x8(%ebp),%eax
801062cc:	0f b6 00             	movzbl (%eax),%eax
801062cf:	0f b6 c8             	movzbl %al,%ecx
801062d2:	89 d0                	mov    %edx,%eax
801062d4:	29 c8                	sub    %ecx,%eax
801062d6:	eb 1a                	jmp    801062f2 <memcmp+0x56>
    s1++, s2++;
801062d8:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
801062dc:	83 45 f8 01          	addl   $0x1,-0x8(%ebp)
  while(n-- > 0){
801062e0:	8b 45 10             	mov    0x10(%ebp),%eax
801062e3:	8d 50 ff             	lea    -0x1(%eax),%edx
801062e6:	89 55 10             	mov    %edx,0x10(%ebp)
801062e9:	85 c0                	test   %eax,%eax
801062eb:	75 c3                	jne    801062b0 <memcmp+0x14>
  }

  return 0;
801062ed:	b8 00 00 00 00       	mov    $0x0,%eax
}
801062f2:	c9                   	leave  
801062f3:	c3                   	ret    

801062f4 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
801062f4:	55                   	push   %ebp
801062f5:	89 e5                	mov    %esp,%ebp
801062f7:	83 ec 10             	sub    $0x10,%esp
  const char *s;
  char *d;

  s = src;
801062fa:	8b 45 0c             	mov    0xc(%ebp),%eax
801062fd:	89 45 fc             	mov    %eax,-0x4(%ebp)
  d = dst;
80106300:	8b 45 08             	mov    0x8(%ebp),%eax
80106303:	89 45 f8             	mov    %eax,-0x8(%ebp)
  if(s < d && s + n > d){
80106306:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106309:	3b 45 f8             	cmp    -0x8(%ebp),%eax
8010630c:	73 54                	jae    80106362 <memmove+0x6e>
8010630e:	8b 55 fc             	mov    -0x4(%ebp),%edx
80106311:	8b 45 10             	mov    0x10(%ebp),%eax
80106314:	01 d0                	add    %edx,%eax
80106316:	39 45 f8             	cmp    %eax,-0x8(%ebp)
80106319:	73 47                	jae    80106362 <memmove+0x6e>
    s += n;
8010631b:	8b 45 10             	mov    0x10(%ebp),%eax
8010631e:	01 45 fc             	add    %eax,-0x4(%ebp)
    d += n;
80106321:	8b 45 10             	mov    0x10(%ebp),%eax
80106324:	01 45 f8             	add    %eax,-0x8(%ebp)
    while(n-- > 0)
80106327:	eb 13                	jmp    8010633c <memmove+0x48>
      *--d = *--s;
80106329:	83 6d fc 01          	subl   $0x1,-0x4(%ebp)
8010632d:	83 6d f8 01          	subl   $0x1,-0x8(%ebp)
80106331:	8b 45 fc             	mov    -0x4(%ebp),%eax
80106334:	0f b6 10             	movzbl (%eax),%edx
80106337:	8b 45 f8             	mov    -0x8(%ebp),%eax
8010633a:	88 10                	mov    %dl,(%eax)
    while(n-- > 0)
8010633c:	8b 45 10             	mov    0x10(%ebp),%eax
8010633f:	8d 50 ff             	lea    -0x1(%eax),%edx
80106342:	89 55 10             	mov    %edx,0x10(%ebp)
80106345:	85 c0                	test   %eax,%eax
80106347:	75 e0                	jne    80106329 <memmove+0x35>
  if(s < d && s + n > d){
80106349:	eb 24                	jmp    8010636f <memmove+0x7b>
  } else
    while(n-- > 0)
      *d++ = *s++;
8010634b:	8b 55 fc             	mov    -0x4(%ebp),%edx
8010634e:	8d 42 01             	lea    0x1(%edx),%eax
80106351:	89 45 fc             	mov    %eax,-0x4(%ebp)
80106354:	8b 45 f8             	mov    -0x8(%ebp),%eax
80106357:	8d 48 01             	lea    0x1(%eax),%ecx
8010635a:	89 4d f8             	mov    %ecx,-0x8(%ebp)
8010635d:	0f b6 12             	movzbl (%edx),%edx
80106360:	88 10                	mov    %dl,(%eax)
    while(n-- > 0)
80106362:	8b 45 10             	mov    0x10(%ebp),%eax
80106365:	8d 50 ff             	lea    -0x1(%eax),%edx
80106368:	89 55 10             	mov    %edx,0x10(%ebp)
8010636b:	85 c0                	test   %eax,%eax
8010636d:	75 dc                	jne    8010634b <memmove+0x57>

  return dst;
8010636f:	8b 45 08             	mov    0x8(%ebp),%eax
}
80106372:	c9                   	leave  
80106373:	c3                   	ret    

80106374 <memcpy>:

// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
80106374:	55                   	push   %ebp
80106375:	89 e5                	mov    %esp,%ebp
  return memmove(dst, src, n);
80106377:	ff 75 10             	push   0x10(%ebp)
8010637a:	ff 75 0c             	push   0xc(%ebp)
8010637d:	ff 75 08             	push   0x8(%ebp)
80106380:	e8 6f ff ff ff       	call   801062f4 <memmove>
80106385:	83 c4 0c             	add    $0xc,%esp
}
80106388:	c9                   	leave  
80106389:	c3                   	ret    

8010638a <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
8010638a:	55                   	push   %ebp
8010638b:	89 e5                	mov    %esp,%ebp
  while(n > 0 && *p && *p == *q)
8010638d:	eb 0c                	jmp    8010639b <strncmp+0x11>
    n--, p++, q++;
8010638f:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80106393:	83 45 08 01          	addl   $0x1,0x8(%ebp)
80106397:	83 45 0c 01          	addl   $0x1,0xc(%ebp)
  while(n > 0 && *p && *p == *q)
8010639b:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010639f:	74 1a                	je     801063bb <strncmp+0x31>
801063a1:	8b 45 08             	mov    0x8(%ebp),%eax
801063a4:	0f b6 00             	movzbl (%eax),%eax
801063a7:	84 c0                	test   %al,%al
801063a9:	74 10                	je     801063bb <strncmp+0x31>
801063ab:	8b 45 08             	mov    0x8(%ebp),%eax
801063ae:	0f b6 10             	movzbl (%eax),%edx
801063b1:	8b 45 0c             	mov    0xc(%ebp),%eax
801063b4:	0f b6 00             	movzbl (%eax),%eax
801063b7:	38 c2                	cmp    %al,%dl
801063b9:	74 d4                	je     8010638f <strncmp+0x5>
  if(n == 0)
801063bb:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801063bf:	75 07                	jne    801063c8 <strncmp+0x3e>
    return 0;
801063c1:	b8 00 00 00 00       	mov    $0x0,%eax
801063c6:	eb 16                	jmp    801063de <strncmp+0x54>
  return (uchar)*p - (uchar)*q;
801063c8:	8b 45 08             	mov    0x8(%ebp),%eax
801063cb:	0f b6 00             	movzbl (%eax),%eax
801063ce:	0f b6 d0             	movzbl %al,%edx
801063d1:	8b 45 0c             	mov    0xc(%ebp),%eax
801063d4:	0f b6 00             	movzbl (%eax),%eax
801063d7:	0f b6 c8             	movzbl %al,%ecx
801063da:	89 d0                	mov    %edx,%eax
801063dc:	29 c8                	sub    %ecx,%eax
}
801063de:	5d                   	pop    %ebp
801063df:	c3                   	ret    

801063e0 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
801063e0:	55                   	push   %ebp
801063e1:	89 e5                	mov    %esp,%ebp
801063e3:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
801063e6:	8b 45 08             	mov    0x8(%ebp),%eax
801063e9:	89 45 fc             	mov    %eax,-0x4(%ebp)
  while(n-- > 0 && (*s++ = *t++) != 0)
801063ec:	90                   	nop
801063ed:	8b 45 10             	mov    0x10(%ebp),%eax
801063f0:	8d 50 ff             	lea    -0x1(%eax),%edx
801063f3:	89 55 10             	mov    %edx,0x10(%ebp)
801063f6:	85 c0                	test   %eax,%eax
801063f8:	7e 2c                	jle    80106426 <strncpy+0x46>
801063fa:	8b 55 0c             	mov    0xc(%ebp),%edx
801063fd:	8d 42 01             	lea    0x1(%edx),%eax
80106400:	89 45 0c             	mov    %eax,0xc(%ebp)
80106403:	8b 45 08             	mov    0x8(%ebp),%eax
80106406:	8d 48 01             	lea    0x1(%eax),%ecx
80106409:	89 4d 08             	mov    %ecx,0x8(%ebp)
8010640c:	0f b6 12             	movzbl (%edx),%edx
8010640f:	88 10                	mov    %dl,(%eax)
80106411:	0f b6 00             	movzbl (%eax),%eax
80106414:	84 c0                	test   %al,%al
80106416:	75 d5                	jne    801063ed <strncpy+0xd>
    ;
  while(n-- > 0)
80106418:	eb 0c                	jmp    80106426 <strncpy+0x46>
    *s++ = 0;
8010641a:	8b 45 08             	mov    0x8(%ebp),%eax
8010641d:	8d 50 01             	lea    0x1(%eax),%edx
80106420:	89 55 08             	mov    %edx,0x8(%ebp)
80106423:	c6 00 00             	movb   $0x0,(%eax)
  while(n-- > 0)
80106426:	8b 45 10             	mov    0x10(%ebp),%eax
80106429:	8d 50 ff             	lea    -0x1(%eax),%edx
8010642c:	89 55 10             	mov    %edx,0x10(%ebp)
8010642f:	85 c0                	test   %eax,%eax
80106431:	7f e7                	jg     8010641a <strncpy+0x3a>
  return os;
80106433:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80106436:	c9                   	leave  
80106437:	c3                   	ret    

80106438 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
80106438:	55                   	push   %ebp
80106439:	89 e5                	mov    %esp,%ebp
8010643b:	83 ec 10             	sub    $0x10,%esp
  char *os;

  os = s;
8010643e:	8b 45 08             	mov    0x8(%ebp),%eax
80106441:	89 45 fc             	mov    %eax,-0x4(%ebp)
  if(n <= 0)
80106444:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80106448:	7f 05                	jg     8010644f <safestrcpy+0x17>
    return os;
8010644a:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010644d:	eb 32                	jmp    80106481 <safestrcpy+0x49>
  while(--n > 0 && (*s++ = *t++) != 0)
8010644f:	90                   	nop
80106450:	83 6d 10 01          	subl   $0x1,0x10(%ebp)
80106454:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80106458:	7e 1e                	jle    80106478 <safestrcpy+0x40>
8010645a:	8b 55 0c             	mov    0xc(%ebp),%edx
8010645d:	8d 42 01             	lea    0x1(%edx),%eax
80106460:	89 45 0c             	mov    %eax,0xc(%ebp)
80106463:	8b 45 08             	mov    0x8(%ebp),%eax
80106466:	8d 48 01             	lea    0x1(%eax),%ecx
80106469:	89 4d 08             	mov    %ecx,0x8(%ebp)
8010646c:	0f b6 12             	movzbl (%edx),%edx
8010646f:	88 10                	mov    %dl,(%eax)
80106471:	0f b6 00             	movzbl (%eax),%eax
80106474:	84 c0                	test   %al,%al
80106476:	75 d8                	jne    80106450 <safestrcpy+0x18>
    ;
  *s = 0;
80106478:	8b 45 08             	mov    0x8(%ebp),%eax
8010647b:	c6 00 00             	movb   $0x0,(%eax)
  return os;
8010647e:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
80106481:	c9                   	leave  
80106482:	c3                   	ret    

80106483 <strlen>:

int
strlen(const char *s)
{
80106483:	55                   	push   %ebp
80106484:	89 e5                	mov    %esp,%ebp
80106486:	83 ec 10             	sub    $0x10,%esp
  int n;

  for(n = 0; s[n]; n++)
80106489:	c7 45 fc 00 00 00 00 	movl   $0x0,-0x4(%ebp)
80106490:	eb 04                	jmp    80106496 <strlen+0x13>
80106492:	83 45 fc 01          	addl   $0x1,-0x4(%ebp)
80106496:	8b 55 fc             	mov    -0x4(%ebp),%edx
80106499:	8b 45 08             	mov    0x8(%ebp),%eax
8010649c:	01 d0                	add    %edx,%eax
8010649e:	0f b6 00             	movzbl (%eax),%eax
801064a1:	84 c0                	test   %al,%al
801064a3:	75 ed                	jne    80106492 <strlen+0xf>
    ;
  return n;
801064a5:	8b 45 fc             	mov    -0x4(%ebp),%eax
}
801064a8:	c9                   	leave  
801064a9:	c3                   	ret    

801064aa <swtch>:
801064aa:	8b 44 24 04          	mov    0x4(%esp),%eax
801064ae:	8b 54 24 08          	mov    0x8(%esp),%edx
801064b2:	55                   	push   %ebp
801064b3:	53                   	push   %ebx
801064b4:	56                   	push   %esi
801064b5:	57                   	push   %edi
801064b6:	89 20                	mov    %esp,(%eax)
801064b8:	89 d4                	mov    %edx,%esp
801064ba:	5f                   	pop    %edi
801064bb:	5e                   	pop    %esi
801064bc:	5b                   	pop    %ebx
801064bd:	5d                   	pop    %ebp
801064be:	c3                   	ret    

801064bf <fetchint>:
801064bf:	55                   	push   %ebp
801064c0:	89 e5                	mov    %esp,%ebp
801064c2:	83 ec 18             	sub    $0x18,%esp
801064c5:	e8 4c de ff ff       	call   80104316 <myproc>
801064ca:	89 45 f4             	mov    %eax,-0xc(%ebp)
801064cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064d0:	8b 00                	mov    (%eax),%eax
801064d2:	39 45 08             	cmp    %eax,0x8(%ebp)
801064d5:	73 0f                	jae    801064e6 <fetchint+0x27>
801064d7:	8b 45 08             	mov    0x8(%ebp),%eax
801064da:	8d 50 04             	lea    0x4(%eax),%edx
801064dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801064e0:	8b 00                	mov    (%eax),%eax
801064e2:	39 c2                	cmp    %eax,%edx
801064e4:	76 07                	jbe    801064ed <fetchint+0x2e>
801064e6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801064eb:	eb 0f                	jmp    801064fc <fetchint+0x3d>
801064ed:	8b 45 08             	mov    0x8(%ebp),%eax
801064f0:	8b 10                	mov    (%eax),%edx
801064f2:	8b 45 0c             	mov    0xc(%ebp),%eax
801064f5:	89 10                	mov    %edx,(%eax)
801064f7:	b8 00 00 00 00       	mov    $0x0,%eax
801064fc:	c9                   	leave  
801064fd:	c3                   	ret    

801064fe <fetchstr>:
801064fe:	55                   	push   %ebp
801064ff:	89 e5                	mov    %esp,%ebp
80106501:	83 ec 18             	sub    $0x18,%esp
80106504:	e8 0d de ff ff       	call   80104316 <myproc>
80106509:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010650c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010650f:	8b 00                	mov    (%eax),%eax
80106511:	39 45 08             	cmp    %eax,0x8(%ebp)
80106514:	72 07                	jb     8010651d <fetchstr+0x1f>
80106516:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010651b:	eb 41                	jmp    8010655e <fetchstr+0x60>
8010651d:	8b 55 08             	mov    0x8(%ebp),%edx
80106520:	8b 45 0c             	mov    0xc(%ebp),%eax
80106523:	89 10                	mov    %edx,(%eax)
80106525:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106528:	8b 00                	mov    (%eax),%eax
8010652a:	89 45 ec             	mov    %eax,-0x14(%ebp)
8010652d:	8b 45 0c             	mov    0xc(%ebp),%eax
80106530:	8b 00                	mov    (%eax),%eax
80106532:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106535:	eb 1a                	jmp    80106551 <fetchstr+0x53>
80106537:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010653a:	0f b6 00             	movzbl (%eax),%eax
8010653d:	84 c0                	test   %al,%al
8010653f:	75 0c                	jne    8010654d <fetchstr+0x4f>
80106541:	8b 45 0c             	mov    0xc(%ebp),%eax
80106544:	8b 10                	mov    (%eax),%edx
80106546:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106549:	29 d0                	sub    %edx,%eax
8010654b:	eb 11                	jmp    8010655e <fetchstr+0x60>
8010654d:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80106551:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106554:	3b 45 ec             	cmp    -0x14(%ebp),%eax
80106557:	72 de                	jb     80106537 <fetchstr+0x39>
80106559:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010655e:	c9                   	leave  
8010655f:	c3                   	ret    

80106560 <argint>:
80106560:	55                   	push   %ebp
80106561:	89 e5                	mov    %esp,%ebp
80106563:	83 ec 08             	sub    $0x8,%esp
80106566:	e8 ab dd ff ff       	call   80104316 <myproc>
8010656b:	8b 40 18             	mov    0x18(%eax),%eax
8010656e:	8b 50 44             	mov    0x44(%eax),%edx
80106571:	8b 45 08             	mov    0x8(%ebp),%eax
80106574:	c1 e0 02             	shl    $0x2,%eax
80106577:	01 d0                	add    %edx,%eax
80106579:	83 c0 04             	add    $0x4,%eax
8010657c:	83 ec 08             	sub    $0x8,%esp
8010657f:	ff 75 0c             	push   0xc(%ebp)
80106582:	50                   	push   %eax
80106583:	e8 37 ff ff ff       	call   801064bf <fetchint>
80106588:	83 c4 10             	add    $0x10,%esp
8010658b:	c9                   	leave  
8010658c:	c3                   	ret    

8010658d <argptr>:
8010658d:	55                   	push   %ebp
8010658e:	89 e5                	mov    %esp,%ebp
80106590:	83 ec 18             	sub    $0x18,%esp
80106593:	e8 7e dd ff ff       	call   80104316 <myproc>
80106598:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010659b:	83 ec 08             	sub    $0x8,%esp
8010659e:	8d 45 f0             	lea    -0x10(%ebp),%eax
801065a1:	50                   	push   %eax
801065a2:	ff 75 08             	push   0x8(%ebp)
801065a5:	e8 b6 ff ff ff       	call   80106560 <argint>
801065aa:	83 c4 10             	add    $0x10,%esp
801065ad:	85 c0                	test   %eax,%eax
801065af:	79 07                	jns    801065b8 <argptr+0x2b>
801065b1:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065b6:	eb 3b                	jmp    801065f3 <argptr+0x66>
801065b8:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
801065bc:	78 1f                	js     801065dd <argptr+0x50>
801065be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065c1:	8b 00                	mov    (%eax),%eax
801065c3:	8b 55 f0             	mov    -0x10(%ebp),%edx
801065c6:	39 d0                	cmp    %edx,%eax
801065c8:	76 13                	jbe    801065dd <argptr+0x50>
801065ca:	8b 45 f0             	mov    -0x10(%ebp),%eax
801065cd:	89 c2                	mov    %eax,%edx
801065cf:	8b 45 10             	mov    0x10(%ebp),%eax
801065d2:	01 c2                	add    %eax,%edx
801065d4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801065d7:	8b 00                	mov    (%eax),%eax
801065d9:	39 c2                	cmp    %eax,%edx
801065db:	76 07                	jbe    801065e4 <argptr+0x57>
801065dd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801065e2:	eb 0f                	jmp    801065f3 <argptr+0x66>
801065e4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801065e7:	89 c2                	mov    %eax,%edx
801065e9:	8b 45 0c             	mov    0xc(%ebp),%eax
801065ec:	89 10                	mov    %edx,(%eax)
801065ee:	b8 00 00 00 00       	mov    $0x0,%eax
801065f3:	c9                   	leave  
801065f4:	c3                   	ret    

801065f5 <argstr>:
801065f5:	55                   	push   %ebp
801065f6:	89 e5                	mov    %esp,%ebp
801065f8:	83 ec 18             	sub    $0x18,%esp
801065fb:	83 ec 08             	sub    $0x8,%esp
801065fe:	8d 45 f4             	lea    -0xc(%ebp),%eax
80106601:	50                   	push   %eax
80106602:	ff 75 08             	push   0x8(%ebp)
80106605:	e8 56 ff ff ff       	call   80106560 <argint>
8010660a:	83 c4 10             	add    $0x10,%esp
8010660d:	85 c0                	test   %eax,%eax
8010660f:	79 07                	jns    80106618 <argstr+0x23>
80106611:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106616:	eb 12                	jmp    8010662a <argstr+0x35>
80106618:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010661b:	83 ec 08             	sub    $0x8,%esp
8010661e:	ff 75 0c             	push   0xc(%ebp)
80106621:	50                   	push   %eax
80106622:	e8 d7 fe ff ff       	call   801064fe <fetchstr>
80106627:	83 c4 10             	add    $0x10,%esp
8010662a:	c9                   	leave  
8010662b:	c3                   	ret    

8010662c <syscall>:
8010662c:	55                   	push   %ebp
8010662d:	89 e5                	mov    %esp,%ebp
8010662f:	83 ec 18             	sub    $0x18,%esp
80106632:	e8 df dc ff ff       	call   80104316 <myproc>
80106637:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010663a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010663d:	8b 40 18             	mov    0x18(%eax),%eax
80106640:	8b 40 1c             	mov    0x1c(%eax),%eax
80106643:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106646:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
8010664a:	7e 2f                	jle    8010667b <syscall+0x4f>
8010664c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010664f:	83 f8 17             	cmp    $0x17,%eax
80106652:	77 27                	ja     8010667b <syscall+0x4f>
80106654:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106657:	8b 04 85 20 c0 10 80 	mov    -0x7fef3fe0(,%eax,4),%eax
8010665e:	85 c0                	test   %eax,%eax
80106660:	74 19                	je     8010667b <syscall+0x4f>
80106662:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106665:	8b 04 85 20 c0 10 80 	mov    -0x7fef3fe0(,%eax,4),%eax
8010666c:	ff d0                	call   *%eax
8010666e:	89 c2                	mov    %eax,%edx
80106670:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106673:	8b 40 18             	mov    0x18(%eax),%eax
80106676:	89 50 1c             	mov    %edx,0x1c(%eax)
80106679:	eb 2c                	jmp    801066a7 <syscall+0x7b>
8010667b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010667e:	8d 50 6c             	lea    0x6c(%eax),%edx
80106681:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106684:	8b 40 10             	mov    0x10(%eax),%eax
80106687:	ff 75 f0             	push   -0x10(%ebp)
8010668a:	52                   	push   %edx
8010668b:	50                   	push   %eax
8010668c:	68 c1 9a 10 80       	push   $0x80109ac1
80106691:	e8 6a 9d ff ff       	call   80100400 <cprintf>
80106696:	83 c4 10             	add    $0x10,%esp
80106699:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010669c:	8b 40 18             	mov    0x18(%eax),%eax
8010669f:	c7 40 1c ff ff ff ff 	movl   $0xffffffff,0x1c(%eax)
801066a6:	90                   	nop
801066a7:	90                   	nop
801066a8:	c9                   	leave  
801066a9:	c3                   	ret    

801066aa <argfd>:
801066aa:	55                   	push   %ebp
801066ab:	89 e5                	mov    %esp,%ebp
801066ad:	83 ec 18             	sub    $0x18,%esp
801066b0:	83 ec 08             	sub    $0x8,%esp
801066b3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801066b6:	50                   	push   %eax
801066b7:	ff 75 08             	push   0x8(%ebp)
801066ba:	e8 a1 fe ff ff       	call   80106560 <argint>
801066bf:	83 c4 10             	add    $0x10,%esp
801066c2:	85 c0                	test   %eax,%eax
801066c4:	79 07                	jns    801066cd <argfd+0x23>
801066c6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801066cb:	eb 4f                	jmp    8010671c <argfd+0x72>
801066cd:	8b 45 f0             	mov    -0x10(%ebp),%eax
801066d0:	85 c0                	test   %eax,%eax
801066d2:	78 20                	js     801066f4 <argfd+0x4a>
801066d4:	8b 45 f0             	mov    -0x10(%ebp),%eax
801066d7:	83 f8 0f             	cmp    $0xf,%eax
801066da:	7f 18                	jg     801066f4 <argfd+0x4a>
801066dc:	e8 35 dc ff ff       	call   80104316 <myproc>
801066e1:	8b 55 f0             	mov    -0x10(%ebp),%edx
801066e4:	83 c2 08             	add    $0x8,%edx
801066e7:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
801066eb:	89 45 f4             	mov    %eax,-0xc(%ebp)
801066ee:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801066f2:	75 07                	jne    801066fb <argfd+0x51>
801066f4:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801066f9:	eb 21                	jmp    8010671c <argfd+0x72>
801066fb:	83 7d 0c 00          	cmpl   $0x0,0xc(%ebp)
801066ff:	74 08                	je     80106709 <argfd+0x5f>
80106701:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106704:	8b 45 0c             	mov    0xc(%ebp),%eax
80106707:	89 10                	mov    %edx,(%eax)
80106709:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
8010670d:	74 08                	je     80106717 <argfd+0x6d>
8010670f:	8b 45 10             	mov    0x10(%ebp),%eax
80106712:	8b 55 f4             	mov    -0xc(%ebp),%edx
80106715:	89 10                	mov    %edx,(%eax)
80106717:	b8 00 00 00 00       	mov    $0x0,%eax
8010671c:	c9                   	leave  
8010671d:	c3                   	ret    

8010671e <fdalloc>:
8010671e:	55                   	push   %ebp
8010671f:	89 e5                	mov    %esp,%ebp
80106721:	83 ec 18             	sub    $0x18,%esp
80106724:	e8 ed db ff ff       	call   80104316 <myproc>
80106729:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010672c:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80106733:	eb 2a                	jmp    8010675f <fdalloc+0x41>
80106735:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106738:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010673b:	83 c2 08             	add    $0x8,%edx
8010673e:	8b 44 90 08          	mov    0x8(%eax,%edx,4),%eax
80106742:	85 c0                	test   %eax,%eax
80106744:	75 15                	jne    8010675b <fdalloc+0x3d>
80106746:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106749:	8b 55 f4             	mov    -0xc(%ebp),%edx
8010674c:	8d 4a 08             	lea    0x8(%edx),%ecx
8010674f:	8b 55 08             	mov    0x8(%ebp),%edx
80106752:	89 54 88 08          	mov    %edx,0x8(%eax,%ecx,4)
80106756:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106759:	eb 0f                	jmp    8010676a <fdalloc+0x4c>
8010675b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010675f:	83 7d f4 0f          	cmpl   $0xf,-0xc(%ebp)
80106763:	7e d0                	jle    80106735 <fdalloc+0x17>
80106765:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010676a:	c9                   	leave  
8010676b:	c3                   	ret    

8010676c <sys_dup>:
8010676c:	55                   	push   %ebp
8010676d:	89 e5                	mov    %esp,%ebp
8010676f:	83 ec 18             	sub    $0x18,%esp
80106772:	83 ec 04             	sub    $0x4,%esp
80106775:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106778:	50                   	push   %eax
80106779:	6a 00                	push   $0x0
8010677b:	6a 00                	push   $0x0
8010677d:	e8 28 ff ff ff       	call   801066aa <argfd>
80106782:	83 c4 10             	add    $0x10,%esp
80106785:	85 c0                	test   %eax,%eax
80106787:	79 07                	jns    80106790 <sys_dup+0x24>
80106789:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010678e:	eb 31                	jmp    801067c1 <sys_dup+0x55>
80106790:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106793:	83 ec 0c             	sub    $0xc,%esp
80106796:	50                   	push   %eax
80106797:	e8 82 ff ff ff       	call   8010671e <fdalloc>
8010679c:	83 c4 10             	add    $0x10,%esp
8010679f:	89 45 f4             	mov    %eax,-0xc(%ebp)
801067a2:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801067a6:	79 07                	jns    801067af <sys_dup+0x43>
801067a8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801067ad:	eb 12                	jmp    801067c1 <sys_dup+0x55>
801067af:	8b 45 f0             	mov    -0x10(%ebp),%eax
801067b2:	83 ec 0c             	sub    $0xc,%esp
801067b5:	50                   	push   %eax
801067b6:	e8 d2 a8 ff ff       	call   8010108d <filedup>
801067bb:	83 c4 10             	add    $0x10,%esp
801067be:	8b 45 f4             	mov    -0xc(%ebp),%eax
801067c1:	c9                   	leave  
801067c2:	c3                   	ret    

801067c3 <sys_read>:
801067c3:	55                   	push   %ebp
801067c4:	89 e5                	mov    %esp,%ebp
801067c6:	83 ec 18             	sub    $0x18,%esp
801067c9:	83 ec 04             	sub    $0x4,%esp
801067cc:	8d 45 f4             	lea    -0xc(%ebp),%eax
801067cf:	50                   	push   %eax
801067d0:	6a 00                	push   $0x0
801067d2:	6a 00                	push   $0x0
801067d4:	e8 d1 fe ff ff       	call   801066aa <argfd>
801067d9:	83 c4 10             	add    $0x10,%esp
801067dc:	85 c0                	test   %eax,%eax
801067de:	78 2e                	js     8010680e <sys_read+0x4b>
801067e0:	83 ec 08             	sub    $0x8,%esp
801067e3:	8d 45 f0             	lea    -0x10(%ebp),%eax
801067e6:	50                   	push   %eax
801067e7:	6a 02                	push   $0x2
801067e9:	e8 72 fd ff ff       	call   80106560 <argint>
801067ee:	83 c4 10             	add    $0x10,%esp
801067f1:	85 c0                	test   %eax,%eax
801067f3:	78 19                	js     8010680e <sys_read+0x4b>
801067f5:	8b 45 f0             	mov    -0x10(%ebp),%eax
801067f8:	83 ec 04             	sub    $0x4,%esp
801067fb:	50                   	push   %eax
801067fc:	8d 45 ec             	lea    -0x14(%ebp),%eax
801067ff:	50                   	push   %eax
80106800:	6a 01                	push   $0x1
80106802:	e8 86 fd ff ff       	call   8010658d <argptr>
80106807:	83 c4 10             	add    $0x10,%esp
8010680a:	85 c0                	test   %eax,%eax
8010680c:	79 07                	jns    80106815 <sys_read+0x52>
8010680e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106813:	eb 17                	jmp    8010682c <sys_read+0x69>
80106815:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80106818:	8b 55 ec             	mov    -0x14(%ebp),%edx
8010681b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010681e:	83 ec 04             	sub    $0x4,%esp
80106821:	51                   	push   %ecx
80106822:	52                   	push   %edx
80106823:	50                   	push   %eax
80106824:	e8 f4 a9 ff ff       	call   8010121d <fileread>
80106829:	83 c4 10             	add    $0x10,%esp
8010682c:	c9                   	leave  
8010682d:	c3                   	ret    

8010682e <sys_write>:
8010682e:	55                   	push   %ebp
8010682f:	89 e5                	mov    %esp,%ebp
80106831:	83 ec 18             	sub    $0x18,%esp
80106834:	83 ec 04             	sub    $0x4,%esp
80106837:	8d 45 f4             	lea    -0xc(%ebp),%eax
8010683a:	50                   	push   %eax
8010683b:	6a 00                	push   $0x0
8010683d:	6a 00                	push   $0x0
8010683f:	e8 66 fe ff ff       	call   801066aa <argfd>
80106844:	83 c4 10             	add    $0x10,%esp
80106847:	85 c0                	test   %eax,%eax
80106849:	78 2e                	js     80106879 <sys_write+0x4b>
8010684b:	83 ec 08             	sub    $0x8,%esp
8010684e:	8d 45 f0             	lea    -0x10(%ebp),%eax
80106851:	50                   	push   %eax
80106852:	6a 02                	push   $0x2
80106854:	e8 07 fd ff ff       	call   80106560 <argint>
80106859:	83 c4 10             	add    $0x10,%esp
8010685c:	85 c0                	test   %eax,%eax
8010685e:	78 19                	js     80106879 <sys_write+0x4b>
80106860:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106863:	83 ec 04             	sub    $0x4,%esp
80106866:	50                   	push   %eax
80106867:	8d 45 ec             	lea    -0x14(%ebp),%eax
8010686a:	50                   	push   %eax
8010686b:	6a 01                	push   $0x1
8010686d:	e8 1b fd ff ff       	call   8010658d <argptr>
80106872:	83 c4 10             	add    $0x10,%esp
80106875:	85 c0                	test   %eax,%eax
80106877:	79 07                	jns    80106880 <sys_write+0x52>
80106879:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010687e:	eb 17                	jmp    80106897 <sys_write+0x69>
80106880:	8b 4d f0             	mov    -0x10(%ebp),%ecx
80106883:	8b 55 ec             	mov    -0x14(%ebp),%edx
80106886:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106889:	83 ec 04             	sub    $0x4,%esp
8010688c:	51                   	push   %ecx
8010688d:	52                   	push   %edx
8010688e:	50                   	push   %eax
8010688f:	e8 41 aa ff ff       	call   801012d5 <filewrite>
80106894:	83 c4 10             	add    $0x10,%esp
80106897:	c9                   	leave  
80106898:	c3                   	ret    

80106899 <sys_close>:
80106899:	55                   	push   %ebp
8010689a:	89 e5                	mov    %esp,%ebp
8010689c:	83 ec 18             	sub    $0x18,%esp
8010689f:	83 ec 04             	sub    $0x4,%esp
801068a2:	8d 45 f0             	lea    -0x10(%ebp),%eax
801068a5:	50                   	push   %eax
801068a6:	8d 45 f4             	lea    -0xc(%ebp),%eax
801068a9:	50                   	push   %eax
801068aa:	6a 00                	push   $0x0
801068ac:	e8 f9 fd ff ff       	call   801066aa <argfd>
801068b1:	83 c4 10             	add    $0x10,%esp
801068b4:	85 c0                	test   %eax,%eax
801068b6:	79 07                	jns    801068bf <sys_close+0x26>
801068b8:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801068bd:	eb 27                	jmp    801068e6 <sys_close+0x4d>
801068bf:	e8 52 da ff ff       	call   80104316 <myproc>
801068c4:	8b 55 f4             	mov    -0xc(%ebp),%edx
801068c7:	83 c2 08             	add    $0x8,%edx
801068ca:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801068d1:	00 
801068d2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801068d5:	83 ec 0c             	sub    $0xc,%esp
801068d8:	50                   	push   %eax
801068d9:	e8 00 a8 ff ff       	call   801010de <fileclose>
801068de:	83 c4 10             	add    $0x10,%esp
801068e1:	b8 00 00 00 00       	mov    $0x0,%eax
801068e6:	c9                   	leave  
801068e7:	c3                   	ret    

801068e8 <sys_fstat>:
801068e8:	55                   	push   %ebp
801068e9:	89 e5                	mov    %esp,%ebp
801068eb:	83 ec 18             	sub    $0x18,%esp
801068ee:	83 ec 04             	sub    $0x4,%esp
801068f1:	8d 45 f4             	lea    -0xc(%ebp),%eax
801068f4:	50                   	push   %eax
801068f5:	6a 00                	push   $0x0
801068f7:	6a 00                	push   $0x0
801068f9:	e8 ac fd ff ff       	call   801066aa <argfd>
801068fe:	83 c4 10             	add    $0x10,%esp
80106901:	85 c0                	test   %eax,%eax
80106903:	78 17                	js     8010691c <sys_fstat+0x34>
80106905:	83 ec 04             	sub    $0x4,%esp
80106908:	6a 14                	push   $0x14
8010690a:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010690d:	50                   	push   %eax
8010690e:	6a 01                	push   $0x1
80106910:	e8 78 fc ff ff       	call   8010658d <argptr>
80106915:	83 c4 10             	add    $0x10,%esp
80106918:	85 c0                	test   %eax,%eax
8010691a:	79 07                	jns    80106923 <sys_fstat+0x3b>
8010691c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106921:	eb 13                	jmp    80106936 <sys_fstat+0x4e>
80106923:	8b 55 f0             	mov    -0x10(%ebp),%edx
80106926:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106929:	83 ec 08             	sub    $0x8,%esp
8010692c:	52                   	push   %edx
8010692d:	50                   	push   %eax
8010692e:	e8 93 a8 ff ff       	call   801011c6 <filestat>
80106933:	83 c4 10             	add    $0x10,%esp
80106936:	c9                   	leave  
80106937:	c3                   	ret    

80106938 <sys_link>:
80106938:	55                   	push   %ebp
80106939:	89 e5                	mov    %esp,%ebp
8010693b:	83 ec 28             	sub    $0x28,%esp
8010693e:	83 ec 08             	sub    $0x8,%esp
80106941:	8d 45 d8             	lea    -0x28(%ebp),%eax
80106944:	50                   	push   %eax
80106945:	6a 00                	push   $0x0
80106947:	e8 a9 fc ff ff       	call   801065f5 <argstr>
8010694c:	83 c4 10             	add    $0x10,%esp
8010694f:	85 c0                	test   %eax,%eax
80106951:	78 15                	js     80106968 <sys_link+0x30>
80106953:	83 ec 08             	sub    $0x8,%esp
80106956:	8d 45 dc             	lea    -0x24(%ebp),%eax
80106959:	50                   	push   %eax
8010695a:	6a 01                	push   $0x1
8010695c:	e8 94 fc ff ff       	call   801065f5 <argstr>
80106961:	83 c4 10             	add    $0x10,%esp
80106964:	85 c0                	test   %eax,%eax
80106966:	79 0a                	jns    80106972 <sys_link+0x3a>
80106968:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010696d:	e9 68 01 00 00       	jmp    80106ada <sys_link+0x1a2>
80106972:	e8 bb cb ff ff       	call   80103532 <begin_op>
80106977:	8b 45 d8             	mov    -0x28(%ebp),%eax
8010697a:	83 ec 0c             	sub    $0xc,%esp
8010697d:	50                   	push   %eax
8010697e:	e8 ca bb ff ff       	call   8010254d <namei>
80106983:	83 c4 10             	add    $0x10,%esp
80106986:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106989:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010698d:	75 0f                	jne    8010699e <sys_link+0x66>
8010698f:	e8 2a cc ff ff       	call   801035be <end_op>
80106994:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106999:	e9 3c 01 00 00       	jmp    80106ada <sys_link+0x1a2>
8010699e:	83 ec 0c             	sub    $0xc,%esp
801069a1:	ff 75 f4             	push   -0xc(%ebp)
801069a4:	e8 71 b0 ff ff       	call   80101a1a <ilock>
801069a9:	83 c4 10             	add    $0x10,%esp
801069ac:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069af:	0f b7 40 50          	movzwl 0x50(%eax),%eax
801069b3:	66 83 f8 01          	cmp    $0x1,%ax
801069b7:	75 1d                	jne    801069d6 <sys_link+0x9e>
801069b9:	83 ec 0c             	sub    $0xc,%esp
801069bc:	ff 75 f4             	push   -0xc(%ebp)
801069bf:	e8 87 b2 ff ff       	call   80101c4b <iunlockput>
801069c4:	83 c4 10             	add    $0x10,%esp
801069c7:	e8 f2 cb ff ff       	call   801035be <end_op>
801069cc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801069d1:	e9 04 01 00 00       	jmp    80106ada <sys_link+0x1a2>
801069d6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069d9:	0f b7 40 56          	movzwl 0x56(%eax),%eax
801069dd:	83 c0 01             	add    $0x1,%eax
801069e0:	89 c2                	mov    %eax,%edx
801069e2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801069e5:	66 89 50 56          	mov    %dx,0x56(%eax)
801069e9:	83 ec 0c             	sub    $0xc,%esp
801069ec:	ff 75 f4             	push   -0xc(%ebp)
801069ef:	e8 49 ae ff ff       	call   8010183d <iupdate>
801069f4:	83 c4 10             	add    $0x10,%esp
801069f7:	83 ec 0c             	sub    $0xc,%esp
801069fa:	ff 75 f4             	push   -0xc(%ebp)
801069fd:	e8 2b b1 ff ff       	call   80101b2d <iunlock>
80106a02:	83 c4 10             	add    $0x10,%esp
80106a05:	8b 45 dc             	mov    -0x24(%ebp),%eax
80106a08:	83 ec 08             	sub    $0x8,%esp
80106a0b:	8d 55 e2             	lea    -0x1e(%ebp),%edx
80106a0e:	52                   	push   %edx
80106a0f:	50                   	push   %eax
80106a10:	e8 54 bb ff ff       	call   80102569 <nameiparent>
80106a15:	83 c4 10             	add    $0x10,%esp
80106a18:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106a1b:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106a1f:	74 71                	je     80106a92 <sys_link+0x15a>
80106a21:	83 ec 0c             	sub    $0xc,%esp
80106a24:	ff 75 f0             	push   -0x10(%ebp)
80106a27:	e8 ee af ff ff       	call   80101a1a <ilock>
80106a2c:	83 c4 10             	add    $0x10,%esp
80106a2f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106a32:	8b 10                	mov    (%eax),%edx
80106a34:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a37:	8b 00                	mov    (%eax),%eax
80106a39:	39 c2                	cmp    %eax,%edx
80106a3b:	75 1d                	jne    80106a5a <sys_link+0x122>
80106a3d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106a40:	8b 40 04             	mov    0x4(%eax),%eax
80106a43:	83 ec 04             	sub    $0x4,%esp
80106a46:	50                   	push   %eax
80106a47:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80106a4a:	50                   	push   %eax
80106a4b:	ff 75 f0             	push   -0x10(%ebp)
80106a4e:	e8 63 b8 ff ff       	call   801022b6 <dirlink>
80106a53:	83 c4 10             	add    $0x10,%esp
80106a56:	85 c0                	test   %eax,%eax
80106a58:	79 10                	jns    80106a6a <sys_link+0x132>
80106a5a:	83 ec 0c             	sub    $0xc,%esp
80106a5d:	ff 75 f0             	push   -0x10(%ebp)
80106a60:	e8 e6 b1 ff ff       	call   80101c4b <iunlockput>
80106a65:	83 c4 10             	add    $0x10,%esp
80106a68:	eb 29                	jmp    80106a93 <sys_link+0x15b>
80106a6a:	83 ec 0c             	sub    $0xc,%esp
80106a6d:	ff 75 f0             	push   -0x10(%ebp)
80106a70:	e8 d6 b1 ff ff       	call   80101c4b <iunlockput>
80106a75:	83 c4 10             	add    $0x10,%esp
80106a78:	83 ec 0c             	sub    $0xc,%esp
80106a7b:	ff 75 f4             	push   -0xc(%ebp)
80106a7e:	e8 f8 b0 ff ff       	call   80101b7b <iput>
80106a83:	83 c4 10             	add    $0x10,%esp
80106a86:	e8 33 cb ff ff       	call   801035be <end_op>
80106a8b:	b8 00 00 00 00       	mov    $0x0,%eax
80106a90:	eb 48                	jmp    80106ada <sys_link+0x1a2>
80106a92:	90                   	nop
80106a93:	83 ec 0c             	sub    $0xc,%esp
80106a96:	ff 75 f4             	push   -0xc(%ebp)
80106a99:	e8 7c af ff ff       	call   80101a1a <ilock>
80106a9e:	83 c4 10             	add    $0x10,%esp
80106aa1:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106aa4:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80106aa8:	83 e8 01             	sub    $0x1,%eax
80106aab:	89 c2                	mov    %eax,%edx
80106aad:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ab0:	66 89 50 56          	mov    %dx,0x56(%eax)
80106ab4:	83 ec 0c             	sub    $0xc,%esp
80106ab7:	ff 75 f4             	push   -0xc(%ebp)
80106aba:	e8 7e ad ff ff       	call   8010183d <iupdate>
80106abf:	83 c4 10             	add    $0x10,%esp
80106ac2:	83 ec 0c             	sub    $0xc,%esp
80106ac5:	ff 75 f4             	push   -0xc(%ebp)
80106ac8:	e8 7e b1 ff ff       	call   80101c4b <iunlockput>
80106acd:	83 c4 10             	add    $0x10,%esp
80106ad0:	e8 e9 ca ff ff       	call   801035be <end_op>
80106ad5:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106ada:	c9                   	leave  
80106adb:	c3                   	ret    

80106adc <isdirempty>:
80106adc:	55                   	push   %ebp
80106add:	89 e5                	mov    %esp,%ebp
80106adf:	83 ec 28             	sub    $0x28,%esp
80106ae2:	c7 45 f4 20 00 00 00 	movl   $0x20,-0xc(%ebp)
80106ae9:	eb 40                	jmp    80106b2b <isdirempty+0x4f>
80106aeb:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106aee:	6a 10                	push   $0x10
80106af0:	50                   	push   %eax
80106af1:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106af4:	50                   	push   %eax
80106af5:	ff 75 08             	push   0x8(%ebp)
80106af8:	e8 09 b4 ff ff       	call   80101f06 <readi>
80106afd:	83 c4 10             	add    $0x10,%esp
80106b00:	83 f8 10             	cmp    $0x10,%eax
80106b03:	74 0d                	je     80106b12 <isdirempty+0x36>
80106b05:	83 ec 0c             	sub    $0xc,%esp
80106b08:	68 dd 9a 10 80       	push   $0x80109add
80106b0d:	e8 a3 9a ff ff       	call   801005b5 <panic>
80106b12:	0f b7 45 e4          	movzwl -0x1c(%ebp),%eax
80106b16:	66 85 c0             	test   %ax,%ax
80106b19:	74 07                	je     80106b22 <isdirempty+0x46>
80106b1b:	b8 00 00 00 00       	mov    $0x0,%eax
80106b20:	eb 1b                	jmp    80106b3d <isdirempty+0x61>
80106b22:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b25:	83 c0 10             	add    $0x10,%eax
80106b28:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106b2b:	8b 45 08             	mov    0x8(%ebp),%eax
80106b2e:	8b 50 58             	mov    0x58(%eax),%edx
80106b31:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106b34:	39 c2                	cmp    %eax,%edx
80106b36:	77 b3                	ja     80106aeb <isdirempty+0xf>
80106b38:	b8 01 00 00 00       	mov    $0x1,%eax
80106b3d:	c9                   	leave  
80106b3e:	c3                   	ret    

80106b3f <sys_unlink>:
80106b3f:	55                   	push   %ebp
80106b40:	89 e5                	mov    %esp,%ebp
80106b42:	83 ec 38             	sub    $0x38,%esp
80106b45:	83 ec 08             	sub    $0x8,%esp
80106b48:	8d 45 cc             	lea    -0x34(%ebp),%eax
80106b4b:	50                   	push   %eax
80106b4c:	6a 00                	push   $0x0
80106b4e:	e8 a2 fa ff ff       	call   801065f5 <argstr>
80106b53:	83 c4 10             	add    $0x10,%esp
80106b56:	85 c0                	test   %eax,%eax
80106b58:	79 0a                	jns    80106b64 <sys_unlink+0x25>
80106b5a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106b5f:	e9 bf 01 00 00       	jmp    80106d23 <sys_unlink+0x1e4>
80106b64:	e8 c9 c9 ff ff       	call   80103532 <begin_op>
80106b69:	8b 45 cc             	mov    -0x34(%ebp),%eax
80106b6c:	83 ec 08             	sub    $0x8,%esp
80106b6f:	8d 55 d2             	lea    -0x2e(%ebp),%edx
80106b72:	52                   	push   %edx
80106b73:	50                   	push   %eax
80106b74:	e8 f0 b9 ff ff       	call   80102569 <nameiparent>
80106b79:	83 c4 10             	add    $0x10,%esp
80106b7c:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106b7f:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106b83:	75 0f                	jne    80106b94 <sys_unlink+0x55>
80106b85:	e8 34 ca ff ff       	call   801035be <end_op>
80106b8a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106b8f:	e9 8f 01 00 00       	jmp    80106d23 <sys_unlink+0x1e4>
80106b94:	83 ec 0c             	sub    $0xc,%esp
80106b97:	ff 75 f4             	push   -0xc(%ebp)
80106b9a:	e8 7b ae ff ff       	call   80101a1a <ilock>
80106b9f:	83 c4 10             	add    $0x10,%esp
80106ba2:	83 ec 08             	sub    $0x8,%esp
80106ba5:	68 ef 9a 10 80       	push   $0x80109aef
80106baa:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80106bad:	50                   	push   %eax
80106bae:	e8 2e b6 ff ff       	call   801021e1 <namecmp>
80106bb3:	83 c4 10             	add    $0x10,%esp
80106bb6:	85 c0                	test   %eax,%eax
80106bb8:	0f 84 49 01 00 00    	je     80106d07 <sys_unlink+0x1c8>
80106bbe:	83 ec 08             	sub    $0x8,%esp
80106bc1:	68 f1 9a 10 80       	push   $0x80109af1
80106bc6:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80106bc9:	50                   	push   %eax
80106bca:	e8 12 b6 ff ff       	call   801021e1 <namecmp>
80106bcf:	83 c4 10             	add    $0x10,%esp
80106bd2:	85 c0                	test   %eax,%eax
80106bd4:	0f 84 2d 01 00 00    	je     80106d07 <sys_unlink+0x1c8>
80106bda:	83 ec 04             	sub    $0x4,%esp
80106bdd:	8d 45 c8             	lea    -0x38(%ebp),%eax
80106be0:	50                   	push   %eax
80106be1:	8d 45 d2             	lea    -0x2e(%ebp),%eax
80106be4:	50                   	push   %eax
80106be5:	ff 75 f4             	push   -0xc(%ebp)
80106be8:	e8 0f b6 ff ff       	call   801021fc <dirlookup>
80106bed:	83 c4 10             	add    $0x10,%esp
80106bf0:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106bf3:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106bf7:	0f 84 0d 01 00 00    	je     80106d0a <sys_unlink+0x1cb>
80106bfd:	83 ec 0c             	sub    $0xc,%esp
80106c00:	ff 75 f0             	push   -0x10(%ebp)
80106c03:	e8 12 ae ff ff       	call   80101a1a <ilock>
80106c08:	83 c4 10             	add    $0x10,%esp
80106c0b:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106c0e:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80106c12:	66 85 c0             	test   %ax,%ax
80106c15:	7f 0d                	jg     80106c24 <sys_unlink+0xe5>
80106c17:	83 ec 0c             	sub    $0xc,%esp
80106c1a:	68 f4 9a 10 80       	push   $0x80109af4
80106c1f:	e8 91 99 ff ff       	call   801005b5 <panic>
80106c24:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106c27:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80106c2b:	66 83 f8 01          	cmp    $0x1,%ax
80106c2f:	75 25                	jne    80106c56 <sys_unlink+0x117>
80106c31:	83 ec 0c             	sub    $0xc,%esp
80106c34:	ff 75 f0             	push   -0x10(%ebp)
80106c37:	e8 a0 fe ff ff       	call   80106adc <isdirempty>
80106c3c:	83 c4 10             	add    $0x10,%esp
80106c3f:	85 c0                	test   %eax,%eax
80106c41:	75 13                	jne    80106c56 <sys_unlink+0x117>
80106c43:	83 ec 0c             	sub    $0xc,%esp
80106c46:	ff 75 f0             	push   -0x10(%ebp)
80106c49:	e8 fd af ff ff       	call   80101c4b <iunlockput>
80106c4e:	83 c4 10             	add    $0x10,%esp
80106c51:	e9 b5 00 00 00       	jmp    80106d0b <sys_unlink+0x1cc>
80106c56:	83 ec 04             	sub    $0x4,%esp
80106c59:	6a 10                	push   $0x10
80106c5b:	6a 00                	push   $0x0
80106c5d:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106c60:	50                   	push   %eax
80106c61:	e8 cf f5 ff ff       	call   80106235 <memset>
80106c66:	83 c4 10             	add    $0x10,%esp
80106c69:	8b 45 c8             	mov    -0x38(%ebp),%eax
80106c6c:	6a 10                	push   $0x10
80106c6e:	50                   	push   %eax
80106c6f:	8d 45 e0             	lea    -0x20(%ebp),%eax
80106c72:	50                   	push   %eax
80106c73:	ff 75 f4             	push   -0xc(%ebp)
80106c76:	e8 e0 b3 ff ff       	call   8010205b <writei>
80106c7b:	83 c4 10             	add    $0x10,%esp
80106c7e:	83 f8 10             	cmp    $0x10,%eax
80106c81:	74 0d                	je     80106c90 <sys_unlink+0x151>
80106c83:	83 ec 0c             	sub    $0xc,%esp
80106c86:	68 06 9b 10 80       	push   $0x80109b06
80106c8b:	e8 25 99 ff ff       	call   801005b5 <panic>
80106c90:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106c93:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80106c97:	66 83 f8 01          	cmp    $0x1,%ax
80106c9b:	75 21                	jne    80106cbe <sys_unlink+0x17f>
80106c9d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106ca0:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80106ca4:	83 e8 01             	sub    $0x1,%eax
80106ca7:	89 c2                	mov    %eax,%edx
80106ca9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106cac:	66 89 50 56          	mov    %dx,0x56(%eax)
80106cb0:	83 ec 0c             	sub    $0xc,%esp
80106cb3:	ff 75 f4             	push   -0xc(%ebp)
80106cb6:	e8 82 ab ff ff       	call   8010183d <iupdate>
80106cbb:	83 c4 10             	add    $0x10,%esp
80106cbe:	83 ec 0c             	sub    $0xc,%esp
80106cc1:	ff 75 f4             	push   -0xc(%ebp)
80106cc4:	e8 82 af ff ff       	call   80101c4b <iunlockput>
80106cc9:	83 c4 10             	add    $0x10,%esp
80106ccc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106ccf:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80106cd3:	83 e8 01             	sub    $0x1,%eax
80106cd6:	89 c2                	mov    %eax,%edx
80106cd8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106cdb:	66 89 50 56          	mov    %dx,0x56(%eax)
80106cdf:	83 ec 0c             	sub    $0xc,%esp
80106ce2:	ff 75 f0             	push   -0x10(%ebp)
80106ce5:	e8 53 ab ff ff       	call   8010183d <iupdate>
80106cea:	83 c4 10             	add    $0x10,%esp
80106ced:	83 ec 0c             	sub    $0xc,%esp
80106cf0:	ff 75 f0             	push   -0x10(%ebp)
80106cf3:	e8 53 af ff ff       	call   80101c4b <iunlockput>
80106cf8:	83 c4 10             	add    $0x10,%esp
80106cfb:	e8 be c8 ff ff       	call   801035be <end_op>
80106d00:	b8 00 00 00 00       	mov    $0x0,%eax
80106d05:	eb 1c                	jmp    80106d23 <sys_unlink+0x1e4>
80106d07:	90                   	nop
80106d08:	eb 01                	jmp    80106d0b <sys_unlink+0x1cc>
80106d0a:	90                   	nop
80106d0b:	83 ec 0c             	sub    $0xc,%esp
80106d0e:	ff 75 f4             	push   -0xc(%ebp)
80106d11:	e8 35 af ff ff       	call   80101c4b <iunlockput>
80106d16:	83 c4 10             	add    $0x10,%esp
80106d19:	e8 a0 c8 ff ff       	call   801035be <end_op>
80106d1e:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106d23:	c9                   	leave  
80106d24:	c3                   	ret    

80106d25 <create>:
80106d25:	55                   	push   %ebp
80106d26:	89 e5                	mov    %esp,%ebp
80106d28:	83 ec 38             	sub    $0x38,%esp
80106d2b:	8b 4d 0c             	mov    0xc(%ebp),%ecx
80106d2e:	8b 55 10             	mov    0x10(%ebp),%edx
80106d31:	8b 45 14             	mov    0x14(%ebp),%eax
80106d34:	66 89 4d d4          	mov    %cx,-0x2c(%ebp)
80106d38:	66 89 55 d0          	mov    %dx,-0x30(%ebp)
80106d3c:	66 89 45 cc          	mov    %ax,-0x34(%ebp)
80106d40:	83 ec 08             	sub    $0x8,%esp
80106d43:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80106d46:	50                   	push   %eax
80106d47:	ff 75 08             	push   0x8(%ebp)
80106d4a:	e8 1a b8 ff ff       	call   80102569 <nameiparent>
80106d4f:	83 c4 10             	add    $0x10,%esp
80106d52:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106d55:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106d59:	75 0a                	jne    80106d65 <create+0x40>
80106d5b:	b8 00 00 00 00       	mov    $0x0,%eax
80106d60:	e9 8e 01 00 00       	jmp    80106ef3 <create+0x1ce>
80106d65:	83 ec 0c             	sub    $0xc,%esp
80106d68:	ff 75 f4             	push   -0xc(%ebp)
80106d6b:	e8 aa ac ff ff       	call   80101a1a <ilock>
80106d70:	83 c4 10             	add    $0x10,%esp
80106d73:	83 ec 04             	sub    $0x4,%esp
80106d76:	6a 00                	push   $0x0
80106d78:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80106d7b:	50                   	push   %eax
80106d7c:	ff 75 f4             	push   -0xc(%ebp)
80106d7f:	e8 78 b4 ff ff       	call   801021fc <dirlookup>
80106d84:	83 c4 10             	add    $0x10,%esp
80106d87:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106d8a:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106d8e:	74 50                	je     80106de0 <create+0xbb>
80106d90:	83 ec 0c             	sub    $0xc,%esp
80106d93:	ff 75 f4             	push   -0xc(%ebp)
80106d96:	e8 b0 ae ff ff       	call   80101c4b <iunlockput>
80106d9b:	83 c4 10             	add    $0x10,%esp
80106d9e:	83 ec 0c             	sub    $0xc,%esp
80106da1:	ff 75 f0             	push   -0x10(%ebp)
80106da4:	e8 71 ac ff ff       	call   80101a1a <ilock>
80106da9:	83 c4 10             	add    $0x10,%esp
80106dac:	66 83 7d d4 02       	cmpw   $0x2,-0x2c(%ebp)
80106db1:	75 15                	jne    80106dc8 <create+0xa3>
80106db3:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106db6:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80106dba:	66 83 f8 02          	cmp    $0x2,%ax
80106dbe:	75 08                	jne    80106dc8 <create+0xa3>
80106dc0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106dc3:	e9 2b 01 00 00       	jmp    80106ef3 <create+0x1ce>
80106dc8:	83 ec 0c             	sub    $0xc,%esp
80106dcb:	ff 75 f0             	push   -0x10(%ebp)
80106dce:	e8 78 ae ff ff       	call   80101c4b <iunlockput>
80106dd3:	83 c4 10             	add    $0x10,%esp
80106dd6:	b8 00 00 00 00       	mov    $0x0,%eax
80106ddb:	e9 13 01 00 00       	jmp    80106ef3 <create+0x1ce>
80106de0:	0f bf 55 d4          	movswl -0x2c(%ebp),%edx
80106de4:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106de7:	8b 00                	mov    (%eax),%eax
80106de9:	83 ec 08             	sub    $0x8,%esp
80106dec:	52                   	push   %edx
80106ded:	50                   	push   %eax
80106dee:	e8 73 a9 ff ff       	call   80101766 <ialloc>
80106df3:	83 c4 10             	add    $0x10,%esp
80106df6:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106df9:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106dfd:	75 0d                	jne    80106e0c <create+0xe7>
80106dff:	83 ec 0c             	sub    $0xc,%esp
80106e02:	68 15 9b 10 80       	push   $0x80109b15
80106e07:	e8 a9 97 ff ff       	call   801005b5 <panic>
80106e0c:	83 ec 0c             	sub    $0xc,%esp
80106e0f:	ff 75 f0             	push   -0x10(%ebp)
80106e12:	e8 03 ac ff ff       	call   80101a1a <ilock>
80106e17:	83 c4 10             	add    $0x10,%esp
80106e1a:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106e1d:	0f b7 55 d0          	movzwl -0x30(%ebp),%edx
80106e21:	66 89 50 52          	mov    %dx,0x52(%eax)
80106e25:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106e28:	0f b7 55 cc          	movzwl -0x34(%ebp),%edx
80106e2c:	66 89 50 54          	mov    %dx,0x54(%eax)
80106e30:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106e33:	66 c7 40 56 01 00    	movw   $0x1,0x56(%eax)
80106e39:	83 ec 0c             	sub    $0xc,%esp
80106e3c:	ff 75 f0             	push   -0x10(%ebp)
80106e3f:	e8 f9 a9 ff ff       	call   8010183d <iupdate>
80106e44:	83 c4 10             	add    $0x10,%esp
80106e47:	66 83 7d d4 01       	cmpw   $0x1,-0x2c(%ebp)
80106e4c:	75 6a                	jne    80106eb8 <create+0x193>
80106e4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e51:	0f b7 40 56          	movzwl 0x56(%eax),%eax
80106e55:	83 c0 01             	add    $0x1,%eax
80106e58:	89 c2                	mov    %eax,%edx
80106e5a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e5d:	66 89 50 56          	mov    %dx,0x56(%eax)
80106e61:	83 ec 0c             	sub    $0xc,%esp
80106e64:	ff 75 f4             	push   -0xc(%ebp)
80106e67:	e8 d1 a9 ff ff       	call   8010183d <iupdate>
80106e6c:	83 c4 10             	add    $0x10,%esp
80106e6f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106e72:	8b 40 04             	mov    0x4(%eax),%eax
80106e75:	83 ec 04             	sub    $0x4,%esp
80106e78:	50                   	push   %eax
80106e79:	68 ef 9a 10 80       	push   $0x80109aef
80106e7e:	ff 75 f0             	push   -0x10(%ebp)
80106e81:	e8 30 b4 ff ff       	call   801022b6 <dirlink>
80106e86:	83 c4 10             	add    $0x10,%esp
80106e89:	85 c0                	test   %eax,%eax
80106e8b:	78 1e                	js     80106eab <create+0x186>
80106e8d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106e90:	8b 40 04             	mov    0x4(%eax),%eax
80106e93:	83 ec 04             	sub    $0x4,%esp
80106e96:	50                   	push   %eax
80106e97:	68 f1 9a 10 80       	push   $0x80109af1
80106e9c:	ff 75 f0             	push   -0x10(%ebp)
80106e9f:	e8 12 b4 ff ff       	call   801022b6 <dirlink>
80106ea4:	83 c4 10             	add    $0x10,%esp
80106ea7:	85 c0                	test   %eax,%eax
80106ea9:	79 0d                	jns    80106eb8 <create+0x193>
80106eab:	83 ec 0c             	sub    $0xc,%esp
80106eae:	68 24 9b 10 80       	push   $0x80109b24
80106eb3:	e8 fd 96 ff ff       	call   801005b5 <panic>
80106eb8:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106ebb:	8b 40 04             	mov    0x4(%eax),%eax
80106ebe:	83 ec 04             	sub    $0x4,%esp
80106ec1:	50                   	push   %eax
80106ec2:	8d 45 e2             	lea    -0x1e(%ebp),%eax
80106ec5:	50                   	push   %eax
80106ec6:	ff 75 f4             	push   -0xc(%ebp)
80106ec9:	e8 e8 b3 ff ff       	call   801022b6 <dirlink>
80106ece:	83 c4 10             	add    $0x10,%esp
80106ed1:	85 c0                	test   %eax,%eax
80106ed3:	79 0d                	jns    80106ee2 <create+0x1bd>
80106ed5:	83 ec 0c             	sub    $0xc,%esp
80106ed8:	68 30 9b 10 80       	push   $0x80109b30
80106edd:	e8 d3 96 ff ff       	call   801005b5 <panic>
80106ee2:	83 ec 0c             	sub    $0xc,%esp
80106ee5:	ff 75 f4             	push   -0xc(%ebp)
80106ee8:	e8 5e ad ff ff       	call   80101c4b <iunlockput>
80106eed:	83 c4 10             	add    $0x10,%esp
80106ef0:	8b 45 f0             	mov    -0x10(%ebp),%eax
80106ef3:	c9                   	leave  
80106ef4:	c3                   	ret    

80106ef5 <sys_open>:
80106ef5:	55                   	push   %ebp
80106ef6:	89 e5                	mov    %esp,%ebp
80106ef8:	83 ec 28             	sub    $0x28,%esp
80106efb:	83 ec 08             	sub    $0x8,%esp
80106efe:	8d 45 e8             	lea    -0x18(%ebp),%eax
80106f01:	50                   	push   %eax
80106f02:	6a 00                	push   $0x0
80106f04:	e8 ec f6 ff ff       	call   801065f5 <argstr>
80106f09:	83 c4 10             	add    $0x10,%esp
80106f0c:	85 c0                	test   %eax,%eax
80106f0e:	78 15                	js     80106f25 <sys_open+0x30>
80106f10:	83 ec 08             	sub    $0x8,%esp
80106f13:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80106f16:	50                   	push   %eax
80106f17:	6a 01                	push   $0x1
80106f19:	e8 42 f6 ff ff       	call   80106560 <argint>
80106f1e:	83 c4 10             	add    $0x10,%esp
80106f21:	85 c0                	test   %eax,%eax
80106f23:	79 0a                	jns    80106f2f <sys_open+0x3a>
80106f25:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106f2a:	e9 61 01 00 00       	jmp    80107090 <sys_open+0x19b>
80106f2f:	e8 fe c5 ff ff       	call   80103532 <begin_op>
80106f34:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106f37:	25 00 02 00 00       	and    $0x200,%eax
80106f3c:	85 c0                	test   %eax,%eax
80106f3e:	74 2a                	je     80106f6a <sys_open+0x75>
80106f40:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106f43:	6a 00                	push   $0x0
80106f45:	6a 00                	push   $0x0
80106f47:	6a 02                	push   $0x2
80106f49:	50                   	push   %eax
80106f4a:	e8 d6 fd ff ff       	call   80106d25 <create>
80106f4f:	83 c4 10             	add    $0x10,%esp
80106f52:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106f55:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106f59:	75 75                	jne    80106fd0 <sys_open+0xdb>
80106f5b:	e8 5e c6 ff ff       	call   801035be <end_op>
80106f60:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106f65:	e9 26 01 00 00       	jmp    80107090 <sys_open+0x19b>
80106f6a:	8b 45 e8             	mov    -0x18(%ebp),%eax
80106f6d:	83 ec 0c             	sub    $0xc,%esp
80106f70:	50                   	push   %eax
80106f71:	e8 d7 b5 ff ff       	call   8010254d <namei>
80106f76:	83 c4 10             	add    $0x10,%esp
80106f79:	89 45 f4             	mov    %eax,-0xc(%ebp)
80106f7c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80106f80:	75 0f                	jne    80106f91 <sys_open+0x9c>
80106f82:	e8 37 c6 ff ff       	call   801035be <end_op>
80106f87:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106f8c:	e9 ff 00 00 00       	jmp    80107090 <sys_open+0x19b>
80106f91:	83 ec 0c             	sub    $0xc,%esp
80106f94:	ff 75 f4             	push   -0xc(%ebp)
80106f97:	e8 7e aa ff ff       	call   80101a1a <ilock>
80106f9c:	83 c4 10             	add    $0x10,%esp
80106f9f:	8b 45 f4             	mov    -0xc(%ebp),%eax
80106fa2:	0f b7 40 50          	movzwl 0x50(%eax),%eax
80106fa6:	66 83 f8 01          	cmp    $0x1,%ax
80106faa:	75 24                	jne    80106fd0 <sys_open+0xdb>
80106fac:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80106faf:	85 c0                	test   %eax,%eax
80106fb1:	74 1d                	je     80106fd0 <sys_open+0xdb>
80106fb3:	83 ec 0c             	sub    $0xc,%esp
80106fb6:	ff 75 f4             	push   -0xc(%ebp)
80106fb9:	e8 8d ac ff ff       	call   80101c4b <iunlockput>
80106fbe:	83 c4 10             	add    $0x10,%esp
80106fc1:	e8 f8 c5 ff ff       	call   801035be <end_op>
80106fc6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80106fcb:	e9 c0 00 00 00       	jmp    80107090 <sys_open+0x19b>
80106fd0:	e8 4b a0 ff ff       	call   80101020 <filealloc>
80106fd5:	89 45 f0             	mov    %eax,-0x10(%ebp)
80106fd8:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106fdc:	74 17                	je     80106ff5 <sys_open+0x100>
80106fde:	83 ec 0c             	sub    $0xc,%esp
80106fe1:	ff 75 f0             	push   -0x10(%ebp)
80106fe4:	e8 35 f7 ff ff       	call   8010671e <fdalloc>
80106fe9:	83 c4 10             	add    $0x10,%esp
80106fec:	89 45 ec             	mov    %eax,-0x14(%ebp)
80106fef:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80106ff3:	79 2e                	jns    80107023 <sys_open+0x12e>
80106ff5:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80106ff9:	74 0e                	je     80107009 <sys_open+0x114>
80106ffb:	83 ec 0c             	sub    $0xc,%esp
80106ffe:	ff 75 f0             	push   -0x10(%ebp)
80107001:	e8 d8 a0 ff ff       	call   801010de <fileclose>
80107006:	83 c4 10             	add    $0x10,%esp
80107009:	83 ec 0c             	sub    $0xc,%esp
8010700c:	ff 75 f4             	push   -0xc(%ebp)
8010700f:	e8 37 ac ff ff       	call   80101c4b <iunlockput>
80107014:	83 c4 10             	add    $0x10,%esp
80107017:	e8 a2 c5 ff ff       	call   801035be <end_op>
8010701c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107021:	eb 6d                	jmp    80107090 <sys_open+0x19b>
80107023:	83 ec 0c             	sub    $0xc,%esp
80107026:	ff 75 f4             	push   -0xc(%ebp)
80107029:	e8 ff aa ff ff       	call   80101b2d <iunlock>
8010702e:	83 c4 10             	add    $0x10,%esp
80107031:	e8 88 c5 ff ff       	call   801035be <end_op>
80107036:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107039:	c7 00 02 00 00 00    	movl   $0x2,(%eax)
8010703f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107042:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107045:	89 50 10             	mov    %edx,0x10(%eax)
80107048:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010704b:	c7 40 14 00 00 00 00 	movl   $0x0,0x14(%eax)
80107052:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107055:	83 e0 01             	and    $0x1,%eax
80107058:	85 c0                	test   %eax,%eax
8010705a:	0f 94 c0             	sete   %al
8010705d:	89 c2                	mov    %eax,%edx
8010705f:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107062:	88 50 08             	mov    %dl,0x8(%eax)
80107065:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107068:	83 e0 01             	and    $0x1,%eax
8010706b:	85 c0                	test   %eax,%eax
8010706d:	75 0a                	jne    80107079 <sys_open+0x184>
8010706f:	8b 45 e4             	mov    -0x1c(%ebp),%eax
80107072:	83 e0 02             	and    $0x2,%eax
80107075:	85 c0                	test   %eax,%eax
80107077:	74 07                	je     80107080 <sys_open+0x18b>
80107079:	b8 01 00 00 00       	mov    $0x1,%eax
8010707e:	eb 05                	jmp    80107085 <sys_open+0x190>
80107080:	b8 00 00 00 00       	mov    $0x0,%eax
80107085:	89 c2                	mov    %eax,%edx
80107087:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010708a:	88 50 09             	mov    %dl,0x9(%eax)
8010708d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107090:	c9                   	leave  
80107091:	c3                   	ret    

80107092 <sys_mkdir>:
80107092:	55                   	push   %ebp
80107093:	89 e5                	mov    %esp,%ebp
80107095:	83 ec 18             	sub    $0x18,%esp
80107098:	e8 95 c4 ff ff       	call   80103532 <begin_op>
8010709d:	83 ec 08             	sub    $0x8,%esp
801070a0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801070a3:	50                   	push   %eax
801070a4:	6a 00                	push   $0x0
801070a6:	e8 4a f5 ff ff       	call   801065f5 <argstr>
801070ab:	83 c4 10             	add    $0x10,%esp
801070ae:	85 c0                	test   %eax,%eax
801070b0:	78 1b                	js     801070cd <sys_mkdir+0x3b>
801070b2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801070b5:	6a 00                	push   $0x0
801070b7:	6a 00                	push   $0x0
801070b9:	6a 01                	push   $0x1
801070bb:	50                   	push   %eax
801070bc:	e8 64 fc ff ff       	call   80106d25 <create>
801070c1:	83 c4 10             	add    $0x10,%esp
801070c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
801070c7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801070cb:	75 0c                	jne    801070d9 <sys_mkdir+0x47>
801070cd:	e8 ec c4 ff ff       	call   801035be <end_op>
801070d2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801070d7:	eb 18                	jmp    801070f1 <sys_mkdir+0x5f>
801070d9:	83 ec 0c             	sub    $0xc,%esp
801070dc:	ff 75 f4             	push   -0xc(%ebp)
801070df:	e8 67 ab ff ff       	call   80101c4b <iunlockput>
801070e4:	83 c4 10             	add    $0x10,%esp
801070e7:	e8 d2 c4 ff ff       	call   801035be <end_op>
801070ec:	b8 00 00 00 00       	mov    $0x0,%eax
801070f1:	c9                   	leave  
801070f2:	c3                   	ret    

801070f3 <sys_mknod>:
801070f3:	55                   	push   %ebp
801070f4:	89 e5                	mov    %esp,%ebp
801070f6:	83 ec 18             	sub    $0x18,%esp
801070f9:	e8 34 c4 ff ff       	call   80103532 <begin_op>
801070fe:	83 ec 08             	sub    $0x8,%esp
80107101:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107104:	50                   	push   %eax
80107105:	6a 00                	push   $0x0
80107107:	e8 e9 f4 ff ff       	call   801065f5 <argstr>
8010710c:	83 c4 10             	add    $0x10,%esp
8010710f:	85 c0                	test   %eax,%eax
80107111:	78 4f                	js     80107162 <sys_mknod+0x6f>
80107113:	83 ec 08             	sub    $0x8,%esp
80107116:	8d 45 ec             	lea    -0x14(%ebp),%eax
80107119:	50                   	push   %eax
8010711a:	6a 01                	push   $0x1
8010711c:	e8 3f f4 ff ff       	call   80106560 <argint>
80107121:	83 c4 10             	add    $0x10,%esp
80107124:	85 c0                	test   %eax,%eax
80107126:	78 3a                	js     80107162 <sys_mknod+0x6f>
80107128:	83 ec 08             	sub    $0x8,%esp
8010712b:	8d 45 e8             	lea    -0x18(%ebp),%eax
8010712e:	50                   	push   %eax
8010712f:	6a 02                	push   $0x2
80107131:	e8 2a f4 ff ff       	call   80106560 <argint>
80107136:	83 c4 10             	add    $0x10,%esp
80107139:	85 c0                	test   %eax,%eax
8010713b:	78 25                	js     80107162 <sys_mknod+0x6f>
8010713d:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107140:	0f bf c8             	movswl %ax,%ecx
80107143:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107146:	0f bf d0             	movswl %ax,%edx
80107149:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010714c:	51                   	push   %ecx
8010714d:	52                   	push   %edx
8010714e:	6a 03                	push   $0x3
80107150:	50                   	push   %eax
80107151:	e8 cf fb ff ff       	call   80106d25 <create>
80107156:	83 c4 10             	add    $0x10,%esp
80107159:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010715c:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80107160:	75 0c                	jne    8010716e <sys_mknod+0x7b>
80107162:	e8 57 c4 ff ff       	call   801035be <end_op>
80107167:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
8010716c:	eb 18                	jmp    80107186 <sys_mknod+0x93>
8010716e:	83 ec 0c             	sub    $0xc,%esp
80107171:	ff 75 f4             	push   -0xc(%ebp)
80107174:	e8 d2 aa ff ff       	call   80101c4b <iunlockput>
80107179:	83 c4 10             	add    $0x10,%esp
8010717c:	e8 3d c4 ff ff       	call   801035be <end_op>
80107181:	b8 00 00 00 00       	mov    $0x0,%eax
80107186:	c9                   	leave  
80107187:	c3                   	ret    

80107188 <sys_chdir>:
80107188:	55                   	push   %ebp
80107189:	89 e5                	mov    %esp,%ebp
8010718b:	83 ec 18             	sub    $0x18,%esp
8010718e:	e8 83 d1 ff ff       	call   80104316 <myproc>
80107193:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107196:	e8 97 c3 ff ff       	call   80103532 <begin_op>
8010719b:	83 ec 08             	sub    $0x8,%esp
8010719e:	8d 45 ec             	lea    -0x14(%ebp),%eax
801071a1:	50                   	push   %eax
801071a2:	6a 00                	push   $0x0
801071a4:	e8 4c f4 ff ff       	call   801065f5 <argstr>
801071a9:	83 c4 10             	add    $0x10,%esp
801071ac:	85 c0                	test   %eax,%eax
801071ae:	78 18                	js     801071c8 <sys_chdir+0x40>
801071b0:	8b 45 ec             	mov    -0x14(%ebp),%eax
801071b3:	83 ec 0c             	sub    $0xc,%esp
801071b6:	50                   	push   %eax
801071b7:	e8 91 b3 ff ff       	call   8010254d <namei>
801071bc:	83 c4 10             	add    $0x10,%esp
801071bf:	89 45 f0             	mov    %eax,-0x10(%ebp)
801071c2:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801071c6:	75 0c                	jne    801071d4 <sys_chdir+0x4c>
801071c8:	e8 f1 c3 ff ff       	call   801035be <end_op>
801071cd:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801071d2:	eb 68                	jmp    8010723c <sys_chdir+0xb4>
801071d4:	83 ec 0c             	sub    $0xc,%esp
801071d7:	ff 75 f0             	push   -0x10(%ebp)
801071da:	e8 3b a8 ff ff       	call   80101a1a <ilock>
801071df:	83 c4 10             	add    $0x10,%esp
801071e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801071e5:	0f b7 40 50          	movzwl 0x50(%eax),%eax
801071e9:	66 83 f8 01          	cmp    $0x1,%ax
801071ed:	74 1a                	je     80107209 <sys_chdir+0x81>
801071ef:	83 ec 0c             	sub    $0xc,%esp
801071f2:	ff 75 f0             	push   -0x10(%ebp)
801071f5:	e8 51 aa ff ff       	call   80101c4b <iunlockput>
801071fa:	83 c4 10             	add    $0x10,%esp
801071fd:	e8 bc c3 ff ff       	call   801035be <end_op>
80107202:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107207:	eb 33                	jmp    8010723c <sys_chdir+0xb4>
80107209:	83 ec 0c             	sub    $0xc,%esp
8010720c:	ff 75 f0             	push   -0x10(%ebp)
8010720f:	e8 19 a9 ff ff       	call   80101b2d <iunlock>
80107214:	83 c4 10             	add    $0x10,%esp
80107217:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010721a:	8b 40 68             	mov    0x68(%eax),%eax
8010721d:	83 ec 0c             	sub    $0xc,%esp
80107220:	50                   	push   %eax
80107221:	e8 55 a9 ff ff       	call   80101b7b <iput>
80107226:	83 c4 10             	add    $0x10,%esp
80107229:	e8 90 c3 ff ff       	call   801035be <end_op>
8010722e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107231:	8b 55 f0             	mov    -0x10(%ebp),%edx
80107234:	89 50 68             	mov    %edx,0x68(%eax)
80107237:	b8 00 00 00 00       	mov    $0x0,%eax
8010723c:	c9                   	leave  
8010723d:	c3                   	ret    

8010723e <sys_exec>:
8010723e:	55                   	push   %ebp
8010723f:	89 e5                	mov    %esp,%ebp
80107241:	81 ec 98 00 00 00    	sub    $0x98,%esp
80107247:	83 ec 08             	sub    $0x8,%esp
8010724a:	8d 45 f0             	lea    -0x10(%ebp),%eax
8010724d:	50                   	push   %eax
8010724e:	6a 00                	push   $0x0
80107250:	e8 a0 f3 ff ff       	call   801065f5 <argstr>
80107255:	83 c4 10             	add    $0x10,%esp
80107258:	85 c0                	test   %eax,%eax
8010725a:	78 18                	js     80107274 <sys_exec+0x36>
8010725c:	83 ec 08             	sub    $0x8,%esp
8010725f:	8d 85 6c ff ff ff    	lea    -0x94(%ebp),%eax
80107265:	50                   	push   %eax
80107266:	6a 01                	push   $0x1
80107268:	e8 f3 f2 ff ff       	call   80106560 <argint>
8010726d:	83 c4 10             	add    $0x10,%esp
80107270:	85 c0                	test   %eax,%eax
80107272:	79 0a                	jns    8010727e <sys_exec+0x40>
80107274:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107279:	e9 c6 00 00 00       	jmp    80107344 <sys_exec+0x106>
8010727e:	83 ec 04             	sub    $0x4,%esp
80107281:	68 80 00 00 00       	push   $0x80
80107286:	6a 00                	push   $0x0
80107288:	8d 85 70 ff ff ff    	lea    -0x90(%ebp),%eax
8010728e:	50                   	push   %eax
8010728f:	e8 a1 ef ff ff       	call   80106235 <memset>
80107294:	83 c4 10             	add    $0x10,%esp
80107297:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010729e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801072a1:	83 f8 1f             	cmp    $0x1f,%eax
801072a4:	76 0a                	jbe    801072b0 <sys_exec+0x72>
801072a6:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801072ab:	e9 94 00 00 00       	jmp    80107344 <sys_exec+0x106>
801072b0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801072b3:	c1 e0 02             	shl    $0x2,%eax
801072b6:	89 c2                	mov    %eax,%edx
801072b8:	8b 85 6c ff ff ff    	mov    -0x94(%ebp),%eax
801072be:	01 c2                	add    %eax,%edx
801072c0:	83 ec 08             	sub    $0x8,%esp
801072c3:	8d 85 68 ff ff ff    	lea    -0x98(%ebp),%eax
801072c9:	50                   	push   %eax
801072ca:	52                   	push   %edx
801072cb:	e8 ef f1 ff ff       	call   801064bf <fetchint>
801072d0:	83 c4 10             	add    $0x10,%esp
801072d3:	85 c0                	test   %eax,%eax
801072d5:	79 07                	jns    801072de <sys_exec+0xa0>
801072d7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801072dc:	eb 66                	jmp    80107344 <sys_exec+0x106>
801072de:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
801072e4:	85 c0                	test   %eax,%eax
801072e6:	75 27                	jne    8010730f <sys_exec+0xd1>
801072e8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801072eb:	c7 84 85 70 ff ff ff 	movl   $0x0,-0x90(%ebp,%eax,4)
801072f2:	00 00 00 00 
801072f6:	90                   	nop
801072f7:	8b 45 f0             	mov    -0x10(%ebp),%eax
801072fa:	83 ec 08             	sub    $0x8,%esp
801072fd:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
80107303:	52                   	push   %edx
80107304:	50                   	push   %eax
80107305:	e8 b9 98 ff ff       	call   80100bc3 <exec>
8010730a:	83 c4 10             	add    $0x10,%esp
8010730d:	eb 35                	jmp    80107344 <sys_exec+0x106>
8010730f:	8d 95 70 ff ff ff    	lea    -0x90(%ebp),%edx
80107315:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107318:	c1 e0 02             	shl    $0x2,%eax
8010731b:	01 c2                	add    %eax,%edx
8010731d:	8b 85 68 ff ff ff    	mov    -0x98(%ebp),%eax
80107323:	83 ec 08             	sub    $0x8,%esp
80107326:	52                   	push   %edx
80107327:	50                   	push   %eax
80107328:	e8 d1 f1 ff ff       	call   801064fe <fetchstr>
8010732d:	83 c4 10             	add    $0x10,%esp
80107330:	85 c0                	test   %eax,%eax
80107332:	79 07                	jns    8010733b <sys_exec+0xfd>
80107334:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107339:	eb 09                	jmp    80107344 <sys_exec+0x106>
8010733b:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
8010733f:	e9 5a ff ff ff       	jmp    8010729e <sys_exec+0x60>
80107344:	c9                   	leave  
80107345:	c3                   	ret    

80107346 <sys_pipe>:
80107346:	55                   	push   %ebp
80107347:	89 e5                	mov    %esp,%ebp
80107349:	83 ec 28             	sub    $0x28,%esp
8010734c:	83 ec 04             	sub    $0x4,%esp
8010734f:	6a 08                	push   $0x8
80107351:	8d 45 ec             	lea    -0x14(%ebp),%eax
80107354:	50                   	push   %eax
80107355:	6a 00                	push   $0x0
80107357:	e8 31 f2 ff ff       	call   8010658d <argptr>
8010735c:	83 c4 10             	add    $0x10,%esp
8010735f:	85 c0                	test   %eax,%eax
80107361:	79 0a                	jns    8010736d <sys_pipe+0x27>
80107363:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107368:	e9 ae 00 00 00       	jmp    8010741b <sys_pipe+0xd5>
8010736d:	83 ec 08             	sub    $0x8,%esp
80107370:	8d 45 e4             	lea    -0x1c(%ebp),%eax
80107373:	50                   	push   %eax
80107374:	8d 45 e8             	lea    -0x18(%ebp),%eax
80107377:	50                   	push   %eax
80107378:	e8 59 ca ff ff       	call   80103dd6 <pipealloc>
8010737d:	83 c4 10             	add    $0x10,%esp
80107380:	85 c0                	test   %eax,%eax
80107382:	79 0a                	jns    8010738e <sys_pipe+0x48>
80107384:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107389:	e9 8d 00 00 00       	jmp    8010741b <sys_pipe+0xd5>
8010738e:	c7 45 f4 ff ff ff ff 	movl   $0xffffffff,-0xc(%ebp)
80107395:	8b 45 e8             	mov    -0x18(%ebp),%eax
80107398:	83 ec 0c             	sub    $0xc,%esp
8010739b:	50                   	push   %eax
8010739c:	e8 7d f3 ff ff       	call   8010671e <fdalloc>
801073a1:	83 c4 10             	add    $0x10,%esp
801073a4:	89 45 f4             	mov    %eax,-0xc(%ebp)
801073a7:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801073ab:	78 18                	js     801073c5 <sys_pipe+0x7f>
801073ad:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801073b0:	83 ec 0c             	sub    $0xc,%esp
801073b3:	50                   	push   %eax
801073b4:	e8 65 f3 ff ff       	call   8010671e <fdalloc>
801073b9:	83 c4 10             	add    $0x10,%esp
801073bc:	89 45 f0             	mov    %eax,-0x10(%ebp)
801073bf:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801073c3:	79 3e                	jns    80107403 <sys_pipe+0xbd>
801073c5:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
801073c9:	78 13                	js     801073de <sys_pipe+0x98>
801073cb:	e8 46 cf ff ff       	call   80104316 <myproc>
801073d0:	8b 55 f4             	mov    -0xc(%ebp),%edx
801073d3:	83 c2 08             	add    $0x8,%edx
801073d6:	c7 44 90 08 00 00 00 	movl   $0x0,0x8(%eax,%edx,4)
801073dd:	00 
801073de:	8b 45 e8             	mov    -0x18(%ebp),%eax
801073e1:	83 ec 0c             	sub    $0xc,%esp
801073e4:	50                   	push   %eax
801073e5:	e8 f4 9c ff ff       	call   801010de <fileclose>
801073ea:	83 c4 10             	add    $0x10,%esp
801073ed:	8b 45 e4             	mov    -0x1c(%ebp),%eax
801073f0:	83 ec 0c             	sub    $0xc,%esp
801073f3:	50                   	push   %eax
801073f4:	e8 e5 9c ff ff       	call   801010de <fileclose>
801073f9:	83 c4 10             	add    $0x10,%esp
801073fc:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107401:	eb 18                	jmp    8010741b <sys_pipe+0xd5>
80107403:	8b 45 ec             	mov    -0x14(%ebp),%eax
80107406:	8b 55 f4             	mov    -0xc(%ebp),%edx
80107409:	89 10                	mov    %edx,(%eax)
8010740b:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010740e:	8d 50 04             	lea    0x4(%eax),%edx
80107411:	8b 45 f0             	mov    -0x10(%ebp),%eax
80107414:	89 02                	mov    %eax,(%edx)
80107416:	b8 00 00 00 00       	mov    $0x0,%eax
8010741b:	c9                   	leave  
8010741c:	c3                   	ret    

8010741d <sys_fork>:
8010741d:	55                   	push   %ebp
8010741e:	89 e5                	mov    %esp,%ebp
80107420:	83 ec 08             	sub    $0x8,%esp
80107423:	e8 38 d2 ff ff       	call   80104660 <fork>
80107428:	c9                   	leave  
80107429:	c3                   	ret    

8010742a <sys_exit>:
8010742a:	55                   	push   %ebp
8010742b:	89 e5                	mov    %esp,%ebp
8010742d:	83 ec 08             	sub    $0x8,%esp
80107430:	e8 15 d6 ff ff       	call   80104a4a <exit>
80107435:	b8 00 00 00 00       	mov    $0x0,%eax
8010743a:	c9                   	leave  
8010743b:	c3                   	ret    

8010743c <sys_wait>:
8010743c:	55                   	push   %ebp
8010743d:	89 e5                	mov    %esp,%ebp
8010743f:	83 ec 08             	sub    $0x8,%esp
80107442:	e8 34 d7 ff ff       	call   80104b7b <wait>
80107447:	c9                   	leave  
80107448:	c3                   	ret    

80107449 <sys_kill>:
80107449:	55                   	push   %ebp
8010744a:	89 e5                	mov    %esp,%ebp
8010744c:	83 ec 18             	sub    $0x18,%esp
8010744f:	83 ec 08             	sub    $0x8,%esp
80107452:	8d 45 f4             	lea    -0xc(%ebp),%eax
80107455:	50                   	push   %eax
80107456:	6a 00                	push   $0x0
80107458:	e8 03 f1 ff ff       	call   80106560 <argint>
8010745d:	83 c4 10             	add    $0x10,%esp
80107460:	85 c0                	test   %eax,%eax
80107462:	79 07                	jns    8010746b <sys_kill+0x22>
80107464:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107469:	eb 0f                	jmp    8010747a <sys_kill+0x31>
8010746b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010746e:	83 ec 0c             	sub    $0xc,%esp
80107471:	50                   	push   %eax
80107472:	e8 61 e0 ff ff       	call   801054d8 <kill>
80107477:	83 c4 10             	add    $0x10,%esp
8010747a:	c9                   	leave  
8010747b:	c3                   	ret    

8010747c <sys_getpid>:
8010747c:	55                   	push   %ebp
8010747d:	89 e5                	mov    %esp,%ebp
8010747f:	83 ec 08             	sub    $0x8,%esp
80107482:	e8 8f ce ff ff       	call   80104316 <myproc>
80107487:	8b 40 10             	mov    0x10(%eax),%eax
8010748a:	c9                   	leave  
8010748b:	c3                   	ret    

8010748c <sys_sbrk>:
8010748c:	55                   	push   %ebp
8010748d:	89 e5                	mov    %esp,%ebp
8010748f:	83 ec 18             	sub    $0x18,%esp
80107492:	83 ec 08             	sub    $0x8,%esp
80107495:	8d 45 f0             	lea    -0x10(%ebp),%eax
80107498:	50                   	push   %eax
80107499:	6a 00                	push   $0x0
8010749b:	e8 c0 f0 ff ff       	call   80106560 <argint>
801074a0:	83 c4 10             	add    $0x10,%esp
801074a3:	85 c0                	test   %eax,%eax
801074a5:	79 07                	jns    801074ae <sys_sbrk+0x22>
801074a7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801074ac:	eb 27                	jmp    801074d5 <sys_sbrk+0x49>
801074ae:	e8 63 ce ff ff       	call   80104316 <myproc>
801074b3:	8b 00                	mov    (%eax),%eax
801074b5:	89 45 f4             	mov    %eax,-0xc(%ebp)
801074b8:	8b 45 f0             	mov    -0x10(%ebp),%eax
801074bb:	83 ec 0c             	sub    $0xc,%esp
801074be:	50                   	push   %eax
801074bf:	e8 01 d1 ff ff       	call   801045c5 <growproc>
801074c4:	83 c4 10             	add    $0x10,%esp
801074c7:	85 c0                	test   %eax,%eax
801074c9:	79 07                	jns    801074d2 <sys_sbrk+0x46>
801074cb:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801074d0:	eb 03                	jmp    801074d5 <sys_sbrk+0x49>
801074d2:	8b 45 f4             	mov    -0xc(%ebp),%eax
801074d5:	c9                   	leave  
801074d6:	c3                   	ret    

801074d7 <sys_sleep>:
801074d7:	55                   	push   %ebp
801074d8:	89 e5                	mov    %esp,%ebp
801074da:	83 ec 18             	sub    $0x18,%esp
801074dd:	83 ec 08             	sub    $0x8,%esp
801074e0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801074e3:	50                   	push   %eax
801074e4:	6a 00                	push   $0x0
801074e6:	e8 75 f0 ff ff       	call   80106560 <argint>
801074eb:	83 c4 10             	add    $0x10,%esp
801074ee:	85 c0                	test   %eax,%eax
801074f0:	79 07                	jns    801074f9 <sys_sleep+0x22>
801074f2:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801074f7:	eb 76                	jmp    8010756f <sys_sleep+0x98>
801074f9:	83 ec 0c             	sub    $0xc,%esp
801074fc:	68 00 73 11 80       	push   $0x80117300
80107501:	e8 a9 ea ff ff       	call   80105faf <acquire>
80107506:	83 c4 10             	add    $0x10,%esp
80107509:	a1 34 73 11 80       	mov    0x80117334,%eax
8010750e:	89 45 f4             	mov    %eax,-0xc(%ebp)
80107511:	eb 38                	jmp    8010754b <sys_sleep+0x74>
80107513:	e8 fe cd ff ff       	call   80104316 <myproc>
80107518:	8b 40 24             	mov    0x24(%eax),%eax
8010751b:	85 c0                	test   %eax,%eax
8010751d:	74 17                	je     80107536 <sys_sleep+0x5f>
8010751f:	83 ec 0c             	sub    $0xc,%esp
80107522:	68 00 73 11 80       	push   $0x80117300
80107527:	e8 f1 ea ff ff       	call   8010601d <release>
8010752c:	83 c4 10             	add    $0x10,%esp
8010752f:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107534:	eb 39                	jmp    8010756f <sys_sleep+0x98>
80107536:	83 ec 08             	sub    $0x8,%esp
80107539:	68 00 73 11 80       	push   $0x80117300
8010753e:	68 34 73 11 80       	push   $0x80117334
80107543:	e8 db dd ff ff       	call   80105323 <sleep>
80107548:	83 c4 10             	add    $0x10,%esp
8010754b:	a1 34 73 11 80       	mov    0x80117334,%eax
80107550:	2b 45 f4             	sub    -0xc(%ebp),%eax
80107553:	8b 55 f0             	mov    -0x10(%ebp),%edx
80107556:	39 d0                	cmp    %edx,%eax
80107558:	72 b9                	jb     80107513 <sys_sleep+0x3c>
8010755a:	83 ec 0c             	sub    $0xc,%esp
8010755d:	68 00 73 11 80       	push   $0x80117300
80107562:	e8 b6 ea ff ff       	call   8010601d <release>
80107567:	83 c4 10             	add    $0x10,%esp
8010756a:	b8 00 00 00 00       	mov    $0x0,%eax
8010756f:	c9                   	leave  
80107570:	c3                   	ret    

80107571 <sys_uptime>:
80107571:	55                   	push   %ebp
80107572:	89 e5                	mov    %esp,%ebp
80107574:	83 ec 18             	sub    $0x18,%esp
80107577:	83 ec 0c             	sub    $0xc,%esp
8010757a:	68 00 73 11 80       	push   $0x80117300
8010757f:	e8 2b ea ff ff       	call   80105faf <acquire>
80107584:	83 c4 10             	add    $0x10,%esp
80107587:	a1 34 73 11 80       	mov    0x80117334,%eax
8010758c:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010758f:	83 ec 0c             	sub    $0xc,%esp
80107592:	68 00 73 11 80       	push   $0x80117300
80107597:	e8 81 ea ff ff       	call   8010601d <release>
8010759c:	83 c4 10             	add    $0x10,%esp
8010759f:	8b 45 f4             	mov    -0xc(%ebp),%eax
801075a2:	c9                   	leave  
801075a3:	c3                   	ret    

801075a4 <sys_print_proc>:
801075a4:	55                   	push   %ebp
801075a5:	89 e5                	mov    %esp,%ebp
801075a7:	83 ec 08             	sub    $0x8,%esp
801075aa:	e8 bb e2 ff ff       	call   8010586a <print_proc>
801075af:	90                   	nop
801075b0:	c9                   	leave  
801075b1:	c3                   	ret    

801075b2 <sys_change_queue>:
801075b2:	55                   	push   %ebp
801075b3:	89 e5                	mov    %esp,%ebp
801075b5:	83 ec 18             	sub    $0x18,%esp
801075b8:	83 ec 08             	sub    $0x8,%esp
801075bb:	8d 45 f4             	lea    -0xc(%ebp),%eax
801075be:	50                   	push   %eax
801075bf:	6a 00                	push   $0x0
801075c1:	e8 9a ef ff ff       	call   80106560 <argint>
801075c6:	83 c4 10             	add    $0x10,%esp
801075c9:	85 c0                	test   %eax,%eax
801075cb:	78 34                	js     80107601 <sys_change_queue+0x4f>
801075cd:	83 ec 08             	sub    $0x8,%esp
801075d0:	8d 45 f0             	lea    -0x10(%ebp),%eax
801075d3:	50                   	push   %eax
801075d4:	6a 01                	push   $0x1
801075d6:	e8 85 ef ff ff       	call   80106560 <argint>
801075db:	83 c4 10             	add    $0x10,%esp
801075de:	85 c0                	test   %eax,%eax
801075e0:	78 1f                	js     80107601 <sys_change_queue+0x4f>
801075e2:	8b 45 f0             	mov    -0x10(%ebp),%eax
801075e5:	85 c0                	test   %eax,%eax
801075e7:	74 1f                	je     80107608 <sys_change_queue+0x56>
801075e9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801075ec:	83 f8 01             	cmp    $0x1,%eax
801075ef:	74 17                	je     80107608 <sys_change_queue+0x56>
801075f1:	8b 45 f0             	mov    -0x10(%ebp),%eax
801075f4:	83 f8 02             	cmp    $0x2,%eax
801075f7:	74 0f                	je     80107608 <sys_change_queue+0x56>
801075f9:	8b 45 f0             	mov    -0x10(%ebp),%eax
801075fc:	83 f8 03             	cmp    $0x3,%eax
801075ff:	74 07                	je     80107608 <sys_change_queue+0x56>
80107601:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107606:	eb 18                	jmp    80107620 <sys_change_queue+0x6e>
80107608:	8b 55 f0             	mov    -0x10(%ebp),%edx
8010760b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010760e:	83 ec 08             	sub    $0x8,%esp
80107611:	52                   	push   %edx
80107612:	50                   	push   %eax
80107613:	e8 3d e6 ff ff       	call   80105c55 <change_queue>
80107618:	83 c4 10             	add    $0x10,%esp
8010761b:	b8 00 00 00 00       	mov    $0x0,%eax
80107620:	c9                   	leave  
80107621:	c3                   	ret    

80107622 <alltraps>:
80107622:	1e                   	push   %ds
80107623:	06                   	push   %es
80107624:	0f a0                	push   %fs
80107626:	0f a8                	push   %gs
80107628:	60                   	pusha  
80107629:	66 b8 10 00          	mov    $0x10,%ax
8010762d:	8e d8                	mov    %eax,%ds
8010762f:	8e c0                	mov    %eax,%es
80107631:	54                   	push   %esp
80107632:	e8 d7 01 00 00       	call   8010780e <trap>
80107637:	83 c4 04             	add    $0x4,%esp

8010763a <trapret>:
8010763a:	61                   	popa   
8010763b:	0f a9                	pop    %gs
8010763d:	0f a1                	pop    %fs
8010763f:	07                   	pop    %es
80107640:	1f                   	pop    %ds
80107641:	83 c4 08             	add    $0x8,%esp
80107644:	cf                   	iret   

80107645 <lidt>:
80107645:	55                   	push   %ebp
80107646:	89 e5                	mov    %esp,%ebp
80107648:	83 ec 10             	sub    $0x10,%esp
8010764b:	8b 45 0c             	mov    0xc(%ebp),%eax
8010764e:	83 e8 01             	sub    $0x1,%eax
80107651:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
80107655:	8b 45 08             	mov    0x8(%ebp),%eax
80107658:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
8010765c:	8b 45 08             	mov    0x8(%ebp),%eax
8010765f:	c1 e8 10             	shr    $0x10,%eax
80107662:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
80107666:	8d 45 fa             	lea    -0x6(%ebp),%eax
80107669:	0f 01 18             	lidtl  (%eax)
8010766c:	90                   	nop
8010766d:	c9                   	leave  
8010766e:	c3                   	ret    

8010766f <rcr2>:
8010766f:	55                   	push   %ebp
80107670:	89 e5                	mov    %esp,%ebp
80107672:	83 ec 10             	sub    $0x10,%esp
80107675:	0f 20 d0             	mov    %cr2,%eax
80107678:	89 45 fc             	mov    %eax,-0x4(%ebp)
8010767b:	8b 45 fc             	mov    -0x4(%ebp),%eax
8010767e:	c9                   	leave  
8010767f:	c3                   	ret    

80107680 <tvinit>:
80107680:	55                   	push   %ebp
80107681:	89 e5                	mov    %esp,%ebp
80107683:	83 ec 18             	sub    $0x18,%esp
80107686:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
8010768d:	e9 c3 00 00 00       	jmp    80107755 <tvinit+0xd5>
80107692:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107695:	8b 04 85 80 c0 10 80 	mov    -0x7fef3f80(,%eax,4),%eax
8010769c:	89 c2                	mov    %eax,%edx
8010769e:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076a1:	66 89 14 c5 00 6b 11 	mov    %dx,-0x7fee9500(,%eax,8)
801076a8:	80 
801076a9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076ac:	66 c7 04 c5 02 6b 11 	movw   $0x8,-0x7fee94fe(,%eax,8)
801076b3:	80 08 00 
801076b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076b9:	0f b6 14 c5 04 6b 11 	movzbl -0x7fee94fc(,%eax,8),%edx
801076c0:	80 
801076c1:	83 e2 e0             	and    $0xffffffe0,%edx
801076c4:	88 14 c5 04 6b 11 80 	mov    %dl,-0x7fee94fc(,%eax,8)
801076cb:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076ce:	0f b6 14 c5 04 6b 11 	movzbl -0x7fee94fc(,%eax,8),%edx
801076d5:	80 
801076d6:	83 e2 1f             	and    $0x1f,%edx
801076d9:	88 14 c5 04 6b 11 80 	mov    %dl,-0x7fee94fc(,%eax,8)
801076e0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076e3:	0f b6 14 c5 05 6b 11 	movzbl -0x7fee94fb(,%eax,8),%edx
801076ea:	80 
801076eb:	83 e2 f0             	and    $0xfffffff0,%edx
801076ee:	83 ca 0e             	or     $0xe,%edx
801076f1:	88 14 c5 05 6b 11 80 	mov    %dl,-0x7fee94fb(,%eax,8)
801076f8:	8b 45 f4             	mov    -0xc(%ebp),%eax
801076fb:	0f b6 14 c5 05 6b 11 	movzbl -0x7fee94fb(,%eax,8),%edx
80107702:	80 
80107703:	83 e2 ef             	and    $0xffffffef,%edx
80107706:	88 14 c5 05 6b 11 80 	mov    %dl,-0x7fee94fb(,%eax,8)
8010770d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107710:	0f b6 14 c5 05 6b 11 	movzbl -0x7fee94fb(,%eax,8),%edx
80107717:	80 
80107718:	83 e2 9f             	and    $0xffffff9f,%edx
8010771b:	88 14 c5 05 6b 11 80 	mov    %dl,-0x7fee94fb(,%eax,8)
80107722:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107725:	0f b6 14 c5 05 6b 11 	movzbl -0x7fee94fb(,%eax,8),%edx
8010772c:	80 
8010772d:	83 ca 80             	or     $0xffffff80,%edx
80107730:	88 14 c5 05 6b 11 80 	mov    %dl,-0x7fee94fb(,%eax,8)
80107737:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010773a:	8b 04 85 80 c0 10 80 	mov    -0x7fef3f80(,%eax,4),%eax
80107741:	c1 e8 10             	shr    $0x10,%eax
80107744:	89 c2                	mov    %eax,%edx
80107746:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107749:	66 89 14 c5 06 6b 11 	mov    %dx,-0x7fee94fa(,%eax,8)
80107750:	80 
80107751:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80107755:	81 7d f4 ff 00 00 00 	cmpl   $0xff,-0xc(%ebp)
8010775c:	0f 8e 30 ff ff ff    	jle    80107692 <tvinit+0x12>
80107762:	a1 80 c1 10 80       	mov    0x8010c180,%eax
80107767:	66 a3 00 6d 11 80    	mov    %ax,0x80116d00
8010776d:	66 c7 05 02 6d 11 80 	movw   $0x8,0x80116d02
80107774:	08 00 
80107776:	0f b6 05 04 6d 11 80 	movzbl 0x80116d04,%eax
8010777d:	83 e0 e0             	and    $0xffffffe0,%eax
80107780:	a2 04 6d 11 80       	mov    %al,0x80116d04
80107785:	0f b6 05 04 6d 11 80 	movzbl 0x80116d04,%eax
8010778c:	83 e0 1f             	and    $0x1f,%eax
8010778f:	a2 04 6d 11 80       	mov    %al,0x80116d04
80107794:	0f b6 05 05 6d 11 80 	movzbl 0x80116d05,%eax
8010779b:	83 c8 0f             	or     $0xf,%eax
8010779e:	a2 05 6d 11 80       	mov    %al,0x80116d05
801077a3:	0f b6 05 05 6d 11 80 	movzbl 0x80116d05,%eax
801077aa:	83 e0 ef             	and    $0xffffffef,%eax
801077ad:	a2 05 6d 11 80       	mov    %al,0x80116d05
801077b2:	0f b6 05 05 6d 11 80 	movzbl 0x80116d05,%eax
801077b9:	83 c8 60             	or     $0x60,%eax
801077bc:	a2 05 6d 11 80       	mov    %al,0x80116d05
801077c1:	0f b6 05 05 6d 11 80 	movzbl 0x80116d05,%eax
801077c8:	83 c8 80             	or     $0xffffff80,%eax
801077cb:	a2 05 6d 11 80       	mov    %al,0x80116d05
801077d0:	a1 80 c1 10 80       	mov    0x8010c180,%eax
801077d5:	c1 e8 10             	shr    $0x10,%eax
801077d8:	66 a3 06 6d 11 80    	mov    %ax,0x80116d06
801077de:	83 ec 08             	sub    $0x8,%esp
801077e1:	68 40 9b 10 80       	push   $0x80109b40
801077e6:	68 00 73 11 80       	push   $0x80117300
801077eb:	e8 9d e7 ff ff       	call   80105f8d <initlock>
801077f0:	83 c4 10             	add    $0x10,%esp
801077f3:	90                   	nop
801077f4:	c9                   	leave  
801077f5:	c3                   	ret    

801077f6 <idtinit>:
801077f6:	55                   	push   %ebp
801077f7:	89 e5                	mov    %esp,%ebp
801077f9:	68 00 08 00 00       	push   $0x800
801077fe:	68 00 6b 11 80       	push   $0x80116b00
80107803:	e8 3d fe ff ff       	call   80107645 <lidt>
80107808:	83 c4 08             	add    $0x8,%esp
8010780b:	90                   	nop
8010780c:	c9                   	leave  
8010780d:	c3                   	ret    

8010780e <trap>:
8010780e:	55                   	push   %ebp
8010780f:	89 e5                	mov    %esp,%ebp
80107811:	57                   	push   %edi
80107812:	56                   	push   %esi
80107813:	53                   	push   %ebx
80107814:	83 ec 1c             	sub    $0x1c,%esp
80107817:	8b 45 08             	mov    0x8(%ebp),%eax
8010781a:	8b 40 30             	mov    0x30(%eax),%eax
8010781d:	83 f8 40             	cmp    $0x40,%eax
80107820:	75 3b                	jne    8010785d <trap+0x4f>
80107822:	e8 ef ca ff ff       	call   80104316 <myproc>
80107827:	8b 40 24             	mov    0x24(%eax),%eax
8010782a:	85 c0                	test   %eax,%eax
8010782c:	74 05                	je     80107833 <trap+0x25>
8010782e:	e8 17 d2 ff ff       	call   80104a4a <exit>
80107833:	e8 de ca ff ff       	call   80104316 <myproc>
80107838:	8b 55 08             	mov    0x8(%ebp),%edx
8010783b:	89 50 18             	mov    %edx,0x18(%eax)
8010783e:	e8 e9 ed ff ff       	call   8010662c <syscall>
80107843:	e8 ce ca ff ff       	call   80104316 <myproc>
80107848:	8b 40 24             	mov    0x24(%eax),%eax
8010784b:	85 c0                	test   %eax,%eax
8010784d:	0f 84 8a 02 00 00    	je     80107add <trap+0x2cf>
80107853:	e8 f2 d1 ff ff       	call   80104a4a <exit>
80107858:	e9 80 02 00 00       	jmp    80107add <trap+0x2cf>
8010785d:	8b 45 08             	mov    0x8(%ebp),%eax
80107860:	8b 40 30             	mov    0x30(%eax),%eax
80107863:	83 e8 20             	sub    $0x20,%eax
80107866:	83 f8 1f             	cmp    $0x1f,%eax
80107869:	0f 87 ba 00 00 00    	ja     80107929 <trap+0x11b>
8010786f:	8b 04 85 e8 9b 10 80 	mov    -0x7fef6418(,%eax,4),%eax
80107876:	ff e0                	jmp    *%eax
80107878:	e8 06 ca ff ff       	call   80104283 <cpuid>
8010787d:	85 c0                	test   %eax,%eax
8010787f:	75 42                	jne    801078c3 <trap+0xb5>
80107881:	83 ec 0c             	sub    $0xc,%esp
80107884:	68 00 73 11 80       	push   $0x80117300
80107889:	e8 21 e7 ff ff       	call   80105faf <acquire>
8010788e:	83 c4 10             	add    $0x10,%esp
80107891:	a1 34 73 11 80       	mov    0x80117334,%eax
80107896:	83 c0 01             	add    $0x1,%eax
80107899:	a3 34 73 11 80       	mov    %eax,0x80117334
8010789e:	e8 ed e2 ff ff       	call   80105b90 <agingMechanism>
801078a3:	83 ec 0c             	sub    $0xc,%esp
801078a6:	68 34 73 11 80       	push   $0x80117334
801078ab:	e8 f1 db ff ff       	call   801054a1 <wakeup>
801078b0:	83 c4 10             	add    $0x10,%esp
801078b3:	83 ec 0c             	sub    $0xc,%esp
801078b6:	68 00 73 11 80       	push   $0x80117300
801078bb:	e8 5d e7 ff ff       	call   8010601d <release>
801078c0:	83 c4 10             	add    $0x10,%esp
801078c3:	e8 4a b7 ff ff       	call   80103012 <lapiceoi>
801078c8:	e9 11 01 00 00       	jmp    801079de <trap+0x1d0>
801078cd:	e8 b4 af ff ff       	call   80102886 <ideintr>
801078d2:	e8 3b b7 ff ff       	call   80103012 <lapiceoi>
801078d7:	e9 02 01 00 00       	jmp    801079de <trap+0x1d0>
801078dc:	e8 76 b5 ff ff       	call   80102e57 <kbdintr>
801078e1:	e8 2c b7 ff ff       	call   80103012 <lapiceoi>
801078e6:	e9 f3 00 00 00       	jmp    801079de <trap+0x1d0>
801078eb:	e8 c3 03 00 00       	call   80107cb3 <uartintr>
801078f0:	e8 1d b7 ff ff       	call   80103012 <lapiceoi>
801078f5:	e9 e4 00 00 00       	jmp    801079de <trap+0x1d0>
801078fa:	8b 45 08             	mov    0x8(%ebp),%eax
801078fd:	8b 70 38             	mov    0x38(%eax),%esi
80107900:	8b 45 08             	mov    0x8(%ebp),%eax
80107903:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80107907:	0f b7 d8             	movzwl %ax,%ebx
8010790a:	e8 74 c9 ff ff       	call   80104283 <cpuid>
8010790f:	56                   	push   %esi
80107910:	53                   	push   %ebx
80107911:	50                   	push   %eax
80107912:	68 48 9b 10 80       	push   $0x80109b48
80107917:	e8 e4 8a ff ff       	call   80100400 <cprintf>
8010791c:	83 c4 10             	add    $0x10,%esp
8010791f:	e8 ee b6 ff ff       	call   80103012 <lapiceoi>
80107924:	e9 b5 00 00 00       	jmp    801079de <trap+0x1d0>
80107929:	e8 e8 c9 ff ff       	call   80104316 <myproc>
8010792e:	85 c0                	test   %eax,%eax
80107930:	74 11                	je     80107943 <trap+0x135>
80107932:	8b 45 08             	mov    0x8(%ebp),%eax
80107935:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80107939:	0f b7 c0             	movzwl %ax,%eax
8010793c:	83 e0 03             	and    $0x3,%eax
8010793f:	85 c0                	test   %eax,%eax
80107941:	75 39                	jne    8010797c <trap+0x16e>
80107943:	e8 27 fd ff ff       	call   8010766f <rcr2>
80107948:	89 c3                	mov    %eax,%ebx
8010794a:	8b 45 08             	mov    0x8(%ebp),%eax
8010794d:	8b 70 38             	mov    0x38(%eax),%esi
80107950:	e8 2e c9 ff ff       	call   80104283 <cpuid>
80107955:	8b 55 08             	mov    0x8(%ebp),%edx
80107958:	8b 52 30             	mov    0x30(%edx),%edx
8010795b:	83 ec 0c             	sub    $0xc,%esp
8010795e:	53                   	push   %ebx
8010795f:	56                   	push   %esi
80107960:	50                   	push   %eax
80107961:	52                   	push   %edx
80107962:	68 6c 9b 10 80       	push   $0x80109b6c
80107967:	e8 94 8a ff ff       	call   80100400 <cprintf>
8010796c:	83 c4 20             	add    $0x20,%esp
8010796f:	83 ec 0c             	sub    $0xc,%esp
80107972:	68 9e 9b 10 80       	push   $0x80109b9e
80107977:	e8 39 8c ff ff       	call   801005b5 <panic>
8010797c:	e8 ee fc ff ff       	call   8010766f <rcr2>
80107981:	89 c6                	mov    %eax,%esi
80107983:	8b 45 08             	mov    0x8(%ebp),%eax
80107986:	8b 40 38             	mov    0x38(%eax),%eax
80107989:	89 45 e4             	mov    %eax,-0x1c(%ebp)
8010798c:	e8 f2 c8 ff ff       	call   80104283 <cpuid>
80107991:	89 c3                	mov    %eax,%ebx
80107993:	8b 45 08             	mov    0x8(%ebp),%eax
80107996:	8b 48 34             	mov    0x34(%eax),%ecx
80107999:	89 4d e0             	mov    %ecx,-0x20(%ebp)
8010799c:	8b 45 08             	mov    0x8(%ebp),%eax
8010799f:	8b 78 30             	mov    0x30(%eax),%edi
801079a2:	e8 6f c9 ff ff       	call   80104316 <myproc>
801079a7:	8d 50 6c             	lea    0x6c(%eax),%edx
801079aa:	89 55 dc             	mov    %edx,-0x24(%ebp)
801079ad:	e8 64 c9 ff ff       	call   80104316 <myproc>
801079b2:	8b 40 10             	mov    0x10(%eax),%eax
801079b5:	56                   	push   %esi
801079b6:	ff 75 e4             	push   -0x1c(%ebp)
801079b9:	53                   	push   %ebx
801079ba:	ff 75 e0             	push   -0x20(%ebp)
801079bd:	57                   	push   %edi
801079be:	ff 75 dc             	push   -0x24(%ebp)
801079c1:	50                   	push   %eax
801079c2:	68 a4 9b 10 80       	push   $0x80109ba4
801079c7:	e8 34 8a ff ff       	call   80100400 <cprintf>
801079cc:	83 c4 20             	add    $0x20,%esp
801079cf:	e8 42 c9 ff ff       	call   80104316 <myproc>
801079d4:	c7 40 24 01 00 00 00 	movl   $0x1,0x24(%eax)
801079db:	eb 01                	jmp    801079de <trap+0x1d0>
801079dd:	90                   	nop
801079de:	e8 33 c9 ff ff       	call   80104316 <myproc>
801079e3:	85 c0                	test   %eax,%eax
801079e5:	74 23                	je     80107a0a <trap+0x1fc>
801079e7:	e8 2a c9 ff ff       	call   80104316 <myproc>
801079ec:	8b 40 24             	mov    0x24(%eax),%eax
801079ef:	85 c0                	test   %eax,%eax
801079f1:	74 17                	je     80107a0a <trap+0x1fc>
801079f3:	8b 45 08             	mov    0x8(%ebp),%eax
801079f6:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
801079fa:	0f b7 c0             	movzwl %ax,%eax
801079fd:	83 e0 03             	and    $0x3,%eax
80107a00:	83 f8 03             	cmp    $0x3,%eax
80107a03:	75 05                	jne    80107a0a <trap+0x1fc>
80107a05:	e8 40 d0 ff ff       	call   80104a4a <exit>
80107a0a:	e8 07 c9 ff ff       	call   80104316 <myproc>
80107a0f:	85 c0                	test   %eax,%eax
80107a11:	0f 84 98 00 00 00    	je     80107aaf <trap+0x2a1>
80107a17:	e8 fa c8 ff ff       	call   80104316 <myproc>
80107a1c:	8b 40 0c             	mov    0xc(%eax),%eax
80107a1f:	83 f8 04             	cmp    $0x4,%eax
80107a22:	0f 85 87 00 00 00    	jne    80107aaf <trap+0x2a1>
80107a28:	8b 45 08             	mov    0x8(%ebp),%eax
80107a2b:	8b 40 30             	mov    0x30(%eax),%eax
80107a2e:	83 f8 20             	cmp    $0x20,%eax
80107a31:	75 7c                	jne    80107aaf <trap+0x2a1>
80107a33:	e8 de c8 ff ff       	call   80104316 <myproc>
80107a38:	8b 90 9c 00 00 00    	mov    0x9c(%eax),%edx
80107a3e:	83 c2 01             	add    $0x1,%edx
80107a41:	89 90 9c 00 00 00    	mov    %edx,0x9c(%eax)
80107a47:	e8 ca c8 ff ff       	call   80104316 <myproc>
80107a4c:	8b 40 7c             	mov    0x7c(%eax),%eax
80107a4f:	83 f8 01             	cmp    $0x1,%eax
80107a52:	75 17                	jne    80107a6b <trap+0x25d>
80107a54:	e8 bd c8 ff ff       	call   80104316 <myproc>
80107a59:	8b 80 9c 00 00 00    	mov    0x9c(%eax),%eax
80107a5f:	83 f8 04             	cmp    $0x4,%eax
80107a62:	76 07                	jbe    80107a6b <trap+0x25d>
80107a64:	e8 69 d7 ff ff       	call   801051d2 <yield>
80107a69:	eb 44                	jmp    80107aaf <trap+0x2a1>
80107a6b:	e8 a6 c8 ff ff       	call   80104316 <myproc>
80107a70:	8b 40 7c             	mov    0x7c(%eax),%eax
80107a73:	85 c0                	test   %eax,%eax
80107a75:	74 0d                	je     80107a84 <trap+0x276>
80107a77:	e8 9a c8 ff ff       	call   80104316 <myproc>
80107a7c:	8b 40 7c             	mov    0x7c(%eax),%eax
80107a7f:	83 f8 02             	cmp    $0x2,%eax
80107a82:	75 07                	jne    80107a8b <trap+0x27d>
80107a84:	e8 49 d7 ff ff       	call   801051d2 <yield>
80107a89:	eb 24                	jmp    80107aaf <trap+0x2a1>
80107a8b:	e8 86 c8 ff ff       	call   80104316 <myproc>
80107a90:	8b 40 7c             	mov    0x7c(%eax),%eax
80107a93:	83 f8 03             	cmp    $0x3,%eax
80107a96:	75 17                	jne    80107aaf <trap+0x2a1>
80107a98:	e8 79 c8 ff ff       	call   80104316 <myproc>
80107a9d:	8b 80 9c 00 00 00    	mov    0x9c(%eax),%eax
80107aa3:	3d f4 01 00 00       	cmp    $0x1f4,%eax
80107aa8:	76 05                	jbe    80107aaf <trap+0x2a1>
80107aaa:	e8 23 d7 ff ff       	call   801051d2 <yield>
80107aaf:	e8 62 c8 ff ff       	call   80104316 <myproc>
80107ab4:	85 c0                	test   %eax,%eax
80107ab6:	74 26                	je     80107ade <trap+0x2d0>
80107ab8:	e8 59 c8 ff ff       	call   80104316 <myproc>
80107abd:	8b 40 24             	mov    0x24(%eax),%eax
80107ac0:	85 c0                	test   %eax,%eax
80107ac2:	74 1a                	je     80107ade <trap+0x2d0>
80107ac4:	8b 45 08             	mov    0x8(%ebp),%eax
80107ac7:	0f b7 40 3c          	movzwl 0x3c(%eax),%eax
80107acb:	0f b7 c0             	movzwl %ax,%eax
80107ace:	83 e0 03             	and    $0x3,%eax
80107ad1:	83 f8 03             	cmp    $0x3,%eax
80107ad4:	75 08                	jne    80107ade <trap+0x2d0>
80107ad6:	e8 6f cf ff ff       	call   80104a4a <exit>
80107adb:	eb 01                	jmp    80107ade <trap+0x2d0>
80107add:	90                   	nop
80107ade:	8d 65 f4             	lea    -0xc(%ebp),%esp
80107ae1:	5b                   	pop    %ebx
80107ae2:	5e                   	pop    %esi
80107ae3:	5f                   	pop    %edi
80107ae4:	5d                   	pop    %ebp
80107ae5:	c3                   	ret    

80107ae6 <inb>:
80107ae6:	55                   	push   %ebp
80107ae7:	89 e5                	mov    %esp,%ebp
80107ae9:	83 ec 14             	sub    $0x14,%esp
80107aec:	8b 45 08             	mov    0x8(%ebp),%eax
80107aef:	66 89 45 ec          	mov    %ax,-0x14(%ebp)
80107af3:	0f b7 45 ec          	movzwl -0x14(%ebp),%eax
80107af7:	89 c2                	mov    %eax,%edx
80107af9:	ec                   	in     (%dx),%al
80107afa:	88 45 ff             	mov    %al,-0x1(%ebp)
80107afd:	0f b6 45 ff          	movzbl -0x1(%ebp),%eax
80107b01:	c9                   	leave  
80107b02:	c3                   	ret    

80107b03 <outb>:
80107b03:	55                   	push   %ebp
80107b04:	89 e5                	mov    %esp,%ebp
80107b06:	83 ec 08             	sub    $0x8,%esp
80107b09:	8b 45 08             	mov    0x8(%ebp),%eax
80107b0c:	8b 55 0c             	mov    0xc(%ebp),%edx
80107b0f:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80107b13:	89 d0                	mov    %edx,%eax
80107b15:	88 45 f8             	mov    %al,-0x8(%ebp)
80107b18:	0f b6 45 f8          	movzbl -0x8(%ebp),%eax
80107b1c:	0f b7 55 fc          	movzwl -0x4(%ebp),%edx
80107b20:	ee                   	out    %al,(%dx)
80107b21:	90                   	nop
80107b22:	c9                   	leave  
80107b23:	c3                   	ret    

80107b24 <uartinit>:
80107b24:	55                   	push   %ebp
80107b25:	89 e5                	mov    %esp,%ebp
80107b27:	83 ec 18             	sub    $0x18,%esp
80107b2a:	6a 00                	push   $0x0
80107b2c:	68 fa 03 00 00       	push   $0x3fa
80107b31:	e8 cd ff ff ff       	call   80107b03 <outb>
80107b36:	83 c4 08             	add    $0x8,%esp
80107b39:	68 80 00 00 00       	push   $0x80
80107b3e:	68 fb 03 00 00       	push   $0x3fb
80107b43:	e8 bb ff ff ff       	call   80107b03 <outb>
80107b48:	83 c4 08             	add    $0x8,%esp
80107b4b:	6a 0c                	push   $0xc
80107b4d:	68 f8 03 00 00       	push   $0x3f8
80107b52:	e8 ac ff ff ff       	call   80107b03 <outb>
80107b57:	83 c4 08             	add    $0x8,%esp
80107b5a:	6a 00                	push   $0x0
80107b5c:	68 f9 03 00 00       	push   $0x3f9
80107b61:	e8 9d ff ff ff       	call   80107b03 <outb>
80107b66:	83 c4 08             	add    $0x8,%esp
80107b69:	6a 03                	push   $0x3
80107b6b:	68 fb 03 00 00       	push   $0x3fb
80107b70:	e8 8e ff ff ff       	call   80107b03 <outb>
80107b75:	83 c4 08             	add    $0x8,%esp
80107b78:	6a 00                	push   $0x0
80107b7a:	68 fc 03 00 00       	push   $0x3fc
80107b7f:	e8 7f ff ff ff       	call   80107b03 <outb>
80107b84:	83 c4 08             	add    $0x8,%esp
80107b87:	6a 01                	push   $0x1
80107b89:	68 f9 03 00 00       	push   $0x3f9
80107b8e:	e8 70 ff ff ff       	call   80107b03 <outb>
80107b93:	83 c4 08             	add    $0x8,%esp
80107b96:	68 fd 03 00 00       	push   $0x3fd
80107b9b:	e8 46 ff ff ff       	call   80107ae6 <inb>
80107ba0:	83 c4 04             	add    $0x4,%esp
80107ba3:	3c ff                	cmp    $0xff,%al
80107ba5:	74 61                	je     80107c08 <uartinit+0xe4>
80107ba7:	c7 05 38 73 11 80 01 	movl   $0x1,0x80117338
80107bae:	00 00 00 
80107bb1:	68 fa 03 00 00       	push   $0x3fa
80107bb6:	e8 2b ff ff ff       	call   80107ae6 <inb>
80107bbb:	83 c4 04             	add    $0x4,%esp
80107bbe:	68 f8 03 00 00       	push   $0x3f8
80107bc3:	e8 1e ff ff ff       	call   80107ae6 <inb>
80107bc8:	83 c4 04             	add    $0x4,%esp
80107bcb:	83 ec 08             	sub    $0x8,%esp
80107bce:	6a 00                	push   $0x0
80107bd0:	6a 04                	push   $0x4
80107bd2:	e8 4d af ff ff       	call   80102b24 <ioapicenable>
80107bd7:	83 c4 10             	add    $0x10,%esp
80107bda:	c7 45 f4 68 9c 10 80 	movl   $0x80109c68,-0xc(%ebp)
80107be1:	eb 19                	jmp    80107bfc <uartinit+0xd8>
80107be3:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107be6:	0f b6 00             	movzbl (%eax),%eax
80107be9:	0f be c0             	movsbl %al,%eax
80107bec:	83 ec 0c             	sub    $0xc,%esp
80107bef:	50                   	push   %eax
80107bf0:	e8 16 00 00 00       	call   80107c0b <uartputc>
80107bf5:	83 c4 10             	add    $0x10,%esp
80107bf8:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80107bfc:	8b 45 f4             	mov    -0xc(%ebp),%eax
80107bff:	0f b6 00             	movzbl (%eax),%eax
80107c02:	84 c0                	test   %al,%al
80107c04:	75 dd                	jne    80107be3 <uartinit+0xbf>
80107c06:	eb 01                	jmp    80107c09 <uartinit+0xe5>
80107c08:	90                   	nop
80107c09:	c9                   	leave  
80107c0a:	c3                   	ret    

80107c0b <uartputc>:
80107c0b:	55                   	push   %ebp
80107c0c:	89 e5                	mov    %esp,%ebp
80107c0e:	83 ec 18             	sub    $0x18,%esp
80107c11:	a1 38 73 11 80       	mov    0x80117338,%eax
80107c16:	85 c0                	test   %eax,%eax
80107c18:	74 53                	je     80107c6d <uartputc+0x62>
80107c1a:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80107c21:	eb 11                	jmp    80107c34 <uartputc+0x29>
80107c23:	83 ec 0c             	sub    $0xc,%esp
80107c26:	6a 0a                	push   $0xa
80107c28:	e8 00 b4 ff ff       	call   8010302d <microdelay>
80107c2d:	83 c4 10             	add    $0x10,%esp
80107c30:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
80107c34:	83 7d f4 7f          	cmpl   $0x7f,-0xc(%ebp)
80107c38:	7f 1a                	jg     80107c54 <uartputc+0x49>
80107c3a:	83 ec 0c             	sub    $0xc,%esp
80107c3d:	68 fd 03 00 00       	push   $0x3fd
80107c42:	e8 9f fe ff ff       	call   80107ae6 <inb>
80107c47:	83 c4 10             	add    $0x10,%esp
80107c4a:	0f b6 c0             	movzbl %al,%eax
80107c4d:	83 e0 20             	and    $0x20,%eax
80107c50:	85 c0                	test   %eax,%eax
80107c52:	74 cf                	je     80107c23 <uartputc+0x18>
80107c54:	8b 45 08             	mov    0x8(%ebp),%eax
80107c57:	0f b6 c0             	movzbl %al,%eax
80107c5a:	83 ec 08             	sub    $0x8,%esp
80107c5d:	50                   	push   %eax
80107c5e:	68 f8 03 00 00       	push   $0x3f8
80107c63:	e8 9b fe ff ff       	call   80107b03 <outb>
80107c68:	83 c4 10             	add    $0x10,%esp
80107c6b:	eb 01                	jmp    80107c6e <uartputc+0x63>
80107c6d:	90                   	nop
80107c6e:	c9                   	leave  
80107c6f:	c3                   	ret    

80107c70 <uartgetc>:
80107c70:	55                   	push   %ebp
80107c71:	89 e5                	mov    %esp,%ebp
80107c73:	a1 38 73 11 80       	mov    0x80117338,%eax
80107c78:	85 c0                	test   %eax,%eax
80107c7a:	75 07                	jne    80107c83 <uartgetc+0x13>
80107c7c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107c81:	eb 2e                	jmp    80107cb1 <uartgetc+0x41>
80107c83:	68 fd 03 00 00       	push   $0x3fd
80107c88:	e8 59 fe ff ff       	call   80107ae6 <inb>
80107c8d:	83 c4 04             	add    $0x4,%esp
80107c90:	0f b6 c0             	movzbl %al,%eax
80107c93:	83 e0 01             	and    $0x1,%eax
80107c96:	85 c0                	test   %eax,%eax
80107c98:	75 07                	jne    80107ca1 <uartgetc+0x31>
80107c9a:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80107c9f:	eb 10                	jmp    80107cb1 <uartgetc+0x41>
80107ca1:	68 f8 03 00 00       	push   $0x3f8
80107ca6:	e8 3b fe ff ff       	call   80107ae6 <inb>
80107cab:	83 c4 04             	add    $0x4,%esp
80107cae:	0f b6 c0             	movzbl %al,%eax
80107cb1:	c9                   	leave  
80107cb2:	c3                   	ret    

80107cb3 <uartintr>:
80107cb3:	55                   	push   %ebp
80107cb4:	89 e5                	mov    %esp,%ebp
80107cb6:	83 ec 08             	sub    $0x8,%esp
80107cb9:	83 ec 0c             	sub    $0xc,%esp
80107cbc:	68 70 7c 10 80       	push   $0x80107c70
80107cc1:	e8 89 8b ff ff       	call   8010084f <consoleintr>
80107cc6:	83 c4 10             	add    $0x10,%esp
80107cc9:	90                   	nop
80107cca:	c9                   	leave  
80107ccb:	c3                   	ret    

80107ccc <vector0>:
80107ccc:	6a 00                	push   $0x0
80107cce:	6a 00                	push   $0x0
80107cd0:	e9 4d f9 ff ff       	jmp    80107622 <alltraps>

80107cd5 <vector1>:
80107cd5:	6a 00                	push   $0x0
80107cd7:	6a 01                	push   $0x1
80107cd9:	e9 44 f9 ff ff       	jmp    80107622 <alltraps>

80107cde <vector2>:
80107cde:	6a 00                	push   $0x0
80107ce0:	6a 02                	push   $0x2
80107ce2:	e9 3b f9 ff ff       	jmp    80107622 <alltraps>

80107ce7 <vector3>:
80107ce7:	6a 00                	push   $0x0
80107ce9:	6a 03                	push   $0x3
80107ceb:	e9 32 f9 ff ff       	jmp    80107622 <alltraps>

80107cf0 <vector4>:
80107cf0:	6a 00                	push   $0x0
80107cf2:	6a 04                	push   $0x4
80107cf4:	e9 29 f9 ff ff       	jmp    80107622 <alltraps>

80107cf9 <vector5>:
80107cf9:	6a 00                	push   $0x0
80107cfb:	6a 05                	push   $0x5
80107cfd:	e9 20 f9 ff ff       	jmp    80107622 <alltraps>

80107d02 <vector6>:
80107d02:	6a 00                	push   $0x0
80107d04:	6a 06                	push   $0x6
80107d06:	e9 17 f9 ff ff       	jmp    80107622 <alltraps>

80107d0b <vector7>:
80107d0b:	6a 00                	push   $0x0
80107d0d:	6a 07                	push   $0x7
80107d0f:	e9 0e f9 ff ff       	jmp    80107622 <alltraps>

80107d14 <vector8>:
80107d14:	6a 08                	push   $0x8
80107d16:	e9 07 f9 ff ff       	jmp    80107622 <alltraps>

80107d1b <vector9>:
80107d1b:	6a 00                	push   $0x0
80107d1d:	6a 09                	push   $0x9
80107d1f:	e9 fe f8 ff ff       	jmp    80107622 <alltraps>

80107d24 <vector10>:
80107d24:	6a 0a                	push   $0xa
80107d26:	e9 f7 f8 ff ff       	jmp    80107622 <alltraps>

80107d2b <vector11>:
80107d2b:	6a 0b                	push   $0xb
80107d2d:	e9 f0 f8 ff ff       	jmp    80107622 <alltraps>

80107d32 <vector12>:
80107d32:	6a 0c                	push   $0xc
80107d34:	e9 e9 f8 ff ff       	jmp    80107622 <alltraps>

80107d39 <vector13>:
80107d39:	6a 0d                	push   $0xd
80107d3b:	e9 e2 f8 ff ff       	jmp    80107622 <alltraps>

80107d40 <vector14>:
80107d40:	6a 0e                	push   $0xe
80107d42:	e9 db f8 ff ff       	jmp    80107622 <alltraps>

80107d47 <vector15>:
80107d47:	6a 00                	push   $0x0
80107d49:	6a 0f                	push   $0xf
80107d4b:	e9 d2 f8 ff ff       	jmp    80107622 <alltraps>

80107d50 <vector16>:
80107d50:	6a 00                	push   $0x0
80107d52:	6a 10                	push   $0x10
80107d54:	e9 c9 f8 ff ff       	jmp    80107622 <alltraps>

80107d59 <vector17>:
80107d59:	6a 11                	push   $0x11
80107d5b:	e9 c2 f8 ff ff       	jmp    80107622 <alltraps>

80107d60 <vector18>:
80107d60:	6a 00                	push   $0x0
80107d62:	6a 12                	push   $0x12
80107d64:	e9 b9 f8 ff ff       	jmp    80107622 <alltraps>

80107d69 <vector19>:
80107d69:	6a 00                	push   $0x0
80107d6b:	6a 13                	push   $0x13
80107d6d:	e9 b0 f8 ff ff       	jmp    80107622 <alltraps>

80107d72 <vector20>:
80107d72:	6a 00                	push   $0x0
80107d74:	6a 14                	push   $0x14
80107d76:	e9 a7 f8 ff ff       	jmp    80107622 <alltraps>

80107d7b <vector21>:
80107d7b:	6a 00                	push   $0x0
80107d7d:	6a 15                	push   $0x15
80107d7f:	e9 9e f8 ff ff       	jmp    80107622 <alltraps>

80107d84 <vector22>:
80107d84:	6a 00                	push   $0x0
80107d86:	6a 16                	push   $0x16
80107d88:	e9 95 f8 ff ff       	jmp    80107622 <alltraps>

80107d8d <vector23>:
80107d8d:	6a 00                	push   $0x0
80107d8f:	6a 17                	push   $0x17
80107d91:	e9 8c f8 ff ff       	jmp    80107622 <alltraps>

80107d96 <vector24>:
80107d96:	6a 00                	push   $0x0
80107d98:	6a 18                	push   $0x18
80107d9a:	e9 83 f8 ff ff       	jmp    80107622 <alltraps>

80107d9f <vector25>:
80107d9f:	6a 00                	push   $0x0
80107da1:	6a 19                	push   $0x19
80107da3:	e9 7a f8 ff ff       	jmp    80107622 <alltraps>

80107da8 <vector26>:
80107da8:	6a 00                	push   $0x0
80107daa:	6a 1a                	push   $0x1a
80107dac:	e9 71 f8 ff ff       	jmp    80107622 <alltraps>

80107db1 <vector27>:
80107db1:	6a 00                	push   $0x0
80107db3:	6a 1b                	push   $0x1b
80107db5:	e9 68 f8 ff ff       	jmp    80107622 <alltraps>

80107dba <vector28>:
80107dba:	6a 00                	push   $0x0
80107dbc:	6a 1c                	push   $0x1c
80107dbe:	e9 5f f8 ff ff       	jmp    80107622 <alltraps>

80107dc3 <vector29>:
80107dc3:	6a 00                	push   $0x0
80107dc5:	6a 1d                	push   $0x1d
80107dc7:	e9 56 f8 ff ff       	jmp    80107622 <alltraps>

80107dcc <vector30>:
80107dcc:	6a 00                	push   $0x0
80107dce:	6a 1e                	push   $0x1e
80107dd0:	e9 4d f8 ff ff       	jmp    80107622 <alltraps>

80107dd5 <vector31>:
80107dd5:	6a 00                	push   $0x0
80107dd7:	6a 1f                	push   $0x1f
80107dd9:	e9 44 f8 ff ff       	jmp    80107622 <alltraps>

80107dde <vector32>:
80107dde:	6a 00                	push   $0x0
80107de0:	6a 20                	push   $0x20
80107de2:	e9 3b f8 ff ff       	jmp    80107622 <alltraps>

80107de7 <vector33>:
80107de7:	6a 00                	push   $0x0
80107de9:	6a 21                	push   $0x21
80107deb:	e9 32 f8 ff ff       	jmp    80107622 <alltraps>

80107df0 <vector34>:
80107df0:	6a 00                	push   $0x0
80107df2:	6a 22                	push   $0x22
80107df4:	e9 29 f8 ff ff       	jmp    80107622 <alltraps>

80107df9 <vector35>:
80107df9:	6a 00                	push   $0x0
80107dfb:	6a 23                	push   $0x23
80107dfd:	e9 20 f8 ff ff       	jmp    80107622 <alltraps>

80107e02 <vector36>:
80107e02:	6a 00                	push   $0x0
80107e04:	6a 24                	push   $0x24
80107e06:	e9 17 f8 ff ff       	jmp    80107622 <alltraps>

80107e0b <vector37>:
80107e0b:	6a 00                	push   $0x0
80107e0d:	6a 25                	push   $0x25
80107e0f:	e9 0e f8 ff ff       	jmp    80107622 <alltraps>

80107e14 <vector38>:
80107e14:	6a 00                	push   $0x0
80107e16:	6a 26                	push   $0x26
80107e18:	e9 05 f8 ff ff       	jmp    80107622 <alltraps>

80107e1d <vector39>:
80107e1d:	6a 00                	push   $0x0
80107e1f:	6a 27                	push   $0x27
80107e21:	e9 fc f7 ff ff       	jmp    80107622 <alltraps>

80107e26 <vector40>:
80107e26:	6a 00                	push   $0x0
80107e28:	6a 28                	push   $0x28
80107e2a:	e9 f3 f7 ff ff       	jmp    80107622 <alltraps>

80107e2f <vector41>:
80107e2f:	6a 00                	push   $0x0
80107e31:	6a 29                	push   $0x29
80107e33:	e9 ea f7 ff ff       	jmp    80107622 <alltraps>

80107e38 <vector42>:
80107e38:	6a 00                	push   $0x0
80107e3a:	6a 2a                	push   $0x2a
80107e3c:	e9 e1 f7 ff ff       	jmp    80107622 <alltraps>

80107e41 <vector43>:
80107e41:	6a 00                	push   $0x0
80107e43:	6a 2b                	push   $0x2b
80107e45:	e9 d8 f7 ff ff       	jmp    80107622 <alltraps>

80107e4a <vector44>:
80107e4a:	6a 00                	push   $0x0
80107e4c:	6a 2c                	push   $0x2c
80107e4e:	e9 cf f7 ff ff       	jmp    80107622 <alltraps>

80107e53 <vector45>:
80107e53:	6a 00                	push   $0x0
80107e55:	6a 2d                	push   $0x2d
80107e57:	e9 c6 f7 ff ff       	jmp    80107622 <alltraps>

80107e5c <vector46>:
80107e5c:	6a 00                	push   $0x0
80107e5e:	6a 2e                	push   $0x2e
80107e60:	e9 bd f7 ff ff       	jmp    80107622 <alltraps>

80107e65 <vector47>:
80107e65:	6a 00                	push   $0x0
80107e67:	6a 2f                	push   $0x2f
80107e69:	e9 b4 f7 ff ff       	jmp    80107622 <alltraps>

80107e6e <vector48>:
80107e6e:	6a 00                	push   $0x0
80107e70:	6a 30                	push   $0x30
80107e72:	e9 ab f7 ff ff       	jmp    80107622 <alltraps>

80107e77 <vector49>:
80107e77:	6a 00                	push   $0x0
80107e79:	6a 31                	push   $0x31
80107e7b:	e9 a2 f7 ff ff       	jmp    80107622 <alltraps>

80107e80 <vector50>:
80107e80:	6a 00                	push   $0x0
80107e82:	6a 32                	push   $0x32
80107e84:	e9 99 f7 ff ff       	jmp    80107622 <alltraps>

80107e89 <vector51>:
80107e89:	6a 00                	push   $0x0
80107e8b:	6a 33                	push   $0x33
80107e8d:	e9 90 f7 ff ff       	jmp    80107622 <alltraps>

80107e92 <vector52>:
80107e92:	6a 00                	push   $0x0
80107e94:	6a 34                	push   $0x34
80107e96:	e9 87 f7 ff ff       	jmp    80107622 <alltraps>

80107e9b <vector53>:
80107e9b:	6a 00                	push   $0x0
80107e9d:	6a 35                	push   $0x35
80107e9f:	e9 7e f7 ff ff       	jmp    80107622 <alltraps>

80107ea4 <vector54>:
80107ea4:	6a 00                	push   $0x0
80107ea6:	6a 36                	push   $0x36
80107ea8:	e9 75 f7 ff ff       	jmp    80107622 <alltraps>

80107ead <vector55>:
80107ead:	6a 00                	push   $0x0
80107eaf:	6a 37                	push   $0x37
80107eb1:	e9 6c f7 ff ff       	jmp    80107622 <alltraps>

80107eb6 <vector56>:
80107eb6:	6a 00                	push   $0x0
80107eb8:	6a 38                	push   $0x38
80107eba:	e9 63 f7 ff ff       	jmp    80107622 <alltraps>

80107ebf <vector57>:
80107ebf:	6a 00                	push   $0x0
80107ec1:	6a 39                	push   $0x39
80107ec3:	e9 5a f7 ff ff       	jmp    80107622 <alltraps>

80107ec8 <vector58>:
80107ec8:	6a 00                	push   $0x0
80107eca:	6a 3a                	push   $0x3a
80107ecc:	e9 51 f7 ff ff       	jmp    80107622 <alltraps>

80107ed1 <vector59>:
80107ed1:	6a 00                	push   $0x0
80107ed3:	6a 3b                	push   $0x3b
80107ed5:	e9 48 f7 ff ff       	jmp    80107622 <alltraps>

80107eda <vector60>:
80107eda:	6a 00                	push   $0x0
80107edc:	6a 3c                	push   $0x3c
80107ede:	e9 3f f7 ff ff       	jmp    80107622 <alltraps>

80107ee3 <vector61>:
80107ee3:	6a 00                	push   $0x0
80107ee5:	6a 3d                	push   $0x3d
80107ee7:	e9 36 f7 ff ff       	jmp    80107622 <alltraps>

80107eec <vector62>:
80107eec:	6a 00                	push   $0x0
80107eee:	6a 3e                	push   $0x3e
80107ef0:	e9 2d f7 ff ff       	jmp    80107622 <alltraps>

80107ef5 <vector63>:
80107ef5:	6a 00                	push   $0x0
80107ef7:	6a 3f                	push   $0x3f
80107ef9:	e9 24 f7 ff ff       	jmp    80107622 <alltraps>

80107efe <vector64>:
80107efe:	6a 00                	push   $0x0
80107f00:	6a 40                	push   $0x40
80107f02:	e9 1b f7 ff ff       	jmp    80107622 <alltraps>

80107f07 <vector65>:
80107f07:	6a 00                	push   $0x0
80107f09:	6a 41                	push   $0x41
80107f0b:	e9 12 f7 ff ff       	jmp    80107622 <alltraps>

80107f10 <vector66>:
80107f10:	6a 00                	push   $0x0
80107f12:	6a 42                	push   $0x42
80107f14:	e9 09 f7 ff ff       	jmp    80107622 <alltraps>

80107f19 <vector67>:
80107f19:	6a 00                	push   $0x0
80107f1b:	6a 43                	push   $0x43
80107f1d:	e9 00 f7 ff ff       	jmp    80107622 <alltraps>

80107f22 <vector68>:
80107f22:	6a 00                	push   $0x0
80107f24:	6a 44                	push   $0x44
80107f26:	e9 f7 f6 ff ff       	jmp    80107622 <alltraps>

80107f2b <vector69>:
80107f2b:	6a 00                	push   $0x0
80107f2d:	6a 45                	push   $0x45
80107f2f:	e9 ee f6 ff ff       	jmp    80107622 <alltraps>

80107f34 <vector70>:
80107f34:	6a 00                	push   $0x0
80107f36:	6a 46                	push   $0x46
80107f38:	e9 e5 f6 ff ff       	jmp    80107622 <alltraps>

80107f3d <vector71>:
80107f3d:	6a 00                	push   $0x0
80107f3f:	6a 47                	push   $0x47
80107f41:	e9 dc f6 ff ff       	jmp    80107622 <alltraps>

80107f46 <vector72>:
80107f46:	6a 00                	push   $0x0
80107f48:	6a 48                	push   $0x48
80107f4a:	e9 d3 f6 ff ff       	jmp    80107622 <alltraps>

80107f4f <vector73>:
80107f4f:	6a 00                	push   $0x0
80107f51:	6a 49                	push   $0x49
80107f53:	e9 ca f6 ff ff       	jmp    80107622 <alltraps>

80107f58 <vector74>:
80107f58:	6a 00                	push   $0x0
80107f5a:	6a 4a                	push   $0x4a
80107f5c:	e9 c1 f6 ff ff       	jmp    80107622 <alltraps>

80107f61 <vector75>:
80107f61:	6a 00                	push   $0x0
80107f63:	6a 4b                	push   $0x4b
80107f65:	e9 b8 f6 ff ff       	jmp    80107622 <alltraps>

80107f6a <vector76>:
80107f6a:	6a 00                	push   $0x0
80107f6c:	6a 4c                	push   $0x4c
80107f6e:	e9 af f6 ff ff       	jmp    80107622 <alltraps>

80107f73 <vector77>:
80107f73:	6a 00                	push   $0x0
80107f75:	6a 4d                	push   $0x4d
80107f77:	e9 a6 f6 ff ff       	jmp    80107622 <alltraps>

80107f7c <vector78>:
80107f7c:	6a 00                	push   $0x0
80107f7e:	6a 4e                	push   $0x4e
80107f80:	e9 9d f6 ff ff       	jmp    80107622 <alltraps>

80107f85 <vector79>:
80107f85:	6a 00                	push   $0x0
80107f87:	6a 4f                	push   $0x4f
80107f89:	e9 94 f6 ff ff       	jmp    80107622 <alltraps>

80107f8e <vector80>:
80107f8e:	6a 00                	push   $0x0
80107f90:	6a 50                	push   $0x50
80107f92:	e9 8b f6 ff ff       	jmp    80107622 <alltraps>

80107f97 <vector81>:
80107f97:	6a 00                	push   $0x0
80107f99:	6a 51                	push   $0x51
80107f9b:	e9 82 f6 ff ff       	jmp    80107622 <alltraps>

80107fa0 <vector82>:
80107fa0:	6a 00                	push   $0x0
80107fa2:	6a 52                	push   $0x52
80107fa4:	e9 79 f6 ff ff       	jmp    80107622 <alltraps>

80107fa9 <vector83>:
80107fa9:	6a 00                	push   $0x0
80107fab:	6a 53                	push   $0x53
80107fad:	e9 70 f6 ff ff       	jmp    80107622 <alltraps>

80107fb2 <vector84>:
80107fb2:	6a 00                	push   $0x0
80107fb4:	6a 54                	push   $0x54
80107fb6:	e9 67 f6 ff ff       	jmp    80107622 <alltraps>

80107fbb <vector85>:
80107fbb:	6a 00                	push   $0x0
80107fbd:	6a 55                	push   $0x55
80107fbf:	e9 5e f6 ff ff       	jmp    80107622 <alltraps>

80107fc4 <vector86>:
80107fc4:	6a 00                	push   $0x0
80107fc6:	6a 56                	push   $0x56
80107fc8:	e9 55 f6 ff ff       	jmp    80107622 <alltraps>

80107fcd <vector87>:
80107fcd:	6a 00                	push   $0x0
80107fcf:	6a 57                	push   $0x57
80107fd1:	e9 4c f6 ff ff       	jmp    80107622 <alltraps>

80107fd6 <vector88>:
80107fd6:	6a 00                	push   $0x0
80107fd8:	6a 58                	push   $0x58
80107fda:	e9 43 f6 ff ff       	jmp    80107622 <alltraps>

80107fdf <vector89>:
80107fdf:	6a 00                	push   $0x0
80107fe1:	6a 59                	push   $0x59
80107fe3:	e9 3a f6 ff ff       	jmp    80107622 <alltraps>

80107fe8 <vector90>:
80107fe8:	6a 00                	push   $0x0
80107fea:	6a 5a                	push   $0x5a
80107fec:	e9 31 f6 ff ff       	jmp    80107622 <alltraps>

80107ff1 <vector91>:
80107ff1:	6a 00                	push   $0x0
80107ff3:	6a 5b                	push   $0x5b
80107ff5:	e9 28 f6 ff ff       	jmp    80107622 <alltraps>

80107ffa <vector92>:
80107ffa:	6a 00                	push   $0x0
80107ffc:	6a 5c                	push   $0x5c
80107ffe:	e9 1f f6 ff ff       	jmp    80107622 <alltraps>

80108003 <vector93>:
80108003:	6a 00                	push   $0x0
80108005:	6a 5d                	push   $0x5d
80108007:	e9 16 f6 ff ff       	jmp    80107622 <alltraps>

8010800c <vector94>:
8010800c:	6a 00                	push   $0x0
8010800e:	6a 5e                	push   $0x5e
80108010:	e9 0d f6 ff ff       	jmp    80107622 <alltraps>

80108015 <vector95>:
80108015:	6a 00                	push   $0x0
80108017:	6a 5f                	push   $0x5f
80108019:	e9 04 f6 ff ff       	jmp    80107622 <alltraps>

8010801e <vector96>:
8010801e:	6a 00                	push   $0x0
80108020:	6a 60                	push   $0x60
80108022:	e9 fb f5 ff ff       	jmp    80107622 <alltraps>

80108027 <vector97>:
80108027:	6a 00                	push   $0x0
80108029:	6a 61                	push   $0x61
8010802b:	e9 f2 f5 ff ff       	jmp    80107622 <alltraps>

80108030 <vector98>:
80108030:	6a 00                	push   $0x0
80108032:	6a 62                	push   $0x62
80108034:	e9 e9 f5 ff ff       	jmp    80107622 <alltraps>

80108039 <vector99>:
80108039:	6a 00                	push   $0x0
8010803b:	6a 63                	push   $0x63
8010803d:	e9 e0 f5 ff ff       	jmp    80107622 <alltraps>

80108042 <vector100>:
80108042:	6a 00                	push   $0x0
80108044:	6a 64                	push   $0x64
80108046:	e9 d7 f5 ff ff       	jmp    80107622 <alltraps>

8010804b <vector101>:
8010804b:	6a 00                	push   $0x0
8010804d:	6a 65                	push   $0x65
8010804f:	e9 ce f5 ff ff       	jmp    80107622 <alltraps>

80108054 <vector102>:
80108054:	6a 00                	push   $0x0
80108056:	6a 66                	push   $0x66
80108058:	e9 c5 f5 ff ff       	jmp    80107622 <alltraps>

8010805d <vector103>:
8010805d:	6a 00                	push   $0x0
8010805f:	6a 67                	push   $0x67
80108061:	e9 bc f5 ff ff       	jmp    80107622 <alltraps>

80108066 <vector104>:
80108066:	6a 00                	push   $0x0
80108068:	6a 68                	push   $0x68
8010806a:	e9 b3 f5 ff ff       	jmp    80107622 <alltraps>

8010806f <vector105>:
8010806f:	6a 00                	push   $0x0
80108071:	6a 69                	push   $0x69
80108073:	e9 aa f5 ff ff       	jmp    80107622 <alltraps>

80108078 <vector106>:
80108078:	6a 00                	push   $0x0
8010807a:	6a 6a                	push   $0x6a
8010807c:	e9 a1 f5 ff ff       	jmp    80107622 <alltraps>

80108081 <vector107>:
80108081:	6a 00                	push   $0x0
80108083:	6a 6b                	push   $0x6b
80108085:	e9 98 f5 ff ff       	jmp    80107622 <alltraps>

8010808a <vector108>:
8010808a:	6a 00                	push   $0x0
8010808c:	6a 6c                	push   $0x6c
8010808e:	e9 8f f5 ff ff       	jmp    80107622 <alltraps>

80108093 <vector109>:
80108093:	6a 00                	push   $0x0
80108095:	6a 6d                	push   $0x6d
80108097:	e9 86 f5 ff ff       	jmp    80107622 <alltraps>

8010809c <vector110>:
8010809c:	6a 00                	push   $0x0
8010809e:	6a 6e                	push   $0x6e
801080a0:	e9 7d f5 ff ff       	jmp    80107622 <alltraps>

801080a5 <vector111>:
801080a5:	6a 00                	push   $0x0
801080a7:	6a 6f                	push   $0x6f
801080a9:	e9 74 f5 ff ff       	jmp    80107622 <alltraps>

801080ae <vector112>:
801080ae:	6a 00                	push   $0x0
801080b0:	6a 70                	push   $0x70
801080b2:	e9 6b f5 ff ff       	jmp    80107622 <alltraps>

801080b7 <vector113>:
801080b7:	6a 00                	push   $0x0
801080b9:	6a 71                	push   $0x71
801080bb:	e9 62 f5 ff ff       	jmp    80107622 <alltraps>

801080c0 <vector114>:
801080c0:	6a 00                	push   $0x0
801080c2:	6a 72                	push   $0x72
801080c4:	e9 59 f5 ff ff       	jmp    80107622 <alltraps>

801080c9 <vector115>:
801080c9:	6a 00                	push   $0x0
801080cb:	6a 73                	push   $0x73
801080cd:	e9 50 f5 ff ff       	jmp    80107622 <alltraps>

801080d2 <vector116>:
801080d2:	6a 00                	push   $0x0
801080d4:	6a 74                	push   $0x74
801080d6:	e9 47 f5 ff ff       	jmp    80107622 <alltraps>

801080db <vector117>:
801080db:	6a 00                	push   $0x0
801080dd:	6a 75                	push   $0x75
801080df:	e9 3e f5 ff ff       	jmp    80107622 <alltraps>

801080e4 <vector118>:
801080e4:	6a 00                	push   $0x0
801080e6:	6a 76                	push   $0x76
801080e8:	e9 35 f5 ff ff       	jmp    80107622 <alltraps>

801080ed <vector119>:
801080ed:	6a 00                	push   $0x0
801080ef:	6a 77                	push   $0x77
801080f1:	e9 2c f5 ff ff       	jmp    80107622 <alltraps>

801080f6 <vector120>:
801080f6:	6a 00                	push   $0x0
801080f8:	6a 78                	push   $0x78
801080fa:	e9 23 f5 ff ff       	jmp    80107622 <alltraps>

801080ff <vector121>:
801080ff:	6a 00                	push   $0x0
80108101:	6a 79                	push   $0x79
80108103:	e9 1a f5 ff ff       	jmp    80107622 <alltraps>

80108108 <vector122>:
80108108:	6a 00                	push   $0x0
8010810a:	6a 7a                	push   $0x7a
8010810c:	e9 11 f5 ff ff       	jmp    80107622 <alltraps>

80108111 <vector123>:
80108111:	6a 00                	push   $0x0
80108113:	6a 7b                	push   $0x7b
80108115:	e9 08 f5 ff ff       	jmp    80107622 <alltraps>

8010811a <vector124>:
8010811a:	6a 00                	push   $0x0
8010811c:	6a 7c                	push   $0x7c
8010811e:	e9 ff f4 ff ff       	jmp    80107622 <alltraps>

80108123 <vector125>:
80108123:	6a 00                	push   $0x0
80108125:	6a 7d                	push   $0x7d
80108127:	e9 f6 f4 ff ff       	jmp    80107622 <alltraps>

8010812c <vector126>:
8010812c:	6a 00                	push   $0x0
8010812e:	6a 7e                	push   $0x7e
80108130:	e9 ed f4 ff ff       	jmp    80107622 <alltraps>

80108135 <vector127>:
80108135:	6a 00                	push   $0x0
80108137:	6a 7f                	push   $0x7f
80108139:	e9 e4 f4 ff ff       	jmp    80107622 <alltraps>

8010813e <vector128>:
8010813e:	6a 00                	push   $0x0
80108140:	68 80 00 00 00       	push   $0x80
80108145:	e9 d8 f4 ff ff       	jmp    80107622 <alltraps>

8010814a <vector129>:
8010814a:	6a 00                	push   $0x0
8010814c:	68 81 00 00 00       	push   $0x81
80108151:	e9 cc f4 ff ff       	jmp    80107622 <alltraps>

80108156 <vector130>:
80108156:	6a 00                	push   $0x0
80108158:	68 82 00 00 00       	push   $0x82
8010815d:	e9 c0 f4 ff ff       	jmp    80107622 <alltraps>

80108162 <vector131>:
80108162:	6a 00                	push   $0x0
80108164:	68 83 00 00 00       	push   $0x83
80108169:	e9 b4 f4 ff ff       	jmp    80107622 <alltraps>

8010816e <vector132>:
8010816e:	6a 00                	push   $0x0
80108170:	68 84 00 00 00       	push   $0x84
80108175:	e9 a8 f4 ff ff       	jmp    80107622 <alltraps>

8010817a <vector133>:
8010817a:	6a 00                	push   $0x0
8010817c:	68 85 00 00 00       	push   $0x85
80108181:	e9 9c f4 ff ff       	jmp    80107622 <alltraps>

80108186 <vector134>:
80108186:	6a 00                	push   $0x0
80108188:	68 86 00 00 00       	push   $0x86
8010818d:	e9 90 f4 ff ff       	jmp    80107622 <alltraps>

80108192 <vector135>:
80108192:	6a 00                	push   $0x0
80108194:	68 87 00 00 00       	push   $0x87
80108199:	e9 84 f4 ff ff       	jmp    80107622 <alltraps>

8010819e <vector136>:
8010819e:	6a 00                	push   $0x0
801081a0:	68 88 00 00 00       	push   $0x88
801081a5:	e9 78 f4 ff ff       	jmp    80107622 <alltraps>

801081aa <vector137>:
801081aa:	6a 00                	push   $0x0
801081ac:	68 89 00 00 00       	push   $0x89
801081b1:	e9 6c f4 ff ff       	jmp    80107622 <alltraps>

801081b6 <vector138>:
801081b6:	6a 00                	push   $0x0
801081b8:	68 8a 00 00 00       	push   $0x8a
801081bd:	e9 60 f4 ff ff       	jmp    80107622 <alltraps>

801081c2 <vector139>:
801081c2:	6a 00                	push   $0x0
801081c4:	68 8b 00 00 00       	push   $0x8b
801081c9:	e9 54 f4 ff ff       	jmp    80107622 <alltraps>

801081ce <vector140>:
801081ce:	6a 00                	push   $0x0
801081d0:	68 8c 00 00 00       	push   $0x8c
801081d5:	e9 48 f4 ff ff       	jmp    80107622 <alltraps>

801081da <vector141>:
801081da:	6a 00                	push   $0x0
801081dc:	68 8d 00 00 00       	push   $0x8d
801081e1:	e9 3c f4 ff ff       	jmp    80107622 <alltraps>

801081e6 <vector142>:
801081e6:	6a 00                	push   $0x0
801081e8:	68 8e 00 00 00       	push   $0x8e
801081ed:	e9 30 f4 ff ff       	jmp    80107622 <alltraps>

801081f2 <vector143>:
801081f2:	6a 00                	push   $0x0
801081f4:	68 8f 00 00 00       	push   $0x8f
801081f9:	e9 24 f4 ff ff       	jmp    80107622 <alltraps>

801081fe <vector144>:
801081fe:	6a 00                	push   $0x0
80108200:	68 90 00 00 00       	push   $0x90
80108205:	e9 18 f4 ff ff       	jmp    80107622 <alltraps>

8010820a <vector145>:
8010820a:	6a 00                	push   $0x0
8010820c:	68 91 00 00 00       	push   $0x91
80108211:	e9 0c f4 ff ff       	jmp    80107622 <alltraps>

80108216 <vector146>:
80108216:	6a 00                	push   $0x0
80108218:	68 92 00 00 00       	push   $0x92
8010821d:	e9 00 f4 ff ff       	jmp    80107622 <alltraps>

80108222 <vector147>:
80108222:	6a 00                	push   $0x0
80108224:	68 93 00 00 00       	push   $0x93
80108229:	e9 f4 f3 ff ff       	jmp    80107622 <alltraps>

8010822e <vector148>:
8010822e:	6a 00                	push   $0x0
80108230:	68 94 00 00 00       	push   $0x94
80108235:	e9 e8 f3 ff ff       	jmp    80107622 <alltraps>

8010823a <vector149>:
8010823a:	6a 00                	push   $0x0
8010823c:	68 95 00 00 00       	push   $0x95
80108241:	e9 dc f3 ff ff       	jmp    80107622 <alltraps>

80108246 <vector150>:
80108246:	6a 00                	push   $0x0
80108248:	68 96 00 00 00       	push   $0x96
8010824d:	e9 d0 f3 ff ff       	jmp    80107622 <alltraps>

80108252 <vector151>:
80108252:	6a 00                	push   $0x0
80108254:	68 97 00 00 00       	push   $0x97
80108259:	e9 c4 f3 ff ff       	jmp    80107622 <alltraps>

8010825e <vector152>:
8010825e:	6a 00                	push   $0x0
80108260:	68 98 00 00 00       	push   $0x98
80108265:	e9 b8 f3 ff ff       	jmp    80107622 <alltraps>

8010826a <vector153>:
8010826a:	6a 00                	push   $0x0
8010826c:	68 99 00 00 00       	push   $0x99
80108271:	e9 ac f3 ff ff       	jmp    80107622 <alltraps>

80108276 <vector154>:
80108276:	6a 00                	push   $0x0
80108278:	68 9a 00 00 00       	push   $0x9a
8010827d:	e9 a0 f3 ff ff       	jmp    80107622 <alltraps>

80108282 <vector155>:
80108282:	6a 00                	push   $0x0
80108284:	68 9b 00 00 00       	push   $0x9b
80108289:	e9 94 f3 ff ff       	jmp    80107622 <alltraps>

8010828e <vector156>:
8010828e:	6a 00                	push   $0x0
80108290:	68 9c 00 00 00       	push   $0x9c
80108295:	e9 88 f3 ff ff       	jmp    80107622 <alltraps>

8010829a <vector157>:
8010829a:	6a 00                	push   $0x0
8010829c:	68 9d 00 00 00       	push   $0x9d
801082a1:	e9 7c f3 ff ff       	jmp    80107622 <alltraps>

801082a6 <vector158>:
801082a6:	6a 00                	push   $0x0
801082a8:	68 9e 00 00 00       	push   $0x9e
801082ad:	e9 70 f3 ff ff       	jmp    80107622 <alltraps>

801082b2 <vector159>:
801082b2:	6a 00                	push   $0x0
801082b4:	68 9f 00 00 00       	push   $0x9f
801082b9:	e9 64 f3 ff ff       	jmp    80107622 <alltraps>

801082be <vector160>:
801082be:	6a 00                	push   $0x0
801082c0:	68 a0 00 00 00       	push   $0xa0
801082c5:	e9 58 f3 ff ff       	jmp    80107622 <alltraps>

801082ca <vector161>:
801082ca:	6a 00                	push   $0x0
801082cc:	68 a1 00 00 00       	push   $0xa1
801082d1:	e9 4c f3 ff ff       	jmp    80107622 <alltraps>

801082d6 <vector162>:
801082d6:	6a 00                	push   $0x0
801082d8:	68 a2 00 00 00       	push   $0xa2
801082dd:	e9 40 f3 ff ff       	jmp    80107622 <alltraps>

801082e2 <vector163>:
801082e2:	6a 00                	push   $0x0
801082e4:	68 a3 00 00 00       	push   $0xa3
801082e9:	e9 34 f3 ff ff       	jmp    80107622 <alltraps>

801082ee <vector164>:
801082ee:	6a 00                	push   $0x0
801082f0:	68 a4 00 00 00       	push   $0xa4
801082f5:	e9 28 f3 ff ff       	jmp    80107622 <alltraps>

801082fa <vector165>:
801082fa:	6a 00                	push   $0x0
801082fc:	68 a5 00 00 00       	push   $0xa5
80108301:	e9 1c f3 ff ff       	jmp    80107622 <alltraps>

80108306 <vector166>:
80108306:	6a 00                	push   $0x0
80108308:	68 a6 00 00 00       	push   $0xa6
8010830d:	e9 10 f3 ff ff       	jmp    80107622 <alltraps>

80108312 <vector167>:
80108312:	6a 00                	push   $0x0
80108314:	68 a7 00 00 00       	push   $0xa7
80108319:	e9 04 f3 ff ff       	jmp    80107622 <alltraps>

8010831e <vector168>:
8010831e:	6a 00                	push   $0x0
80108320:	68 a8 00 00 00       	push   $0xa8
80108325:	e9 f8 f2 ff ff       	jmp    80107622 <alltraps>

8010832a <vector169>:
8010832a:	6a 00                	push   $0x0
8010832c:	68 a9 00 00 00       	push   $0xa9
80108331:	e9 ec f2 ff ff       	jmp    80107622 <alltraps>

80108336 <vector170>:
80108336:	6a 00                	push   $0x0
80108338:	68 aa 00 00 00       	push   $0xaa
8010833d:	e9 e0 f2 ff ff       	jmp    80107622 <alltraps>

80108342 <vector171>:
80108342:	6a 00                	push   $0x0
80108344:	68 ab 00 00 00       	push   $0xab
80108349:	e9 d4 f2 ff ff       	jmp    80107622 <alltraps>

8010834e <vector172>:
8010834e:	6a 00                	push   $0x0
80108350:	68 ac 00 00 00       	push   $0xac
80108355:	e9 c8 f2 ff ff       	jmp    80107622 <alltraps>

8010835a <vector173>:
8010835a:	6a 00                	push   $0x0
8010835c:	68 ad 00 00 00       	push   $0xad
80108361:	e9 bc f2 ff ff       	jmp    80107622 <alltraps>

80108366 <vector174>:
80108366:	6a 00                	push   $0x0
80108368:	68 ae 00 00 00       	push   $0xae
8010836d:	e9 b0 f2 ff ff       	jmp    80107622 <alltraps>

80108372 <vector175>:
80108372:	6a 00                	push   $0x0
80108374:	68 af 00 00 00       	push   $0xaf
80108379:	e9 a4 f2 ff ff       	jmp    80107622 <alltraps>

8010837e <vector176>:
8010837e:	6a 00                	push   $0x0
80108380:	68 b0 00 00 00       	push   $0xb0
80108385:	e9 98 f2 ff ff       	jmp    80107622 <alltraps>

8010838a <vector177>:
8010838a:	6a 00                	push   $0x0
8010838c:	68 b1 00 00 00       	push   $0xb1
80108391:	e9 8c f2 ff ff       	jmp    80107622 <alltraps>

80108396 <vector178>:
80108396:	6a 00                	push   $0x0
80108398:	68 b2 00 00 00       	push   $0xb2
8010839d:	e9 80 f2 ff ff       	jmp    80107622 <alltraps>

801083a2 <vector179>:
801083a2:	6a 00                	push   $0x0
801083a4:	68 b3 00 00 00       	push   $0xb3
801083a9:	e9 74 f2 ff ff       	jmp    80107622 <alltraps>

801083ae <vector180>:
801083ae:	6a 00                	push   $0x0
801083b0:	68 b4 00 00 00       	push   $0xb4
801083b5:	e9 68 f2 ff ff       	jmp    80107622 <alltraps>

801083ba <vector181>:
801083ba:	6a 00                	push   $0x0
801083bc:	68 b5 00 00 00       	push   $0xb5
801083c1:	e9 5c f2 ff ff       	jmp    80107622 <alltraps>

801083c6 <vector182>:
801083c6:	6a 00                	push   $0x0
801083c8:	68 b6 00 00 00       	push   $0xb6
801083cd:	e9 50 f2 ff ff       	jmp    80107622 <alltraps>

801083d2 <vector183>:
801083d2:	6a 00                	push   $0x0
801083d4:	68 b7 00 00 00       	push   $0xb7
801083d9:	e9 44 f2 ff ff       	jmp    80107622 <alltraps>

801083de <vector184>:
801083de:	6a 00                	push   $0x0
801083e0:	68 b8 00 00 00       	push   $0xb8
801083e5:	e9 38 f2 ff ff       	jmp    80107622 <alltraps>

801083ea <vector185>:
801083ea:	6a 00                	push   $0x0
801083ec:	68 b9 00 00 00       	push   $0xb9
801083f1:	e9 2c f2 ff ff       	jmp    80107622 <alltraps>

801083f6 <vector186>:
801083f6:	6a 00                	push   $0x0
801083f8:	68 ba 00 00 00       	push   $0xba
801083fd:	e9 20 f2 ff ff       	jmp    80107622 <alltraps>

80108402 <vector187>:
80108402:	6a 00                	push   $0x0
80108404:	68 bb 00 00 00       	push   $0xbb
80108409:	e9 14 f2 ff ff       	jmp    80107622 <alltraps>

8010840e <vector188>:
8010840e:	6a 00                	push   $0x0
80108410:	68 bc 00 00 00       	push   $0xbc
80108415:	e9 08 f2 ff ff       	jmp    80107622 <alltraps>

8010841a <vector189>:
8010841a:	6a 00                	push   $0x0
8010841c:	68 bd 00 00 00       	push   $0xbd
80108421:	e9 fc f1 ff ff       	jmp    80107622 <alltraps>

80108426 <vector190>:
80108426:	6a 00                	push   $0x0
80108428:	68 be 00 00 00       	push   $0xbe
8010842d:	e9 f0 f1 ff ff       	jmp    80107622 <alltraps>

80108432 <vector191>:
80108432:	6a 00                	push   $0x0
80108434:	68 bf 00 00 00       	push   $0xbf
80108439:	e9 e4 f1 ff ff       	jmp    80107622 <alltraps>

8010843e <vector192>:
8010843e:	6a 00                	push   $0x0
80108440:	68 c0 00 00 00       	push   $0xc0
80108445:	e9 d8 f1 ff ff       	jmp    80107622 <alltraps>

8010844a <vector193>:
8010844a:	6a 00                	push   $0x0
8010844c:	68 c1 00 00 00       	push   $0xc1
80108451:	e9 cc f1 ff ff       	jmp    80107622 <alltraps>

80108456 <vector194>:
80108456:	6a 00                	push   $0x0
80108458:	68 c2 00 00 00       	push   $0xc2
8010845d:	e9 c0 f1 ff ff       	jmp    80107622 <alltraps>

80108462 <vector195>:
80108462:	6a 00                	push   $0x0
80108464:	68 c3 00 00 00       	push   $0xc3
80108469:	e9 b4 f1 ff ff       	jmp    80107622 <alltraps>

8010846e <vector196>:
8010846e:	6a 00                	push   $0x0
80108470:	68 c4 00 00 00       	push   $0xc4
80108475:	e9 a8 f1 ff ff       	jmp    80107622 <alltraps>

8010847a <vector197>:
8010847a:	6a 00                	push   $0x0
8010847c:	68 c5 00 00 00       	push   $0xc5
80108481:	e9 9c f1 ff ff       	jmp    80107622 <alltraps>

80108486 <vector198>:
80108486:	6a 00                	push   $0x0
80108488:	68 c6 00 00 00       	push   $0xc6
8010848d:	e9 90 f1 ff ff       	jmp    80107622 <alltraps>

80108492 <vector199>:
80108492:	6a 00                	push   $0x0
80108494:	68 c7 00 00 00       	push   $0xc7
80108499:	e9 84 f1 ff ff       	jmp    80107622 <alltraps>

8010849e <vector200>:
8010849e:	6a 00                	push   $0x0
801084a0:	68 c8 00 00 00       	push   $0xc8
801084a5:	e9 78 f1 ff ff       	jmp    80107622 <alltraps>

801084aa <vector201>:
801084aa:	6a 00                	push   $0x0
801084ac:	68 c9 00 00 00       	push   $0xc9
801084b1:	e9 6c f1 ff ff       	jmp    80107622 <alltraps>

801084b6 <vector202>:
801084b6:	6a 00                	push   $0x0
801084b8:	68 ca 00 00 00       	push   $0xca
801084bd:	e9 60 f1 ff ff       	jmp    80107622 <alltraps>

801084c2 <vector203>:
801084c2:	6a 00                	push   $0x0
801084c4:	68 cb 00 00 00       	push   $0xcb
801084c9:	e9 54 f1 ff ff       	jmp    80107622 <alltraps>

801084ce <vector204>:
801084ce:	6a 00                	push   $0x0
801084d0:	68 cc 00 00 00       	push   $0xcc
801084d5:	e9 48 f1 ff ff       	jmp    80107622 <alltraps>

801084da <vector205>:
801084da:	6a 00                	push   $0x0
801084dc:	68 cd 00 00 00       	push   $0xcd
801084e1:	e9 3c f1 ff ff       	jmp    80107622 <alltraps>

801084e6 <vector206>:
801084e6:	6a 00                	push   $0x0
801084e8:	68 ce 00 00 00       	push   $0xce
801084ed:	e9 30 f1 ff ff       	jmp    80107622 <alltraps>

801084f2 <vector207>:
801084f2:	6a 00                	push   $0x0
801084f4:	68 cf 00 00 00       	push   $0xcf
801084f9:	e9 24 f1 ff ff       	jmp    80107622 <alltraps>

801084fe <vector208>:
801084fe:	6a 00                	push   $0x0
80108500:	68 d0 00 00 00       	push   $0xd0
80108505:	e9 18 f1 ff ff       	jmp    80107622 <alltraps>

8010850a <vector209>:
8010850a:	6a 00                	push   $0x0
8010850c:	68 d1 00 00 00       	push   $0xd1
80108511:	e9 0c f1 ff ff       	jmp    80107622 <alltraps>

80108516 <vector210>:
80108516:	6a 00                	push   $0x0
80108518:	68 d2 00 00 00       	push   $0xd2
8010851d:	e9 00 f1 ff ff       	jmp    80107622 <alltraps>

80108522 <vector211>:
80108522:	6a 00                	push   $0x0
80108524:	68 d3 00 00 00       	push   $0xd3
80108529:	e9 f4 f0 ff ff       	jmp    80107622 <alltraps>

8010852e <vector212>:
8010852e:	6a 00                	push   $0x0
80108530:	68 d4 00 00 00       	push   $0xd4
80108535:	e9 e8 f0 ff ff       	jmp    80107622 <alltraps>

8010853a <vector213>:
8010853a:	6a 00                	push   $0x0
8010853c:	68 d5 00 00 00       	push   $0xd5
80108541:	e9 dc f0 ff ff       	jmp    80107622 <alltraps>

80108546 <vector214>:
80108546:	6a 00                	push   $0x0
80108548:	68 d6 00 00 00       	push   $0xd6
8010854d:	e9 d0 f0 ff ff       	jmp    80107622 <alltraps>

80108552 <vector215>:
80108552:	6a 00                	push   $0x0
80108554:	68 d7 00 00 00       	push   $0xd7
80108559:	e9 c4 f0 ff ff       	jmp    80107622 <alltraps>

8010855e <vector216>:
8010855e:	6a 00                	push   $0x0
80108560:	68 d8 00 00 00       	push   $0xd8
80108565:	e9 b8 f0 ff ff       	jmp    80107622 <alltraps>

8010856a <vector217>:
8010856a:	6a 00                	push   $0x0
8010856c:	68 d9 00 00 00       	push   $0xd9
80108571:	e9 ac f0 ff ff       	jmp    80107622 <alltraps>

80108576 <vector218>:
80108576:	6a 00                	push   $0x0
80108578:	68 da 00 00 00       	push   $0xda
8010857d:	e9 a0 f0 ff ff       	jmp    80107622 <alltraps>

80108582 <vector219>:
80108582:	6a 00                	push   $0x0
80108584:	68 db 00 00 00       	push   $0xdb
80108589:	e9 94 f0 ff ff       	jmp    80107622 <alltraps>

8010858e <vector220>:
8010858e:	6a 00                	push   $0x0
80108590:	68 dc 00 00 00       	push   $0xdc
80108595:	e9 88 f0 ff ff       	jmp    80107622 <alltraps>

8010859a <vector221>:
8010859a:	6a 00                	push   $0x0
8010859c:	68 dd 00 00 00       	push   $0xdd
801085a1:	e9 7c f0 ff ff       	jmp    80107622 <alltraps>

801085a6 <vector222>:
801085a6:	6a 00                	push   $0x0
801085a8:	68 de 00 00 00       	push   $0xde
801085ad:	e9 70 f0 ff ff       	jmp    80107622 <alltraps>

801085b2 <vector223>:
801085b2:	6a 00                	push   $0x0
801085b4:	68 df 00 00 00       	push   $0xdf
801085b9:	e9 64 f0 ff ff       	jmp    80107622 <alltraps>

801085be <vector224>:
801085be:	6a 00                	push   $0x0
801085c0:	68 e0 00 00 00       	push   $0xe0
801085c5:	e9 58 f0 ff ff       	jmp    80107622 <alltraps>

801085ca <vector225>:
801085ca:	6a 00                	push   $0x0
801085cc:	68 e1 00 00 00       	push   $0xe1
801085d1:	e9 4c f0 ff ff       	jmp    80107622 <alltraps>

801085d6 <vector226>:
801085d6:	6a 00                	push   $0x0
801085d8:	68 e2 00 00 00       	push   $0xe2
801085dd:	e9 40 f0 ff ff       	jmp    80107622 <alltraps>

801085e2 <vector227>:
801085e2:	6a 00                	push   $0x0
801085e4:	68 e3 00 00 00       	push   $0xe3
801085e9:	e9 34 f0 ff ff       	jmp    80107622 <alltraps>

801085ee <vector228>:
801085ee:	6a 00                	push   $0x0
801085f0:	68 e4 00 00 00       	push   $0xe4
801085f5:	e9 28 f0 ff ff       	jmp    80107622 <alltraps>

801085fa <vector229>:
801085fa:	6a 00                	push   $0x0
801085fc:	68 e5 00 00 00       	push   $0xe5
80108601:	e9 1c f0 ff ff       	jmp    80107622 <alltraps>

80108606 <vector230>:
80108606:	6a 00                	push   $0x0
80108608:	68 e6 00 00 00       	push   $0xe6
8010860d:	e9 10 f0 ff ff       	jmp    80107622 <alltraps>

80108612 <vector231>:
80108612:	6a 00                	push   $0x0
80108614:	68 e7 00 00 00       	push   $0xe7
80108619:	e9 04 f0 ff ff       	jmp    80107622 <alltraps>

8010861e <vector232>:
8010861e:	6a 00                	push   $0x0
80108620:	68 e8 00 00 00       	push   $0xe8
80108625:	e9 f8 ef ff ff       	jmp    80107622 <alltraps>

8010862a <vector233>:
8010862a:	6a 00                	push   $0x0
8010862c:	68 e9 00 00 00       	push   $0xe9
80108631:	e9 ec ef ff ff       	jmp    80107622 <alltraps>

80108636 <vector234>:
80108636:	6a 00                	push   $0x0
80108638:	68 ea 00 00 00       	push   $0xea
8010863d:	e9 e0 ef ff ff       	jmp    80107622 <alltraps>

80108642 <vector235>:
80108642:	6a 00                	push   $0x0
80108644:	68 eb 00 00 00       	push   $0xeb
80108649:	e9 d4 ef ff ff       	jmp    80107622 <alltraps>

8010864e <vector236>:
8010864e:	6a 00                	push   $0x0
80108650:	68 ec 00 00 00       	push   $0xec
80108655:	e9 c8 ef ff ff       	jmp    80107622 <alltraps>

8010865a <vector237>:
8010865a:	6a 00                	push   $0x0
8010865c:	68 ed 00 00 00       	push   $0xed
80108661:	e9 bc ef ff ff       	jmp    80107622 <alltraps>

80108666 <vector238>:
80108666:	6a 00                	push   $0x0
80108668:	68 ee 00 00 00       	push   $0xee
8010866d:	e9 b0 ef ff ff       	jmp    80107622 <alltraps>

80108672 <vector239>:
80108672:	6a 00                	push   $0x0
80108674:	68 ef 00 00 00       	push   $0xef
80108679:	e9 a4 ef ff ff       	jmp    80107622 <alltraps>

8010867e <vector240>:
8010867e:	6a 00                	push   $0x0
80108680:	68 f0 00 00 00       	push   $0xf0
80108685:	e9 98 ef ff ff       	jmp    80107622 <alltraps>

8010868a <vector241>:
8010868a:	6a 00                	push   $0x0
8010868c:	68 f1 00 00 00       	push   $0xf1
80108691:	e9 8c ef ff ff       	jmp    80107622 <alltraps>

80108696 <vector242>:
80108696:	6a 00                	push   $0x0
80108698:	68 f2 00 00 00       	push   $0xf2
8010869d:	e9 80 ef ff ff       	jmp    80107622 <alltraps>

801086a2 <vector243>:
801086a2:	6a 00                	push   $0x0
801086a4:	68 f3 00 00 00       	push   $0xf3
801086a9:	e9 74 ef ff ff       	jmp    80107622 <alltraps>

801086ae <vector244>:
801086ae:	6a 00                	push   $0x0
801086b0:	68 f4 00 00 00       	push   $0xf4
801086b5:	e9 68 ef ff ff       	jmp    80107622 <alltraps>

801086ba <vector245>:
801086ba:	6a 00                	push   $0x0
801086bc:	68 f5 00 00 00       	push   $0xf5
801086c1:	e9 5c ef ff ff       	jmp    80107622 <alltraps>

801086c6 <vector246>:
801086c6:	6a 00                	push   $0x0
801086c8:	68 f6 00 00 00       	push   $0xf6
801086cd:	e9 50 ef ff ff       	jmp    80107622 <alltraps>

801086d2 <vector247>:
801086d2:	6a 00                	push   $0x0
801086d4:	68 f7 00 00 00       	push   $0xf7
801086d9:	e9 44 ef ff ff       	jmp    80107622 <alltraps>

801086de <vector248>:
801086de:	6a 00                	push   $0x0
801086e0:	68 f8 00 00 00       	push   $0xf8
801086e5:	e9 38 ef ff ff       	jmp    80107622 <alltraps>

801086ea <vector249>:
801086ea:	6a 00                	push   $0x0
801086ec:	68 f9 00 00 00       	push   $0xf9
801086f1:	e9 2c ef ff ff       	jmp    80107622 <alltraps>

801086f6 <vector250>:
801086f6:	6a 00                	push   $0x0
801086f8:	68 fa 00 00 00       	push   $0xfa
801086fd:	e9 20 ef ff ff       	jmp    80107622 <alltraps>

80108702 <vector251>:
80108702:	6a 00                	push   $0x0
80108704:	68 fb 00 00 00       	push   $0xfb
80108709:	e9 14 ef ff ff       	jmp    80107622 <alltraps>

8010870e <vector252>:
8010870e:	6a 00                	push   $0x0
80108710:	68 fc 00 00 00       	push   $0xfc
80108715:	e9 08 ef ff ff       	jmp    80107622 <alltraps>

8010871a <vector253>:
8010871a:	6a 00                	push   $0x0
8010871c:	68 fd 00 00 00       	push   $0xfd
80108721:	e9 fc ee ff ff       	jmp    80107622 <alltraps>

80108726 <vector254>:
80108726:	6a 00                	push   $0x0
80108728:	68 fe 00 00 00       	push   $0xfe
8010872d:	e9 f0 ee ff ff       	jmp    80107622 <alltraps>

80108732 <vector255>:
80108732:	6a 00                	push   $0x0
80108734:	68 ff 00 00 00       	push   $0xff
80108739:	e9 e4 ee ff ff       	jmp    80107622 <alltraps>

8010873e <lgdt>:
8010873e:	55                   	push   %ebp
8010873f:	89 e5                	mov    %esp,%ebp
80108741:	83 ec 10             	sub    $0x10,%esp
80108744:	8b 45 0c             	mov    0xc(%ebp),%eax
80108747:	83 e8 01             	sub    $0x1,%eax
8010874a:	66 89 45 fa          	mov    %ax,-0x6(%ebp)
8010874e:	8b 45 08             	mov    0x8(%ebp),%eax
80108751:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80108755:	8b 45 08             	mov    0x8(%ebp),%eax
80108758:	c1 e8 10             	shr    $0x10,%eax
8010875b:	66 89 45 fe          	mov    %ax,-0x2(%ebp)
8010875f:	8d 45 fa             	lea    -0x6(%ebp),%eax
80108762:	0f 01 10             	lgdtl  (%eax)
80108765:	90                   	nop
80108766:	c9                   	leave  
80108767:	c3                   	ret    

80108768 <ltr>:
80108768:	55                   	push   %ebp
80108769:	89 e5                	mov    %esp,%ebp
8010876b:	83 ec 04             	sub    $0x4,%esp
8010876e:	8b 45 08             	mov    0x8(%ebp),%eax
80108771:	66 89 45 fc          	mov    %ax,-0x4(%ebp)
80108775:	0f b7 45 fc          	movzwl -0x4(%ebp),%eax
80108779:	0f 00 d8             	ltr    %ax
8010877c:	90                   	nop
8010877d:	c9                   	leave  
8010877e:	c3                   	ret    

8010877f <lcr3>:
8010877f:	55                   	push   %ebp
80108780:	89 e5                	mov    %esp,%ebp
80108782:	8b 45 08             	mov    0x8(%ebp),%eax
80108785:	0f 22 d8             	mov    %eax,%cr3
80108788:	90                   	nop
80108789:	5d                   	pop    %ebp
8010878a:	c3                   	ret    

8010878b <seginit>:
8010878b:	55                   	push   %ebp
8010878c:	89 e5                	mov    %esp,%ebp
8010878e:	83 ec 18             	sub    $0x18,%esp
80108791:	e8 ed ba ff ff       	call   80104283 <cpuid>
80108796:	69 c0 b0 00 00 00    	imul   $0xb0,%eax,%eax
8010879c:	05 c0 37 11 80       	add    $0x801137c0,%eax
801087a1:	89 45 f4             	mov    %eax,-0xc(%ebp)
801087a4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087a7:	66 c7 40 78 ff ff    	movw   $0xffff,0x78(%eax)
801087ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087b0:	66 c7 40 7a 00 00    	movw   $0x0,0x7a(%eax)
801087b6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087b9:	c6 40 7c 00          	movb   $0x0,0x7c(%eax)
801087bd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087c0:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801087c4:	83 e2 f0             	and    $0xfffffff0,%edx
801087c7:	83 ca 0a             	or     $0xa,%edx
801087ca:	88 50 7d             	mov    %dl,0x7d(%eax)
801087cd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087d0:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801087d4:	83 ca 10             	or     $0x10,%edx
801087d7:	88 50 7d             	mov    %dl,0x7d(%eax)
801087da:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087dd:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801087e1:	83 e2 9f             	and    $0xffffff9f,%edx
801087e4:	88 50 7d             	mov    %dl,0x7d(%eax)
801087e7:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087ea:	0f b6 50 7d          	movzbl 0x7d(%eax),%edx
801087ee:	83 ca 80             	or     $0xffffff80,%edx
801087f1:	88 50 7d             	mov    %dl,0x7d(%eax)
801087f4:	8b 45 f4             	mov    -0xc(%ebp),%eax
801087f7:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
801087fb:	83 ca 0f             	or     $0xf,%edx
801087fe:	88 50 7e             	mov    %dl,0x7e(%eax)
80108801:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108804:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80108808:	83 e2 ef             	and    $0xffffffef,%edx
8010880b:	88 50 7e             	mov    %dl,0x7e(%eax)
8010880e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108811:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80108815:	83 e2 df             	and    $0xffffffdf,%edx
80108818:	88 50 7e             	mov    %dl,0x7e(%eax)
8010881b:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010881e:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
80108822:	83 ca 40             	or     $0x40,%edx
80108825:	88 50 7e             	mov    %dl,0x7e(%eax)
80108828:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010882b:	0f b6 50 7e          	movzbl 0x7e(%eax),%edx
8010882f:	83 ca 80             	or     $0xffffff80,%edx
80108832:	88 50 7e             	mov    %dl,0x7e(%eax)
80108835:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108838:	c6 40 7f 00          	movb   $0x0,0x7f(%eax)
8010883c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010883f:	66 c7 80 80 00 00 00 	movw   $0xffff,0x80(%eax)
80108846:	ff ff 
80108848:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010884b:	66 c7 80 82 00 00 00 	movw   $0x0,0x82(%eax)
80108852:	00 00 
80108854:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108857:	c6 80 84 00 00 00 00 	movb   $0x0,0x84(%eax)
8010885e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108861:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80108868:	83 e2 f0             	and    $0xfffffff0,%edx
8010886b:	83 ca 02             	or     $0x2,%edx
8010886e:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80108874:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108877:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
8010887e:	83 ca 10             	or     $0x10,%edx
80108881:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
80108887:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010888a:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
80108891:	83 e2 9f             	and    $0xffffff9f,%edx
80108894:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
8010889a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010889d:	0f b6 90 85 00 00 00 	movzbl 0x85(%eax),%edx
801088a4:	83 ca 80             	or     $0xffffff80,%edx
801088a7:	88 90 85 00 00 00    	mov    %dl,0x85(%eax)
801088ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801088b0:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801088b7:	83 ca 0f             	or     $0xf,%edx
801088ba:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801088c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801088c3:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801088ca:	83 e2 ef             	and    $0xffffffef,%edx
801088cd:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801088d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801088d6:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801088dd:	83 e2 df             	and    $0xffffffdf,%edx
801088e0:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801088e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801088e9:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
801088f0:	83 ca 40             	or     $0x40,%edx
801088f3:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
801088f9:	8b 45 f4             	mov    -0xc(%ebp),%eax
801088fc:	0f b6 90 86 00 00 00 	movzbl 0x86(%eax),%edx
80108903:	83 ca 80             	or     $0xffffff80,%edx
80108906:	88 90 86 00 00 00    	mov    %dl,0x86(%eax)
8010890c:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010890f:	c6 80 87 00 00 00 00 	movb   $0x0,0x87(%eax)
80108916:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108919:	66 c7 80 88 00 00 00 	movw   $0xffff,0x88(%eax)
80108920:	ff ff 
80108922:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108925:	66 c7 80 8a 00 00 00 	movw   $0x0,0x8a(%eax)
8010892c:	00 00 
8010892e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108931:	c6 80 8c 00 00 00 00 	movb   $0x0,0x8c(%eax)
80108938:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010893b:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80108942:	83 e2 f0             	and    $0xfffffff0,%edx
80108945:	83 ca 0a             	or     $0xa,%edx
80108948:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
8010894e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108951:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
80108958:	83 ca 10             	or     $0x10,%edx
8010895b:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80108961:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108964:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
8010896b:	83 ca 60             	or     $0x60,%edx
8010896e:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80108974:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108977:	0f b6 90 8d 00 00 00 	movzbl 0x8d(%eax),%edx
8010897e:	83 ca 80             	or     $0xffffff80,%edx
80108981:	88 90 8d 00 00 00    	mov    %dl,0x8d(%eax)
80108987:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010898a:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
80108991:	83 ca 0f             	or     $0xf,%edx
80108994:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
8010899a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010899d:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801089a4:	83 e2 ef             	and    $0xffffffef,%edx
801089a7:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801089ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801089b0:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801089b7:	83 e2 df             	and    $0xffffffdf,%edx
801089ba:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801089c0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801089c3:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801089ca:	83 ca 40             	or     $0x40,%edx
801089cd:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801089d3:	8b 45 f4             	mov    -0xc(%ebp),%eax
801089d6:	0f b6 90 8e 00 00 00 	movzbl 0x8e(%eax),%edx
801089dd:	83 ca 80             	or     $0xffffff80,%edx
801089e0:	88 90 8e 00 00 00    	mov    %dl,0x8e(%eax)
801089e6:	8b 45 f4             	mov    -0xc(%ebp),%eax
801089e9:	c6 80 8f 00 00 00 00 	movb   $0x0,0x8f(%eax)
801089f0:	8b 45 f4             	mov    -0xc(%ebp),%eax
801089f3:	66 c7 80 90 00 00 00 	movw   $0xffff,0x90(%eax)
801089fa:	ff ff 
801089fc:	8b 45 f4             	mov    -0xc(%ebp),%eax
801089ff:	66 c7 80 92 00 00 00 	movw   $0x0,0x92(%eax)
80108a06:	00 00 
80108a08:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a0b:	c6 80 94 00 00 00 00 	movb   $0x0,0x94(%eax)
80108a12:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a15:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80108a1c:	83 e2 f0             	and    $0xfffffff0,%edx
80108a1f:	83 ca 02             	or     $0x2,%edx
80108a22:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80108a28:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a2b:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80108a32:	83 ca 10             	or     $0x10,%edx
80108a35:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80108a3b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a3e:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80108a45:	83 ca 60             	or     $0x60,%edx
80108a48:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80108a4e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a51:	0f b6 90 95 00 00 00 	movzbl 0x95(%eax),%edx
80108a58:	83 ca 80             	or     $0xffffff80,%edx
80108a5b:	88 90 95 00 00 00    	mov    %dl,0x95(%eax)
80108a61:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a64:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80108a6b:	83 ca 0f             	or     $0xf,%edx
80108a6e:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80108a74:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a77:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80108a7e:	83 e2 ef             	and    $0xffffffef,%edx
80108a81:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80108a87:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a8a:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80108a91:	83 e2 df             	and    $0xffffffdf,%edx
80108a94:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80108a9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108a9d:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80108aa4:	83 ca 40             	or     $0x40,%edx
80108aa7:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80108aad:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108ab0:	0f b6 90 96 00 00 00 	movzbl 0x96(%eax),%edx
80108ab7:	83 ca 80             	or     $0xffffff80,%edx
80108aba:	88 90 96 00 00 00    	mov    %dl,0x96(%eax)
80108ac0:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108ac3:	c6 80 97 00 00 00 00 	movb   $0x0,0x97(%eax)
80108aca:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108acd:	83 c0 70             	add    $0x70,%eax
80108ad0:	83 ec 08             	sub    $0x8,%esp
80108ad3:	6a 30                	push   $0x30
80108ad5:	50                   	push   %eax
80108ad6:	e8 63 fc ff ff       	call   8010873e <lgdt>
80108adb:	83 c4 10             	add    $0x10,%esp
80108ade:	90                   	nop
80108adf:	c9                   	leave  
80108ae0:	c3                   	ret    

80108ae1 <walkpgdir>:
80108ae1:	55                   	push   %ebp
80108ae2:	89 e5                	mov    %esp,%ebp
80108ae4:	83 ec 18             	sub    $0x18,%esp
80108ae7:	8b 45 0c             	mov    0xc(%ebp),%eax
80108aea:	c1 e8 16             	shr    $0x16,%eax
80108aed:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108af4:	8b 45 08             	mov    0x8(%ebp),%eax
80108af7:	01 d0                	add    %edx,%eax
80108af9:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108afc:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108aff:	8b 00                	mov    (%eax),%eax
80108b01:	83 e0 01             	and    $0x1,%eax
80108b04:	85 c0                	test   %eax,%eax
80108b06:	74 14                	je     80108b1c <walkpgdir+0x3b>
80108b08:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108b0b:	8b 00                	mov    (%eax),%eax
80108b0d:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108b12:	05 00 00 00 80       	add    $0x80000000,%eax
80108b17:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108b1a:	eb 42                	jmp    80108b5e <walkpgdir+0x7d>
80108b1c:	83 7d 10 00          	cmpl   $0x0,0x10(%ebp)
80108b20:	74 0e                	je     80108b30 <walkpgdir+0x4f>
80108b22:	e8 6f a1 ff ff       	call   80102c96 <kalloc>
80108b27:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108b2a:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
80108b2e:	75 07                	jne    80108b37 <walkpgdir+0x56>
80108b30:	b8 00 00 00 00       	mov    $0x0,%eax
80108b35:	eb 3e                	jmp    80108b75 <walkpgdir+0x94>
80108b37:	83 ec 04             	sub    $0x4,%esp
80108b3a:	68 00 10 00 00       	push   $0x1000
80108b3f:	6a 00                	push   $0x0
80108b41:	ff 75 f4             	push   -0xc(%ebp)
80108b44:	e8 ec d6 ff ff       	call   80106235 <memset>
80108b49:	83 c4 10             	add    $0x10,%esp
80108b4c:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b4f:	05 00 00 00 80       	add    $0x80000000,%eax
80108b54:	83 c8 07             	or     $0x7,%eax
80108b57:	89 c2                	mov    %eax,%edx
80108b59:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108b5c:	89 10                	mov    %edx,(%eax)
80108b5e:	8b 45 0c             	mov    0xc(%ebp),%eax
80108b61:	c1 e8 0c             	shr    $0xc,%eax
80108b64:	25 ff 03 00 00       	and    $0x3ff,%eax
80108b69:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
80108b70:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108b73:	01 d0                	add    %edx,%eax
80108b75:	c9                   	leave  
80108b76:	c3                   	ret    

80108b77 <mappages>:
80108b77:	55                   	push   %ebp
80108b78:	89 e5                	mov    %esp,%ebp
80108b7a:	83 ec 18             	sub    $0x18,%esp
80108b7d:	8b 45 0c             	mov    0xc(%ebp),%eax
80108b80:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108b85:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108b88:	8b 55 0c             	mov    0xc(%ebp),%edx
80108b8b:	8b 45 10             	mov    0x10(%ebp),%eax
80108b8e:	01 d0                	add    %edx,%eax
80108b90:	83 e8 01             	sub    $0x1,%eax
80108b93:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108b98:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108b9b:	83 ec 04             	sub    $0x4,%esp
80108b9e:	6a 01                	push   $0x1
80108ba0:	ff 75 f4             	push   -0xc(%ebp)
80108ba3:	ff 75 08             	push   0x8(%ebp)
80108ba6:	e8 36 ff ff ff       	call   80108ae1 <walkpgdir>
80108bab:	83 c4 10             	add    $0x10,%esp
80108bae:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108bb1:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108bb5:	75 07                	jne    80108bbe <mappages+0x47>
80108bb7:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108bbc:	eb 47                	jmp    80108c05 <mappages+0x8e>
80108bbe:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108bc1:	8b 00                	mov    (%eax),%eax
80108bc3:	83 e0 01             	and    $0x1,%eax
80108bc6:	85 c0                	test   %eax,%eax
80108bc8:	74 0d                	je     80108bd7 <mappages+0x60>
80108bca:	83 ec 0c             	sub    $0xc,%esp
80108bcd:	68 70 9c 10 80       	push   $0x80109c70
80108bd2:	e8 de 79 ff ff       	call   801005b5 <panic>
80108bd7:	8b 45 18             	mov    0x18(%ebp),%eax
80108bda:	0b 45 14             	or     0x14(%ebp),%eax
80108bdd:	83 c8 01             	or     $0x1,%eax
80108be0:	89 c2                	mov    %eax,%edx
80108be2:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108be5:	89 10                	mov    %edx,(%eax)
80108be7:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108bea:	3b 45 f0             	cmp    -0x10(%ebp),%eax
80108bed:	74 10                	je     80108bff <mappages+0x88>
80108bef:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108bf6:	81 45 14 00 10 00 00 	addl   $0x1000,0x14(%ebp)
80108bfd:	eb 9c                	jmp    80108b9b <mappages+0x24>
80108bff:	90                   	nop
80108c00:	b8 00 00 00 00       	mov    $0x0,%eax
80108c05:	c9                   	leave  
80108c06:	c3                   	ret    

80108c07 <setupkvm>:
80108c07:	55                   	push   %ebp
80108c08:	89 e5                	mov    %esp,%ebp
80108c0a:	53                   	push   %ebx
80108c0b:	83 ec 14             	sub    $0x14,%esp
80108c0e:	e8 83 a0 ff ff       	call   80102c96 <kalloc>
80108c13:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108c16:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108c1a:	75 07                	jne    80108c23 <setupkvm+0x1c>
80108c1c:	b8 00 00 00 00       	mov    $0x0,%eax
80108c21:	eb 78                	jmp    80108c9b <setupkvm+0x94>
80108c23:	83 ec 04             	sub    $0x4,%esp
80108c26:	68 00 10 00 00       	push   $0x1000
80108c2b:	6a 00                	push   $0x0
80108c2d:	ff 75 f0             	push   -0x10(%ebp)
80108c30:	e8 00 d6 ff ff       	call   80106235 <memset>
80108c35:	83 c4 10             	add    $0x10,%esp
80108c38:	c7 45 f4 80 c4 10 80 	movl   $0x8010c480,-0xc(%ebp)
80108c3f:	eb 4e                	jmp    80108c8f <setupkvm+0x88>
80108c41:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108c44:	8b 48 0c             	mov    0xc(%eax),%ecx
80108c47:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108c4a:	8b 50 04             	mov    0x4(%eax),%edx
80108c4d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108c50:	8b 58 08             	mov    0x8(%eax),%ebx
80108c53:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108c56:	8b 40 04             	mov    0x4(%eax),%eax
80108c59:	29 c3                	sub    %eax,%ebx
80108c5b:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108c5e:	8b 00                	mov    (%eax),%eax
80108c60:	83 ec 0c             	sub    $0xc,%esp
80108c63:	51                   	push   %ecx
80108c64:	52                   	push   %edx
80108c65:	53                   	push   %ebx
80108c66:	50                   	push   %eax
80108c67:	ff 75 f0             	push   -0x10(%ebp)
80108c6a:	e8 08 ff ff ff       	call   80108b77 <mappages>
80108c6f:	83 c4 20             	add    $0x20,%esp
80108c72:	85 c0                	test   %eax,%eax
80108c74:	79 15                	jns    80108c8b <setupkvm+0x84>
80108c76:	83 ec 0c             	sub    $0xc,%esp
80108c79:	ff 75 f0             	push   -0x10(%ebp)
80108c7c:	e8 f5 04 00 00       	call   80109176 <freevm>
80108c81:	83 c4 10             	add    $0x10,%esp
80108c84:	b8 00 00 00 00       	mov    $0x0,%eax
80108c89:	eb 10                	jmp    80108c9b <setupkvm+0x94>
80108c8b:	83 45 f4 10          	addl   $0x10,-0xc(%ebp)
80108c8f:	81 7d f4 c0 c4 10 80 	cmpl   $0x8010c4c0,-0xc(%ebp)
80108c96:	72 a9                	jb     80108c41 <setupkvm+0x3a>
80108c98:	8b 45 f0             	mov    -0x10(%ebp),%eax
80108c9b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
80108c9e:	c9                   	leave  
80108c9f:	c3                   	ret    

80108ca0 <kvmalloc>:
80108ca0:	55                   	push   %ebp
80108ca1:	89 e5                	mov    %esp,%ebp
80108ca3:	83 ec 08             	sub    $0x8,%esp
80108ca6:	e8 5c ff ff ff       	call   80108c07 <setupkvm>
80108cab:	a3 3c 73 11 80       	mov    %eax,0x8011733c
80108cb0:	e8 03 00 00 00       	call   80108cb8 <switchkvm>
80108cb5:	90                   	nop
80108cb6:	c9                   	leave  
80108cb7:	c3                   	ret    

80108cb8 <switchkvm>:
80108cb8:	55                   	push   %ebp
80108cb9:	89 e5                	mov    %esp,%ebp
80108cbb:	a1 3c 73 11 80       	mov    0x8011733c,%eax
80108cc0:	05 00 00 00 80       	add    $0x80000000,%eax
80108cc5:	50                   	push   %eax
80108cc6:	e8 b4 fa ff ff       	call   8010877f <lcr3>
80108ccb:	83 c4 04             	add    $0x4,%esp
80108cce:	90                   	nop
80108ccf:	c9                   	leave  
80108cd0:	c3                   	ret    

80108cd1 <switchuvm>:
80108cd1:	55                   	push   %ebp
80108cd2:	89 e5                	mov    %esp,%ebp
80108cd4:	56                   	push   %esi
80108cd5:	53                   	push   %ebx
80108cd6:	83 ec 10             	sub    $0x10,%esp
80108cd9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80108cdd:	75 0d                	jne    80108cec <switchuvm+0x1b>
80108cdf:	83 ec 0c             	sub    $0xc,%esp
80108ce2:	68 76 9c 10 80       	push   $0x80109c76
80108ce7:	e8 c9 78 ff ff       	call   801005b5 <panic>
80108cec:	8b 45 08             	mov    0x8(%ebp),%eax
80108cef:	8b 40 08             	mov    0x8(%eax),%eax
80108cf2:	85 c0                	test   %eax,%eax
80108cf4:	75 0d                	jne    80108d03 <switchuvm+0x32>
80108cf6:	83 ec 0c             	sub    $0xc,%esp
80108cf9:	68 8c 9c 10 80       	push   $0x80109c8c
80108cfe:	e8 b2 78 ff ff       	call   801005b5 <panic>
80108d03:	8b 45 08             	mov    0x8(%ebp),%eax
80108d06:	8b 40 04             	mov    0x4(%eax),%eax
80108d09:	85 c0                	test   %eax,%eax
80108d0b:	75 0d                	jne    80108d1a <switchuvm+0x49>
80108d0d:	83 ec 0c             	sub    $0xc,%esp
80108d10:	68 a1 9c 10 80       	push   $0x80109ca1
80108d15:	e8 9b 78 ff ff       	call   801005b5 <panic>
80108d1a:	e8 0b d4 ff ff       	call   8010612a <pushcli>
80108d1f:	e8 7a b5 ff ff       	call   8010429e <mycpu>
80108d24:	89 c3                	mov    %eax,%ebx
80108d26:	e8 73 b5 ff ff       	call   8010429e <mycpu>
80108d2b:	83 c0 08             	add    $0x8,%eax
80108d2e:	89 c6                	mov    %eax,%esi
80108d30:	e8 69 b5 ff ff       	call   8010429e <mycpu>
80108d35:	83 c0 08             	add    $0x8,%eax
80108d38:	c1 e8 10             	shr    $0x10,%eax
80108d3b:	88 45 f7             	mov    %al,-0x9(%ebp)
80108d3e:	e8 5b b5 ff ff       	call   8010429e <mycpu>
80108d43:	83 c0 08             	add    $0x8,%eax
80108d46:	c1 e8 18             	shr    $0x18,%eax
80108d49:	89 c2                	mov    %eax,%edx
80108d4b:	66 c7 83 98 00 00 00 	movw   $0x67,0x98(%ebx)
80108d52:	67 00 
80108d54:	66 89 b3 9a 00 00 00 	mov    %si,0x9a(%ebx)
80108d5b:	0f b6 45 f7          	movzbl -0x9(%ebp),%eax
80108d5f:	88 83 9c 00 00 00    	mov    %al,0x9c(%ebx)
80108d65:	0f b6 83 9d 00 00 00 	movzbl 0x9d(%ebx),%eax
80108d6c:	83 e0 f0             	and    $0xfffffff0,%eax
80108d6f:	83 c8 09             	or     $0x9,%eax
80108d72:	88 83 9d 00 00 00    	mov    %al,0x9d(%ebx)
80108d78:	0f b6 83 9d 00 00 00 	movzbl 0x9d(%ebx),%eax
80108d7f:	83 c8 10             	or     $0x10,%eax
80108d82:	88 83 9d 00 00 00    	mov    %al,0x9d(%ebx)
80108d88:	0f b6 83 9d 00 00 00 	movzbl 0x9d(%ebx),%eax
80108d8f:	83 e0 9f             	and    $0xffffff9f,%eax
80108d92:	88 83 9d 00 00 00    	mov    %al,0x9d(%ebx)
80108d98:	0f b6 83 9d 00 00 00 	movzbl 0x9d(%ebx),%eax
80108d9f:	83 c8 80             	or     $0xffffff80,%eax
80108da2:	88 83 9d 00 00 00    	mov    %al,0x9d(%ebx)
80108da8:	0f b6 83 9e 00 00 00 	movzbl 0x9e(%ebx),%eax
80108daf:	83 e0 f0             	and    $0xfffffff0,%eax
80108db2:	88 83 9e 00 00 00    	mov    %al,0x9e(%ebx)
80108db8:	0f b6 83 9e 00 00 00 	movzbl 0x9e(%ebx),%eax
80108dbf:	83 e0 ef             	and    $0xffffffef,%eax
80108dc2:	88 83 9e 00 00 00    	mov    %al,0x9e(%ebx)
80108dc8:	0f b6 83 9e 00 00 00 	movzbl 0x9e(%ebx),%eax
80108dcf:	83 e0 df             	and    $0xffffffdf,%eax
80108dd2:	88 83 9e 00 00 00    	mov    %al,0x9e(%ebx)
80108dd8:	0f b6 83 9e 00 00 00 	movzbl 0x9e(%ebx),%eax
80108ddf:	83 c8 40             	or     $0x40,%eax
80108de2:	88 83 9e 00 00 00    	mov    %al,0x9e(%ebx)
80108de8:	0f b6 83 9e 00 00 00 	movzbl 0x9e(%ebx),%eax
80108def:	83 e0 7f             	and    $0x7f,%eax
80108df2:	88 83 9e 00 00 00    	mov    %al,0x9e(%ebx)
80108df8:	88 93 9f 00 00 00    	mov    %dl,0x9f(%ebx)
80108dfe:	e8 9b b4 ff ff       	call   8010429e <mycpu>
80108e03:	0f b6 90 9d 00 00 00 	movzbl 0x9d(%eax),%edx
80108e0a:	83 e2 ef             	and    $0xffffffef,%edx
80108e0d:	88 90 9d 00 00 00    	mov    %dl,0x9d(%eax)
80108e13:	e8 86 b4 ff ff       	call   8010429e <mycpu>
80108e18:	66 c7 40 10 10 00    	movw   $0x10,0x10(%eax)
80108e1e:	8b 45 08             	mov    0x8(%ebp),%eax
80108e21:	8b 40 08             	mov    0x8(%eax),%eax
80108e24:	89 c3                	mov    %eax,%ebx
80108e26:	e8 73 b4 ff ff       	call   8010429e <mycpu>
80108e2b:	8d 93 00 10 00 00    	lea    0x1000(%ebx),%edx
80108e31:	89 50 0c             	mov    %edx,0xc(%eax)
80108e34:	e8 65 b4 ff ff       	call   8010429e <mycpu>
80108e39:	66 c7 40 6e ff ff    	movw   $0xffff,0x6e(%eax)
80108e3f:	83 ec 0c             	sub    $0xc,%esp
80108e42:	6a 28                	push   $0x28
80108e44:	e8 1f f9 ff ff       	call   80108768 <ltr>
80108e49:	83 c4 10             	add    $0x10,%esp
80108e4c:	8b 45 08             	mov    0x8(%ebp),%eax
80108e4f:	8b 40 04             	mov    0x4(%eax),%eax
80108e52:	05 00 00 00 80       	add    $0x80000000,%eax
80108e57:	83 ec 0c             	sub    $0xc,%esp
80108e5a:	50                   	push   %eax
80108e5b:	e8 1f f9 ff ff       	call   8010877f <lcr3>
80108e60:	83 c4 10             	add    $0x10,%esp
80108e63:	e8 0f d3 ff ff       	call   80106177 <popcli>
80108e68:	90                   	nop
80108e69:	8d 65 f8             	lea    -0x8(%ebp),%esp
80108e6c:	5b                   	pop    %ebx
80108e6d:	5e                   	pop    %esi
80108e6e:	5d                   	pop    %ebp
80108e6f:	c3                   	ret    

80108e70 <inituvm>:
80108e70:	55                   	push   %ebp
80108e71:	89 e5                	mov    %esp,%ebp
80108e73:	83 ec 18             	sub    $0x18,%esp
80108e76:	81 7d 10 ff 0f 00 00 	cmpl   $0xfff,0x10(%ebp)
80108e7d:	76 0d                	jbe    80108e8c <inituvm+0x1c>
80108e7f:	83 ec 0c             	sub    $0xc,%esp
80108e82:	68 b5 9c 10 80       	push   $0x80109cb5
80108e87:	e8 29 77 ff ff       	call   801005b5 <panic>
80108e8c:	e8 05 9e ff ff       	call   80102c96 <kalloc>
80108e91:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108e94:	83 ec 04             	sub    $0x4,%esp
80108e97:	68 00 10 00 00       	push   $0x1000
80108e9c:	6a 00                	push   $0x0
80108e9e:	ff 75 f4             	push   -0xc(%ebp)
80108ea1:	e8 8f d3 ff ff       	call   80106235 <memset>
80108ea6:	83 c4 10             	add    $0x10,%esp
80108ea9:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108eac:	05 00 00 00 80       	add    $0x80000000,%eax
80108eb1:	83 ec 0c             	sub    $0xc,%esp
80108eb4:	6a 06                	push   $0x6
80108eb6:	50                   	push   %eax
80108eb7:	68 00 10 00 00       	push   $0x1000
80108ebc:	6a 00                	push   $0x0
80108ebe:	ff 75 08             	push   0x8(%ebp)
80108ec1:	e8 b1 fc ff ff       	call   80108b77 <mappages>
80108ec6:	83 c4 20             	add    $0x20,%esp
80108ec9:	83 ec 04             	sub    $0x4,%esp
80108ecc:	ff 75 10             	push   0x10(%ebp)
80108ecf:	ff 75 0c             	push   0xc(%ebp)
80108ed2:	ff 75 f4             	push   -0xc(%ebp)
80108ed5:	e8 1a d4 ff ff       	call   801062f4 <memmove>
80108eda:	83 c4 10             	add    $0x10,%esp
80108edd:	90                   	nop
80108ede:	c9                   	leave  
80108edf:	c3                   	ret    

80108ee0 <loaduvm>:
80108ee0:	55                   	push   %ebp
80108ee1:	89 e5                	mov    %esp,%ebp
80108ee3:	83 ec 18             	sub    $0x18,%esp
80108ee6:	8b 45 0c             	mov    0xc(%ebp),%eax
80108ee9:	25 ff 0f 00 00       	and    $0xfff,%eax
80108eee:	85 c0                	test   %eax,%eax
80108ef0:	74 0d                	je     80108eff <loaduvm+0x1f>
80108ef2:	83 ec 0c             	sub    $0xc,%esp
80108ef5:	68 d0 9c 10 80       	push   $0x80109cd0
80108efa:	e8 b6 76 ff ff       	call   801005b5 <panic>
80108eff:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80108f06:	e9 8f 00 00 00       	jmp    80108f9a <loaduvm+0xba>
80108f0b:	8b 55 0c             	mov    0xc(%ebp),%edx
80108f0e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108f11:	01 d0                	add    %edx,%eax
80108f13:	83 ec 04             	sub    $0x4,%esp
80108f16:	6a 00                	push   $0x0
80108f18:	50                   	push   %eax
80108f19:	ff 75 08             	push   0x8(%ebp)
80108f1c:	e8 c0 fb ff ff       	call   80108ae1 <walkpgdir>
80108f21:	83 c4 10             	add    $0x10,%esp
80108f24:	89 45 ec             	mov    %eax,-0x14(%ebp)
80108f27:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80108f2b:	75 0d                	jne    80108f3a <loaduvm+0x5a>
80108f2d:	83 ec 0c             	sub    $0xc,%esp
80108f30:	68 f3 9c 10 80       	push   $0x80109cf3
80108f35:	e8 7b 76 ff ff       	call   801005b5 <panic>
80108f3a:	8b 45 ec             	mov    -0x14(%ebp),%eax
80108f3d:	8b 00                	mov    (%eax),%eax
80108f3f:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108f44:	89 45 e8             	mov    %eax,-0x18(%ebp)
80108f47:	8b 45 18             	mov    0x18(%ebp),%eax
80108f4a:	2b 45 f4             	sub    -0xc(%ebp),%eax
80108f4d:	3d ff 0f 00 00       	cmp    $0xfff,%eax
80108f52:	77 0b                	ja     80108f5f <loaduvm+0x7f>
80108f54:	8b 45 18             	mov    0x18(%ebp),%eax
80108f57:	2b 45 f4             	sub    -0xc(%ebp),%eax
80108f5a:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108f5d:	eb 07                	jmp    80108f66 <loaduvm+0x86>
80108f5f:	c7 45 f0 00 10 00 00 	movl   $0x1000,-0x10(%ebp)
80108f66:	8b 55 14             	mov    0x14(%ebp),%edx
80108f69:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108f6c:	01 d0                	add    %edx,%eax
80108f6e:	8b 55 e8             	mov    -0x18(%ebp),%edx
80108f71:	81 c2 00 00 00 80    	add    $0x80000000,%edx
80108f77:	ff 75 f0             	push   -0x10(%ebp)
80108f7a:	50                   	push   %eax
80108f7b:	52                   	push   %edx
80108f7c:	ff 75 10             	push   0x10(%ebp)
80108f7f:	e8 82 8f ff ff       	call   80101f06 <readi>
80108f84:	83 c4 10             	add    $0x10,%esp
80108f87:	39 45 f0             	cmp    %eax,-0x10(%ebp)
80108f8a:	74 07                	je     80108f93 <loaduvm+0xb3>
80108f8c:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
80108f91:	eb 18                	jmp    80108fab <loaduvm+0xcb>
80108f93:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80108f9a:	8b 45 f4             	mov    -0xc(%ebp),%eax
80108f9d:	3b 45 18             	cmp    0x18(%ebp),%eax
80108fa0:	0f 82 65 ff ff ff    	jb     80108f0b <loaduvm+0x2b>
80108fa6:	b8 00 00 00 00       	mov    $0x0,%eax
80108fab:	c9                   	leave  
80108fac:	c3                   	ret    

80108fad <allocuvm>:
80108fad:	55                   	push   %ebp
80108fae:	89 e5                	mov    %esp,%ebp
80108fb0:	83 ec 18             	sub    $0x18,%esp
80108fb3:	8b 45 10             	mov    0x10(%ebp),%eax
80108fb6:	85 c0                	test   %eax,%eax
80108fb8:	79 0a                	jns    80108fc4 <allocuvm+0x17>
80108fba:	b8 00 00 00 00       	mov    $0x0,%eax
80108fbf:	e9 ec 00 00 00       	jmp    801090b0 <allocuvm+0x103>
80108fc4:	8b 45 10             	mov    0x10(%ebp),%eax
80108fc7:	3b 45 0c             	cmp    0xc(%ebp),%eax
80108fca:	73 08                	jae    80108fd4 <allocuvm+0x27>
80108fcc:	8b 45 0c             	mov    0xc(%ebp),%eax
80108fcf:	e9 dc 00 00 00       	jmp    801090b0 <allocuvm+0x103>
80108fd4:	8b 45 0c             	mov    0xc(%ebp),%eax
80108fd7:	05 ff 0f 00 00       	add    $0xfff,%eax
80108fdc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80108fe1:	89 45 f4             	mov    %eax,-0xc(%ebp)
80108fe4:	e9 b8 00 00 00       	jmp    801090a1 <allocuvm+0xf4>
80108fe9:	e8 a8 9c ff ff       	call   80102c96 <kalloc>
80108fee:	89 45 f0             	mov    %eax,-0x10(%ebp)
80108ff1:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80108ff5:	75 2e                	jne    80109025 <allocuvm+0x78>
80108ff7:	83 ec 0c             	sub    $0xc,%esp
80108ffa:	68 11 9d 10 80       	push   $0x80109d11
80108fff:	e8 fc 73 ff ff       	call   80100400 <cprintf>
80109004:	83 c4 10             	add    $0x10,%esp
80109007:	83 ec 04             	sub    $0x4,%esp
8010900a:	ff 75 0c             	push   0xc(%ebp)
8010900d:	ff 75 10             	push   0x10(%ebp)
80109010:	ff 75 08             	push   0x8(%ebp)
80109013:	e8 9a 00 00 00       	call   801090b2 <deallocuvm>
80109018:	83 c4 10             	add    $0x10,%esp
8010901b:	b8 00 00 00 00       	mov    $0x0,%eax
80109020:	e9 8b 00 00 00       	jmp    801090b0 <allocuvm+0x103>
80109025:	83 ec 04             	sub    $0x4,%esp
80109028:	68 00 10 00 00       	push   $0x1000
8010902d:	6a 00                	push   $0x0
8010902f:	ff 75 f0             	push   -0x10(%ebp)
80109032:	e8 fe d1 ff ff       	call   80106235 <memset>
80109037:	83 c4 10             	add    $0x10,%esp
8010903a:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010903d:	8d 90 00 00 00 80    	lea    -0x80000000(%eax),%edx
80109043:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109046:	83 ec 0c             	sub    $0xc,%esp
80109049:	6a 06                	push   $0x6
8010904b:	52                   	push   %edx
8010904c:	68 00 10 00 00       	push   $0x1000
80109051:	50                   	push   %eax
80109052:	ff 75 08             	push   0x8(%ebp)
80109055:	e8 1d fb ff ff       	call   80108b77 <mappages>
8010905a:	83 c4 20             	add    $0x20,%esp
8010905d:	85 c0                	test   %eax,%eax
8010905f:	79 39                	jns    8010909a <allocuvm+0xed>
80109061:	83 ec 0c             	sub    $0xc,%esp
80109064:	68 29 9d 10 80       	push   $0x80109d29
80109069:	e8 92 73 ff ff       	call   80100400 <cprintf>
8010906e:	83 c4 10             	add    $0x10,%esp
80109071:	83 ec 04             	sub    $0x4,%esp
80109074:	ff 75 0c             	push   0xc(%ebp)
80109077:	ff 75 10             	push   0x10(%ebp)
8010907a:	ff 75 08             	push   0x8(%ebp)
8010907d:	e8 30 00 00 00       	call   801090b2 <deallocuvm>
80109082:	83 c4 10             	add    $0x10,%esp
80109085:	83 ec 0c             	sub    $0xc,%esp
80109088:	ff 75 f0             	push   -0x10(%ebp)
8010908b:	e8 6c 9b ff ff       	call   80102bfc <kfree>
80109090:	83 c4 10             	add    $0x10,%esp
80109093:	b8 00 00 00 00       	mov    $0x0,%eax
80109098:	eb 16                	jmp    801090b0 <allocuvm+0x103>
8010909a:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
801090a1:	8b 45 f4             	mov    -0xc(%ebp),%eax
801090a4:	3b 45 10             	cmp    0x10(%ebp),%eax
801090a7:	0f 82 3c ff ff ff    	jb     80108fe9 <allocuvm+0x3c>
801090ad:	8b 45 10             	mov    0x10(%ebp),%eax
801090b0:	c9                   	leave  
801090b1:	c3                   	ret    

801090b2 <deallocuvm>:
801090b2:	55                   	push   %ebp
801090b3:	89 e5                	mov    %esp,%ebp
801090b5:	83 ec 18             	sub    $0x18,%esp
801090b8:	8b 45 10             	mov    0x10(%ebp),%eax
801090bb:	3b 45 0c             	cmp    0xc(%ebp),%eax
801090be:	72 08                	jb     801090c8 <deallocuvm+0x16>
801090c0:	8b 45 0c             	mov    0xc(%ebp),%eax
801090c3:	e9 ac 00 00 00       	jmp    80109174 <deallocuvm+0xc2>
801090c8:	8b 45 10             	mov    0x10(%ebp),%eax
801090cb:	05 ff 0f 00 00       	add    $0xfff,%eax
801090d0:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801090d5:	89 45 f4             	mov    %eax,-0xc(%ebp)
801090d8:	e9 88 00 00 00       	jmp    80109165 <deallocuvm+0xb3>
801090dd:	8b 45 f4             	mov    -0xc(%ebp),%eax
801090e0:	83 ec 04             	sub    $0x4,%esp
801090e3:	6a 00                	push   $0x0
801090e5:	50                   	push   %eax
801090e6:	ff 75 08             	push   0x8(%ebp)
801090e9:	e8 f3 f9 ff ff       	call   80108ae1 <walkpgdir>
801090ee:	83 c4 10             	add    $0x10,%esp
801090f1:	89 45 f0             	mov    %eax,-0x10(%ebp)
801090f4:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
801090f8:	75 16                	jne    80109110 <deallocuvm+0x5e>
801090fa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801090fd:	c1 e8 16             	shr    $0x16,%eax
80109100:	83 c0 01             	add    $0x1,%eax
80109103:	c1 e0 16             	shl    $0x16,%eax
80109106:	2d 00 10 00 00       	sub    $0x1000,%eax
8010910b:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010910e:	eb 4e                	jmp    8010915e <deallocuvm+0xac>
80109110:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109113:	8b 00                	mov    (%eax),%eax
80109115:	83 e0 01             	and    $0x1,%eax
80109118:	85 c0                	test   %eax,%eax
8010911a:	74 42                	je     8010915e <deallocuvm+0xac>
8010911c:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010911f:	8b 00                	mov    (%eax),%eax
80109121:	25 00 f0 ff ff       	and    $0xfffff000,%eax
80109126:	89 45 ec             	mov    %eax,-0x14(%ebp)
80109129:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
8010912d:	75 0d                	jne    8010913c <deallocuvm+0x8a>
8010912f:	83 ec 0c             	sub    $0xc,%esp
80109132:	68 45 9d 10 80       	push   $0x80109d45
80109137:	e8 79 74 ff ff       	call   801005b5 <panic>
8010913c:	8b 45 ec             	mov    -0x14(%ebp),%eax
8010913f:	05 00 00 00 80       	add    $0x80000000,%eax
80109144:	89 45 e8             	mov    %eax,-0x18(%ebp)
80109147:	83 ec 0c             	sub    $0xc,%esp
8010914a:	ff 75 e8             	push   -0x18(%ebp)
8010914d:	e8 aa 9a ff ff       	call   80102bfc <kfree>
80109152:	83 c4 10             	add    $0x10,%esp
80109155:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109158:	c7 00 00 00 00 00    	movl   $0x0,(%eax)
8010915e:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80109165:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109168:	3b 45 0c             	cmp    0xc(%ebp),%eax
8010916b:	0f 82 6c ff ff ff    	jb     801090dd <deallocuvm+0x2b>
80109171:	8b 45 10             	mov    0x10(%ebp),%eax
80109174:	c9                   	leave  
80109175:	c3                   	ret    

80109176 <freevm>:
80109176:	55                   	push   %ebp
80109177:	89 e5                	mov    %esp,%ebp
80109179:	83 ec 18             	sub    $0x18,%esp
8010917c:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
80109180:	75 0d                	jne    8010918f <freevm+0x19>
80109182:	83 ec 0c             	sub    $0xc,%esp
80109185:	68 4b 9d 10 80       	push   $0x80109d4b
8010918a:	e8 26 74 ff ff       	call   801005b5 <panic>
8010918f:	83 ec 04             	sub    $0x4,%esp
80109192:	6a 00                	push   $0x0
80109194:	68 00 00 00 80       	push   $0x80000000
80109199:	ff 75 08             	push   0x8(%ebp)
8010919c:	e8 11 ff ff ff       	call   801090b2 <deallocuvm>
801091a1:	83 c4 10             	add    $0x10,%esp
801091a4:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
801091ab:	eb 48                	jmp    801091f5 <freevm+0x7f>
801091ad:	8b 45 f4             	mov    -0xc(%ebp),%eax
801091b0:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801091b7:	8b 45 08             	mov    0x8(%ebp),%eax
801091ba:	01 d0                	add    %edx,%eax
801091bc:	8b 00                	mov    (%eax),%eax
801091be:	83 e0 01             	and    $0x1,%eax
801091c1:	85 c0                	test   %eax,%eax
801091c3:	74 2c                	je     801091f1 <freevm+0x7b>
801091c5:	8b 45 f4             	mov    -0xc(%ebp),%eax
801091c8:	8d 14 85 00 00 00 00 	lea    0x0(,%eax,4),%edx
801091cf:	8b 45 08             	mov    0x8(%ebp),%eax
801091d2:	01 d0                	add    %edx,%eax
801091d4:	8b 00                	mov    (%eax),%eax
801091d6:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801091db:	05 00 00 00 80       	add    $0x80000000,%eax
801091e0:	89 45 f0             	mov    %eax,-0x10(%ebp)
801091e3:	83 ec 0c             	sub    $0xc,%esp
801091e6:	ff 75 f0             	push   -0x10(%ebp)
801091e9:	e8 0e 9a ff ff       	call   80102bfc <kfree>
801091ee:	83 c4 10             	add    $0x10,%esp
801091f1:	83 45 f4 01          	addl   $0x1,-0xc(%ebp)
801091f5:	81 7d f4 ff 03 00 00 	cmpl   $0x3ff,-0xc(%ebp)
801091fc:	76 af                	jbe    801091ad <freevm+0x37>
801091fe:	83 ec 0c             	sub    $0xc,%esp
80109201:	ff 75 08             	push   0x8(%ebp)
80109204:	e8 f3 99 ff ff       	call   80102bfc <kfree>
80109209:	83 c4 10             	add    $0x10,%esp
8010920c:	90                   	nop
8010920d:	c9                   	leave  
8010920e:	c3                   	ret    

8010920f <clearpteu>:
8010920f:	55                   	push   %ebp
80109210:	89 e5                	mov    %esp,%ebp
80109212:	83 ec 18             	sub    $0x18,%esp
80109215:	83 ec 04             	sub    $0x4,%esp
80109218:	6a 00                	push   $0x0
8010921a:	ff 75 0c             	push   0xc(%ebp)
8010921d:	ff 75 08             	push   0x8(%ebp)
80109220:	e8 bc f8 ff ff       	call   80108ae1 <walkpgdir>
80109225:	83 c4 10             	add    $0x10,%esp
80109228:	89 45 f4             	mov    %eax,-0xc(%ebp)
8010922b:	83 7d f4 00          	cmpl   $0x0,-0xc(%ebp)
8010922f:	75 0d                	jne    8010923e <clearpteu+0x2f>
80109231:	83 ec 0c             	sub    $0xc,%esp
80109234:	68 5c 9d 10 80       	push   $0x80109d5c
80109239:	e8 77 73 ff ff       	call   801005b5 <panic>
8010923e:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109241:	8b 00                	mov    (%eax),%eax
80109243:	83 e0 fb             	and    $0xfffffffb,%eax
80109246:	89 c2                	mov    %eax,%edx
80109248:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010924b:	89 10                	mov    %edx,(%eax)
8010924d:	90                   	nop
8010924e:	c9                   	leave  
8010924f:	c3                   	ret    

80109250 <copyuvm>:
80109250:	55                   	push   %ebp
80109251:	89 e5                	mov    %esp,%ebp
80109253:	83 ec 28             	sub    $0x28,%esp
80109256:	e8 ac f9 ff ff       	call   80108c07 <setupkvm>
8010925b:	89 45 f0             	mov    %eax,-0x10(%ebp)
8010925e:	83 7d f0 00          	cmpl   $0x0,-0x10(%ebp)
80109262:	75 0a                	jne    8010926e <copyuvm+0x1e>
80109264:	b8 00 00 00 00       	mov    $0x0,%eax
80109269:	e9 f8 00 00 00       	jmp    80109366 <copyuvm+0x116>
8010926e:	c7 45 f4 00 00 00 00 	movl   $0x0,-0xc(%ebp)
80109275:	e9 c7 00 00 00       	jmp    80109341 <copyuvm+0xf1>
8010927a:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010927d:	83 ec 04             	sub    $0x4,%esp
80109280:	6a 00                	push   $0x0
80109282:	50                   	push   %eax
80109283:	ff 75 08             	push   0x8(%ebp)
80109286:	e8 56 f8 ff ff       	call   80108ae1 <walkpgdir>
8010928b:	83 c4 10             	add    $0x10,%esp
8010928e:	89 45 ec             	mov    %eax,-0x14(%ebp)
80109291:	83 7d ec 00          	cmpl   $0x0,-0x14(%ebp)
80109295:	75 0d                	jne    801092a4 <copyuvm+0x54>
80109297:	83 ec 0c             	sub    $0xc,%esp
8010929a:	68 66 9d 10 80       	push   $0x80109d66
8010929f:	e8 11 73 ff ff       	call   801005b5 <panic>
801092a4:	8b 45 ec             	mov    -0x14(%ebp),%eax
801092a7:	8b 00                	mov    (%eax),%eax
801092a9:	83 e0 01             	and    $0x1,%eax
801092ac:	85 c0                	test   %eax,%eax
801092ae:	75 0d                	jne    801092bd <copyuvm+0x6d>
801092b0:	83 ec 0c             	sub    $0xc,%esp
801092b3:	68 80 9d 10 80       	push   $0x80109d80
801092b8:	e8 f8 72 ff ff       	call   801005b5 <panic>
801092bd:	8b 45 ec             	mov    -0x14(%ebp),%eax
801092c0:	8b 00                	mov    (%eax),%eax
801092c2:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801092c7:	89 45 e8             	mov    %eax,-0x18(%ebp)
801092ca:	8b 45 ec             	mov    -0x14(%ebp),%eax
801092cd:	8b 00                	mov    (%eax),%eax
801092cf:	25 ff 0f 00 00       	and    $0xfff,%eax
801092d4:	89 45 e4             	mov    %eax,-0x1c(%ebp)
801092d7:	e8 ba 99 ff ff       	call   80102c96 <kalloc>
801092dc:	89 45 e0             	mov    %eax,-0x20(%ebp)
801092df:	83 7d e0 00          	cmpl   $0x0,-0x20(%ebp)
801092e3:	74 6d                	je     80109352 <copyuvm+0x102>
801092e5:	8b 45 e8             	mov    -0x18(%ebp),%eax
801092e8:	05 00 00 00 80       	add    $0x80000000,%eax
801092ed:	83 ec 04             	sub    $0x4,%esp
801092f0:	68 00 10 00 00       	push   $0x1000
801092f5:	50                   	push   %eax
801092f6:	ff 75 e0             	push   -0x20(%ebp)
801092f9:	e8 f6 cf ff ff       	call   801062f4 <memmove>
801092fe:	83 c4 10             	add    $0x10,%esp
80109301:	8b 55 e4             	mov    -0x1c(%ebp),%edx
80109304:	8b 45 e0             	mov    -0x20(%ebp),%eax
80109307:	8d 88 00 00 00 80    	lea    -0x80000000(%eax),%ecx
8010930d:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109310:	83 ec 0c             	sub    $0xc,%esp
80109313:	52                   	push   %edx
80109314:	51                   	push   %ecx
80109315:	68 00 10 00 00       	push   $0x1000
8010931a:	50                   	push   %eax
8010931b:	ff 75 f0             	push   -0x10(%ebp)
8010931e:	e8 54 f8 ff ff       	call   80108b77 <mappages>
80109323:	83 c4 20             	add    $0x20,%esp
80109326:	85 c0                	test   %eax,%eax
80109328:	79 10                	jns    8010933a <copyuvm+0xea>
8010932a:	83 ec 0c             	sub    $0xc,%esp
8010932d:	ff 75 e0             	push   -0x20(%ebp)
80109330:	e8 c7 98 ff ff       	call   80102bfc <kfree>
80109335:	83 c4 10             	add    $0x10,%esp
80109338:	eb 19                	jmp    80109353 <copyuvm+0x103>
8010933a:	81 45 f4 00 10 00 00 	addl   $0x1000,-0xc(%ebp)
80109341:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109344:	3b 45 0c             	cmp    0xc(%ebp),%eax
80109347:	0f 82 2d ff ff ff    	jb     8010927a <copyuvm+0x2a>
8010934d:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109350:	eb 14                	jmp    80109366 <copyuvm+0x116>
80109352:	90                   	nop
80109353:	83 ec 0c             	sub    $0xc,%esp
80109356:	ff 75 f0             	push   -0x10(%ebp)
80109359:	e8 18 fe ff ff       	call   80109176 <freevm>
8010935e:	83 c4 10             	add    $0x10,%esp
80109361:	b8 00 00 00 00       	mov    $0x0,%eax
80109366:	c9                   	leave  
80109367:	c3                   	ret    

80109368 <uva2ka>:
80109368:	55                   	push   %ebp
80109369:	89 e5                	mov    %esp,%ebp
8010936b:	83 ec 18             	sub    $0x18,%esp
8010936e:	83 ec 04             	sub    $0x4,%esp
80109371:	6a 00                	push   $0x0
80109373:	ff 75 0c             	push   0xc(%ebp)
80109376:	ff 75 08             	push   0x8(%ebp)
80109379:	e8 63 f7 ff ff       	call   80108ae1 <walkpgdir>
8010937e:	83 c4 10             	add    $0x10,%esp
80109381:	89 45 f4             	mov    %eax,-0xc(%ebp)
80109384:	8b 45 f4             	mov    -0xc(%ebp),%eax
80109387:	8b 00                	mov    (%eax),%eax
80109389:	83 e0 01             	and    $0x1,%eax
8010938c:	85 c0                	test   %eax,%eax
8010938e:	75 07                	jne    80109397 <uva2ka+0x2f>
80109390:	b8 00 00 00 00       	mov    $0x0,%eax
80109395:	eb 22                	jmp    801093b9 <uva2ka+0x51>
80109397:	8b 45 f4             	mov    -0xc(%ebp),%eax
8010939a:	8b 00                	mov    (%eax),%eax
8010939c:	83 e0 04             	and    $0x4,%eax
8010939f:	85 c0                	test   %eax,%eax
801093a1:	75 07                	jne    801093aa <uva2ka+0x42>
801093a3:	b8 00 00 00 00       	mov    $0x0,%eax
801093a8:	eb 0f                	jmp    801093b9 <uva2ka+0x51>
801093aa:	8b 45 f4             	mov    -0xc(%ebp),%eax
801093ad:	8b 00                	mov    (%eax),%eax
801093af:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801093b4:	05 00 00 00 80       	add    $0x80000000,%eax
801093b9:	c9                   	leave  
801093ba:	c3                   	ret    

801093bb <copyout>:
801093bb:	55                   	push   %ebp
801093bc:	89 e5                	mov    %esp,%ebp
801093be:	83 ec 18             	sub    $0x18,%esp
801093c1:	8b 45 10             	mov    0x10(%ebp),%eax
801093c4:	89 45 f4             	mov    %eax,-0xc(%ebp)
801093c7:	eb 7f                	jmp    80109448 <copyout+0x8d>
801093c9:	8b 45 0c             	mov    0xc(%ebp),%eax
801093cc:	25 00 f0 ff ff       	and    $0xfffff000,%eax
801093d1:	89 45 ec             	mov    %eax,-0x14(%ebp)
801093d4:	8b 45 ec             	mov    -0x14(%ebp),%eax
801093d7:	83 ec 08             	sub    $0x8,%esp
801093da:	50                   	push   %eax
801093db:	ff 75 08             	push   0x8(%ebp)
801093de:	e8 85 ff ff ff       	call   80109368 <uva2ka>
801093e3:	83 c4 10             	add    $0x10,%esp
801093e6:	89 45 e8             	mov    %eax,-0x18(%ebp)
801093e9:	83 7d e8 00          	cmpl   $0x0,-0x18(%ebp)
801093ed:	75 07                	jne    801093f6 <copyout+0x3b>
801093ef:	b8 ff ff ff ff       	mov    $0xffffffff,%eax
801093f4:	eb 61                	jmp    80109457 <copyout+0x9c>
801093f6:	8b 45 ec             	mov    -0x14(%ebp),%eax
801093f9:	2b 45 0c             	sub    0xc(%ebp),%eax
801093fc:	05 00 10 00 00       	add    $0x1000,%eax
80109401:	89 45 f0             	mov    %eax,-0x10(%ebp)
80109404:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109407:	3b 45 14             	cmp    0x14(%ebp),%eax
8010940a:	76 06                	jbe    80109412 <copyout+0x57>
8010940c:	8b 45 14             	mov    0x14(%ebp),%eax
8010940f:	89 45 f0             	mov    %eax,-0x10(%ebp)
80109412:	8b 45 0c             	mov    0xc(%ebp),%eax
80109415:	2b 45 ec             	sub    -0x14(%ebp),%eax
80109418:	89 c2                	mov    %eax,%edx
8010941a:	8b 45 e8             	mov    -0x18(%ebp),%eax
8010941d:	01 d0                	add    %edx,%eax
8010941f:	83 ec 04             	sub    $0x4,%esp
80109422:	ff 75 f0             	push   -0x10(%ebp)
80109425:	ff 75 f4             	push   -0xc(%ebp)
80109428:	50                   	push   %eax
80109429:	e8 c6 ce ff ff       	call   801062f4 <memmove>
8010942e:	83 c4 10             	add    $0x10,%esp
80109431:	8b 45 f0             	mov    -0x10(%ebp),%eax
80109434:	29 45 14             	sub    %eax,0x14(%ebp)
80109437:	8b 45 f0             	mov    -0x10(%ebp),%eax
8010943a:	01 45 f4             	add    %eax,-0xc(%ebp)
8010943d:	8b 45 ec             	mov    -0x14(%ebp),%eax
80109440:	05 00 10 00 00       	add    $0x1000,%eax
80109445:	89 45 0c             	mov    %eax,0xc(%ebp)
80109448:	83 7d 14 00          	cmpl   $0x0,0x14(%ebp)
8010944c:	0f 85 77 ff ff ff    	jne    801093c9 <copyout+0xe>
80109452:	b8 00 00 00 00       	mov    $0x0,%eax
80109457:	c9                   	leave  
80109458:	c3                   	ret    
