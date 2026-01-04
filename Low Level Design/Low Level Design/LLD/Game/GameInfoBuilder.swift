//
//  GameInfoBuilder.swift
//  Low Level Design
//
//  Created by Prakash Rajak on 04/01/26.
//


class GameInfoBuilder {
    private var isOver: Bool
    private var winner: String
    private var hasFork: Bool = false
    private var player: Player?
    private var numberOfMoves: Int = 0
    
    init(isOver: Bool, winner: String) {
        self.isOver = isOver
        self.winner = winner
    }
    
    public func hasFork(hasFork: Bool) -> GameInfoBuilder {
        self.hasFork = hasFork
        return self
    }
    
    public func player(player: Player) -> GameInfoBuilder {
        self.player = player
        return self
    }
    
    public func numberOfMoves(numberOfMoves: Int) -> GameInfoBuilder {
        self.numberOfMoves = numberOfMoves
        return self
    }
    
    public func build() -> GameInfo {
       return GameInfo(isOver: isOver, winner: winner, hasFork: hasFork, player: player, numberOfMoves: numberOfMoves)
    }
}
