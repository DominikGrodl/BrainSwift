//
//  Operation.swift
//
//
//  Created by Dominik Grodl on 08.02.2024.
//

import Foundation

enum OperationType: Character {
    case right = ">"
    case left = "<"
    case increment = "+"
    case decrement = "-"
    case output = "."
    case input = ","
    case jumpIfZero = "["
    case jumpIfNotZero = "]"
}

struct Operation: CustomDebugStringConvertible {
    let type: OperationType
    let jumpAddress: [OperationType].Index
    
    var debugDescription: String {
        switch type {
        case .increment, .decrement, .right, .left, .input, .output:
            return "\(type)"
            
        case .jumpIfZero, .jumpIfNotZero:
            return "\(type) -> \(jumpAddress)"
        }
    }
}
