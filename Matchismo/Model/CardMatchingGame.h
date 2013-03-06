//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by sesproul on 2/9/13.
//  Copyright (c) 2013 SDS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "deck.h"
@interface CardMatchingGame : NSObject

// designated initializer
-(id) initWithCardCount:(NSUInteger)count
              usingDeck:(Deck *)deck;

-(void) flipCardAtindex:(NSUInteger)index;

-(Card *) cardAtindex:(NSUInteger)index;

@property (readonly, nonatomic) int score;
@property (readwrite, nonatomic) int gamePlayMode;

@property (readonly, nonatomic) NSString *flipStatus;


@end
