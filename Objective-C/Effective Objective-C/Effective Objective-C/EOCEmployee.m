//
//  EOCEmployee.m
//  Effective Objective-C
//
//  Created by feiyun on 16/5/22.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "EOCEmployee.h"
#import "EOCEmployeeFinance.h"
#import "EOCEmployeeDeveloper.h"
#import "EOCEmployeeDeveloper.h"

@implementation EOCEmployee
+(EOCEmployee *)employeeWithType:(EOCEmployeeType)type{
    switch (type) {
        case EOCEmployeeTypeDeveloper:
            return [EOCEmployeeDeveloper new];
            break;
        case EOCEmployeeTypeDesigner:
            return [EOCEmployeeDeveloper new];
            break;
        case EOCEmployeeTypeFinance:
            return [EOCEmployeeFinance new];;
            break;

    }
}
-(void)doADaysWork{
    
}
@end
