//
//  ViewController.swift
//  CarouselTest
//
//  Created by feiyun on 16/7/4.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class CATiledLayerTest: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let imagePaths = NSBundle.mainBundle().pathsForResourcesOfType("png", inDirectory: "Vacation Photos")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagePaths.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath)
        
        var tileLayer = cell.contentView.layer.sublayers?.last as? CATiledLayer
        if tileLayer == nil {
            tileLayer = CATiledLayer()
            tileLayer!.frame = cell.bounds
            tileLayer!.contentsScale = UIScreen.mainScreen().scale;
            tileLayer!.tileSize = CGSizeMake(
                cell.bounds.size.width *  UIScreen.mainScreen().scale,
                cell.bounds.size.height *  UIScreen.mainScreen().scale);
            tileLayer!.delegate = self;
            cell.contentView.layer.addSublayer(tileLayer!)
        }
        
        tileLayer!.contents = nil;
        tileLayer?.setValue(indexPath.row, forKey: "index")
        tileLayer?.setNeedsDisplay()
        return cell;
    }
    
    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        let index = layer.valueForKey("index") as! Int
        let imagePath = self.imagePaths[index]
        let image = UIImage(contentsOfFile:imagePath)
        UIGraphicsPushContext(ctx)
        image?.drawInRect(layer.bounds)
        UIGraphicsPopContext()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

