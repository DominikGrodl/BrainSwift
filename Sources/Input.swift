//
//  Input.swift
//
//
//  Created by Dominik Grodl on 08.02.2024.
//

struct Input {
    static func get(_ prompt: String = "Input") -> String? {
        print(prompt, terminator: ": ")
        return readLine()
    }
}
