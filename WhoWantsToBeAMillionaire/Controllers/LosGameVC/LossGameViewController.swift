//
//  LossGameViewController.swift
//  Millionaire
//
//  Created by user on 9.02.23.
//

import UIKit

class LossGameViewController: UIViewController {
    @IBOutlet weak var labelPlayersSumm: UILabel!
    var playersSumm = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        labelPlayersSumm.text = "Ваш выигрыш: " + String(playersSumm) + "рублей."

    }

    @IBAction func playAgainButtonPress(_ sender: UIButton) {
        let startViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
        startViewController.modalPresentationStyle = .overFullScreen
        self.present(startViewController, animated: false, completion: nil)
    }
}
