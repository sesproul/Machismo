//
//  GameResult.h
//  Matchismo
//
//  Created by sesproul on 2/28/13.
//  Copyright (c) 2013 SDS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameResult : NSObject
//External API read only
@property (readonly, nonatomic) NSDate *start;
@property (readonly, nonatomic) NSDate *end;
@property (readonly, nonatomic) NSTimeInterval duration;

//this property is externally Read/write asda
@property (nonatomic) int score;

//And this is a CLASS method.
+(NSArray *)allGameResults; //Of Game Results
@end
