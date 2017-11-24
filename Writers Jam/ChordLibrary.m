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
        self.Dbmajor = [[NSArray alloc] initWithObjects:@"Db",@"Ebm",@"Fm",@"Gb",@"Ab",@"Bbm",@"Cm7b5", nil];
        self.Dmajor = [[NSArray alloc] initWithObjects:@"D",@"Em",@"F#m",@"G",@"A",@"Bm",@"C#m7b5", nil];
        self.Ebmajor = [[NSArray alloc] initWithObjects:@"Eb",@"Fm",@"Gm",@"Ab",@"Bb",@"Cm",@"Dm7b5", nil];
        self.Emajor = [[NSArray alloc] initWithObjects:@"E",@"F#m",@"G#m",@"A",@"B",@"C#m",@"D#m7b5", nil];
        self.Fmajor = [[NSArray alloc] initWithObjects:@"F",@"Gm",@"Am",@"Bb",@"C",@"Dm",@"Em7b5", nil];
        self.Gbmajor = [[NSArray alloc] initWithObjects:@"Gb",@"Abm",@"Bbm",@"Cb",@"Db",@"Ebm",@"Fm7b5", nil];
        self.Gmajor = [[NSArray alloc] initWithObjects:@"G",@"Am",@"Bm",@"C",@"D",@"Em",@"F#m7b5", nil];
        self.Amajor = [[NSArray alloc] initWithObjects:@"Ab",@"Bbm",@"Cm",@"Db",@"Eb",@"Fm",@"Gm7b5", nil];
        self.Amajor = [[NSArray alloc] initWithObjects:@"A",@"Bm",@"C#m",@"D",@"E",@"F#m",@"G#m7b5", nil];
        self.Bbmajor = [[NSArray alloc] initWithObjects:@"Bb",@"Cm",@"Dm",@"Eb",@"F",@"Gm",@"Am7b5", nil];
        self.Bmajor = [[NSArray alloc] initWithObjects:@"B",@"C#m",@"D#m",@"E",@"F#",@"G#m",@"A#m7b5", nil];
        
        self.AllChords = [[NSArray alloc] initWithObjects:@"C",@"Cm",@"Cm7b5",@"C#",@"C#m",@"C#m7b5",@"D",@"Dm",@"Dm7b5",@"D#",@"D#m",@"D#m7b5",@"E",@"Em",@"Em7b5",
                                                          @"F",@"Fm",@"Fm7b5",@"F#",@"F#m",@"F#m7b5",@"G",@"Gm",@"Gm7b5",@"G#",@"G#m",@"G#m7b5",@"A",@"Am",@"Am7b5",
                                                          @"A#",@"A#m",@"A#m7b5",@"B",@"Bm",@"Bm7b5",nil];

    }
    return self;
}
@end



