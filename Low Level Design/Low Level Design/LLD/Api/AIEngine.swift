//
//  AIEngine.swift
//  Low Level Design
//
//  Created by Prakash Rajak on 29/12/25.
//

class AIEngine {
    
    func suggestMove(player: Player, board: Board) throws -> Move {
        if board is TicTacToeBoard {
            let board1 : TicTacToeBoard = board as! TicTacToeBoard
            var suggestion: Move
            let threshold: Int = 4
            if countMoves(board: board1) < threshold {
                do {
                    suggestion = try getBasicMove(player: player, board: board1)
                    return suggestion
                } catch {
                    throw GameError.illegalStateException("there is no empty place on the board")
                }
            } else {
                suggestion =  try getSmartMove(player: player, board: board1) //todo prakash
                return suggestion //todo prakash
            }
        }
        throw GameError.illegalArgumentException("Board is not of tic tac toe type")
    }
    
    func getSmartMove(player: Player, board: TicTacToeBoard) throws -> Move {
        let ruleEngine: RuleEngine = RuleEngine()
        
        //Victorious move
        for i in 0..<3 {
            for j in 0..<3 {
                if (board.getSymbol(i, j) == "-"){
                    let move: Move =  Move(cell: Cell(row: i, col: j), player: player)
                    let boardCopy : TicTacToeBoard = board.copy() as! TicTacToeBoard
                    try boardCopy.move(move: move)
                    if ((try! ruleEngine.getState(board: boardCopy)).isOver) {
                        return move
                    }
                }
            }
        }
        
        //Defensive move
        for i in 0..<3 {
            for j in 0..<3 {
                if (board.getSymbol(i, j) == "-"){
                    let move: Move =  Move(cell: Cell(row: i, col: j), player: player.flip())
                    let boardCopy : TicTacToeBoard = board.copy() as! TicTacToeBoard
                    try boardCopy.move(move: move)
                    if ((try! ruleEngine.getState(board: boardCopy)).isOver) {
                        return Move(cell: Cell(row: i, col: j), player: player)
                    }
                }
            }
        }
        
        return try getBasicMove(player: player, board: board) //todo try? try try!
    }
    
    func getBasicMove(player: Player, board: TicTacToeBoard) throws -> Move {
        for i in 0..<3 {
            for j in 0..<3{
                if(board.getSymbol(i, j) == "-"){
                    return Move(cell: Cell(row: i, col: j), player: player)
                }
            }
        }
        throw GameError.illegalStateException("there is no empty place on the board")
    }
    
    func countMoves(board: TicTacToeBoard) -> Int {
        var count = 0
        for i in 0..<3 {
            for j in 0..<3{
                if(board.getSymbol(i, j) != "-"){
                    count += 1
                }
            }
        }
        return count
    }
    
}
