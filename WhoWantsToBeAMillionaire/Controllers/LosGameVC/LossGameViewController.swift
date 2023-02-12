//
//  LossGameViewController.swift
//  Millionaire
//
//  Created by user on 9.02.23.
//

import UIKit
var questionVC = QuestionViewController()
class LossGameViewController: UIViewController {
    @IBOutlet weak var labelPlayersSumm: UILabel!
    @IBOutlet var taskLabel: UILabel!
    var playersSumm = 0
    var takeMoney = 0
    
    override func viewDidLoad() {
        switch playersSumm {
        case takeMoney: labelPlayersSumm.text = "Ваш выйгрыш: \(takeMoney)руб"
            taskLabel.text = "Решил не рисковать почем зря?"
        case _ where playersSumm == 1000000 : labelPlayersSumm.text = "Ваш выигрыш: 1 000 000 руб."
            taskLabel.text = "Миллионер!!!"
        case _ where playersSumm >= 32000 : labelPlayersSumm.text = "Ваш выигрыш: 32 000 руб."
            taskLabel.text = "А ты оказывается умён!"
        case _ where playersSumm >= 1000  : labelPlayersSumm.text = "Ваш выигрыш: 1 000 руб."
            taskLabel.text = "На такси до дома должно хватить"
        default : labelPlayersSumm.text = "Вы проиграли."
            taskLabel.text = "Иди учи и возвращайся!"
        }
        super.viewDidLoad()
    }

    @IBAction func playAgainButtonPress(_ sender: UIButton) {
        let startViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
        startViewController.modalPresentationStyle = .overFullScreen
        self.present(startViewController, animated: false, completion: nil)
    }
}
