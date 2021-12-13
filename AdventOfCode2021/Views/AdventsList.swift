//
//  ContentView.swift
//  AdventOfCode2021
//
//  Created by Ben Stone on 12/1/21.
//

import SwiftUI

struct AdventsList: View {
    var body: some View {
        NavigationView {
            List(Advent.solvedAdvents) { advent in
                VStack {
                    Text(advent.title)
                    Text("Solution One: \(advent.solutionOne)")
                    Text("Solution Two: \(advent.solutionTwo)")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AdventsList()
    }
}
