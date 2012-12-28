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

+ (void) findById:(NSNumber *)aID async:(void (^)(id, NSError *))async {
    [self findByStringId:[NSString stringWithFormat:@"%d",[aID integerValue]] async:async];
}

+ (void) findByStringId: (NSString *) aID async: (void (^)(id object, NSError *error)) async{
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:[NSString stringWithFormat:@"/%@/%@", [self tableName], aID]
                                                    usingBlock:^(RKObjectLoader *loader) {
        loader.objectMapping = [[RKObjectManager sharedManager].mappingProvider objectMappingForClass:[self class]];
        loader.onDidLoadObject = ^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                async(object, nil);
            });
        };
        loader.onDidFailWithError = ^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                async(nil, error);
            });
        };

    }];
}

+ (void) findAll: (void (^)(NSArray *objects, NSError *error)) async {
    [self findWithPage:1 perPage:1000 async:async];
}

+ (void) findWithPage: (int) page perPage:(int)perPage async: (void (^)(NSArray *objects, NSError *error)) async {
    
    NSString *path = [NSString stringWithFormat:@"/%@?page=%d&per_page=%d", [self tableName], page, perPage];
    
    [[RKObjectManager sharedManager] loadObjectsAtResourcePath:path
                                                    usingBlock:^(RKObjectLoader *loader) {
        loader.objectMapping = [[RKObjectManager sharedManager].mappingProvider objectMappingForClass:[self class]];
        loader.onDidLoadObjects = ^(NSArray *objects) {
            dispatch_async(dispatch_get_main_queue(), ^{
                async(objects, nil);
            });
        };
        loader.onDidFailWithError = ^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                async(nil, error);
            });
        };
    }];    
}

+ (void) create: (id) object async: (void (^)(id object, NSError *error)) async {    
    [[RKObjectManager sharedManager] postObject:object
                                     usingBlock:^(RKObjectLoader *loader) {
        loader.objectMapping = [[RKObjectManager sharedManager].mappingProvider objectMappingForClass:[self class]];
        loader.resourcePath = [NSString stringWithFormat:@"/%@", [self tableName]];
        loader.onDidLoadObject = ^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
              async(object,nil);
            });
        };
        loader.onDidFailWithError = ^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
              async(nil,error);
            });
        };
    }];
}

@end
