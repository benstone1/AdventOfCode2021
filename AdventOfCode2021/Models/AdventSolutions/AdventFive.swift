//
//  AdventFive.swift
//  AdventOfCode2021
//
//  Created by Ben Stone on 12/5/21.
//

import Foundation

extension AdventSolver {
    struct Five: AdventNumber {
        struct Line {
            let startPoint: Point
            let endPoint: Point
        }
        struct Point {
            let x: Int
            let y: Int
        }
        struct OceanFloor {
            var grid = [[Int]](repeating: [Int](repeating: 0, count: 1_000), count: 1_000)
            mutating func drawLine(_ line: Line, ignoreDiagonals: Bool) {
                if line.startPoint.x == line.endPoint.x {
                    for y in line.startPoint.y...line.endPoint.y {
                        grid[y][line.startPoint.x] += 1
                    }
                } else if line.startPoint.y == line.endPoint.y {
                    for x in line.startPoint.x...line.endPoint.x {
                        grid[line.startPoint.y][x] += 1
                    }
                } else {
                    guard !ignoreDiagonals else { return }
                    if line.startPoint.x <= line.endPoint.x && line.startPoint.y <= line.endPoint.y {
                        let difference = line.endPoint.x - line.startPoint.x
                        for increment in 0...difference {
                            grid[line.startPoint.y + increment][line.startPoint.x + increment] += 1
                        }
                    } else {
                        let difference = abs(line.endPoint.x - line.startPoint.x)
                        for increment in 0...difference {
                            if line.startPoint.y < line.endPoint.y {
                                grid[line.startPoint.y + increment][line.startPoint.x - increment] += 1
                            } else {
                                grid[line.startPoint.y - increment][line.startPoint.x + increment] += 1
                            }
                        }
                    }
                }
            }
            var overlapCount: Int {
                var count = 0
                for row in grid {
                    for ventCount in row {
                        if ventCount >= 2 {
                            count += 1
                        }
                    }
                }
                return count
            }
        }
        private func getLines(from strArr: [String]) -> [Line] {
            // 0,9 -> 5,9
            var lines = [Line]()
            for str in strArr {
                let pointStrs = str.components(separatedBy: "->").map { $0.trimmingCharacters(in: .whitespaces) }
                var points = [Point]()
                for pointStr in pointStrs {
                    let xAndY = pointStr.components(separatedBy: ",").map { Int($0)! }
                    let point = Point(x: xAndY[0], y: xAndY[1])
                    points.append(point)
                }
                if points[0].x <= points[1].x && points[0].y <= points[1].y {
                    lines.append(Line(startPoint: points[0], endPoint: points[1]))
                } else {
                    lines.append(Line(startPoint: points[1], endPoint: points[0]))
                }
            }
            return lines
        }
        func partOne(rawInput: String) -> Int {
            let lines = getLines(from: Utilities.getStrArray(fromNewlineSeparatedString: rawInput))
            var floor = OceanFloor()
            for line in lines {
                floor.drawLine(line, ignoreDiagonals: true)
            }
            return floor.overlapCount
        }
        func partTwo(rawInput: String) -> Int {
            let lines = getLines(from: Utilities.getStrArray(fromNewlineSeparatedString: rawInput))
            var floor = OceanFloor()
            for line in lines {
                floor.drawLine(line, ignoreDiagonals: false)
            }
            return floor.overlapCount
        }
    }
}
