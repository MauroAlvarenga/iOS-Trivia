//
//  CategoriesViewController.swift
//  Trivia
//
//  Created by Mauro Alvarenga on 03/11/2021.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: CategoriesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "background_1")!)
        tableView.backgroundColor = UIColor(patternImage: UIImage(named: "background_1")!)
        
        self.viewModel = CategoriesViewModel(service: CategoriesService())
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        getCategories()
    }
    
    func getCategories() {
        viewModel?.getCategories { [weak self] in
            self?.tableView.reloadData()
        }
    }

    func showQuestions(for category: Category) {
        let questionViewController = QuestionViewController(nibName: "QuestionViewController", bundle: nil)
        questionViewController.title = category.name
        questionViewController.categoryID = category.id
        
        navigationController?.pushViewController(questionViewController, animated: true)
    }
}

extension CategoriesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let category = viewModel?.getCategory(at: indexPath.row) {
            showQuestions(for: category)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel?.getCategoriesCount() ?? 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = UIColor(patternImage: UIImage(named: "background_1")!)
        cell.textLabel?.font = UIFont(name: "Futura", size: 24)
        cell.textLabel?.textColor = .black
        cell.textLabel?.text = viewModel?.getCategory(at: indexPath.row).name
        
        return cell
    }
}
