//
//  RCNewTopicViewController.m
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-17.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import "RCNewTopicViewController.h"
#import "RCViewController.h"
#import "RCTableView.h"


@implementation RCNewTopicViewController

static RCNewTopicViewController *_shared;


+ (RCNewTopicViewController *) shared {
    if (!_shared) {
        _shared = [[RCNewTopicViewController alloc] init];
    }
    return _shared;
}

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
        topicForm = [[RCTopicForm alloc] init:self.view];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

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
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [topicForm.fields count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    UITextField *field              = [topicForm.fields objectAtIndex:indexPath.row];
    if (indexPath.row == 2) {
        field.frame                     = CGRectMake(0, 0, cell.bounds.size.width, 400);
    }
    else {
       field.frame                     = CGRectInset(cell.bounds, 30.0f, 5.0f);
    }
    field.contentVerticalAlignment  = UIControlContentVerticalAlignmentCenter;
    
    [cell addSubview:field];
    
    return cell;

}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
    footerView.backgroundColor = [UIColor clearColor];
    
    UIButton *submit            = [UIButton buttonWithType:UIButtonTypeCustom];
    submit.frame                = CGRectMake(10.0f, 10.0f, self.tableView.bounds.size.width - 20.0f, 40.0f);
    submit.clipsToBounds        = YES;
    submit.titleLabel.font      = [UIFont systemFontOfSize:22.0f];
    submit.backgroundColor      = [UIColor colorWithRed:255.0f green:255.0f blue:255.0f alpha:0.5];
    //////    submit.layer.cornerRadius   = 5.0f;
    ////    submit.layer.borderColor    = [UIColor darkGrayColor].CGColor;
    //    submit.layer.borderWidth    = 1.0f;
    
    [submit setTitle:@"发布帖子" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:submit];
    
    return footerView;
}

@end
