# BrainSwift
BrainSwift is a simple, arguably very ineffective [BrainFuck](https://en.wikipedia.org/wiki/Brainfuck) interpreter written in the [Swift programming language](https://www.swift.org).

## How to use
1. clone this repo to you machine `git clone https://github.com/DominikGrodl/BrainSwift.git` or `git clone git@github.com:DominikGrodl/BrainSwift.git` if using ssh
2. in Terminal, run `swift run BrainSwift {path-to-brainfuck-file}`. You can use the helloworld.bf example file included in this repo.
3. Additionally, you can pass in flags to get some additional program information when executing. You can use the `--output-intermediate-representation` flag to see the intermediate representation the program is parsed to, and `--output-memory` to output the state of the program memory when it finishes execution.

### Please let me know if you find any issues, or anything you would have done differently. This is the first pass-through for this project, so there are I suppose many edge cases which are not correctly handled.


