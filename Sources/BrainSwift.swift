//
//  BrainSwift.swift
//  
//
//  Created by Dominik Grodl on 08.02.2024.
//

import Foundation
import ArgumentParser

@main
struct BrainSwift: ParsableCommand {
    @Argument var inputFile: String
    @Flag var outputMemory = false
    @Flag var outputIntermediateRepresentation = false
    
    func run() throws {
        let url = try validateInputReturnPath()
        let data = try extractProgramCode(url)
        let representation = try Parser.parseIntermediateRepresentation(from: data)
        
        if outputIntermediateRepresentation {
            Output.outputIntermediateRepresentation(representation)
        }
        
        try Interpreter.interpret(representation, outputMemory: outputMemory)
    }
    
    func validateInputReturnPath() throws -> URL {
        guard let url = URL(string: "file://\(inputFile)") else {
            throw ValidationError.noInputPathProvided
        }
        
        guard SupportedFileType.allCases.map(\.pathExtension).contains(url.pathExtension) else {
            throw ValidationError.unsuportedFileType(url.pathExtension)
        }
        
        return url
    }
    
    func extractProgramCode(_ url: URL) throws -> String {
        try String(contentsOf: url)
    }
}
