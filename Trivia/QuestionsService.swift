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

    func getQuestion(for category: Int, completion: @escaping (Question) -> Void) {
        var questionURL: String
        if category == 0 {
            questionURL = "https://opentdb.com/api.php?amount=1&type=boolean"
        } else {
            let stringCategory = String(category)
            questionURL = "https://opentdb.com/api.php?amount=1&category=" + stringCategory + "&type=boolean"
        }
        apiClient.get(url: questionURL) { response in
            switch response {
            case .success(let data):
                do {
                    if let dataOK = data {
                        NSLog(dataOK.description)
                        print(dataOK)
                        let question = try JSONDecoder().decode(Questions.self, from: dataOK)
                        completion(question.results[0])
                    }
                } catch {
                    print(error)
                    completion(Question(category: "catch error", type: "catch error", difficulty: "catch error", question: "catch error", correct_answer: "catch error", incorrect_answers: [String]()))
                }
            case .failure(let error):
                print(error)
                completion(Question(category: "failure", type: "failure", difficulty: "failure", question: "failure", correct_answer: "failure", incorrect_answers: [String]()))
            }
        }
    }
}
