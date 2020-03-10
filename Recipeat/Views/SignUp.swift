//
//  SignUp.swift
//  Recipeat
//
//  Created by Frank Bara on 3/7/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import SwiftUI

struct SignUp: View {
    
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    
    var body: some View {
        ZStack {
            Image("fadeCarrousel_2_blur")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width)
                .edgesIgnoringSafeArea(.all)
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.blue, Color.white]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/).opacity(0.2)
                LinearGradient(gradient: Gradient(colors: [Color.black, Color.white]), startPoint: .top, endPoint: .bottom).opacity(0.2)
                Color.white.opacity(0.2)
            }
            .edgesIgnoringSafeArea(.all)
            VStack(spacing: 0.0) {
                
                Image("baralabs_logo")
                    .resizable()
                    .scaledToFit()
                    .shadow(radius: 5, y: 5)
                Spacer()
                    .frame(height: 50)
                
                VStack(spacing: 0) {
                    TextField("Name", text: $name)
                        .frame(height: 40)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.white)
                        .opacity(0.2)
                    TextField("Email", text: $email)
                    .frame(height: 40)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.white)
                        .opacity(0.2)
                    TextField("Username", text: $username)
                    .frame(height: 40)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.white)
                        .opacity(0.2)
                    TextField("Password", text: $password)
                    .frame(height: 40)
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(.white)
                        .opacity(0.2)
                }
                Spacer()
                    .frame(height: 30)
            
                Button(action: {
                    print("Button pressed")
                }) {
                    HStack {
                        Text("Sign Up")
                        Image(systemName: "checkmark")
                    }
                    
                }
                Spacer().frame(height: 250)
            }.padding(30)
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
