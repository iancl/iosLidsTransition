//
//  RQHomeScreenViewController.h
//  RandomQuiz
//
//  Created by Ian Calderon on 5/29/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import <UIKit/UIKit.h>

//Protocol
@protocol RQHomeScreenDelegateProtocol <NSObject>

@required
-(void)shouldStartGame;

@end

//Interface
@interface RQHomeScreenViewController : UIViewController

@property (nonatomic, weak) id<RQHomeScreenDelegateProtocol> delegate;

-(IBAction)startGameBtnClicked:(id)sender;

@end

