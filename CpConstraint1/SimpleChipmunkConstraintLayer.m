//
//  SimpleChipmunkConstraintLayer.m
//  BasicCocos2D
//
//  Created by Ian Fan on 26/08/12.
//
//

#import "SimpleChipmunkConstraintLayer.h"

#define GRABABLE_MASK_BIT (1<<31)
#define NOT_GRABABLE_MASK (~GRABABLE_MASK_BIT)

@implementation SimpleChipmunkConstraintLayer

@synthesize body1,body2;

+(CCScene *) scene {
	CCScene *scene = [CCScene node];
	SimpleChipmunkConstraintLayer *layer = [SimpleChipmunkConstraintLayer node];
	[scene addChild: layer];
  
	return scene;
}

#pragma mark -
#pragma mark Chipmunk Constraint Menu

-(void)setChipmunkConstraintMenu
{
  int fontSize = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)? 18:20;
  
  CCLabelTTF *label1 = [CCLabelTTF labelWithString:@"PinJoint" fontName:@"Helvetica" fontSize:fontSize];
  CCMenuItemLabel *menuItemLabel1 = [CCMenuItemLabel itemWithLabel:label1 target:self selector:@selector(chipmunkPinJoint)];
  
  CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"SlideJoint" fontName:@"Helvetica" fontSize:fontSize];
  CCMenuItemLabel *menuItemLabel2 = [CCMenuItemLabel itemWithLabel:label2 target:self selector:@selector(chipmunkSlideJoint)];
  
  CCLabelTTF *label3 = [CCLabelTTF labelWithString:@"PivotJoint" fontName:@"Helvetica" fontSize:fontSize];
  CCMenuItemLabel *menuItemLabel3 = [CCMenuItemLabel itemWithLabel:label3 target:self selector:@selector(chipmunkPivotJoint)];
  
  CCLabelTTF *label4 = [CCLabelTTF labelWithString:@"GrooveJoint" fontName:@"Helvetica" fontSize:fontSize];
  CCMenuItemLabel *menuItemLabel4 = [CCMenuItemLabel itemWithLabel:label4 target:self selector:@selector(chipmunkGrooveJoint)];
  
  CCLabelTTF *label5 = [CCLabelTTF labelWithString:@"DampedSpring" fontName:@"Helvetica" fontSize:fontSize];
  CCMenuItemLabel *menuItemLabel5 = [CCMenuItemLabel itemWithLabel:label5 target:self selector:@selector(chipmunkDampedSpring)];
  
  CCLabelTTF *label6 = [CCLabelTTF labelWithString:@"DampedRotarySpring" fontName:@"Helvetica" fontSize:fontSize];
  CCMenuItemLabel *menuItemLabel6 = [CCMenuItemLabel itemWithLabel:label6 target:self selector:@selector(chipmunkDampedRotarySpring)];
  
  CCLabelTTF *label7 = [CCLabelTTF labelWithString:@"RotaryLimitJoint" fontName:@"Helvetica" fontSize:fontSize];
  CCMenuItemLabel *menuItemLabel7 = [CCMenuItemLabel itemWithLabel:label7 target:self selector:@selector(chipmunkRotaryLimitJoint)];
  
  CCLabelTTF *label8 = [CCLabelTTF labelWithString:@"SimpleMotor" fontName:@"Helvetica" fontSize:fontSize];
  CCMenuItemLabel *menuItemLabel8 = [CCMenuItemLabel itemWithLabel:label8 target:self selector:@selector(chipmunkSimpleMotor)];
  
  CCLabelTTF *label9 = [CCLabelTTF labelWithString:@"GearJoint" fontName:@"Helvetica" fontSize:fontSize];
  CCMenuItemLabel *menuItemLabel9 = [CCMenuItemLabel itemWithLabel:label9 target:self selector:@selector(chipmunkGearJoint)];
  
  CCLabelTTF *label10 = [CCLabelTTF labelWithString:@"RatchetJoint" fontName:@"Helvetica" fontSize:fontSize];
  CCMenuItemLabel *menuItemLabel10 = [CCMenuItemLabel itemWithLabel:label10 target:self selector:@selector(chipmunkRatchetJoint)];
  
  CCMenu *menu = [CCMenu menuWithItems:menuItemLabel1,menuItemLabel2,menuItemLabel3,menuItemLabel4,menuItemLabel5,menuItemLabel6,menuItemLabel7,menuItemLabel8,menuItemLabel9,menuItemLabel10, nil];
  [menu alignItemsVertically];
  CGSize winSize = [CCDirector sharedDirector].winSize;
  CGPoint menuPosition = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)? CGPointMake(100, winSize.height/2):CGPointMake(140, winSize.height/2-180);
  [menu setPosition:menuPosition];
  [self addChild:menu];
}

-(void)chipmunkPinJoint {
  [self removeConstraint];
  
  ChipmunkConstraint *constraint = [ChipmunkPinJoint pinJointWithBodyA:body1 bodyB:body2 anchr1:cpvzero anchr2:cpvzero];
  [_space addConstraint:constraint];
}

