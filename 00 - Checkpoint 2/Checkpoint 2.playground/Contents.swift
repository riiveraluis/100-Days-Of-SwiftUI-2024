import UIKit

// Checkpoint 2 Requirements
/*
This time the challenge is to create an array of strings, then write some code that prints the number of items in the array and also the number of unique items in the array.
*/

let arrayOfStrings: [String] = ["Apple", "iOS", "SwiftUI", "Hacking with Swift", "Apple"]

print("The array of strings contains \(arrayOfStrings.count) elements")
print("Meanwhile the same array contains \(Set(arrayOfStrings).count) unique items.")

// Output
/*
 The array of strings contains 5 elements
 Meanwhile the same array contains 4 unique items.
 */
