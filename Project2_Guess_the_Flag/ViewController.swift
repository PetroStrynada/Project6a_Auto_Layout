//
//  ViewController.swift
//  Project2_Guess_the_Flag
//
//  Created by Petro Strynada on 03.06.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!


    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    let numberOfRounds = 10
    var roundNumber = 1

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .pause, target: self, action: #selector(scoreCheck))

        countries.append(contentsOf: ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "spain", "uk", "us"])


        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1

        button1.layer.borderColor = UIColor.black.cgColor
        button2.layer.borderColor = UIColor.black.cgColor
        button3.layer.borderColor = UIColor.black.cgColor

        askQuestion(action: nil)
    }

    @objc func scoreCheck() {
        let ac = UIAlertController(title: "Your current score is \(score)", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default))
        present(ac, animated: true)
    }

    func askQuestion(action: UIAlertAction!) {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)

        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)

        title = "Round \(roundNumber) of \(numberOfRounds). Guess \(countries[correctAnswer].uppercased())"
    }

    func restartGame() {
        score = 0
        correctAnswer = 0
        roundNumber = 1
    }

    @IBAction func buttonTapped(_ sender: UIButton) {
        var title: String
        var massage: String
        let scoreMassage: String

        if sender.tag == correctAnswer {
            title = "Correct"
            score += 1
            massage = ""
        } else {
            title = "Wrong"
            score -= 1
            massage = "Ops, you did mistake\n"
        }
        scoreMassage = "Your score is \(score)"
        roundNumber += 1

        guard roundNumber != numberOfRounds else {
            let ac = UIAlertController(title: "\(title)\nThe last round", message: massage + scoreMassage, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
            return present(ac, animated: true)
        }

        guard roundNumber != numberOfRounds + 1 else {
            let ac = UIAlertController(title: "\(title)", message: "\(massage)Your total score \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Start new game", style: .default, handler: askQuestion))
            restartGame()
            return present(ac, animated: true)
        }

        let ac = UIAlertController(title: title, message: massage + scoreMassage, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))


        present(ac, animated: true)
    }



}




/*
 var title: String
 var massage: String
 let scoreMassage: String

 if sender.tag == correctAnswer {
     title = "Correct"
     score += 1
     massage = ""
 } else {
     title = "Wrong"
     score -= 1
     massage = "Ops, you did mistake\n"
 }
 scoreMassage = "Your score is \(score)"
 roundNumber += 1

 guard roundNumber != numberOfRounds else {
     let ac = UIAlertController(title: "\(title)\nThe last round", message: massage + scoreMassage, preferredStyle: .alert)
     ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
     return present(ac, animated: true)
 }

 guard roundNumber != numberOfRounds + 1 else {
     let ac = UIAlertController(title: "\(title)", message: "\(massage)Your total score \(score)", preferredStyle: .alert)
     ac.addAction(UIAlertAction(title: "Start new game", style: .default, handler: askQuestion))
     restartGame()
     return present(ac, animated: true)
 }

 let ac = UIAlertController(title: title, message: massage + scoreMassage, preferredStyle: .alert)
 ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))


 present(ac, animated: true)
 */
