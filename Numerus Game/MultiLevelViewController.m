//
//  MultiLevelViewController.m
//  Numerus Game
//
//  Created by Ömer Hakan Bilici on 11.03.2014.
//  Copyright (c) 2014 8CookIn. All rights reserved.
//

#import "MultiLevelViewController.h"
#import "PlayGameViewController.h"

@interface MultiLevelViewController ()

@end

@implementation MultiLevelViewController

@synthesize levelList;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //set backbutton text to blank
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStyleBordered target:nil action:nil];
    self.navigationItem.backBarButtonItem = backButton;
    
    self.levelList = [[NSMutableArray alloc]initWithObjects:@"Easy", @"Medium", @"Hard", @"Impossible", nil];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [levelList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MultiLevelCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self sectorForRow:indexPath.row];
    
    return cell;
}

- (NSString *)sectorForRow:(NSUInteger)row
{
    return [self.levelList[row] description];
}

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"TwoLevelToPlaySegue"])
    {
        PlayGameViewController *pgvc = [segue destinationViewController];
        
        
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        
        NSString* selectedLevel=[self.levelList objectAtIndex:path.row];
        [pgvc setDifficulty:selectedLevel];
    }
}



@end
