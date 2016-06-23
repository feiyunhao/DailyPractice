//
//  SYCoverFlowLayout.swift
//  CoverFlowDemo
//
//  Created by feiyun on 16/6/23.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class SYCoverFlowLayout: UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        self.scrollDirection = .Horizontal
        let size = self.collectionView!.frame.size
        self.itemSize = CGSizeMake(size.width/4.0, size.height*0.7);
        self.sectionInset = UIEdgeInsetsMake(size.height * 0.15, size.height * 0.1, size.height * 0.15, size.height * 0.1)
    }
    
    
}
