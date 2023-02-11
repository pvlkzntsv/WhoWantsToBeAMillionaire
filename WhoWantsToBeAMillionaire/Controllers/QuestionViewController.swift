
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
    
    
    var timerWaitAnswer = Timer() // тайимер ожидания ответа от пользователя(30 сек)
    var timerWaitCorrectAnswer = Timer() // таймер ожидания правильного ответа от программы(5 сек)
    
    var seconds = 0
    var questionBrain = QuestionBrain()
    var questionNumber:Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //updateUI()
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
        //создаем массив кнопок
        arrAnswerButton.append(contentsOf: [buttonAnswer1, buttonAnswer2, buttonAnswer3, buttonAnswer4])
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateUI()
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
            let correctAnswer = self.questionBrain.getCorrectAnswer(questionNumber: self.questionNumber)
            //подсветка кнопки с правильным ответом
            for button in self.arrAnswerButton {
                if button.title(for: .normal) == correctAnswer {
                    button.layer.borderWidth = 5
                    button.layer.borderColor = UIColor.green.cgColor
                }
            }
            // MARK: TODO(dmitrii_er) - сделать начисление денег и переход на экран, который показывает все вопросы
            
            
            
            // определение правильный ответ или нет
            if sender.title(for: .normal) == correctAnswer {
                // верный ответ переход на экран со свписком вопросов
                let sumListViewController = SumListViewController()
                sumListViewController.modalPresentationStyle = .fullScreen
                self.present(sumListViewController, animated: true)
                //зачисляем игроку сумму и только потом меняем номер вопроса
                self.questionBrain.playersSumm += arrQuestionAndSumm[self.questionNumber+1]
                self.questionBrain.nextQuestion()
            }
            else {
                // неверный ответ - переход на укран показа результатом игры
                let lossGaveViewController = LossGameViewController()
                lossGaveViewController.playersSumm = self.questionBrain.playersSumm
                lossGaveViewController.modalPresentationStyle = .fullScreen
                self.present(lossGaveViewController, animated: true)
            }
        }
        
        
    }
    
    
    @IBAction func adviceButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
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
    
    func updateUI() {
        
        // вывод вопроса *******************************
        labelQuestion.text = questionBrain.getQuestion()
        // вывод номера вопроса и суммы ***************************
        questionNumber = questionBrain.getQuestionNumber()
        labelQuestionNumber.text = "Вопрос №" + String(questionNumber+1) //так как в массиве вопросы с 0
        labelSumm.text = String(arrQuestionAndSumm[questionNumber+1]) + " РУБ"
        
        // вывод 4-х ответов ***************************
        var arrAnswers = questionBrain.getArrAnswers() //массив ответов
        //сопоставляем случайный ответ каждой кнопке
        for button in arrAnswerButton {
            guard let rndAnswer = arrAnswers.randomElement() else {
                print("Error: there are no answers")
                return
            }
            let indexElementForRemove = arrAnswers.firstIndex(of: rndAnswer)
            arrAnswers.remove(at: indexElementForRemove!) // удаляем ответ, который уже внесли на кнопку
            button.setTitle(rndAnswer, for: .normal) // устанавливаем надпись на кнопке
            button.layer.borderWidth = 0 //убираем подсветку кнопок
        }
        //возврат к начальному виду экрана(при смене вопроса)
        view.isUserInteractionEnabled = true // разрешаем взаимодействие с экраном
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
    
    
    

