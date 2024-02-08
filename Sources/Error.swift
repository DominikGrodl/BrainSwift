import Foundation

enum ValidationError: Error {
    case noProgramProvided
    case noInputPathProvided
    case unsuportedFileType(String)
}

enum InterpretationError: Error {
    case memoryUnderflow
}

enum RuntimeError: Error {
    case invalidInput
}
