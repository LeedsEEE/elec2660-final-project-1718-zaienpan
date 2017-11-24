//
//  ViewController.h
//  Writers Jam
//
//  Created by ZaiEn on 15/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChordLibrary.h"
#import <AVFoundation/AVFoundation.h>
#import "KeyController.h"

@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>


@property (strong, nonatomic) IBOutlet UIPickerView *chordPicker;




//chord selection properties

@property (strong, nonatomic) IBOutlet UITextField *selectChord1;
@property (strong, nonatomic) IBOutlet UITextField *selectChord2;
@property (strong, nonatomic) IBOutlet UITextField *selectChord3;
@property (strong, nonatomic) IBOutlet UITextField *selectChord4;
- (IBAction)randomAllPressed:(UIButton *)sender;
- (IBAction)randomChord1:(UIButton *)sender;
- (IBAction)randomChord2:(UIButton *)sender;
- (IBAction)randomChord3:(UIButton *)sender;
- (IBAction)randomChord4:(UIButton *)sender;

- (IBAction)clearAll:(UIButton *)sender;
- (IBAction)clearChord1:(UIButton *)sender;
- (IBAction)clearChord2:(UIButton *)sender;
- (IBAction)clearChord3:(UIButton *)sender;
- (IBAction)clearChord4:(UIButton *)sender;

//key related objects
@property (strong, nonatomic) NSArray *keySignatureToPass;
@property (strong, nonatomic) NSArray *keySignature;
@property (strong, nonatomic) IBOutlet UILabel *keyLabel;
@property (strong, nonatomic) NSString *keyToPass;

- (IBAction)pickKey:(UIButton *)sender;




//tempo related objects and properties
@property BOOL playing;
@property float BPM;
@property NSInteger chordLoop;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) IBOutlet UILabel *tempoLabel;
@property (weak, nonatomic) IBOutlet UISlider *tempoSlider;
- (IBAction)tempoSliderDidMove:(UISlider *)sender;
- (IBAction)tempoPlus:(UIButton *)sender;
- (IBAction)tempoMinus:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UIButton *didPressPlay;
- (IBAction)didPressPlay:(UIButton *)sender;
- (IBAction)didPressStop:(UIButton *)sender;

//audio engine
@property (strong, nonatomic) AVAudioPlayer *playCmajor;
@property (strong, nonatomic) AVAudioPlayer *playCminor;
@property (strong, nonatomic) AVAudioPlayer *playCm7b5;
@property (strong, nonatomic) AVAudioPlayer *playDbmajor;
@property (strong, nonatomic) AVAudioPlayer *playDbminor;
@property (strong, nonatomic) AVAudioPlayer *playDbm7b5;
@property (strong, nonatomic) AVAudioPlayer *playDmajor;
@property (strong, nonatomic) AVAudioPlayer *playDminor;
@property (strong, nonatomic) AVAudioPlayer *playDm7b5;
@property (strong, nonatomic) AVAudioPlayer *playEbmajor;
@property (strong, nonatomic) AVAudioPlayer *playEbminor;
@property (strong, nonatomic) AVAudioPlayer *playEbm7b5;
@property (strong, nonatomic) AVAudioPlayer *playEmajor;
@property (strong, nonatomic) AVAudioPlayer *playEminor;
@property (strong, nonatomic) AVAudioPlayer *playEm7b5;
@property (strong, nonatomic) AVAudioPlayer *playFmajor;
@property (strong, nonatomic) AVAudioPlayer *playFminor;
@property (strong, nonatomic) AVAudioPlayer *playFm7b5;
@property (strong, nonatomic) AVAudioPlayer *playGbmajor;
@property (strong, nonatomic) AVAudioPlayer *playGbminor;
@property (strong, nonatomic) AVAudioPlayer *playGbm7b5;
@property (strong, nonatomic) AVAudioPlayer *playGmajor;
@property (strong, nonatomic) AVAudioPlayer *playGminor;
@property (strong, nonatomic) AVAudioPlayer *playGm7b5;
@property (strong, nonatomic) AVAudioPlayer *playAbmajor;
@property (strong, nonatomic) AVAudioPlayer *playAbminor;
@property (strong, nonatomic) AVAudioPlayer *playAbm7b5;
@property (strong, nonatomic) AVAudioPlayer *playAmajor;
@property (strong, nonatomic) AVAudioPlayer *playAminor;
@property (strong, nonatomic) AVAudioPlayer *playAm7b5;
@property (strong, nonatomic) AVAudioPlayer *playBbmajor;
@property (strong, nonatomic) AVAudioPlayer *playBbminor;
@property (strong, nonatomic) AVAudioPlayer *playBbm7b5;
@property (strong, nonatomic) AVAudioPlayer *playBmajor;
@property (strong, nonatomic) AVAudioPlayer *playBminor;
@property (strong, nonatomic) AVAudioPlayer *playBm7b5;




@end

