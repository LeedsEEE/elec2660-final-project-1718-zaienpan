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

@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>


@property (strong, nonatomic) IBOutlet UIPickerView *chordPicker;
@property (strong, nonatomic) NSArray *CmajorKey;
@property (strong, nonatomic) NSString *setKey;


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



- (IBAction)didPressPlay:(UIButton *)sender;
- (IBAction)didPressStop:(UIButton *)sender;

@property (strong, nonatomic) AVAudioPlayer *playCmajor;
@property (strong, nonatomic) AVAudioPlayer *playDminor;
@property (strong, nonatomic) AVAudioPlayer *playEminor;
@property (strong, nonatomic) AVAudioPlayer *playFmajor;
@property (strong, nonatomic) AVAudioPlayer *playGmajor;
@property (strong, nonatomic) AVAudioPlayer *playAminor;
@property (strong, nonatomic) AVAudioPlayer *playBm7b5;




@end

