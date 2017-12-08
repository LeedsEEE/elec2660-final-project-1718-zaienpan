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
    
    //each textfield has its own corresponding pickerView to avoid a single pickerView affecting other textfields
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
    
    return [self.keySignature count]; //number of rows created is dependent on how many objects are in the keySignature
    
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
    [self.view endEditing:YES];
}

#pragma mark tempo related UI and code
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

#pragma mark Randomize input UI
// obtain randomized picker output, code from stackoverflow
- (IBAction)randomAllPressed:(UIButton *)sender {
    }

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

#pragma mark Clear input UI
//timer continues to fire but the respective AVAudioPlayer of selected textfield will stop playing 
- (IBAction)clearAll:(UIButton *)sender {
    self.selectChord1.text = @"-";
    self.selectChord2.text = @"-";
    self.selectChord3.text = @"-";
    self.selectChord4.text = @"-";
}
    
- (IBAction)clearChord1:(UIButton *)sender {
    self.selectChord1.text = @"-";
}
- (IBAction)clearChord2:(UIButton *)sender {
    self.selectChord2.text = @"-";
}
- (IBAction)clearChord3:(UIButton *)sender {
    self.selectChord3.text = @"-";
}
- (IBAction)clearChord4:(UIButton *)sender {
    self.selectChord4.text = @"-";
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
        self.selectChord1.backgroundColor = [UIColor colorWithRed:0.73 green:0.95 blue:0.82 alpha:1.0];
    } else {
        self.selectChord1.backgroundColor = [UIColor whiteColor];
    }

    if (self.selectChord2.tag == self.chordLoop){
        self.selectChord2.backgroundColor = [UIColor colorWithRed:0.73 green:0.95 blue:0.82 alpha:1.0];
    } else { self.selectChord2.backgroundColor = [UIColor whiteColor];
    }
    
    if (self.selectChord3.tag == self.chordLoop){
        self.selectChord3.backgroundColor = [UIColor colorWithRed:0.73 green:0.95 blue:0.82 alpha:1.0];
    } else { self.selectChord3.backgroundColor = [UIColor whiteColor];
    }
    
    if (self.selectChord4.tag == self.chordLoop){
        self.selectChord4.backgroundColor = [UIColor colorWithRed:0.73 green:0.95 blue:0.82 alpha:1.0];
    } else { self.selectChord4.backgroundColor = [UIColor whiteColor];
    }
    
