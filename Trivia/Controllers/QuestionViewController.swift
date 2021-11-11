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
    
    private var viewModel: QuestionViewModel!
    private var username: String?
    private var score: Int?
    private var currentQuestion: Question?
    
    var categoryID = 0
    let userDefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = QuestionViewModel(service: QuestionsService())
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background_1")!)
        setUsername()
        getScore()
        getQuestion()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getScore()
    }
    
    private func getQuestion() {
        viewModel.getQuestion(for: categoryID) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.setCurrentQuestion()
        }
    }

    @IBAction func yesButtonTapped(_ sender: UIButton) {
        let result = validateCurrentQuestion(answer: "True")
        sendResultAlert(for: result)
    }
    
    @IBAction func noButtonTapped(_ sender: UIButton) {
        let result = validateCurrentQuestion(answer: "False")
        sendResultAlert(for: result)
    }
     
    private func setCurrentQuestion() {
        questionLabel.text = viewModel.getCurrentQuestion()
    }
    
    private func validateCurrentQuestion(answer: String) -> Bool {
        viewModel.validateCurrentQuestion(answer: answer)
    }
        
    private func sendResultAlert(for result: Bool) {
        result ? rightAnswerTapped() : wrongAnswerTapped()
    }
   
    private func rightAnswerTapped() {
        let alertYES = UIAlertController(title: "Excellent!", message: "Good Job, \(username!)! 😁", preferredStyle: .alert)
        alertYES.addAction(UIAlertAction(title: "Thanks! 😎", style: .cancel, handler: { [self] _ in
            increaseScore()
            getQuestion()
        }))
        self.present(alertYES, animated: true)
        }
    
    private func wrongAnswerTapped() {
        let alertNO = UIAlertController(title: "Wrong!", message: "Better luck next time, \(username!) 😔", preferredStyle: .alert)
        alertNO.addAction(UIAlertAction(title: "Ups! 😅", style: .cancel, handler: { [self] _ in
            getQuestion()
        }))
        self.present(alertNO, animated: true)
    }
    
    private func setUsername() {
        if let usernameSet = userDefaults.string(forKey: "username") {
            self.username = usernameSet
            self.nameLabel.text = usernameSet + ":"
        }
    }
    
    private func getScore() {
        self.score = userDefaults.integer(forKey: "score")
        setScore()
    }
    
    private func setScore() {
        if let score = self.score {
            self.scoreLabel.text = "Score: " + String(score)
        }
    }
    
    private func increaseScore() {
        self.score! += 5
        userDefaults.set(self.score!, forKey: "score")
        setScore()
    }
    
}
