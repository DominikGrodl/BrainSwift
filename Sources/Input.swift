struct Input {
    static func get(_ prompt: String = "Input") -> String? {
        print(prompt, terminator: ": ")
        return readLine()
    }
}
