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
    
    //Jump address is used for Operation types jumpIfZero and jumpIfNotZero to determine the operation address to jump to. This is to optimize the runtime so that when interpreting conditional jumps, we don't have to calculate the result address every time. In future, this could be renamed and used both for this and to signify multiple same operation types in a row to optimize the runtime interpretation loop.
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
