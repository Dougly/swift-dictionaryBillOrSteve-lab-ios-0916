//: Playground - noun: a place where people can play

import UIKit

var facts: [String:[String]] = [:]
var currentPersonAndFact: (person: String, fact: String) = ("","")
var scoreTracker = 0
var currentIndexOfFact = 0

func randomIndex(fromArray array: [String]) -> Int {
    return Int(arc4random_uniform(UInt32(array.count)))
}

func randomPerson() -> String {
    let randomNumber = arc4random_uniform(2)
    
    if randomNumber == 0 {
        return "Steve Jobs"
    } else {
        return "Bill Gates"
    }
}

func checkAnswer (name: String) {
    if let allFacts = facts[currentPersonAndFact.person] {
        for listedFact in allFacts {
            if currentPersonAndFact.fact == listedFact {
                scoreTracker += 1
            }
        }
    }
}

func checkIfArrayIsEmpty (myArray: [String]) -> Bool {
    if myArray.isEmpty {
        return true
    } else {
        return false
    }
}

func getRandomFact () -> (String, String) {
    let person = randomPerson()
    var index = 0
    var theFact = ""
    
    //if !facts[person]?.isEmpty
    /*
    if person == "Bill Gates" && !(facts[person]?.isEmpty)! {
        if let person = facts["Bill Gates"] {
            index = randomIndex(fromArray: person)
        }
    }else if person == "Steve Jobs" && !(facts[person]?.isEmpty)! {
        if let person = facts["Steve Jobs"] {
            index = randomIndex(fromArray: person)
        }
    }
    */
    switch person {
    case "Bill Gates":
        if let person = facts["Bill Gates"] {
            index = randomIndex(fromArray: person)
        }
        break
    case "Steve Jobs":
        if let person = facts["Steve Jobs"] {
            index = randomIndex(fromArray: person)
        }
        break
    default:
        break
    }
    
    if let fact = facts[person] {
        theFact = fact[index]
    }
    //currentIndexOfFact = index
    return (person, theFact)
}

func removeFact () {
    facts[currentPersonAndFact.person]?.remove(at: currentIndexOfFact)
}


func createFacts () {
    let billFacts = [
            "He aimed to become a millionaire by the age of 30. However, he became a billionaire at 31.",
            "He scored 1590 (out of 1600) on his SATs.",
            "His foundation spends more on global health each year than the United Nation's World Health Organization.",
            "The private school he attended as a child was one of the only schools in the US with a computer. The first program he ever used was a tic-tac-toe game.",
            "In 1994, he was asked by a TV interviewer if he could jump over a chair from a standing position. He promptly took the challenge and leapt over the chair like a boss."]
    let steveFacts = [
            "He took a calligraphy course, which he says was instrumental in the future company products' attention to typography and font.",
            "Shortly after being shooed out of his company, he applied to fly on the Space Shuttle as a civilian astronaut (he was rejected) and even considered starting a computer company in the Soviet Union.",
            "He actually served as a mentor for Google founders Sergey Brin and Larry Page, even sharing some of his advisers with the Google duo.",
            "He was a pescetarian, meaning he ate no meat except for fish."]
        
        facts["Bill Gates"] = billFacts
        facts["Steve Jobs"] = steveFacts
}
createFacts()
//print (facts)

currentPersonAndFact = getRandomFact()

func showResults () {
    print ("Current person is: \(currentPersonAndFact.person)\nCurrent Facts is: \(currentPersonAndFact.fact)")
    print("Remaining Facts:")
    for (index, item) in facts[currentPersonAndFact.person]!.enumerated() {
        print ("\(index + 1). \(item)")
    }
    print ("")
}

func buttonHit () {
    if !checkIfArrayIsEmpty(myArray: facts["Bill Gates"]!)
        && !checkIfArrayIsEmpty(myArray: facts["Steve Jobs"]!){
        currentPersonAndFact = getRandomFact()
        showResults()
        removeFact()
    } else if checkIfArrayIsEmpty(myArray: facts["Bill Gates"]!)
        && !checkIfArrayIsEmpty(myArray: facts["Steve Jobs"]!) {
        currentPersonAndFact.person = "Steve Jobs"
        currentPersonAndFact.fact = facts["Steve Jobs"]![0]
        showResults()
        removeFact()
    } else if !checkIfArrayIsEmpty(myArray: facts["Bill Gates"]!)
        && checkIfArrayIsEmpty(myArray: facts["Steve Jobs"]!){
        currentPersonAndFact.person = "Bill Gates"
        currentPersonAndFact.fact = facts["Bill Gates"]![0]
        showResults()
        removeFact()
    } else if checkIfArrayIsEmpty(myArray: facts["Bill Gates"]!)
        && checkIfArrayIsEmpty(myArray: facts["Steve Jobs"]!){
        print ("End of Trivia")
    }
}

buttonHit()
buttonHit()
buttonHit()
buttonHit()
buttonHit()
buttonHit()
buttonHit()
buttonHit()
buttonHit()
buttonHit()
buttonHit()
buttonHit()
buttonHit()
buttonHit()
buttonHit()
buttonHit()
buttonHit()













