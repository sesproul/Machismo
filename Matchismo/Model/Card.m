//
//  Card.m
//  Matchismo
//
//  Created by sesproul on 1/28/13.
//  Copyright (c) 2013 SDS. All rights reserved.
//

#import "Card.h"

@implementation Card



-(int)match:(NSArray *)otherCards{
    //local variable
    int score = 0;
    
    for (Card *card in otherCards){
        if ([card.contents isEqualToString: self.contents]){
            score = 1;
        }
    }
    return score;
}

@end