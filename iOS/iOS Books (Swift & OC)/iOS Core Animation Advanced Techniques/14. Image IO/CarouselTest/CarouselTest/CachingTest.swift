//
//  ViewController.swift
//  CarouselTest
//
//  Created by feiyun on 16/7/4.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class CachingTest: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var cache = NSCache()
    
    let imagePaths = NSBundle.mainBundle().pathsForResourcesOfType("png", inDirectory: "Vacation Photos")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell4")
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagePaths.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell4", forIndexPath: indexPath)
        var imageView = cell.contentView.subviews.first as? UIImageView
        if imageView == nil {
            imageView = UIImageView.init(frame: cell.contentView.bounds)
            cell.contentView.addSubview(imageView!)
            imageView?.tag = indexPath.row
        }
        
        imageView?.image = self.loadImageAtIndex(indexPath.row)
        
        if indexPath.item < self.imagePaths.count - 1 {
            self.loadImageAtIndex(indexPath.row + 1)
        }
        if indexPath.item > 0 {
            self.loadImageAtIndex(indexPath.row - 1)
        }
        
        return cell
    }
    
    
    func loadImageAtIndex(index: Int) -> UIImage? {
        
        if let image = cache.objectForKey(String(index)) {
            return image as? UIImage
        }
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0)) {
            let imagePath = self.imagePaths[index]
            var image = UIImage(contentsOfFile: imagePath)
            UIGraphicsBeginImageContextWithOptions(image!.size, true, 0);
            image!.drawAtPoint(CGPointZero)
            image = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            
            dispatch_async(dispatch_get_main_queue(), { 
                self.cache.setObject(image!, forKey: String(index))
                let indexPath = NSIndexPath.init(forRow: index, inSection: 0)
                let cell = self.collectionView.cellForItemAtIndexPath(indexPath)
                let imageView = cell?.contentView.subviews.first as? UIImageView
                if imageView?.tag == index {
                    imageView?.image = image
                }
            })

        }
        
        return nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

