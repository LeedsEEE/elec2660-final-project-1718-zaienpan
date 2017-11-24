//
//  AudioEngine.h
//  Writers Jam
//
//  Created by ZaiEn on 24/11/2017.
//  Copyright © 2017 University of Leeds. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface AudioEngine : NSObject
{
    
}

+ (AudioEngine *) sharedInstance;

//

@property (nonatomic,copy) NSString *chord1;
@property (nonatomic,copy) NSString *chord2;
@property (nonatomic,copy) NSString *chord3;
@property (nonatomic,copy) NSString *chord4;


@end
