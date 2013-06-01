//
//  RQScoreBoardViewController.h
//  RandomQuiz
//
//  Created by Ian Calderon on 5/29/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RQScoreBoardViewController : UIViewController{
    __weak IBOutlet UILabel *lblScore;
    __weak IBOutlet UILabel *lblTime;
}

@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *time;

-(void)refreshBoard;

@end
