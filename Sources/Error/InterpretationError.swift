//
//  InterpretationError.swift
//  
//
//  Created by Dominik Grodl on 13.02.2024.
//

import Foundation

enum InterpretationError: Error {
    case memoryUnderflow
}

extension InterpretationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .memoryUnderflow:
            return "Memory underflow. This means the memory pointer was pointing to the beginning of the memory, but current operation tried to move it to the left."
        }
    }
}
