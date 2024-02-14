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
    @Option var runInParsingPerfMeasureModeWithCount: Int? = nil
    @Flag var outputMemory = false
    @Flag var outputIntermediateRepresentation = false
    
    func run() throws {
        let url = try validateInputReturnPath()
        let data = try extractProgramCode(url)
        
        if let count = runInParsingPerfMeasureModeWithCount {
            try runInParsingPerformanceMeasureMode(input: data, count: count)
        } else {
            try runInDefaulMode(input: data)
        }
    }
    
    func runInParsingPerformanceMeasureMode(input: Data, count: Int) throws {
        let start = Date()
        for _ in 0..<count {
            let _ = try Parser.parseIntermediateRepresentation(from: input)
        }
        let resultTime = Date().timeIntervalSince(start)
        print("Took:", resultTime, "seconds", separator: " ")
        print("Average", resultTime / Double(count), "seconds", separator: " ")
    }
    
    func runInDefaulMode(input: Data) throws {
        let representation = try Parser.parseIntermediateRepresentation(from: input)
        
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
    
    func extractProgramCode(_ url: URL) throws -> Data {
        try Data(contentsOf: url)
    }
}
