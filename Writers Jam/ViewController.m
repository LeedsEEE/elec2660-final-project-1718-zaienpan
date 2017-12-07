//
//  ViewController.m
//  Writers Jam
//
//  Created by ZaiEn on 15/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupAudioPlayer];
    [self tempoSliderDidMove:self.tempoSlider];
    self.playing = NO;
    [self.timer invalidate];
    self.chordLoop = 0;
    self.keyLabel.text = self.keyToPass;         //data from keycontroller
    self.keySignature = self.keySignatureToPass; //data from keycontroller
    
    //using UIPickerView as input for each textfield, code from stackoverflow
    UIPickerView *chordPicker = [[UIPickerView alloc] init];
    chordPicker.delegate = self;
    chordPicker.tag = 1;
    
    UIPickerView *chordPicker2 = [[UIPickerView alloc] init];
    chordPicker2.delegate = self;
    chordPicker2.tag = 2;
    
    UIPickerView *chordPicker3 = [[UIPickerView alloc] init];
    chordPicker3.delegate = self;
    chordPicker3.tag = 3;
    
    UIPickerView *chordPicker4 = [[UIPickerView alloc] init];
    chordPicker4.delegate = self;
    chordPicker4.tag = 4;
    
    
    self.selectChord1.inputView = chordPicker;
    self.selectChord2.inputView = chordPicker2;
    self.selectChord3.inputView = chordPicker3;
    self.selectChord4.inputView = chordPicker4;
    

    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark pickerView setup
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    
    return [self.keySignature count];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component{

        return [self.keySignature objectAtIndex:row];
    
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component{
    
    //update each textfield with selected pickerview input
    if (pickerView.tag == 1){
        self.selectChord1.text = self.keySignature[row];
    } else if (pickerView.tag == 2){
        self.selectChord2.text = self.keySignature[row];
    } else if (pickerView.tag == 3){
        self.selectChord3.text = self.keySignature[row];
    } else if (pickerView.tag == 4){
        self.selectChord4.text = self.keySignature[row];
    }
    
    
}

//touch anywhere to dismiss keyboard/pickerview, code from stackoverflow
- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event {
    [self.view endEditing:YES];}

#pragma mark tempo related UI
- (IBAction)tempoSliderDidMove:(UISlider *)sender {
    self.BPM = self.tempoSlider.value;
    NSLog(@"BPM = %d", (int)self.BPM);
    self.tempoLabel.text = [NSString stringWithFormat:@"%d", (int)self.BPM];
    
    if (self.playing == YES){
        [self.timer invalidate];
        [self didPressPlay:nil];
    }
}

- (IBAction)tempoPlus:(UIButton *)sender {
    self.BPM += 1;
    NSLog(@"BPM = %d", (int)self.BPM);
        self.tempoLabel.text = [NSString stringWithFormat:@"%d", (int)self.BPM];
}

- (IBAction)tempoMinus:(UIButton *)sender {
    self.BPM -= 1;
    NSLog(@"BPM = %d", (int)self.BPM);
        self.tempoLabel.text = [NSString stringWithFormat:@"%d", (int)self.BPM];
}


- (IBAction)randomAllPressed:(UIButton *)sender {
    }

#pragma mark Randomize/Clear buttons UI
// obtain randomized picker output, code from stackoverflow
- (IBAction)randomChord1:(UIButton *)sender {
    NSUInteger random = arc4random_uniform((uint32_t) self.keySignature.count);
    [_chordPicker selectRow:random inComponent:0 animated:YES];
        self.selectChord1.text = self.keySignature[random];
}

- (IBAction)randomChord2:(UIButton *)sender {
    NSUInteger random = arc4random_uniform((uint32_t) self.keySignature.count);
    [_chordPicker selectRow:random inComponent:0 animated:YES];
    self.selectChord2.text = self.keySignature[random];
}

- (IBAction)randomChord3:(UIButton *)sender {
    NSUInteger random = arc4random_uniform((uint32_t) self.keySignature.count);
    [_chordPicker selectRow:random inComponent:0 animated:YES];
    self.selectChord3.text = self.keySignature[random];
}

- (IBAction)randomChord4:(UIButton *)sender {
    NSUInteger random = arc4random_uniform((uint32_t) self.keySignature.count);
    [_chordPicker selectRow:random inComponent:0 animated:YES];
    self.selectChord4.text = self.keySignature[random];
}

- (IBAction)clearAll:(UIButton *)sender {
    self.selectChord1.backgroundColor = [UIColor whiteColor];
    self.selectChord2.backgroundColor = [UIColor whiteColor];
    self.selectChord3.backgroundColor = [UIColor whiteColor];
    self.selectChord4.backgroundColor = [UIColor whiteColor];
}
    
- (IBAction)clearChord1:(UIButton *)sender {
    self.selectChord1.text = nil;
}
- (IBAction)clearChord2:(UIButton *)sender {
    self.selectChord2.text = nil;
}
- (IBAction)clearChord3:(UIButton *)sender {
    self.selectChord3.text = nil;
}
- (IBAction)clearChord4:(UIButton *)sender {
    self.selectChord4.text = nil;
}

- (IBAction)pickKey:(UIButton *)sender {
    self.playing = NO;
    [self.timer invalidate];
    self.chordLoop = 0; //resets playback when selecting key
}

- (IBAction)didPressPlay:(UIButton *)sender {
    NSLog(@"Pressed Play");
    self.playing = YES;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:60.0/self.BPM target:self selector:@selector(timerFire:) userInfo:nil repeats:YES];
    ((UIButton *)sender).enabled = NO; //disables second pressing
    
}

