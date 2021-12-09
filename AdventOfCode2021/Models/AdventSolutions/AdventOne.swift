//
//  AdventOne.swift
//  AdventOfCode2021
//
//  Created by Ben Stone on 12/1/21.
//

import Foundation

extension AdventSolver {
    struct One: AdventNumber {
        func partOne(rawInput: String) -> Int {
            let input = Utilities.getIntArray(fromNewlineSeparatedString: rawInput)
            var count = 0
            var lastReading: Int?
            for reading in input {
                if let lastReading = lastReading, reading > lastReading {
                    count += 1
                }
                lastReading = reading
            }
            return count
        }
        func partTwo(rawInput: String) -> Int {
            let input = Utilities.getIntArray(fromNewlineSeparatedString: rawInput)
            guard input.count >= 2 else { return 0 }
            var count = 0
            var lastReadingSum: Int = input[0] + input[1] + input[2]
            for i in 1..<(input.count - 2) {
                let newSum = input[i] + input[i+1] + input[i+2]
                if newSum > lastReadingSum {
                    count += 1
                }
                lastReadingSum = newSum
            }
            return count
        }
    }
}
