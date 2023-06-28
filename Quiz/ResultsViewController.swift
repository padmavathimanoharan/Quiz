//
//  ResultsViewController.swift
//  Quiz
//
//  Created by Padmavathi Sivakumar on 2023-06-28.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    var correctAnswers = 0
    var totalQuestions = 0
    
    override func viewDidLoad() {
            super.viewDidLoad()
            let percentage = Double(correctAnswers) / Double(totalQuestions) * 100
            let resultString = String(format: "You answered %.0f%% of the questions correctly.", percentage)
            resultLabel.text = resultString
        }
    
    @IBAction func back()  {
        let  vc = storyboard?.instantiateViewController(identifier: "home") as! HomeViewController
        vc.modalPresentationStyle  = .fullScreen
        present(vc, animated: true)
    }

    
}
