//
//  KVCTableViewCell.m
//  KVC
//
//  Created by feiyun on 16/7/14.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "KVCTableViewCell.h"

@implementation KVCTableViewCell

- (id)initWithReuseIdentifier:(NSString *)identifier {
    return [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
}

- (BOOL)isReady {
    // Only display something if configured
    return (self.object && [self.property length] > 0);
}

- (void)update {
    NSString *text;
    if (self.isReady) {
        id value = [self.object valueForKeyPath:self.property];
        text = [value description];
    }
    else {
        text = @"";
    }
    self.textLabel.text = text;
}

- (void)setObject:(id)object {
    _object = object;
    [self update];
}

- (void)setProperty:(NSString *)property {
    _property = property;
    [self update];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
