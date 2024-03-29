//
//  ParsingError.swift
//
//
//  Created by Dominik Grodl on 08.02.2024.
//

import Foundation

enum ParsingError: Error {
    case noCorrespondingJumpAddress(_ token: UInt8, _ index: Int)
}

extension ParsingError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .noCorrespondingJumpAddress(token, index):
            return """
                    Unable to find corresponding jump address for token \(token).
                    | Originating address: \(index)
                    """
        }
    }
}




