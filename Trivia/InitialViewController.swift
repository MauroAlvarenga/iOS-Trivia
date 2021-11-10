//
//  InitialViewController.swift
//  Trivia
//
//  Created by Mauro Alvarenga on 30/10/2021.
//

import UIKit

class InitialViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var termsSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad invocado")
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background_1")!)
        nameTextField.delegate = self
        // It's called when the controller is created
    }
    
    @IBAction func startTrivia(_ sender: Any) {
        if nameTextField.hasText && termsSwitch.isOn {
            if let username = nameTextField.text {
                let userDefaults = UserDefaults()
                userDefaults.set(username, forKey: "username")
                userDefaults.set(0, forKey: "score")
            }
            presentTabBarController()
        } else if !nameTextField.hasText {
            presentNoUsernameAlert()
        } else {
            presentNotAcceptedTermsAlert()
        }
    }
    
    @IBAction func infoTapped(_ sender: UIButton) {
        let infoVC = InformationViewController(nibName: "InformationViewController", bundle: nil)
        infoVC.title = "About Alkemy Trivia"
        infoVC.modalPresentationStyle = .fullScreen
        self.present(infoVC, animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    } // Dismiss keyboard when another part of the view is tapped.
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    } // Dismiss keyboard when return key is pressed.
    
    func presentNoUsernameAlert() {
        let alert = UIAlertController(title: "Username required", message: "Please fill the username field to continue.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in NSLog("The \"OK\" alert occured.") }))
        self.present(alert, animated: true)
    }
    
    func presentNotAcceptedTermsAlert() {
        let alert = UIAlertController(title: "Terms and Conditions", message: "Please accept the terms and conditions to continue.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in NSLog("The \"Terms OK\" alert occured.")}))
        self.present(alert, animated: true)
    }
    
    func presentTabBarController() {
        let tabBarController = TabBarViewController(nibName: "TabBarViewController", bundle: nil)
        tabBarController.modalPresentationStyle = .overFullScreen
        self.present(tabBarController, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // It's called right before the view appears. It's useful to hide/show fields or any kind of operation that you wish to occur when the view appears.
        // It may be called more than once.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // It's called right after view appears. Used, i.e, for starting an animation.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // It's called right before the view dissapears.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // It's called when the view has gone. 
    }

}
