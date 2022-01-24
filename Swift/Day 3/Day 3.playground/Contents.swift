import UIKit

// MARK: - Arithmetic operators

let firstSccore = 12
let secondSccore = 4

let total = firstSccore + secondSccore
let difference = firstSccore - secondSccore

let product = firstSccore * secondSccore
let divided = firstSccore / secondSccore

let remainder = 13 % secondSccore


// MARK: - Operator Overloading

let meaningOfLife = 42
let doubleMeaningOfLife = 42 + 42

let fakers = "Fakers gonna"
let action = fakers + "fake"

let firstHalf = ["John", "Paul"]
let secondHalf = ["George", "Ringo"]
let beatles = firstHalf + secondHalf

// MARK: - Compound Assignment Operators

var score = 95
score -= 5

var quote = "The rain in Spain fals mainly on the"
quote += "Spaniards"


// MARK: - Comparison Operators

let firstScore = 6
let secondScore = 4

firstScore == secondScore
firstScore != secondScore
firstScore >= secondScore
firstScore < secondScore


// MARK: - Conditions

let firstCard = 11
let secondCard = 10

if firstCard + secondCard == 21 {
    print("Aces - Lucky!")
} else if firstCard + secondCard == 21 {
    print("Blackjack!")
} else {
    print("Regular cards")
}

// MARK: - Combining Conditions

let age1 = 12
let age2 = 21

if age1 > 18 && age2 > 18 {
    print("Both are over 18")
}

if age1 > 18 || age2 > 18 {
    print("At least one is over 18")
}

// MARK: - The ternary Operator

let firstCardd = 11
let secondCardd = 10
print(firstCardd == secondCardd ? "Cards are the same" : "Cards are different")


// MARK: - Switch Statements

let weather = "sunny"

switch weather {
case "rain":
    print("Bring an umbrella")
case "snow":
    print("Wrap up warm")
case "sunny":
    print("Wear sunscreen")
    fallthrough
default:
    print("Enjoy your day!")
}


// MARK: - Range operators

let aScore = 85

switch aScore {
case 0..<50:
    print("You failed badly.")
case 50..<85:
    print("You did OK.")
default:
    print("You did great!")
}
