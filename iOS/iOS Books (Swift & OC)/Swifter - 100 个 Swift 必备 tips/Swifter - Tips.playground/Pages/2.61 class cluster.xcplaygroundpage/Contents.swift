//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//在Objective－C中，init开头的初始化方法虽然打着初始化的口号，但是实际做的事情he其它方法没太大区别，在构建类簇时，在所谓的初始化方法中将self替代，返回私有的子类对象

//Swit拥有真正的初始化方法，构建类簇时，用工厂方法替代；


class Drinking {
    
    typealias LiquidColor = UIColor
    
    var color: LiquidColor {
        
        return LiquidColor.clearColor()
        
    }
    
    class func drinking(name: String) -> Drinking {
        
        var drinking: Drinking
        
        switch name {
            
        case "Coke":
            
            drinking = Coke()
            
        case "Beer":
            
            drinking = Beer()
            
        default:
            
            drinking = Drinking()
            
        }
        
        return drinking
        
    }
    
}

class Coke: Drinking {
    
    override var color: LiquidColor {
        
        return LiquidColor.blackColor()
        
    }
    
}

class Beer: Drinking {
    
    override var color: LiquidColor {
        
        return LiquidColor.yellowColor()
        
    }
    
}

let coke = Drinking.drinking("Coke")

coke.color // Black

let beer = Drinking.drinking("Beer")

beer.color // Yellow