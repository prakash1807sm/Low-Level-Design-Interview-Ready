//
//  TicTacToeBoard.swift
//  Low Level Design
//
//  Created by Prakash Rajak on 27/12/25.
//

import Foundation

class TicTacToeBoard : Board {
    
    private var cells: [[String]] = [
        ["-", "-", "-"],
        ["-", "-", "-"],
        ["-", "-", "-"],
    ]
    
    public func setCell(cell: Cell, symbol: String) throws {
        if cells[cell.getRow()][cell.getCol()] ==  "-" {
            cells[cell.getRow()][cell.getCol()] = symbol
        } else {
            throw GameError.illegalArgumentException("Cell is not empty, row: \(cell.getRow()), col: \(cell.getCol())")
        }
        
    }
    
    public func getSymbol(_ i: Int, _ j: Int) -> String {
        return cells[i][j]
    }
    
    public func move(move: Move) throws{
        try setCell(cell: move.getSymbol(), symbol: move.getPlayer().symbol())
    }
    
    public func printCells() { // written by me
        for cell in cells {
            print(cell, terminator: "\n")
        }
    }
    
    func copy() -> any Board {
        let ticTacToeBoard = TicTacToeBoard()
        for i in 0..<3 {
            for j in 0..<3 {
                ticTacToeBoard.cells[i][j] = cells[i][j]
            }
        }
        return ticTacToeBoard
    }
    
    static func getName() -> String {
        return String(describing: type(of: self))
    }
}
