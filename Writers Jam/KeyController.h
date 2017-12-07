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
@property (strong, nonatomic) IBOutlet UILabel *majorOrMinor;



- (IBAction)majorMinorSwitch:(UISwitch *)sender;
@property (strong, nonatomic) IBOutlet UISwitch *majorMinorSwitch;


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
- (IBAction)selectedNoKey:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIButton *C;
@property (strong, nonatomic) IBOutlet UIButton *Db;
@property (strong, nonatomic) IBOutlet UIButton *D;
@property (strong, nonatomic) IBOutlet UIButton *Eb;
@property (strong, nonatomic) IBOutlet UIButton *E;
@property (strong, nonatomic) IBOutlet UIButton *F;
@property (strong, nonatomic) IBOutlet UIButton *Gb;
@property (strong, nonatomic) IBOutlet UIButton *G;
@property (strong, nonatomic) IBOutlet UIButton *Ab;
@property (strong, nonatomic) IBOutlet UIButton *A;
@property (strong, nonatomic) IBOutlet UIButton *Bb;
@property (strong, nonatomic) IBOutlet UIButton *B;





@end
