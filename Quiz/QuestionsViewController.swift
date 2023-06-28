//
//  QuestionsViewController.swift
//  Quiz
//
//  Created by Padmavathi Sivakumar on 2023-06-28.
//

import UIKit

class QuestionsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answersTableView: UITableView!
    
    let questions = [
        Question(text: "What is the capital of France?", answers: ["London", "Paris", "Berlin", "Madrid"], correctAnswerIndex: 1),
        Question(text: "Which planet is known as the Red Planet?", answers: ["Mars", "Jupiter", "Saturn", "Venus"], correctAnswerIndex: 0),
        Question(text: "What is the symbol for the chemical element iron?", answers: ["Fe", "Ir", "In", "I"], correctAnswerIndex: 0)
    ]
    
    var currentQuestionIndex = 0
    var userAnswers = [Int?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answersTableView.dataSource = self
        answersTableView.delegate = self
        displayQuestion(at: currentQuestionIndex)
    }
    
    func displayQuestion(at index: Int) {
        let question = questions[index]
        questionLabel.text = question.text
        userAnswers.append(nil)
        answersTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions[currentQuestionIndex].answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath)
        let answer = questions[currentQuestionIndex].answers[indexPath.row]
        cell.textLabel?.text = answer
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userAnswers[currentQuestionIndex] = indexPath.row
        tableView.reloadData() 
    }
    
    @IBAction func previousButtonTapped(_ sender: UIButton) {
        if currentQuestionIndex > 0 {
            currentQuestionIndex -= 1
            displayQuestion(at: currentQuestionIndex)
        }
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if currentQuestionIndex < questions.count - 1 {
            currentQuestionIndex += 1
            displayQuestion(at: currentQuestionIndex)
        } else {
            let  vc = storyboard?.instantiateViewController(identifier: "results") as! ResultsViewController
            vc.modalPresentationStyle  = .fullScreen
            present(vc, animated: true)
        }
    }
    
    func showResult() {
        var correctAnswers = 0
        for (index, question) in questions.enumerated() {
            if let userAnswerIndex = userAnswers[index], userAnswerIndex == question.correctAnswerIndex {
                correctAnswers += 1
            }
        }
        
        self.performSegue(withIdentifier: "ShowResultSegue", sender: correctAnswers)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowResultSegue" {
            if let resultViewController = segue.destination as? ResultsViewController {
                if let correctAnswers = sender as? Int {
                    resultViewController.correctAnswers = correctAnswers
                    resultViewController.totalQuestions = questions.count
                }
            }
        }
    }

}
