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
    [self setupAudioPlayers];
    [self tempoSliderDidMove:self.tempoSlider];
    self.playing = NO;
    [self.timer invalidate];
    self.chordLoop = 0;
    self.keyLabel.text = self.keyToPass;
    self.keySignature = self.keySignatureToPass;
    
    //self.setKey = [[ChordLibrary alloc] init];
    //self.setKey.Cmajor;


    //using UIPickerView as input for the chords
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
    
    NSLog(@"Selected Row %ld", (long)row);
    
    //update each textfield with pickerview input
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

//touch anywhere to dismiss keyboard/pickerview from stackoverflow
- (void)touchesBegan:(NSSet<UITouch *> *)touches
           withEvent:(UIEvent *)event {
    [self.view endEditing:YES];}

- (IBAction)tempoSliderDidMove:(UISlider *)sender {
    self.BPM = self.tempoSlider.value;
    NSLog(@"BPM = %d", (int)self.BPM);
    self.tempoLabel.text = [NSString stringWithFormat:@"%d", (int)self.BPM];

        [self.timer invalidate];
        [self didPressPlay:nil];
    
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

//code to randomize picker from stackoverflow
- (IBAction)randomChord1:(UIButton *)sender {
    NSUInteger random = arc4random_uniform(self.keySignature.count);
    [_chordPicker selectRow:random inComponent:0 animated:YES];
        self.selectChord1.text = self.keySignature[random];
}

- (IBAction)randomChord2:(UIButton *)sender {
    NSUInteger random = arc4random_uniform(self.keySignature.count);
    [_chordPicker selectRow:random inComponent:0 animated:YES];
    self.selectChord2.text = self.keySignature[random];
}

- (IBAction)randomChord3:(UIButton *)sender {
    NSUInteger random = arc4random_uniform(self.keySignature.count);
    [_chordPicker selectRow:random inComponent:0 animated:YES];
    self.selectChord3.text = self.keySignature[random];
}

- (IBAction)randomChord4:(UIButton *)sender {
    NSUInteger random = arc4random_uniform(self.keySignature.count);
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

- (IBAction)didPressPlay:(UIButton *)sender {

    NSLog(@"Pressed Play %ld", sender.tag);
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:60.0/self.BPM target:self selector:@selector(timerFire:) userInfo:nil repeats:YES];
    ((UIButton *)sender).enabled = NO; //disables second pressing
    
}

- (IBAction)didPressStop:(UIButton *)sender {
    NSLog(@"STOPPED");
    self.playing = NO;
    [self.timer invalidate];
    self.chordLoop = 0;
    self.didPressPlay.enabled = YES;

}


- (void) timerFire:(NSTimer *)timer {
    NSLog(@"Timer Fired! chord %ld", (long)self.chordLoop);
        //NSLog(@"%@",self.selectChord1.text);
    
    self.selectChord1.tag = 0;
    self.selectChord2.tag = 1;
    self.selectChord3.tag = 2;
    self.selectChord4.tag = 3;
    
    if (self.selectChord1.tag == self.chordLoop){
        self.selectChord1.backgroundColor = [UIColor orangeColor];}
    else {
        self.selectChord1.backgroundColor = [UIColor whiteColor];
            }
    
    if (self.selectChord2.tag == self.chordLoop){
        self.selectChord2.backgroundColor = [UIColor orangeColor];
    } else { self.selectChord2.backgroundColor = [UIColor whiteColor];
    }
    
    if (self.selectChord3.tag == self.chordLoop){
        self.selectChord3.backgroundColor = [UIColor orangeColor];
    } else { self.selectChord3.backgroundColor = [UIColor whiteColor];
    }
    
    if (self.selectChord4.tag == self.chordLoop){
        self.selectChord4.backgroundColor = [UIColor orangeColor];
    } else { self.selectChord4.backgroundColor = [UIColor whiteColor];
    }
    
    //things related to playback
    if (self.selectChord1.tag == self.chordLoop){
        if ([self.selectChord1.text isEqualToString:@"C"]) {
            [self.playCmajor play];}
        else if ([self.selectChord1.text isEqualToString:@"Dm"]) {
            [self.playDminor play];}
        else if ([self.selectChord1.text isEqualToString:@"Em"]) {
            [self.playEminor play];}
        else if ([self.selectChord1.text isEqualToString:@"F"]) {
            [self.playFmajor play];}
        else if ([self.selectChord1.text isEqualToString:@"G"]) {
            [self.playGmajor play];}
        else if ([self.selectChord1.text isEqualToString:@"Am"]) {
            [self.playAminor play];}
        else if ([self.selectChord1.text isEqualToString:@"Bm7b5"]) {
            [self.playBm7b5 play];}
    }
    if (self.selectChord2.tag == self.chordLoop){
        if ([self.selectChord2.text isEqualToString:@"C"]) {
            [self.playCmajor play];}
        else if ([self.selectChord2.text isEqualToString:@"Dm"]) {
            [self.playDminor play];}
        else if ([self.selectChord2.text isEqualToString:@"Em"]) {
            [self.playEminor play];}
        else if ([self.selectChord2.text isEqualToString:@"F"]) {
            [self.playFmajor play];}
        else if ([self.selectChord2.text isEqualToString:@"G"]) {
            [self.playGmajor play];}
        else if ([self.selectChord2.text isEqualToString:@"Am"]) {
            [self.playAminor play];}
        else if ([self.selectChord2.text isEqualToString:@"Bm7b5"]) {
            [self.playBm7b5 play];}
    }
    if (self.selectChord3.tag == self.chordLoop){
        if ([self.selectChord3.text isEqualToString:@"C"]) {
            [self.playCmajor play];}
        else if ([self.selectChord3.text isEqualToString:@"Dm"]) {
            [self.playDminor play];}
        else if ([self.selectChord3.text isEqualToString:@"Em"]) {
            [self.playEminor play];}
        else if ([self.selectChord3.text isEqualToString:@"F"]) {
            [self.playFmajor play];}
        else if ([self.selectChord3.text isEqualToString:@"G"]) {
            [self.playGmajor play];}
        else if ([self.selectChord3.text isEqualToString:@"Am"]) {
            [self.playAminor play];}
        else if ([self.selectChord3.text isEqualToString:@"Bm7b5"]) {
            [self.playBm7b5 play];}
    }
    if (self.selectChord4.tag == self.chordLoop){
        if ([self.selectChord4.text isEqualToString:@"C"]) {
            [self.playCmajor play];}
        else if ([self.selectChord4.text isEqualToString:@"Dm"]) {
            [self.playDminor play];}
        else if ([self.selectChord4.text isEqualToString:@"Em"]) {
            [self.playEminor play];}
        else if ([self.selectChord4.text isEqualToString:@"F"]) {
            [self.playFmajor play];}
        else if ([self.selectChord4.text isEqualToString:@"G"]) {
            [self.playGmajor play];}
        else if ([self.selectChord4.text isEqualToString:@"Am"]) {
            [self.playAminor play];}
        else if ([self.selectChord4.text isEqualToString:@"Bm7b5"]) {
            [self.playBm7b5 play];}
    }


    
    
    
    
    

    
    
    self.chordLoop++;
    if (self.chordLoop > 3)
        self.chordLoop = 0;
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
}

- (IBAction)pickKey:(UIButton *)sender {
}
@end
