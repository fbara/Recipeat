//
//  HelperFuncs.swift
//  Recipeat
//
//  Created by Frank Bara on 3/14/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import Foundation
import SwiftUI

extension GlobalEnvironment {
    
    func save_UserDefaults() {
        let data_dictionary: [String: Any?] = [
            "lastLogin_username":currentUser.username,
            "lastLogin_password":currentUser.password
        ]
        
        let save_UserDefaults = UserDefaults.standard
        
        do {
            let sessionData = try
                NSKeyedArchiver.archivedData(withRootObject: data_dictionary, requiringSecureCoding: false)
            save_UserDefaults.set(sessionData, forKey: "lastLogin_objects")
            print("saved successfully")

        } catch {
            print("couldn't write file")
        }
    }
}

