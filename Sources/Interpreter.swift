//
//  Interpreter.swift
//
//
//  Created by Dominik Grodl on 08.02.2024.
//

import Foundation

struct Interpreter {
    static func interpret(_ operations: [Operation], outputMemory: Bool) throws {
        var memory: [UInt8] = [0] //memory of the program simulating simple stack.
        var memoryPointer = memory.startIndex
        var operationsPointer = operations.startIndex //pointer to the currentle executing operation
        
        while operationsPointer < operations.endIndex {
            let op = operations[operationsPointer]
            switch op.type {
                //increment memory slot, wrapping around in case the new value does not fit
            case .increment:
                memory[memoryPointer] = getIncrement(current: memory[memoryPointer])
                operationsPointer += 1
                
                //decrement memory slot, wrapping around in case the new value does not fit
            case .decrement:
                memory[memoryPointer] = getDecrement(current: memory[memoryPointer])
                operationsPointer += 1
                
                //move to next slot, creating new memory slots if needed
            case .right:
                memoryPointer += 1
                operationsPointer += 1
                
                while memoryPointer >= memory.count {
                    memory.append(0)
                }
                
                //move to previous slot, creating new memory slots if needed
            case .left:
                memoryPointer -= 1
                operationsPointer += 1
                
                //get input from CLI
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
                
                //output out current memory value
            case .output:
                Output.codeOutput(value: memory[memoryPointer])
                operationsPointer += 1
                
                //conditionally jump forward to corresponding address if current value in memmory is 0
            case .jumpIfZero:
                if memory[memoryPointer] == 0 {
                    operationsPointer = op.jumpAddress
                } else {
                    operationsPointer += 1
                }
                
                //conditionally jump backwards to corresponding address if current value in memmory is not 0
            case .jumpIfNotZero:
                if memory[memoryPointer] != 0 {
                    operationsPointer = op.jumpAddress
                } else {
                    operationsPointer += 1
                }
            }
        }
        
        if outputMemory {
            Output.outputMemory(memory)
        }
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
