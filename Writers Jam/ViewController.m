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
    
    
    self.Cmajor  = [[NSArray alloc] initWithObjects:@"C",@"Dm",@"Em",@"F",@"G",@"Am",@"Bm7b5", nil];



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
    
    return [self.Cmajor count];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component{

        return [self.Cmajor objectAtIndex:row];
    
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component{
    
    NSLog(@"Selected Row %ld", (long)row);
    
    //update each textfield with pickerview input
    if (pickerView.tag == 1){
        self.selectChord1.text = _Cmajor[row];
    } else if (pickerView.tag == 2){
        self.selectChord2.text = _Cmajor[row];
    } else if (pickerView.tag == 3){
        self.selectChord3.text = _Cmajor[row];
    } else if (pickerView.tag == 4){
        self.selectChord4.text = _Cmajor[row];
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

- (IBAction)randomPressed:(UIButton *)sender {
    NSUInteger random = arc4random_uniform(_Cmajor.count);
    NSUInteger random2 = arc4random_uniform(_Cmajor.count);
    NSUInteger random3 = arc4random_uniform(_Cmajor.count);
    NSUInteger random4 = arc4random_uniform(_Cmajor.count);
    [_chordPicker selectRow:random inComponent:0 animated:YES];

    self.selectChord1.text = _Cmajor[random];
    self.selectChord2.text = _Cmajor[random2];
    self.selectChord3.text = _Cmajor[random3];
    self.selectChord4.text = _Cmajor[random4];
    }

- (IBAction)didPressPlay:(UIButton *)sender {
    NSLog(@"Pressed Play %ld", sender.tag);
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:60.0/self.BPM target:self selector:@selector(timerFire:) userInfo:nil repeats:YES];
}
                
- (void) timerFire:(NSTimer *)timer {
    NSLog(@"Timer Fire! chord %ld", (long)self.chordLoop);
    
    self.selectChord1.tag = 0;
    self.selectChord2.tag = 1;
    self.selectChord3.tag = 2;
    self.selectChord4.tag = 3;
    
    if (self.selectChord1.tag == self.chordLoop){
                self.selectChord1.backgroundColor = [UIColor orangeColor];
            } else { self.selectChord1.backgroundColor = [UIColor whiteColor];
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
    
    
    

    
    
    self.chordLoop++;
    if (self.chordLoop > 3)
        self.chordLoop = 0;
}

- (void) initBackgroundFlash {
    for (UITextField *textField in self.chordFields) {
        textField.backgroundColor =  [UIColor whiteColor];
    }
}
                  
                  

- (void) setupAudioPlayers {
    NSLog(@"Setup audio player path");
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Cmajor" ofType:@"wav"];
    NSURL *fileURL = [[NSURL alloc] initFileURLWithPath:filePath];
    
    self.trackOne = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:nil];
    [self.trackOne prepareToPlay];
}

@end
