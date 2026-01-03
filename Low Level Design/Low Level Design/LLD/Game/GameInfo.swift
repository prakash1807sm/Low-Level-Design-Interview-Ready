//
//  GameInfo.swift
//  Low Level Design
//
//  Created by Prakash Rajak on 04/01/26.
//


class GameInfo {
    private var isOver: Bool
    private var winner: String
    private var hasFork: Bool
    private var player: Player?
    
    init(gameState: GameState, hasFork: Bool, player: Player?) {
        self.isOver = gameState.isOver
        self.winner = gameState.winner
        self.hasFork = hasFork
        self.player = player
    }
}
