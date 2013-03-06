//
//  PlayingCard.h
//  Matchismo
//
//  Created by sesproul on 1/28/13.
//  Copyright (c) 2013 SDS. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (nonatomic) NSUInteger rank;
@property (strong, nonatomic) NSString *suit;

+ (NSArray *)rankStrings;
+ (NSArray *)validSuites;
+ (NSUInteger)maxRank;

@end
