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
    
    self.Cmajor  = [[NSArray alloc] initWithObjects:@"C",@"Dm",@"Em",@"F",@"G",@"Am",@"Bm7b5", nil];



    //using UIPickerView as input for the chords
    UIPickerView *chordPicker = [[UIPickerView alloc] init];
    
    chordPicker.dataSource = self;
    chordPicker.delegate = self;
    
    self.selectChord1.inputView = chordPicker;
    self.selectChord2.inputView = chordPicker;
    self.selectChord3.inputView = chordPicker;
    self.selectChord4.inputView = chordPicker;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component{

        return [self.Cmajor objectAtIndex:row];
    
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component{
    
    NSLog(@"Selected Row %d", row);

    {
            self.selectChord1.text = _Cmajor[row];
    }
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 1;

}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    
        return [self.Cmajor count];

}

@end
