//
//  TableViewCell.h
//  KVO
//
//  Created by feiyun on 16/7/14.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
- (id)initWithReuseIdentifier:(NSString*)identifier;
@property (nonatomic, readwrite, strong) id object;
@property (nonatomic, readwrite, copy) NSString *property;
@end
