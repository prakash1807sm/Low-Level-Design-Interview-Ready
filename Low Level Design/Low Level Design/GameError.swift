//
//  GameError.swift
//  Low Level Design
//
//  Created by Prakash Rajak on 28/12/25.
//

import Foundation

//Note: Added by me with the help of chat gpt to consider the flow of the app when it is error scenarions
enum GameError: Error {
    case illegalArgumentException(String)
    case illegalStateException(String)
}
