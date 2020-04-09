//
//  HelperFuncs.swift
//  Recipeat
//
//  Created by Frank Bara on 3/14/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import Foundation
import SwiftUI
import Combine
import Firebase

extension GlobalEnvironment {
    
    func save_UserDefaults() {
        let data_dictionary: [String: Any?] = [
            "lastLogin_user": currentUser
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

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension Double {
    //Removes trailing zeros from Doubles during display
    var stringWithoutZeroFraction: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

//Turns our structure for Steps into an array of arrays for Firebase
extension Array where Element == Step {
    func formatForFirebase() -> [[String: Any]] {
        var returnVal:[[String: Any]] = []
    
    for element in self {
    returnVal.append(element.dictionary)
    }
    
    return returnVal
    
    }
}

//Turns our structure for Ingredients into an array of arrays for Firebase
extension Array where Element == Ingredient {
    func formatForFirebase() -> [[String: Any]] {
        var returnVal:[[String: Any]] = []
    
    for element in self {
        returnVal.append(element.dictionary)
    }
    
    return returnVal
    
    }
}

func fraction_progress(lowerLimit: Double = 0, upperLimit: Double, current: Double, inverted: Bool = false) -> Double {
    var val: Double = 0
    
    if current >= upperLimit {
        val = 1
    } else if current <= lowerLimit {
        val = 0
    } else {
        val = (current - lowerLimit)/(upperLimit -  lowerLimit)
    }
    
    if inverted {
        return 1 - val
    } else {
        return val
    }
}
 
enum DragState {
    case inactive
    case dragging(translation: CGSize)
    
    var translation: CGSize {
        switch self {
        case .inactive:
            return .zero
        case .dragging(let translation):
            return translation
        }
    }
    
    var isDragging: Bool {
        switch self {
        case .inactive:
            return false
        case .dragging:
            return true
        }
    }
}

//Saves data to Firestore
func firestoreSubmit_data(docRef_string: String, dataToSave: [String: Any], completion: @escaping (Any) -> Void, showDetails: Bool = false) {
    
    let docRef = Firestore.firestore().document(docRef_string)
    
    print("setting data")
    
    docRef.setData(dataToSave) { (error) in
        if let error = error {
            print("Error: \(error)")
            completion(error)
        } else {
            print("data uploaded successfully")
            if showDetails {
                print("dataUploaded = \(dataToSave)")
            }
        }
    }
}

