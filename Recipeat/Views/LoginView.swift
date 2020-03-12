//
//  LoginView.swift
//  Recipeat
//
//  Created by Frank Bara on 3/7/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import SwiftUI
import Firebase

struct LoginView: View {
    
    @State private var signup_visible = false
    @State private var username: String = ""
    @State private var password: String = ""
    
    
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
            
            TextField("Username", text: $username)
                .padding()
                .background(Color.clear)
            
            TextField("Password", text: $password)
                .padding()
                .background(Color.clear)
            
            Spacer().frame(height: 30)
            
            Button(action: {
                Firestore.firestore().collection("users").whereField("username", isEqualTo: self.username).getDocuments() { (querySnapshot, err) in
                    print("Username: \(self.username)")
                    if let err = err {
                        print("Error getting documents: \(err)")
                    } else {
                        
                        for document in querySnapshot!.documents {
                            print("Output:\n")
                            print("\(document.documentID) => \(document.data())")
                        }
                    }
                }
            }) {
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
