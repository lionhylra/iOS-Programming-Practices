/*
Question:
Given a list of integer numbers (greater than or equal to zero), and a integer number. Find all the possible pairs(pairs are unique).
For example,
given: [1,2,3,3,4,5,7,8] and 3
the pairs should be: (1,4) (2,5) (4,7) (5,8)
*/

//Swift 2.0
//Xcode 7.0.1

import UIKit

enum FindPairsError :ErrorType {
    case InvalidParameter
}

func findPairs(numbers numbers:[Int], difference:Int)throws ->Int{
    /* validate parameters */
    guard difference > 0 && numbers.count > 0 else {
        throw FindPairsError.InvalidParameter
    }
    
    /* Sort Array */
    let sortedArray = numbers.sort()
    /* Find unique pairs */
    var resultSet = Set<Int>()
    for i in 0 ..< sortedArray.count {
        let num = sortedArray[i]
        for j in i+1 ..< sortedArray.count where num == sortedArray[j] - difference {
            resultSet.insert(num)
        }
    }
    /* print */
    for num in resultSet {
        print("Find a pair: (\(num), \(num+difference))")
    }
    return resultSet.count
}

//test
func test(numbers numbers:[Int], difference:Int){
    print("======Test Begin=====")
    print("List: \(numbers)")
    print("Difference: \(difference)")
    do{
        let count = try findPairs(numbers: numbers, difference: difference)
        print("Find \(count) pairs")
    } catch {
        print("Parameters are invalid!")
    }
    print("======Test End======")
}
let list1 = [1,2,3,3,4,4,5,5,7,8]
let list2 = [1,1,2,2,3,6,6,7,7,8,8,8]
let list3 = [5,7,3,2,8,0,5,1,2,4]
test(numbers: list1, difference: 3)
test(numbers: list2, difference: 0)
test(numbers: list2, difference: 1)
test(numbers: list3, difference: 2)
test(numbers: list1, difference: -1)
