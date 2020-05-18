//
//  ResultView.swift
//  Sudoku2.0
//
//  Created by Muhammad Azeem on 16/05/2020.
//  Copyright © 2020 Muhammad Azeem. All rights reserved.
//

import UIKit

class ResultView: UIViewController {
    
    @IBOutlet weak var mainMenu: UIButton!
    @IBOutlet weak var score: UILabel!
    
    var yourScore = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        score.text = String(Scoring().score)
        score.text = yourScore
        
        mainMenu.addSoftUIEffectForButton(cornerRadius: 10, themeColor: #colorLiteral(red: 0, green: 0.7615224719, blue: 0.8011472821, alpha: 1))
        navigationController?.isNavigationBarHidden = true
    }
    
    
    @IBAction func menuButtonPressed(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
        
    }
}


