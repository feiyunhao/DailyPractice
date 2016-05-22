//
//  EOCEmployee.h
//  Effective Objective-C
//
//  Created by feiyun on 16/5/22.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM (NSUInteger, EOCEmployeeType) {
    EOCEmployeeTypeDeveloper,
    EOCEmployeeTypeDesigner,
    EOCEmployeeTypeFinance
};

@interface EOCEmployee : NSObject

@property (copy) NSString *name;
@property NSUInteger salary;

+ (EOCEmployee*)employeeWithType:(EOCEmployeeType)type;
- (void)doADaysWork;

@end
