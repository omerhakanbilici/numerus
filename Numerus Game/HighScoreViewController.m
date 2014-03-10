//
//  HighScoreViewController.m
//  Numerus Game
//
//  Created by Ömer Hakan Bilici on 10.03.2014.
//  Copyright (c) 2014 8CookIn. All rights reserved.
//

#import "HighScoreViewController.h"
#import "UIView+Toast.h"

@interface HighScoreViewController ()

@end

@implementation HighScoreViewController

@synthesize lblHighScore;

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
    
    NSNumber *highScore = [[NSUserDefaults standardUserDefaults] objectForKey:@"HighScore"];
    
    if ([highScore intValue] == 1043) {
        [lblHighScore setText:[NSString stringWithFormat:@"Score: -"]];
    }
    else{
        [lblHighScore setText:[NSString stringWithFormat:@"Score: %@", highScore]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnResetScore:(id)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:1043 forKey:@"HighScore"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Toast with duration, title, and position
    NSString *toastDesc = @"Successfully removed score history.";
    [self.view makeToast:toastDesc
                duration:2.0
                position:[NSValue valueWithCGPoint:CGPointMake(160, 300)]];
    
    // Redirecting Home Page with 2 second delay
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        //Redirect to root view
        [self.navigationController popToRootViewControllerAnimated:YES];
    });
}
@end
