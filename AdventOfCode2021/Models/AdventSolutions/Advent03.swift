//
//  AdventThree.swift
//  AdventOfCode2021
//
//  Created by Ben Stone on 12/3/21.
//

import Foundation

extension AdventSolver {
    struct Three: AdventNumber {
        func partOne(rawInput: String) -> Int {
            let strArr = Utilities.getStrArray(fromNewlineSeparatedString: rawInput)
            var counts = [Int](repeating: 0, count: strArr[0].count)
            for binaryStr in strArr {
                for (digitIndex, char) in binaryStr.enumerated() {
                    counts[digitIndex] += (char == "1" ? 1 : 0)
                }
            }
            let gammaRateArr: [Int] = counts.map { count in
                if count > Int(strArr.count / 2) {
                    return 1
                } else {
                    return 0
                }
            }
            let gammaRateStr = gammaRateArr.reduce("") { $0 + "\($1)" }
            let gammaRate = Int(gammaRateStr, radix: 2)!
            let epislonRate = Int(gammaRateArr
                .map { $0 == 1 ? 0 : 1 }
                .reduce("") { $0 + "\($1)" }, radix: 2)!
            return Int(gammaRate * epislonRate)
        }
        
        func partTwo(rawInput: String) -> Int {
            let strArr = Utilities.getStrArray(fromNewlineSeparatedString: rawInput)
            let oxygenGeneratorRating = getRating(from: strArr, type: .oxygen)
            let cO2ScrubberRating = getRating(from: strArr, type: .c02)
            return oxygenGeneratorRating * cO2ScrubberRating
        }
        
        enum RatingType {
            case c02
            case oxygen
        }
        private func getRating(from strArr: [String], type: RatingType) -> Int {
            var strArr = strArr
            var index = 0
            let bitIdentifier: ([String], Int) -> Int
            switch type {
            case .oxygen:
                bitIdentifier = mostCommonBit
            case .c02:
                bitIdentifier = leastCommonBit
            }
            
            while strArr.count > 1 {
                let bit = bitIdentifier(strArr, index)
                strArr = strArr.filter { binaryStr in
                    return String(binaryStr[binaryStr.index(binaryStr.startIndex, offsetBy: index)]) == "\(bit)"
                }
                index += 1
            }
            let oxygenGeneratorRating = Int(strArr[0].reduce("") { $0 + "\($1)" }, radix: 2)!
            return oxygenGeneratorRating
        }
        
        private func mostCommonBit(in strs: [String], forIndex index: Int) -> Int {
            var zeros = 0
            var ones = 0
            for str in strs {
                if str[str.index(str.startIndex, offsetBy: index)] == "1" {
                    ones += 1
                } else {
                    zeros += 1
                }
            }
            return ones >= zeros ? 1 : 0
        }
        private func leastCommonBit(in strs: [String], forIndex index: Int) -> Int {
            return mostCommonBit(in: strs, forIndex: index) == 1 ? 0 : 1
        }
    }
}
