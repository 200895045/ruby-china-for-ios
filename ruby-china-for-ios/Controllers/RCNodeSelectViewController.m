//
//  RCNodeSelectViewController.m
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-17.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import "RCNodeSelectViewController.h"
#import "RCNode.h"

@interface RCNodeSelectViewController ()

@end

@implementation RCNodeSelectViewController
@synthesize selectedNode;

static RCNodeSelectViewController *_shared;

+ (RCNodeSelectViewController *) shared {
    if (!_shared) {
        _shared = [[super alloc] initWithStyle:UITableViewStylePlain];
    }
    return _shared;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.frame = CGRectMake(0, 100, self.view.frame.size.width, self.view.frame.size.height - 100);

    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [RCNode findAll:^(NSArray *objects, NSError *error) {
        if (!error) {
            nodes = objects;
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            [self.tableView reloadData];
        }
    }];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [nodes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    RCNode *node = [nodes objectAtIndex:indexPath.row];
    // Configure the cell...
    cell.textLabel.text = node.name;
    
    return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedNode = [nodes objectAtIndex:indexPath.row];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
