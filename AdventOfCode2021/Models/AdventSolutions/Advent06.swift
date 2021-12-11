//
//  AdventSix.swift
//  AdventOfCode2021666-
//
//  Created by Ben Stone on 12/6/21.
//

import Foundation

extension AdventSolver {
    struct Six: AdventNumber {
        func partOne(rawInput: String) -> Int {
            return lanternfishCount(rawInput: rawInput, days: 80)
        }
        
        func partTwo(rawInput: String) -> Int {
            return lanternfishCount(rawInput: rawInput, days: 256)
        }
        
        private func lanternfishCount(rawInput str: String, days: Int) -> Int {
            let intArr = Utilities.getIntArray(fromCommaSeparatedString: str)
            var fishCounts = [Int: Int]()
            for val in intArr {
                fishCounts[val] = fishCounts[val, default: 0] + 1
            }
            for _ in 0..<days {
                let spawningFishCount = fishCounts[0, default: 0]
                for val in 1...8 {
                    fishCounts[val - 1] = fishCounts[val]
                }
                fishCounts[8] = spawningFishCount
                fishCounts[6] = fishCounts[6, default: 0] + spawningFishCount
            }
            return fishCounts.values.reduce(0, +)
        }
    }
}
