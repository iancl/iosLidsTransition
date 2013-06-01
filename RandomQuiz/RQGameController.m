//
//  RQGameController.m
//  RandomQuiz
//
//  Created by Ian Calderon on 5/29/13.
//  Copyright (c) 2013 Ian. All rights reserved.
//

#import "RQGameController.h"
#import "RQScoreBoardViewController.h"

@interface RQGameController (PrivateMethods)
-(NSArray *)getNibList;
-(void)initTimer;
-(void)handleTimerTicks: (id)sender;
-(void)updateScore;
-(void)updateTime;
-(void)showScoreBoard;

-(void)showHomeScreen;
-(void)hideHomeScreen;

-(void)generateEyelids;

-(void)hidePreviousQuestion;
-(void)showNextQuestion;
@end

@implementation RQGameController

//constants
static const int A_MINUTE = 60;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
        
        //scoreBoard initialization
        scoreBoard = [[RQScoreBoardViewController alloc] init];
        [scoreBoard.view setFrame:CGRectMake(0.0, 0.0, scoreBoard.view.frame.size.width, scoreBoard.view.frame.size.height)];
        
        
        //getting all nibs from nibs.plist
        allNibNames = [self getNibList];
        
        index = -1;
        
    }
    
    return self;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self showHomeScreen];
    
    //generate Lids
    [self generateEyelids];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

#pragma mark private methods


/**
 *Get NibNames from Plist
 */
-(void)generateEyelids{
    
    //FRAMES WILL BE CLOSED
    
    //setting frame
    CGRect mainFrame = [self.view frame];
    CGRect upperFrame = mainFrame;
    CGRect lowerFrame = mainFrame;
    
    //upper lid related
    upperFrame.size.height = mainFrame.size.height/2;
    upperFrame.origin.x = 0;
    upperFrame.origin.y = upperFrame.size.height * -1;
    
    upperLid = [[UIView alloc] initWithFrame:upperFrame];
    [upperLid setBackgroundColor:[UIColor redColor]];
    
    //lower lid related
    lowerFrame.size.height = mainFrame.size.height/2;
    lowerFrame.origin.y = mainFrame.size.height;
    lowerFrame.origin.x = 0;
    
    lowerLid = [[UIView alloc] initWithFrame:lowerFrame];
    [lowerLid setBackgroundColor:[UIColor greenColor]];
    
    //adding to main view
    [self.view addSubview:upperLid];
    [self.view addSubview:lowerLid];
}


-(void)closeLids{
    [UIView animateWithDuration:1.0 animations:^{
        CGRect topFrame = [upperLid frame];
        CGRect botFrame = [lowerLid frame];
        
        topFrame.origin.y = 0;
        botFrame.origin.y = self.view.frame.size.height - botFrame.size.height;
        
        [upperLid setFrame:topFrame];
        [lowerLid setFrame:botFrame];
        
    } completion:lidCloseCallback];
}

-(void)openLids{
    [UIView animateWithDuration:1.0 animations:^{
        CGRect topFrame = [upperLid frame];
        CGRect botFrame = [lowerLid frame];
        
        topFrame.origin.y = topFrame.size.height * -1;
        botFrame.origin.y = self.view.frame.size.height;
        
        [upperLid setFrame:topFrame];
        [lowerLid setFrame:botFrame];
        
    } completion:^(BOOL finished){
        if(finished){
            
        }
    }];
}

-(void)clearLidCloseCallback{
    lidCloseCallback = nil;
}

/**
 *Get NibNames from Plist
 */
-(NSArray *)getNibList{
    NSArray *nibs = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"nibs" ofType:@"plist"]];
    
    return nibs;
}

/**
 *Init Timer
 */
-(void)initTimer{
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handleTimerTicks:) userInfo:nil repeats:YES];
}

/**
 *Show Home Screen
 */
-(void)showHomeScreen{
    homeScreen = [[RQHomeScreenViewController alloc] init];
    
    [homeScreen setDelegate:self];
    [self addChildViewController:homeScreen];
    [self.view addSubview:homeScreen.view];
}

/**
 *Hide Home Screen
 */
-(void)hideHomeScreen{
    
    [homeScreen removeFromParentViewController];
    [homeScreen.view removeFromSuperview];
    [homeScreen setDelegate:nil];
    homeScreen = nil;
}

/**
 *Show ScoreBoard
 */
-(void)showScoreBoard{
    [self addChildViewController:scoreBoard];
    [self.view addSubview:scoreBoard.view];
    
    
    [self updateScore];
    [self updateTime];
}

/**
 *Handling Ticks
 */
-(void)handleTimerTicks: (id)sender{
    //update Timer Here
    seconds++;
    
    if(seconds % A_MINUTE == 0){
        seconds = 0;
        minutes++;
    }
    
    [self updateTime]; 
}

/**
 *Updating score on ScoreBoard
 */
-(void)updateScore{
    
    NSString *currentScore = [NSString stringWithFormat:@"%i", score];
  
    
    [scoreBoard setScore:currentScore];
    [scoreBoard refreshBoard];
}
/**
 *Updating time on ScoreBoard
 */
-(void)updateTime{
    NSString *currentTime = [NSString stringWithFormat:@"m%i : s%i", minutes, seconds];
    
    [scoreBoard setTime:currentTime];
    [scoreBoard refreshBoard];
}

-(void)showNextQuestion{
    
    if(index >= [allNibNames count]) {
        
        //transition to final screen here
        
        return;
    }
    
    currentQuestion = [[RQQuestionViewController alloc] initWithNibName:[allNibNames objectAtIndex:index] bundle:nil];
    
    [currentQuestion setDelegate:self];
    
    [self addChildViewController:currentQuestion];
    [self.view addSubview:currentQuestion.view];
    [self.view sendSubviewToBack:currentQuestion.view];
}

-(void)hidePreviousQuestion{
    //if(index <= 0)
     //   return;
    index++;
    
    [currentQuestion removeFromParentViewController];
    [currentQuestion.view removeFromSuperview];
    [currentQuestion setDelegate:nil];
    currentQuestion = nil;
}

#pragma  mark public methods

/**
 *add a point
 */
-(void)addPoint{
    score++;
    [self updateScore];
}

#pragma mark homeScreen delegate methods
/**
 *Delegate methods called when the start game button is clicked
 */
-(void)shouldStartGame{
    
    __block RQGameController *currentContext = self;
    
    //defininf lidCloseCallback
    lidCloseCallback = ^void(BOOL finished){
        
        if (finished) {
            [currentContext hideHomeScreen];
            [currentContext hidePreviousQuestion];
            [currentContext showNextQuestion];
            [currentContext clearLidCloseCallback];
            currentContext = nil;
            
        }
    };
    
    [self closeLids];
}

#pragma mark Question View Controller delegate methods
/**
 *Delegate methods called when the current question view was rendered
 */
-(void)viewWasRendered{
    [self openLids];
}

-(void)shouldShowNextQuestion{
    
    if(index == [allNibNames count]) return;
    
    NSLog(@"%i", index);
    
    __block RQGameController *currentContext = self;
    
    //defininf lidCloseCallback
    lidCloseCallback = ^void(BOOL finished){
        
        [currentContext hidePreviousQuestion];
        [currentContext showNextQuestion];
        [currentContext clearLidCloseCallback];
        currentContext = nil;
    };
    
    [self closeLids];
    
}

@end

