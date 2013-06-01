//
//  RQGameController.h
//  RandomQuiz
//
//  Created by Ian Calderon on 5/29/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RQHomeScreenViewController.h"
#import "RQQuestionViewController.h"
@class RQScoreBoardViewController;


@interface RQGameController : UIViewController <RQHomeScreenDelegateProtocol, RQQuestionViewControllerDelegate>{
    
    //Question View controller references
    RQQuestionViewController *currentQuestion;
    RQQuestionViewController *nextQuestion;
    RQHomeScreenViewController *homeScreen;
    
    //ScoreBoard View Controller
    RQScoreBoardViewController *scoreBoard;
    
    //eyelids references
    UIView *upperLid;
    UIView *lowerLid;
    
    //to determine active question
    int index;
    
    //score
    int score;
    
    //Timer
    NSTimer *timer;
    int seconds;
    int minutes;
    int secondsPerQuestion;
    
    //all nib list
    NSArray *allNibNames;
    
    void (^lidCloseCallback)(BOOL);
}

-(void)addPoint;

-(void)closeLids;
-(void)openLids;

@end
