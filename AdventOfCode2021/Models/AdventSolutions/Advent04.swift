//
//  AdventFour.swift
//  AdventOfCode2021
//
//  Created by Ben Stone on 12/4/21.
//

import Foundation

extension AdventSolver {
    struct Four: AdventNumber {
        struct BingoBoard {
            var board: [[Int]]
            mutating func mark(_ target: Int) {
                for i in 0..<board.count {
                    for j in 0..<board[i].count {
                        let num = board[i][j]
                        if num == target {
                            board[i][j] = num == 0 ? Int.min : -num
                        }
                    }
                }
            }
            var isWinner: Bool {
                return isHorizontalWinner || isVerticalWinner
            }
            private var isHorizontalWinner: Bool {
                for row in board {
                    if row.allSatisfy({ $0 < 0 }) { return true }
                }
                return false
            }
            
            private var isVerticalWinner: Bool {
                for column in 0..<board[0].count {
                    var vals = [Int]()
                    for row in 0..<board.count {
                        vals.append(board[row][column])
                    }
                    if vals.allSatisfy({ $0 < 0 }) { return true }
                }
                return false
            }
            var unmarkedSum: Int {
                var sum = 0
                for row in board {
                    for val in row {
                        if val > 0 {
                            sum += val
                        }
                    }
                }
                return sum
            }
        }
        func partOne(rawInput: String) -> Int {
            let numbers = getNumbers(from: rawInput)
            var boards = getBoards(from: rawInput)
            for number in numbers {
                for i in 0..<boards.count {
                    boards[i].mark(number)
                    if boards[i].isWinner {
                        return boards[i].unmarkedSum * number
                    }
                }
            }
            fatalError("No winning board")
        }
        private func getNumbers(from rawInput: String) -> [Int] {
            var lines = Utilities.getStrArray(fromNewlineSeparatedString: rawInput)
            return lines.removeFirst().components(separatedBy: ",").compactMap(Int.init)
        }
        private func getBoards(from rawInput: String) -> [BingoBoard] {
            var lines = Utilities.getStrArray(fromNewlineSeparatedString: rawInput)
            _ = lines.removeFirst()
            var boards = [BingoBoard]()
            var currentBoard = [[Int]]()
            for line in lines {
                currentBoard.append(line.components(separatedBy: .whitespaces).compactMap(Int.init))
                if currentBoard.count == 5 {
                    boards.append(BingoBoard(board: currentBoard))
                    currentBoard = [[Int]]()
                }
            }
            return boards
        }
        func partTwo(rawInput: String) -> Int {
            let numbers = getNumbers(from: rawInput)
            var boards = getBoards(from: rawInput)
            var orderedWinningBoardIndicesAndWinningNumber = [(Int, Int)]()
            var winningBoardIndices = Set<Int>()
            mainloop: for number in numbers {
                for i in 0..<boards.count where !winningBoardIndices.contains(i) {
                    boards[i].mark(number)
                    if boards[i].isWinner {
                        orderedWinningBoardIndicesAndWinningNumber.append((i, number))
                        winningBoardIndices.insert(i)
                        if orderedWinningBoardIndicesAndWinningNumber.count == boards.count {
                            break mainloop
                        }
                    }
                }
            }
            let (lastBoardIndex, winningNumber) = orderedWinningBoardIndicesAndWinningNumber.last!
            return boards[lastBoardIndex].unmarkedSum * winningNumber
        }
    }
}
