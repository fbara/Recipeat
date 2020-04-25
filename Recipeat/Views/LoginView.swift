//
//  LoginView.swift
//  Recipeat
//
//  Created by Frank Bara on 3/7/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import SPAlert

struct LoginView: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    @State private var signup_visible = false
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationView{
            ZStack {
                LinearGradient(gradient: Gradient(colors: [darkBlue, vDarkBlue]), startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 0) {
                    Image("fadeCarousel_2")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width)
                    
                    TextField("Username", text: $username)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.clear)
                        .frame(height: 50)
                        .overlay(Capsule()
                            .stroke(lineWidth: 2))
                        .padding()
                    
                    SecureField("Password", text: $password)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color.clear)
                        .frame(height: 50)
                        .overlay(Capsule()
                            .stroke(lineWidth: 2))
                        .padding()
                    
                    
                    NavigationLink(destination: TabbedRootView(), isActive: $isLoggedIn) {
                        Button(action: {
                            Firestore.firestore().collection("users").whereField("username", isEqualTo: self.username).getDocuments() { (querySnapshot, err) in
                                print("Username: \(self.username)")
                                if let err = err {
                                    print("Error getting documents: \(err)")
                                } else {
                                    if querySnapshot!.documents.count <= 0 {
                                        let alertView = SPAlertView(title: "No users found",
                                                                    message: "No users have the username you entered.",
                                                                    preset: SPAlertPreset.error)
                                        alertView.duration = 3
                                        alertView.present()
                                    } else if querySnapshot!.documents.count > 1 {
                                        let alertView = SPAlertView(title: "Something went wrong",
                                                                    message: "Multiple accounts exist for this username.",
                                                                    preset: SPAlertPreset.error)
                                        alertView.duration = 3
                                        alertView.present()
                                    } else {
                                        
                                        for document in querySnapshot!.documents {
                                            print("\(document.documentID) => \(document.data())")
                                            if document.data()["password"] as? String ?? "" == (self.password) {
                                                self.env.currentUser = user.init(username: document.data()["username"] as? String ?? "",
                                                                                 password: document.data()["password"] as? String ?? "",
                                                                                 name: document.data()["name"] as? String ?? "",
                                                                                 email: document.data()["email"] as? String ?? "",
                                                                                 publishedRecipes: document.data()["publishedRecipes"] as? [String] ?? [],
                                                                                 document.documentID)
                                                
                                                
                                                
                                                // Login happens here.  This is where you are right before you're flipped to the next screen.
                                                self.env.save_UserDefaults()
                                                self.isLoggedIn = true
                                            } else {
                                                let alertView = SPAlertView(title: "Password doesn't match", message: nil, preset: SPAlertPreset.error)
                                                alertView.duration = 3
                                                alertView.present()
                                            }
                                        }
                                    }
                                    
                                }
                            }
                        }) {
                            HStack {
                                Text("Login")
                                Image(systemName: "arrow.right")
                            }.frame(height: 50)
                                .frame(minWidth: 0, maxWidth: .infinity)
                            
                        }.background(lightBlue)
                            .cornerRadius(25)
                            .padding()
                    }
                    .onAppear() {
                        // open up lastLogin_objects as Data
                        if let lastLogin_objects = UserDefaults.standard.object(forKey: "lastLogin_objects") as? Data {
                            do {
                                // try to unarchive lastLoging_objects as the data dictionary we used to save it in the first place (HelperFuncs)
                                if let lastSession = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(lastLogin_objects) as? [String: Any?] {
                                    // successful login; move user to TabbedRootView
                                    
                                    if let rememberedUser = lastSession["lastLogin_user"] as? user {
                                        print("Login good with remembered user")
                                        print(rememberedUser)
                                        self.env.currentUser = rememberedUser
                                        
                                        self.env.initialize_CurrentUser()
                                        
                                    } else {
                                        print("Couldn't unwrap user")
                                        print(lastSession)
                                        print(lastSession["lastLogin_user"])
                                    }
                                    
                                    self.isLoggedIn = true
                                    print("Logged in successfully.")
                                }
                            } catch {
                                print("couldn't unwrap data/last session.")
                            }
                        } else {
                            print("couldn't unwrap data/lastLogin_objects.")
                        }
                    }
                    
                    
                    
                    
                    Spacer()
                    
                    Text("Don't have an account?")
                        .foregroundColor(.white)
                    
                    Button(action: {
                        self.signup_visible.toggle()
                    }) {
                        Text("Sign-up")
                            .padding()
                    }.background(Color.clear)
                        .foregroundColor(lightBlue)
                        .sheet(isPresented: $signup_visible, content: {
                            SignUp()
                        })
                    Spacer()
                    
                    
                }.background(Color.clear)
                    .foregroundColor(.white)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
