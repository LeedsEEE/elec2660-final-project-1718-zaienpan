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
        [self.selectedKey setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected key related objects to the view controller.
    ViewController *tempViewController = [segue destinationViewController];
    if ([segue.identifier isEqualToString:@"back"]) {
    tempViewController.keyToPass = self.selectedKey.text;
        tempViewController.keySignatureToPass = self.keySignature;
        
    }
    
}


- (IBAction)backButtonPressed:(UIButton *)sender {
}

//switch to change the text of the key selection from its major to its relative minor
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

#pragma mark Selecting the Key


- (IBAction)selectedC:(UIButton *)sender {
    if (self.majorMinorSwitch.on) {
        self.selectedKey.text = @"C major";
    } else {
        self.selectedKey.text = @"A minor";
    }
        self.keySignature = self.setKey.Cmajor; //sets the key signature, which will be passed to main view and decide which diatonic chords are shown in the pickerView
}
- (IBAction)selectedDb:(UIButton *)sender {
    if (self.majorMinorSwitch.on) {
        self.selectedKey.text = @"Db major";
    } else {
        self.selectedKey.text = @"Bb minor";
    }
        self.keySignature = self.setKey.Dbmajor;
}
- (IBAction)selectedD:(UIButton *)sender {
    if (self.majorMinorSwitch.on) {
        self.selectedKey.text = @"D major";
    } else {
        self.selectedKey.text = @"B minor";
    }
        self.keySignature = self.setKey.Dmajor;
}
- (IBAction)selectedEb:(UIButton *)sender {
    if (self.majorMinorSwitch.on) {
        self.selectedKey.text = @"Eb major";
    } else {
        self.selectedKey.text = @"C minor";
    }
        self.keySignature = self.setKey.Ebmajor;
}
- (IBAction)selectedE:(UIButton *)sender {
    if (self.majorMinorSwitch.on) {
        self.selectedKey.text = @"E major";
    } else {
        self.selectedKey.text = @"C# minor";
    }
        self.keySignature = self.setKey.Emajor;
}
- (IBAction)selectedF:(UIButton *)sender {
    if (self.majorMinorSwitch.on) {
        self.selectedKey.text = @"F major";
    } else {
        self.selectedKey.text = @"D minor";
    }
        self.keySignature = self.setKey.Fmajor;
}
- (IBAction)selectedGb:(UIButton *)sender {
    if (self.majorMinorSwitch.on) {
        self.selectedKey.text = @"Gb major";
    } else {
        self.selectedKey.text = @"Eb minor";
    }
        self.keySignature = self.setKey.Gbmajor;
}
- (IBAction)selectedG:(UIButton *)sender {
    if (self.majorMinorSwitch.on) {
        self.selectedKey.text = @"G major";
    } else {
        self.selectedKey.text = @"E minor";
    }
        self.keySignature = self.setKey.Gmajor;
}
- (IBAction)selectedAb:(UIButton *)sender {
    if (self.majorMinorSwitch.on) {
        self.selectedKey.text = @"Ab major";
    } else {
        self.selectedKey.text = @"F minor";
    }
        self.keySignature = self.setKey.Abmajor;
}
- (IBAction)selectedA:(UIButton *)sender {
    if (self.majorMinorSwitch.on) {
        self.selectedKey.text = @"A major";
    } else {
        self.selectedKey.text = @"F# minor";
    }
        self.keySignature = self.setKey.Amajor;
}
- (IBAction)selectedBb:(UIButton *)sender {
    if (self.majorMinorSwitch.on) {
        self.selectedKey.text = @"Bb major";
    } else {
        self.selectedKey.text = @"G minor";
    }
        self.keySignature = self.setKey.Bbmajor;
}
- (IBAction)selectedB:(UIButton *)sender {
    if (self.majorMinorSwitch.on) {
        self.selectedKey.text = @"B major";
    } else {
        self.selectedKey.text = @"G# minor";
    }
        self.keySignature = self.setKey.Bmajor;
    
    
}

- (IBAction)selectedNoKey:(UIButton *)sender {
    self.selectedKey.text = @"Free Mode";
    self.keySignature = self.setKey.AllChords; //sets the key signature to nothing, no restrictions on chords shown, which will allow for all the chords available

}
@end
