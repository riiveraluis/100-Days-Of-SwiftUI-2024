import UIKit


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
