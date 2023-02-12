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
    private var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if
        
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) {
            timer in
            if self.currentQuestion == 14 {
                let lossGaveViewController = LossGameViewController()
                lossGaveViewController.playersSumm = 1000000
                lossGaveViewController.modalPresentationStyle = .fullScreen
                self.present(lossGaveViewController, animated: true)
            } else {
                self.dismiss(animated: true)
            }
        }
        
        guard let currentQuestion = currentQuestion else { return }
        hightlitedQuestion(currentQuestion)
    }
    
    private func hightlitedQuestion(_ questionNumber: Int) {
        guard let currentQuestion = currentQuestion else { return }
        
        if question[currentQuestion].tag == questionNumber {
            question[currentQuestion].image = UIImage(named: "Rectangle green")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.question[currentQuestion].image = UIImage(named: "Rectangle violet")
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.question[currentQuestion].image = UIImage(named: "Rectangle green")
                }
            }
        }
    }
}
