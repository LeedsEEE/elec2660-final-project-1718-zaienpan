//
//  AudioEngine.m
//  Writers Jam
//
//  Created by ZaiEn on 24/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "AudioEngine.h"


@implementation AudioEngine

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ViewController *tempViewController = [segue destinationViewController];
    {
        tempViewController.Chord1ToPass = self.Chord1;

        
    }
    
}

- (void) setupAudioPlayers {
    NSLog(@"Setup audio player path");
    
    NSString *Cmajor = [[NSBundle mainBundle] pathForResource:@"Cmajor" ofType:@"wav"];
    NSURL *CmajorURL = [[NSURL alloc] initFileURLWithPath:Cmajor];
    self.playCmajor = [[AVAudioPlayer alloc] initWithContentsOfURL:CmajorURL error:nil];
    [self.playCmajor prepareToPlay];
    
    NSString *Dminor = [[NSBundle mainBundle] pathForResource:@"Dminor" ofType:@"wav"];
    NSURL *DminorURL = [[NSURL alloc] initFileURLWithPath:Dminor];
    self.playDminor = [[AVAudioPlayer alloc] initWithContentsOfURL:DminorURL error:nil];
    [self.playDminor prepareToPlay];
    
    NSString *Eminor = [[NSBundle mainBundle] pathForResource:@"Eminor" ofType:@"wav"];
    NSURL *EminorURL = [[NSURL alloc] initFileURLWithPath:Eminor];
    self.playEminor = [[AVAudioPlayer alloc] initWithContentsOfURL:EminorURL error:nil];
    [self.playEminor prepareToPlay];
    
    NSString *Fmajor = [[NSBundle mainBundle] pathForResource:@"Fmajor" ofType:@"wav"];
    NSURL *FmajorURL = [[NSURL alloc] initFileURLWithPath:Fmajor];
    self.playFmajor = [[AVAudioPlayer alloc] initWithContentsOfURL:FmajorURL error:nil];
    [self.playFmajor prepareToPlay];
    
    NSString *Gmajor = [[NSBundle mainBundle] pathForResource:@"Gmajor" ofType:@"wav"];
    NSURL *GmajorURL = [[NSURL alloc] initFileURLWithPath:Gmajor];
    self.playGmajor = [[AVAudioPlayer alloc] initWithContentsOfURL:GmajorURL error:nil];
    [self.playGmajor prepareToPlay];
    
    NSString *Aminor = [[NSBundle mainBundle] pathForResource:@"Aminor" ofType:@"wav"];
    NSURL *AminorURL = [[NSURL alloc] initFileURLWithPath:Aminor];
    self.playAminor = [[AVAudioPlayer alloc] initWithContentsOfURL:AminorURL error:nil];
    [self.playAminor prepareToPlay];
    
    NSString *Bm7b5 = [[NSBundle mainBundle] pathForResource:@"Bm7b5" ofType:@"wav"];
    NSURL *Bm7b5URL = [[NSURL alloc] initFileURLWithPath:Bm7b5];
    self.playBm7b5 = [[AVAudioPlayer alloc] initWithContentsOfURL:Bm7b5URL error:nil];
    [self.playBm7b5 prepareToPlay];
    
    if ([self.selectChord1.text isEqualToString:@"C"]) {
        [self.Chord1 = self.playCmajor play];}
}


@end
