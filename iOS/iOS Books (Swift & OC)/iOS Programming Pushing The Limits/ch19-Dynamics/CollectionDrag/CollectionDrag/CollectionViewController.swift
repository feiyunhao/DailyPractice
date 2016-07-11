//
//  CollectionViewController.swift
//  CollectionDrag
//
//  Created by feiyun on 16/7/10.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView!.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

   
    // MARK: UICollectionViewDataSource

    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 180
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
        cell.backgroundColor = UIColor.darkGrayColor()
        return cell
    }

    @IBAction func handleLongPress(sender: UIGestureRecognizer) {
        let point = sender.locationInView(self.collectionView)
        if let indexPath = self.collectionView?.indexPathForItemAtPoint(point) {        
            let cell = self.collectionView!.cellForItemAtIndexPath(indexPath)
            let state = sender.state
            let dragLayout = self.collectionViewLayout as! DragLayout
            
            if state == .Began {
                UIView.animateWithDuration(0.25, animations: { 
                    cell?.backgroundColor = UIColor.redColor()
                })
                dragLayout.startDraggingIndexPath(indexPath, fromPoint: point)
            } else if state == .Ended || state == .Cancelled {
                UIView.animateWithDuration(0.25, animations: {
                    cell?.backgroundColor = UIColor.darkGrayColor()
                })
                dragLayout.stopDragging()
            } else {
                dragLayout.updateDragLocation(point)
            }
        
        }
    }
}
