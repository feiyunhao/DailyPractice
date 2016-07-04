//
//  ViewController.swift
//  CarouselTest
//
//  Created by feiyun on 16/7/4.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let imagePaths = NSBundle.mainBundle().pathsForResourcesOfType("png", inDirectory: "Vacation Photos")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell1")
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagePaths.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell1", forIndexPath: indexPath)
        var imageView = cell.viewWithTag(101) as? UIImageView
        if imageView == nil {
            imageView = UIImageView.init(frame: cell.contentView.bounds)
            imageView?.tag = 101
            cell.contentView.addSubview(imageView!)
        }
        let imagePath = self.imagePaths[indexPath.row]
        imageView!.image = UIImage(contentsOfFile: imagePath)
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

