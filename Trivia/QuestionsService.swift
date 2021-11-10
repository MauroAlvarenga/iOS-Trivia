//
//  QuestionsService.swift
//  Trivia
//
//  Created by Mauro Alvarenga on 05/11/2021.
//

import Foundation
import Alamofire

class QuestionsService {

    private struct Questions: Codable {
        let response_code: Int
        let results: [Question]
    }
    
    let apiClient = AlamofireAPIClient()

    func getRandomQuestion(completion: @escaping ([Question]) -> Void) {
        let randomQuestionURL = "https://opentdb.com/api.php?amount=1&type=boolean"
        apiClient.get(url: randomQuestionURL) { response in
            switch response {
            case .success(let data):
                do {
                    if let dataOK = data {
//                        NSLog(data.description)
//                        print(data)
                        let question = try JSONDecoder().decode(Questions.self, from: dataOK)
                        completion(question.results)
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

    func getQuestions(for category: Int, completion: @escaping ([Question]) -> Void) {
        let categoriesURL = "https://opentdb.com/api_category.php"
        apiClient.get(url: categoriesURL) { response in
            switch response {
            case .success(let data):
                do {
                    if let data = data {
                        let questions = try JSONDecoder().decode(Questions.self, from: data)
                        completion(questions.results)
                    }
                } catch {
                    completion([])
                }
            case .failure(_):
                completion([])
            }
        }
    }


}
