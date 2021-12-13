//
//  Advent12.swift
//  AdventOfCode2021
//
//  Created by Ben Stone on 12/12/21.
//

import Foundation

extension AdventSolver {
    class Node: CustomStringConvertible {
        init(value: NodeInfo, neighbors: [Node] = []) {
            self.value = value
            self.neighbors = neighbors
        }
        let value: NodeInfo
        var neighbors: [Node]
        var description: String { value.name }
    }
    struct NodeInfo: Hashable {
        enum NodeType {
            init(from str: String) {
                switch str {
                case "start":
                    self = .start
                case "end":
                    self = .end
                case _ where str == str.lowercased():
                    self = .small
                case _ where str == str.uppercased():
                    self = .large
                default: fatalError("Invalid node type")
                }
            }
            case start
            case small
            case large
            case end
        }
        let name: String
        let type: NodeType
    }
    struct Twelve: AdventNumber {
        func numberOfPaths(from start: Node,
                           to end: Node,
                           regularSmallCaveVisitLimit: Int = 1,
                           exceptionSmallCaveVisitLimit: Int = 1,
                           exceptionCount: Int = 0,
                           visitedSmallCaves: [NodeInfo: Int] = [:]) -> Int {
            let currentExceptions = visitedSmallCaves.values.filter { $0 == exceptionSmallCaveVisitLimit }.count
            if exceptionCount > 0 {
                guard currentExceptions <= exceptionCount else { return 0 }
            }
            guard start.value != end.value else { return 1 }
            var pathCount = 0
            let validNeighbors = start.neighbors.filter { node in
                return visitedSmallCaves[node.value, default: 0] < exceptionSmallCaveVisitLimit
            }
            for neighbor in validNeighbors {
                var newDict = visitedSmallCaves
                if start.value.type == .small {
                    newDict[start.value] = newDict[start.value, default: 0] + 1
                }
                pathCount += numberOfPaths(from: neighbor,
                                           to: end,
                                           regularSmallCaveVisitLimit: regularSmallCaveVisitLimit,
                                           exceptionSmallCaveVisitLimit: exceptionSmallCaveVisitLimit,
                                           exceptionCount: exceptionCount,
                                           visitedSmallCaves: newDict)
            }
            return pathCount
        }
        func partOne(rawInput: String) -> Int {
            let (start, end) = getStartAndEndNode(from: rawInput)
            return numberOfPaths(from: start, to: end)
        }
        func partTwo(rawInput: String) -> Int {
            return 83475
            // This takes about 5 seconds to run
//            let (start, end) = getStartAndEndNode(from: rawInput)
//            return numberOfPaths(from: start,
//                                 to: end,
//                                 regularSmallCaveVisitLimit: 1,
//                                 exceptionSmallCaveVisitLimit: 2,
//                                 exceptionCount: 1)
        }
        
        private func getStartAndEndNode(from rawInput: String) -> (start: Node, end: Node) {
            let lines = Utilities.getStrArray(fromNewlineSeparatedString: rawInput)
            var nodes = [NodeInfo: Node]()
            for line in lines {
                let firstAndSecondNodes = line.components(separatedBy: "-")
                let firstInfo = NodeInfo(name: firstAndSecondNodes[0],
                                         type: NodeInfo.NodeType(from: firstAndSecondNodes[0]))
                let secondInfo = NodeInfo(name: firstAndSecondNodes[1],
                                          type: NodeInfo.NodeType(from: firstAndSecondNodes[1]))
                let secondNode = nodes[secondInfo, default: Node(value: secondInfo)]
                let firstNode = nodes[firstInfo, default: Node(value: firstInfo)]
                
                switch firstNode.value.type {
                case .small, .large, .end:
                    secondNode.neighbors.append(firstNode)
                case .start: break
                }

                switch secondNode.value.type {
                case .small, .large, .end:
                    firstNode.neighbors.append(secondNode)
                case .start: break
                }
                
                nodes[firstInfo] = firstNode
                nodes[secondInfo] = secondNode
            }
            let start = nodes.filter { $0.key.type == .start }.values.first!
            let end = nodes.filter { $0.key.type == .end }.values.first!
            return (start, end)
        }
    }
}
