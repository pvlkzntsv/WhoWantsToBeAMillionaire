//
//  LossGameViewController.swift
//  Millionaire
//
//  Created by user on 9.02.23.
//

import UIKit

class LossGameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func playAgainButtonPress(_ sender: UIButton) {
        let startViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
        startViewController.modalPresentationStyle = .overFullScreen
        self.present(startViewController, animated: false, completion: nil)
    }
}
