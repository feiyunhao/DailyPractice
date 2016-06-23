//
//  CollectionViewCell.swift
//  CollectionViewDemo
//
//  Created by feiyun on 16/6/23.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectedBackgroundView = UIView(frame:self.frame)
        self.selectedBackgroundView?.backgroundColor = UIColor(white: 0.3, alpha: 0.5)
        self.photoView.layer.borderWidth = 5
        self.photoView.layer.borderColor = UIColor.whiteColor().CGColor
    }
}
