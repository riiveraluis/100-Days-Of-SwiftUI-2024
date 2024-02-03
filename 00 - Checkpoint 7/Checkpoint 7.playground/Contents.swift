import UIKit

// Checkpoint 7 Requirements

/*
 Your challenge is this: make a class hierarchy for animals, starting with Animal at the top, then Dog and Cat as subclasses, then Corgi and Poodle as subclasses of Dog, and Persian and Lion as subclasses of Cat.

 But there’s more:

 The Animal class should have a legs integer property that tracks how many legs the animal has.
 The Dog class should have a speak() method that prints a generic dog barking string, but each of the subclasses should print something slightly different.
 The Cat class should have a matching speak() method, again with each subclass printing something different.
 The Cat class should have an isTame Boolean property, provided using an initializer.
*/

class Animal {
    let legs: Int
    
    init(legs: Int) {
        self.legs = legs
    }
}

class Dog: Animal {
    override init(legs: Int) {
        super.init(legs: 4)
    }
    
    func speak() {
        print("Normal dog woof woof!")
    }
}

class Cat: Animal {
    var isTame: Bool
    
    init(isTame: Bool, legs: Int) {
        self.isTame = isTame
        super.init(legs: legs)
    }
    
    func speak() {
        print("Normal cat meow meow!")
    }
}

class Corgi: Dog {
    override init(legs: Int) {
        super.init(legs: 4)
    }
    
    override func speak() {
        print("Corgi starts to bark wufwuf!")
    }
}

class Poodle: Dog {
    override init(legs: Int) {
        super.init(legs: 4)
    }
    
    override func speak() {
        print("Poodle starts to bark woff! woff!")
    }
}

class Persian: Cat {
    override init(isTame: Bool, legs: Int) {
        super.init(isTame: isTame, legs: legs)
    }
    
    override func speak() {
        print("Persian starts to growl meoww!")
    }
}


class Lion: Cat {
    override init(isTame: Bool, legs: Int) {
        super.init(isTame: isTame, legs: legs)
    }
    
    override func speak() {
        print("Lion starts to growl roughrrrrr!")
    }
}

let standardDog = Dog(legs: 4)
standardDog.speak()

let poodleDog = Poodle(legs: 4)
poodleDog.speak()

let standardCat = Cat(isTame: false, legs: 4)
standardCat.speak()

let persianCat = Persian(isTame: true, legs: 4)
persianCat.speak()


// Output

/*
 Normal dog woof woof!
 Poodle starts to bark woff! woff!
 Normal cat meow meow!
 Persian starts to growl meoww!
 */
