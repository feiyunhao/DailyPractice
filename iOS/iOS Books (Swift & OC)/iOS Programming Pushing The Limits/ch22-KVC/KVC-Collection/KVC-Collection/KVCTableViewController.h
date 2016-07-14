//
//  KVCTableViewController.h
//  KVC-Collection
//
//  Created by feiyun on 16/7/14.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimesTwoArray.h"
@interface KVCTableViewController : UITableViewController
@property (nonatomic, readwrite, strong) TimesTwoArray *array;

@end