- (IBAction)didPressStop:(UIButton *)sender {
    NSLog(@"STOPPED");
    self.playing = NO;
    [self.timer invalidate];
    self.chordLoop = 0;
    self.didPressPlay.enabled = YES; //reenables play button after stopping

}


- (void) timerFire:(NSTimer *)timer {
    NSLog(@"Timer Fired! chord %ld", (long)self.chordLoop);
    
    //tag each textfield
    self.selectChord1.tag = 0;
    self.selectChord2.tag = 1;
    self.selectChord3.tag = 2;
    self.selectChord4.tag = 3;
    
    //flash the textfield if it is active
    if (self.selectChord1.tag == self.chordLoop){
        self.selectChord1.backgroundColor = [UIColor yellowColor];
    } else {
        self.selectChord1.backgroundColor = [UIColor whiteColor];
    }

    if (self.selectChord2.tag == self.chordLoop){
        self.selectChord2.backgroundColor = [UIColor yellowColor];
    } else { self.selectChord2.backgroundColor = [UIColor whiteColor];
    }
    
    if (self.selectChord3.tag == self.chordLoop){
        self.selectChord3.backgroundColor = [UIColor yellowColor];
    } else { self.selectChord3.backgroundColor = [UIColor whiteColor];
    }
    
    if (self.selectChord4.tag == self.chordLoop){
        self.selectChord4.backgroundColor = [UIColor yellowColor];
    } else { self.selectChord4.backgroundColor = [UIColor whiteColor];
    }
    
    //things related to playback
    if (self.selectChord1.tag == self.chordLoop){
        if ([self.selectChord1.text isEqualToString:@"C"]) {
            [self.playCmajor play];}
        else if ([self.selectChord1.text isEqualToString:@"Cm"]) {
            [self.playCminor play];}
        else if ([self.selectChord1.text isEqualToString:@"Cm7b5"]) {
            [self.playCm7b5 play];}
        else if ([self.selectChord1.text isEqualToString:@"Db"]) {
            [self.playDbmajor play];}
        else if ([self.selectChord1.text isEqualToString:@"Dbm"]) {
            [self.playDbminor play];}
        else if ([self.selectChord1.text isEqualToString:@"Dbm7b5"]) {
            [self.playDbm7b5 play];}
        else if ([self.selectChord1.text isEqualToString:@"C#"]) {
            [self.playDbmajor play];}
        else if ([self.selectChord1.text isEqualToString:@"C#m"]) {
            [self.playDbminor play];}
        else if ([self.selectChord1.text isEqualToString:@"C#m7b5"]) {
            [self.playDbm7b5 play];}
        else if ([self.selectChord1.text isEqualToString:@"D"]) {
            [self.playDmajor play];}
        else if ([self.selectChord1.text isEqualToString:@"Dm"]) {
            [self.playDminor play];}
        else if ([self.selectChord1.text isEqualToString:@"Dm7b5"]) {
            [self.playDm7b5 play];}
        else if ([self.selectChord1.text isEqualToString:@"D#"]) {
            [self.playEbmajor play];}
        else if ([self.selectChord1.text isEqualToString:@"D#m"]) {
            [self.playEbminor play];}
        else if ([self.selectChord1.text isEqualToString:@"D#m7b5"]) {
            [self.playEbm7b5 play];}
        else if ([self.selectChord1.text isEqualToString:@"Eb"]) {
            [self.playEbmajor play];}
        else if ([self.selectChord1.text isEqualToString:@"Ebm"]) {
            [self.playEbminor play];}
        else if ([self.selectChord1.text isEqualToString:@"Ebm7b5"]) {
            [self.playEbm7b5 play];}
        else if ([self.selectChord1.text isEqualToString:@"E"]) {
            [self.playEmajor play];}
        else if ([self.selectChord1.text isEqualToString:@"Em"]) {
            [self.playEminor play];}
        else if ([self.selectChord1.text isEqualToString:@"Em7b5"]) {
            [self.playEm7b5 play];}
        else if ([self.selectChord1.text isEqualToString:@"F"]) {
            [self.playFmajor play];}
        else if ([self.selectChord1.text isEqualToString:@"Fm"]) {
            [self.playFminor play];}
        else if ([self.selectChord1.text isEqualToString:@"Fm7b5"]) {
            [self.playFm7b5 play];}
        else if ([self.selectChord1.text isEqualToString:@"Gb"]) {
            [self.playGbmajor play];}
        else if ([self.selectChord1.text isEqualToString:@"Gbm"]) {
            [self.playGbminor play];}
        else if ([self.selectChord1.text isEqualToString:@"Gbm7b5"]) {
            [self.playGbm7b5 play];}
        else if ([self.selectChord1.text isEqualToString:@"F#"]) {
            [self.playGbmajor play];}
        else if ([self.selectChord1.text isEqualToString:@"F#m"]) {
            [self.playGbminor play];}
        else if ([self.selectChord1.text isEqualToString:@"F#m7b5"]) {
            [self.playGbm7b5 play];}
        else if ([self.selectChord1.text isEqualToString:@"G"]) {
            [self.playGmajor play];}
        else if ([self.selectChord1.text isEqualToString:@"Gm"]) {
            [self.playGminor play];}
        else if ([self.selectChord1.text isEqualToString:@"Gm7b5"]) {
            [self.playGm7b5 play];}
        else if ([self.selectChord1.text isEqualToString:@"G#"]) {
            [self.playAbmajor play];}
        else if ([self.selectChord1.text isEqualToString:@"G#m"]) {
            [self.playAbminor play];}
        else if ([self.selectChord1.text isEqualToString:@"G#m7b5"]) {
            [self.playAbm7b5 play];}
        else if ([self.selectChord1.text isEqualToString:@"Ab"]) {
            [self.playAbmajor play];}
        else if ([self.selectChord1.text isEqualToString:@"Abm"]) {
            [self.playAbminor play];}
        else if ([self.selectChord1.text isEqualToString:@"Abm7b5"]) {
            [self.playAbm7b5 play];}
        else if ([self.selectChord1.text isEqualToString:@"A"]) {
            [self.playAmajor play];}
        else if ([self.selectChord1.text isEqualToString:@"Am"]) {
            [self.playAminor play];}
        else if ([self.selectChord1.text isEqualToString:@"Am7b5"]) {
            [self.playAm7b5 play];}
        else if ([self.selectChord1.text isEqualToString:@"A#"]) {
            [self.playBbmajor play];}
        else if ([self.selectChord1.text isEqualToString:@"A#m"]) {
            [self.playBbminor play];}
        else if ([self.selectChord1.text isEqualToString:@"A#m7b5"]) {
            [self.playBbm7b5 play];}
        else if ([self.selectChord1.text isEqualToString:@"Bb"]) {
            [self.playBbmajor play];}
        else if ([self.selectChord1.text isEqualToString:@"Bbm"]) {
            [self.playBbminor play];}
        else if ([self.selectChord1.text isEqualToString:@"Bbm7b5"]) {
            [self.playBbm7b5 play];}
        else if ([self.selectChord1.text isEqualToString:@"B"]) {
            [self.playBmajor play];}
        else if ([self.selectChord1.text isEqualToString:@"Bm"]) {
            [self.playBminor play];}
        else if ([self.selectChord1.text isEqualToString:@"Bm7b5"]) {
            [self.playBm7b5 play];}

    }
    if (self.selectChord2.tag == self.chordLoop){
        if ([self.selectChord2.text isEqualToString:@"C"]) {
            [self.playCmajor play];}
        else if ([self.selectChord2.text isEqualToString:@"Cm"]) {
            [self.playCminor play];}
        else if ([self.selectChord2.text isEqualToString:@"Cm7b5"]) {
            [self.playCm7b5 play];}
        else if ([self.selectChord2.text isEqualToString:@"Db"]) {
            [self.playDbmajor play];}
        else if ([self.selectChord2.text isEqualToString:@"Dbm"]) {
            [self.playDbminor play];}
        else if ([self.selectChord2.text isEqualToString:@"Dbm7b5"]) {
            [self.playDbm7b5 play];}
        else if ([self.selectChord2.text isEqualToString:@"C#"]) {
            [self.playDbmajor play];}
        else if ([self.selectChord2.text isEqualToString:@"C#m"]) {
            [self.playDbminor play];}
        else if ([self.selectChord2.text isEqualToString:@"C#m7b5"]) {
            [self.playDbm7b5 play];}
        else if ([self.selectChord2.text isEqualToString:@"D"]) {
            [self.playDmajor play];}
        else if ([self.selectChord2.text isEqualToString:@"Dm"]) {
            [self.playDminor play];}
        else if ([self.selectChord2.text isEqualToString:@"Dm7b5"]) {
            [self.playDm7b5 play];}
        else if ([self.selectChord2.text isEqualToString:@"D#"]) {
            [self.playEbmajor play];}
        else if ([self.selectChord2.text isEqualToString:@"D#m"]) {
            [self.playEbminor play];}
        else if ([self.selectChord2.text isEqualToString:@"D#m7b5"]) {
            [self.playEbm7b5 play];}
        else if ([self.selectChord2.text isEqualToString:@"Eb"]) {
            [self.playEbmajor play];}
        else if ([self.selectChord2.text isEqualToString:@"Ebm"]) {
            [self.playEbminor play];}
        else if ([self.selectChord2.text isEqualToString:@"Ebm7b5"]) {
            [self.playEbm7b5 play];}
        else if ([self.selectChord2.text isEqualToString:@"E"]) {
            [self.playEmajor play];}
        else if ([self.selectChord2.text isEqualToString:@"Em"]) {
            [self.playEminor play];}
        else if ([self.selectChord2.text isEqualToString:@"Em7b5"]) {
            [self.playEm7b5 play];}
        else if ([self.selectChord2.text isEqualToString:@"F"]) {
            [self.playFmajor play];}
        else if ([self.selectChord2.text isEqualToString:@"Fm"]) {
            [self.playFminor play];}
        else if ([self.selectChord2.text isEqualToString:@"Fm7b5"]) {
            [self.playFm7b5 play];}
        else if ([self.selectChord2.text isEqualToString:@"Gb"]) {
            [self.playGbmajor play];}
        else if ([self.selectChord2.text isEqualToString:@"Gbm"]) {
            [self.playGbminor play];}
        else if ([self.selectChord2.text isEqualToString:@"Gbm7b5"]) {
            [self.playGbm7b5 play];}
        else if ([self.selectChord2.text isEqualToString:@"F#"]) {
            [self.playGbmajor play];}
        else if ([self.selectChord2.text isEqualToString:@"F#m"]) {
            [self.playGbminor play];}
        else if ([self.selectChord2.text isEqualToString:@"F#m7b5"]) {
            [self.playGbm7b5 play];}
        else if ([self.selectChord2.text isEqualToString:@"G"]) {
            [self.playGmajor play];}
        else if ([self.selectChord2.text isEqualToString:@"Gm"]) {
            [self.playGminor play];}
        else if ([self.selectChord2.text isEqualToString:@"Gm7b5"]) {
            [self.playGm7b5 play];}
        else if ([self.selectChord2.text isEqualToString:@"G#"]) {
            [self.playAbmajor play];}
        else if ([self.selectChord2.text isEqualToString:@"G#m"]) {
            [self.playAbminor play];}
        else if ([self.selectChord2.text isEqualToString:@"G#m7b5"]) {
            [self.playAbm7b5 play];}
        else if ([self.selectChord2.text isEqualToString:@"Ab"]) {
            [self.playAbmajor play];}
        else if ([self.selectChord2.text isEqualToString:@"Abm"]) {
            [self.playAbminor play];}
        else if ([self.selectChord2.text isEqualToString:@"Abm7b5"]) {
            [self.playAbm7b5 play];}
        else if ([self.selectChord2.text isEqualToString:@"A"]) {
            [self.playAmajor play];}
        else if ([self.selectChord2.text isEqualToString:@"Am"]) {
            [self.playAminor play];}
        else if ([self.selectChord2.text isEqualToString:@"Am7b5"]) {
            [self.playAm7b5 play];}
        else if ([self.selectChord2.text isEqualToString:@"A#"]) {
            [self.playBbmajor play];}
        else if ([self.selectChord2.text isEqualToString:@"A#m"]) {
            [self.playBbminor play];}
        else if ([self.selectChord2.text isEqualToString:@"A#m7b5"]) {
            [self.playBbm7b5 play];}
        else if ([self.selectChord2.text isEqualToString:@"Bb"]) {
            [self.playBbmajor play];}
        else if ([self.selectChord2.text isEqualToString:@"Bbm"]) {
            [self.playBbminor play];}
        else if ([self.selectChord2.text isEqualToString:@"Bbm7b5"]) {
            [self.playBbm7b5 play];}
        else if ([self.selectChord2.text isEqualToString:@"B"]) {
            [self.playBmajor play];}
        else if ([self.selectChord2.text isEqualToString:@"Bm"]) {
            [self.playBminor play];}
        else if ([self.selectChord2.text isEqualToString:@"Bm7b5"]) {
            [self.playBm7b5 play];}
    }
    if (self.selectChord3.tag == self.chordLoop){
        if ([self.selectChord3.text isEqualToString:@"C"]) {
            [self.playCmajor play];}
        else if ([self.selectChord3.text isEqualToString:@"Cm"]) {
            [self.playCminor play];}
        else if ([self.selectChord3.text isEqualToString:@"Cm7b5"]) {
            [self.playCm7b5 play];}
        else if ([self.selectChord3.text isEqualToString:@"Db"]) {
            [self.playDbmajor play];}
        else if ([self.selectChord3.text isEqualToString:@"Dbm"]) {
            [self.playDbminor play];}
        else if ([self.selectChord3.text isEqualToString:@"Dbm7b5"]) {
            [self.playDbm7b5 play];}
        else if ([self.selectChord3.text isEqualToString:@"C#"]) {
            [self.playDbmajor play];}
        else if ([self.selectChord3.text isEqualToString:@"C#m"]) {
            [self.playDbminor play];}
        else if ([self.selectChord3.text isEqualToString:@"C#m7b5"]) {
            [self.playDbm7b5 play];}
        else if ([self.selectChord3.text isEqualToString:@"D"]) {
            [self.playDmajor play];}
        else if ([self.selectChord3.text isEqualToString:@"Dm"]) {
            [self.playDminor play];}
        else if ([self.selectChord3.text isEqualToString:@"Dm7b5"]) {
            [self.playDm7b5 play];}
        else if ([self.selectChord3.text isEqualToString:@"D#"]) {
            [self.playEbmajor play];}
        else if ([self.selectChord3.text isEqualToString:@"D#m"]) {
            [self.playEbminor play];}
        else if ([self.selectChord3.text isEqualToString:@"D#m7b5"]) {
            [self.playEbm7b5 play];}
        else if ([self.selectChord3.text isEqualToString:@"Eb"]) {
            [self.playEbmajor play];}
        else if ([self.selectChord3.text isEqualToString:@"Ebm"]) {
            [self.playEbminor play];}
        else if ([self.selectChord3.text isEqualToString:@"Ebm7b5"]) {
            [self.playEbm7b5 play];}
        else if ([self.selectChord3.text isEqualToString:@"E"]) {
            [self.playEmajor play];}
        else if ([self.selectChord3.text isEqualToString:@"Em"]) {
            [self.playEminor play];}
        else if ([self.selectChord3.text isEqualToString:@"Em7b5"]) {
            [self.playEm7b5 play];}
        else if ([self.selectChord3.text isEqualToString:@"F"]) {
            [self.playFmajor play];}
        else if ([self.selectChord3.text isEqualToString:@"Fm"]) {
            [self.playFminor play];}
        else if ([self.selectChord3.text isEqualToString:@"Fm7b5"]) {
            [self.playFm7b5 play];}
        else if ([self.selectChord3.text isEqualToString:@"Gb"]) {
            [self.playGbmajor play];}
        else if ([self.selectChord3.text isEqualToString:@"Gbm"]) {
            [self.playGbminor play];}
        else if ([self.selectChord3.text isEqualToString:@"Gbm7b5"]) {
            [self.playGbm7b5 play];}
        else if ([self.selectChord3.text isEqualToString:@"F#"]) {
            [self.playGbmajor play];}
        else if ([self.selectChord3.text isEqualToString:@"F#m"]) {
            [self.playGbminor play];}
        else if ([self.selectChord3.text isEqualToString:@"F#m7b5"]) {
            [self.playGbm7b5 play];}
        else if ([self.selectChord3.text isEqualToString:@"G"]) {
            [self.playGmajor play];}
        else if ([self.selectChord3.text isEqualToString:@"Gm"]) {
            [self.playGminor play];}
        else if ([self.selectChord3.text isEqualToString:@"Gm7b5"]) {
            [self.playGm7b5 play];}
        else if ([self.selectChord3.text isEqualToString:@"G#"]) {
            [self.playAbmajor play];}
        else if ([self.selectChord3.text isEqualToString:@"G#m"]) {
            [self.playAbminor play];}
        else if ([self.selectChord3.text isEqualToString:@"G#m7b5"]) {
            [self.playAbm7b5 play];}
        else if ([self.selectChord3.text isEqualToString:@"Ab"]) {
            [self.playAbmajor play];}
        else if ([self.selectChord3.text isEqualToString:@"Abm"]) {
            [self.playAbminor play];}
        else if ([self.selectChord3.text isEqualToString:@"Abm7b5"]) {
            [self.playAbm7b5 play];}
        else if ([self.selectChord3.text isEqualToString:@"A"]) {
            [self.playAmajor play];}
        else if ([self.selectChord3.text isEqualToString:@"Am"]) {
            [self.playAminor play];}
        else if ([self.selectChord3.text isEqualToString:@"Am7b5"]) {
            [self.playAm7b5 play];}
        else if ([self.selectChord3.text isEqualToString:@"A#"]) {
            [self.playBbmajor play];}
        else if ([self.selectChord3.text isEqualToString:@"A#m"]) {
            [self.playBbminor play];}
        else if ([self.selectChord3.text isEqualToString:@"A#m7b5"]) {
            [self.playBbm7b5 play];}
        else if ([self.selectChord3.text isEqualToString:@"Bb"]) {
            [self.playBbmajor play];}
        else if ([self.selectChord3.text isEqualToString:@"Bbm"]) {
            [self.playBbminor play];}
        else if ([self.selectChord3.text isEqualToString:@"Bbm7b5"]) {
            [self.playBbm7b5 play];}
        else if ([self.selectChord3.text isEqualToString:@"B"]) {
            [self.playBmajor play];}
        else if ([self.selectChord3.text isEqualToString:@"Bm"]) {
            [self.playBminor play];}
        else if ([self.selectChord3.text isEqualToString:@"Bm7b5"]) {
            [self.playBm7b5 play];}
    }
    if (self.selectChord4.tag == self.chordLoop){
        if ([self.selectChord4.text isEqualToString:@"C"]) {
            [self.playCmajor play];}
        else if ([self.selectChord4.text isEqualToString:@"Cm"]) {
            [self.playCminor play];}
        else if ([self.selectChord4.text isEqualToString:@"Cm7b5"]) {
            [self.playCm7b5 play];}
        else if ([self.selectChord4.text isEqualToString:@"Db"]) {
            [self.playDbmajor play];}
        else if ([self.selectChord4.text isEqualToString:@"Dbm"]) {
            [self.playDbminor play];}
        else if ([self.selectChord4.text isEqualToString:@"Dbm7b5"]) {
            [self.playDbm7b5 play];}
        else if ([self.selectChord4.text isEqualToString:@"C#"]) {
            [self.playDbmajor play];}
        else if ([self.selectChord4.text isEqualToString:@"C#m"]) {
            [self.playDbminor play];}
        else if ([self.selectChord4.text isEqualToString:@"C#m7b5"]) {
            [self.playDbm7b5 play];}
        else if ([self.selectChord4.text isEqualToString:@"D"]) {
            [self.playDmajor play];}
        else if ([self.selectChord4.text isEqualToString:@"Dm"]) {
            [self.playDminor play];}
        else if ([self.selectChord4.text isEqualToString:@"Dm7b5"]) {
            [self.playDm7b5 play];}
        else if ([self.selectChord4.text isEqualToString:@"D#"]) {
            [self.playEbmajor play];}
        else if ([self.selectChord4.text isEqualToString:@"D#m"]) {
            [self.playEbminor play];}
        else if ([self.selectChord4.text isEqualToString:@"D#m7b5"]) {
            [self.playEbm7b5 play];}
        else if ([self.selectChord4.text isEqualToString:@"Eb"]) {
            [self.playEbmajor play];}
        else if ([self.selectChord4.text isEqualToString:@"Ebm"]) {
            [self.playEbminor play];}
        else if ([self.selectChord4.text isEqualToString:@"Ebm7b5"]) {
            [self.playEbm7b5 play];}
        else if ([self.selectChord4.text isEqualToString:@"E"]) {
            [self.playEmajor play];}
        else if ([self.selectChord4.text isEqualToString:@"Em"]) {
            [self.playEminor play];}
        else if ([self.selectChord4.text isEqualToString:@"Em7b5"]) {
            [self.playEm7b5 play];}
        else if ([self.selectChord4.text isEqualToString:@"F"]) {
            [self.playFmajor play];}
        else if ([self.selectChord4.text isEqualToString:@"Fm"]) {
            [self.playFminor play];}
        else if ([self.selectChord4.text isEqualToString:@"Fm7b5"]) {
            [self.playFm7b5 play];}
        else if ([self.selectChord4.text isEqualToString:@"Gb"]) {
            [self.playGbmajor play];}
        else if ([self.selectChord4.text isEqualToString:@"Gbm"]) {
            [self.playGbminor play];}
        else if ([self.selectChord4.text isEqualToString:@"Gbm7b5"]) {
            [self.playGbm7b5 play];}
        else if ([self.selectChord4.text isEqualToString:@"F#"]) {
            [self.playGbmajor play];}
        else if ([self.selectChord4.text isEqualToString:@"F#m"]) {
            [self.playGbminor play];}
        else if ([self.selectChord4.text isEqualToString:@"F#m7b5"]) {
            [self.playGbm7b5 play];}
        else if ([self.selectChord4.text isEqualToString:@"G"]) {
            [self.playGmajor play];}
        else if ([self.selectChord4.text isEqualToString:@"Gm"]) {
            [self.playGminor play];}
        else if ([self.selectChord4.text isEqualToString:@"Gm7b5"]) {
            [self.playGm7b5 play];}
        else if ([self.selectChord4.text isEqualToString:@"G#"]) {
            [self.playAbmajor play];}
        else if ([self.selectChord4.text isEqualToString:@"G#m"]) {
            [self.playAbminor play];}
        else if ([self.selectChord4.text isEqualToString:@"G#m7b5"]) {
            [self.playAbm7b5 play];}
        else if ([self.selectChord4.text isEqualToString:@"Ab"]) {
            [self.playAbmajor play];}
        else if ([self.selectChord4.text isEqualToString:@"Abm"]) {
            [self.playAbminor play];}
        else if ([self.selectChord4.text isEqualToString:@"Abm7b5"]) {
            [self.playAbm7b5 play];}
        else if ([self.selectChord4.text isEqualToString:@"A"]) {
            [self.playAmajor play];}
        else if ([self.selectChord4.text isEqualToString:@"Am"]) {
            [self.playAminor play];}
        else if ([self.selectChord4.text isEqualToString:@"Am7b5"]) {
            [self.playAm7b5 play];}
        else if ([self.selectChord4.text isEqualToString:@"A#"]) {
            [self.playBbmajor play];}
        else if ([self.selectChord4.text isEqualToString:@"A#m"]) {
            [self.playBbminor play];}
        else if ([self.selectChord4.text isEqualToString:@"A#m7b5"]) {
            [self.playBbm7b5 play];}
        else if ([self.selectChord4.text isEqualToString:@"Bb"]) {
            [self.playBbmajor play];}
        else if ([self.selectChord4.text isEqualToString:@"Bbm"]) {
            [self.playBbminor play];}
        else if ([self.selectChord4.text isEqualToString:@"Bbm7b5"]) {
            [self.playBbm7b5 play];}
        else if ([self.selectChord4.text isEqualToString:@"B"]) {
            [self.playBmajor play];}
        else if ([self.selectChord4.text isEqualToString:@"Bm"]) {
            [self.playBminor play];}
        else if ([self.selectChord4.text isEqualToString:@"Bm7b5"]) {
            [self.playBm7b5 play];}
    }
    self.chordLoop++;
    if (self.chordLoop > 3)
        self.chordLoop = 0;
    
    

}
                  

