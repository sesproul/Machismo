//
//  PlayingCard.m
//  Matchismo
//
//  Created by sesproul on 1/28/13.
//  Copyright (c) 2013 SDS. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard


//Override
-(int)match:(NSArray *)otherCards{
    
    int score = 0;
    
    if ([otherCards count] ==1) {
        PlayingCard *otherCard = [otherCards lastObject]; //return nil if empty array
        NSLog(@"OtherCard Suit:%@ new Suit:%@   otherCard Rank:%d  NewCard Rank:%d", otherCard.suit, self.suit, otherCard.rank, self.rank);
        if ([otherCard.suit isEqualToString:self.suit]){
            score = 1;
        } else if (otherCard.rank == self.rank) {
            score = 4;
        }
    } else {
        PlayingCard *otherCard1 = otherCards[0]; //return nil if empty array
        PlayingCard *otherCard2 = otherCards[1]; //return nil if empty array

        if ([otherCard1.suit isEqualToString:self.suit] && [otherCard2.suit isEqualToString:self.suit]){
            score = 5;
        
        }
    }

    return score;
}



+(NSArray *)rankStrings{
    
    return  @[ @"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K" ];
}

+(NSArray *) validSuites{
    return @[@"♣",@"♥",@"♦",@"♠"];
}

+(NSUInteger)maxRank{
    return [self rankStrings].count - 1;
}

-(NSString *)contents{
    
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString: self.suit];
}

@synthesize suit=_suit;//because we provide setter and getter
- (void)setSuit:(NSString *) suit{
    
    //Check to see if the passed in object is in this valid array
    if ([[PlayingCard validSuites] containsObject:suit]){
        _suit = suit;
    }
}

-(NSString *)suit{
    
    //here if suit is nil, then we have to assign the suit as ?
    // using the tertiary IF
    
    return _suit ? _suit : @"?";
}

-(void)setRank:(NSUInteger)rank{
    if (rank <= [PlayingCard maxRank]){
        _rank = rank;
    }
}

@end
