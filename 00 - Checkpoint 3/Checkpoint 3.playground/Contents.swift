import UIKit

// Checkpoint 3 Requirements
/*
 The problem is called fizz buzz, and has been used in job interviews, university entrance tests, and more for as long as I can remember. Your goal is to loop from 1 through 100, and for each number:

 If it’s a multiple of 3, print “Fizz”
 If it’s a multiple of 5, print “Buzz”
 If it’s a multiple of 3 and 5, print “FizzBuzz”
 Otherwise, just print the number.
 So, here are some example values you should have when your code runs:

 1 should print “1”
 2 should print “2”
 3 should print “Fizz”
 4 should print “4”
 5 should print “Buzz”
 6 should print “Fizz”
 7 should print “7”
 …
 15 should print “FizzBuzz”
 …
 100 should print “Buzz”
*/

for i in 1...100 {
    if i.isMultiple(of: 3) && i.isMultiple(of: 5) {
        print("\(i) FizzBuzz")
    } else if i.isMultiple(of: 3) {
        print("\(i) Fizz")
    } else if i.isMultiple(of: 5) {
        print("\(i) Buzz")
    } else {
        print(i)
    }
}

// Output
/*
 1
 2
 3 Fizz
 4
 5 Buzz
 6 Fizz
 7
 8
 9 Fizz
 10 Buzz
 11
 12 Fizz
 13
 14
 15 FizzBuzz
 16
 17
 18 Fizz
 19
 20 Buzz
 21 Fizz
 22
 23
 24 Fizz
 25 Buzz
 26
 27 Fizz
 28
 29
 30 FizzBuzz
 31
 32
 33 Fizz
 34
 35 Buzz
 36 Fizz
 37
 38
 39 Fizz
 40 Buzz
 41
 42 Fizz
 43
 44
 45 FizzBuzz
 46
 47
 48 Fizz
 49
 50 Buzz
 51 Fizz
 52
 53
 54 Fizz
 55 Buzz
 56
 57 Fizz
 58
 59
 60 FizzBuzz
 61
 62
 63 Fizz
 64
 65 Buzz
 66 Fizz
 67
 68
 69 Fizz
 70 Buzz
 71
 72 Fizz
 73
 74
 75 FizzBuzz
 76
 77
 78 Fizz
 79
 80 Buzz
 81 Fizz
 82
 83
 84 Fizz
 85 Buzz
 86
 87 Fizz
 88
 89
 90 FizzBuzz
 91
 92
 93 Fizz
 94
 95 Buzz
 96 Fizz
 97
 98
 99 Fizz
 100 Buzz
 */

