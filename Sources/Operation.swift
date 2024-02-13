//
//  Operation.swift
//
//
//  Created by Dominik Grodl on 08.02.2024.
//

import Foundation

enum OperationType: UTF8.CodeUnit {
    case right = 0x3e // ">"
    case left = 0x3c // "<"
    case increment = 0x2b // "+"
    case decrement = 0x2d // "-"
    case output = 0x2e // "."
    case input = 0x2c // ","
    case jumpIfZero = 0x5b // "["
    case jumpIfNotZero = 0x5d // "]"
}

struct Operation: CustomDebugStringConvertible {
    let type: OperationType
    
    /*
     Jump address is used for Operation types jumpIfZero and jumpIfNotZero to determine the operation address to jump to.
     This is to optimize the runtime so that when interpreting conditional jumps, we don't have to calculate the result address every time. 
     In future, this could be renamed and used both for this and to signify multiple same operation types in a row to optimize the runtime interpretation
     */
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
