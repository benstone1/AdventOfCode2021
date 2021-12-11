//
//  Advent11.swift
//  AdventOfCode2021
//
//  Created by Ben Stone on 12/11/21.
//

import Foundation

extension AdventSolver {
    struct Eleven: AdventNumber {
        struct OctopusBoard {
            struct Point: Hashable {
                let x: Int
                let y: Int
            }
            
            var grid: [[Int]]
            
            mutating func firstSimultaneousFlash() -> Int {
                var step = 0
                while true {
                    if grid.joined().reduce(0, +) == 0 {
                        return step
                    }
                    for y in 0..<grid.count {
                        for x in 0..<grid[0].count {
                            let p = Point(x: x, y: y)
                            increaseEnergyLevel(of: p)
                        }
                    }
                    var flashedPoints = Set<Point>()
                    for y in 0..<grid.count {
                        for x in 0..<grid[0].count {
                            let p = Point(x: x, y: y)
                            if energyLevel(of: p) >= 10 && !flashedPoints.contains(p) {
                                flash(startingAt: p, flashedPoints: &flashedPoints)
                            }
                        }
                    }
                    step += 1
                }
            }
            
            mutating func flashCount(after n: Int) -> Int {
                var flashCount = 0
                for _ in 0..<n {
                    for y in 0..<grid.count {
                        for x in 0..<grid[0].count {
                            let p = Point(x: x, y: y)
                            increaseEnergyLevel(of: p)
                        }
                    }
                    var flashedPoints = Set<Point>()
                    for y in 0..<grid.count {
                        for x in 0..<grid[0].count {
                            let p = Point(x: x, y: y)
                            if energyLevel(of: p) >= 10 && !flashedPoints.contains(p) {
                                flash(startingAt: p, flashedPoints: &flashedPoints)
                            }
                        }
                    }
                    flashCount += flashedPoints.count
                }
                return flashCount
            }
            
            private mutating func flash(startingAt startPoint: Point, flashedPoints: inout Set<Point>) { flashedPoints.insert(startPoint)
                resetEnergyLevel(of: startPoint)
                for point in adjacentPoints(to: startPoint) where !flashedPoints.contains(point) {
                    increaseEnergyLevel(of: point)
                    if energyLevel(of: point) >= 10 {
                        flash(startingAt: point, flashedPoints: &flashedPoints)
                    }
                }
            }
            
            mutating private func resetEnergyLevel(of p: Point) {
                grid[p.y][p.x] = 0
            }
            
            mutating private func increaseEnergyLevel(of p: Point) {
                grid[p.y][p.x] = energyLevel(of: p) + 1
            }
            
            private func adjacentPoints(to point: Point) -> [Point] {
                let (x, y) = (point.x, point.y)
                return [
                    Point(x: x - 1, y: y),
                    Point(x: x - 1, y: y - 1),
                    Point(x: x - 1, y: y + 1),
                    Point(x: x, y: y - 1),
                    Point(x: x, y: y + 1),
                    Point(x: x + 1, y: y - 1),
                    Point(x: x + 1, y: y),
                    Point(x: x + 1, y: y + 1),
                ].filter { isValid($0) }
            }
            private func energyLevel(of point: Point) -> Int {
                return grid[point.y][point.x]
            }
            
            private func isValid(_ point: Point) -> Bool {
                let (x, y) = (point.x, point.y)
                return x >= 0 && y >= 0 && x < grid[0].endIndex && y < grid.endIndex
            }
        }
        
        func partOne(rawInput: String) -> Int {
            var board = OctopusBoard(grid: Utilities.getGrid(from: rawInput))
            return board.flashCount(after: 100)
        }
        func partTwo(rawInput: String) -> Int {
            var board = OctopusBoard(grid: Utilities.getGrid(from: rawInput))
            return board.firstSimultaneousFlash()
        }
    }
}
