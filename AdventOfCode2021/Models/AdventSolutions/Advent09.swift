//
//  AdventNine.swift
//  AdventOfCode2021
//
//  Created by Ben Stone on 12/9/21.
//

import Foundation

extension AdventSolver {
    struct Nine: AdventNumber {
        struct Point: Hashable {
            let x: Int
            let y: Int
            
            func basinSize(in grid: [[Int]]) -> Int {
                var visited = Set<Point>()
                var queue = [self]
                while !queue.isEmpty {
                    let currentPoint = queue.removeFirst()
                    visited.insert(currentPoint)
                    let neighbors = currentPoint
                        .adjacentPoints(in: grid)
                        .filter { $0.value(in: grid) != 9 }
                        .filter { !visited.contains($0) }
                    queue += neighbors
                }
                return visited.count
            }
            
            func isMinimum(in grid: [[Int]]) -> Bool {
                return value(in: grid) < adjacentPointValues(in: grid).min()!
            }
            
            
            private func adjacentPoints(in grid: [[Int]]) -> [Point] {
                return [
                    Point(x: x - 1, y: y),
                    Point(x: x + 1, y: y),
                    Point(x: x, y: y - 1),
                    Point(x: x, y: y + 1)
                ].filter { $0.isValid(in: grid) }
            }
            
            private func adjacentPointValues(in grid: [[Int]]) -> [Int] {
                adjacentPoints(in: grid).map { $0.value(in: grid) }
            }
            
            func value(in grid: [[Int]]) -> Int {
                return grid[y][x]
            }
            
            private func isValid(in grid: [[Int]]) -> Bool {
                return x >= 0 && y >= 0 && x < grid[0].endIndex && y < grid.endIndex
            }
        }
        func partOne(rawInput: String) -> Int {
            let grid = getGrid(from: rawInput)
            var lowPointValues = [Int]()
            for y in 0..<grid.count {
                for x in 0..<grid[0].count {
                    let point = Point(x: x, y: y)
                    if point.isMinimum(in: grid) {
                        lowPointValues.append(point.value(in: grid))
                    }
                }
            }
            return lowPointValues.map { $0 + 1 }.reduce(0, +)
        }
        func partTwo(rawInput: String) -> Int {
            let grid = getGrid(from: rawInput)
            var lowPoints = [Point]()
            for y in 0..<grid.count {
                for x in 0..<grid[0].count {
                    let point = Point(x: x, y: y)
                    if point.isMinimum(in: grid) {
                        lowPoints.append(point)
                    }
                }
            }
            let basinSizes = lowPoints.map { $0.basinSize(in: grid) }
            return basinSizes.sorted(by: >)[0..<3].reduce(1, *)
        }
        private func getGrid(from rawInput: String) -> [[Int]] {
            let lines = Utilities.getStrArray(fromNewlineSeparatedString: rawInput)
            let grid = lines.map { Array($0).map { Int("\($0)")! } }
            return grid
        }
    }
}
