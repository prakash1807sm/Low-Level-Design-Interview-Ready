//
//  Board.swift
//  Low Level Design
//
//  Created by Prakash Rajak on 27/12/25.
//

import Foundation

protocol Board {
    func move(move: Move) throws
    func copy() -> Board
    static func getName() -> String
}
