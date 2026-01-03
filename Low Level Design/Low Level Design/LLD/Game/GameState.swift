//
//  GameState.swift
//  Low Level Design
//
//  Created by Prakash Rajak on 27/12/25.
//

import Foundation

class GameState {
    var isOver: Bool
    var winner: String
    
    init(isOver: Bool, winner: String) {
        self.isOver = isOver
        self.winner = winner
    }
}
