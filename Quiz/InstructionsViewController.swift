//
//  InstructionsViewController.swift
//  Quiz
//
//  Created by Padmavathi Sivakumar on 2023-06-27.
//

import UIKit

class InstructionsViewController: UIViewController {
    
    @IBOutlet weak var  dateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let curDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        let dateString = formatter.string(from: curDate)
        dateLabel.text  = "Date : " + dateString
    }

    @IBAction func startQuiz()  {
        let  vc = storyboard?.instantiateViewController(identifier: "questions") as! QuestionsViewController
        vc.modalPresentationStyle  = .fullScreen
        present(vc, animated: true)
    }
}
