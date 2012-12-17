//
//  RCNode.h
//  ruby-china
//
//  Created by NSRails autogen on 12/10/2012.
//  Copyright (c) 2012 jason. All rights reserved.
//

#import "RCBaseModel.h"

@class RCSection;
@class RCUser;

@interface RCNode : RCBaseModel

@property (nonatomic, strong) RCSection *section;
@property (nonatomic, strong) RCUser *followers;
@property (nonatomic, strong) NSString *name, *summary;
@property (nonatomic, strong) NSNumber *sort, *topicsCount;

@end
