//
//  StoryCircleView.swift
//  Recipeat
//
//  Created by Frank Bara on 3/6/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import SwiftUI

struct StoryCircleView: View {
    var body: some View {
        Image(systemName: "circle.grid.hex")
            .frame(width: 60, height: 60)
            .background(Color.init(red: 0.95, green: 0.95, blue: 0.95))
            .foregroundColor(Color.black)
        .clipShape(Circle())
            .overlay(Circle().stroke(Color.blue.opacity(0.3), lineWidth: 3))
    }
}

struct StoryCircleView_Previews: PreviewProvider {
    static var previews: some View {
        StoryCircleView()
    }
}
