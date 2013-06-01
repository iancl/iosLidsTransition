//
//  RQHomeScreenViewController.m
//  RandomQuiz
//
//  Created by Ian Calderon on 5/29/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import "RQHomeScreenViewController.h"

@implementation RQHomeScreenViewController
@synthesize delegate;


-(void)setDelegate:(id<RQHomeScreenDelegateProtocol>)aDelegate{
    if(delegate != aDelegate){
        delegate = aDelegate;
    }
}

-(IBAction)startGameBtnClicked:(id)sender{
   
    if([delegate respondsToSelector:@selector(shouldStartGame)]){
        [delegate shouldStartGame];
    }
}

-(void)dealloc{
    NSLog(@"destroyed home screen");
}

@end
