//
//  ViewController.swift
//  Sudoku2.0
//
//  Created by Muhammad Azeem on 14/05/2020.
//  Copyright © 2020 Muhammad Azeem. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    
    @IBOutlet weak var time: UILabel!
    var score = 5
    var timer = Timer()
    var items: [[Int]] = [[]]
    var iArr: [[(Int, UIColor)]] = Array(repeating: Array(repeating: (0, UIColor.white), count: 9), count: 9)
    var initialArray: [[Int]] = [[]]
    let grid = GridData()
    var scoring = Scoring()
    var secondsPassed = 0.0
    var count = 0
    var gameCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = false
        // Do any additional setup after loading the view.
        grid.fillSudoku()
        print(grid.sudo[0])
        items = grid.sudo
        grid.generatePuzzle()
        for (i, item) in grid.sudoku.enumerated() {
            for (j, value) in item.enumerated() {
                iArr[i][j] = (Int(value), UIColor.white)
            }
        }
        //        iArr = grid.sudoku
        initialArray = grid.sudoku
        
        count = counting(array: initialArray)
        
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
    }
    
    func counting(array: [[Int]]) -> Int {
        var count = 0
        for i in 0..<array.count{
            for j in 0..<array.count{
                if array[i][j] == 0 {
                    count += 1
                }
            }
        }
        return count
    }
    
    @objc func update() {
        let str = String(String(format: "%.1f", secondsPassed))
        let index = str.firstIndex(of: ".")
        //        time.text = "\(String(str[..<index!])):\(String(str[..<index!]))"
        let minutes = String(str.prefix(upTo: index!))
        let seconds = String(str.suffix(from: index!))
        print(seconds.suffix(1))
        time.text = "\(minutes):\(seconds.suffix(1))"
        secondsPassed += 0.1
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var vc = segue.destination as! ResultView
        vc.yourScore = String(self.scoring.score)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/10.0
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return iArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return iArr[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.layer.borderWidth = 2
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = UIColor.black.cgColor
        //        let string = iArr[indexPath.section][indexPath.item]
        let (string, color) = iArr[indexPath.section][indexPath.item]
        cell.myLabel.text = String(string)
        cell.backgroundColor = color
        //        cell.myLabel.text = String(string)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
        if(self.initialArray[indexPath.section][indexPath.item] == 0){
            let alert = UIAlertController(title: "Add Sudoku number", message: "", preferredStyle: .alert)
            presentAlert(collectionView, indexPath: indexPath, alert: alert)
        }
    }
    
    func scoring(color: UIColor) {
        if(color == UIColor.green){
            if (secondsPassed <= 1.0) {
                scoring.score += 5
            }
            else if (secondsPassed > 1.0 && secondsPassed < 5.0) {
                scoring.score += 4
            }
            else {
                scoring.score += 2
            }
        }
        else {
            if (secondsPassed <= 1.0) {
                scoring.score -= 2
            }
            else if (secondsPassed > 1.0 && secondsPassed < 5.0) {
                scoring.score -= 4
            }
            else {
                scoring.score -= 5
            }
        }
    }
    
    func presentAlert(_ collectionView: UICollectionView, indexPath: IndexPath, alert: UIAlertController){
        var textField = UITextField()
        var arr: [[Int]] = Array(repeating: Array(repeating: 0, count: 9), count: 9)
        for (i, item) in iArr.enumerated() {
            for (j, value) in item.enumerated() {
                arr[i][j] = value.0
            }
        }
        let action = UIAlertAction(title: "Add Cell", style: .default) { (action) in
            //Once user presses add button
            if (!textField.text!.trimmingCharacters(in: .whitespaces).isEmpty){
                let newItem = Int(textField.text!)!
                if newItem != 0 {
                    if(self.grid.checkGrid(sudo: arr, i: indexPath.section, j: indexPath.item, num: newItem) && self.grid.checkRowColumn(sudo: arr, row: indexPath.section, col: indexPath.item, num: newItem)){
                        self.iArr[indexPath.section][indexPath.item] = (newItem, UIColor.green)
                        print(self.iArr[indexPath.section][indexPath.item])
                        self.gameCount += 1
                        self.scoring(color: UIColor.green)
                        if self.gameCount == 5 {
                            self.performSegue(withIdentifier: "Result", sender: self)
                        }
                        if self.gameCount == self.count {
                            self.timer.invalidate()
                            self.performSegue(withIdentifier: "Result", sender: self)
                        }
                    }
                    else {
                        self.iArr[indexPath.section][indexPath.item] = (newItem, UIColor.red)
                        print(self.iArr[indexPath.section][indexPath.item])
                    }
                }
                else {
                    self.iArr[indexPath.section][indexPath.item] = (newItem, UIColor.white)
                }
            }
            
            collectionView.reloadData()
        }
        
        
        //        let action = UIAlertAction(title: "Add Cell", style: .default) { (action) in
        //            //Once user presses add button
        //            if (!textField.text!.trimmingCharacters(in: .whitespaces).isEmpty){
        //                let newItem: String
        //                newItem = textField.text!
        //                if(self.grid.checkGrid(sudo: self.iArr, i: indexPath.section, j: indexPath.item, num: Int(newItem)!) && self.grid.checkRowColumn(sudo: self.iArr, row: indexPath.section, col: indexPath.item, num: Int(newItem)!)){
        //                    self.iArr[indexPath.section][indexPath.item] = Int(newItem)!
        //                    print(self.iArr[indexPath.section][indexPath.item])
        //
        //                }
        //                else {
        //                    self.iArr[indexPath.section][indexPath.item] = Int(newItem)!
        //                    print(self.iArr[indexPath.section][indexPath.item])
        //
        //                    collectionView.reloadData()
        //                }
        //            }
        //        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

