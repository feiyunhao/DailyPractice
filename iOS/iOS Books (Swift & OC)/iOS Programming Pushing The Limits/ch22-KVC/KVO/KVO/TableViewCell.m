//
//  TableViewCell.m
//  KVO
//
//  Created by feiyun on 16/7/14.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (id)initWithReuseIdentifier:(NSString *)identifier {
    return [super initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:identifier];
}

- (BOOL)isReady {
    return (self.object && [self.property length] > 0);
}

- (void)update {
    self.textLabel.text = self.isReady ?
    [[self.object valueForKeyPath:self.property] description]
    : @"";
}

- (void)setObject:(id)anObject {
    [self removeObservation];
    _object = anObject;
    [self addObservation];
    [self update];
}

- (void)setProperty:(NSString *)aProperty {
    [self removeObservation];
    _property = aProperty;
    [self addObservation];
    [self update];
}

- (void)removeObservation {
    if (self.isReady) {
        [self.object removeObserver:self
                         forKeyPath:self.property];
    }
}

- (void)addObservation {
    if (self.isReady) {
        //观察 self.object (tableViewController) 的属性 now
        [self.object addObserver:self forKeyPath:self.property
                         options:0
                         context:(void*)self];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ((__bridge id)context == self) {
        // Our notification, not our superclass’s
        [self update];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object
                               change:change context:context];
    }
}

- (void)dealloc {
    if (_object && [_property length] > 0) {
        [_object removeObserver:self
                     forKeyPath:_property
                        context:(void *)self];
    }
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
