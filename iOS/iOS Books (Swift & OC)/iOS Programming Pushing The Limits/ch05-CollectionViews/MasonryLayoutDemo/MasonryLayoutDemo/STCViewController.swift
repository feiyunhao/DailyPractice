//
//  ViewController.swift
//  MasonryLayoutDemo
//
//  Created by feiyun on 16/6/23.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class STCViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout,MKMasonryViewLayoutDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CollectionViewCell
        cell.label.text = "\(indexPath.row)"
        return cell
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        let randomHeight = CGFloat(100 + (arc4random() % 140))
//        return CGSizeMake(100, randomHeight)
//    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: MKMasonryViewLayout, heightForItemAtIndexPath: NSIndexPath) -> CGFloat {
        let randomHeight:CGFloat = CGFloat(100 + (arc4random() % 140));
        return randomHeight
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

