//
//  RQScoreBoardViewController.m
//  RandomQuiz
//
//  Created by Ian Calderon on 5/29/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import "RQScoreBoardViewController.h"


@implementation RQScoreBoardViewController
@synthesize score, time;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)refreshBoard{
    [lblScore setText:[NSString stringWithFormat:@"Score: %@", [self score]]];
    [lblTime setText:[NSString stringWithFormat:@"Time: %@", [self time]]];
}

@end
