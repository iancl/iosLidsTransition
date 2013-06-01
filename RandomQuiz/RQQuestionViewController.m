//
//  RQQuestionViewController.m
//  RandomQuiz
//
//  Created by Ian Calderon on 5/29/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import "RQQuestionViewController.h"

@implementation RQQuestionViewController
@synthesize delegate;

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSLog(@"view will appear Question");
    if([delegate respondsToSelector:@selector(viewWasRendered)]){
        [delegate viewWasRendered];
    }
}

-(void)setDelegate:(id<RQQuestionViewControllerDelegate>)aDelegate{
    if(delegate != aDelegate){
        delegate = aDelegate;
    }
}

-(IBAction)showNextQuestion:(id)sender{
    if([delegate respondsToSelector:@selector(shouldShowNextQuestion)]){
        [delegate shouldShowNextQuestion];
    }
}

-(void)dealloc{
    NSLog(@"question destroyeds");
}

@end
