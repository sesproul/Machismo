//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by sesproul on 1/29/13.
//  Copyright (c) 2013 SDS. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

//designated initializer
-(id) init{
    self = [super init]; //gives super class a chance to initialize
    
    if (self){
        
        for (NSString *suit in [PlayingCard validSuites]){
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank ++){
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card atTop:YES]; //this is not found but apparently is ok because it is a superclass 
            }
        }
        
        
    }
    
    return self;
}
@end
