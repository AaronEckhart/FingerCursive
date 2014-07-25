//
//  TitleScene.m
//  FingerCursive
//
//  Created by AE on 7/9/14.
//  Copyright (c) 2014 Aaron Eckhart. All rights reserved.
//

#import "TitleScene.h"
#import "DrawingScene.h"

@implementation TitleScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {

        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.15 alpha:1.0];

        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura"];

        SKAction *rotateLabel = [SKAction rotateByAngle:1.5707 duration:.000001];
        [myLabel runAction:rotateLabel];

        myLabel.text = @"Finger fire";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));

        [self addChild:myLabel];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    DrawingScene *drawingLevel = [DrawingScene sceneWithSize:self.frame.size];
    SKTransition *transition = [SKTransition doorsOpenHorizontalWithDuration:0.3f];
    [self.view presentScene:drawingLevel transition:transition];
}

-(void)update:(CFTimeInterval)currentTime {
}

@end
