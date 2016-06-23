//
//  CollectionViewController.swift
//  CollectionViewDemo
//
//  Created by feiyun on 16/6/23.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class CollectionViewController: UICollectionViewController {

    enum PhotoOrientation: String {
        case PhotoOrientationLandscape = "MKPhotoCellLandscape"
        case PhotoOrientationPortrait  = "MKPhotoCellPortrait"
    }

    var photosList: [String]?
    var photoOrientation: [PhotoOrientation]? = Array()
    var photosCache: [String : UIImage]? = Dictionary()
    var photosDirectory: String {
        return (NSBundle.mainBundle().resourcePath?.stringByAppendingString("/Photos"))!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let photosArray = try? NSFileManager.defaultManager().contentsOfDirectoryAtPath(self.photosDirectory)
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
            
            for (_, obj) in (photosArray?.enumerate())! {
                let path = self.photosDirectory.stringByAppendingString("/\(obj)")
                let size = UIImage(contentsOfFile:path)?.size
                if size?.height > size?.width {
                    self.photoOrientation?.append(PhotoOrientation.PhotoOrientationPortrait)
                } else {
                    self.photoOrientation?.append(PhotoOrientation.PhotoOrientationLandscape)
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), { 
                self.photosList = photosArray
                self.collectionView?.reloadData()
            })
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        let selectedIndexPath = sender as! NSIndexPath
        let photoName = self.photosList![selectedIndexPath.row]
        let controller = segue.destinationViewController as! ViewController
        controller.photoPath = self.photosDirectory.stringByAppendingString("/\(photoName)")
        
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.photosList?.count ?? 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let orientation = self.photoOrientation![indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(orientation.rawValue,
            forIndexPath: indexPath) as! CollectionViewCell
    
        // Configure the cell
    
        let photoName = self.photosList![indexPath.row]
        cell.nameLabel.text = photoName
        let photoFilePath = self.photosDirectory.stringByAppendingString("/\(photoName)")
        var thumbImage = self.photosCache!["\(photoName)"]
        if thumbImage == nil {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), { 
                let image = UIImage(contentsOfFile:photoFilePath)
                if orientation == .PhotoOrientationPortrait {
                    UIGraphicsBeginImageContext(CGSizeMake(180, 120))
                    image?.drawInRect(CGRectMake(0, 0, 180, 120))
                    thumbImage = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                } else {
                    UIGraphicsBeginImageContext(CGSizeMake(120, 180))
                    image?.drawInRect(CGRectMake(0, 0, 120, 180))
                    thumbImage = UIGraphicsGetImageFromCurrentImageContext()
                    UIGraphicsEndImageContext()
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    self.photosCache![photoName] = thumbImage
                    cell.photoView.image = thumbImage
                })
            })
        } else {
            cell.photoView.image = thumbImage
        }
        return cell
    }

    override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let supplementaryViewIdentifier = "SupplementaryViewIdentifier"
        return collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: supplementaryViewIdentifier, forIndexPath: indexPath)
    }
    // MARK: UICollectionViewDelegate

    
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("MainSegue", sender: indexPath)
    }
    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
