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




//textfield to select AND display chords
@property (strong, nonatomic) IBOutlet UITextField *selectChord1;
@property (strong, nonatomic) IBOutlet UITextField *selectChord2;
@property (strong, nonatomic) IBOutlet UITextField *selectChord3;
@property (strong, nonatomic) IBOutlet UITextField *selectChord4;


//randomize buttons to come up with interesting chords
- (IBAction)randomAllPressed:(UIButton *)sender;
- (IBAction)randomChord1:(UIButton *)sender;
- (IBAction)randomChord2:(UIButton *)sender;
- (IBAction)randomChord3:(UIButton *)sender;
- (IBAction)randomChord4:(UIButton *)sender;

//clear all to erase all currently selected chords
//clear indivudal textfield when user desires the chords from other textfields
- (IBAction)clearAll:(UIButton *)sender;
- (IBAction)clearChord1:(UIButton *)sender;
- (IBAction)clearChord2:(UIButton *)sender;
- (IBAction)clearChord3:(UIButton *)sender;
- (IBAction)clearChord4:(UIButton *)sender;

//key signature related UI and properties
@property (strong, nonatomic) NSArray *keySignatureToPass;
@property (strong, nonatomic) NSArray *keySignature;
@property (strong, nonatomic) IBOutlet UILabel *keyLabel;
@property (strong, nonatomic) NSString *keyToPass;

- (IBAction)pickKey:(UIButton *)sender;

@property (strong, nonatomic) NSString *currentTextField;

//tempo related UI and properties
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

//separate AVAudioPlayer required for each textfield
@property (strong, nonatomic) AVAudioPlayer *playChord1;
@property (strong, nonatomic) AVAudioPlayer *playChord2;
@property (strong, nonatomic) AVAudioPlayer *playChord3;
@property (strong, nonatomic) AVAudioPlayer *playChord4;


@end

