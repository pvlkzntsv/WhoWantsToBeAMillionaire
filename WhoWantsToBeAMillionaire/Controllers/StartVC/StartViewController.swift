//
//  StartViewController.swift
//  WhoWantsToBeAMillionaire
//
//  Created by pvl kzntsv on 09.02.2023.
//

import UIKit

class StartViewController: UIViewController {
    var quest = QuestionViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func startButtonPressed(_ sender: UIButton) {
        quest.modalPresentationStyle = .fullScreen //показ не в стиле карточки а на полный экран
        self.present(quest, animated: true, completion: nil)
        
    }
    
    @IBAction func gameRulesButtonPressed(_ sender: UIButton) {
    }
}
