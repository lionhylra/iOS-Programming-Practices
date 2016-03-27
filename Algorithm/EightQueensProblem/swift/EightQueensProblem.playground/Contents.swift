//: Playground - noun: a place where people can play

import UIKit

struct Point:CustomStringConvertible{
    var x:Int
    var y:Int!
    var description: String{
        return "(\(x),\(y))"
    }
    func isConflictWith(point:Point) -> Bool{
        if point.x == x {
            return true
        }
        if point.y == y {
            return true
        }
        if point.x + point.y == x + y {
            return true
        }
        if point.x - point.y == x - y {
            return true
        }
        return false
    }
}

var resultCount = 0
func findPositionFor(var queens:[Point], withDecidedQueens decidedQueens:[Point]){
    guard queens.count > 0 else {
        print("Result\(++resultCount):")
        for queen in decidedQueens {
            print(queen)
        }
        return
    }
    var queen = queens.removeFirst()
    
    OutsideLoop: for i in 0...7 {
        queen.y = i
        for existingQueen in decidedQueens {
            if queen.isConflictWith(existingQueen){
                continue OutsideLoop
            }
        }
        var decidedQueensCopy = decidedQueens
        decidedQueensCopy.append(queen)
        findPositionFor(queens, withDecidedQueens: decidedQueensCopy)
    }
}

func test(){
    var queens = [Point]()
    for i in 0...7 {
        queens.append(Point(x: i, y: nil))
    }
    
    findPositionFor(queens, withDecidedQueens: [Point]())
    
}

test()







