
//
//  QuestionViewController.swift
//  Millionaire
//
//  Created by ddd on 18.08.2022.
//

import UIKit

class QuestionViewController: UIViewController {
//ddd
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
    
    @IBOutlet weak var viewAnswerA: UIView!
    @IBOutlet weak var viewAnswerB: UIView!
    @IBOutlet weak var viewAnswerC: UIView!
    @IBOutlet weak var viewAnswerD: UIView!
    
    
    
    var arrAnswerButton = [UIButton]() // массив кнопок с ответами
    var answersForThisQuestion: [String] = [] // свой массив с ответами, уменьшим его при выборе 50 на 50 совета
    
    var timerWaitAnswer = Timer() // тайимер ожидания ответа от пользователя(30 сек)
    var timerWaitCorrectAnswer = Timer() // таймер ожидания правильного ответа от программы(5 сек)
    
    var seconds = 0
    var questionBrain = QuestionBrain()
    var questionNumber:Int = 1
    var playerSum = 0
    
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
        //переход на экран показа результатом игры
        let lossGaveViewController = LossGameViewController()
        lossGaveViewController.playersSumm = self.questionBrain.playersSumm
        lossGaveViewController.modalPresentationStyle = .fullScreen
        self.present(lossGaveViewController, animated: true)
        
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
                // верный ответ переход на экран со списком вопросов
                let sumListViewController = SumListViewController()
                sumListViewController.modalPresentationStyle = .fullScreen
                self.present(sumListViewController, animated: true)
                //зачисляем игроку сумму и только потом меняем номер вопроса
                self.questionBrain.playersSumm += arrQuestionAndSumm[self.questionNumber+1]
                self.questionBrain.nextQuestion()
                self.playerSum = self.questionBrain.playerSum()
            }
            else {
                // неверный ответ
                self.wrongAnswerOrTimeOff()
                
            }
        }
        
        
    }
    
    
    @IBAction func adviceButtonPressed(_ sender: UIButton) {
        sender.isEnabled = false
        var twoHiddenButton = 0 //считаем спрятанные кнопки
        if sender.tag == 1 { //50:50 нажата
            button50persent.setBackgroundImage( UIImage(named: "Advice-50-spent"), for: .normal)
            for button in arrAnswerButton {
                if button.title(for: .normal) == questionBrain.getCorrectAnswer(questionNumber: questionNumber) {
                    //не прячу кнопку с правильным ответом
                }
                else {
                    button.superview!.alpha = 0
                    //убираю из массива ответов ответы для двух спрятанных кнопок
                    answersForThisQuestion = answersForThisQuestion.filter{$0 != button.title(for: .normal) }
                    twoHiddenButton += 1
                    if twoHiddenButton >= 2 { //хватит, если спрятали уже две кнопки
                        return
                    }
                }
            }
        } else if sender.tag == 2 { //помощь зала
            buttonHall.setBackgroundImage( UIImage(named: "Advice-hall-spent"), for: .normal)
            showAdvice(maxPercent: 70)
        } else if sender.tag == 3 { // звонок другу
            buttonCall.setBackgroundImage( UIImage(named: "Advice-call-spent"), for: .normal)
            showAdvice(maxPercent: 80)
        }
        else {
            print("Error: unknown tag for advice buttons")
        }
    }
    
    func showAdvice(maxPercent:UInt32) {
        var message = "нет подсказок"
        var rndPercent = (arc4random() % 1000) / 10
        let correctAnswer = questionBrain.getCorrectAnswer(questionNumber: questionBrain.questionNumber)
        
        switch(rndPercent) {
        case 0..<maxPercent:
            message = correctAnswer
            print("hi percent = \(maxPercent)")
        case maxPercent...100:
            // MARK: TODO - не совсем верно считает вероятность при уже убранных кнопках(доделать)
            var wrongAnswers = answersForThisQuestion.filter {
                $0 != correctAnswer
            }
            message = wrongAnswers.randomElement()!
            print("low %")
        default:
            print("noprecent")
        }
        let alert = UIAlertController(title: "Время идет, поторопись!", message: "Правильный ответ: \(message)", preferredStyle: .alert)
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
        answersForThisQuestion = questionBrain.getArrAnswers()
        // вывод 4-х ответов ***************************
        var arrAnswers = answersForThisQuestion //массив ответов
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
        viewAnswerA.alpha = 1
        viewAnswerB.alpha = 1
        viewAnswerC.alpha = 1
        viewAnswerD.alpha = 1
        
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
                self.wrongAnswerOrTimeOff()
                
            }
        }
        
    }
    
    // Игрок ответил неверно или вышло время-переход на экран окончания игры
    func wrongAnswerOrTimeOff() {
        //очищаем выигрыш до минимальной несгорающей суммы
        if ((questionBrain.playersSumm>=1000)&&(questionBrain.playersSumm<32000)) {
            questionBrain.playersSumm = 1000
        }
        else if (questionBrain.playersSumm>=32000) {
            questionBrain.playersSumm = 32000
        }
        else {
            questionBrain.playersSumm = 0
        }
        //переход на экран показа результатом игры
        let lossGaveViewController = LossGameViewController()
        lossGaveViewController.playersSumm = questionBrain.playersSumm
        lossGaveViewController.modalPresentationStyle = .fullScreen
        self.present(lossGaveViewController, animated: true)
    }
    
    
    }
    
    
    

