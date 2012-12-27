//
//  RCLoginViewController.m
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-17.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import "RCLoginViewController.h"
#import "RCLoginForm.h"
#import "RCUser.h"
#import "RCButton.h"
#import "RCLinkButton.h"
#import "RCBoxView.h"
#import <QuartzCore/QuartzCore.h>

#define kLineColor [UIColor colorWithRed:0.9333 green:0.9333 blue:0.9333 alpha:1.0000]



@implementation RCLoginViewController

@synthesize tableView;

- (id)init
{
    self = [super init];
//    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    
    if (self)
    {
        
        
        loginForm = [[RCLoginForm alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImageView *bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    bgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"view_bg"]];
    
    [self.view addSubview:bgView];
    

    CGRect boxRect = CGRectMake(10, 10, self.view.bounds.size.width - 20, 220);
    CGRect logoRect = CGRectMake(self.view.frame.size.width / 2 - 206 / 2, 10, 206, 43);
    if (iPhone5) {
        boxRect.size.height = 310;
        logoRect = CGRectMake(self.view.frame.size.width / 2 - 206 / 2, 40, 206, 43);
    }

    
    RCBoxView *boxView = [[RCBoxView alloc] initWithFrame:boxRect];
    
    [self.view addSubview:boxView];
    
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:logoRect];
    logoView.image = [UIImage imageNamed:@"text_logo"];
    
    [boxView addSubview:logoView];

    CGRect tableViewRect = CGRectMake(20, 43, boxView.frame.size.width - 40, 170);
    if (iPhone5) {
        tableViewRect = CGRectMake(20, 93, boxView.frame.size.width - 40, 170);
    }
    
    self.tableView = [[UITableView alloc] initWithFrame:tableViewRect style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView setSeparatorColor:kLineColor];
    self.tableView.bounces = NO;
    self.tableView.backgroundView.layer.masksToBounds = YES;

    
    [boxView addSubview:self.tableView];
    
    
    [UIApplication sharedApplication].statusBarHidden = NO;
    
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
    return [loginForm.fields count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.restorationIdentifier = CellIdentifier;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundColor = [UIColor clearColor];
    }
    
    UITextField *field              = [loginForm.fields objectAtIndex:indexPath.row];
    field.frame                     = CGRectInset(cell.bounds, 10.0f, 5.0f);
    field.contentVerticalAlignment  = UIControlContentVerticalAlignmentCenter;
    
    if (indexPath.row == 0) {
        [field becomeFirstResponder];
    }
    
    [cell addSubview:field];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectZero];
    footerView.backgroundColor = [UIColor clearColor];
    
        
    RCButton *submitButton            = [[RCButton alloc] initWithFrame:CGRectMake(10.0f, 20.0f, 110, 35.0f) withColor:RCButtonColorRed];
    [submitButton setTitle:@"登录" forState:UIControlStateNormal];
    [submitButton addTarget:self action:@selector(submitButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:submitButton];
    
    RCButton *registButton            = [[RCButton alloc] initWithFrame:CGRectMake(self.tableView.frame.size.width - 120, 20.0f, 110, 35.0f) withColor:RCButtonColorBlack];
    [registButton setTitle:@"注册" forState:UIControlStateNormal];
    [registButton addTarget:self action:@selector(registerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:registButton];
    
    RCLinkButton *forgetPasswordButton = [[RCLinkButton alloc] initWithFrame:CGRectMake(10, 30 + submitButton.frame.size.height , 80, 20) withTitle:@"忘记了密码?"];
    [forgetPasswordButton addTarget:self action:@selector(forgetPasswordButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [footerView addSubview:forgetPasswordButton];
    
    return footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 60.0f;
}


#pragma mark - Button Event
- (void) submitButtonClick: (id) sender {
    if (!loginForm.isValid) {
        return;
    }
    
    [SVProgressHUD show];
    
    BOOL success = [RCUser authorize:loginForm.login.field.text password:loginForm.password.field.text];
    
    if (success) {
        [SVProgressHUD showSuccessWithStatus:@"登录成功"];
        [self dismissViewControllerAnimated:YES completion:^{
            //
        }];
    }
    else {
        [SVProgressHUD showErrorWithStatus:@"用户名或密码错误"];
    }
}

- (void) registerButtonClick: (id) sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://ruby-china.org/account/sign_up"]];
}

- (void) forgetPasswordButtonClick: (id) sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://ruby-china.org/account/password/new"]];
}


@end