-(void)chipmunkSlideJoint {
  [self removeConstraint];
  
  ChipmunkConstraint *constraint = [ChipmunkSlideJoint slideJointWithBodyA:body1 bodyB:body2 anchr1:cpvzero anchr2:cpvzero min:150 max:300];
  [_space addConstraint:constraint];
}

-(void)chipmunkPivotJoint {
  [self removeConstraint];
  
  ChipmunkConstraint *constraint = [ChipmunkPivotJoint pivotJointWithBodyA:body1 bodyB:body2 anchr1:cpv(100, 0) anchr2:cpv(-100, 0)];
  [_space addConstraint:constraint];
}

-(void)chipmunkGrooveJoint {
  [self removeConstraint];
  
  CGSize winSize = [CCDirector sharedDirector].winSize;
  
  ChipmunkConstraint *constraint = [ChipmunkGrooveJoint grooveJointWithBodyA:_space.staticBody bodyB:body1 groove_a:cpv(winSize.width*2/5, winSize.height/2) groove_b:cpv(winSize.width*4/5, winSize.height/2) anchr2:cpvzero];
  [_space addConstraint:constraint];
  
  constraint = [ChipmunkGrooveJoint grooveJointWithBodyA:_space.staticBody bodyB:body2 groove_a:cpv(winSize.width*2/5, winSize.height/2) groove_b:cpv(winSize.width*4/5, winSize.height/2) anchr2:cpvzero];
  [_space addConstraint:constraint];
}

-(void)chipmunkDampedSpring {
  [self removeConstraint];
  
  ChipmunkConstraint *constraint = [ChipmunkDampedSpring dampedSpringWithBodyA:body1 bodyB:body2 anchr1:cpvzero anchr2:cpvzero restLength:200 stiffness:400 damping:10];
  [_space addConstraint:constraint];
}

-(void)chipmunkDampedRotarySpring {
  [self removeConstraint];
  
  ChipmunkConstraint *constraint = [ChipmunkDampedRotarySpring dampedRotarySpringWithBodyA:body1 bodyB:body2 restAngle:1 stiffness:500 damping:1];
  [_space addConstraint:constraint];
  
  //fix body1 at the same position
  constraint = [ChipmunkPivotJoint pivotJointWithBodyA:_space.staticBody bodyB:body1 pivot:body1.pos];
  [_space addConstraint:constraint];
  
  //fix body2 at the same position
  constraint = [ChipmunkPivotJoint pivotJointWithBodyA:_space.staticBody bodyB:body2 pivot:body2.pos];
  [_space addConstraint:constraint];
}

-(void)chipmunkRotaryLimitJoint {
  [self removeConstraint];
  
  ChipmunkConstraint *constraint = [ChipmunkRotaryLimitJoint rotaryLimitJointWithBodyA:body1 bodyB:body2 min:5 max:10];
  [_space addConstraint:constraint];
  
  //fix body1 at the same position
  constraint = [ChipmunkPivotJoint pivotJointWithBodyA:_space.staticBody bodyB:body1 pivot:body1.pos];
  [_space addConstraint:constraint];
  
  //fix body2 at the same position
  constraint = [ChipmunkPivotJoint pivotJointWithBodyA:_space.staticBody bodyB:body2 pivot:body2.pos];
  [_space addConstraint:constraint];
}

-(void)chipmunkSimpleMotor {
  [self removeConstraint];
  
  ChipmunkConstraint *constraint = [ChipmunkSimpleMotor simpleMotorWithBodyA:body1 bodyB:body2 rate:2.0];
  [_space addConstraint:constraint];
}

-(void)chipmunkGearJoint {
  [self removeConstraint];
  
  ChipmunkConstraint *constraint = [ChipmunkGearJoint gearJointWithBodyA:body1 bodyB:body2 phase:10 ratio:10];
  [_space addConstraint:constraint];
  
  //fix body1 at the same position
  constraint = [ChipmunkPivotJoint pivotJointWithBodyA:_space.staticBody bodyB:body1 pivot:body1.pos];
  [_space addConstraint:constraint];
  
  //fix body2 at the same position
  constraint = [ChipmunkPivotJoint pivotJointWithBodyA:_space.staticBody bodyB:body2 pivot:body2.pos];
  [_space addConstraint:constraint];
}

-(void)chipmunkRatchetJoint {
  [self removeConstraint];
  
  ChipmunkConstraint *constraint = [ChipmunkRatchetJoint ratchetJointWithBodyA:body1 bodyB:body2 phase:10 ratchet:10];
  [_space addConstraint:constraint];
}

-(void)removeConstraint {
  for (ChipmunkConstraint *cs in [_space constraints]) {
    if ([_space contains:cs]) [_space smartRemove:cs];
  }
}

#pragma mark -
#pragma mark Chipmunk objects

