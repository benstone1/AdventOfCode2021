//
//  PromptView.swift
//  AdventOfCode2021
//
//  Created by Ben Stone on 12/2/21.
//

import SwiftUI

struct PromptView: View {
    enum Prompt: String, CaseIterable, Identifiable {
        var id: String { rawValue }
        case one = "One"
        case two = "Two"
    }
    @State var prompt = Prompt.one
    let advent: Advent
    var body: some View {
        VStack {
            Picker("Prompt", selection: $prompt) {
                ForEach(Prompt.allCases) { prompt in
                    Text("Prompt \(prompt.rawValue)").tag(prompt)
                }
            }
        }
    }
}

struct PromptView_Previews: PreviewProvider {
    static var previews: some View {
        PromptView(advent: Advent.testAdvent)
    }
}
