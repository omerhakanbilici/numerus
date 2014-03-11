//
//  MultiPlayGameViewController.m
//  Numerus Game
//
//  Created by Ömer Hakan Bilici on 11.03.2014.
//  Copyright (c) 2014 8CookIn. All rights reserved.
//

#import "MultiPlayGameViewController.h"
#import "UIView+Toast.h"

@interface MultiPlayGameViewController ()

@end

@implementation MultiPlayGameViewController

@synthesize lblCongratulations;
@synthesize txtNumberPrediction;
@synthesize lblPlayerTurn;
@synthesize difficulty;

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
    
}

- (IBAction)predictionResult:(id)sender {
    
    int prediction = [txtNumberPrediction.text intValue];
    
    lblPlayerTurn.text = [NSString stringWithFormat:@"%d. Player Turn", (score%2)+1];
    
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
