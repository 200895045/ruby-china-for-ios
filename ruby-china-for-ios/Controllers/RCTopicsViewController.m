//
//  RCFirstViewController.m
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-10.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import "RCTopicsViewController.h"
#import "RCTopicViewController.h"
#import "RCTopicTableViewCell.h"
#import "RCAll.h"
#import <SSPullToRefresh/SSPullToRefresh.h>
#import "RCLoginViewController.h"
#import "RCNewTopicViewController.h"

@interface RCTopicsViewController ()

@end

@implementation RCTopicsViewController

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        //
        topics = [[NSArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 检查登录
    if (![RCUser currentUser]) {
        RCLoginViewController *loginControlelr = [[RCLoginViewController alloc] init];
        [self presentViewController:loginControlelr animated:YES completion:^{
            //
        }];
    }
    
    pullToRefreshView = [[SSPullToRefreshView alloc] initWithScrollView:tableView delegate:self];
    SSPullToRefreshDefaultContentView *contentView = (SSPullToRefreshDefaultContentView *)pullToRefreshView.contentView;
    contentView.statusLabel.textColor = [UIColor grayColor];
    contentView.lastUpdatedAtLabel.textColor = [UIColor darkGrayColor];
    contentView.activityIndicatorView.color = [UIColor lightGrayColor];
    
    // MARK: UINavigationBar 设置
    UINavigationBar *navbar = self.navigationController.navigationBar;
    
    // Toolbar
    RCNavLeftRightButtonItem *rightButton = [[RCNavLeftRightButtonItem alloc] initWithNavBar:navbar
                                                                                   leftRight:RCNavLeftRightButtonItemTypeRight
                                                                             withButtonImage:[UIImage imageNamed:@"nav_new_icon"]
                                                                                  withTarget:self
                                                                                withSelector:@selector(newTopicButtonClick)];
    
    RCNavLeftRightButtonItem *leftButton  = [[RCNavLeftRightButtonItem alloc] initWithNavBar:navbar
                                                                                   leftRight:RCNavLeftRightButtonItemTypeLeft
                                                                             withButtonImage:[UIImage imageNamed:@"nav_menu_icon"]
                                                                                  withTarget:self
                                                                                withSelector:@selector(refreshButtonClick)];
    
    navbar.topItem.title = @"社区";
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
    [self refresh];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 基础方法
- (void) refreshButtonClick {
    [pullToRefreshView startLoadingAndExpand:YES];
}

- (void) newTopicButtonClick {
    [self.navigationController pushViewController:[RCNewTopicViewController shared] animated:YES];
}

- (void) refresh {
    [pullToRefreshView startLoading];
    [RCTopic findWithPage:1 perPage:20 async:^(NSArray *objects, NSError *error) {
        if (!error) {
            topics = objects;
            [tableView reloadData];
        }
    }];
    [pullToRefreshView finishLoading];
}

#pragma mark - PullToRefresh
- (void) pullToRefreshViewDidStartLoading:(SSPullToRefreshView *)view {
    [self refresh];
}

- (void)setState:(SSPullToRefreshViewState)state withPullToRefreshView:(SSPullToRefreshView *)view {
    
}

#pragma mark - TableView delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)aTableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [topics count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    int titleWidth = self.view.frame.size.width - 30 - 40;
    RCTopic *topic = [topics objectAtIndex:indexPath.row];
    NSString *titleString = topic.title;
	NSString *detailString = topic.nodeName;
	CGSize titleSize = [titleString sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:CGSizeMake(titleWidth, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
	CGSize detailSize = [detailString sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(titleWidth, MAXFLOAT) lineBreakMode:NSLineBreakByTruncatingTail];
    
	return MAX(50, detailSize.height + 20 + titleSize.height);
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RCTopic *topic = [topics objectAtIndex:indexPath.row];
    RCTopicTableViewCell *cell = [[RCTopicTableViewCell alloc] initWithTopic:topic];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    RCTopic *topic = [topics objectAtIndex:indexPath.row];
    
    [[RCTopicViewController sharedInstance] setTopic:topic];
    
    [self.navigationController pushViewController:[RCTopicViewController sharedInstance] animated:YES];
    
}
@end
