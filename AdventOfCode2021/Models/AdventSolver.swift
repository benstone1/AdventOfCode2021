//
//  AdventInputs.swift
//  AdventOfCode2021
//
//  Created by Ben Stone on 12/1/21.
//

import Foundation

//protocol Solution {
//    static func partOne(rawInput: String) -> Int
//    static func partTwo(rawInput: String) -> Int
//}
//
//extension Solution {
//    static func partOne(rawInput: String) -> Int {
//        return -1
//    }
//    static func partTwo(rawInput: String) -> Int {
//        return -1
//    }
//}

struct AdventSolver {
    typealias Solver = (String) -> Int
    
    let partOne: Solver
    let partTwo: Solver

    init(number: AdventNumber) {
        self.partOne = number.partOne
        self.partTwo = number.partTwo
    }
    
    static func getSolver(forID id: Int) -> AdventSolver? {
        return solvers[id]
    }
    
    static private var solvers: [Int: AdventSolver] = [
        1: AdventSolver(number: One()),
        2: AdventSolver(number: Two()),
        3: AdventSolver(number: Three()),
        4: AdventSolver(number: Four()),
        5: AdventSolver(number: Five()),
        6: AdventSolver(number: Six()),
        7: AdventSolver(number: Seven()),
        8: AdventSolver(number: Eight()),
        9: AdventSolver(number: Nine()),
    ]
}

protocol AdventNumber {
    func partOne(rawInput: String) -> Int
    func partTwo(rawInput: String) -> Int
}

extension AdventNumber {
    func partOne(rawInput: String) -> Int {
        return -1
    }
    func partTwo(rawInput: String) -> Int {
        return -1
    }
}
