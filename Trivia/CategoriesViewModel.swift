//
//  CategoriesViewModel.swift
//  Trivia
//
//  Created by Mauro Alvarenga on 05/11/2021.
//

import Foundation

class CategoriesViewModel {

    private let categoriesService: CategoriesService
    private var categories = [Category(id: 0, name: "Loading...")]
    
    init(service: CategoriesService) {
        self.categoriesService = service
    }
    
    func getCategories(completion: @escaping () -> Void) {
        categoriesService.getCategories { [weak self] categories in
            self?.categories = categories
            completion()
        }
    }
    
    func getCategory(at index:Int) -> Category {
        categories[index]
    }
    
    func getCategoriesCount() -> Int {
        categories.count
    }
    
}
