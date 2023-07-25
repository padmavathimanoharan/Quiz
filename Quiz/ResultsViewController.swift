//
//  ResultsViewController.swift
//  Quiz
//
//  Created by Padmavathi Sivakumar on 2023-06-28.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    var correctAnswers: [Int?] = []
    var totalQuestions: [Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showResults()
    }
    
    func showResults() {
        print(correctAnswers) // Print userSelectedAnswers for verification
        let correctAnswersCount = calculateCorrectAnswersCount()
        resultLabel.text = "You answered \(correctAnswersCount) out of \(totalQuestions.count) questions correctly!"
    }
    
    func calculateCorrectAnswersCount() -> Int {
        var correctAnswersCount = 0
        for (index, question) in totalQuestions.enumerated() {
            if let userSelectedAnswerIndex = correctAnswers[index], userSelectedAnswerIndex == question.correctAnswerIndex {
                correctAnswersCount += 1
                print("Question \(index+1) is correct") // Print if the question is correct
            } else {
                print("Question \(index+1) is incorrect") // Print if the question is incorrect
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
