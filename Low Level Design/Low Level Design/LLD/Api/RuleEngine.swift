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
            
            
            let getRow: (Int) -> String = { i in
                return board1.getSymbol(i, 0)
            }
            
            let getCol: (Int) -> String = { i in
                return board1.getSymbol(0, i)
            }
            
            let getNextRow: (Int, Int) -> String = { i, j in
                return board1.getSymbol(i, j)
            }
            
            let getNextCol: (Int, Int) -> String = { i, j in
                return board1.getSymbol(j, i)
            }
            
            let rowWin : GameState? = isVictory(startsWith: getRow, next: getNextRow)
    
            if rowWin != nil {
                return rowWin!
            }
            
            //Here alternate way to reduce code is pass the closure inline
//            let rowWinInline : GameState? = isVictory(startsWith: { i in
//                return board1.getSymbol(i, 0)
//            }, next: { i, j in
//                return board1.getSymbol(i, j)
//            })
            
            let colWin : GameState? = isVictory(startsWith: getCol, next: getNextCol)
            if colWin != nil {
                return colWin!
            }
            
            //Here alternate way to reduce code is pass the closure inline
//            let colWinInline : GameState? = isVictory(startsWith: { i in
//                return board1.getSymbol(0, i)
//            }, next: { i, j in
//                return board1.getSymbol(j, i)
//            })

            
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
    
    
    public func isVictory(startsWith: (Int) -> String, next: (Int, Int) -> String) -> GameState? {
        for i in 0..<3 {
            var possibleStreak = true
            for j in 1..<3 {
                if(next(i, j) == "-" || next(i, j) != next(i, 0)){
                    possibleStreak = false
                    break
                }
            }
            
            if(possibleStreak) {
                return GameState(isOver: true, winner: next(i, 0))
            }
        }
        return nil
    }
}



