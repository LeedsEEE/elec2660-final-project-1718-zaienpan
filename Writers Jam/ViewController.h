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
@property (strong, nonatomic) NSArray *Cmajor;
@property (strong, nonatomic) NSString *setKey;


//chord selection properties
@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *chordFields;
@property (strong, nonatomic) IBOutlet UITextField *selectChord1;
@property (strong, nonatomic) IBOutlet UITextField *selectChord2;
@property (strong, nonatomic) IBOutlet UITextField *selectChord3;
@property (strong, nonatomic) IBOutlet UITextField *selectChord4;
- (IBAction)randomPressed:(UIButton *)sender;

//tempo related objects and properties
@property float BPM;
@property NSInteger chordLoop;
@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) IBOutlet UILabel *tempoLabel;
@property (weak, nonatomic) IBOutlet UISlider *tempoSlider;
- (IBAction)tempoSliderDidMove:(UISlider *)sender;
- (IBAction)tempoPlus:(UIButton *)sender;
- (IBAction)tempoMinus:(UIButton *)sender;



- (IBAction)didPressPlay:(UIButton *)sender;

@property (strong, nonatomic) AVAudioPlayer *trackOne;




@end

