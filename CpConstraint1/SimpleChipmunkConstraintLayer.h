//
//  SimpleChipmunkConstraintLayer.h
//  BasicCocos2D
//
//  Created by Ian Fan on 26/08/12.
//
//

#import "cocos2d.h"
#import "ObjectiveChipmunk.h"
#import "CPDebugLayer.h"

@interface SimpleChipmunkConstraintLayer : CCLayer
{
  ChipmunkSpace *_space;
  ChipmunkMultiGrab *_multiGrab;
  CPDebugLayer *_debugLayer;
}

@property (nonatomic,retain) ChipmunkBody *body1;
@property (nonatomic,retain) ChipmunkBody *body2;

+(CCScene *) scene;

@end
