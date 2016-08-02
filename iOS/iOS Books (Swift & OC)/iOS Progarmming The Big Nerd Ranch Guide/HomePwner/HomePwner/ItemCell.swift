//
//  ItemCell.swift
//  HomePwner
//
//  Created by feiyun on 16/8/2.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumbnailView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var serialNumberLabel: UILabel!
    
    @IBOutlet weak var valueLabel: UILabel!
    
    var actionBlock: (()->())?
    
    @IBOutlet weak var imageHeight: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.updateInterfaceForDynamicTypeSize()
        let defaultCenter = NSNotificationCenter.defaultCenter()
        defaultCenter.addObserver(self, selector: #selector(self.updateInterfaceForDynamicTypeSize), name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }

    @IBAction func showImage(sender: UIButton) {
        if actionBlock != nil {
            actionBlock!()
        }
    }
    
    func updateInterfaceForDynamicTypeSize() {
        let font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        self.nameLabel.font = font
        self.serialNumberLabel.font = font
        self.valueLabel.font = font
        
        let imageSizeDictionary = [
            UIContentSizeCategoryExtraSmall : 40,
            UIContentSizeCategorySmall : 40,
            UIContentSizeCategoryMedium : 40,
            UIContentSizeCategoryLarge : 40,
            UIContentSizeCategoryExtraLarge : 45,
            UIContentSizeCategoryExtraExtraLarge : 55,
            UIContentSizeCategoryExtraExtraExtraLarge : 65
        ]
        
        let userSize = UIApplication.sharedApplication().preferredContentSizeCategory
        
        if let imageSize = imageSizeDictionary[userSize] {
            self.imageHeight.constant = CGFloat(imageSize);
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
