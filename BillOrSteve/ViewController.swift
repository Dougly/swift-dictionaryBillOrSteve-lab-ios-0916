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
    
    // Create your stored properties here
    var facts: [String:[String]] = [:]
    var currentPersonAndFact: (person: String, fact: String) = ("","")
    var scoreTracker = 0
    var currentIndexOfFact = 0
    var noMoreFacts: (bill: Bool, steve: Bool) = (false, false)

    override func viewDidLoad() {
        createFacts()
        currentPersonAndFact = getRandomFact()
        print (currentPersonAndFact)
        fact.text = currentPersonAndFact.fact
        super.viewDidLoad()
    }

    @IBAction func billClicked(_ sender: AnyObject) {
        checkForEmptyArrays(billArray: facts["Bill Gates"]!, steveArray: facts["Steve Jobs"]!)
        checkAnswer(name: "Bill Gates")
        removeFact()
        determineNextQuestion()
    }
    
    @IBAction func steveClicked (_ sender: AnyObject) {
        checkForEmptyArrays(billArray: facts["Bill Gates"]!, steveArray: facts["Steve Jobs"]!)
        checkAnswer(name: "Steve Jobs")
        removeFact()
        determineNextQuestion()
    }
    
    
    
    
    // Helper Functions
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
            fact = facts[index]
        }
        currentIndexOfFact = index
        return (person, fact)
    }
    
    func checkAnswer (name: String) {
        if let allFacts = facts[name] {
            print (allFacts)
            for listedFact in allFacts {
                if currentPersonAndFact.fact == listedFact {
                    scoreTracker += 1
                    score.text = String(scoreTracker)
                }
            }
        }
    }
    
    func removeFact () {
        facts[currentPersonAndFact.person]?.remove(at: currentIndexOfFact)
    }
    
    func checkForEmptyArrays (billArray: [String], steveArray: [String]) {
        if !billArray.isEmpty && !steveArray.isEmpty {
            noMoreFacts = (false,false)
        } else if billArray.isEmpty && !steveArray.isEmpty {
            noMoreFacts = (true,false)
        } else if !billArray.isEmpty && steveArray.isEmpty {
            noMoreFacts = (false, true)
        } else {
            noMoreFacts = (true,true)
        }
    }
    
    func determineNextQuestion() {
        if noMoreFacts == (false, false) {
            currentPersonAndFact = getRandomFact()
        } else if noMoreFacts == (true, false) {
            currentPersonAndFact.person = "Steve Jobs"
            currentPersonAndFact.fact = facts["Steve Jobs"]![0]
        } else if noMoreFacts == (false, true) {
            currentPersonAndFact.person = "Bill Gates"
            currentPersonAndFact.fact = facts["Bill Gates"]![0]
        } else if noMoreFacts == (true, true) {
            fact.text = ("Final Score: \(scoreTracker)")
        }
    }
    
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
