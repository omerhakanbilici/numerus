//
//  MultiPlayGameViewController.h
//  Numerus Game
//
//  Created by Ömer Hakan Bilici on 11.03.2014.
//  Copyright (c) 2014 8CookIn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultiPlayGameViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *lblCongratulations;
@property (weak, nonatomic) IBOutlet UITextField *txtNumberPrediction;
@property (weak, nonatomic) IBOutlet UIButton *btnSubmitPrediction;
@property (weak, nonatomic) IBOutlet UILabel *lblPlayerTurn;

@property (nonatomic, strong) NSString *difficulty;

- (IBAction)predictionResult:(id)sender;

@end
