//
//  AdventSeven.swift
//  AdventOfCode2021
//
//  Created by Ben Stone on 12/7/21.
//

import Foundation

extension AdventSolver {
    struct Seven: AdventNumber {
        func partOne(rawInput: String) -> Int {
            return totalFuelCost(positionsStr: rawInput, fuelCostGenerator: partOneFuelExpenditure)
        }
        func partTwo(rawInput: String) -> Int {
            return totalFuelCost(positionsStr: rawInput, fuelCostGenerator: partTwoFuelExpenditure)
        }
        private func totalFuelCost(positionsStr rawInput: String, fuelCostGenerator: (Int, Int) -> Int) -> Int {
            let positions = Utilities.getIntArray(fromCommaSeparatedString: rawInput)
            guard let maxPosition = positions.max() else { fatalError("Expected at least one crab") }
            var fuelPerPosition = [Int: Int]()
            for possibleEndPosition in 0...maxPosition {
                let totalFuel = positions.map { fuelCostGenerator($0, possibleEndPosition) }.reduce(0, +)
                fuelPerPosition[possibleEndPosition] = totalFuel
            }
            return fuelPerPosition.min { $0.value < $1.value }!.value
        }
        private func partOneFuelExpenditure(from x: Int, to y: Int) -> Int {
            return abs(x - y)
        }
        private func partTwoFuelExpenditure(from x: Int, to y: Int) -> Int {
            let distance = abs(x - y)
            return distance * (distance + 1) / 2
        }
    }
}
