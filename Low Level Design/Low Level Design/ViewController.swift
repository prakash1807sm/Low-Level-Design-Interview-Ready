//
//  ViewController.swift
//  Low Level Design
//
//  Created by Prakash Rajak on 29/12/25.
//


import UIKit

class ViewController: UIViewController {
    
    private let boardView = TicTacToeBoardView()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .systemBackground
        setupBoard()
//        setupGameEngine()
    }
    
//    private func setupGameEngine() {
//        let gameEngine = GameEngine()
//        var board: Board = gameEngine.start(type: "TicTacToe")
//
//        var row: Int = 0
//        var col: Int = 0
//
//        while (!gameEngine.isComplete(board: board).isOver) {
//            var computer: Player = Player(playerSymbol: "O")
//            var opponent: Player = Player(playerSymbol: "X")
//
//            print("Make your move!")
//
//            let oppMove = Move(cell: Cell(row: row, col: col))
//            gameEngine.move(board: board, player: opponent, move: oppMove)
//
//            if (!gameEngine.isComplete(board: board).isOver) {
//                let compMove = gameEngine.suggestMove(player: computer, board: board)
//                gameEngine.move(board: board, player: computer, move: compMove)
//            }
//        }
//        print(gameEngine.isComplete(board: board))
//    }
    
    
    private func setupBoard() {
        view.addSubview(boardView)
        boardView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            boardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            boardView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            boardView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            boardView.heightAnchor.constraint(equalTo: boardView.widthAnchor)
        ])
        
        let gameEngine = GameEngine()
        let ruleEngine = RuleEngine()
        let aiEngine = AIEngine()
        let board: Board = try! gameEngine.start(type: "TicTacToe") // we are sure that we are working for tic tac toe. but good to do in do catch block. todo
        
        let board1 : TicTacToeBoard = board as! TicTacToeBoard
        board1.printCells()
        
        boardView.onCellTapped = { [weak self] row, col in

            if (!(try! ruleEngine.getState(board: board)).isOver) { // we are sure that we are working for tic tac toe. but good to do in do catch block. todo
                print("Make your move!")
                let human: Player = Player(playerSymbol: "X")
                let humanMove = Move(cell: Cell(row: row, col: col), player: human)
                try! gameEngine.move(board: board, move: humanMove)
                self?.updateCellText(row: row, col: col, symbol: "X")
                board1.printCells()
                
                if (!(try! ruleEngine.getState(board: board)).isOver) {
                    print("Make AI move!")
                    let computer: Player = Player(playerSymbol: "O")
                    do {
                        let compMove = try aiEngine.suggestMove(player: computer, board: board)
                        try! gameEngine.move(board: board, move: compMove)
                        self?.updateCellText(row: compMove.getSymbol().getRow(), col: compMove.getSymbol().getCol(), symbol: "O")
                    } catch {
                        print("Error: \(error)")
                    }
                    board1.printCells()
                }
            }
            
            let gameResult = try! ruleEngine.getState(board: board)
            if(gameResult.isOver) {
                print("Winner : \(gameResult.winner)")
            }
        }
    }
    
    func updateCellText(row: Int, col: Int, symbol: String){
        boardView.updateCell(row: row, col: col, symbol: symbol)
    }
}
