import UIKit

// Checkpoint 9 Requirements

/*
 Your challenge is this: write a function that accepts an optional array of integers, and returns one randomly. If the array is missing or empty, return a random number in the range 1 through 100. You should be able to write this whole thing in one line of code.
*/

func randomIntFromInputOrDefault(input integers: [Int]?) -> Int {
    integers?.randomElement() ?? Int.random(in: 1...100)
}

let optionalIntegers: [Int]? = nil
let integersArray: [Int] = [1,2,3,4,5,6,7,8,9,10]
print(randomIntFromInputOrDefault(input: optionalIntegers))
print(randomIntFromInputOrDefault(input: integersArray))


// Output
/*
59
1
 */
