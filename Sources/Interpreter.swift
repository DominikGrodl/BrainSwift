import Foundation

struct Interpreter {
    static func interpret(_ operations: [Operation]) throws {
        var memory: [UInt8] = [0]
        var memoryPointer = memory.startIndex
        var operationsPointer = operations.startIndex
        
        while operationsPointer < operations.endIndex {
            let op = operations[operationsPointer]
            switch op.type {
            case .increment:
                memory[memoryPointer] = getIncrement(current: memory[memoryPointer])
                operationsPointer += 1
            case .decrement:
                memory[memoryPointer] = getDecrement(current: memory[memoryPointer])
                operationsPointer += 1
            case .right:
                memoryPointer += 1
                operationsPointer += 1
                
                while memoryPointer >= memory.count {
                    memory.append(0)
                }
            case .left:
                memoryPointer -= 1
                operationsPointer += 1
            case .input:
                if 
                    let input = Input.get(),
                    let value = UInt8(input)
                {
                    memory[memoryPointer] = value
                } else {
                    throw RuntimeError.invalidInput
                }
                operationsPointer += 1
            case .output:
                Output.codeOutput(value: memory[memoryPointer])
                operationsPointer += 1
            case .jumpIfZero:
                if memory[memoryPointer] == 0 {
                    operationsPointer = op.jumpAddress
                } else {
                    operationsPointer += 1
                }
            case .jumpIfNotZero:
                if memory[memoryPointer] != 0 {
                    operationsPointer = op.jumpAddress
                } else {
                    operationsPointer += 1
                }
            }
        }
        
        Output.outputMemory(memory)
    }
    
    private static func getIncrement(current: UInt8) -> UInt8 {
        if current == 255 {
            return 0
        }
        
        return current + 1
    }
    
    private static func getDecrement(current: UInt8) -> UInt8 {
        if current == 0 {
            return 255
        }
        
        return current - 1
    }
}
