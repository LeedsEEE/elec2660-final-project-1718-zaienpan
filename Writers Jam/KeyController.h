//
//  KeyController.h
//  Writers Jam
//
//  Created by Zai'En Pan [el16zep] on 21/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ChordLibrary.h"
#import "ViewController.h"



@interface KeyController : UIViewController

- (IBAction)backButtonPressed:(UIButton *)sender;

@property ChordLibrary *setKey;
@property (strong, nonatomic) NSArray *keySignature;
@property (strong, nonatomic) IBOutlet UILabel *selectedKey;



- (IBAction)selectedC:(UIButton *)sender;
- (IBAction)selectedDb:(UIButton *)sender;
- (IBAction)selectedD:(UIButton *)sender;
- (IBAction)selectedEb:(UIButton *)sender;
- (IBAction)selectedE:(UIButton *)sender;
- (IBAction)selectedF:(UIButton *)sender;
- (IBAction)selectedGb:(UIButton *)sender;
- (IBAction)selectedG:(UIButton *)sender;
- (IBAction)selectedAb:(UIButton *)sender;
- (IBAction)selectedA:(UIButton *)sender;
- (IBAction)selectedBb:(UIButton *)sender;
- (IBAction)selectedB:(UIButton *)sender;






@end
