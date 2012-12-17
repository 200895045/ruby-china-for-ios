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
#import <MBProgressHUD/MBProgressHUD.h>

@interface RCLoginViewController ()

@end

@implementation RCLoginViewController

- (id)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self)
    {
        //        _registerForm = [[WCRegisterForm alloc] init];
        
        loginForm = [[RCLoginForm alloc] init];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [loginForm.fields count];
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
    
    UITextField *field              = [loginForm.fields objectAtIndex:indexPath.row];
    field.frame                     = CGRectInset(cell.bounds, 30.0f, 5.0f);
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
    
    [submit setTitle:@"登录" forState:UIControlStateNormal];
    [submit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [submit addTarget:self action:@selector(submitClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [footerView addSubview:submit];
    
    return footerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 60.0f;
}


#pragma mark - Button Event
- (void) submitClick: (id) sender {
    if (!loginForm.isValid) {
        return;
    }
    
    hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.animationType = MBProgressHUDModeIndeterminate;
    hud.labelText = @"";
    [hud show:YES];
    
    BOOL success = [RCUser authorize:loginForm.login.field.text password:loginForm.password.field.text];
    
    [hud hide:YES];
    if (success) {
        hud.labelText = @"登录成功";
        [self dismissViewControllerAnimated:YES completion:^{
            //
        }];
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录" message:@"用户或密码错误，请重试。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}
@end
