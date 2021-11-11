//
//  InformationViewController.swift
//  Trivia
//
//  Created by Mauro Alvarenga on 05/11/2021.
//

import UIKit

class InformationViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var innerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background_1")!)
        scrollView.backgroundColor = UIColor(patternImage: UIImage(named: "background_1")!)
        innerView.backgroundColor = UIColor(patternImage: UIImage(named: "background_1")!)
    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
}
