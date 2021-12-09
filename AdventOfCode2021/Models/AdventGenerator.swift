//
//  AdventGenerator.swift
//  AdventOfCode2021
//
//  Created by Ben Stone on 12/1/21.
//

import Foundation

struct AdventGenerator {
    static func makeAdvent(id: Int) -> Advent? {
        guard let solver = AdventSolver.getSolver(forID: id) else { return nil }
        let inputOne = Utilities.getText(fromFilename: "\(id)-input-1")
        let inputTwo = Utilities.getText(fromFilename: "\(id)-input-2")
        let promptOne = Utilities.getText(fromFilename: "\(id)-prompt-1")
        let promptTwo = Utilities.getText(fromFilename: "\(id)-prompt-2")
        let title = Utilities.getStrArray(fromNewlineSeparatedString: promptOne)[0]
        
        return Advent(id: id,
                      title: title,
                      solutionOne: solver.partOne(inputOne),
                      solutionTwo: solver.partTwo(inputTwo),
                      promptOne: promptOne,
                      promptTwo: promptTwo)
    }
}
