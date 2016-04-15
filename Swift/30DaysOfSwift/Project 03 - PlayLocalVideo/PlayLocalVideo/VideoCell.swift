//
//  VideoCell.swift
//  PlayLocalVideo
//
//  Created by feiyun on 16/4/15.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

struct video {
    let image : String
    let title : String
    let source : String
}
class VideoCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBOutlet weak var videoScreenShot: UIImageView!
    
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    @IBOutlet weak var videoSourceLabel: UILabel!
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
