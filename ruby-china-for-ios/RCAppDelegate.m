//
//  RCAppDelegate.m
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-10.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import "RCAppDelegate.h"
#import "RCViewController.h"
#import "RCAll.h"
#import "RCPreferences.h"
#import "RCLoginViewController.h"
#import "RCTopicsViewController.h"
#import <ShareKit/SHKConfiguration.h>


@implementation RCAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    
    [self.window addSubview:[RCTopicsViewController shared].view];
    
    [self mapObjects];
    
    [RCUser checkLogin];
    
    DefaultSHKConfigurator *configurator = [[DefaultSHKConfigurator alloc] init];
    [SHKConfiguration sharedInstanceWithConfigurator:configurator];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)mapObjects {
//    AFHTTPClient* client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:kApiURL]];
//    [client setDefaultHeader:@"Accept" value:RKMIMETypeJSON];
    
    RKObjectManager *manager = [[RKObjectManager alloc] initWithBaseURL:[RKURL URLWithBaseURLString:kApiURL]];
    manager.client.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;
    
    // Error
    RKObjectMapping *errorMapping = [RKObjectMapping mappingForClass:[RKErrorMessage class]];
    [errorMapping mapKeyPath:@"error" toAttribute:@"errorMessage"];
    [manager.mappingProvider setErrorMapping:errorMapping];
    
    // Node
    RKObjectMapping *nodeMapping = [RKObjectMapping mappingForClass:[RCNode class]];
    [nodeMapping mapAttributes:@"name", @"summary",@"sort", nil];
    [nodeMapping mapKeyPathsToAttributes:@"id" , @"ID",
     @"topics_count" , @"topicsCount",
     nil];
    [manager.mappingProvider setObjectMapping:nodeMapping forKeyPath:@"/nodes/:id.json"];
    
    // User
    RKObjectMapping *userMapping = [RKObjectMapping mappingForClass:[RCUser class]];
    [userMapping mapAttributes:@"login", @"name", @"company", @"location", @"bio", @"tagline", @"website",nil];
    [userMapping mapKeyPathsToAttributes: @"id" , @"ID",
     @"created_at" , @"createdAt",
     @"updated_at" , @"updatedAt",
     @"github_url" , @"githubUrl",
     @"avatar_url" , @"avatarUrl"
     ,nil];
    [manager.mappingProvider setObjectMapping:userMapping forKeyPath:@"/users/:login.json"];

    
    
    // Reply
    RKObjectMapping *replyMapping = [RKObjectMapping mappingForClass:[RCReply class]];
    [replyMapping mapAttributes:@"body",nil];
    [replyMapping mapKeyPathsToAttributes: @"id", @"ID",
     @"created_at", @"createdAt",
     @"updated_at", @"updatedAt",
     @"body_html", @"bodyHtml",
     @"topic_id", @"topicId" ,nil];
    [replyMapping mapRelationship:@"user" withMapping:userMapping];
    [manager.mappingProvider addObjectMapping:replyMapping];
    
    // Reply Submit
    RKObjectMapping *replySerializationMapping = [RKObjectMapping mappingForClass:[RCReply class]];
    [replySerializationMapping mapKeyPath:@"body" toAttribute:@"body"];
    [replySerializationMapping mapKeyPath:@"topicId" toAttribute:@"topic_id"];
    [manager.mappingProvider setSerializationMapping:replySerializationMapping forClass:[RCReply class]];
    [manager.router routeClass:[RCReply class] toResourcePath:@"/topics/:id/replies" forMethod:RKRequestMethodPOST];
    
    
    // Topic
    RKObjectMapping *topicMapping = [RKObjectMapping mappingForClass:[RCTopic class]];
    [topicMapping mapAttributes:@"title", @"body", @"hits",nil];
    [topicMapping mapKeyPathsToAttributes:@"id" , @"ID",
         @"created_at", @"createdAt",
         @"updated_at", @"updatedAt",
         @"body_html", @"bodyHtml",
         @"last_reply_user_login", @"lastReplyUserLogin",
         @"last_reply_user_id", @"lastReplyUserId",
         @"node_name", @"nodeName",
         @"node_id", @"nodeId",
         @"replied_at", @"repliedAt",
         @"replies_count", @"repliesCount",
         @"user_login", @"userLogin",nil];
    [topicMapping mapRelationship:@"user" withMapping:userMapping];
    [topicMapping mapRelationship:@"node" withMapping:nodeMapping];
    [topicMapping mapKeyPath:@"replies" toRelationship:@"replies" withMapping:replyMapping];
    [manager.mappingProvider setObjectMapping:topicMapping forKeyPath:@"/topics"];
    [manager.mappingProvider setObjectMapping:topicMapping forKeyPath:@"/topics/:id"];
    
    
    // Topic Submit    
    RKObjectMapping *topicSerializationMapping = [RKObjectMapping mappingForClass:[RCTopic class]];
    [topicSerializationMapping mapKeyPath:@"title" toAttribute:@"title"];
    [topicSerializationMapping mapKeyPath:@"body" toAttribute:@"body"];
    [topicSerializationMapping mapKeyPath:@"nodeId" toAttribute:@"node_id"];
    [manager.mappingProvider setSerializationMapping:topicSerializationMapping forClass:[RCTopic class]];
    [manager.router routeClass:[RCTopic class] toResourcePath:@"/topics" forMethod:RKRequestMethodPOST];
    
//
//    // MARK: Request Mapping
//    RKObjectMapping *topicSubmitMapping = [RKObjectMapping requestMapping];
//    [topicSubmitMapping addAttributeMappingsFromDictionary:@{
//     @"title" : @"title",
//     @"body" : @"body",
//     @"nodeId" : @"node_id"
//     }];
//    RKRequestDescriptor *topicRequestDescripter = [RKRequestDescriptor requestDescriptorWithMapping:topicSubmitMapping objectClass:[RCTopic class] rootKeyPath:nil];
//    
//    RKObjectMapping *replySubmitMapping = [RKObjectMapping requestMapping];
//    [replySubmitMapping addAttributeMappingsFromDictionary:@{
//     @"topicId" : @"topic_id",
//     @"body" : @"body",
//     }];
//    RKRequestDescriptor *replyRequestDescriptor = [RKRequestDescriptor requestDescriptorWithMapping:replySubmitMapping
//                                                                                        objectClass:[RCReply class]
//                                                                                        rootKeyPath:nil];
//

}


@end
