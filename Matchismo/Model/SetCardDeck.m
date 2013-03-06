//
//  SetCardDeck.m
//  Matchismo
//
//  Created by sesproul on 3/4/13.
//  Copyright (c) 2013 SDS. All rights reserved.
//

#import "SetCardDeck.h"

@implementation SetCardDeck

//designated initializer
-(id) init{
    self = [super init]; //gives the superclass a chance to initialize
    
    if (self)
    {
        //Loop colors
        for (NSString *color in [SetCard validColors]){
            for (NSString *symbol in [SetCard validSymbols]){
                for (int fill = 0; fill <= 2; fill++) {
                    SetCard *card = [[SetCard alloc] init];
                    card.color = color;
                    card.symbol = symbol;
                    card.fill = fill;
                    //using the deck inherited function
                    //you can add a SetCard to any deck
                    //Since a set card isaKinfof Card
                    [self addCard:card  atTop:YES];
                }
            }
        }
    }
    
    return self;
}
@end
