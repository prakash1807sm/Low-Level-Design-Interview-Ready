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
    private var numberOfMoves: Int
    
    init(isOver: Bool, winner: String, hasFork: Bool, player: Player?, numberOfMoves: Int) {
        self.isOver = isOver
        self.winner = winner
        self.hasFork = hasFork
        self.player = player
        self.numberOfMoves = numberOfMoves
    }
}
