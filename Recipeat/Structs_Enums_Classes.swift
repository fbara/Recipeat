//
//  Structs_Enums_Classes.swift
//  Recipeat
//
//  Created by Frank Bara on 3/2/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import Foundation
import SwiftUI

struct recipePost: Identifiable {
    var id = UUID()
    
    var postingUser: String
    var description: String
    var numberOfLikes: Int
    var image: Image
}
