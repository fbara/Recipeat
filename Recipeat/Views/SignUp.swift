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
        VStack {
            Text("Sign up")
            TextField("Name", text: $name)
            TextField("Email", text: $email)
            TextField("Username", text: $username)
            TextField("Password", text: $password)
            
        }
    }
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        SignUp()
    }
}
