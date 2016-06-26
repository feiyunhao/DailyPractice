//
//  UIimage+Extension.swift
//  BlurDemo
//
//  Created by feiyun on 16/6/22.
//  Copyright © 2016年 feiyun. All rights reserved.
//

import UIKit
import Accelerate

protocol BlurExtension {
    
    func applyLightEffect() -> UIImage?
    
    func applyExtraLightEffect() -> UIImage?
    
    func applyDarkEffect() -> UIImage?
    
    func applyTintEffectWithColor(tintColor:UIColor) -> UIImage?
    
    func applyBlurWithRadius(blurRadius: CGFloat,tintColor: UIColor?, saturationDeltaFactor:CGFloat, maskImage: UIImage? ) -> UIImage?
    
}
extension UIImage: BlurExtension {
    
    func applyLightEffect() -> UIImage? {
        return self.applyBlurWithRadius(30, tintColor: UIColor(white: 1.0,alpha: 0.3), saturationDeltaFactor: 1.8, maskImage: nil)
    }
    
    func applyExtraLightEffect() -> UIImage? {
        return self.applyBlurWithRadius(20, tintColor: UIColor(white: 0.97, alpha: 0.82), saturationDeltaFactor: 1.8, maskImage: nil)
    }
    
    func applyDarkEffect() -> UIImage? {
        return self.applyBlurWithRadius(20, tintColor: UIColor(white: 0.11, alpha: 0.73), saturationDeltaFactor: 1.8, maskImage: nil)
    }
    
    func applyTintEffectWithColor(tintColor: UIColor) -> UIImage? {
        let EffectColorAlpha:CGFloat = 0.6;
        var effectColor = tintColor;
        let componentCount = CGColorGetNumberOfComponents(tintColor.CGColor);
        if componentCount == 2 {
            var b: CGFloat = 0;
            if tintColor.getWhite(&b, alpha: nil) {
            effectColor = UIColor(white:b,alpha:EffectColorAlpha )
            }
        }
        else {
            var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0
            
            if tintColor.getRed(&r, green: &g, blue: &b, alpha: nil) {
                effectColor = UIColor(red: r, green: g, blue: b, alpha: EffectColorAlpha)
            }
        }
        return self.applyBlurWithRadius(10, tintColor: effectColor, saturationDeltaFactor: -1, maskImage: nil)
    }
    
    func applyBlurWithRadius(blurRadius: CGFloat,tintColor: UIColor?, saturationDeltaFactor:CGFloat, maskImage: UIImage? ) -> UIImage? {
        
        if (self.size.width < 1 || self.size.height < 1) {
            print("*** error: invalid size: (\(String(format: "%.2f", self.size.width)) x \(String(format:"%.2f", self.size.height))). Both dimensions must be >= 1: \(self)");
            return nil;
        }
        
        if ((self.CGImage == nil)) {
            print("*** error: image must be backed by a CGImage: \(self)")
            return nil;
        }
        
        if (maskImage != nil && maskImage!.CGImage != nil) {
            print("*** error: maskImage must be backed by a CGImage: \(maskImage)")
            return nil;
        }
        
        let imageRect = CGRect(origin: CGPointZero, size: self.size)
        var effectImage = self
        let hasBlur = Float(blurRadius) > FLT_EPSILON
        let hasSaturationChange = fabs(Float(saturationDeltaFactor) - 1) > FLT_EPSILON

        if hasBlur || hasSaturationChange {
            //获取上下文
            UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.mainScreen().scale)
            let effectInContext:CGContext = UIGraphicsGetCurrentContext()!
            //该方法接收三个参数（图形上下文，x方向的缩放比例，y方向上的缩放比例
            CGContextScaleCTM(effectInContext, 1.0, -1.0)
            //该方法接收三个参数（图形上下文，x方向的偏移量，y方向上的偏移量）
            CGContextTranslateCTM(effectInContext, 0, -self.size.height)
            CGContextDrawImage(effectInContext, imageRect, self.CGImage)
            //图像缓存,输入缓存，输出缓存:宽，高，字节/行，data
            var effectInBuffer:vImage_Buffer = vImage_Buffer(data: CGBitmapContextGetData(effectInContext),
                                                             height: UInt(CGBitmapContextGetHeight(effectInContext)),
                                                             width: UInt(CGBitmapContextGetWidth(effectInContext)),
                                                             rowBytes:CGBitmapContextGetBytesPerRow(effectInContext))
            

            UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.mainScreen().scale)
            let effectOutContext:CGContext = UIGraphicsGetCurrentContext()!
            var effectOutBuffer:vImage_Buffer = vImage_Buffer(data: CGBitmapContextGetData(effectOutContext),
                                                             height: UInt(CGBitmapContextGetHeight(effectOutContext)),
                                                             width: UInt(CGBitmapContextGetWidth(effectOutContext)),
                                                             rowBytes:CGBitmapContextGetBytesPerRow(effectOutContext))
            
