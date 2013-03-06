//
//  GameResult.m
//  Matchismo
//
//  Created by sesproul on 2/28/13.
//  Copyright (c) 2013 SDS. All rights reserved.
//

#import "GameResult.h"

@interface GameResult ()
//internal implementation is different than the external readonly,
//I may access through property and set
@property (readwrite, nonatomic) NSDate *start;
@property (readwrite, nonatomic) NSDate *end;

@end

@implementation GameResult

//designated initializer
-(id) init
{
    self = [super init];
    if (self){
        // design philosophy, in the initializer, do not call
        // the setters and getters.
        // since the object is not yet set properly, only ivars
        _start = [NSDate date];
        _end = _start;
    }
    
    return self;
}


//This is the Namespaced key that stores all the NSUSerDefaults
#define ALL_RESULTS_KEY @"Gameresult_All" //STORED AT TOP LEVEL for this application
#define START_KEY @"StartDate"
#define END_KEY @"EndDate"
#define SCORE_KEY @"Score"


+(NSArray *)allGameResults
{
    NSMutableArray *allGameResults = [[NSMutableArray alloc] init];
    
    for (id plist in [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] allValues]) {
        
        GameResult *result = [[GameResult alloc] initFromPropertyList:plist];
        [allGameResults addObject:result];
     
    }
    return allGameResults;
    
}

// Convenience initialize so I call my own initializer internally
-(id)initFromPropertyList:(id)plist
{
    self = [self init];
    if (self){
        if ([plist isKindOfClass:[NSDictionary class]]){
            NSDictionary *resultDictionary = (NSDictionary *) plist;
            
            _start = resultDictionary[START_KEY];
            _end = resultDictionary[END_KEY];
            _score = [resultDictionary[SCORE_KEY] intValue];
            
            if(!_start || !_end) self = nil;
            
        }
    }
    return self;
}

-(void)synchronize
{
    //get the dictionary that has ALL the games in it
    NSMutableDictionary *mutableGameResultsFromUserDefaults = [[[NSUserDefaults standardUserDefaults] dictionaryForKey:ALL_RESULTS_KEY] mutableCopy];
    
    //Create a new one if we have not saved one before
    if (!mutableGameResultsFromUserDefaults) mutableGameResultsFromUserDefaults = [[NSMutableDictionary alloc] init];
    
    mutableGameResultsFromUserDefaults[[self.start description]] = [self asPropertyList];
    
    //Now put it back in StandardUserDefaults USING THE ALL_RESULTS_KEY
    [[NSUserDefaults standardUserDefaults] setObject:mutableGameResultsFromUserDefaults forKey:ALL_RESULTS_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}




-(id)asPropertyList
{
    return @{START_KEY:self.start, END_KEY:self.end, SCORE_KEY:@(self.score)};
}

-(NSTimeInterval)duration
{
    return [self.end timeIntervalSinceDate:self.start];
}


-(void)setScore:(int)score
{
    _score=score;
    self.end = [NSDate date];
    [self synchronize]; //write's game result out to NSUSerDefault
    
}

@end
