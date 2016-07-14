//
//  KVCTableViewCell.h
//  KVC
//
//  Created by feiyun on 16/7/14.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KVCTableViewCell : UITableViewCell

- (id)initWithReuseIdentifier:(NSString*)identifier;

// Object to display.
@property (nonatomic, readwrite, strong) id object;

// Name of property of object to display
@property (nonatomic, readwrite, copy) NSString *property;

@end
