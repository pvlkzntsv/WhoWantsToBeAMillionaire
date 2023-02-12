//
//  StartViewController.swift
//  WhoWantsToBeAMillionaire
//
//  Created by pvl kzntsv on 09.02.2023.
//

import UIKit

class StartViewController: UIViewController {
    var quest = QuestionViewController()
    let rules = QuestionsList().gameRules
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startButtonPressed(_ sender: UIButton) {
        quest.modalPresentationStyle = .fullScreen //показ не в стиле карточки а на полный экран
        self.present(quest, animated: true, completion: nil)
        
    }
    
    @IBAction func gameRulesButtonPressed(_ sender: UIButton) {
        let ac = UIAlertController(title: "Правила игры", message: rules, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Вернуться", style: .cancel, handler: .none))
        present(ac, animated: true)
    }
}
