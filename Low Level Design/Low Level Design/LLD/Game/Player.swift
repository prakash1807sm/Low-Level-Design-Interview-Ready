//
//  Player.swift
//  Low Level Design
//
//  Created by Prakash Rajak on 27/12/25.
//

import Foundation

class Player {
    private var playerSymbol: String
    
    init(playerSymbol: String) {
        self.playerSymbol = playerSymbol
    }
    
    public func symbol() -> String {
        return playerSymbol
    }
    
    public func flip() -> Player {
        return Player(playerSymbol: playerSymbol == "O" ? "X" : "O")
    }
}
