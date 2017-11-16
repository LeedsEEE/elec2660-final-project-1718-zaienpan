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
    
    self.rootArray  = [[NSArray alloc] initWithObjects:@"C",@"Db",@"D",@"Eb",@"E",@"F",@"Gb",@"G",@"Ab",@"A",@"Bb",@"B", nil];
    self.typeArray  = [[NSArray alloc] initWithObjects:@"maj",@"min",@"dom",@"dim", nil];


    //using UIPickerView as input for the chords
    UIPickerView *chordPicker = [[UIPickerView alloc] init];
    
    chordPicker.dataSource = self;
    chordPicker.delegate = self;
    
    self.Chord1.inputView = chordPicker;
    self.Chord2.inputView = chordPicker;
    self.Chord3.inputView = chordPicker;
    self.Chord4.inputView = chordPicker;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component{
    if (component == 0){
        return [self.rootArray objectAtIndex:row];
    }
    else {
        return [self.typeArray objectAtIndex:row];
    }
    
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component{
    
    NSLog(@"Selected Row %d", row);
    NSInteger firstComponentRow = [self.chordPicker selectedRowInComponent:0];
    NSInteger secondComponentRow = [self.chordPicker selectedRowInComponent:1];
    
    NSString *str = [NSString stringWithFormat:@"%@,%@",[_rootArray objectAtIndex:firstComponentRow],[_typeArray objectAtIndex:secondComponentRow]];
    //NSString *firstComponentRow = [NSString stringWithFormat:@"%ld", (long)row];

self.Chord1.text = str;
    
    
    switch(firstComponentRow)
    
    {
        case 0:
            self.Chord1.text = @"C";
            break;
        case 1:
            self.Chord1.text = @"Db";
            break;
        case 2:
            self.Chord1.text = @"D";
            break;
        case 3:
            self.Chord1.text = @"Eb";
            break;
        case 4:
            self.Chord1.text = @"E";
            break;
        case 5:
            self.Chord1.text = @"F";
            break;
        case 6:
            self.Chord1.text = @"Gb";
            break;
        case 7:
            self.Chord1.text = @"G";
            break;
        case 8:
            self.Chord1.text = @"Ab";
            break;
        case 9:
            self.Chord1.text = @"A";
            break;
        case 10:
            self.Chord1.text = @"Bb";
            break;
        case 11:
            self.Chord1.text = @"B";
            break;
    }
    
    switch(secondComponentRow)
    
    {
        case 0:
            self.Chord1.text = @"maj";
            break;
        case 1:
            self.Chord1.text = @"min";
            break;
        case 2:
            self.Chord1.text = @"dim";
            break;
        case 3:
            self.Chord1.text = @"dom";
            break;
        }
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{

    return 2;

}

- (NSInteger)pickerView:(UIPickerView *)pickerView
numberOfRowsInComponent:(NSInteger)component{
    
    if (component == 0)
    {
        return [self.rootArray count];
    } else {
        return [self.typeArray count];
    }
}

@end
