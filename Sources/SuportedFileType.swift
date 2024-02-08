//
//  SuportedFileType.swift
//
//
//  Created by Dominik Grodl on 08.02.2024.
//

enum SupportedFileType: CaseIterable {
    case brainfuck
    
    var pathExtension: String {
        switch self {
        case .brainfuck:
            return "bf"
        }
    }
}
