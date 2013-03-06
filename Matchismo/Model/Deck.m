//
//  Deck.m
//  Matchismo
//
//  Created by sesproul on 1/28/13.
//  Copyright (c) 2013 SDS. All rights reserved.
//

#import "Deck.h"
@interface Deck()
@property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck

-(NSMutableArray *) cards{
    //here we implement the getter and allow for lazy instatiation
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(void) addCard:(Card *)card atTop:(BOOL)atTop {
    
    //only call if the card has value
    if (card){
        if (atTop) {
            [self.cards insertObject:card atIndex:0];
        } else {
            [self.cards addObject:card];
        }
    }
}

- (Card *) drawRandomCard {
    
    
    
    Card *randomCard = nil;
    
    //Protect for empty array
    if (self.cards.count){
    unsigned index = arc4random() % self.cards.count;
     randomCard = [self.cards objectAtIndex:index];
    [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;

}


@end
