//
//  PlayGameViewController.m
//  Numerus Game
//
//  Created by Ömer Hakan Bilici on 8.03.2014.
//  Copyright (c) 2014 8CookIn. All rights reserved.
//

#import "PlayGameViewController.h"
#import "UIView+Toast.h"

#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface PlayGameViewController ()

@end

@implementation PlayGameViewController

@synthesize lblCongratulations;
@synthesize txtNumberPrediction;
@synthesize difficulty;
@synthesize audioWalk;

int randomNumberWithLevel;
int score;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Hide Congratulations label from view
    [lblCongratulations setHidden:TRUE];
    
    // Set title
    self.title = difficulty;
    
    // Set score to 1
    score = 1;
    
    [self randomNumberGenerator:difficulty];
    
    // Play audio even if lock screen is on, the with options allows audio from other applications to play without interruption
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback withOptions:AVAudioSessionCategoryOptionMixWithOthers error: nil];
    [[AVAudioSession sharedInstance] setActive: YES error:nil];
    
    // Walk Audio File
    NSString *soundFile2 = [[NSBundle mainBundle] pathForResource:@"numerus" ofType:@"mp3"];
    audioWalk = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:soundFile2] error:nil];
    
    // Load the audio into memory
    [audioWalk prepareToPlay];
    
    // Permit the timer to run in the background
    UIBackgroundTaskIdentifier bgTask = 0;
    UIApplication  *app = [UIApplication sharedApplication];
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        [app endBackgroundTask:bgTask];
    }];
    
    // Prevent the application from going to sleep while it is running
    [UIApplication sharedApplication].idleTimerDisabled = YES;
    
    // Starts receiving remote control events and is the first responder
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    [self becomeFirstResponder];
    
    // Plays audio infinite
    audioWalk.numberOfLoops = -1;
    [audioWalk play];

}

- (IBAction)predictionResult:(id)sender {
    
    int prediction = [txtNumberPrediction.text intValue];
    
    if (prediction != randomNumberWithLevel) {
        score++;
    }
    
    if (prediction == randomNumberWithLevel) {

        // Show Congratulations label from view
        [lblCongratulations setHidden:FALSE];
        
        // Hide keyboard
        [self.view endEditing:YES];
        
        // Toast with duration, title, and position
        NSString *toastDesc = [NSString stringWithFormat:@"Congratulations!\n \"%d\" is true\n Redirecting Home Page", prediction];
        [self.view makeToast:toastDesc
                    duration:4.0
                    position:[NSValue valueWithCGPoint:CGPointMake(160, 300)]];
        
        // Set high score if it is best
        NSNumber *highScore = [[NSUserDefaults standardUserDefaults] objectForKey:@"HighScore"];
        if (score < [highScore intValue]) {
            [[NSUserDefaults standardUserDefaults] setInteger:score forKey:@"HighScore"];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        // Redirecting Home Page with 4 second delay
        double delayInSeconds = 5.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            
            //Redirect to root view
            [self.navigationController popToRootViewControllerAnimated:YES];
        });
        
//        UIViewController *prevVC = [self.navigationController.viewControllers objectAtIndex:0];
//        [self.navigationController popToViewController:prevVC animated:YES];
    }
    if (prediction < randomNumberWithLevel) {
        
        // toast with duration, title, and position
        [self.view makeToast:@"UP!!!"
                    duration:2.0
                    position:[NSValue valueWithCGPoint:CGPointMake(160, 5)]
                       title:@"Hint:"];
    }
    if (prediction > randomNumberWithLevel) {
        
        // toast with duration, title, and position
        [self.view makeToast:@"DOWN!!!"
                    duration:2.0
                    position:[NSValue valueWithCGPoint:CGPointMake(160, 5)]
                       title:@"Hint:"];
    }
}

- (int)randomNumberGenerator:(NSString*)level{
    //Why obj-c has no switch case with string
    if ([level isEqualToString:@"Easy"]) {
        randomNumberWithLevel = arc4random()%10;
    }
    else if ([level isEqualToString:@"Medium"]) {
        randomNumberWithLevel = arc4random()%100;
    }
    else if ([level isEqualToString:@"Hard"]) {
        randomNumberWithLevel = arc4random()%1000;
    }
    else if ([level isEqualToString:@"Impossible"]) {
        randomNumberWithLevel = arc4random()%10000;
    }
    else {
        randomNumberWithLevel = 0;
    }
//    randomNumberWithLevel = arc4random();
    return randomNumberWithLevel;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
