//
//  ChordLibrary.m
//  Writers Jam
//
//  Created by ZaiEn on 16/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "ChordLibrary.h"

@implementation ChordLibrary


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.Cmajor  = [[NSArray alloc] initWithObjects:@"C",@"Dm",@"Em",@"F",@"G",@"Am",@"Bm7b5", nil];
        self.Gmajor = [[NSArray alloc] initWithObjects:@"G",@"Am",@"Bm",@"C",@"D",@"Em",@"F#m7b5", nil];
        self.Dmajor = [[NSArray alloc] initWithObjects:@"D",@"Em",@"F#m",@"G",@"A",@"Bm",@"C#m7b5", nil];
        

    }
    return self;
}
@end



