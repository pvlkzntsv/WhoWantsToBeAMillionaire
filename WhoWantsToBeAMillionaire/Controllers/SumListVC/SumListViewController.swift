//
//  SumListViewController.swift
//  Millionaire
//
//  Created by Eldar Garbuzov on 7.02.23.
//

import UIKit

class SumListViewController: UIViewController {
    

    @IBOutlet var question: [UIImageView]!
 
    var currentQuestion: Int? //counter for current question from QuestionBrain.swift
    var trueOrFalseAnswer: Bool? //result of checkAnswer() from QuestionBrain.swift
    private var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) {
            timer in
            self.dismiss(animated: true)
            
        }
        
        //guard let currentQuestion = currentQuestion else { return }
        //hightlitedQuestion(currentQuestion)
        
    }
    
    private func hightlitedQuestion(_ questionNumber: Int) {
        guard let currentQuestion = currentQuestion else { return }
        
        if question[currentQuestion].tag == questionNumber {
            for _ in 0...2 {
                if trueOrFalseAnswer == true {
                    question[currentQuestion].image = UIImage(named: "Rectangle green")
                } else {
                    question[currentQuestion].image = UIImage(named: "Rectangle red")
                }
                timer = Timer(timeInterval: 0.5, repeats: true, block: { [weak self] i in
                    self?.question[currentQuestion].image = UIImage(named: "Rectangle violet")
                    self?.dismiss(animated: true)
                    
                })
            }
        }
    }
}
