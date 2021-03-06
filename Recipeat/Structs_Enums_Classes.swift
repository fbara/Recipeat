//
//  Structs_Enums_Classes.swift
//  Recipeat
//
//  Created by Frank Bara on 3/2/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import Foundation
import SwiftUI

struct trunc_RecipePost: Identifiable {
    var id = UUID()
    var title: String
    var decription: String
    
    var dictionary: [String: Any] {
        return [
            "id": id.uuidString,
            "title": title,
            "description": decription
        ]
    }
}

struct RecipePost: Identifiable {
    var id = UUID()
    var title: String
    var steps: [Step]
    var ingredients: [Ingredient]
    var postingUser: String
    var description: String
    var numberOfLikes: Int
    var image: Image
    
    var dictionary: [String: Any] {
        return [
            "id": id.uuidString,
            "title": title,
            "steps": steps.formatForFirebase(),
            "ingredients": ingredients.formatForFirebase(),
            "postingUser": postingUser,
            "description": description,
            "numberOfLikes": numberOfLikes
        ]
    }
}

struct Identifiable_UIImage: Identifiable {
    var id = UUID()
    var image: UIImage
}

class user: NSObject, Identifiable, NSCoding {
    var id = UUID()
    var establishedID: String
    var username: String
    var password: String
    var name: String
    var email: String
    var publishedRecipes: [String] = []
    
    init(username: String, password: String, name: String, email: String, publishedRecipes: [String] , _ establishedID: String?) {
        self.username = username
        self.password = password
        self.name = name
        self.email = email
        self.publishedRecipes = publishedRecipes
        
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
        publishedRecipes = aDecoder.decodeObject(forKey: "publishedRecipes") as? [String] ?? []
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(establishedID, forKey: "establishedID")
        aCoder.encode(username, forKey: "username")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(publishedRecipes, forKey: "publishedRescipes")
    }
    
}

class GlobalEnvironment: ObservableObject {
    
    @Published var currentUser: user = user.init(username: "", password: "", name: "", email: "", publishedRecipes: [], nil)
}


var vLightBlue = Color.init(red: 130/255, green: 209/255, blue: 255/255)
var lightBlue = Color.init(red: 91/255, green: 152/255, blue: 198/255)
var mediumBlue = Color.init(red: 98/255, green: 157/255, blue: 191/255)
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
    
    var dictionary: [String: Any] {
        return [
            "id": id.uuidString,
            "name": name,
            "amount": amount,
            "amountUnit": amountUnit.rawValue
        ]
    }
}

struct Step: Identifiable {
    var id = UUID()
    var description: String
    
    var dictionary: [String: Any] {
        return [
            "id": id.uuidString,
            "description": description        ]
    }
}


enum new_StepOrIngredient {
    case Step, Ingredient
}
