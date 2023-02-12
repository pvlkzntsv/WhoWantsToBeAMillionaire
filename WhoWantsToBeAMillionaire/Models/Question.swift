
import Foundation

struct Question {
    let ask : String
    let correctAnswer: String
    var answers: [String]
}

// массив с суммами вопросов, индекс соответствует номеру вопроса
let arrQuestionAndSumm = [0, 100, 200, 300, 500, 1000, 2000, 4000, 8000, 16000,
32000, 64000, 125000, 250000, 500000, 1000000]
