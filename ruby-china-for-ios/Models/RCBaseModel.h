//
//  RCBaseModel.h
//  ruby-china-for-ios
//
//  Created by Jason Lee on 12-12-18.
//  Copyright (c) 2012年 Ruby China. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSDictionary.h>

@interface RCBaseModel : NSObject

@property (nonatomic, strong) NSNumber *ID;
@property (nonatomic, strong) NSDate *createdAt,*updatedAt;
@property (nonatomic, strong) NSString *errorMessage;

+ (NSString *) tableName;

+ (void) findById: (NSNumber *) aID async: (void (^)(id object, NSError *error)) async;
+ (id) findByStringId: (NSString *) aID;
+ (void) findByStringId: (NSString *) aID async: (void (^)(id object, NSError *error)) async;
+ (void) findWithPage: (int) page perPage:(int)perPage async: (void (^)(NSArray *objects, NSError *error)) async;
+ (void) findAll: (void (^)(NSArray *objects, NSError *error)) async;
+ (void) create: (id) object async: (void (^)(id object, NSError *error)) async;
@end
