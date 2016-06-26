//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

import AudioToolbox

let fileURL = NSURL(string: "SomeURL")
var theSoundID: SystemSoundID = 0
AudioServicesCreateSystemSoundID(fileURL!, &theSoundID)