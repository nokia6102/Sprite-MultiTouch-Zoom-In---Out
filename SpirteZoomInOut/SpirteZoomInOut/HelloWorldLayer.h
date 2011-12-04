//
//  HelloWorldLayer.h
//  SpirteZoomInOut
//
//  Created by Cheng Leon on 11/12/4.
//  Copyright __MyCompanyName__ 2011年. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
  float oldDist;

  CCSprite *demoSprite;
  UIView *glView;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
//@property CCSprie;

@end
