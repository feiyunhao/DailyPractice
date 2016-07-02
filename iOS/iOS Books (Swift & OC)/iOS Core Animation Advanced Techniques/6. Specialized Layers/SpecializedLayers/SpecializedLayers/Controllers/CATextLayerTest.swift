//
//  CATextLayerTest.swift
//  SpecializedLayers
//
//  Created by feiyun on 16/6/29.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit

class CATextLayerTest: UIViewController {
    
    @IBOutlet weak var labelView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let textLayer = CATextLayer()
        textLayer.frame = self.labelView.bounds
        self.labelView.layer.addSublayer(textLayer)
        
        textLayer.contentsScale = UIScreen.mainScreen().scale
        
        textLayer.foregroundColor = UIColor.redColor().CGColor
        textLayer.alignmentMode = kCAAlignmentJustified
        textLayer.wrapped = true
        
        let font = UIFont.systemFontOfSize(14)
        textLayer.font = CGFontCreateWithFontName(font.fontName)
        textLayer.fontSize = font.pointSize
        
        let string = "CATextLayer的font可以根据你的具体需要来决定字体属性应该是用CGFontRef类型还是CTFontRef类型（Core Text字体）。同时字体大小也是用fontSize属性单独设置的，因为CTFontRef和CGFontRef并不像UIFont一样包含点大小。这个例子会告诉你如何将UIFont转换成CGFontRef。另外，CATextLayer的string属性并不是你想象的NSString类型，而是id类型。这样你既可以用NSString也可以用NSAttributedString来指定文本了（注意，NSAttributedString并不是NSString的子类）。属性化字符串是iOS用来渲染字体风格的机制，它以特定的方式来决定指定范围内的字符串的原始信息，比如字体，颜色，字重，斜体等。"
        textLayer.string = string
        
        
        let attributedString = NSMutableAttributedString.init(string: string)
        let attribute:[String : AnyObject] = [NSFontAttributeName : font,
                         NSForegroundColorAttributeName : UIColor.redColor().CGColor]
        attributedString.setAttributes(attribute , range: NSMakeRange(10, 20))
        textLayer.string = attributedString
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
