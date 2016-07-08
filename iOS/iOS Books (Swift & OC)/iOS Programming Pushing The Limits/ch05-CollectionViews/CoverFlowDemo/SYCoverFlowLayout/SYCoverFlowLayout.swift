//
//  SYCoverFlowLayout.swift
//  CoverFlowDemo
//
//  Created by feiyun on 16/6/23.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

private let ZOOM_FACTOR:CGFloat  = 0.35

class SYCoverFlowLayout: UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        self.scrollDirection = .Horizontal
        let size = self.collectionView!.frame.size
        self.itemSize = CGSizeMake(size.width/4.0, size.height*0.7);
        self.sectionInset = UIEdgeInsetsMake(size.height * 0.15, size.height * 0.1, size.height * 0.15, size.height * 0.1)
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let array = super.layoutAttributesForElementsInRect(rect)!
        //可见区域（当前屏幕尺寸）
        let visibleRect = CGRect(origin: (self.collectionView?.contentOffset)!,size: (self.collectionView?.bounds.size)!)
        //屏幕一半宽度
        let collectionViewHalfFrame = self.collectionView!.frame.size.width/2.0
        for attributes in array {
            if CGRectIntersectsRect(attributes.frame, rect) {
                //cell 的中心距离屏幕中心的距离
                let distance = CGRectGetMidX(visibleRect) - attributes.center.x
                //cell的中心距离屏幕中心的距离／屏幕一半宽度
                let normalizedDistance = distance / collectionViewHalfFrame
                //如果中心在屏幕内
                if fabs(distance) < collectionViewHalfFrame {
                    //水冰月，变身... fabs绝对值
                    let zoom =  1 + ZOOM_FACTOR*(1 - fabs(normalizedDistance))
                    //生成矩阵
                    var rotationAndPerspectiveTransform = CATransform3DIdentity
                    //透视效果 m34
                    rotationAndPerspectiveTransform.m34 = 1.0 / -500;
                    //延Y轴旋转
                    rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, (normalizedDistance) * CGFloat(M_PI_4), 0.0, 1.0, 0.0)
                    //缩放
                    let zoomTransform = CATransform3DMakeScale(zoom, zoom, 1.0);
                    //合并 旋转 与 缩放， 赋值
                    attributes.transform3D = CATransform3DConcat(zoomTransform, rotationAndPerspectiveTransform);
                    //层次
                    attributes.zIndex = Int(fabs(normalizedDistance) * 10.0)
                    //透明度
                    var alpha = (1 - fabs(normalizedDistance)) + 0.1
                    if alpha > 1.0 {
                        alpha = 1.0
                    }
                    attributes.alpha = alpha;
                } else {
                    attributes.alpha = 0.0
                }
            }
        }
        return array
    }
    
}
