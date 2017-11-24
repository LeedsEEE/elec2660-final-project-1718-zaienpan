//
//  KeyController.m
//  Writers Jam
//
//  Created by Zai'En Pan [el16zep] on 21/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import "KeyController.h"

@interface KeyController ()

@end

@implementation KeyController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

        self.setKey = [[ChordLibrary alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    ViewController *tempViewController = [segue destinationViewController];
    if ([segue.identifier isEqualToString:@"back"]) {
    tempViewController.keyToPass = self.selectedKey.text;
        tempViewController.keySignatureToPass = self.keySignature;
        
    }
    
}


- (IBAction)backButtonPressed:(UIButton *)sender {
}


- (IBAction)majorMinorSwitch:(UISwitch *)sender {
    if (sender.on){
        self.majorOrMinor.text = @"Major";
        [self.C setTitle:@"C" forState:UIControlStateNormal];
        [self.Db setTitle:@"Db" forState:UIControlStateNormal];
        [self.D setTitle:@"D" forState:UIControlStateNormal];
        [self.Eb setTitle:@"Eb" forState:UIControlStateNormal];
        [self.E setTitle:@"E" forState:UIControlStateNormal];
        [self.F setTitle:@"F" forState:UIControlStateNormal];
        [self.Gb setTitle:@"Gb" forState:UIControlStateNormal];
        [self.G setTitle:@"G" forState:UIControlStateNormal];
        [self.Ab setTitle:@"Ab" forState:UIControlStateNormal];
        [self.A setTitle:@"A" forState:UIControlStateNormal];
        [self.Bb setTitle:@"Bb" forState:UIControlStateNormal];
        [self.B setTitle:@"B" forState:UIControlStateNormal];

    }
    else { self.majorOrMinor.text = @"Minor";
        [self.C setTitle:@"Am" forState:UIControlStateNormal];
        [self.Db setTitle:@"Bbm" forState:UIControlStateNormal];
        [self.D setTitle:@"Bm" forState:UIControlStateNormal];
        [self.Eb setTitle:@"Cm" forState:UIControlStateNormal];
        [self.E setTitle:@"C#m" forState:UIControlStateNormal];
        [self.F setTitle:@"Dm" forState:UIControlStateNormal];
        [self.Gb setTitle:@"Ebm" forState:UIControlStateNormal];
        [self.G setTitle:@"Em" forState:UIControlStateNormal];
        [self.Ab setTitle:@"Fm" forState:UIControlStateNormal];
        [self.A setTitle:@"F#m" forState:UIControlStateNormal];
        [self.Bb setTitle:@"Gm" forState:UIControlStateNormal];
        [self.B setTitle:@"G#m" forState:UIControlStateNormal];

        
        
    }
}

- (IBAction)selectedC:(UIButton *)sender {
        self.selectedKey.text = @"C";
        self.keySignature = self.setKey.Cmajor;
}
- (IBAction)selectedDb:(UIButton *)sender {
        self.selectedKey.text = @"Db";
        self.keySignature = self.setKey.Dbmajor;
}
- (IBAction)selectedD:(UIButton *)sender {
        self.selectedKey.text = @"D";
        self.keySignature = self.setKey.Dmajor;
}
- (IBAction)selectedEb:(UIButton *)sender {
        self.selectedKey.text = @"Eb";
        self.keySignature = self.setKey.Ebmajor;
}
- (IBAction)selectedE:(UIButton *)sender {
        self.selectedKey.text = @"E";
        self.keySignature = self.setKey.Emajor;
}
- (IBAction)selectedF:(UIButton *)sender {
        self.selectedKey.text = @"F";
        self.keySignature = self.setKey.Fmajor;
}
- (IBAction)selectedGb:(UIButton *)sender {
        self.selectedKey.text = @"Gb";
        self.keySignature = self.setKey.Gbmajor;
}
- (IBAction)selectedG:(UIButton *)sender {
        self.selectedKey.text = @"G";
        self.keySignature = self.setKey.Gmajor;
}
- (IBAction)selectedAb:(UIButton *)sender {
        self.selectedKey.text = @"Ab";
        self.keySignature = self.setKey.Abmajor;
}
- (IBAction)selectedA:(UIButton *)sender {
        self.selectedKey.text = @"A";
        self.keySignature = self.setKey.Amajor;
}
- (IBAction)selectedBb:(UIButton *)sender {
        self.selectedKey.text = @"Bb";
        self.keySignature = self.setKey.Bbmajor;
}
- (IBAction)selectedB:(UIButton *)sender {
        self.selectedKey.text = @"B";
        self.keySignature = self.setKey.Bmajor;
    
    
}

- (IBAction)selectedNoKey:(UIButton *)sender {
    self.selectedKey.text = @"Free Mode";
    self.keySignature = self.setKey.AllChords;
}
@end
