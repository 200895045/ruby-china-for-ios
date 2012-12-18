//
//  RCBaseModel.m
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-18.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import "RCBaseModel.h"
#import "NSString+ActiveSupportInflector.h"
#import "RCPreferences.h"

@implementation RCBaseModel

@synthesize ID,createdAt,updatedAt, errorMessage;

+ (NSString *) tableName {
    return [[[NSStringFromClass([self class]) stringByReplacingOccurrencesOfString:@"RC" withString:@""] lowercaseString] pluralizeString];
}

+ (void) findById:(int)aID async:(void (^)(id, NSError *))async {
    [self findByStringId:[NSString stringWithFormat:@"%d",aID] async:async];
}

+ (void) findByStringId: (NSString *) aID async: (void (^)(id object, NSError *error)) async{
    [[RKObjectManager sharedManager] getObjectsAtPath:[NSString stringWithFormat:@"%@/%@",[self tableName],aID]
                                           parameters:nil
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  //
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      async([mappingResult firstObject], nil);
                                                  });
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  //
                                                  NSLog(@"%@ findByStringId error: %@", [self tableName], error);
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      async([error.userInfo objectForKey:RKObjectMapperErrorObjectsKey], error);
                                                  });
                                              }];
    
}

+ (void) findAll: (void (^)(NSArray *objects, NSError *error)) async {
    [self findWithPage:1 perPage:1000 async:async];
}

+ (void) findWithPage: (int) page perPage:(int)perPage async: (void (^)(NSArray *objects, NSError *error)) async {
    [[RKObjectManager sharedManager] getObjectsAtPath:[NSString stringWithFormat:@"%@",[self tableName]]
                                           parameters:@{ @"page" : [NSNumber numberWithInt:page], @"per_page" : [NSNumber numberWithInt:perPage] }
                                              success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                                  NSArray *result = [mappingResult array];
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      async(result, nil);
                                                  });
                                              }
                                              failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                                  NSLog(@"%@ findWithPage error: %@", [self tableName], error);
                                                  dispatch_async(dispatch_get_main_queue(), ^{
                                                      async(nil, error);
                                                  });
                                                  
                                              }];
    
}

+ (void) create: (id) object async: (void (^)(id object, NSError *error)) async {
    [[RKObjectManager sharedManager] postObject:object
                                           path:[NSString stringWithFormat:@"%@",[self tableName]]
                                     parameters:nil
                                        success:^(RKObjectRequestOperation *operation, RKMappingResult *mappingResult) {
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                async([mappingResult firstObject], nil);
                                            });
                                        } failure:^(RKObjectRequestOperation *operation, NSError *error) {
                                            //
                                            dispatch_async(dispatch_get_main_queue(), ^{                                                
                                                RKErrorMessage *errorMessage = [[[error userInfo] objectForKey:RKObjectMapperErrorObjectsKey] firstObject];
                                                NSLog(@"RKErrorMessage: %@ - %@", errorMessage, error);
                                                async(nil, error);
                                            });
                                        }];
}

@end
