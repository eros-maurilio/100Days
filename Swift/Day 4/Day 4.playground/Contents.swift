import UIKit

// MARK: - For loops

let count = 1...10

for number in count {
    print("Number is \(number)")
}

let albums = ["Red", "1989", "Reputation"]

for album in albums {
    print("\(album) is on Apple Music")
}

print("Players gonna ")

for _ in 1...5 {
    print("play")
}

// MARK: - While loops

var number = 1

while number <= 20 {
    print(number)
    number += 1
}

print("Ready or not, here I come!")

// MARK: - Repeat loops

repeat {
    print(number)
    number += 1
} while number <= 20

while false {
    print("This is false")
}

// != /\ \/

repeat {
    print("This is false")
} while false

print("Ready or not, here I come!")


// MARK: - Exiting loops

var countDown = 10

while countDown >= 0 {
    print(countDown)

    if countDown == 4 {
        print("I'm bored. Let's go now!")
        break
    }

    countDown -= 1
}

// MARK: - Exiting multiple loops

outerLoop: for i in 1...10 {
    for j in 1...10 {
        let product = i * j
        print ("\(i) * \(j) is \(product)")

        if product == 50 {
            print("It's a bullseye!")
            break outerLoop
        }
    }
}

// MARK: - Skipping items

for i in 1...10 {
    if i % 2 == 1 {
        continue
    }
    print(i)
}

// MARK: - Infinite loops

var counter = 0

while true {
    print(" ")
    counter += 1

    if counter == 273 {
        break
    }
}

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
