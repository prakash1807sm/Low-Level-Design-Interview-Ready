//
//  RuleEngine.swift
//  Low Level Design
//
//  Created by Prakash Rajak on 29/12/25.
//

import Foundation

class RuleEngine {
    
    var ruleMap: [String : [Rule<TicTacToeBoard>]] = [:]
    
    public init() {
        let key: String = TicTacToeBoard.getName()
        ruleMap[key] = []
        ruleMap[key]?.append(Rule(condition: { board in //todo memory leak check
            return self.outerTraversals { i, j in
                return board.getSymbol(i, j)
            }
        }))
        ruleMap[key]?.append(Rule(condition: { board in //todo memory leak check
            return self.outerTraversals { i, j in
                return board.getSymbol(j, i)
            }
        }))
        
        ruleMap[key]?.append(Rule(condition: { board in //todo memory leak check
            return self.traverse { i in
                return board.getSymbol(i, i)
            }
        }))
        
        ruleMap[key]?.append(Rule(condition: { board in //todo memory leak check
            return self.traverse { i in
                return board.getSymbol(i, 2-i)
            }
        }))
        
        
        ruleMap[key]?.append(Rule(condition: { board in //todo memory leak check
            var countFilledCells : Int = 0
            for i in 0..<3{
                for j in 0..<3{
                    if(board.getSymbol(i, j) != "-"){
                        countFilledCells += 1
                    }
                }
            }
            if countFilledCells == 9 {
                return GameState(isOver: true, winner: "-")
            }
            
            return GameState(isOver: false, winner: "-")
        }))
    }
    
    public func getInfo(board: Board) throws -> GameInfo {
        if board is TicTacToeBoard {
           //Implement to detect fork
            let gameState = try getState(board: board)
            let players: [String] = ["X", "O"]
            for playerSymbol in players {
                for i in 0..<3 {
                    for j in 0..<3 {
                        let b: Board = board.copy()
                        let player : Player = Player(playerSymbol: playerSymbol)
                        try b.move(move: Move(cell: Cell(row: i, col: j), player: player))
                        var canStillWin: Bool =  false
                        for k in 0..<3 {
                            for l in 0..<3 {
                                let b1: Board = b.copy()
                                try b1.move(move: Move(cell: Cell(row: k, col: l), player: player.flip()))
                                
                                if ((try getState(board: b1).winner) == player.flip().symbol()) {
                                    canStillWin = true
                                    break
                                }
                            }
                            if canStillWin {
                                break
                            }
                        }
                        if canStillWin {
                            return GameInfo(gameState: gameState, hasFork: true, player: player.flip())
                        }
                    }
                }
            }
            return GameInfo(gameState: gameState, hasFork: false, player: nil)
        } else {
            throw GameError.illegalArgumentException("Board is not of tic tac toe type")
        }
    }
    
    public func getState(board: Board) throws -> GameState {
        if board is TicTacToeBoard {
            let b : TicTacToeBoard = board as! TicTacToeBoard
            
            let rules: [Rule<TicTacToeBoard>] = ruleMap[TicTacToeBoard.getName()] ?? []
            
            for r in rules {
                let gameState: GameState = r.condition(b)
                if gameState.isOver {
                    return gameState
                }
            }
            return GameState(isOver: false, winner: "-")
        } else {
            throw GameError.illegalArgumentException("Board is not of tic tac toe type")
        }
    }
    
    private func findDiagStreak(traversal: (Int) -> String) -> GameState {
        return traverse(traversal: traversal)
    }
    
    private func outerTraversals(next: @escaping (Int, Int) -> String) -> GameState {
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



