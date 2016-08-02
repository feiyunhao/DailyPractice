//
//  ImageViewController.swift
//  HomePwner
//
//  Created by feiyun on 16/8/2.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    var image: UIImage?
    
    override func loadView() {
        let imageView = UIImageView()
        imageView.contentMode = .ScaleAspectFit
        self.view = imageView
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        (self.view as! UIImageView).image = self.image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
