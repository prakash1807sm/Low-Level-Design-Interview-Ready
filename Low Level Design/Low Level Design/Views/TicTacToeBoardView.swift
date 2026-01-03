//
//  TicTacToeBoardView.swift
//  Low Level Design
//
//  Created by Prakash Rajak on 28/12/25.
//


import UIKit

final class TicTacToeBoardView: UIView {

    var onCellTapped: ((Int, Int) -> Void)?

    private let mainStack = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        buildBoard()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        mainStack.axis = .vertical
        mainStack.spacing = 0
        mainStack.distribution = .fillEqually

        addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    private func buildBoard() {
        for row in 0..<3 {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 0
            rowStack.distribution = .fillEqually

            for col in 0..<3 {
                let cell = TicTacToeCellButton(row: row, col: col)
                cell.addTarget(self, action: #selector(cellTapped(_:)), for: .touchUpInside)
                rowStack.addArrangedSubview(cell)
            }

            mainStack.addArrangedSubview(rowStack)
        }
    }

    @objc
    private func cellTapped(_ sender: TicTacToeCellButton) {
        onCellTapped?(sender.row, sender.col)
    }

    // MARK: - Public helpers

    func updateCell(row: Int, col: Int, symbol: String) {
        let rowStack = mainStack.arrangedSubviews[row] as! UIStackView
        let cell = rowStack.arrangedSubviews[col] as! TicTacToeCellButton
        cell.setTitle(symbol, for: .normal)
        cell.isEnabled = false
    }

    func resetBoard() {
        for rowStack in mainStack.arrangedSubviews {
            let stack = rowStack as! UIStackView
            for cell in stack.arrangedSubviews {
                let button = cell as! TicTacToeCellButton
                button.setTitle("-", for: .normal)
                button.isEnabled = true
            }
        }
    }
}
