//
//  Question.swift
//  Trivia
//
//  Created by Mauro Alvarenga on 05/11/2021.
//

import Foundation

struct Question: Codable {
    var category: String
    var type: String
    var difficulty: String
    var question: String
    var correct_answer: String
    var incorrect_answers: [String]
}

//var json = {"response_code": 0,
//        "results": [
//            {"category":"Science & Nature",
//                "type":"boolean",
//                "difficulty":"easy",
//                "question":"Celiac Disease is a disease that effects the heart, causing those effected to be unable to eat meat.",
//                "correct_answer":"False",
//                "incorrect_answers":["True"]}
//        ]}

//The following code is used for testing when not fetching the questions from the api

struct LocalQuestion: Codable {
    var question: String
    var answer: Bool
}

final class Contenido {
    static let shared = Contenido()

    private init() {}

    func getQuestions() -> [LocalQuestion] {
        return [
            LocalQuestion(question: "Argentina tiene 3 copas del Mundo", answer: false),
            LocalQuestion(question: "La capital de Chile es Santiago", answer: true),
            LocalQuestion(question: "El dia tiene 24 horas", answer: true),
            LocalQuestion(question: "El mes de Junio tiene 31 dias", answer: false),
            LocalQuestion(question: "2 + 2 * 2 = 8", answer: false),
            LocalQuestion(question: "1024 Terabytes = 1 Petabyte", answer: true),
            LocalQuestion(question: "La glandula tiroides está en el cerebro", answer: false),
            LocalQuestion(question: "El intestino delgado mide entre 5 y 8 metros", answer: true),
            LocalQuestion(question: "El primer pais en organizar un Mundial de Futbol fue Uruguay", answer: true),
            LocalQuestion(question: "La gran muralla china es visible desde la luna", answer: false),
            LocalQuestion(question: "Rusia cuenta con 11 zonas horarias diferentes", answer: true)
        ]
    }

}
