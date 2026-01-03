//
//  TicTacToeCellButton.swift
//  Low Level Design
//
//  Created by Prakash Rajak on 28/12/25.
//


import UIKit

final class TicTacToeCellButton: UIButton {

    let row: Int
    let col: Int

    init(row: Int, col: Int) {
        self.row = row
        self.col = col
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        setTitle("-", for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 36, weight: .bold)
        setTitleColor(.label, for: .normal)

        backgroundColor = .systemBackground
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor

        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalTo: widthAnchor).isActive = true
    }
}
