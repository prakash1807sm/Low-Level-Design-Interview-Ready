//
//  Game.swift
//  Low Level Design
//
//  Created by Prakash Rajak on 27/12/25.
//


import Foundation

class GameEngine {
    
    public func start(type: String) throws -> Board { // we can imagine a board where pieces or points can move
        if type == "TicTacToe"{
            return TicTacToeBoard()
        } else {
            throw GameError.illegalArgumentException("Can't start the game since it is not of tic tac toe type")
        }
    }
    
    public func move(board: Board, move: Move) throws {
        if board is TicTacToeBoard {
            try board.move(move: move)
        } else {
            throw GameError.illegalArgumentException("Board is not of tic tac toe type")
        }
    }
}
