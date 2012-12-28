//
//  RCReplyViewController.m
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-18.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import "RCReplyViewController.h"
#import "RCPreferences.h"
#import "RCTopicViewController.h"

@interface RCReplyViewController ()

@end

@implementation RCReplyViewController

static RCReplyViewController *_shared;
+ (RCReplyViewController *) shared {
    if (!_shared) {
        _shared =  [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"RCReplyViewController"];
    }
    return _shared;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"回帖";
    
    [bodyTextView setPlaceholders:@"回帖内容..."];
    [bodyTextView setText:@""];

    self.navigationController.navigationBar.topItem.leftBarButtonItem.title = @"取消";
    self.navigationController.navigationBar.topItem.rightBarButtonItem.title = @"回复";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setTopic: (RCTopic *) aTopic {
    topic = aTopic;
}


- (IBAction)cancelButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)submitButtonClick:(id)sender {
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [SVProgressHUD showWithStatus:@"提交中"];
    
    RCReply *reply = [[RCReply alloc] init];
    reply.body = bodyTextView.text;
    
    [topic createReply:reply async:^(id object, NSError *error) {
        if (!error) {
            [SVProgressHUD showSuccessWithStatus:@"回帖成功"];

            [[RCTopicViewController shared] appendReply:object];
            
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else {
            [SVProgressHUD dismiss];
            
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


- (IBAction)photoButtonClick:(id)sender {
    if (!imagePicker) {
        imagePicker =[[UIImagePickerController alloc] init];
    }
    
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo {
    [SVProgressHUD showWithStatus:@"上传中"];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"picking image: %@",image);
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/photos.json?token=%@",kApiURL,[RCPreferences privateToken]]];
    ASIFormDataRequest *req = [[ASIFormDataRequest alloc] initWithURL:url];
    NSData *imageData = UIImageJPEGRepresentation(image,99);
    [req appendPostData:imageData];
    [req setData:imageData withFileName:[NSString stringWithFormat:@"%@.jpg",[NSDate date]] andContentType:@"image/jpeg" forKey:@"Filedata"];
    
    req.delegate = self;
    
    [req startAsynchronous];
}


- (void)requestFinished:(ASIHTTPRequest *)request {
    [bodyTextView insertText:[NSString stringWithFormat:@"![](%@)\n",[request responseString]]];
    [bodyTextView becomeFirstResponder];
    [SVProgressHUD showSuccessWithStatus:@"上传成功"];
}

- (void)requestFailed:(ASIHTTPRequest *)request {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"上传失败"
                                                    message:@"由于某些原因，图片上传失败了，请稍后再试。"
                                                   delegate:self
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"确定", nil];
    [alert show];
    
    [SVProgressHUD dismiss];
}


@end
