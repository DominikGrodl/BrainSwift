struct Output {
    static func outputIntermediateRepresentation(_ operations: [Operation]) {
        let mapped = operations
            .map(\.debugDescription)
            .enumerated()
            .map {
                "\($0.offset): \($0.element)"
            }
            .joined(separator: "\n")
        
        print(
            "----------",
            "Representation:",
            mapped,
            "End of representation",
            "----------",
            separator: "\n\n"
        )
    }
    
    static func codeOutput(value: UInt8) {
        print(
            Character(UnicodeScalar(value)),
            terminator: ""
        )
    }
    
    static func outputMemory(_ memory: [UInt8]) {
        print(
            "----------",
            "Memory:",
            memory,
            separator: "\n"
        )
    }
}
