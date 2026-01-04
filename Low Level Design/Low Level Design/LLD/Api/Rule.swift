//
//  Rule.swift
//  Low Level Design
//
//  Created by Prakash Rajak on 04/01/26.
//


class Rule<T: Board> {
    var condition: (T) -> GameState
    init(condition:  @escaping (T) -> GameState) {
        self.condition = condition
    }
}