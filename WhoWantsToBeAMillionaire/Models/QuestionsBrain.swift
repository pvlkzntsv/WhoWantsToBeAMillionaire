import Foundation

struct QuestionBrain {
    let question = QuestionsList().questionList
    
    var questionNumber = 0
    mutating func nextQuestion()  {
        if questionNumber < question.count - 1 {
            questionNumber += 1
        }else {
            questionNumber = 0
        }
    }
    
    lazy var currentQuestion = question[questionNumber]
    
// Проверка ответа
    func checkAnswer (userAnswer:String) -> Bool {
        let correctAnswer = question[questionNumber].correctAnswer
        if userAnswer == correctAnswer {
          return true
        }else {
            return false
        }
    }
    
    // Функция получение вопроса
    mutating func getQuestion() -> String {
        return  currentQuestion.ask
    }
    
    // Функция получения массива ответов (для кнопок)
    mutating func getArrAnswers() -> [String] {
        return currentQuestion.answers
    }
    
    // Функция получает правильный ответ
    mutating func getCorrectAnswer(questionNumber: Int) -> String {
        return currentQuestion.correctAnswer
    }

}
