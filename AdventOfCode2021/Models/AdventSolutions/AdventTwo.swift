//
//  AdventTwo.swift
//  AdventOfCode2021
//
//  Created by Ben Stone on 12/2/21.
//

import Foundation

extension AdventSolver {
    struct Two: AdventNumber {
        enum Direction {
            case down(Int)
            case forward(Int)
            case up(Int)
            
            init(orientation: String, magnitude: Int) {
                switch orientation {
                case "down": self = .down(magnitude)
                case "forward": self = .forward(magnitude)
                case "up": self = .up(magnitude)
                default: fatalError("Unexpected orientation: \(orientation)")
                }
            }
            static func directions(from rawInput: String) -> [Direction] {
                let directionsStrs = Utilities.getStrArray(fromNewlineSeparatedString: rawInput)
                let directions: [Direction] = directionsStrs.map { directionStr in
                    let components = directionStr.components(separatedBy: .whitespaces)
                    let orientation = components[0]
                    guard let magnitude = Int(components[1]) else { fatalError("Magnitude \(components[1]) is not an Int") }
                    return Direction(orientation: orientation, magnitude: magnitude)
                }
                return directions
            }
        }
        func partOne(rawInput: String) -> Int {
            let directions = Direction.directions(from: rawInput)
            var horizontalPosition = 0
            var verticalPosition = 0
            for direction in directions {
                switch direction {
                case .down(let magnitude):
                    verticalPosition += magnitude
                case .forward(let magnitude):
                    horizontalPosition += magnitude
                case .up(let magnitude):
                    verticalPosition -= magnitude
                }
            }
            return horizontalPosition * verticalPosition
        }
        func partTwo(rawInput: String) -> Int {
            let directions = Direction.directions(from: rawInput)
            var horizontalPosition = 0
            var verticalPosition = 0
            var aim = 0
            for direction in directions {
                switch direction {
                case .down(let magnitude):
                    aim += magnitude
                case .forward(let magnitude):
                    horizontalPosition += magnitude
                    verticalPosition += aim * magnitude
                case .up(let magnitude):
                    aim -= magnitude
                }
            }
            return horizontalPosition * verticalPosition
        }
    }
}
