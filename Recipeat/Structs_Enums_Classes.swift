//
//  Structs_Enums_Classes.swift
//  Recipeat
//
//  Created by Frank Bara on 3/2/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import Foundation
import SwiftUI

struct RecipePost: Identifiable {
    var id = UUID()
    var steps: [Step]
    var ingredients: [Ingredient]
    var postingUser: String
    var description: String
    var numberOfLikes: Int
    var image: Image
    
    var dictionary: [String: Any] {
        return [
            "id": id.uuidString,
            "steps": steps.formatForFirebase(),
            "ingredients": ingredients.formatForFirebase(),
            "postingUser": postingUser,
            "description": description,
            "numberOfLikes": numberOfLikes
        ]
    }
}

class user: NSObject, Identifiable, NSCoding {
    var id = UUID()
    var establishedID: String
    var username: String
    var password: String
    var name: String
    var email: String
    
    init(username: String, password: String, name: String, email: String, _ establishedID: String?) {
        self.username = username
        self.password = password
        self.name = name
        self.email = email
        
        if let establishedID = establishedID {
            self.establishedID = establishedID
        } else {
            self.establishedID = id.uuidString
        }
        
    }
    
    required init(coder aDecoder: NSCoder) {
        // decode the attributes
        id = aDecoder.decodeObject(forKey: "id") as? UUID ?? UUID()
        establishedID = aDecoder.decodeObject(forKey: "establishedID") as? String ?? ""
        username = aDecoder.decodeObject(forKey: "username") as? String ?? ""
        password = aDecoder.decodeObject(forKey: "password") as? String ?? ""
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        email = aDecoder.decodeObject(forKey: "email") as? String ?? ""
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(establishedID, forKey: "establishedID")
        aCoder.encode(username, forKey: "username")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(email, forKey: "email")
    }
    
}

class GlobalEnvironment: ObservableObject {
    
    @Published var currentUser: user = user.init(username: "", password: "", name: "", email: "", nil)
}


var lightBlue = Color.init(red: 91/255, green: 152/255, blue: 198/255)
var darkBlue = Color.init(red: 47/255, green: 75/255, blue: 135/255)
var vDarkBlue = Color.init(red: 2/255, green: 51/255, blue: 92/255)

enum IngredientUnit: String, CaseIterable {
    case cup = "cup"
    case tablespoon = "tablespoon"
    case teaspoon = "teaspoon"
    case pinch = "pinch"
    case dash = "dash"
    case lb = "lb"
    case kg = "kg"
    case mg = "mg"
    case g = "g"
    case mL = "mL"
    case L = "L"
    case whole = "whole"
}

struct Ingredient: Identifiable {
    var id = UUID()
    var name: String
    var amount: Double
    var amountUnit: IngredientUnit
    var orderNumber: Int
    
    var dictionary: [String: Any] {
        return [
            "id": id.uuidString,
            "name": name,
            "amount": amount,
            "amountUnit": amountUnit.rawValue,
            "orderNumber": orderNumber,
        ]
    }
}

struct Step: Identifiable {
    var id = UUID()
    var description: String
    var orderNumber: Int
    
    var dictionary: [String: Any] {
        return [
            "id": id.uuidString,
            "description": description,
            "orderNumber": orderNumber
        ]
    }
}
