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
            
            let rowWin : GameState? = findStreak(next: { i, j in
                return board1.getSymbol(i, j)
            })
            if rowWin != nil {
                return rowWin!
            }
            
            let colWin : GameState? = findStreak(next: { i, j in
                return board1.getSymbol(j, i)
            })
            if colWin != nil {
                return colWin!
            }
            
            let diagWin: GameState? = findDiagStreak(diag: { i in
                return board1.getSymbol(i, i)
            })
            if diagWin != nil {
                return diagWin!
            }
            
            let revDiagWin: GameState? = findDiagStreak(diag: { i in
                return board1.getSymbol(i, 2-i)
            })
            if revDiagWin != nil {
                return revDiagWin!
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
    
    private func findDiagStreak(diag: (Int) -> String) -> GameState? {
        var possibleStreak = true
        for i in 0..<3 {
            if(diag(i) == "-" || diag(i) != diag(0)){
                possibleStreak = false
                break
            }
        }
        
        if possibleStreak {
            return GameState(isOver: true, winner: diag(0))
        }
        return nil
    }
    
    private func findStreak(next: (Int, Int) -> String) -> GameState? {
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



