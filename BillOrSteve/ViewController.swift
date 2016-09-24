//
//  ViewController.swift
//  BillOrSteve
//
//  Created by James Campagno on 6/8/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var fact: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var playAgain: UIButton!
    
    // Create your stored properties here
    var facts: [String:[String]] = [:]
    var currentPersonAndFact: (person: String, fact: String) = ("","")
    var scoreTracker = 0
    var currentIndexOfFact = 0
    var billEmpty = false
    var steveEmpty = false

    override func viewDidLoad() {
        createFacts()
        playAgain.isHidden = true
        currentPersonAndFact = getRandomFact()
        fact.text = currentPersonAndFact.fact
        super.viewDidLoad()
    }

    @IBAction func billClicked(_ sender: AnyObject) {
        pressedButton(person: "Bill Gates")
    }
    
    @IBAction func steveClicked (_ sender: AnyObject) {
        pressedButton(person: "Steve Jobs")
    }
    
    
    @IBAction func playAgainClicked(_ sender: AnyObject) {
        viewDidLoad()
        scoreTracker = 0
        score.text = String(scoreTracker)
    }
    
    
    
    
    // Helper Functions
    
    //pulls random fact for bill or steve from facts dictionary
    func getRandomFact () -> (String, String) {
        
        let person = randomPerson()
        var index = 0
        var fact = ""
        
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
        if let facts = facts[person] {
            if !facts.isEmpty {
                fact = facts[index]
            }
        }
        currentIndexOfFact = index
        return (person, fact)
    }
    
    //checks to see if answer is correct and increments score
    func checkAnswer (name: String) {
        if currentPersonAndFact.person == name {
            scoreTracker += 1
            score.text = String(scoreTracker)
        }
    }
    
    //removes current fact from steve or bills array
    func removeFact () {
        if var currentFacts = facts[currentPersonAndFact.person] {
            if !currentFacts.isEmpty {
                currentFacts.remove(at: currentIndexOfFact)
                facts[currentPersonAndFact.person] = currentFacts
            }
        }
    }
    
    //determines if steve or bill have empty arrays to avoid index out of range exception
    func checkForEmptyArrays (billArray: [String], steveArray: [String]) {
        if !billArray.isEmpty && !steveArray.isEmpty {
            billEmpty = false
            steveEmpty = false
        } else if billArray.isEmpty && !steveArray.isEmpty {
            billEmpty = true
            steveEmpty = false
        } else if !billArray.isEmpty && steveArray.isEmpty {
            billEmpty = false
            steveEmpty = true
        } else {
            billEmpty = true
            steveEmpty = true
        }
    }
    
    //determins where to grab next question if steve or bill have no more facts
    func determineNextQuestion() {
        if !billEmpty && !steveEmpty {
            currentPersonAndFact = getRandomFact()
        } else if billEmpty && !steveEmpty {
            currentPersonAndFact.person = "Steve Jobs"
            currentPersonAndFact.fact = facts["Steve Jobs"]![0]
        } else if !billEmpty && steveEmpty {
            currentPersonAndFact.person = "Bill Gates"
            currentPersonAndFact.fact = facts["Bill Gates"]![0]
        } else {
            currentPersonAndFact.fact = ("Final Score: \(scoreTracker)/9")
            currentPersonAndFact.person = "Game Over"
            playAgain.isHidden = false
        }
    }
    
    //sequence of actions when button is pressed
    func pressedButton (person: String) {
        //checkForEmptyArrays(billArray: facts["Bill Gates"]!, steveArray: facts["Steve Jobs"]!)
        checkAnswer(name: person)
        removeFact()
        checkForEmptyArrays(billArray: facts["Bill Gates"]!, steveArray: facts["Steve Jobs"]!)
        determineNextQuestion()
        fact.text = currentPersonAndFact.fact
    }
    
    //chooses random index out of an array
    func randomIndex(fromArray array: [String]) -> Int {
        return Int(arc4random_uniform(UInt32(array.count)))
    }
    
    //chooses steve or bill randomly
    func randomPerson() -> String {
        let randomNumber = arc4random_uniform(2)
        
        if randomNumber == 0 {
            return "Steve Jobs"
        } else {
            return "Bill Gates"
        }
    }
    
    //populates facts dictonary
    func createFacts () {
        let billFacts = [
            "He aimed to become a millionaire by the age of 30. However, he became a billionaire at 31.",
            "He scored 1590 (out of 1600) on his SATs.",
            "His foundation spends more on global health each year than the United Nation's World Health Organization.",
            "The private school he attended as a child was one of the only schools in the US with a computer. The first program he ever used was a tic-tac-toe game.",
            "In 1994, he was asked by a TV interviewer if he could jump over a chair from a standing position. He promptly took the challenge and leapt over the chair like a boss."
        ]
        let steveFacts = [
            "He took a calligraphy course, which he says was instrumental in the future company products' attention to typography and font.",
            "Shortly after being shooed out of his company, he applied to fly on the Space Shuttle as a civilian astronaut (he was rejected) and even considered starting a computer company in the Soviet Union.",
            "He actually served as a mentor for Google founders Sergey Brin and Larry Page, even sharing some of his advisers with the Google duo.",
            "He was a pescetarian, meaning he ate no meat except for fish."
        ]
        facts["Bill Gates"] = billFacts
        facts["Steve Jobs"] = steveFacts
    }
}
