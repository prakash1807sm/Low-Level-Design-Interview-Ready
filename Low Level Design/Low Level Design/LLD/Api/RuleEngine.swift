//
//  RuleEngine.swift
//  Low Level Design
//
//  Created by Prakash Rajak on 29/12/25.
//

import Foundation

class RuleEngine {
    public func getState(board: Board) throws -> GameState {
        if board is TicTacToeBoard {
            let board1 : TicTacToeBoard = board as! TicTacToeBoard
            
            var firstCharacter: String = ""
            //rows
            var rowComplete: Bool = true
            for i in 0..<3 {
                firstCharacter = board1.getSymbol(i, 0)
                rowComplete = firstCharacter != "-"
                if firstCharacter != "-" {
                    for j in 1..<3 {
                        if(board1.getSymbol(i, j) != firstCharacter){
                            rowComplete = false
                            break
                        }
                    }
                }
                
                if(rowComplete) {
                    break
                }
            }
            
            if rowComplete {
                return GameState(isOver: true, winner: firstCharacter)
            }
            
            //columns
            var colComplete: Bool = true
            for i in 0..<3 {
                firstCharacter = board1.getSymbol(0, i)
                colComplete = firstCharacter != "-"
                if firstCharacter !=  "-" {
                    for j in 1..<3 {
                        if(board1.getSymbol(j, i) != firstCharacter){
                            colComplete = false
                            break
                        }
                    }
                }
                if(colComplete) {
                    break
                }
            }
            
            if colComplete {
                return GameState(isOver: true, winner: firstCharacter)
            }
            
            //diagonals
            firstCharacter = board1.getSymbol(0, 0)
            var diagComplete: Bool = firstCharacter != "-"
            for i in 0..<3 {
                if(firstCharacter != "-" && board1.getSymbol(i, i) != firstCharacter){
                    diagComplete = false
                    break
                }
            }
            
            if diagComplete {
                return GameState(isOver: true, winner: firstCharacter)
            }
            
            //rev diagonal
            firstCharacter = board1.getSymbol(0, 2)
            var revDiagComplete: Bool = firstCharacter != "-"
            for i in 0..<3 {
                if(firstCharacter != "-" && board1.getSymbol(i, 2-i) != firstCharacter){
                    revDiagComplete = false
                    break
                }
            }
            
            if revDiagComplete {
                return GameState(isOver: true, winner: firstCharacter)
            }
            
            var countFilledCells : Int = 0
            for i in 0..<3{
                for j in 0..<3{
                    if(board1.getSymbol(i, j) != "-"){
                        countFilledCells += 1
                    }
                }
            }
            if countFilledCells == 9 {
                return GameState(isOver: true, winner: "-")
            } else {
                return GameState(isOver: false, winner: "-")
            }
        } else {
            throw GameError.illegalArgumentException("Board is not of tic tac toe type")
        }
    }
}



