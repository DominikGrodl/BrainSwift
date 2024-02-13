//
//  Parser.swift
//
//
//  Created by Dominik Grodl on 08.02.2024.
//

struct Parser {
    static func parseIntermediateRepresentation(from code: String) -> [Operation] {
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
                        jumpAddress: findCorrespondingJumpAddressForward(
                            in: operationTypes,
                            from: index
                        )
                    )
                )
            case .jumpIfNotZero:
                operations.append(
                    Operation(
                        type: operationType,
                        jumpAddress: findCorrespondingJumpAddressBackward(
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
    ) -> [OperationType].Index {
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
                return index + 1
            }
        }
        
        fatalError("Unable to find corresponding jump address for [ token at address \(from)")
    }
    
    private static func findCorrespondingJumpAddressBackward(
        in operations: [OperationType],
        from: [OperationType].Index
    ) -> [OperationType].Index {
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
                return index + 1
            }
            
            index -= 1
        }
        
        fatalError("Unable to find corresponding jump address for ] token at address \(from)")
    }
}
