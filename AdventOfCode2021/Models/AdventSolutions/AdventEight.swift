//
//  Eight.swift
//  AdventOfCode2021
//
//  Created by Ben Stone on 12/8/21.
//

import Foundation

extension AdventSolver {
    struct Eight: AdventNumber {
        struct Entry {
            let patterns: [String]
            let output: [String]
        }
        func partOne(rawInput: String) -> Int {
            let entries = getEntries(from: rawInput)
            let uniquePatternLengths = [2,3,4,7]
            var count = 0
            for entry in entries {
                let outputs = entry.output
                for output in outputs {
                    if uniquePatternLengths.contains(output.count) {
                        count += 1
                    }
                }
            }
            return count
        }
        func partTwo(rawInput: String) -> Int {
            let entries = getEntries(from: rawInput)
            var sum = 0
            for entry in entries {
                let decoderDict = decode(entry.patterns)
                var finalStr = ""
                for pattern in entry.output {
                    guard let decodedInt = decoderDict[pattern.sorted()] else {
                        fatalError("Unable to decode \(pattern)")
                    }
                    finalStr += "\(decodedInt)"
                }
                let finalVal = Int(finalStr)!
                sum += finalVal
            }
            return sum
        }
        private func decode(_ patterns: [String]) -> [[Character]: Int] {
            guard patterns.count == 10 else { fatalError("Bad input") }
            var dict = [[Character]: Int]()
            let parsingCountSequence = [2,3,4,7,6,5]
            let sortedPatterns = patterns.sorted {
                parsingCountSequence.firstIndex(of: $0.count)! < parsingCountSequence.firstIndex(of: $1.count)!
            }
            var keyPatternsByCount = [Int: String]()
            for pattern in sortedPatterns {
                switch pattern.count {
                case 2:
                    dict[pattern.sorted()] = 1
                    keyPatternsByCount[2] = pattern
                case 3:
                    dict[pattern.sorted()] = 7
                    keyPatternsByCount[3] = pattern
                case 4:
                    dict[pattern.sorted()] = 4
                    keyPatternsByCount[4] = pattern
                case 7:
                    dict[pattern.sorted()] = 8
                case 6:
                    guard let twoCountPattern = keyPatternsByCount[2] else { fatalError("No 2 count") }
                    guard let fourCountPattern = keyPatternsByCount[4] else { fatalError("No 4 count") }
                    if !Set(pattern).isStrictSuperset(of: Set(twoCountPattern)) {
                        dict[pattern.sorted()] = 6
                    } else if Set(pattern).isStrictSuperset(of: Set(fourCountPattern)) {
                        dict[pattern.sorted()] = 9
                    } else {
                        dict[pattern.sorted()] = 0
                    }
                case 5:
                    guard let twoCountPattern = keyPatternsByCount[2] else { fatalError("No 2 count") }
                    var ninePattern: [Character]?
                    for (key, value) in dict {
                        if value == 9 { ninePattern = key }
                    }
                    guard let unwrappedNinePattern = ninePattern else { fatalError("No 9 pattern") }
                    if Set(pattern).isSuperset(of: Set(twoCountPattern)) {
                        dict[pattern.sorted()] = 3
                    } else if Set(pattern).isSubset(of: Set(unwrappedNinePattern)) {
                        dict[pattern.sorted()] = 5
                    } else {
                        dict[pattern.sorted()] = 2
                    }
                default:
                    fatalError("Unexpected pattern length")
                }
            }
            return dict
        }
        private func getEntries(from rawInput: String) -> [Entry] {
            let strs = Utilities.getStrArray(fromNewlineSeparatedString: rawInput)
            return strs.map { str in
                let components = str.components(separatedBy: "|")
                return Entry(patterns: components[0].components(separatedBy: " ").filter { !$0.isEmpty },
                             output: components[1].components(separatedBy: " ").filter { !$0.isEmpty })
            }
        }
    }
}
