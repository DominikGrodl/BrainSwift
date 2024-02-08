enum SupportedFileType: CaseIterable {
    case brainfuck
    
    var pathExtension: String {
        switch self {
        case .brainfuck:
            return "bf"
        }
    }
}
