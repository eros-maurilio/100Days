import UIKit

// MARK: - Arrays

let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles = [john, paul, george, ringo]

beatles[1]


// MARK: - Sets

let colors = Set(["red", "green", "blue"])

// Random order
// No item can appear twice in a set

let colors2 = Set(["red", "green", "blue", "red", "blue"])


// MARK: - Tuples

var name = (first: "Taylor", last: "Swift")

name.first
name.last


// MARK: - Arrays vs sets vs tuples

let address = (house: 555, street: "Taylor Swift Avenue", city: "Nashville")

let set = Set(["aardvark", "astronaut", "azalea"])

let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]


// MARK: - Dictionaries

let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]

heights["Taylor Swift"]


// MARK: - Dictionary Default Values

let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]

favoriteIceCream["Paul"]

favoriteIceCream["Charlotte"]

favoriteIceCream["Charlotte", default: "Unknow"]

favoriteIceCream["Test"]


// MARK: - Creating Empty Collections

var teams = [String: String]()
var teams1: Dictionary<String, String>
teams["Paul"] = "Red"

var results = [Int]()
var result3: [Int]

var words = Set<String>()
var numbers = Set<Int>()
var sets: Set<Int>

var scores = Dictionary<String, Int>()
var results1 = Array<Int>()


// MARK: - Creating Empty Collections

enum Result {
    case success
    case failure
}

let result4 = Result.failure


// MARK: - Enum Associated values

enum Activity {
    case bored
    case running(destination: String)
    case talking(topic: String)
    case singing(volume: Int)
}

let talking = Activity.talking(topic: "football")

switch talking {

case .bored:
    print("bored")
case .running(destination: let destination):
    print("im running")
case .talking(topic: let topic):
    print("talking about \(topic)")
case .singing(volume: let volume):
    print("singin")
}


// MARK: - Enum Raw Values

enum Planet: Int {
    case mercury
    case venus
    case earth
    case mars
}

let whatPlanet = Planet(rawValue: 3)
let marsNum = Planet.mars.rawValue
