//
//  SetCard.h
//  Matchismo
//
//  Created by sesproul on 3/3/13.
//  Copyright (c) 2013 SDS. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger fill;
@property (strong, nonatomic) NSString *symbol;
@property (strong, nonatomic) NSString *color;

+ (NSArray *) validColors;
+ (NSArray *) validSymbols;
@end
