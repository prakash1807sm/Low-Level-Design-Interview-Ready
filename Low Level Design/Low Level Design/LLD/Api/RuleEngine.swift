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
            
            let rowWin : GameState = outerTraversal(next: { i, j in
                return board1.getSymbol(i, j)
            })
            if rowWin.isOver {
                return rowWin
            }
            
            let colWin : GameState = outerTraversal(next: { i, j in
                return board1.getSymbol(j, i)
            })
            if colWin.isOver {
                return colWin
            }
            
            let diagWin: GameState = findDiagStreak(traversal: { i in
                return board1.getSymbol(i, i)
            })
            if diagWin.isOver {
                return diagWin
            }
            
            let revDiagWin: GameState = findDiagStreak(traversal: { i in
                return board1.getSymbol(i, 2-i)
            })
            if revDiagWin.isOver {
                return revDiagWin
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
    
    private func findDiagStreak(traversal: (Int) -> String) -> GameState {
        return traverse(traversal: traversal)
    }
    
    private func outerTraversal(next: @escaping (Int, Int) -> String) -> GameState {
        var result = GameState(isOver: false, winner: "-")
        for i in 0..<3 {
            let ii = i
            let traversal: GameState = traverse(traversal: { j in
                return next(ii, j)
            })
            if traversal.isOver {
                result = traversal
                break
            }
        }
        return result
    }
    
    private func traverse(traversal: (Int) -> String) -> GameState {
        var result = GameState(isOver: false, winner: "-")
        var possibleStreak = true
        for j in 0..<3 {
            if(traversal(j) == "-" || traversal(j) != traversal(0)){
                possibleStreak = false
                break
            }
        }
        
        if possibleStreak {
            result =  GameState(isOver: true, winner: traversal(0))
        }
        return result
    }
}



