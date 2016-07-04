//
//  ViewController.swift
//  CarouselTest
//
//  Created by feiyun on 16/7/4.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController2: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let imagePaths = NSBundle.mainBundle().pathsForResourcesOfType("png", inDirectory: "Vacation Photos")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell2")
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagePaths.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell2", forIndexPath: indexPath)
        var imageView = cell.contentView.subviews.first as? UIImageView
        if imageView == nil {
            imageView = UIImageView.init(frame: cell.contentView.bounds)
            cell.contentView.addSubview(imageView!)
        }
        imageView?.tag = indexPath.row
        imageView?.image = nil
        
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)) {
//            
//            let imagePath = self.imagePaths[indexPath.row]
//            let image = UIImage(contentsOfFile: imagePath)
//            
//           dispatch_async(dispatch_get_main_queue(), { 
//                if indexPath.row == imageView!.tag {
//                    imageView!.image = image;
//                }
//           })
//            
//        }
        
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)) {
            
            let imagePath = self.imagePaths[indexPath.row]
            var image = UIImage(contentsOfFile: imagePath)
            
            UIGraphicsBeginImageContextWithOptions((imageView?.bounds.size)!, true, 0)
            image?.drawInRect((imageView?.bounds)!)
            image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            dispatch_async(dispatch_get_main_queue(), {
                if indexPath.row == imageView!.tag {
                    imageView!.image = image;
                }
            })
        }

         return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

