//
//  Cell.swift
//  Low Level Design
//
//  Created by Prakash Rajak on 27/12/25.
//

import Foundation

class Cell {
    private var row: Int
    private var col: Int
    
    init(row: Int, col: Int) {
        self.row = row
        self.col = col
    }
    
    public func getRow() -> Int {
        return row
    }
    
    public func getCol() -> Int {
        return col
    }
}
