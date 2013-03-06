//
//  GameResultViewController.m
//  Matchismo
//
//  Created by sesproul on 3/3/13.
//  Copyright (c) 2013 SDS. All rights reserved.
//

#import "GameResultViewController.h"
#import "GameResult.h"

@interface GameResultViewController ()

@property (weak, nonatomic) IBOutlet UITextView *display;

@end

@implementation GameResultViewController

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
    
}

-(void) updateUI
{
    NSString *displayText = @"";
    //Here we load from the CLASS method all the game results returns an ARRAY
    for (GameResult *result in [GameResult allGameResults]){
        displayText = [displayText stringByAppendingFormat:@"Score: %d (%@, %0g)\n", result.score, result.end, round(result.duration)];
        
    }
    self.display.text = displayText;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
