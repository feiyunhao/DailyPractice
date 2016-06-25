//
//  ViewController.swift
//  CoverFlowDemo
//
//  Created by feiyun on 16/6/23.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    var photolist: [String] = Array()
    var photosCache = NSCache()
    let photosDirectory = NSBundle.mainBundle().resourcePath?.stringByAppendingString("/Photos")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        photolist = try! NSFileManager.defaultManager().contentsOfDirectoryAtPath(photosDirectory!)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photolist.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SYPhotoCell", forIndexPath: indexPath) as! PhotoCell
        let photoName = photolist[indexPath.row]
        
        if let thumbImage = photosCache.objectForKey(photoName) {
            cell.photoView.image = (thumbImage as! UIImage)
        } else {
            let layout = collectionView.collectionViewLayout as! SYCoverFlowLayout
            let photoPath = photosDirectory?.stringByAppendingString("/\(photoName)")
            let scale = UIScreen.mainScreen().scale
            let image = UIImage(contentsOfFile:photoPath!)
            UIGraphicsBeginImageContextWithOptions(layout.itemSize, true, scale)
            image?.drawInRect(CGRectMake(0, 0, layout.itemSize.width, layout.itemSize.height))
            let thumbimage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.photosCache.setObject(thumbimage, forKey: photoName)
            dispatch_async(dispatch_get_main_queue(), { 
                cell.photoView.image = thumbimage
            })
        }
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

