//
//  InitialView.swift
//  Sudoku2.0
//
//  Created by Muhammad Azeem on 16/05/2020.
//  Copyright © 2020 Muhammad Azeem. All rights reserved.
//

import Foundation
import UIKit
import MHSoftUI

class InitialView: UIViewController {
    
    @IBOutlet weak var playButton: UIButton!
//    var duration:CFAbsoluteTime = CFAbsoluteTimeGetCurrent()
//    var startTime:CFAbsoluteTime = CFAbsoluteTimeGetCurrent()
//    var endTime:CFAbsoluteTime = CFAbsoluteTimeGetCurrent()
    override func viewDidLoad() {
        super.viewDidLoad()
//        playButton.layer.cornerRadius = 10
        playButton.addSoftUIEffectForButton(cornerRadius: 10, themeColor: #colorLiteral(red: 0, green: 0.7615224719, blue: 0.8011472821, alpha: 1))
//        playButton.addSoftUIEffectForButton(cornerRadius: 10, themeColor: #colorLiteral(red: 0, green: 0.7615224719, blue: 0.8011472821, alpha: 1))
//        playButton.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//        playButton.layer.masksToBounds = false
//        playButton.layer.shadowColor = UIColor.white.cgColor
//        playButton.layer.shadowRadius = 50
//        playButton.layer.shadowOpacity = 1
//        let shadowPath = UIBezierPath(rect: CGRect(x: 10, y: 10, width: 2, height: 2))
//        playButton.layer.shadowPath = shadowPath.cgPath
        navigationController?.isNavigationBarHidden = true
        
//        startTime = CFAbsoluteTimeGetCurrent()
    }
    
    
    @IBAction func playPressed(_ sender: UIButton) {
//        endTime = CFAbsoluteTimeGetCurrent()
//        duration = endTime - startTime
//        print(String(format: "%.2f", duration))
        self.performSegue(withIdentifier: "GameView", sender: self)
    }
    
}

extension UIButton {
    
    override open var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                 setState()
            } else {
                 resetState()
            }
        }
    }
    
    override open var isEnabled: Bool {
        didSet{
            if isEnabled == false {
                setState()
            } else {
                resetState()
            }
        }
    }
    
    func setState(){
        self.layer.shadowOffset = CGSize(width: -2, height: -2)
        self.layer.sublayers?[0].shadowOffset = CGSize(width: 2, height: 2)
        self.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 0, right: 0)
    }
    
    func resetState(){
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.sublayers?[0].shadowOffset = CGSize(width: -2, height: -2)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 2, right: 2)
    }
    
    public func addSoftUIEffectForButton(cornerRadius: CGFloat = 15.0, themeColor: UIColor = UIColor(red: 241/255, green: 243/255, blue: 246/255, alpha: 1.0)) {
        self.layer.cornerRadius = cornerRadius
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize( width: 2, height: 2)
        self.layer.shadowColor = UIColor.black.cgColor
        
        let shadowLayer = CAShapeLayer()
        shadowLayer.frame = bounds
        shadowLayer.backgroundColor = themeColor.cgColor
        shadowLayer.shadowColor = UIColor.black.cgColor
        shadowLayer.cornerRadius = cornerRadius
        shadowLayer.shadowOffset = CGSize(width: -2.0, height: -2.0)
        shadowLayer.shadowOpacity = 0.2
        shadowLayer.shadowRadius = 2
        self.layer.insertSublayer(shadowLayer, below: self.imageView?.layer)
    }
}
