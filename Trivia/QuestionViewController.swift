//
//  QuestionViewController.swift
//  Trivia
//
//  Created by Mauro Alvarenga on 03/11/2021.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    private var questions = Contenido.shared.getQuestions()
    private var currentQuestionIndex = 0
    private var username: String?
    private var score: Int?
    
    var categoryID = 0
    private var currentQuestion: Question?
    private let questionsService = QuestionsService()
    
    let userDefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background_1")!)
        //setCurrentQuestion(for: currentQuestionIndex)
        //setUsername()
        if let usernameSet = userDefaults.string(forKey: "username") {
            self.username = usernameSet
            self.nameLabel.text = usernameSet + ":"
        } else {
            self.username = "Jugador:"
        }
        getQuestion()
        //setRandomQuestion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //setScore()
        self.score = userDefaults.integer(forKey: "score")
        self.scoreLabel.text = "Score: " + String(self.score!)
    }
    
    @IBAction func yesButtonTapped(_ sender: UIButton) {
        //let result = validateCurrentQuestion(answer: true)
        let result = validateCurrentQuestion(answer: "True")
        sendResultAlert(for: result)
    }
    
    @IBAction func noButtonTapped(_ sender: UIButton) {
       // let result = validateCurrentQuestion(answer: false)
        let result = validateCurrentQuestion(answer: "False")
        sendResultAlert(for: result)
    }
    
    private func getQuestion() {
        questionsService.getQuestion(for: categoryID) { [weak self] receivedQuestion in
            guard let strongSelf = self else { return }
            
            strongSelf.currentQuestion = receivedQuestion
            strongSelf.questionLabel.text = receivedQuestion.question.htmlDecoded
        }
    }
    
//    private func setRandomQuestion() {
//        questionsService.getRandomQuestion { [weak self] receivedQuestion in
//            //if receivedQuestions.count > 0 {
//            print(receivedQuestion)
//            self?.currentQuestion = receivedQuestion
//            self?.questionLabel.text = receivedQuestion.question.htmlDecoded
//            //}
//        }
//    }
    
    private func validateCurrentQuestion(answer: String) -> Bool {
        //questions[currentQuestionIndex].answer == answer
        if let rightAnswer = currentQuestion?.correct_answer {
            return rightAnswer == answer
        }
        return false
    }
    
    private func sendResultAlert(for result: Bool) {
        result ? rightAnswerTapped() : wrongAnswerTapped()
    }
    
    func rightAnswerTapped() {
        let alertYES = UIAlertController(title: "Excellent!", message: "Good Job, \(username!)! 😁", preferredStyle: .alert)
        alertYES.addAction(UIAlertAction(title: "Thanks! 😎", style: .cancel, handler: { [self] _ in
            NSLog("The \"correct answer\" alert occured.")
            //updateQuestion()
            //setRandomQuestion()
            self.score! += 5
            self.scoreLabel.text = "Score: " + String(self.score!)
            userDefaults.set(self.score!, forKey: "score")
            getQuestion()
        }))
        self.present(alertYES, animated: true)
        }
    
    func wrongAnswerTapped() {
        let alertNO = UIAlertController(title: "Wrong!", message: "Better luck next time, \(username!) 😔", preferredStyle: .alert)
        alertNO.addAction(UIAlertAction(title: "Ups! 😅", style: .cancel, handler: { [self] _ in
            NSLog("The \"correct answer\" alert occured.")
            //updateQuestion()
            //setRandomQuestion()
            getQuestion()
        }))
        self.present(alertNO, animated: true)
    }
    
    private func updateQuestion() {
        currentQuestionIndex += 1
        setCurrentQuestion(for: currentQuestionIndex)
    }
    
    private func setCurrentQuestion(for index: Int) {
        if index < questions.count {
            questionLabel.text = questions[index].question
        } else {
            currentQuestionIndex = 0
            questionLabel.text = questions[currentQuestionIndex].question
        }
    }
        
}

// Used to decode special characters like '&quot;' from the JSON
extension String {
    var htmlDecoded: String {
        let decoded = try? NSAttributedString(data: Data(utf8), options: [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ], documentAttributes: nil).string

        return decoded ?? self
    }
}
