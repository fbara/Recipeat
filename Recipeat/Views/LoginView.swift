//
//  LoginView.swift
//  Recipeat
//
//  Created by Frank Bara on 3/7/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @State private var signup_visible = false
    
    var body: some View {
        VStack(spacing: 0) {
            Image("fadeCarousel_2")
                .resizable()
                .scaledToFill()
            .clipped()
                .frame(height: 300.0)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(Color.blue)
                .edgesIgnoringSafeArea(.top)
            
            TextField("User", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                .padding()
                .background(Color.clear)
            
            TextField("Password", text: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Value@*/.constant("")/*@END_MENU_TOKEN@*/)
                .padding()
                .background(Color.clear)
            
            Spacer().frame(height: 30)
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                HStack {
                    Text("Login")
                    Image(systemName: "arrow.right")
                }.padding()
            }.background(Color.init(red: 0.85, green: 0.85, blue: 0.85))
                .cornerRadius(10)
            
            Spacer()
            
            Button(action: {
                self.signup_visible.toggle()
            }) {
                Text("Sign-up")
                    .padding()
            }.background(Color.clear)
                .foregroundColor(Color.init(red: 0.8, green: 0.8, blue: 0.8))
                .sheet(isPresented: $signup_visible, content: {
                    Text("This is the signup.")
                })
            Spacer()
            
            
        }.background(Color.clear)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
