//
//  ResultsViewController.swift
//  Quiz
//
//  Created by Padmavathi Sivakumar on 2023-06-28.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var resultNote: UILabel!
    
    var correctAnswers: [Int?] = []
    var totalQuestions: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showResults()
    }
    
    func showResults() {
        let correctAnswersCount = calculateCorrectAnswersCount()
        resultLabel.text = "\(correctAnswersCount)/\(totalQuestions.count)"
        
        if correctAnswersCount < 5 {
            resultNote.text = "Learn more and Try again!."
        } else if correctAnswersCount >= 5 && correctAnswersCount <= 8 {
            resultNote.text = "Good job! You can improve."
        } else {
            resultNote.text = "Congratulations! You did a great job!"
        }
    }
    
    func calculateCorrectAnswersCount() -> Int {
        var correctAnswersCount = 0
        for (index, question) in totalQuestions.enumerated() {
            if let userSelectedAnswerIndex = correctAnswers[index], userSelectedAnswerIndex == question.correctAnswerIndex {
                correctAnswersCount += 1
            }
        }
        return correctAnswersCount
    }
    
    @IBAction func back()  {
        let  vc = storyboard?.instantiateViewController(identifier: "home") as! HomeViewController
        vc.modalPresentationStyle  = .fullScreen
        present(vc, animated: true)
    }

    
}
