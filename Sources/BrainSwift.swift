import Foundation

@main
struct BrainSwift {
    static func main() throws {
        let url = try validateInputReturnPath()
        let data = try extractProgramCode(url)
        let representation = Parser.parseIntermediateRepresentation(from: data)
        Output.outputIntermediateRepresentation(representation)
        try Interpreter.interpret(representation)
    }
    
    static func validateInputReturnPath() throws -> URL {
        let arguments = CommandLine.arguments
        
        guard arguments.count > 1 else {
            throw ValidationError.noProgramProvided
        }
        
        guard let url = URL(string: "file://\(arguments[1])") else {
            throw ValidationError.noInputPathProvided
        }
        
        guard SupportedFileType.allCases.map(\.pathExtension).contains(url.pathExtension) else {
            throw ValidationError.unsuportedFileType(url.pathExtension)
        }
        
        return url
    }
    
    static func extractProgramCode(_ url: URL) throws -> String {
        try String(contentsOf: url)
    }
}
