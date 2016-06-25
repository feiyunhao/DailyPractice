//
//  MKMasonryViewLayout.swift
//  MasonryLayoutDemo
//
//  Created by feiyun on 16/6/23.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

protocol MKMasonryViewLayoutDelegate {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout:MKMasonryViewLayout,
    heightForItemAtIndexPath indexPath:NSIndexPath ) -> CGFloat
}

class MKMasonryViewLayout: UICollectionViewLayout {
    
    let numberOfColumns:CGFloat = 3
    let interItemSpacing:CGFloat = 12.5
    var layoutInfo: [NSIndexPath : UICollectionViewLayoutAttributes] = Dictionary()
    var lastYValueForColumn: [CGFloat : CGFloat] = [0:0, 1:0, 2:0]
    
    override func prepareLayout() {
        
        var currentColumn: CGFloat = 0
        let fullWidth = self.collectionView!.frame.size.width
        let availableSpaceExcludingPadding = fullWidth - (self.interItemSpacing * (self.numberOfColumns + 1));
        let itemWidth = availableSpaceExcludingPadding / self.numberOfColumns
        
        var indexPath: NSIndexPath
        let numSections = self.collectionView!.numberOfSections()
        for section in 0..<numSections {
            let numItems = self.collectionView!.numberOfItemsInSection(section)
            for item in 0..<numItems {
                indexPath = NSIndexPath(forRow: item, inSection: section)
                let itemAttributes = UICollectionViewLayoutAttributes(forCellWithIndexPath:indexPath)
                let x = self.interItemSpacing + (self.interItemSpacing + itemWidth) * currentColumn;
                var y = self.lastYValueForColumn[currentColumn]!
                let delegate = self.collectionView?.delegate as! MKMasonryViewLayoutDelegate
                let height = delegate.collectionView(self.collectionView!, layout: self, heightForItemAtIndexPath: indexPath)
                itemAttributes.frame = CGRectMake(x, y, itemWidth, height);
                
                y += height
                y += self.interItemSpacing;
                
                self.lastYValueForColumn[currentColumn] = y;
                
                currentColumn += 1
                if(currentColumn == self.numberOfColumns) {
                    currentColumn = 0
                }
                self.layoutInfo[indexPath] = itemAttributes;
            }
        }
    }
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var allAttributes: [UICollectionViewLayoutAttributes] = []
        for (_ , attributes) in layoutInfo {
            if CGRectIntersectsRect(rect, attributes.frame) {
                allAttributes.append(attributes)
            }
        }
        return allAttributes
    }
    
    override func collectionViewContentSize() -> CGSize {
        var currentColumn:CGFloat = 0
        var maxHeight:CGFloat = 0
        repeat {
            let height = self.lastYValueForColumn[currentColumn]!
            if height > maxHeight {
                maxHeight = height;
            }
            currentColumn += 1
           
        } while (currentColumn < self.numberOfColumns);
        
        return CGSizeMake(self.collectionView!.frame.size.width, maxHeight)
    }

}
