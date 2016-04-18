//
//  Interest.swift
//  Carousel Effect
//
//  Created by feiyun on 16/4/18.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class InterestCell: UICollectionViewCell {
    
    
    var interest: Interest! {
        didSet {
            updateUI()
        }
    }

    
//    var interest: Interest! {
//        didSet {
//            updateUI()
//        }
//        
//    }
    
    @IBOutlet weak var featuredImageView: UIImageView!
    
    @IBOutlet weak var interestTitleLabel: UILabel!
    private func updateUI()  {
        interestTitleLabel.text = interest.title
//        interestTitleLabel?.text! = interest.titler
        featuredImageView?.image! = interest.featuredImage

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 5.0
        self.clipsToBounds = true
    }
   
}
