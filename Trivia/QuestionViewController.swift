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
    
    private var questions = Contenido.shared.getQuestions()
    private var currentQuestionIndex = 0
    private var username: String?
    var categoryID: Int?
    
    //Agregar puntuacion, sumar 5 con cada correcta.
    
    private let questionsService = QuestionsService()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background_1")!)
        //setCurrentQuestion(for: currentQuestionIndex)
        let userDefaults = UserDefaults()
        if let usernameSet = userDefaults.string(forKey: "username") {
            username = usernameSet
            nameLabel.text = usernameSet + ":"
        } else {
            username = "Jugador:"
        }
        //getQuestions()
        setRandomQuestion()
    }

//    private func getQuestions() {
//        questionsService.getQuestions() { [weak self] question in
//            self!.questionLabel.text = question.question
//        }
//    }
    
    @IBAction func yesButtonTapped(_ sender: UIButton) {
        let result = validateCurrentQuestion(answer: true)
        sendResultAlert(for: result)
    }
    
    @IBAction func noButtonTapped(_ sender: UIButton) {
        let result = validateCurrentQuestion(answer: false)
        sendResultAlert(for: result)
    }
    
    
    func rightAnswerTapped() {
        let alertSI = UIAlertController(title: "Excellent!", message: "Good Job, \(username!)! 😁", preferredStyle: .alert)
        alertSI.addAction(UIAlertAction(title: "Thanks! 😎", style: .cancel, handler: { [self] _ in
            NSLog("The \"correct answer\" alert occured.")
            //updateQuestion()
            setRandomQuestion()
        }))
        self.present(alertSI, animated: true)
        }
    
    func wrongAnswerTapped() {
        let alertNO = UIAlertController(title: "Wrong!", message: "Better luck next time, \(username!) 😔", preferredStyle: .alert)
        alertNO.addAction(UIAlertAction(title: "Ups! 😅", style: .cancel, handler: { [self] _ in
            NSLog("The \"correct answer\" alert occured.")
            //updateQuestion()
            setRandomQuestion()
        }))
        self.present(alertNO, animated: true)
    }
    
    private func updateQuestion() {
        currentQuestionIndex += 1
        setCurrentQuestion(for: currentQuestionIndex)
    }

    private func setRandomQuestion() {
        questionsService.getRandomQuestion { [weak self] receivedQuestions in
            if receivedQuestions.count > 0 {
                print(receivedQuestions)
                self?.questionLabel.text = receivedQuestions[0].question
            }
        }
    }
    
    private func setCurrentQuestion(for index: Int) {
        if index < questions.count {
            questionLabel.text = questions[index].question
        } else {
            currentQuestionIndex = 0
            questionLabel.text = questions[currentQuestionIndex].question
        }
    }
    
    private func validateCurrentQuestion(answer: Bool) -> Bool {
        questions[currentQuestionIndex].answer == answer
    }
    
    private func sendResultAlert(for result: Bool) {
        result ? rightAnswerTapped() : wrongAnswerTapped()
    }
    
}
