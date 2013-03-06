//
//  CardGameViewController.m
//  Matchismo
//
//  Created by sesproul on 1/27/13.
//  Copyright (c) 2013 SDS. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"
#import "GameResult.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (weak, nonatomic) IBOutlet UILabel *FlipDisplay;
@property (weak, nonatomic) IBOutlet UISegmentedControl *GameSwitchControl;
@property (nonatomic) int flipCount;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons; //STRONG
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *ScoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *Deal;
@property (strong, nonatomic) GameResult *gameResult;

@end

@implementation CardGameViewController

- (GameResult *) gameResult
{
    if (!_gameResult) _gameResult = [[GameResult alloc] init];
    return _gameResult;
}

- (IBAction)SwitchGameMode:(id)sender {
    UISegmentedControl *Control = (UISegmentedControl *)sender;
    self.game.gamePlayMode = Control.selectedSegmentIndex +2;
}

-(CardMatchingGame *)game{
    //We never actually use the deck, just get cards from it.
    if (!_game) {
        NSInteger mode =  self.GameSwitchControl.selectedSegmentIndex+2;
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
        _game.gamePlayMode = self.GameSwitchControl.selectedSegmentIndex +2;
    }
    return  _game;
}

-(void)setCardButtons:(NSArray *)cardButtons{
    _cardButtons = cardButtons; //sets the array
    [self updateUI];
}



-(void) updateUI{
    //Take the state of the model and make it match the model both directions
    
    for (UIButton *cardButton in self.cardButtons){
        Card *card = [self.game cardAtindex:[self.cardButtons indexOfObject:cardButton]];
        [cardButton setTitle:card.contents forState:UIControlStateSelected];
        [cardButton setTitle:card.contents forState:UIControlStateSelected|UIControlStateDisabled];
        
        cardButton.selected = card.isFaceUp;
        
        [cardButton setImage:[UIImage imageNamed:@"FrogBig.png"] forState:UIControlStateNormal];
        [cardButton setImage:[[UIImage alloc] init] forState:UIControlStateSelected];
        [cardButton setImage:[[UIImage alloc] init] forState:UIControlStateSelected|UIControlStateDisabled];

        
        //cardButton.enabled = !card.isUnPlayable;
        cardButton.alpha =(card.isUnPlayable?.3 :1.0);
        self.ScoreLabel.text =[NSString stringWithFormat:@"Score: %d",[self.game score]];
        
    }
    self.FlipDisplay.text = self.game.flipStatus;
}

//it is ok for purely UI things to be in the controller, otherwise this 
- (void) setFlipCount:(int)flipCount{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    
    //Set the images of the buttons
    
    //UIImage *buttonBackground = [UIImage imageNamed:@"FrogBig.png"];
    
     for (UIButton *Button in self.cardButtons){
         [Button setImage:[UIImage imageNamed:@"FrogBig.png"] forState:UIControlStateNormal];
         [Button setImage:nil forState:UIControlStateSelected];
        
     }
    
    
}

-(void) viewDidAppear:(BOOL)animated
{
    self.tabBarItem.badgeValue = @"S";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Deal:(UIButton *)sender {
    NSString *msg = nil;
    
    msg = @"Are you interested in a new deal?";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"New Deal" message:msg delegate:self cancelButtonTitle:@"No Thank You" otherButtonTitles:@"Yes", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex != 0){
        
        self.GameSwitchControl.enabled = YES;
        //Restart the Game
        self.flipCount = 0;
        self.game = nil;
        self.gameResult = nil;
        [self updateUI];
    }
}

- (IBAction)flipCard:(UIButton *)sender {
    
    //We cast the Card as a playing card so that we are telling the comiler it is a PlayingCard not a Card
    
    self.GameSwitchControl.enabled = NO;
    [self.game flipCardAtindex:[self.cardButtons indexOfObject:sender]];
    [self updateUI];
    self.gameResult.score = self.game.score;
    self.flipCount++;
    
}

@end
