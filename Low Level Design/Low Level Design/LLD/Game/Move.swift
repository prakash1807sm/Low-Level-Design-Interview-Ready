//
//  Move.swift
//  Low Level Design
//
//  Created by Prakash Rajak on 27/12/25.
//
import Foundation

class Move {
    private var cell: Cell
    private var player: Player
    
    init(cell: Cell, player: Player) {
        self.cell = cell
        self.player = player
    }
    
    public func getSymbol() -> Cell {
        return cell
    }
    
    public func getPlayer() -> Player {
        return player
    }
}
