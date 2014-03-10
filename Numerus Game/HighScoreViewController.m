//
//  HighScoreViewController.m
//  Numerus Game
//
//  Created by Ömer Hakan Bilici on 10.03.2014.
//  Copyright (c) 2014 8CookIn. All rights reserved.
//

#import "HighScoreViewController.h"

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

@end
