//
//  PlayGameViewController.h
//  Numerus Game
//
//  Created by Ömer Hakan Bilici on 8.03.2014.
//  Copyright (c) 2014 8CookIn. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayGameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblCongratulations;
@property (weak, nonatomic) IBOutlet UITextField *txtNumberPrediction;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmitPrediction;

@property (nonatomic, strong) AVAudioPlayer *audioWalk;

@property (nonatomic, strong) NSString *difficulty;

- (IBAction)predictionResult:(id)sender;

@end
