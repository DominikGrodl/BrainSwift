//
//  ValidationError.swift
//
//
//  Created by Dominik Grodl on 13.02.2024.
//

enum ValidationError: Error {
    case noProgramProvided
    case noInputPathProvided
    case unsuportedFileType(String)
}
