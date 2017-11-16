//
//  ViewController.h
//  Writers Jam
//
//  Created by ZaiEn on 15/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>


@property (weak, nonatomic) IBOutlet UIPickerView *chordPicker;
@property (strong, nonatomic) NSArray *rootArray;
@property (strong, nonatomic) NSArray *typeArray;

@property (strong, nonatomic) IBOutlet UITextField *Chord1;
@property (strong, nonatomic) IBOutlet UITextField *Chord2;
@property (strong, nonatomic) IBOutlet UITextField *Chord3;
@property (strong, nonatomic) IBOutlet UITextField *Chord4;





@end

