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
    @IBOutlet weak var nextButton: UIButton!
    
    let questions: [Question] = [
        Question(text: "What is the keyword used to define a constant in Swift?", answers: ["var", "let", "const", "constant"], correctAnswerIndex: 1),
        Question(text: "Which of the following is NOT a basic data type in Swift?", answers: ["Int", "String", "Float", "Double", "Char"], correctAnswerIndex: 4),
        Question(text: "What is the correct way to declare an optional variable in Swift?", answers: ["var name: String", "var name: String?", "let name: String!", "opt name: String"], correctAnswerIndex: 1),
        Question(text: "In Swift, what does the guard statement do?", answers: ["It creates a new scope to encapsulate variables", "It performs early exits from a function if a condition is not met", "It defines a new variable with optional binding", "It is used for defining loops"], correctAnswerIndex: 1),
        Question(text: "What does the self keyword refer to in Swift?", answers: ["It refers to the superclass of the current class", "It is used to access global variables", "It refers to the instance of the current class", "It is used to declare a new instance variable"], correctAnswerIndex: 2),
        Question(text: "Which Swift collection type is an unordered collection of unique elements?", answers: ["Array", "Dictionary", "Set", "Tuple"], correctAnswerIndex: 2),
        Question(text: "What is the purpose of an initializer in Swift?", answers: ["It is used to deinitialize objects and free up memory", "It is a method used to perform setup and initialization of a class instance", "It is a reserved keyword and not used in Swift", "It is used to define custom operators"], correctAnswerIndex: 1),
        Question(text: "How do you create a function that takes a variable number of arguments in Swift?", answers: ["func myFunction(args: Int...)", "func myFunction(args: [Int])", "func myFunction(args: Int[])", "func myFunction(args: Int..)"], correctAnswerIndex: 0),
        Question(text: "What is the Swift keyword used to make a class member accessible within its own class and subclasses only?", answers: ["private", "internal", "protected", "fileprivate"], correctAnswerIndex: 2),
        Question(text: "Which keyword is used to handle errors in Swift?", answers: ["catch", "try", "throw", "throws"], correctAnswerIndex: 2)
    ]
    
    var currentQuestionIndex = 0
    var userSelectedAnswers: [Int?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        answersTableView.dataSource = self
        answersTableView.delegate = self
        initializeUserSelectedAnswers()
        displayQuestion()
    }
    
    func initializeUserSelectedAnswers() {
        userSelectedAnswers = Array(repeating: nil, count: questions.count)
    }
    
    func displayQuestion() {
        let question = questions[currentQuestionIndex]
        questionLabel.text = question.text
        answersTableView.reloadData()
        answersTableView.isUserInteractionEnabled = true
        if let selectedAnswerIndex = userSelectedAnswers[currentQuestionIndex] {
            answersTableView.selectRow(at: IndexPath(row: selectedAnswerIndex, section: 0), animated: false, scrollPosition: .none)
        }
        updateNextButtonState()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions[currentQuestionIndex].answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath)
        cell.textLabel?.text = questions[currentQuestionIndex].answers[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        // Highlight the selected answer
        if indexPath.row == userSelectedAnswers[currentQuestionIndex] {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userSelectedAnswers[currentQuestionIndex] = indexPath.row
        answersTableView.reloadData()
        updateNextButtonState()
    }
    
    func updateNextButtonState() {
        let hasSelectedAnswer = userSelectedAnswers[currentQuestionIndex] != nil
        nextButton.isEnabled = hasSelectedAnswer
    }
    
    func showNextQuestion() {
        currentQuestionIndex += 1
        if currentQuestionIndex < questions.count {
            displayQuestion()
        } else {
            performSegue(withIdentifier: "showResultsSegue", sender: nil)
        }
    }
    
    func showPreviousQuestion() {
        currentQuestionIndex -= 1
        if currentQuestionIndex >= 0 {
            displayQuestion()
        }
    }
    
    @IBAction func previousButtonTapped(_ sender: UIButton) {
        showPreviousQuestion()
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        showNextQuestion()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResultsSegue" {
            if let resultsVC = segue.destination as? ResultsViewController {
                // Pass the user-selected answers and questions to the ResultsViewController
                resultsVC.correctAnswers = userSelectedAnswers
                resultsVC.totalQuestions = questions
            }
        }
    }
}
