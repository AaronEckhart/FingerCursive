//
//  DrawingScene.m
//  FingerCursive
//
//  Created by AE on 7/9/14.
//  Copyright (c) 2014 Aaron Eckhart. All rights reserved.
//

#import "DrawingScene.h"

@interface DrawingScene ()

@property SKSpriteNode *cue;
@property SKSpriteNode *fieldSphere;
@property SKSpriteNode *goal;

@end



//static const uint32_t fieldSphereCatagory = 0x1;
static const uint32_t cueCatagory = 0x1 << 1;
//static const uint32_t goalCatagory = 0x1 << 2;
static const uint32_t edgeCatagory = 0x1 << 3;

@implementation DrawingScene



-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {

        //the scene
        self.backgroundColor = [SKColor blackColor];
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];


        self.physicsBody.categoryBitMask = edgeCatagory;


        //[self addFieldSphere:size];
        [self addCue:size];
        //[self addGoal:size];


    }
    return self;
}


- (void) addCue:(CGSize)size
{
    self.cue = [SKSpriteNode spriteNodeWithImageNamed:@"Oval 1"];
    CGPoint playerPoint = CGPointMake(size.width / 2, size.height / 2);
    self.cue.position = playerPoint;
    self.cue.alpha = 0.001f;


    [self addChild:self.cue];

    self.cue.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.cue.size.width / 2];
    self.cue.physicsBody.dynamic = NO;
    //self.cue.physicsBody.mass = 200;
    self.cue.physicsBody.categoryBitMask = cueCatagory;
    //self.cue.physicsBody.usesPreciseCollisionDetection = YES;
    //self.cue.physicsBody.restitution = 1.0;
    //self.cue.physicsBody.friction = 0.0f;




    SKEmitterNode *trail = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"FireParticle" ofType:@"sks"]];
    trail.targetNode = self;
    trail.particleScale = 1;
    trail.position = CGPointMake(0,0);

//    SKEmitterNode *goal = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"GoalFireParticle" ofType:@"sks"]];
//    //goal.position = CGPointMake(20, 0);
//    goal.targetNode = self;
//    goal.particleScale = 1;
//    goal.position = CGPointMake(0,0);

//    SKEmitterNode *bok = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"bokehParticle" ofType:@"sks"]];
//    //goal.position = CGPointMake(20, 0);
//    bok.targetNode = self;
//    bok.particleScale = 1;
//    bok.position = CGPointMake(0,0);

    [self.cue addChild:trail];
    //[self.cue addChild:goal];
    //[self.cue addChild:bok];
}



-(void)didBeginContact:(SKPhysicsContact *)contact
{
    SKPhysicsBody *notTheSphere;

    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        notTheSphere = contact.bodyB;
    } else {
        notTheSphere = contact.bodyA;
    }

    if (notTheSphere.categoryBitMask == cueCatagory)
    {
        NSLog(@"Smack!");
        CGVector vector = CGVectorMake(0, 0);
        [self.fieldSphere.physicsBody applyImpulse:vector];
    }
    else  if (notTheSphere.categoryBitMask == edgeCatagory)
    {
        NSLog(@"POINT!!!!");
        SKEmitterNode *touchWall = [NSKeyedUnarchiver unarchiveObjectWithFile:[[NSBundle mainBundle] pathForResource:@"TouchWall" ofType:@"sks"]];
        touchWall.position = CGPointMake(30, 40);

        [self addChild:touchWall];

    } else {
        NSLog(@"Gooooooaaaaallllll");
        
    }
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //CGVector vector = CGVectorMake(0, 10);

    //[self.cue.physicsBody applyImpulse:vector];
    [self touchesMoved:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.cue runAction:[SKAction moveTo:[[touches anyObject] locationInNode:self] duration:0.01]];
}


//update method for future anime
- (void)update:(NSTimeInterval)currentTime
{
    //CGPoint cuePosition = self.cue.position;
    
    
}

@end
