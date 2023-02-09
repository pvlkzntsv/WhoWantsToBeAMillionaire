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
    
    func currentQuestion () -> Question {
        return question[questionNumber]
    }
 
// Проверка ответа
    func checkAnswer (userAnswer:String) -> Bool {
        let correctAnswer = question[questionNumber].correctAnswer
        if userAnswer == correctAnswer {
          return true
        }else {
            return false
        }
    }
    

}
