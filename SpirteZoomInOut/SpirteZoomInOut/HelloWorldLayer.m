//
//  HelloWorldLayer.m
//  SpirteZoomInOut
//
//  Created by Cheng Leon on 11/12/4.
//  Copyright __MyCompanyName__ 2011年. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "CCScrollLayer.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
  
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
		
    self.isTouchEnabled=YES;
    [glView setMultipleTouchEnabled:YES]; 
    
 demoSprite =[CCSprite spriteWithFile:@"2.jpg" ];
    chicken =[CCSprite spriteWithFile:@"image1.png" ];
    CCLabelTTF *myLabel=[CCLabelTTF labelWithString:@"chicken tester" fontName:@"Marker Felt" fontSize:40] ;  
       
//    [self addChild: myLabel] ;
    // ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];
	  

// 		demoSprite.scale=(size.height/demoSprite.contentSize.height);
    demoSprite.position =  ccp( size.width /2 , size.height/2 );
    chicken.position =  ccp( size.width /2 , size.height/2 );
		// add the label as a child to this Layer
    myLabel.position=CGPointMake(chicken.position.x, chicken.position.x-chicken.contentSize.height/2);

 		[self addChild: demoSprite z:1 tag:1];
    [self addChild: chicken z:2 tag:2];
    [self addChild: myLabel z:3 tag:3];
  }
	return self;
}

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
  NSSet *set=[event allTouches];
   
  if (set.count ==2){
    UITouch *one =[[set allObjects] objectAtIndex:0] ;
    UITouch *two =[[set allObjects] objectAtIndex:1] ;
    CGPoint ptOne=[one locationInView:[one view]];
    CGPoint ptTwo=[two locationInView:[two view]];
    ptOne =[[CCDirector sharedDirector] convertToGL:ptOne];
    ptTwo =[[CCDirector sharedDirector] convertToGL:ptTwo];
    float dist = ccpDistance(ptOne, ptTwo);
    oldDist=dist;
  }
  
  if (set.count == 1){    
    UITouch *one = [touches anyObject];
    CGPoint ptOne=[one locationInView:[one view]];
    ptOne =[[CCDirector sharedDirector] convertToGL:ptOne];
   // demoSprite.position =  ccp( ptOne.x , ptOne.y );
  }

}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
  NSSet *set=[event allTouches];
  if (set.count ==2){
    UITouch *one =[[set allObjects] objectAtIndex:0] ;
    UITouch *two =[[set allObjects] objectAtIndex:1] ;
    CGPoint ptOne=[one locationInView:[one view]];
    CGPoint ptTwo=[two locationInView:[two view]];
    ptOne =[[CCDirector sharedDirector] convertToGL:ptOne];
    ptTwo =[[CCDirector sharedDirector] convertToGL:ptTwo];
    float dist = ccpDistance(ptOne, ptTwo);
    
    if (oldDist>=dist) {
       CCLOG(@">=");
      [demoSprite setScale:demoSprite.scale - fabsf(oldDist-dist) /100];
 
      CCLOG(@"%f",demoSprite.scale);
    } else {
      CCLOG(@"<");
      
      [demoSprite setScale:demoSprite.scale + fabsf(oldDist-dist) /100];

    }
    CCLOG(@"olddist=%f , disd=%f move disk=%f",oldDist,dist,dist);
    oldDist=dist;
  }

  if (set.count == 1){
    UITouch *one = [touches anyObject];
    CGPoint ptOne=[one locationInView:[one view]];
    ptOne =[[CCDirector sharedDirector] convertToGL:ptOne];
    demoSprite.position =  ccp( ptOne.x , ptOne.y );
  }
  
}

#if 0
- (void) onEnter
{
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
 //  [openGLView_ setMultipleTouchEnabled:YES];
	[super onEnter];
}
- (void) onExit
{
	[[CCTouchDispatcher sharedDispatcher] removeDelegate:self];
	[super onExit];
}
#endif

- (void)onPageMoved:(CCScrollLayer *)scrollLayer
{
	[self setPageIndex:scrollLayer.currentScreen - 1];
}


- (void)initScrollLayer
{
	// get screen size
	CGSize screenSize = [CCDirector sharedDirector].winSize;
	
	/////////////////////////////////////////////////
	// PAGE 1
	////////////////////////////////////////////////
	// create a blank layer for page 1
	CCLayer *pageOne = [[CCLayer alloc] init];
	 pageOne.position = ccp(screenSize.width/2, screenSize.height/2);
  [pageOne addChild:demoSprite];
	
	
	// now create the scroller and pass-in the pages (set widthOffset to 0 for fullscreen pages)
 	CCScrollLayer *scroller = [[CCScrollLayer alloc] initWithLayers:[NSMutableArray arrayWithObjects: pageOne,pageOne,nil] widthOffset: 0];
	
	// finally add the scroller to your scene
	[self addChild:scroller];
	
	// page moved delegate
	{
    
		NSMethodSignature* signature = 
		[[self class] instanceMethodSignatureForSelector:@selector(onPageMoved:)];
		
		NSInvocation* invocation = [NSInvocation invocationWithMethodSignature:signature];
		
		[invocation setTarget:self];
		[invocation setSelector:@selector(onPageMoved:)];
		
		scroller.onPageMoved = invocation;
	}
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}


@end
