//
//  Low_Level_DesignTests.swift
//  Low Level DesignTests
//
//  Created by Prakash Rajak on 29/12/25.
//

import XCTest
@testable import Low_Level_Design

final class Low_Level_DesignTests: XCTestCase {
    
    var gameEngine: GameEngine!
    var ruleEngine: RuleEngine!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        gameEngine = GameEngine()
        ruleEngine = RuleEngine()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    private func playGame(board: Board, firstPlayerMoves: [[Int]], secondPlayerMoves: [[Int]]) {
        var row: Int = 0
        var col: Int = 0
        var next: Int = 0
        
        let board1 : TicTacToeBoard = board as! TicTacToeBoard //just to print todo
        
        while (!(try! ruleEngine.getState(board: board)).isOver) { // we are sure that we are working for tic tac toe. but good to do in do catch block. todo
            let firstPlayer: Player = Player(playerSymbol: "X")
            let secondPlayer: Player = Player(playerSymbol: "O")
            
            print("Make your move!")
            row = firstPlayerMoves[next][0]
            col = firstPlayerMoves[next][1]
            
            let firstPlayerMove = Move(cell: Cell(row: row, col: col), player: firstPlayer)
            
            do {
                try gameEngine.move(board: board, move: firstPlayerMove)
                board1.printCells()
            } catch {
                print("Error: \(error)")
                break
            }
            
            if (!(try! ruleEngine.getState(board: board)).isOver) {
                print("Make AI move!")
                let sRow = secondPlayerMoves[next][0]
                let sCol = secondPlayerMoves[next][1]
                let secondPlayerMove = Move(cell: Cell(row: sRow, col: sCol), player: secondPlayer)
                do {
                    try gameEngine.move(board: board, move: secondPlayerMove)
                    board1.printCells()
                } catch {
                    print("Error: \(error)")
                    break
                }
            }
            next += 1
        }
    }
    
    func testCheckForRowWin() throws {
        let board: Board = try! gameEngine.start(type: "TicTacToe")
        
        let firstPlayerMoves: [[Int]] = [ [1, 0], [1, 1], [1, 2] ]
        let secondPlayerMoves: [[Int]] = [ [0, 0], [0, 1], [0, 2] ]
        
        playGame(board: board, firstPlayerMoves: firstPlayerMoves, secondPlayerMoves: secondPlayerMoves)
        
        let gameState = try! ruleEngine.getState(board: board)
        
        XCTAssertTrue(gameState.isOver)
        XCTAssertEqual(gameState.winner, "X")
    }
    
    func testCheckForColWin() throws {
        let board: Board = try! gameEngine.start(type: "TicTacToe")
        
        let firstPlayerMoves: [[Int]] = [ [0, 0], [1, 0], [2, 0] ]
        let secondPlayerMoves: [[Int]] = [ [0, 1], [0, 2], [1, 0] ]
        playGame(board: board, firstPlayerMoves: firstPlayerMoves, secondPlayerMoves: secondPlayerMoves)
        
        let gameState = try! ruleEngine.getState(board: board)
        
        XCTAssertTrue(gameState.isOver)
        XCTAssertEqual(gameState.winner, "X")
    }
    
    func testCheckForDiagWin() throws {
        let board: Board = try! gameEngine.start(type: "TicTacToe")
        
        let firstPlayerMoves: [[Int]] = [ [0, 0], [1, 1], [2, 2] ]
        let secondPlayerMoves: [[Int]] = [ [0, 1], [0, 2], [1, 1] ]
        playGame(board: board, firstPlayerMoves: firstPlayerMoves, secondPlayerMoves: secondPlayerMoves)
        
        let gameState = try! ruleEngine.getState(board: board)
        
        XCTAssertTrue(gameState.isOver)
        XCTAssertEqual(gameState.winner, "X")
    }
    
    func testCheckForRevDiagWin() throws {
        let board: Board = try! gameEngine.start(type: "TicTacToe")
        
        let firstPlayerMoves: [[Int]] = [ [0, 2], [1, 1], [2, 0] ]
        let secondPlayerMoves: [[Int]] = [ [0, 0], [0, 1], [1, 0] ]
        playGame(board: board, firstPlayerMoves: firstPlayerMoves, secondPlayerMoves: secondPlayerMoves)
        
        let gameState = try! ruleEngine.getState(board: board)
        
        XCTAssertTrue(gameState.isOver)
        XCTAssertEqual(gameState.winner, "X")
    }
    
    func testCheckForSecondPlayerWin() throws {
        let board: Board = try! gameEngine.start(type: "TicTacToe")
        
        let firstPlayerMoves: [[Int]] = [ [1, 0], [1, 1], [2, 0] ]
        let secondPlayerMoves: [[Int]] = [ [0, 0], [0, 1], [0, 2] ]
        playGame(board: board, firstPlayerMoves: firstPlayerMoves, secondPlayerMoves: secondPlayerMoves)
        
        let gameState = try! ruleEngine.getState(board: board)
        
        XCTAssertTrue(gameState.isOver)
        XCTAssertEqual(gameState.winner, "O")
    }
}
