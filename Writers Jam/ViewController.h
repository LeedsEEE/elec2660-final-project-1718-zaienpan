//
//  ViewController.h
//  Writers Jam
//
//  Created by ZaiEn on 15/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChordLibrary.h"

@interface ViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>


@property (strong, nonatomic) IBOutlet UIPickerView *chordPicker;
@property (strong, nonatomic) NSArray *Cmajor;
@property (strong, nonatomic) NSString *setKey;


@property (strong, nonatomic) IBOutlet UITextField *selectChord1;
@property (strong, nonatomic) IBOutlet UITextField *selectChord2;
@property (strong, nonatomic) IBOutlet UITextField *selectChord3;
@property (strong, nonatomic) IBOutlet UITextField *selectChord4;





@end