- (void) setupAudioPlayer {
    
    NSString *Cmajor = [[NSBundle mainBundle] pathForResource:@"Cmajor" ofType:@"wav"];
    NSURL *CmajorURL = [[NSURL alloc] initFileURLWithPath:Cmajor];
    self.playCmajor = [[AVAudioPlayer alloc] initWithContentsOfURL:CmajorURL error:nil];
    [self.playCmajor prepareToPlay];
    
    NSString *Cminor = [[NSBundle mainBundle] pathForResource:@"Cminor" ofType:@"wav"];
    NSURL *CminorURL = [[NSURL alloc] initFileURLWithPath:Cminor];
    self.playCminor = [[AVAudioPlayer alloc] initWithContentsOfURL:CminorURL error:nil];
    [self.playCminor prepareToPlay];
    
    NSString *Cm7b5 = [[NSBundle mainBundle] pathForResource:@"Cm7b5" ofType:@"wav"];
    NSURL *Cm7b5URL = [[NSURL alloc] initFileURLWithPath:Cm7b5];
    self.playCm7b5 = [[AVAudioPlayer alloc] initWithContentsOfURL:Cm7b5URL error:nil];
    [self.playCm7b5 prepareToPlay];
    
    NSString *Dmajor = [[NSBundle mainBundle] pathForResource:@"Dmajor" ofType:@"wav"];
    NSURL *DmajorURL = [[NSURL alloc] initFileURLWithPath:Dmajor];
    self.playDmajor = [[AVAudioPlayer alloc] initWithContentsOfURL:DmajorURL error:nil];
    [self.playDmajor prepareToPlay];
    
    NSString *Dminor = [[NSBundle mainBundle] pathForResource:@"Dminor" ofType:@"wav"];
    NSURL *DminorURL = [[NSURL alloc] initFileURLWithPath:Dminor];
    self.playDminor = [[AVAudioPlayer alloc] initWithContentsOfURL:DminorURL error:nil];
    [self.playDminor prepareToPlay];
    
    NSString *Dm7b5 = [[NSBundle mainBundle] pathForResource:@"Dm7b5" ofType:@"wav"];
    NSURL *Dm7b5URL = [[NSURL alloc] initFileURLWithPath:Dm7b5];
    self.playDm7b5 = [[AVAudioPlayer alloc] initWithContentsOfURL:Dm7b5URL error:nil];
    [self.playDm7b5 prepareToPlay];
    
    NSString *Dbmajor = [[NSBundle mainBundle] pathForResource:@"Dbmajor" ofType:@"wav"];
    NSURL *DbmajorURL = [[NSURL alloc] initFileURLWithPath:Dbmajor];
    self.playDbmajor = [[AVAudioPlayer alloc] initWithContentsOfURL:DbmajorURL error:nil];
    [self.playDbmajor prepareToPlay];
    
    NSString *Dbminor = [[NSBundle mainBundle] pathForResource:@"Dbminor" ofType:@"wav"];
    NSURL *DbminorURL = [[NSURL alloc] initFileURLWithPath:Dbminor];
    self.playDbminor = [[AVAudioPlayer alloc] initWithContentsOfURL:DbminorURL error:nil];
    [self.playDbminor prepareToPlay];
    
    NSString *Dbm7b5 = [[NSBundle mainBundle] pathForResource:@"Dbm7b5" ofType:@"wav"];
    NSURL *Dbm7b5URL = [[NSURL alloc] initFileURLWithPath:Dbm7b5];
    self.playDbm7b5 = [[AVAudioPlayer alloc] initWithContentsOfURL:Dbm7b5URL error:nil];
    [self.playDbm7b5 prepareToPlay];
    
    NSString *Emajor = [[NSBundle mainBundle] pathForResource:@"Emajor" ofType:@"wav"];
    NSURL *EmajorURL = [[NSURL alloc] initFileURLWithPath:Emajor];
    self.playEmajor = [[AVAudioPlayer alloc] initWithContentsOfURL:EmajorURL error:nil];
    [self.playEmajor prepareToPlay];
    
    NSString *Eminor = [[NSBundle mainBundle] pathForResource:@"Eminor" ofType:@"wav"];
    NSURL *EminorURL = [[NSURL alloc] initFileURLWithPath:Eminor];
    self.playEminor = [[AVAudioPlayer alloc] initWithContentsOfURL:EminorURL error:nil];
    [self.playEminor prepareToPlay];
    
    NSString *Em7b5 = [[NSBundle mainBundle] pathForResource:@"Em7b5" ofType:@"wav"];
    NSURL *Em7b5URL = [[NSURL alloc] initFileURLWithPath:Em7b5];
    self.playEm7b5 = [[AVAudioPlayer alloc] initWithContentsOfURL:Em7b5URL error:nil];
    [self.playEm7b5 prepareToPlay];
    
    NSString *Ebmajor = [[NSBundle mainBundle] pathForResource:@"Ebmajor" ofType:@"wav"];
    NSURL *EbmajorURL = [[NSURL alloc] initFileURLWithPath:Ebmajor];
    self.playEbmajor = [[AVAudioPlayer alloc] initWithContentsOfURL:EbmajorURL error:nil];
    [self.playEbmajor prepareToPlay];
    
    NSString *Ebminor = [[NSBundle mainBundle] pathForResource:@"Ebminor" ofType:@"wav"];
    NSURL *EbminorURL = [[NSURL alloc] initFileURLWithPath:Ebminor];
    self.playEbminor = [[AVAudioPlayer alloc] initWithContentsOfURL:EbminorURL error:nil];
    [self.playEbminor prepareToPlay];
    
    NSString *Ebm7b5 = [[NSBundle mainBundle] pathForResource:@"Ebm7b5" ofType:@"wav"];
    NSURL *Ebm7b5URL = [[NSURL alloc] initFileURLWithPath:Ebm7b5];
    self.playEbm7b5 = [[AVAudioPlayer alloc] initWithContentsOfURL:Ebm7b5URL error:nil];
    [self.playEbm7b5 prepareToPlay];
    
    NSString *Fmajor = [[NSBundle mainBundle] pathForResource:@"Fmajor" ofType:@"wav"];
    NSURL *FmajorURL = [[NSURL alloc] initFileURLWithPath:Fmajor];
    self.playFmajor = [[AVAudioPlayer alloc] initWithContentsOfURL:FmajorURL error:nil];
    [self.playFmajor prepareToPlay];
    
    NSString *Fminor = [[NSBundle mainBundle] pathForResource:@"Fminor" ofType:@"wav"];
    NSURL *FminorURL = [[NSURL alloc] initFileURLWithPath:Fminor];
    self.playFminor = [[AVAudioPlayer alloc] initWithContentsOfURL:FminorURL error:nil];
    [self.playFminor prepareToPlay];
    
    NSString *Fm7b5 = [[NSBundle mainBundle] pathForResource:@"Fm7b5" ofType:@"wav"];
    NSURL *Fm7b5URL = [[NSURL alloc] initFileURLWithPath:Fm7b5];
    self.playFm7b5 = [[AVAudioPlayer alloc] initWithContentsOfURL:Fm7b5URL error:nil];
    [self.playFm7b5 prepareToPlay];
    
    NSString *Gbmajor = [[NSBundle mainBundle] pathForResource:@"Gbmajor" ofType:@"wav"];
    NSURL *GbmajorURL = [[NSURL alloc] initFileURLWithPath:Gbmajor];
    self.playGbmajor = [[AVAudioPlayer alloc] initWithContentsOfURL:GbmajorURL error:nil];
    [self.playGbmajor prepareToPlay];
    
    NSString *Gbminor = [[NSBundle mainBundle] pathForResource:@"Gbminor" ofType:@"wav"];
    NSURL *GbminorURL = [[NSURL alloc] initFileURLWithPath:Gbminor];
    self.playGbminor = [[AVAudioPlayer alloc] initWithContentsOfURL:GbminorURL error:nil];
    [self.playGbminor prepareToPlay];
    
    NSString *Gbm7b5 = [[NSBundle mainBundle] pathForResource:@"Gbm7b5" ofType:@"wav"];
    NSURL *Gbm7b5URL = [[NSURL alloc] initFileURLWithPath:Gbm7b5];
    self.playGbm7b5 = [[AVAudioPlayer alloc] initWithContentsOfURL:Gbm7b5URL error:nil];
    [self.playGbm7b5 prepareToPlay];
    
    NSString *Gmajor = [[NSBundle mainBundle] pathForResource:@"Gmajor" ofType:@"wav"];
    NSURL *GmajorURL = [[NSURL alloc] initFileURLWithPath:Gmajor];
    self.playGmajor = [[AVAudioPlayer alloc] initWithContentsOfURL:GmajorURL error:nil];
    [self.playGmajor prepareToPlay];
    
    NSString *Gminor = [[NSBundle mainBundle] pathForResource:@"Gminor" ofType:@"wav"];
    NSURL *GminorURL = [[NSURL alloc] initFileURLWithPath:Gminor];
    self.playGminor = [[AVAudioPlayer alloc] initWithContentsOfURL:GminorURL error:nil];
    [self.playGminor prepareToPlay];
    
    NSString *Gm7b5 = [[NSBundle mainBundle] pathForResource:@"Gm7b5" ofType:@"wav"];
    NSURL *Gm7b5URL = [[NSURL alloc] initFileURLWithPath:Gm7b5];
    self.playGm7b5 = [[AVAudioPlayer alloc] initWithContentsOfURL:Gm7b5URL error:nil];
    [self.playGm7b5 prepareToPlay];
    
    NSString *Abmajor = [[NSBundle mainBundle] pathForResource:@"Abmajor" ofType:@"wav"];
    NSURL *AbmajorURL = [[NSURL alloc] initFileURLWithPath:Abmajor];
    self.playAbmajor = [[AVAudioPlayer alloc] initWithContentsOfURL:AbmajorURL error:nil];
    [self.playAbmajor prepareToPlay];
    
    NSString *Abminor = [[NSBundle mainBundle] pathForResource:@"Abminor" ofType:@"wav"];
    NSURL *AbminorURL = [[NSURL alloc] initFileURLWithPath:Abminor];
    self.playAbminor = [[AVAudioPlayer alloc] initWithContentsOfURL:AbminorURL error:nil];
    [self.playAbminor prepareToPlay];
    
    NSString *Abm7b5 = [[NSBundle mainBundle] pathForResource:@"Abm7b5" ofType:@"wav"];
    NSURL *Abm7b5URL = [[NSURL alloc] initFileURLWithPath:Abm7b5];
    self.playAbm7b5 = [[AVAudioPlayer alloc] initWithContentsOfURL:Abm7b5URL error:nil];
    [self.playAbm7b5 prepareToPlay];

    NSString *Amajor = [[NSBundle mainBundle] pathForResource:@"Amajor" ofType:@"wav"];
    NSURL *AmajorURL = [[NSURL alloc] initFileURLWithPath:Amajor];
    self.playAmajor = [[AVAudioPlayer alloc] initWithContentsOfURL:AmajorURL error:nil];
    [self.playAmajor prepareToPlay];
    
    NSString *Aminor = [[NSBundle mainBundle] pathForResource:@"Aminor" ofType:@"wav"];
    NSURL *AminorURL = [[NSURL alloc] initFileURLWithPath:Aminor];
    self.playAminor = [[AVAudioPlayer alloc] initWithContentsOfURL:AminorURL error:nil];
    [self.playAminor prepareToPlay];
    
    NSString *Am7b5 = [[NSBundle mainBundle] pathForResource:@"Am7b5" ofType:@"wav"];
    NSURL *Am7b5URL = [[NSURL alloc] initFileURLWithPath:Am7b5];
    self.playAm7b5 = [[AVAudioPlayer alloc] initWithContentsOfURL:Am7b5URL error:nil];
    [self.playAm7b5 prepareToPlay];
    
    NSString *Bbmajor = [[NSBundle mainBundle] pathForResource:@"Bbmajor" ofType:@"wav"];
    NSURL *BbmajorURL = [[NSURL alloc] initFileURLWithPath:Bbmajor];
    self.playBbmajor = [[AVAudioPlayer alloc] initWithContentsOfURL:BbmajorURL error:nil];
    [self.playBbmajor prepareToPlay];
    
    NSString *Bbminor = [[NSBundle mainBundle] pathForResource:@"Bbminor" ofType:@"wav"];
    NSURL *BbminorURL = [[NSURL alloc] initFileURLWithPath:Bbminor];
    self.playBbminor = [[AVAudioPlayer alloc] initWithContentsOfURL:BbminorURL error:nil];
    [self.playBbminor prepareToPlay];
    
    NSString *Bbm7b5 = [[NSBundle mainBundle] pathForResource:@"Bbm7b5" ofType:@"wav"];
    NSURL *Bbm7b5URL = [[NSURL alloc] initFileURLWithPath:Bbm7b5];
    self.playBbm7b5 = [[AVAudioPlayer alloc] initWithContentsOfURL:Bbm7b5URL error:nil];
    [self.playBbm7b5 prepareToPlay];
    
    NSString *Bmajor = [[NSBundle mainBundle] pathForResource:@"Bmajor" ofType:@"wav"];
    NSURL *BmajorURL = [[NSURL alloc] initFileURLWithPath:Bmajor];
    self.playBmajor = [[AVAudioPlayer alloc] initWithContentsOfURL:BmajorURL error:nil];
    [self.playBmajor prepareToPlay];
    
    NSString *Bminor = [[NSBundle mainBundle] pathForResource:@"Bminor" ofType:@"wav"];
    NSURL *BminorURL = [[NSURL alloc] initFileURLWithPath:Bminor];
    self.playBminor = [[AVAudioPlayer alloc] initWithContentsOfURL:BminorURL error:nil];
    [self.playBminor prepareToPlay];
    
    NSString *Bm7b5 = [[NSBundle mainBundle] pathForResource:@"Bm7b5" ofType:@"wav"];
    NSURL *Bm7b5URL = [[NSURL alloc] initFileURLWithPath:Bm7b5];
    self.playBm7b5 = [[AVAudioPlayer alloc] initWithContentsOfURL:Bm7b5URL error:nil];
    [self.playBm7b5 prepareToPlay];

}

@end
