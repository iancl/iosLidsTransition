//
//  RQQuestionViewController.h
//  RandomQuiz
//
//  Created by Ian Calderon on 5/29/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RQQuestionViewControllerDelegate <NSObject>

@required
-(void)viewWasRendered;
-(void)shouldShowNextQuestion;

@end

@interface RQQuestionViewController : UIViewController

@property (nonatomic, weak) id<RQQuestionViewControllerDelegate> delegate;


-(IBAction)showNextQuestion:(id)sender;

@end