#pragma mark Load Chord1
    //loads the audio sample based on textfield input
    //I apologise for putting everything in this section as this seems to be the only way to do it.
    //using isEqualToString to load the chords only works in timerFire as it is updated for each NSTimer tick
    
    if ([self.selectChord1.text isEqualToString:@"C"]) {
        NSString *Cmajor = [[NSBundle mainBundle] pathForResource:@"Cmajor" ofType:@"wav"];
        NSURL *CmajorURL = [[NSURL alloc] initFileURLWithPath:Cmajor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:CmajorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Cm"]) {
        NSString *Cminor = [[NSBundle mainBundle] pathForResource:@"Cminor" ofType:@"wav"];
        NSURL *CminorURL = [[NSURL alloc] initFileURLWithPath:Cminor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:CminorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Cm7b5"]) {
        NSString *Cm7b5 = [[NSBundle mainBundle] pathForResource:@"Cm7b5" ofType:@"wav"];
        NSURL *Cm7b5URL = [[NSURL alloc] initFileURLWithPath:Cm7b5];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:Cm7b5URL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"C#"]) {
        NSString *Dbmajor = [[NSBundle mainBundle] pathForResource:@"Dbmajor" ofType:@"wav"];
        NSURL *DbmajorURL = [[NSURL alloc] initFileURLWithPath:Dbmajor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:DbmajorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"C#m"]) {
        NSString *Dbminor = [[NSBundle mainBundle] pathForResource:@"Dbminor" ofType:@"wav"];
        NSURL *DbminorURL = [[NSURL alloc] initFileURLWithPath:Dbminor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:DbminorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"C#m7b5"]) {
        NSString *Dbm7b5 = [[NSBundle mainBundle] pathForResource:@"Dbm7b5" ofType:@"wav"];
        NSURL *Dbm7b5URL = [[NSURL alloc] initFileURLWithPath:Dbm7b5];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:Dbm7b5URL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Db"]) {
        NSString *Dbmajor = [[NSBundle mainBundle] pathForResource:@"Dbmajor" ofType:@"wav"];
        NSURL *DbmajorURL = [[NSURL alloc] initFileURLWithPath:Dbmajor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:DbmajorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Dbm"]) {
        NSString *Dbminor = [[NSBundle mainBundle] pathForResource:@"Dbminor" ofType:@"wav"];
        NSURL *DbminorURL = [[NSURL alloc] initFileURLWithPath:Dbminor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:DbminorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Dbm7b5"]) {
        NSString *Dbm7b5 = [[NSBundle mainBundle] pathForResource:@"Dbm7b5" ofType:@"wav"];
        NSURL *Dbm7b5URL = [[NSURL alloc] initFileURLWithPath:Dbm7b5];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:Dbm7b5URL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"D"]) {
        NSString *Dmajor = [[NSBundle mainBundle] pathForResource:@"Dmajor" ofType:@"wav"];
        NSURL *DmajorURL = [[NSURL alloc] initFileURLWithPath:Dmajor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:DmajorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Dm"]) {
        NSString *Dminor = [[NSBundle mainBundle] pathForResource:@"Dminor" ofType:@"wav"];
        NSURL *DminorURL = [[NSURL alloc] initFileURLWithPath:Dminor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:DminorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Dm7b5"]) {
        NSString *Dm7b5 = [[NSBundle mainBundle] pathForResource:@"Dm7b5" ofType:@"wav"];
        NSURL *Dm7b5URL = [[NSURL alloc] initFileURLWithPath:Dm7b5];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:Dm7b5URL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"D#"]) {
        NSString *Ebmajor = [[NSBundle mainBundle] pathForResource:@"Ebmajor" ofType:@"wav"];
        NSURL *EbmajorURL = [[NSURL alloc] initFileURLWithPath:Ebmajor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:EbmajorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"D#m"]) {
        NSString *Ebminor = [[NSBundle mainBundle] pathForResource:@"Ebminor" ofType:@"wav"];
        NSURL *EbminorURL = [[NSURL alloc] initFileURLWithPath:Ebminor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:EbminorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"D#m7b5"]) {
        NSString *Ebm7b5 = [[NSBundle mainBundle] pathForResource:@"Ebm7b5" ofType:@"wav"];
        NSURL *Ebm7b5URL = [[NSURL alloc] initFileURLWithPath:Ebm7b5];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:Ebm7b5URL error:nil];
        [self.playChord1 prepareToPlay];}

    else if ([self.selectChord1.text isEqualToString:@"Eb"]) {
        NSString *Ebmajor = [[NSBundle mainBundle] pathForResource:@"Ebmajor" ofType:@"wav"];
        NSURL *EbmajorURL = [[NSURL alloc] initFileURLWithPath:Ebmajor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:EbmajorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Ebm"]) {
        NSString *Ebminor = [[NSBundle mainBundle] pathForResource:@"Ebminor" ofType:@"wav"];
        NSURL *EbminorURL = [[NSURL alloc] initFileURLWithPath:Ebminor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:EbminorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Ebm7b5"]) {
        NSString *Ebm7b5 = [[NSBundle mainBundle] pathForResource:@"Ebm7b5" ofType:@"wav"];
        NSURL *Ebm7b5URL = [[NSURL alloc] initFileURLWithPath:Ebm7b5];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:Ebm7b5URL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"E"]) {
        NSString *Emajor = [[NSBundle mainBundle] pathForResource:@"Emajor" ofType:@"wav"];
        NSURL *EmajorURL = [[NSURL alloc] initFileURLWithPath:Emajor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:EmajorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Em"]) {
        NSString *Eminor = [[NSBundle mainBundle] pathForResource:@"Eminor" ofType:@"wav"];
        NSURL *EminorURL = [[NSURL alloc] initFileURLWithPath:Eminor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:EminorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Em7b5"]) {
        NSString *Em7b5 = [[NSBundle mainBundle] pathForResource:@"Em7b5" ofType:@"wav"];
        NSURL *Em7b5URL = [[NSURL alloc] initFileURLWithPath:Em7b5];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:Em7b5URL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"F"]) {
        NSString *Fmajor = [[NSBundle mainBundle] pathForResource:@"Fmajor" ofType:@"wav"];
        NSURL *FmajorURL = [[NSURL alloc] initFileURLWithPath:Fmajor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:FmajorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Fm"]) {
        NSString *Fminor = [[NSBundle mainBundle] pathForResource:@"Fminor" ofType:@"wav"];
        NSURL *FminorURL = [[NSURL alloc] initFileURLWithPath:Fminor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:FminorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Fm7b5"]) {
        NSString *Fm7b5 = [[NSBundle mainBundle] pathForResource:@"Fm7b5" ofType:@"wav"];
        NSURL *Fm7b5URL = [[NSURL alloc] initFileURLWithPath:Fm7b5];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:Fm7b5URL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"F#"]) {
        NSString *Gbmajor = [[NSBundle mainBundle] pathForResource:@"Gbmajor" ofType:@"wav"];
        NSURL *GbmajorURL = [[NSURL alloc] initFileURLWithPath:Gbmajor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:GbmajorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"F#m"]) {
        NSString *Gbminor = [[NSBundle mainBundle] pathForResource:@"Gbminor" ofType:@"wav"];
        NSURL *GbminorURL = [[NSURL alloc] initFileURLWithPath:Gbminor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:GbminorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"F#m7b5"]) {
        NSString *Gbm7b5 = [[NSBundle mainBundle] pathForResource:@"Gbm7b5" ofType:@"wav"];
        NSURL *Gbm7b5URL = [[NSURL alloc] initFileURLWithPath:Gbm7b5];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:Gbm7b5URL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Gb"]) {
        NSString *Gbmajor = [[NSBundle mainBundle] pathForResource:@"Gbmajor" ofType:@"wav"];
        NSURL *GbmajorURL = [[NSURL alloc] initFileURLWithPath:Gbmajor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:GbmajorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Gbm"]) {
        NSString *Gbminor = [[NSBundle mainBundle] pathForResource:@"Gbminor" ofType:@"wav"];
        NSURL *GbminorURL = [[NSURL alloc] initFileURLWithPath:Gbminor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:GbminorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Gbm7b5"]) {
        NSString *Gbm7b5 = [[NSBundle mainBundle] pathForResource:@"Gbm7b5" ofType:@"wav"];
        NSURL *Gbm7b5URL = [[NSURL alloc] initFileURLWithPath:Gbm7b5];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:Gbm7b5URL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"G"]) {
        NSString *Gmajor = [[NSBundle mainBundle] pathForResource:@"Gmajor" ofType:@"wav"];
        NSURL *GmajorURL = [[NSURL alloc] initFileURLWithPath:Gmajor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:GmajorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Gm"]) {
        NSString *Gminor = [[NSBundle mainBundle] pathForResource:@"Gminor" ofType:@"wav"];
        NSURL *GminorURL = [[NSURL alloc] initFileURLWithPath:Gminor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:GminorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Gm7b5"]) {
        NSString *Gm7b5 = [[NSBundle mainBundle] pathForResource:@"Gm7b5" ofType:@"wav"];
        NSURL *Gm7b5URL = [[NSURL alloc] initFileURLWithPath:Gm7b5];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:Gm7b5URL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"G#"]) {
        NSString *Abmajor = [[NSBundle mainBundle] pathForResource:@"Abmajor" ofType:@"wav"];
        NSURL *AbmajorURL = [[NSURL alloc] initFileURLWithPath:Abmajor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:AbmajorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"G#m"]) {
        NSString *Abminor = [[NSBundle mainBundle] pathForResource:@"Abminor" ofType:@"wav"];
        NSURL *AbminorURL = [[NSURL alloc] initFileURLWithPath:Abminor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:AbminorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"G#m7b5"]) {
        NSString *Abm7b5 = [[NSBundle mainBundle] pathForResource:@"Abm7b5" ofType:@"wav"];
        NSURL *Abm7b5URL = [[NSURL alloc] initFileURLWithPath:Abm7b5];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:Abm7b5URL error:nil];
        [self.playChord1 prepareToPlay];}

    
    else if ([self.selectChord1.text isEqualToString:@"Ab"]) {
        NSString *Abmajor = [[NSBundle mainBundle] pathForResource:@"Abmajor" ofType:@"wav"];
        NSURL *AbmajorURL = [[NSURL alloc] initFileURLWithPath:Abmajor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:AbmajorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Abm"]) {
        NSString *Abminor = [[NSBundle mainBundle] pathForResource:@"Abminor" ofType:@"wav"];
        NSURL *AbminorURL = [[NSURL alloc] initFileURLWithPath:Abminor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:AbminorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Abm7b5"]) {
        NSString *Abm7b5 = [[NSBundle mainBundle] pathForResource:@"Abm7b5" ofType:@"wav"];
        NSURL *Abm7b5URL = [[NSURL alloc] initFileURLWithPath:Abm7b5];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:Abm7b5URL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"A"]) {
        NSString *Amajor = [[NSBundle mainBundle] pathForResource:@"Amajor" ofType:@"wav"];
        NSURL *AmajorURL = [[NSURL alloc] initFileURLWithPath:Amajor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:AmajorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Am"]) {
        NSString *Aminor = [[NSBundle mainBundle] pathForResource:@"Aminor" ofType:@"wav"];
        NSURL *AminorURL = [[NSURL alloc] initFileURLWithPath:Aminor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:AminorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Am7b5"]) {
        NSString *Am7b5 = [[NSBundle mainBundle] pathForResource:@"Am7b5" ofType:@"wav"];
        NSURL *Am7b5URL = [[NSURL alloc] initFileURLWithPath:Am7b5];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:Am7b5URL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"A#"]) {
        NSString *Bbmajor = [[NSBundle mainBundle] pathForResource:@"Bbmajor" ofType:@"wav"];
        NSURL *BbmajorURL = [[NSURL alloc] initFileURLWithPath:Bbmajor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:BbmajorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"A#m"]) {
        NSString *Bbminor = [[NSBundle mainBundle] pathForResource:@"Bbminor" ofType:@"wav"];
        NSURL *BbminorURL = [[NSURL alloc] initFileURLWithPath:Bbminor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:BbminorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"A#m7b5"]) {
        NSString *Bbm7b5 = [[NSBundle mainBundle] pathForResource:@"Bbm7b5" ofType:@"wav"];
        NSURL *Bbm7b5URL = [[NSURL alloc] initFileURLWithPath:Bbm7b5];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:Bbm7b5URL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Bb"]) {
        NSString *Bbmajor = [[NSBundle mainBundle] pathForResource:@"Bbmajor" ofType:@"wav"];
        NSURL *BbmajorURL = [[NSURL alloc] initFileURLWithPath:Bbmajor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:BbmajorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Bbm"]) {
        NSString *Bbminor = [[NSBundle mainBundle] pathForResource:@"Bbminor" ofType:@"wav"];
        NSURL *BbminorURL = [[NSURL alloc] initFileURLWithPath:Bbminor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:BbminorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Bbm7b5"]) {
        NSString *Bbm7b5 = [[NSBundle mainBundle] pathForResource:@"Bbm7b5" ofType:@"wav"];
        NSURL *Bbm7b5URL = [[NSURL alloc] initFileURLWithPath:Bbm7b5];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:Bbm7b5URL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"B"]) {
        NSString *Bmajor = [[NSBundle mainBundle] pathForResource:@"Bmajor" ofType:@"wav"];
        NSURL *BmajorURL = [[NSURL alloc] initFileURLWithPath:Bmajor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:BmajorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Bm"]) {
        NSString *Bminor = [[NSBundle mainBundle] pathForResource:@"Bminor" ofType:@"wav"];
        NSURL *BminorURL = [[NSURL alloc] initFileURLWithPath:Bminor];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:BminorURL error:nil];
        [self.playChord1 prepareToPlay];}
    
    else if ([self.selectChord1.text isEqualToString:@"Bm7b5"]) {
        NSString *Bm7b5 = [[NSBundle mainBundle] pathForResource:@"Bm7b5" ofType:@"wav"];
        NSURL *Bm7b5URL = [[NSURL alloc] initFileURLWithPath:Bm7b5];
        self.playChord1 = [[AVAudioPlayer alloc] initWithContentsOfURL:Bm7b5URL error:nil];
        [self.playChord1 prepareToPlay];}
    
#pragma mark Load Chord2
    if ([self.selectChord2.text isEqualToString:@"C"]) {
        NSString *Cmajor = [[NSBundle mainBundle] pathForResource:@"Cmajor" ofType:@"wav"];
        NSURL *CmajorURL = [[NSURL alloc] initFileURLWithPath:Cmajor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:CmajorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Cm"]) {
        NSString *Cminor = [[NSBundle mainBundle] pathForResource:@"Cminor" ofType:@"wav"];
        NSURL *CminorURL = [[NSURL alloc] initFileURLWithPath:Cminor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:CminorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Cm7b5"]) {
        NSString *Cm7b5 = [[NSBundle mainBundle] pathForResource:@"Cm7b5" ofType:@"wav"];
        NSURL *Cm7b5URL = [[NSURL alloc] initFileURLWithPath:Cm7b5];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:Cm7b5URL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"C#"]) {
        NSString *Dbmajor = [[NSBundle mainBundle] pathForResource:@"Dbmajor" ofType:@"wav"];
        NSURL *DbmajorURL = [[NSURL alloc] initFileURLWithPath:Dbmajor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:DbmajorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"C#m"]) {
        NSString *Dbminor = [[NSBundle mainBundle] pathForResource:@"Dbminor" ofType:@"wav"];
        NSURL *DbminorURL = [[NSURL alloc] initFileURLWithPath:Dbminor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:DbminorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"C#m7b5"]) {
        NSString *Dbm7b5 = [[NSBundle mainBundle] pathForResource:@"Dbm7b5" ofType:@"wav"];
        NSURL *Dbm7b5URL = [[NSURL alloc] initFileURLWithPath:Dbm7b5];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:Dbm7b5URL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Db"]) {
        NSString *Dbmajor = [[NSBundle mainBundle] pathForResource:@"Dbmajor" ofType:@"wav"];
        NSURL *DbmajorURL = [[NSURL alloc] initFileURLWithPath:Dbmajor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:DbmajorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Dbm"]) {
        NSString *Dbminor = [[NSBundle mainBundle] pathForResource:@"Dbminor" ofType:@"wav"];
        NSURL *DbminorURL = [[NSURL alloc] initFileURLWithPath:Dbminor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:DbminorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Dbm7b5"]) {
        NSString *Dbm7b5 = [[NSBundle mainBundle] pathForResource:@"Dbm7b5" ofType:@"wav"];
        NSURL *Dbm7b5URL = [[NSURL alloc] initFileURLWithPath:Dbm7b5];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:Dbm7b5URL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"D"]) {
        NSString *Dmajor = [[NSBundle mainBundle] pathForResource:@"Dmajor" ofType:@"wav"];
        NSURL *DmajorURL = [[NSURL alloc] initFileURLWithPath:Dmajor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:DmajorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Dm"]) {
        NSString *Dminor = [[NSBundle mainBundle] pathForResource:@"Dminor" ofType:@"wav"];
        NSURL *DminorURL = [[NSURL alloc] initFileURLWithPath:Dminor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:DminorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Dm7b5"]) {
        NSString *Dm7b5 = [[NSBundle mainBundle] pathForResource:@"Dm7b5" ofType:@"wav"];
        NSURL *Dm7b5URL = [[NSURL alloc] initFileURLWithPath:Dm7b5];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:Dm7b5URL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"D#"]) {
        NSString *Ebmajor = [[NSBundle mainBundle] pathForResource:@"Ebmajor" ofType:@"wav"];
        NSURL *EbmajorURL = [[NSURL alloc] initFileURLWithPath:Ebmajor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:EbmajorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"D#m"]) {
        NSString *Ebminor = [[NSBundle mainBundle] pathForResource:@"Ebminor" ofType:@"wav"];
        NSURL *EbminorURL = [[NSURL alloc] initFileURLWithPath:Ebminor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:EbminorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"D#m7b5"]) {
        NSString *Ebm7b5 = [[NSBundle mainBundle] pathForResource:@"Ebm7b5" ofType:@"wav"];
        NSURL *Ebm7b5URL = [[NSURL alloc] initFileURLWithPath:Ebm7b5];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:Ebm7b5URL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Eb"]) {
        NSString *Ebmajor = [[NSBundle mainBundle] pathForResource:@"Ebmajor" ofType:@"wav"];
        NSURL *EbmajorURL = [[NSURL alloc] initFileURLWithPath:Ebmajor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:EbmajorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Ebm"]) {
        NSString *Ebminor = [[NSBundle mainBundle] pathForResource:@"Ebminor" ofType:@"wav"];
        NSURL *EbminorURL = [[NSURL alloc] initFileURLWithPath:Ebminor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:EbminorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Ebm7b5"]) {
        NSString *Ebm7b5 = [[NSBundle mainBundle] pathForResource:@"Ebm7b5" ofType:@"wav"];
        NSURL *Ebm7b5URL = [[NSURL alloc] initFileURLWithPath:Ebm7b5];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:Ebm7b5URL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"E"]) {
        NSString *Emajor = [[NSBundle mainBundle] pathForResource:@"Emajor" ofType:@"wav"];
        NSURL *EmajorURL = [[NSURL alloc] initFileURLWithPath:Emajor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:EmajorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Em"]) {
        NSString *Eminor = [[NSBundle mainBundle] pathForResource:@"Eminor" ofType:@"wav"];
        NSURL *EminorURL = [[NSURL alloc] initFileURLWithPath:Eminor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:EminorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Em7b5"]) {
        NSString *Em7b5 = [[NSBundle mainBundle] pathForResource:@"Em7b5" ofType:@"wav"];
        NSURL *Em7b5URL = [[NSURL alloc] initFileURLWithPath:Em7b5];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:Em7b5URL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"F"]) {
        NSString *Fmajor = [[NSBundle mainBundle] pathForResource:@"Fmajor" ofType:@"wav"];
        NSURL *FmajorURL = [[NSURL alloc] initFileURLWithPath:Fmajor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:FmajorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Fm"]) {
        NSString *Fminor = [[NSBundle mainBundle] pathForResource:@"Fminor" ofType:@"wav"];
        NSURL *FminorURL = [[NSURL alloc] initFileURLWithPath:Fminor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:FminorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Fm7b5"]) {
        NSString *Fm7b5 = [[NSBundle mainBundle] pathForResource:@"Fm7b5" ofType:@"wav"];
        NSURL *Fm7b5URL = [[NSURL alloc] initFileURLWithPath:Fm7b5];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:Fm7b5URL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"F#"]) {
        NSString *Gbmajor = [[NSBundle mainBundle] pathForResource:@"Gbmajor" ofType:@"wav"];
        NSURL *GbmajorURL = [[NSURL alloc] initFileURLWithPath:Gbmajor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:GbmajorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"F#m"]) {
        NSString *Gbminor = [[NSBundle mainBundle] pathForResource:@"Gbminor" ofType:@"wav"];
        NSURL *GbminorURL = [[NSURL alloc] initFileURLWithPath:Gbminor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:GbminorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"F#m7b5"]) {
        NSString *Gbm7b5 = [[NSBundle mainBundle] pathForResource:@"Gbm7b5" ofType:@"wav"];
        NSURL *Gbm7b5URL = [[NSURL alloc] initFileURLWithPath:Gbm7b5];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:Gbm7b5URL error:nil];
        [self.playChord2 prepareToPlay];}

    
    else if ([self.selectChord2.text isEqualToString:@"Gb"]) {
        NSString *Gbmajor = [[NSBundle mainBundle] pathForResource:@"Gbmajor" ofType:@"wav"];
        NSURL *GbmajorURL = [[NSURL alloc] initFileURLWithPath:Gbmajor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:GbmajorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Gbm"]) {
        NSString *Gbminor = [[NSBundle mainBundle] pathForResource:@"Gbminor" ofType:@"wav"];
        NSURL *GbminorURL = [[NSURL alloc] initFileURLWithPath:Gbminor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:GbminorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Gbm7b5"]) {
        NSString *Gbm7b5 = [[NSBundle mainBundle] pathForResource:@"Gbm7b5" ofType:@"wav"];
        NSURL *Gbm7b5URL = [[NSURL alloc] initFileURLWithPath:Gbm7b5];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:Gbm7b5URL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"G"]) {
        NSString *Gmajor = [[NSBundle mainBundle] pathForResource:@"Gmajor" ofType:@"wav"];
        NSURL *GmajorURL = [[NSURL alloc] initFileURLWithPath:Gmajor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:GmajorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Gm"]) {
        NSString *Gminor = [[NSBundle mainBundle] pathForResource:@"Gminor" ofType:@"wav"];
        NSURL *GminorURL = [[NSURL alloc] initFileURLWithPath:Gminor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:GminorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Gm7b5"]) {
        NSString *Gm7b5 = [[NSBundle mainBundle] pathForResource:@"Gm7b5" ofType:@"wav"];
        NSURL *Gm7b5URL = [[NSURL alloc] initFileURLWithPath:Gm7b5];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:Gm7b5URL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"G#"]) {
        NSString *Abmajor = [[NSBundle mainBundle] pathForResource:@"Abmajor" ofType:@"wav"];
        NSURL *AbmajorURL = [[NSURL alloc] initFileURLWithPath:Abmajor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:AbmajorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"G#m"]) {
        NSString *Abminor = [[NSBundle mainBundle] pathForResource:@"Abminor" ofType:@"wav"];
        NSURL *AbminorURL = [[NSURL alloc] initFileURLWithPath:Abminor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:AbminorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"G#m7b5"]) {
        NSString *Abm7b5 = [[NSBundle mainBundle] pathForResource:@"Abm7b5" ofType:@"wav"];
        NSURL *Abm7b5URL = [[NSURL alloc] initFileURLWithPath:Abm7b5];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:Abm7b5URL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Ab"]) {
        NSString *Abmajor = [[NSBundle mainBundle] pathForResource:@"Abmajor" ofType:@"wav"];
        NSURL *AbmajorURL = [[NSURL alloc] initFileURLWithPath:Abmajor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:AbmajorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Abm"]) {
        NSString *Abminor = [[NSBundle mainBundle] pathForResource:@"Abminor" ofType:@"wav"];
        NSURL *AbminorURL = [[NSURL alloc] initFileURLWithPath:Abminor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:AbminorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Abm7b5"]) {
        NSString *Abm7b5 = [[NSBundle mainBundle] pathForResource:@"Abm7b5" ofType:@"wav"];
        NSURL *Abm7b5URL = [[NSURL alloc] initFileURLWithPath:Abm7b5];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:Abm7b5URL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"A"]) {
        NSString *Amajor = [[NSBundle mainBundle] pathForResource:@"Amajor" ofType:@"wav"];
        NSURL *AmajorURL = [[NSURL alloc] initFileURLWithPath:Amajor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:AmajorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Am"]) {
        NSString *Aminor = [[NSBundle mainBundle] pathForResource:@"Aminor" ofType:@"wav"];
        NSURL *AminorURL = [[NSURL alloc] initFileURLWithPath:Aminor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:AminorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Am7b5"]) {
        NSString *Am7b5 = [[NSBundle mainBundle] pathForResource:@"Am7b5" ofType:@"wav"];
        NSURL *Am7b5URL = [[NSURL alloc] initFileURLWithPath:Am7b5];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:Am7b5URL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"A#"]) {
        NSString *Bbmajor = [[NSBundle mainBundle] pathForResource:@"Bbmajor" ofType:@"wav"];
        NSURL *BbmajorURL = [[NSURL alloc] initFileURLWithPath:Bbmajor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:BbmajorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"A#m"]) {
        NSString *Bbminor = [[NSBundle mainBundle] pathForResource:@"Bbminor" ofType:@"wav"];
        NSURL *BbminorURL = [[NSURL alloc] initFileURLWithPath:Bbminor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:BbminorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"A#m7b5"]) {
        NSString *Bbm7b5 = [[NSBundle mainBundle] pathForResource:@"Bbm7b5" ofType:@"wav"];
        NSURL *Bbm7b5URL = [[NSURL alloc] initFileURLWithPath:Bbm7b5];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:Bbm7b5URL error:nil];
        [self.playChord2 prepareToPlay];}

    
    else if ([self.selectChord2.text isEqualToString:@"Bb"]) {
        NSString *Bbmajor = [[NSBundle mainBundle] pathForResource:@"Bbmajor" ofType:@"wav"];
        NSURL *BbmajorURL = [[NSURL alloc] initFileURLWithPath:Bbmajor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:BbmajorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Bbm"]) {
        NSString *Bbminor = [[NSBundle mainBundle] pathForResource:@"Bbminor" ofType:@"wav"];
        NSURL *BbminorURL = [[NSURL alloc] initFileURLWithPath:Bbminor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:BbminorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Bbm7b5"]) {
        NSString *Bbm7b5 = [[NSBundle mainBundle] pathForResource:@"Bbm7b5" ofType:@"wav"];
        NSURL *Bbm7b5URL = [[NSURL alloc] initFileURLWithPath:Bbm7b5];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:Bbm7b5URL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"B"]) {
        NSString *Bmajor = [[NSBundle mainBundle] pathForResource:@"Bmajor" ofType:@"wav"];
        NSURL *BmajorURL = [[NSURL alloc] initFileURLWithPath:Bmajor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:BmajorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Bm"]) {
        NSString *Bminor = [[NSBundle mainBundle] pathForResource:@"Bminor" ofType:@"wav"];
        NSURL *BminorURL = [[NSURL alloc] initFileURLWithPath:Bminor];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:BminorURL error:nil];
        [self.playChord2 prepareToPlay];}
    
    else if ([self.selectChord2.text isEqualToString:@"Bm7b5"]) {
        NSString *Bm7b5 = [[NSBundle mainBundle] pathForResource:@"Bm7b5" ofType:@"wav"];
        NSURL *Bm7b5URL = [[NSURL alloc] initFileURLWithPath:Bm7b5];
        self.playChord2 = [[AVAudioPlayer alloc] initWithContentsOfURL:Bm7b5URL error:nil];
        [self.playChord2 prepareToPlay];}
    
#pragma mark Load Chord3
    
    if ([self.selectChord3.text isEqualToString:@"C"]) {
        NSString *Cmajor = [[NSBundle mainBundle] pathForResource:@"Cmajor" ofType:@"wav"];
        NSURL *CmajorURL = [[NSURL alloc] initFileURLWithPath:Cmajor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:CmajorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Cm"]) {
        NSString *Cminor = [[NSBundle mainBundle] pathForResource:@"Cminor" ofType:@"wav"];
        NSURL *CminorURL = [[NSURL alloc] initFileURLWithPath:Cminor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:CminorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Cm7b5"]) {
        NSString *Cm7b5 = [[NSBundle mainBundle] pathForResource:@"Cm7b5" ofType:@"wav"];
        NSURL *Cm7b5URL = [[NSURL alloc] initFileURLWithPath:Cm7b5];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:Cm7b5URL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"C#"]) {
        NSString *Dbmajor = [[NSBundle mainBundle] pathForResource:@"Dbmajor" ofType:@"wav"];
        NSURL *DbmajorURL = [[NSURL alloc] initFileURLWithPath:Dbmajor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:DbmajorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"C#m"]) {
        NSString *Dbminor = [[NSBundle mainBundle] pathForResource:@"Dbminor" ofType:@"wav"];
        NSURL *DbminorURL = [[NSURL alloc] initFileURLWithPath:Dbminor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:DbminorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"C#m7b5"]) {
        NSString *Dbm7b5 = [[NSBundle mainBundle] pathForResource:@"Dbm7b5" ofType:@"wav"];
        NSURL *Dbm7b5URL = [[NSURL alloc] initFileURLWithPath:Dbm7b5];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:Dbm7b5URL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Db"]) {
        NSString *Dbmajor = [[NSBundle mainBundle] pathForResource:@"Dbmajor" ofType:@"wav"];
        NSURL *DbmajorURL = [[NSURL alloc] initFileURLWithPath:Dbmajor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:DbmajorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Dbm"]) {
        NSString *Dbminor = [[NSBundle mainBundle] pathForResource:@"Dbminor" ofType:@"wav"];
        NSURL *DbminorURL = [[NSURL alloc] initFileURLWithPath:Dbminor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:DbminorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Dbm7b5"]) {
        NSString *Dbm7b5 = [[NSBundle mainBundle] pathForResource:@"Dbm7b5" ofType:@"wav"];
        NSURL *Dbm7b5URL = [[NSURL alloc] initFileURLWithPath:Dbm7b5];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:Dbm7b5URL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"D"]) {
        NSString *Dmajor = [[NSBundle mainBundle] pathForResource:@"Dmajor" ofType:@"wav"];
        NSURL *DmajorURL = [[NSURL alloc] initFileURLWithPath:Dmajor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:DmajorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Dm"]) {
        NSString *Dminor = [[NSBundle mainBundle] pathForResource:@"Dminor" ofType:@"wav"];
        NSURL *DminorURL = [[NSURL alloc] initFileURLWithPath:Dminor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:DminorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Dm7b5"]) {
        NSString *Dm7b5 = [[NSBundle mainBundle] pathForResource:@"Dm7b5" ofType:@"wav"];
        NSURL *Dm7b5URL = [[NSURL alloc] initFileURLWithPath:Dm7b5];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:Dm7b5URL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"D#"]) {
        NSString *Ebmajor = [[NSBundle mainBundle] pathForResource:@"Ebmajor" ofType:@"wav"];
        NSURL *EbmajorURL = [[NSURL alloc] initFileURLWithPath:Ebmajor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:EbmajorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"D#m"]) {
        NSString *Ebminor = [[NSBundle mainBundle] pathForResource:@"Ebminor" ofType:@"wav"];
        NSURL *EbminorURL = [[NSURL alloc] initFileURLWithPath:Ebminor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:EbminorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"D#m7b5"]) {
        NSString *Ebm7b5 = [[NSBundle mainBundle] pathForResource:@"Ebm7b5" ofType:@"wav"];
        NSURL *Ebm7b5URL = [[NSURL alloc] initFileURLWithPath:Ebm7b5];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:Ebm7b5URL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Eb"]) {
        NSString *Ebmajor = [[NSBundle mainBundle] pathForResource:@"Ebmajor" ofType:@"wav"];
        NSURL *EbmajorURL = [[NSURL alloc] initFileURLWithPath:Ebmajor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:EbmajorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Ebm"]) {
        NSString *Ebminor = [[NSBundle mainBundle] pathForResource:@"Ebminor" ofType:@"wav"];
        NSURL *EbminorURL = [[NSURL alloc] initFileURLWithPath:Ebminor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:EbminorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Ebm7b5"]) {
        NSString *Ebm7b5 = [[NSBundle mainBundle] pathForResource:@"Ebm7b5" ofType:@"wav"];
        NSURL *Ebm7b5URL = [[NSURL alloc] initFileURLWithPath:Ebm7b5];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:Ebm7b5URL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"E"]) {
        NSString *Emajor = [[NSBundle mainBundle] pathForResource:@"Emajor" ofType:@"wav"];
        NSURL *EmajorURL = [[NSURL alloc] initFileURLWithPath:Emajor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:EmajorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Em"]) {
        NSString *Eminor = [[NSBundle mainBundle] pathForResource:@"Eminor" ofType:@"wav"];
        NSURL *EminorURL = [[NSURL alloc] initFileURLWithPath:Eminor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:EminorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Em7b5"]) {
        NSString *Em7b5 = [[NSBundle mainBundle] pathForResource:@"Em7b5" ofType:@"wav"];
        NSURL *Em7b5URL = [[NSURL alloc] initFileURLWithPath:Em7b5];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:Em7b5URL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"F"]) {
        NSString *Fmajor = [[NSBundle mainBundle] pathForResource:@"Fmajor" ofType:@"wav"];
        NSURL *FmajorURL = [[NSURL alloc] initFileURLWithPath:Fmajor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:FmajorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Fm"]) {
        NSString *Fminor = [[NSBundle mainBundle] pathForResource:@"Fminor" ofType:@"wav"];
        NSURL *FminorURL = [[NSURL alloc] initFileURLWithPath:Fminor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:FminorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Fm7b5"]) {
        NSString *Fm7b5 = [[NSBundle mainBundle] pathForResource:@"Fm7b5" ofType:@"wav"];
        NSURL *Fm7b5URL = [[NSURL alloc] initFileURLWithPath:Fm7b5];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:Fm7b5URL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"F#"]) {
        NSString *Gbmajor = [[NSBundle mainBundle] pathForResource:@"Gbmajor" ofType:@"wav"];
        NSURL *GbmajorURL = [[NSURL alloc] initFileURLWithPath:Gbmajor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:GbmajorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"F#m"]) {
        NSString *Gbminor = [[NSBundle mainBundle] pathForResource:@"Gbminor" ofType:@"wav"];
        NSURL *GbminorURL = [[NSURL alloc] initFileURLWithPath:Gbminor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:GbminorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"F#m7b5"]) {
        NSString *Gbm7b5 = [[NSBundle mainBundle] pathForResource:@"Gbm7b5" ofType:@"wav"];
        NSURL *Gbm7b5URL = [[NSURL alloc] initFileURLWithPath:Gbm7b5];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:Gbm7b5URL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Gb"]) {
        NSString *Gbmajor = [[NSBundle mainBundle] pathForResource:@"Gbmajor" ofType:@"wav"];
        NSURL *GbmajorURL = [[NSURL alloc] initFileURLWithPath:Gbmajor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:GbmajorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Gbm"]) {
        NSString *Gbminor = [[NSBundle mainBundle] pathForResource:@"Gbminor" ofType:@"wav"];
        NSURL *GbminorURL = [[NSURL alloc] initFileURLWithPath:Gbminor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:GbminorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Gbm7b5"]) {
        NSString *Gbm7b5 = [[NSBundle mainBundle] pathForResource:@"Gbm7b5" ofType:@"wav"];
        NSURL *Gbm7b5URL = [[NSURL alloc] initFileURLWithPath:Gbm7b5];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:Gbm7b5URL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"G"]) {
        NSString *Gmajor = [[NSBundle mainBundle] pathForResource:@"Gmajor" ofType:@"wav"];
        NSURL *GmajorURL = [[NSURL alloc] initFileURLWithPath:Gmajor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:GmajorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Gm"]) {
        NSString *Gminor = [[NSBundle mainBundle] pathForResource:@"Gminor" ofType:@"wav"];
        NSURL *GminorURL = [[NSURL alloc] initFileURLWithPath:Gminor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:GminorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Gm7b5"]) {
        NSString *Gm7b5 = [[NSBundle mainBundle] pathForResource:@"Gm7b5" ofType:@"wav"];
        NSURL *Gm7b5URL = [[NSURL alloc] initFileURLWithPath:Gm7b5];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:Gm7b5URL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"G#"]) {
        NSString *Abmajor = [[NSBundle mainBundle] pathForResource:@"Abmajor" ofType:@"wav"];
        NSURL *AbmajorURL = [[NSURL alloc] initFileURLWithPath:Abmajor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:AbmajorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"G#m"]) {
        NSString *Abminor = [[NSBundle mainBundle] pathForResource:@"Abminor" ofType:@"wav"];
        NSURL *AbminorURL = [[NSURL alloc] initFileURLWithPath:Abminor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:AbminorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"G#m7b5"]) {
        NSString *Abm7b5 = [[NSBundle mainBundle] pathForResource:@"Abm7b5" ofType:@"wav"];
        NSURL *Abm7b5URL = [[NSURL alloc] initFileURLWithPath:Abm7b5];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:Abm7b5URL error:nil];
        [self.playChord3 prepareToPlay];}

    
    else if ([self.selectChord3.text isEqualToString:@"Ab"]) {
        NSString *Abmajor = [[NSBundle mainBundle] pathForResource:@"Abmajor" ofType:@"wav"];
        NSURL *AbmajorURL = [[NSURL alloc] initFileURLWithPath:Abmajor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:AbmajorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Abm"]) {
        NSString *Abminor = [[NSBundle mainBundle] pathForResource:@"Abminor" ofType:@"wav"];
        NSURL *AbminorURL = [[NSURL alloc] initFileURLWithPath:Abminor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:AbminorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Abm7b5"]) {
        NSString *Abm7b5 = [[NSBundle mainBundle] pathForResource:@"Abm7b5" ofType:@"wav"];
        NSURL *Abm7b5URL = [[NSURL alloc] initFileURLWithPath:Abm7b5];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:Abm7b5URL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"A"]) {
        NSString *Amajor = [[NSBundle mainBundle] pathForResource:@"Amajor" ofType:@"wav"];
        NSURL *AmajorURL = [[NSURL alloc] initFileURLWithPath:Amajor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:AmajorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Am"]) {
        NSString *Aminor = [[NSBundle mainBundle] pathForResource:@"Aminor" ofType:@"wav"];
        NSURL *AminorURL = [[NSURL alloc] initFileURLWithPath:Aminor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:AminorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Am7b5"]) {
        NSString *Am7b5 = [[NSBundle mainBundle] pathForResource:@"Am7b5" ofType:@"wav"];
        NSURL *Am7b5URL = [[NSURL alloc] initFileURLWithPath:Am7b5];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:Am7b5URL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"A#"]) {
        NSString *Bbmajor = [[NSBundle mainBundle] pathForResource:@"Bbmajor" ofType:@"wav"];
        NSURL *BbmajorURL = [[NSURL alloc] initFileURLWithPath:Bbmajor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:BbmajorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"A#m"]) {
        NSString *Bbminor = [[NSBundle mainBundle] pathForResource:@"Bbminor" ofType:@"wav"];
        NSURL *BbminorURL = [[NSURL alloc] initFileURLWithPath:Bbminor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:BbminorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"A#m7b5"]) {
        NSString *Bbm7b5 = [[NSBundle mainBundle] pathForResource:@"Bbm7b5" ofType:@"wav"];
        NSURL *Bbm7b5URL = [[NSURL alloc] initFileURLWithPath:Bbm7b5];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:Bbm7b5URL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Bb"]) {
        NSString *Bbmajor = [[NSBundle mainBundle] pathForResource:@"Bbmajor" ofType:@"wav"];
        NSURL *BbmajorURL = [[NSURL alloc] initFileURLWithPath:Bbmajor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:BbmajorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Bbm"]) {
        NSString *Bbminor = [[NSBundle mainBundle] pathForResource:@"Bbminor" ofType:@"wav"];
        NSURL *BbminorURL = [[NSURL alloc] initFileURLWithPath:Bbminor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:BbminorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Bbm7b5"]) {
        NSString *Bbm7b5 = [[NSBundle mainBundle] pathForResource:@"Bbm7b5" ofType:@"wav"];
        NSURL *Bbm7b5URL = [[NSURL alloc] initFileURLWithPath:Bbm7b5];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:Bbm7b5URL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"B"]) {
        NSString *Bmajor = [[NSBundle mainBundle] pathForResource:@"Bmajor" ofType:@"wav"];
        NSURL *BmajorURL = [[NSURL alloc] initFileURLWithPath:Bmajor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:BmajorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Bm"]) {
        NSString *Bminor = [[NSBundle mainBundle] pathForResource:@"Bminor" ofType:@"wav"];
        NSURL *BminorURL = [[NSURL alloc] initFileURLWithPath:Bminor];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:BminorURL error:nil];
        [self.playChord3 prepareToPlay];}
    
    else if ([self.selectChord3.text isEqualToString:@"Bm7b5"]) {
        NSString *Bm7b5 = [[NSBundle mainBundle] pathForResource:@"Bm7b5" ofType:@"wav"];
        NSURL *Bm7b5URL = [[NSURL alloc] initFileURLWithPath:Bm7b5];
        self.playChord3 = [[AVAudioPlayer alloc] initWithContentsOfURL:Bm7b5URL error:nil];
        [self.playChord3 prepareToPlay];}
    
#pragma mark Load Chord4
    if ([self.selectChord4.text isEqualToString:@"C"]) {
        NSString *Cmajor = [[NSBundle mainBundle] pathForResource:@"Cmajor" ofType:@"wav"];
        NSURL *CmajorURL = [[NSURL alloc] initFileURLWithPath:Cmajor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:CmajorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Cm"]) {
        NSString *Cminor = [[NSBundle mainBundle] pathForResource:@"Cminor" ofType:@"wav"];
        NSURL *CminorURL = [[NSURL alloc] initFileURLWithPath:Cminor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:CminorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Cm7b5"]) {
        NSString *Cm7b5 = [[NSBundle mainBundle] pathForResource:@"Cm7b5" ofType:@"wav"];
        NSURL *Cm7b5URL = [[NSURL alloc] initFileURLWithPath:Cm7b5];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:Cm7b5URL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"C#"]) {
        NSString *Dbmajor = [[NSBundle mainBundle] pathForResource:@"Dbmajor" ofType:@"wav"];
        NSURL *DbmajorURL = [[NSURL alloc] initFileURLWithPath:Dbmajor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:DbmajorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"C#m"]) {
        NSString *Dbminor = [[NSBundle mainBundle] pathForResource:@"Dbminor" ofType:@"wav"];
        NSURL *DbminorURL = [[NSURL alloc] initFileURLWithPath:Dbminor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:DbminorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"C#m7b5"]) {
        NSString *Dbm7b5 = [[NSBundle mainBundle] pathForResource:@"Dbm7b5" ofType:@"wav"];
        NSURL *Dbm7b5URL = [[NSURL alloc] initFileURLWithPath:Dbm7b5];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:Dbm7b5URL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Db"]) {
        NSString *Dbmajor = [[NSBundle mainBundle] pathForResource:@"Dbmajor" ofType:@"wav"];
        NSURL *DbmajorURL = [[NSURL alloc] initFileURLWithPath:Dbmajor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:DbmajorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Dbm"]) {
        NSString *Dbminor = [[NSBundle mainBundle] pathForResource:@"Dbminor" ofType:@"wav"];
        NSURL *DbminorURL = [[NSURL alloc] initFileURLWithPath:Dbminor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:DbminorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Dbm7b5"]) {
        NSString *Dbm7b5 = [[NSBundle mainBundle] pathForResource:@"Dbm7b5" ofType:@"wav"];
        NSURL *Dbm7b5URL = [[NSURL alloc] initFileURLWithPath:Dbm7b5];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:Dbm7b5URL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"D"]) {
        NSString *Dmajor = [[NSBundle mainBundle] pathForResource:@"Dmajor" ofType:@"wav"];
        NSURL *DmajorURL = [[NSURL alloc] initFileURLWithPath:Dmajor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:DmajorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Dm"]) {
        NSString *Dminor = [[NSBundle mainBundle] pathForResource:@"Dminor" ofType:@"wav"];
        NSURL *DminorURL = [[NSURL alloc] initFileURLWithPath:Dminor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:DminorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Dm7b5"]) {
        NSString *Dm7b5 = [[NSBundle mainBundle] pathForResource:@"Dm7b5" ofType:@"wav"];
        NSURL *Dm7b5URL = [[NSURL alloc] initFileURLWithPath:Dm7b5];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:Dm7b5URL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"D#"]) {
        NSString *Ebmajor = [[NSBundle mainBundle] pathForResource:@"Ebmajor" ofType:@"wav"];
        NSURL *EbmajorURL = [[NSURL alloc] initFileURLWithPath:Ebmajor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:EbmajorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"D#m"]) {
        NSString *Ebminor = [[NSBundle mainBundle] pathForResource:@"Ebminor" ofType:@"wav"];
        NSURL *EbminorURL = [[NSURL alloc] initFileURLWithPath:Ebminor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:EbminorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"D#m7b5"]) {
        NSString *Ebm7b5 = [[NSBundle mainBundle] pathForResource:@"Ebm7b5" ofType:@"wav"];
        NSURL *Ebm7b5URL = [[NSURL alloc] initFileURLWithPath:Ebm7b5];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:Ebm7b5URL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Eb"]) {
        NSString *Ebmajor = [[NSBundle mainBundle] pathForResource:@"Ebmajor" ofType:@"wav"];
        NSURL *EbmajorURL = [[NSURL alloc] initFileURLWithPath:Ebmajor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:EbmajorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Ebm"]) {
        NSString *Ebminor = [[NSBundle mainBundle] pathForResource:@"Ebminor" ofType:@"wav"];
        NSURL *EbminorURL = [[NSURL alloc] initFileURLWithPath:Ebminor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:EbminorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Ebm7b5"]) {
        NSString *Ebm7b5 = [[NSBundle mainBundle] pathForResource:@"Ebm7b5" ofType:@"wav"];
        NSURL *Ebm7b5URL = [[NSURL alloc] initFileURLWithPath:Ebm7b5];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:Ebm7b5URL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"E"]) {
        NSString *Emajor = [[NSBundle mainBundle] pathForResource:@"Emajor" ofType:@"wav"];
        NSURL *EmajorURL = [[NSURL alloc] initFileURLWithPath:Emajor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:EmajorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Em"]) {
        NSString *Eminor = [[NSBundle mainBundle] pathForResource:@"Eminor" ofType:@"wav"];
        NSURL *EminorURL = [[NSURL alloc] initFileURLWithPath:Eminor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:EminorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Em7b5"]) {
        NSString *Em7b5 = [[NSBundle mainBundle] pathForResource:@"Em7b5" ofType:@"wav"];
        NSURL *Em7b5URL = [[NSURL alloc] initFileURLWithPath:Em7b5];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:Em7b5URL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"F"]) {
        NSString *Fmajor = [[NSBundle mainBundle] pathForResource:@"Fmajor" ofType:@"wav"];
        NSURL *FmajorURL = [[NSURL alloc] initFileURLWithPath:Fmajor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:FmajorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Fm"]) {
        NSString *Fminor = [[NSBundle mainBundle] pathForResource:@"Fminor" ofType:@"wav"];
        NSURL *FminorURL = [[NSURL alloc] initFileURLWithPath:Fminor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:FminorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Fm7b5"]) {
        NSString *Fm7b5 = [[NSBundle mainBundle] pathForResource:@"Fm7b5" ofType:@"wav"];
        NSURL *Fm7b5URL = [[NSURL alloc] initFileURLWithPath:Fm7b5];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:Fm7b5URL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"F#"]) {
        NSString *Gbmajor = [[NSBundle mainBundle] pathForResource:@"Gbmajor" ofType:@"wav"];
        NSURL *GbmajorURL = [[NSURL alloc] initFileURLWithPath:Gbmajor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:GbmajorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"F#m"]) {
        NSString *Gbminor = [[NSBundle mainBundle] pathForResource:@"Gbminor" ofType:@"wav"];
        NSURL *GbminorURL = [[NSURL alloc] initFileURLWithPath:Gbminor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:GbminorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"F#m7b5"]) {
        NSString *Gbm7b5 = [[NSBundle mainBundle] pathForResource:@"Gbm7b5" ofType:@"wav"];
        NSURL *Gbm7b5URL = [[NSURL alloc] initFileURLWithPath:Gbm7b5];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:Gbm7b5URL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Gb"]) {
        NSString *Gbmajor = [[NSBundle mainBundle] pathForResource:@"Gbmajor" ofType:@"wav"];
        NSURL *GbmajorURL = [[NSURL alloc] initFileURLWithPath:Gbmajor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:GbmajorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Gbm"]) {
        NSString *Gbminor = [[NSBundle mainBundle] pathForResource:@"Gbminor" ofType:@"wav"];
        NSURL *GbminorURL = [[NSURL alloc] initFileURLWithPath:Gbminor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:GbminorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Gbm7b5"]) {
        NSString *Gbm7b5 = [[NSBundle mainBundle] pathForResource:@"Gbm7b5" ofType:@"wav"];
        NSURL *Gbm7b5URL = [[NSURL alloc] initFileURLWithPath:Gbm7b5];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:Gbm7b5URL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"G"]) {
        NSString *Gmajor = [[NSBundle mainBundle] pathForResource:@"Gmajor" ofType:@"wav"];
        NSURL *GmajorURL = [[NSURL alloc] initFileURLWithPath:Gmajor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:GmajorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Gm"]) {
        NSString *Gminor = [[NSBundle mainBundle] pathForResource:@"Gminor" ofType:@"wav"];
        NSURL *GminorURL = [[NSURL alloc] initFileURLWithPath:Gminor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:GminorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Gm7b5"]) {
        NSString *Gm7b5 = [[NSBundle mainBundle] pathForResource:@"Gm7b5" ofType:@"wav"];
        NSURL *Gm7b5URL = [[NSURL alloc] initFileURLWithPath:Gm7b5];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:Gm7b5URL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"G#"]) {
        NSString *Abmajor = [[NSBundle mainBundle] pathForResource:@"Abmajor" ofType:@"wav"];
        NSURL *AbmajorURL = [[NSURL alloc] initFileURLWithPath:Abmajor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:AbmajorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"G#m"]) {
        NSString *Abminor = [[NSBundle mainBundle] pathForResource:@"Abminor" ofType:@"wav"];
        NSURL *AbminorURL = [[NSURL alloc] initFileURLWithPath:Abminor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:AbminorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"G#m7b5"]) {
        NSString *Abm7b5 = [[NSBundle mainBundle] pathForResource:@"Abm7b5" ofType:@"wav"];
        NSURL *Abm7b5URL = [[NSURL alloc] initFileURLWithPath:Abm7b5];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:Abm7b5URL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Ab"]) {
        NSString *Abmajor = [[NSBundle mainBundle] pathForResource:@"Abmajor" ofType:@"wav"];
        NSURL *AbmajorURL = [[NSURL alloc] initFileURLWithPath:Abmajor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:AbmajorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Abm"]) {
        NSString *Abminor = [[NSBundle mainBundle] pathForResource:@"Abminor" ofType:@"wav"];
        NSURL *AbminorURL = [[NSURL alloc] initFileURLWithPath:Abminor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:AbminorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Abm7b5"]) {
        NSString *Abm7b5 = [[NSBundle mainBundle] pathForResource:@"Abm7b5" ofType:@"wav"];
        NSURL *Abm7b5URL = [[NSURL alloc] initFileURLWithPath:Abm7b5];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:Abm7b5URL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"A"]) {
        NSString *Amajor = [[NSBundle mainBundle] pathForResource:@"Amajor" ofType:@"wav"];
        NSURL *AmajorURL = [[NSURL alloc] initFileURLWithPath:Amajor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:AmajorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Am"]) {
        NSString *Aminor = [[NSBundle mainBundle] pathForResource:@"Aminor" ofType:@"wav"];
        NSURL *AminorURL = [[NSURL alloc] initFileURLWithPath:Aminor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:AminorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Am7b5"]) {
        NSString *Am7b5 = [[NSBundle mainBundle] pathForResource:@"Am7b5" ofType:@"wav"];
        NSURL *Am7b5URL = [[NSURL alloc] initFileURLWithPath:Am7b5];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:Am7b5URL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"A#"]) {
        NSString *Bbmajor = [[NSBundle mainBundle] pathForResource:@"Bbmajor" ofType:@"wav"];
        NSURL *BbmajorURL = [[NSURL alloc] initFileURLWithPath:Bbmajor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:BbmajorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"A#m"]) {
        NSString *Bbminor = [[NSBundle mainBundle] pathForResource:@"Bbminor" ofType:@"wav"];
        NSURL *BbminorURL = [[NSURL alloc] initFileURLWithPath:Bbminor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:BbminorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"A#m7b5"]) {
        NSString *Bbm7b5 = [[NSBundle mainBundle] pathForResource:@"Bbm7b5" ofType:@"wav"];
        NSURL *Bbm7b5URL = [[NSURL alloc] initFileURLWithPath:Bbm7b5];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:Bbm7b5URL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Bb"]) {
        NSString *Bbmajor = [[NSBundle mainBundle] pathForResource:@"Bbmajor" ofType:@"wav"];
        NSURL *BbmajorURL = [[NSURL alloc] initFileURLWithPath:Bbmajor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:BbmajorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Bbm"]) {
        NSString *Bbminor = [[NSBundle mainBundle] pathForResource:@"Bbminor" ofType:@"wav"];
        NSURL *BbminorURL = [[NSURL alloc] initFileURLWithPath:Bbminor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:BbminorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Bbm7b5"]) {
        NSString *Bbm7b5 = [[NSBundle mainBundle] pathForResource:@"Bbm7b5" ofType:@"wav"];
        NSURL *Bbm7b5URL = [[NSURL alloc] initFileURLWithPath:Bbm7b5];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:Bbm7b5URL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"B"]) {
        NSString *Bmajor = [[NSBundle mainBundle] pathForResource:@"Bmajor" ofType:@"wav"];
        NSURL *BmajorURL = [[NSURL alloc] initFileURLWithPath:Bmajor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:BmajorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Bm"]) {
        NSString *Bminor = [[NSBundle mainBundle] pathForResource:@"Bminor" ofType:@"wav"];
        NSURL *BminorURL = [[NSURL alloc] initFileURLWithPath:Bminor];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:BminorURL error:nil];
        [self.playChord4 prepareToPlay];}
    
    else if ([self.selectChord4.text isEqualToString:@"Bm7b5"]) {
        NSString *Bm7b5 = [[NSBundle mainBundle] pathForResource:@"Bm7b5" ofType:@"wav"];
        NSURL *Bm7b5URL = [[NSURL alloc] initFileURLWithPath:Bm7b5];
        self.playChord4 = [[AVAudioPlayer alloc] initWithContentsOfURL:Bm7b5URL error:nil];
        [self.playChord4 prepareToPlay];}
    
    
    //playback the loaded chord
    if (self.selectChord1.tag == self.chordLoop){
        [self.playChord1 play];
        if ([self.selectChord1.text  isEqual: @"-"]) { //timer continues to fire but the respective AVAudioPlayer stops playing
            [self.playChord1 stop];
        }
    }
    if (self.selectChord2.tag == self.chordLoop){
        [self.playChord2 play];
        if ([self.selectChord2.text  isEqual: @"-"]) {
            [self.playChord2 stop];
        }
    }
    if (self.selectChord3.tag == self.chordLoop){
        [self.playChord3 play];
        if ([self.selectChord3.text  isEqual: @"-"]) {
            [self.playChord3 stop];
        }
    }
    if (self.selectChord4.tag == self.chordLoop){
        [self.playChord4 play];
        if ([self.selectChord4.text  isEqual: @"-"]) {
            [self.playChord4 stop];
        }
    }
    
    self.chordLoop++;
    if (self.chordLoop > 3)
        self.chordLoop = 0;
    

}
                  

@end