            if hasBlur {
                
                let inputRadius = blurRadius * UIScreen.mainScreen().scale
                var radius = UInt32(floor(Double(inputRadius) * 3 * sqrt(2 * M_PI) / 4 + 0.5));
                
                if radius % 2 != 1 {
                    radius += 1 // force radius to be odd so that the three box-blur methodology works.
                }
                var uint8 = UInt8(0)
                vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, nil, 0, 0, radius, radius, &uint8, UInt32(kvImageEdgeExtend));
                vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, nil, 0, 0, radius, radius, &uint8, UInt32(kvImageEdgeExtend));
                vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, nil, 0, 0, radius, radius, &uint8, UInt32(kvImageEdgeExtend));
            }
            
            var effectImageBuffersAreSwapped = false
            
            if hasSaturationChange {
                
                let s = saturationDeltaFactor
                
                let floatingPointSaturationMatrix:[CGFloat] = [
                    0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                    0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                    0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                    0,                    0,                    0,  1,
                    ]
                
                let divisor: Int32  = 256
                let matrixSize = sizeofValue(floatingPointSaturationMatrix)/sizeofValue(floatingPointSaturationMatrix[0])
                var saturationMatrix:[Int16] = Array()
                
                for i in 0..<matrixSize {
                    saturationMatrix.append( Int16(roundf(Float(floatingPointSaturationMatrix[i]) * Float(divisor))) )
                }
                
                if hasBlur {
                    vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, nil, nil, UInt32(kvImageNoFlags));
                    effectImageBuffersAreSwapped = true;
                }
                else {
                    vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, nil, nil, UInt32(kvImageNoFlags));
                }
            }
            
            if !effectImageBuffersAreSwapped  {
                effectImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext();
            }
            
            if effectImageBuffersAreSwapped {
                effectImage = UIGraphicsGetImageFromCurrentImageContext();
                UIGraphicsEndImageContext();
            }
        }
        
        // Set up output context.
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.mainScreen().scale)
        let outputContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(outputContext, 1.0, -1.0);
        CGContextTranslateCTM(outputContext, 0, -self.size.height);
        
        // Draw base image.
        CGContextDrawImage(outputContext, imageRect, self.CGImage);
        
        // Draw effect image.
        if hasBlur {
            CGContextSaveGState(outputContext);
            if maskImage != nil {
                CGContextClipToMask(outputContext, imageRect, maskImage!.CGImage);
            }
            CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
            CGContextRestoreGState(outputContext);
        }
        
        // Add in color tint.
        if tintColor != nil {
            CGContextSaveGState(outputContext);
            CGContextSetFillColorWithColor(outputContext, tintColor!.CGColor);
            CGContextFillRect(outputContext, imageRect);
            CGContextRestoreGState(outputContext);
        }
        
        // Output image is ready.
        let outputImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        return outputImage
        
    }

}

