//
//  MeView.swift
//  Recipeat
//
//  Created by Frank Bara on 3/2/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import SwiftUI

struct MeView: View {
    var body: some View {
        ZStack {
          Text("This is me")
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
