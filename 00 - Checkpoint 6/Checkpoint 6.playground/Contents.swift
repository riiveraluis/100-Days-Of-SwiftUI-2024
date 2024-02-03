import UIKit

// Checkpoint 6 Requirements

/*
 Create a struct to store information about a car, including its model, number of seats, and current gear, then add a method to change gears up or down.
*/

struct Car {
    let model: String
    let numberOfSeats: Int
    let gearCount: Int
    
    private var gear: Int = 1 {
        didSet {
            print("\(model) is now on gear \(gear)")
        }
    }
    
    init(model: String, numberOfSeats: Int, gearCount: Int) {
        self.model = model
        self.numberOfSeats = numberOfSeats
        self.gearCount = gearCount
    }
    
    mutating func shiftGearUp() {
        if gear + 1 <= gearCount {
            gear += 1
        } else {
            print("\(model) can't shift up futher")
        }
    }
    
    mutating func shiftGearDown() {
        if gear - 1 >= 1 {
            gear -= 1
        } else {
            print("\(model) can't shift down futher")
        }
    }
}

var model3 = Car(model: "Tesla Model 3 Highland", numberOfSeats: 5, gearCount: 7)



model3.shiftGearUp()
model3.shiftGearDown()
model3.shiftGearDown()

for _ in 1...model3.gearCount {
    model3.shiftGearUp()
}

// Output

/*
 Tesla Model 3 Highland is now on gear 2
 Tesla Model 3 Highland is now on gear 1
 Tesla Model 3 Highland can't shift down futher
 Tesla Model 3 Highland is now on gear 2
 Tesla Model 3 Highland is now on gear 3
 Tesla Model 3 Highland is now on gear 4
 Tesla Model 3 Highland is now on gear 5
 Tesla Model 3 Highland is now on gear 6
 Tesla Model 3 Highland is now on gear 7
 Tesla Model 3 Highland can't shift up futher
 */
