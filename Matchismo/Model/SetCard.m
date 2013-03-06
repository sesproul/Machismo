//
//  SetCard.m
//  Matchismo
//
//  Created by sesproul on 3/3/13.
//  Copyright (c) 2013 SDS. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

+(NSArray *) validSymbols
{
    return @[@"?",@"▲",@"●",@"■"];
}

@synthesize symbol=_symbol;//because we provide setter and getter

- (void)setSymbol:(NSString *) symbol{
    
    //Check to see if the passed in object is in this valid array
    if ([[SetCard validSymbols] containsObject:symbol]){
        _symbol = symbol;
    }
}

-(NSString *)symbol{
    
    //here if suit is nil, then we have to assign the symbol as ?
    // using the tertiary IF
    
    return _symbol ? _symbol : @"?";
}

+(NSArray *) validColors
{
    return @[ @"?",@"Red",@"Green",@"Purple"];
}

@synthesize color=_color;//because we provide setter and getter

- (void)setColor:(NSString *) color{
    
    //Check to see if the passed in object is in this valid array of colors
    if ([[SetCard validColors] containsObject:color]){
        _color = color;
    }
}

-(NSString *)color{
    
    //here if suit is nil, then we have to assign the color as ?
    // using the tertiary IF
    
    return _color ? _color : @"?";
}


- (void)setFill:(NSUInteger)fill{
    
    //Check to see if fill value is 1,2,3
    if (fill==0 || fill ==1 || fill==2) _fill = fill;}

@end
