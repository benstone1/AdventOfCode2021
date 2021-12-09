//
//  Advent.swift
//  AdventOfCode2021
//
//  Created by Ben Stone on 12/1/21.
//

import Foundation

struct Advent: Identifiable {
    let id: Int
    let title: String
    var solutionOne: Int
    var solutionTwo: Int
    var promptOne: String
    var promptTwo: String
}

extension Advent {
    static var solvedAdvents: [Advent] {
        var validAdvents = [Advent]()
        for i in 1...25 {
            if let advent = AdventGenerator.makeAdvent(id: i) {
                validAdvents.append(advent)
            }
        }
        return validAdvents
    }
    static let testAdvent = Advent(id: 1,
                                   title: "test",
                                   solutionOne: 0,
                                   solutionTwo: 0,
                                   promptOne: "First prompt",
                                   promptTwo: "Second Prompt")
}
