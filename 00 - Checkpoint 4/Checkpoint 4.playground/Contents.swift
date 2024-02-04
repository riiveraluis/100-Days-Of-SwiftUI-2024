import UIKit

// Checkpoint 4 Requirements
/*
The challenge is this: write a function that accepts an integer from 1 through 10,000, and returns the integer square root of that number. That sounds easy, but there are some catches:

You can’t use Swift’s built-in sqrt() function or similar – you need to find the square root yourself.
If the number is less than 1 or greater than 10,000 you should throw an “out of bounds” error.
You should only consider integer square roots – don’t worry about the square root of 3 being 1.732, for example.
If you can’t find the square root, throw a “no root” error.
*/

enum InputErrors: Error {
    case OutOfBounds
}

enum OutputErrors: Error {
    case noRoot
}

func customSqrt(of number: Int) throws {
    guard number >= 1 && number <= 10_000 else {
        throw InputErrors.OutOfBounds
    }
    
    var result = 0
    
    for i in 1...10_000 {
        if i * i == number {
            result = i
            print("The square root of \(number) is \(result).")
            return
        }
    }
    throw OutputErrors.noRoot
}

// Good attempt
do {
    try customSqrt(of: 10000)
} catch {
    switch error {
    case InputErrors.OutOfBounds:
        print("You entered a number outside permited range (1 to 10,000")
    case OutputErrors.noRoot:
        print("No integer root was found")
    default:
        print("Unexpected error!")
    }
}

// Fail attempt out of bounds
do {
    try customSqrt(of: -10000)
} catch {
    switch error {
    case InputErrors.OutOfBounds:
        print("You entered a number outside permited range (1 to 10,000)")
    case OutputErrors.noRoot:
        print("No integer root was found")
    default:
        print("Unexpected error!")
    }
}

// Fail attempt no root found
do {
    try customSqrt(of: 7)
} catch {
    switch error {
    case InputErrors.OutOfBounds:
        print("You entered a number outside permited range (1 to 10,000)")
    case OutputErrors.noRoot:
        print("No integer root was found")
    default:
        print("Unexpected error!")
    }
}

// Output
/*
 The square root of 10000 is 100.
 You entered a number outside permited range (1 to 10,000)
 No integer root was found
 */
