//
//  MeView.swift
//  Recipeat
//
//  Created by Frank Bara on 3/2/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import SwiftUI
import Firebase

struct MeView: View {
    @EnvironmentObject var env: GlobalEnvironment

    var body: some View {
        ZStack {
            VStack {
                HStack {
                    VStack {
                        Text("\(env.currentUser.name)")
                        Text("\(env.currentUser.username) || \(env.currentUser.publishedRecipes.count)")
                    }
                    Spacer()
                    Image(systemName: "timelapse")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 90, height: 90)
                        .background(Color.yellow)
                        .cornerRadius(45)
                }
                .padding()
                
                HStack {
                    Button(action: {}) {
                        Spacer()
                        Text("Message")
                            .padding(3)
                        .foregroundColor(.black)
                        Spacer()
                        
                    }.cornerRadius(5)
                    
                    Button(action: {}) {
                        Spacer()
                        Text("Follow")
                            .padding(3)
                        .foregroundColor(.white)
                        Spacer()
                        
                    }
                    .background(darkBlue)
                    .cornerRadius(5)
                }
                
                ScrollView {
                    ForEach(0..<env.currentUser.publishedRecipes.count) { i in
                        
                        Me_PostView()
                        
                    }
                }.background(Color.red)
            }
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