-(void)setChipmunkObjects {
  CGSize winSize = [CCDirector sharedDirector].winSize;
  
  //set circle1
  {
  cpFloat mass = 10;
  cpFloat innerRadius = 0;
  cpFloat outerRadius = 50;
  cpVect offset = cpvzero;
  cpVect position = cpv(winSize.width*2/5, winSize.height/2);
  cpFloat elasticity = 0.8;
  cpFloat friction = 0.2;
  
  cpFloat moment = cpMomentForCircle(mass, innerRadius, outerRadius, offset);
  self.body1 = [ChipmunkBody bodyWithMass:mass andMoment:moment];
  body1.pos = position;
  [_space addBody:body1];
  
  ChipmunkShape *shape = [ChipmunkCircleShape circleWithBody:body1 radius:outerRadius offset:offset];
  shape.elasticity = elasticity;
  shape.friction = friction;
  [_space addShape:shape];
  }
  
  //set circle2
  {
  cpFloat mass = 10;
  cpFloat innerRadius = 0;
  cpFloat outerRadius = 50;
  cpVect offset = cpvzero;
  cpVect position = cpv(winSize.width*3/5, winSize.height/2);
  cpFloat elasticity = 0.8;
  cpFloat friction = 0.2;
  
  cpFloat moment = cpMomentForCircle(mass, innerRadius, outerRadius, offset);
  self.body2 = [ChipmunkBody bodyWithMass:mass andMoment:moment];
  body2.pos = position;
  [_space addBody:body2];
  
  ChipmunkShape *shape = [ChipmunkCircleShape circleWithBody:body2 radius:outerRadius offset:offset];
  shape.elasticity = elasticity;
  shape.friction = friction;
  [_space addShape:shape];
  }
}


#pragma mark -
#pragma mark Touch Event

-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
  for(UITouch *touch in touches){
    CGPoint point = [touch locationInView:[touch view]];
    point = [[CCDirector sharedDirector]convertToGL:point];
    [_multiGrab beginLocation:point];
  }
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
{
  for(UITouch *touch in touches){
    CGPoint point = [touch locationInView:[touch view]];
    point = [[CCDirector sharedDirector]convertToGL:point];
    [_multiGrab updateLocation:point];
  }
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
{
	for(UITouch *touch in touches){
    CGPoint point = [touch locationInView:[touch view]];
    point = [[CCDirector sharedDirector]convertToGL:point];
    [_multiGrab endLocation:point];
  }
}

-(void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event {
  [self ccTouchEnded:touch withEvent:event];
}

#pragma mark -
#pragma mark Update

-(void)update:(ccTime)dt {
  [_space step:dt];
}

#pragma mark -
#pragma mark CpDebugLayer

-(void)setChipmunkDebugLayer {
  _debugLayer = [[CPDebugLayer alloc]initWithSpace:_space.space options:nil];
  [self addChild:_debugLayer z:999];
}

#pragma mark -
#pragma mark ChipmunkMultiGrab

-(void)setChipmunkMultiGrab {
  cpFloat grabForce = 1e5;
  cpFloat smoothing = cpfpow(0.3,60);
  
  _multiGrab = [[ChipmunkMultiGrab alloc]initForSpace:_space withSmoothing:smoothing withGrabForce:grabForce];
  _multiGrab.layers = GRABABLE_MASK_BIT;
  _multiGrab.grabFriction = grabForce*0.1;
  _multiGrab.grabRotaryFriction = 1e3;
  _multiGrab.grabRadius = 20.0;
  _multiGrab.pushMass = 1.0;
  _multiGrab.pushFriction = 0.7;
  _multiGrab.pushMode = FALSE;
}

#pragma mark -
#pragma mark ChipmunkSpace

-(void)setChipmunkSpace {
  CGSize winSize = [CCDirector sharedDirector].winSize;
  
  _space = [[ChipmunkSpace alloc]init];
  [_space addBounds:CGRectMake(0, 0, winSize.width, winSize.height) thickness:60 elasticity:1.0 friction:0.2 layers:NOT_GRABABLE_MASK group:nil collisionType:nil];
}

#pragma mark -
#pragma mark Init

/*
 Target: Set many types of ChipmunkConstraint.
 
 1. set ChipmunkSpace, ChipmunkMultiGrab, updateStep as usual.
 2. set Two Chipmunk objects.
 3. set a constraint menu to run many types of ChipmunkConstraint effects.
 */

-(id) init {
	if((self = [super init])) {
    
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.1],[CCCallBlock actionWithBlock:^(id sender){
      self.isTouchEnabled = YES;
    }], nil]];
    
    [self setChipmunkSpace];
    
    [self setChipmunkMultiGrab];
    
    [self setChipmunkDebugLayer];
    
    [self setChipmunkObjects];
    
    [self setChipmunkConstraintMenu];
    
    [self chipmunkPinJoint];
    
    [self schedule:@selector(update:)];
    
    self.isTouchEnabled = YES;
	}
	return self;
}

- (void) dealloc {
  self.body1 = nil;
  self.body2 = nil;
  
  [_space release];
  [_multiGrab release];
  [_debugLayer release];
  
	[super dealloc];
}

@end
