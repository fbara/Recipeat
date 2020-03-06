//
//  PostView.swift
//  Recipeat
//
//  Created by Frank Bara on 3/6/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import SwiftUI

struct PostView: View {
    var body: some View {
        VStack {
            Image(systemName: "heart")
                .frame(height: 300)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.init(red: 0.95, green: 0.95, blue: 0.95))
            VStack {
                HStack {
                    Image(systemName: "heart")
                    Image(systemName: "envelope")
                    Spacer()
                    Image(systemName: "bookmark")
                }
                
                HStack {
                    Text("poster")
                    Spacer()
                }
                .font(.system(size: 14, weight: .bold))
                
                HStack {
                    Text("description")
                    Spacer()
                }
                .font(.system(size: 14, weight: .regular))
            }.padding()
        }
    }
}

struct PostView_Previews: PreviewProvider {
    static var previews: some View {
        PostView()
    }
}
