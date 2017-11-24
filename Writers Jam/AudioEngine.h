//
//  AudioEngine.h
//  Writers Jam
//
//  Created by ZaiEn on 24/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "ChordLibrary.h"
#import "ViewController.h"

@interface AudioEngine : NSObject

@property (strong, nonatomic) AVAudioPlayer *Chord1;

@property (strong, nonatomic) AVAudioPlayer *playCmajor;
@property (strong, nonatomic) AVAudioPlayer *playDminor;
@property (strong, nonatomic) AVAudioPlayer *playEminor;
@property (strong, nonatomic) AVAudioPlayer *playFmajor;
@property (strong, nonatomic) AVAudioPlayer *playGmajor;
@property (strong, nonatomic) AVAudioPlayer *playAminor;
@property (strong, nonatomic) AVAudioPlayer *playBm7b5;

@end


