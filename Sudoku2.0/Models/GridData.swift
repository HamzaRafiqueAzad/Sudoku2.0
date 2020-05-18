//
//  Grid.swift
//  Sudoku2.0
//
//  Created by Muhammad Azeem on 14/05/2020.
//  Copyright © 2020 Muhammad Azeem. All rights reserved.
//

import Foundation

class GridData {
    //    var sudo: [[Int]] = [[0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0], [0, 0, 0, 0, 0, 0, 0, 0, 0]]
    var score = 0
    var sudo = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)
    var sudoku = [[Int]](repeating: [Int](repeating: 0, count: 9), count: 9)

    var rArr: [Int] = []
    let data = ["1"]
    
    func fillSudoku() -> Bool{
        for i in 0..<sudo[0].count{
            for j in 0..<9{
                if(sudo[i][j] == 0){
                    rArr = [1, 2, 3, 4, 5, 6, 7, 8, 9]
                    rArr.shuffle()
                    for k in 0..<9{
                        let num = rArr[k]
                        if (checkGrid(sudo: sudo, i: i, j: j, num: num) && checkRowColumn(sudo: sudo, row: i, col: j, num: num)){
                            self.sudo[i][j] = num;
                            if (fillSudoku()) {
                                return true;
                            }
                            else {
                                self.sudo[i][j] = Int(0);
                            }
                        }
                    }
                    return false;
                }
                
            }
        }
        return true
    }
    func checkGrid(sudo: [[Int]], i: Int, j: Int, num: Int) -> Bool{
        //        This method checks if the number has appeared in the grid before
        let ii = Int(i - (i % 3));
        let jj = Int(j - (j % 3));
        for k in ii..<(ii+3) {
            for l in jj..<(jj+3) {
                if (sudo[k][l] == num) {
                    return false;
                }
            }
        }
        return true;
    }
    
    func checkRowColumn(sudo: [[Int]], row: Int, col: Int, num: Int) -> Bool{
        if (num == 0) {
            return true;
        }
        for i in 0...8 {
            if (sudo[row][i] == num) {
                return false;
            }
        }
        for i in 0...8 {
            if (sudo[i][col] == num) {
                return false;
            }
        }
        return true;
    }
    func generatePuzzle(){
//        print(Int.random())
        sudoku = sudo
        var i = 0
        while i < 9 {
            for _ in 0..<2 {
//                sudoku[(Int.random() * ((i + 3) - i)) + i][(Int.random() * ((j + 3) - j)) + j] = 0;
                let a = Int.random(in: 0..<9)
                sudoku[i][a] = 0
            }
            i += 1
        }
    }
    
    
    //
    //    func createGrid(sudo: [[Int]]) -> Bool {
    //        for i in 0..<sudo[0].count  {
    //            for j in 0...8 {
    //                if (sudo[i][j] == 0) {
    //                    //                    Shuffling array so that the same board doesn't occur every time the program runs
    //                    rArr = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    //                    rArr.shuffle()
    //
    //                    for k in 0..<rArr.count {
    //                        let num = rArr[k];
    //                        //                        Checking if the number has appeared in a row, column or a grid before
    //                        if (checkGrid(sudo: sudo, i: i, j: j, num: num) && checkRowColumn(sudo: sudo, row: i, col: j, num: num)) {
    //                            self.sudo[i][j] = num;
    //                            //                            recursing the function to solve the 3x3 grids properly
    //                            if (createGrid(sudo: sudo)) {
    //                                return true;
    //                            } else {
    //                                self.sudo[i][j] = 0;
    //                            }
    //                        }
    //                    }
    //
    //                    return false;
    //                }
    //            }
    //        }
    //
    //        return true;
    //    }
    //
    //    func checkRowColumn(sudo: [[Int]], row: Int, col: Int, num: Int) -> Bool{
    //        if (num == 0) {
    //            return true;
    //        }
    //        for i in 0...8 {
    //            if (sudo[row][i] == num) {
    //                return false;
    //            }
    //        }
    //        for i in 0...8 {
    //            if (sudo[i][col] == num) {
    //                return false;
    //            }
    //        }
    //        return true;
    //    }
    //
    //    func checkGrid(sudo: [[Int]], i: Int, j: Int, num: Int) -> Bool{
    //        //        This method checks if the number has appeared in the grid before
    //        let ii = Int(i - (i % 3));
    //        let jj = Int(j - (j % 3));
    //        for k in ii..<(ii+3) {
    //            for l in jj...(jj+3)-1 {
    //                if (sudo[k][l] == num) {
    //                    return false;
    //                }
    //            }
    //        }
    //        return true;
    //    }
    
    //    func shuffleArray(rArr: [Int]){
    //        let randomInt = Int.random(in: 1..<9)
    //        for i in 0..<rArr.count {
    //            let index = Int.random(in: 0..<9)
    //            //            let index = rand.nextInt(arr.length - 1);
    //            let temp = rArr[i];
    //            self.rArr[i] = rArr[index];
    //            self.rArr[index] = temp;
    //        }
    //    }
}
