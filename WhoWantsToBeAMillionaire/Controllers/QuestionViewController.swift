
//
//  QuestionViewController.swift
//  Millionaire
//
//  Created by ddd on 18.08.2022.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var button50persent: UIButton!
    @IBOutlet weak var buttonHall: UIButton!
    @IBOutlet weak var buttonCall: UIButton!
    
    @IBOutlet weak var labelQuestionNumber: UILabel!
    @IBOutlet weak var labelQuestion: UILabel!
    @IBOutlet weak var labelSumm: UILabel!
    @IBOutlet weak var labelTimer: UILabel!
    
    @IBOutlet weak var buttonAnswer1: UIButton!
    @IBOutlet weak var buttonAnswer2: UIButton!
    @IBOutlet weak var buttonAnswer3: UIButton!
    @IBOutlet weak var buttonAnswer4: UIButton!
    var arrAnswerButton = [UIButton]() // массив кнопок с ответами
    var arrQuestionNumberAndSumm = [Int]() //массив номера вопроса и суммы
    
    var timerWaitAnswer = Timer() // тайимер ожидания ответа от пользователя(30 сек)
    var timerWaitCorrectAnswer = Timer() // таймер ожидания правильного ответа от программы(5 сек)
    
    var seconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Настройка рисунков для кнопок "Звонок другу", "50/50", "Помощь зала" **********************************
        button50persent.setBackgroundImage( UIImage(named: "Advice-50"), for: .normal)
        button50persent.layoutIfNeeded()
        button50persent.subviews.first?.contentMode = .scaleAspectFit
        
        buttonHall.setBackgroundImage( UIImage(named: "Advice-hall"), for: .normal)
        buttonHall.layoutIfNeeded()
        buttonHall.subviews.first?.contentMode = .scaleAspectFit
        
        buttonCall.setBackgroundImage( UIImage(named: "Advice-call"), for: .normal)
        buttonCall.layoutIfNeeded()
        buttonCall.subviews.first?.contentMode = .scaleAspectFit
        
        // вывод вопроса *******************************
        labelQuestion.text = getQuestion()
        // вывод номера вопроса и суммы ***************************
        arrQuestionNumberAndSumm = getQuestionNumberAndSumm()
        labelQuestionNumber.text = "Вопрос №" + String(arrQuestionNumberAndSumm[0])
        labelSumm.text = String(arrQuestionNumberAndSumm[1]) + " РУБ"
        
        // вывод 4-х ответов ***************************
        var arrAnswers = getArrAnswers() //массив ответов
        //создаем массив кнопок
        arrAnswerButton.append(contentsOf: [buttonAnswer1, buttonAnswer2, buttonAnswer3, buttonAnswer4])
        //сопоставляем случайный ответ каждой кнопке
        for button in arrAnswerButton {
            guard let rndAnswer = arrAnswers.randomElement() else {
                print("Error: there are no answers")
                return
            }
            let indexElementForRemove = arrAnswers.firstIndex(of: rndAnswer)
            arrAnswers.remove(at: indexElementForRemove!) // удаляем ответ, который уже внесли на кнопку
            button.setTitle(rndAnswer, for: .normal) // устанавливаем надпись на кнопке
        }
        
        // MARK: TODO - старт 30 секундного таймера, обновление LabelTimerToEnd, проигрывание музыки, после 30 сек - экран окончания игры
        timerWaitAnswer.invalidate()
        seconds = 30
        // MARK: TODO(dmitrii_er) - начало проигрывания музыки2
        // таймер ожидания ответа от пользователя
        timerWaitAnswer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) {
            timer in
            self.seconds -= 1
            self.labelTimer.text = String(self.seconds) + "сек"
            if self.seconds <= 0 {
                self.timerWaitAnswer.invalidate()
                    //MARK: TODO(dmitrii_er) - вызов экрана окончания игры
            }
        }
        
    }

    @IBAction func giveMyMoney(_ sender: UIButton) {
        // MARK: TODO(dmitrii_er) - сделать переход на экран окончания игры
        
    }
    
    @IBAction func buttonsAnswerPressed(_ sender: UIButton) {
        //блокирую все кнопки для нажатий-ждем ответа ведущего
        view.isUserInteractionEnabled = false
        
        sender.layer.borderWidth = 5
        sender.layer.borderColor = UIColor.orange.cgColor

        
        
        // стоп таймера ожидания ответа и запуск таймера ожидания правильного ответа
        timerWaitAnswer.invalidate()
    
        // MARK: TODO(dmitrii_er) - начало проигрывания музыки1
        timerWaitCorrectAnswer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) {
            timer in
           
            // MARK: TODO(dmitrii_er) - окончание проигрывания музыки1
            // MARK: TODO(dmitrii_er) - получение реального ответа
            let correctAnswer = self.getCorrectAnswer(questionNumber: self.arrQuestionNumberAndSumm[0])
            //подсветка кнопки с правильным ответом
            for button in self.arrAnswerButton {
                if button.title(for: .normal) == correctAnswer {
                    button.layer.borderWidth = 5
                    button.layer.borderColor = UIColor.green.cgColor
                }
            }
            
            // определение правильный ответ или нет
            if sender.title(for: .normal) == correctAnswer {
                // MARK: TODO(dmitrii_er) - переход на экран со свписком вопросов
                // верный ответ
            }
            else {
                // MARK: TODO(dmitrii_er) - переход на укран показа результатом игры
                // неверный ответ
            }
        }
        
        // MARK: TODO(dmitrii_er) - сделать начисление денег и переход на экран, который показывает все вопросы
        let correctAnswer = getCorrectAnswer(questionNumber: arrQuestionNumberAndSumm[0])
        if sender.title(for: .normal) == correctAnswer {
            // верный ответ
        }
        else {
            // неверный ответ
        }
    }
    
    
    @IBAction func adviceButtonPressed(_ sender: UIButton) {

        if sender.tag == 1 { //50:50 нажата
            button50persent.setBackgroundImage( UIImage(named: "Advice-50-spent"), for: .normal)
            
            
        } else if sender.tag == 2 { //помощь зала
            buttonHall.setBackgroundImage( UIImage(named: "Advice-hall-spent"), for: .normal)
            let advice = getAdvice(typeOfAdvice: "Hall")
            showAdvice(advice: advice)
            
        } else if sender.tag == 3 { // звонок другу
            buttonCall.setBackgroundImage( UIImage(named: "Advice-call-spent"), for: .normal)
            let advice = getAdvice(typeOfAdvice: "Call")
            showAdvice(advice: advice)
            
        }
        else {
            print("Error: unknown tag for advice buttons")
        }
    }
    
    func showAdvice(advice:String) {
        let alert = UIAlertController(title: "Время идет, поторопись!", message: "Правильный ответ: \(advice)", preferredStyle: .alert)
        let alertButton = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(alertButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // Функция получение вопроса
    func getQuestion() -> String {
        // MARK: TODO(dmitrii_er) - сделать реальное получение вопроса
        return "Здесь будет вовзращаться вопрос"
    }
    
    // Функция получения массива ответов (для кнопок)
    func getArrAnswers() -> [String] {
        // MARK: TODO(dmitrii_er) - сделать реальное получение ответов
        return ["Answer1", "Answer2", "Answer3", "Answer4"]
        
    }
    
    
    // Функция получает правильный ответ
    func getCorrectAnswer(questionNumber: Int) -> String {
        //MARK: TODO(dmitrii_er) - сделать реальную функцию получения верного ответа
        return "Answer1"
    }
    
    // Функция получает массив, состоящий из номера вопроса и суммы
    func getQuestionNumberAndSumm() -> [Int] {
        //MARK: TODO(dmitrii_er) - сделать реальное возвращение номера вопроса, первый элемент - номер вопроса, второй элемент - сумма
        return [1, 100]
    }
    
    
    // функция получает совет
    //typeOfAdvice = "Call" or "Hall"
    func getAdvice(typeOfAdvice: String) -> String {
        //MARK: TODO(dmitrii_er) - сделать реальное возвращение советов
        return "здесь будет совет"
    }
    
    // MARK: TODO function answerButtonPress
    
    
    //MARK: TODO function helpForAnswerButtomPressed
    
    //MARK: TODO function geveMyMoney

    
    }
    
    
    

