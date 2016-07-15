//: Playground - noun: a place where people can play

import UIKit

typealias Distance = Double

struct Position {
    var x: Double
    var y: Double
}

extension Position {
    func inRange(range: Distance) -> Bool {
        return sqrt( x * x + y * y) <= range
    }
}

struct Ship {
    var position: Position
    var firingRange: Distance
    var unsafeRange: Distance
}

extension Ship {
    func canSafelyEngageShip(target: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx + dy * dy)
        return targetDistance <= firingRange && targetDistance >= unsafeRange
    }
}

extension Ship {
    func canSafelyEngageShip1(target: Ship, friendly: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx + dy * dy)
        let friendlyDx = friendly.position.x - target.position.x
        let friendlyDy = friendly.position.y - target.position.y
        let friendlyDistance = sqrt(friendlyDx * friendlyDx +
            friendlyDy * friendlyDy)
        return targetDistance <= firingRange
            && targetDistance > unsafeRange
            && (friendlyDistance > unsafeRange)
    }
}

extension Position {
    func minus(p: Position) -> Position {
        return Position(x: x - p.x, y: y - p.y)
    }
    var length: Double {
        return sqrt(x * x + y * y)
    }
    func distanceToPosition(position: Position) -> Double {
        return self.minus(position).length
    }
}

extension Ship {
    func canSafelyEngageShip2(target: Ship, friendly: Ship) -> Bool {
        let targetDistance = target.position.distanceToPosition(position)
        let friendlyDistance = friendly.position.distanceToPosition(position)
        return targetDistance <= firingRange
            && targetDistance > unsafeRange
            && (friendlyDistance > unsafeRange)
    }
}

// MARK: First-Class Functions

typealias Region = Position -> Bool

func circle(radius: Distance) -> Region {
    return { point in point.length <= radius }
}

func cirlce2(radius: Distance, center: Position) -> Region {
    return { point in point.minus(center).length <= radius }
}

func shift(region: Region, offset: Position) -> Region {
    return { point in region(point.minus(offset)) }
}

shift(circle(10), offset: Position(x: 5, y: 5))

func invert(region: Region) -> Region {
    return { point in !region(point) }
}

func intersection(region1: Region, _ region2: Region) -> Region {
    return { point in region1(point) && region2(point) }
}

func union(region1: Region, _ region2: Region) -> Region {
    return { point in region1(point) || region2(point) }
}

func difference(region: Region, minus: Region) -> Region {
    return intersection(region, invert(minus))
}

extension Ship {
    func canSafelyEngageShip(target: Ship, friendly: Ship) -> Bool {
        let rangeRegion = difference(circle(firingRange), minus: circle(unsafeRange))
        let firingRegion = shift(rangeRegion, offset: position)
        let friednlyRegion = shift(circle(unsafeRange), offset: friendly.position)
        let resultRegion = difference(firingRegion, minus: friednlyRegion)
        return resultRegion(target.position)
    }
}
