//
//  Advent10.swift
//  AdventOfCode2021
//
//  Created by Ben Stone on 12/10/21.
//

import Foundation

extension AdventSolver {
    struct Ten: AdventNumber {
        func partOne(rawInput: String) -> Int {
            let lines = Utilities.getStrArray(fromNewlineSeparatedString: rawInput)
            return lines.map { pointValue(of: $0) }.reduce(0, +)
        }
        func partTwo(rawInput: String) -> Int {
            let lines = Utilities.getStrArray(fromNewlineSeparatedString: rawInput)
            let uncorruptedLines = lines.filter { pointValue(of: $0) == 0 }
            return uncorruptedLines
                .map { autocompleteScore(of: $0) }
                .sorted(by: <)[uncorruptedLines.count / 2]
        }
        
        private func pointValue(of line: String) -> Int {
            var stack = [Character]()
            for c in line {
                if String.openers.contains(c) {
                    stack.append(c)
                } else {
                    guard let last = stack.popLast(), last.isClosed(by: c) else {
                        return c.pointValue
                    }
                }
            }
            return 0
        }
        
        private func autocompleteScore(of line: String) -> Int {
            var stack = [Character]()
            for c in line {
                if String.openers.contains(c) {
                    stack.append(c)
                } else {
                    _ = stack.popLast()
                }
            }
            var score = 0
            let missingOrderedClosers = stack.reversed().map { $0.closer }
            for closer in missingOrderedClosers {
                score *= 5
                score += closer.autocompletePointValue
            }
            return score
        }
    }
}

extension String {
    static let openers: Set<Character> = ["(", "[", "{", "<"]
    static let closers: Set<Character> = [")", "]", "}", ">"]
}

extension Character {
    func isClosed(by char: Character) -> Bool {
        switch self {
        case "(": return char == ")"
        case "[": return char == "]"
        case "{": return char == "}"
        case "<": return char == ">"
        default: return false
        }
    }
    var closer: Character {
        switch self {
        case "(": return ")"
        case "[": return "]"
        case "{": return "}"
        case "<": return ">"
        default: fatalError("No valid opener for \(self)")
        }
    }
    
    var pointValue: Int {
        switch self {
        case ")": return 3
        case "]": return 57
        case "}": return 1197
        case ">": return 25137
        default: fatalError("No point value")
        }
    }
    var autocompletePointValue: Int {
        switch self {
        case ")": return 1
        case "]": return 2
        case "}": return 3
        case ">": return 4
        default: fatalError("No point value")
        }
    }
}
