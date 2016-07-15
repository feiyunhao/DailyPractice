//
//  JuliaCell.h
//  JuliaOp
//
//  Created by feiyun on 16/7/15.
//  Copyright © 2016年 feiyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JuliaCell : UICollectionViewCell

- (void)configureWithSeed:(NSUInteger)seed
                    queue:(NSOperationQueue *)queue
                   scales:(NSArray *)scales;

@end
