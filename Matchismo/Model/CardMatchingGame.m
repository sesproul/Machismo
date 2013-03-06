//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by sesproul on 2/9/13.
//  Copyright (c) 2013 SDS. All rights reserved.
//

#import "CardMatchingGame.h"
@interface CardMatchingGame()
    @property (readwrite, nonatomic) int score;
    @property (strong, nonatomic) NSMutableArray *cards; // of Card for 3 flip
    @property (readwrite, nonatomic) int flipCardCount;
    @property (readwrite, nonatomic) NSString *flipStatus;

@end


@implementation CardMatchingGame

-(NSString *) flipStatus{
    if (!_flipStatus) _flipStatus = [[NSString alloc] init];
    return _flipStatus;
}

-(NSMutableArray *) cards{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    
    return _cards;
}


- (void)setGamePlayMode:(int)gamePlayMode{
    
    _gamePlayMode = gamePlayMode;    
    NSLog(@"New Value : %d, Current IVAR %d", gamePlayMode, _gamePlayMode);

}

// make these penalty a
#define MATCH_BONUS 4
#define MISMATCH_PENALITY 2
#define FLIP_COST 1

-(void) flipCardAtindex:(NSUInteger)index{
    Card *card = [self cardAtindex:index];
    
    //If we have a card and it is not unplayable
    if (card && !card.isUnPlayable){
        
        NSLog (@"Flip Card self.gameplaymode: %d",self.gamePlayMode);
        if (self.gamePlayMode == 2){
        
        
            //Now we look to see if the card is face up it will currently be not isfaceup
            if(!card.isFaceUp){
                self.flipStatus = [[NSString alloc] initWithFormat:@"The %@ was turned over", card.contents];            
                //Charge for th flip
                self.score -= FLIP_COST;
                
                //Now we extract every other card in the deck (we have not
                // flipped ours over yet so we only compare it to other already flipped cards
                for (Card *otherCard in self.cards){
                    
                    //Only look at playable faceup cards in this portion of the function
                    if (otherCard.isFaceUp && !otherCard.isUnPlayable) {
                        int matchScore = [card match:@[otherCard]];
                        
                        //Check for a match
                        if (matchScore){
                            card.UnPlayable = YES;
                            otherCard.UnPlayable = YES;
                            self.score += matchScore * MATCH_BONUS;
                            self.flipStatus = [[NSString alloc] initWithFormat:@"The %@ matches the %@", card.contents, otherCard.contents];
                        } else {
                            //Mismatch penalty and unfllip the 
                            otherCard.faceUp = NO;
                            self.score -= MISMATCH_PENALITY;
                            self.flipStatus = [[NSString alloc] initWithFormat:@"The %@ does not match the %@", card.contents, otherCard.contents];
                        }
                        
                        //We found another faceup card and matched against it, so break out.
                        break;
                    }

                } //end For
            } //end IF Faceup
            
            //now we flip over the card that was just clicked
            if (card.isFaceUp) {
                self.flipStatus = [[NSString alloc] initWithFormat:@"The %@ was turned back over", card.contents];
            }
            card.faceUp = !card.isFaceUp;
        
        }

       //3 Card Flip
        else {
            NSLog(@"You are in the 3 card section");
            
            //First Disallow more tham 3 flipped over already
            if (!card.isFaceUp && self.flipCardCount==3){
                self.flipStatus = [[NSString alloc] initWithFormat:@"You already Have 3 cards Flipped"];
            } else if  (!card.isFaceUp && self.flipCardCount<2) {
                //Update the Status
                self.flipStatus = [[NSString alloc] initWithFormat:@"The %@ was turned over", card.contents];
                //Charge for the flip
                self.score -= FLIP_COST;
                self.flipCardCount += 1;
                card.FaceUp = !card.isFaceUp;
            } else if (!card.isFaceUp && self.flipCardCount==2){
                
                
                self.flipCardCount += 1;
                
                //Now Start looking far all the face up cards and load them into the
                //Flipped Cards Array
                
                NSMutableArray *flippedCards  = [[NSMutableArray alloc] init];
                for (Card *otherCard in self.cards){
                    
                    //Only look at playable faceup cards in this portion of the function
                    if (otherCard.isFaceUp && !otherCard.isUnPlayable) {
                        [flippedCards addObject:otherCard];
                    }
                    
                } //end For
                
                
                
                int matchScore = [card match:flippedCards];
                //first let's flip over the card beacuse no matter what it gets flipped
                
                //Now the card is flipped, since we have all three
                card.faceUp = YES;
                
                //Check for a match
                if (matchScore){
                    card.UnPlayable = YES;
                    for (Card *otherCard in flippedCards){
                        otherCard.unPlayable = YES;
              
                    } //end For
                    self.score += matchScore * MATCH_BONUS;
                    self.flipStatus = [[NSString alloc] initWithFormat:@"The %@ matches %@, %@", card.contents, [flippedCards[0] contents], [flippedCards[1] contents]];
                    self.flipCardCount = 0;
                } else {
                    //Mismatch penalty and unfllip the
                    self.score -= MISMATCH_PENALITY;
                    self.flipStatus = [[NSString alloc] initWithFormat:@"The %@ no match: %@, %@", card.contents, [flippedCards[0] contents], [flippedCards[1] contents]];
                }

                
            } else if (card.isFaceUp){
                //Flip the card over if you clicked a
                card.faceUp = !card.isFaceUp;
                self.flipCardCount -= 1;
            }

            
        }//end of Face up section for card 3
        
    }// End of CARD and !isUnplayable
    
    else if (card.isUnPlayable){
        self.flipStatus = [[NSString alloc] initWithFormat:@"The %@ is unplayable", card.contents];
    }
        
        
            
}


-(Card *) cardAtindex:(NSUInteger)index{
    
    return (index < [self.cards count]) ?   self.cards[index] : nil;
    }


-(id)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    self = [super init];
    
    if (self){
         
        //draw out the count of cards for this game
        for (int i= 0; i < count; i++){
            Card *card = [deck drawRandomCard];
            if (card) {
                self.cards[i] = card;
            } else{
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

@end
