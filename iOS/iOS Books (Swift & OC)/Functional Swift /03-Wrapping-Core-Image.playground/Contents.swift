//: Playground - noun: a place where people can play

import Cocoa

typealias Filter = CIImage -> CIImage

func blur(radius: Double) -> Filter {
    return { image in
        let parameters = [
            kCIInputRadiusKey: radius,
            kCIInputImageKey : image
        ]
        guard let filter = CIFilter(name: "CIGaussianBlur",
            withInputParameters: parameters) else { fatalError() }
        guard let outputImage = filter.outputImage else { fatalError() }
        
        return outputImage
    }
}

func colorGenerator(color: NSColor) -> Filter {
    return { _ in
        guard let c = CIColor(color: color) else { fatalError() }
        let parameters = [kCIInputColorKey : c]
        guard let filter = CIFilter(name: "CIConstantColorGenerator", withInputParameters: parameters) else { fatalError() }
        guard let outputImage = filter.outputImage else { fatalError() }
        return outputImage
    }
}

func compositeSourceOver(overlay: CIImage) -> Filter {
    return { image in
        let parameters = [
            kCIInputBackgroundImageKey : image,
            kCIInputImageKey           : overlay
        ]
        guard let filter = CIFilter(name: "CISourceOverCompositing", withInputParameters: parameters) else { fatalError() }
        guard let outputImage = filter.outputImage else { fatalError() }
        let cropRect = image.extent
        return outputImage.imageByCroppingToRect(cropRect)
    }
}

func colorOverlay(color: NSColor) -> Filter {
    return { image in
        let overlay = colorGenerator(color)(image)
         return compositeSourceOver(overlay)(image)
    }
}

let url = NSURL(string: "http://upload-images.jianshu.io/upload_images/822518-be452bc83fb02b4f.jpg")!
let image = CIImage(contentsOfURL: url)!

let blurRadius = 5.0
let overlayColor = NSColor.redColor().colorWithAlphaComponent(0.2)
let blurredImage = blur(blurRadius)(image)
let overlaidImage = colorOverlay(overlayColor)(image)

let result = colorOverlay(overlayColor)(blur(blurRadius)(image))

func composeFilters(filter1: Filter, _ filter2: Filter) -> Filter {
    return { image in filter2(filter1(image)) }
}

let myFilter1 = composeFilters(blur(blurRadius), colorOverlay(overlayColor))
let result1 = myFilter1(image)

infix operator >>> { associativity left }

func >>> (lhs: Filter, rhs: Filter) -> Filter {
    return { image in rhs(lhs(image)) }
}

let myFilter2 = blur(blurRadius) >>> colorOverlay(overlayColor)
let result2 = myFilter2(image)

func add1(x: Int, _ y: Int) -> Int {
    return x + y
}

func add2(x: Int) -> (Int -> Int) {
    return { y in x + y }
}

add1(1, 2)
add2(1)(2)


