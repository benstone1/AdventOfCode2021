//
//  Utilities.swift
//  AdventOfCode2021
//
//  Created by Ben Stone on 12/1/21.
//

import Foundation

struct Utilities {
    static func getText(fromFilename name: String) -> String {
        guard let path = Bundle.main.path(forResource: name, ofType: "txt") else {
            fatalError("\(name).txt file not found")
        }
        let internalURL = URL(fileURLWithPath: path)
        let data = try! Data(contentsOf: internalURL)
        return String(data: data, encoding: .utf8)!
    }
    static func getStrArray(fromNewlineSeparatedString rawInput: String) -> [String] {
        return rawInput
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }            
    }
    static func getIntArray(fromNewlineSeparatedString rawInput: String) -> [Int] {
        return rawInput
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map { Int($0)! }
    }
    static func getIntArray(fromCommaSeparatedString rawInput: String) -> [Int] {
        return rawInput
            .components(separatedBy: ",")
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .map { Int($0)! }
    }
}
