//
//  CategoriesService.swift
//  Trivia
//
//  Created by Mauro Alvarenga on 05/11/2021.
//

import Foundation
import Alamofire

class CategoriesService {
    
    private struct Categories: Codable {
        let trivia_categories: [Category]
    }
        
    let apiClient = AlamofireAPIClient()
    
    func getCategories(completion: @escaping ([Category]) -> Void) {
        let categoriesURL = "https://opentdb.com/api_category.php"
        apiClient.get(url: categoriesURL) { response in
            switch response {
            case .success(let data):
                do {
                    if let data = data {
                        let categories = try JSONDecoder().decode(Categories.self, from: data)
                        completion(categories.trivia_categories)
                    }
                } catch {
                    print(error)
                    completion([])
                }
            case .failure(let error):
                print(error)
                completion([])
            }
        }
    }
    
}
