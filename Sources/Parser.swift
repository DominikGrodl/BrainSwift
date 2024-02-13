//
//  Parser.swift
//
//
//  Created by Dominik Grodl on 08.02.2024.
//

import Foundation

struct Parser {
    static func parseIntermediateRepresentation(from code: Data) throws -> [Operation] {
        let operationTypes = code.compactMap(OperationType.init)
        var operations = [Operation]()
        
        for index in operationTypes.startIndex..<operationTypes.endIndex {
            let operationType = operationTypes[index]
            
            switch operationType {
            case .increment, .decrement, .right, .left, .input, .output:
                operations.append(Operation(type: operationType, jumpAddress: 0))
                
            case .jumpIfZero:
                operations.append(
                    Operation(
                        type: operationType,
                        jumpAddress: try findCorrespondingJumpAddressForward(
                            in: operationTypes,
                            from: index
                        )
                    )
                )
            case .jumpIfNotZero:
                operations.append(
                    Operation(
                        type: operationType,
                        jumpAddress: try findCorrespondingJumpAddressBackward(
                            in: operationTypes,
                            from: index
                        )
                    )
                )
            }
        }
        
        return operations
    }
    
    private static func findCorrespondingJumpAddressForward(
        in operations: [OperationType],
        from: [OperationType].Index
    ) throws -> [OperationType].Index {
        let window = operations[from...]
        var buffer = 0
        
        for index in window.startIndex..<window.endIndex {
            switch window[index] {
            case .jumpIfZero:
                buffer += 1
                
            case .jumpIfNotZero:
                buffer -= 1
                
            default: continue
            }
            
            if buffer == 0 {
                return index + 1 // + 1 because we want to jump to the address after the corresponding token
            }
        }
        
        throw ParsingError.noCorrespondingJumpAddress(OperationType.jumpIfZero.rawValue, from)
    }
    
    private static func findCorrespondingJumpAddressBackward(
        in operations: [OperationType],
        from: [OperationType].Index
    ) throws -> [OperationType].Index {
        let window = operations[...from]
        var buffer = 0
        var index = window.endIndex - 1
        
        while index >= window.startIndex {
            switch window[index] {
            case .jumpIfZero:
                buffer -= 1
            case .jumpIfNotZero:
                buffer += 1
                
            default:
                index -= 1
                continue
            }
            
            if buffer == 0 {
                return index + 1 // + 1 because we want to jump to the address after the corresponding token
            }
            
            index -= 1
        }
        
        throw ParsingError.noCorrespondingJumpAddress(OperationType.jumpIfNotZero.rawValue, from)
    }
}
