//
//  HelloWorldLayer.h
//  SpirteZoomInOut
//
//  Created by Cheng Leon on 11/12/4.
//  Copyright __MyCompanyName__ 2011年. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import <UIKit/UIKit.h>

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
  float oldDist;

  CCSprite *demoSprite;
  CCSprite *chicken;
  
  UIView *glView;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

//myScrollView在兩個以上的函式會用到，因此用property、synthesize比較方便使用
//@property (nonatomic,retain) UIScrollView *myScrollView;
//
//@property (nonatomic,retain) UITableView *myTableView;


@end
