//
//  RCNewTopicViewController.m
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-17.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import "RCNewTopicViewController.h"
#import "RCNodeSelectViewController.h"
#import "RCViewController.h"
#import "RCTableView.h"

@implementation RCNewTopicViewController

static RCNewTopicViewController *_shared;


+ (RCNewTopicViewController *) shared {
    if (!_shared) {
        _shared =  [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"RCNewTopicViewController"];
    }
    return _shared;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"发布帖子";
    
    titleTextView.text = @"";
    titleTextView.placeholders = @"标题";
    
    bodyTextView.text = @"";
    bodyTextView.placeholders = @"正文";

    nodeButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [nodeButton.titleLabel setFont:[UIFont systemFontOfSize:11]];
    [nodeButton setTitle:@"选择节点" forState:UIControlStateNormal];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.editButtonItem.title = @"提交";
    [self.editButtonItem setAction:@selector(submitButtonClick:)];
    
    [[RCNodeSelectViewController shared] addObserver:self forKeyPath:@"selectedNode" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == [RCNodeSelectViewController shared]) {
        if ([keyPath isEqualToString:@"selectedNode"]) {
            RCNode *node = [RCNodeSelectViewController shared].selectedNode;
            [nodeButton setTitle:node.name forState:UIControlStateNormal];
            [nodeButton setFrame:CGRectMake(100, nodeButton.frame.origin.y, 200, nodeButton.frame.size.height)];
            [nodeButton sizeToFit];
        }
    }
}

- (IBAction)nodeButtonClick:(id)sender {
    [self presentViewController:[RCNodeSelectViewController shared] animated:YES completion:nil];
}

- (IBAction)photoButtonClick:(id)sender {
    NSLog(@"photoButtonClick");
}

- (IBAction)submitButtonClick:(id)sender {
    MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
    [hud show:YES];
    RCTopic *topic = [[RCTopic alloc] init];
    topic.title = titleTextView.text;
    topic.body = bodyTextView.text;
    topic.nodeId = [RCNodeSelectViewController shared].selectedNode.ID;
    
    [RCTopic create:topic async:^(id object, NSError *error) {
        if (!error) {
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }
        else {
            NSString *errorMessage = @"";
            
            errorMessage = [error localizedDescription];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"创建失败"
                                                            message:errorMessage
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"确定", nil];
            [alert show];

        }
    }];
}


@end
