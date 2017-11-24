//
//  AudioEngine.m
//  Writers Jam
//
//  Created by ZaiEn on 24/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "AudioEngine.h"

@implementation AudioEngine

@synthesize chord1 = _chord1;
@synthesize chord2 = _chord2;
@synthesize chord3 = _chord3;
@synthesize chord4 = _chord4;

static AudioEngine *_sharedInstance;

- (id) init { 
    if (self = [super init]){
        self.chord1 = @"Cmajor";
        self.chord2 = @"Gmajor";
        self.chord3 = @"Aminor";
        self.chord4 = @"Fmajor";
    }
    return self;
}

//
+ (AudioEngine  *) sharedInstance
{
    if(!_sharedInstance){
        _sharedInstance = [[AudioEngine alloc] init];
    }
    return _sharedInstance;
    
}

-(void) setChords {
    
    //initialises the audio players from the last saved audio file name in the global variables, intialises in a different method if a recorded piece of audio if being used.
    //initilise audio files taken from AVAudioPlayer ScreenCast and AVRecorder Blog
    AudioEngine *data =[AudioEngine sharedInstance];
    
            [data setChord1:self.TempSoundFileName];
    

    
    

    
    
    
    
}

    
    
@end
