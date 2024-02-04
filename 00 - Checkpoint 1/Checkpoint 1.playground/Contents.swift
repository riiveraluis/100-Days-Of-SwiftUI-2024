import UIKit

// Checkpoint 1 Requirements

/*
 Your goal is to write a Swift playground that:

 Creates a constant holding any temperature in Celsius.
 Converts it to Fahrenheit by multiplying by 9, dividing by 5, then adding 32.
 Prints the result for the user, showing both the Celsius and Fahrenheit values.
*/

let celsius = 20.0

let connvertedToFahrenheit = (celsius * 9.0) / 5.0 + 32.0

print("º\(celsius)C is \(connvertedToFahrenheit)ºF")

// Output
/*
 º20.0C is 68.0ºF
 */
