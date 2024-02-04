import UIKit

// Checkpoint 8 Requirements

/*
 Your challenge is this: make a protocol that describes a building, adding various properties and methods, then create two structs, House and Office, that conform to it. Your protocol should require the following:

 A property storing how many rooms it has.
 A property storing the cost as an integer (e.g. 500,000 for a building costing $500,000.)
 A property storing the name of the estate agent responsible for selling the building.
 A method for printing the sales summary of the building, describing what it is along with its other properties.
*/

protocol Building {
    var rooms: Int { get set }
    var cost: Int { get set }
    var estateAgent: String { get set }
    func salesSummary()
}

struct House: Building {
    var rooms: Int
    var cost: Int
    var estateAgent: String

    func salesSummary() {
        print ("The cost of a house of \(rooms) rooms is $\(cost), sold by \(estateAgent).")
    }
}

struct Office: Building {
    var rooms: Int
    var cost: Int
    var estateAgent: String

    func salesSummary() {
        print ("The cost of an office of \(rooms) rooms is $\(cost), sold by \(estateAgent).")
    }
}

let house = House(rooms: 4, cost: 150_000, estateAgent: "ABC Realty")
house.salesSummary()

let office = Office(rooms: 15, cost: 1_000_000, estateAgent: "CBA Realty")
office.salesSummary()


// Output

/*
 The cost of a house of 4 rooms is $150000, sold by ABC Realty.
 The cost of an office of 15 rooms is $1000000, sold by CBA Realty.
 */
