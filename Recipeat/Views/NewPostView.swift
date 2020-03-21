//
//  NewPostView.swift
//  Recipeat
//
//  Created by Frank Bara on 3/18/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import SwiftUI

struct NewPostView: View {
    var steps: [Step] = [
        Step(description: "add eggs", orderNumber: 0),
        Step(description: "add eggs", orderNumber: 1),
        Step(description: "add eggs", orderNumber: 2),
        Step(description: "add eggs", orderNumber: 3),
        Step(description: "add eggs", orderNumber: 4),
        Step(description: "add eggs", orderNumber: 5),
        Step(description: "add eggs", orderNumber: 6),
        Step(description: "add eggs", orderNumber: 7),
        Step(description: "add eggs", orderNumber: 8)
    ]
    
    var ingredients: [Ingredient] = [
        Ingredient(name: "eggs", amount: 3, amountUnit: .whole, orderNumber: 0),
        Ingredient(name: "parsley", amount: 3, amountUnit: .whole, orderNumber: 13),
        Ingredient(name: "eggs", amount: 3, amountUnit: .whole, orderNumber: 22),
        Ingredient(name: "parsley", amount: 2, amountUnit: .whole, orderNumber: 34),
        Ingredient(name: "eggs", amount: 3, amountUnit: .whole, orderNumber: 44),
        Ingredient(name: "parsley", amount: 3, amountUnit: .whole, orderNumber: 52),
        Ingredient(name: "eggs", amount: 3, amountUnit: .whole, orderNumber: 16),
        Ingredient(name: "parsley", amount: 3, amountUnit: .whole, orderNumber: 18),
        Ingredient(name: "eggs", amount: 3, amountUnit: .whole, orderNumber: 17),
        Ingredient(name: "parsley", amount: 3, amountUnit: .whole, orderNumber: 13),
        Ingredient(name: "eggs", amount: 3, amountUnit: .whole, orderNumber: 22),
        Ingredient(name: "parsley", amount: 2, amountUnit: .whole, orderNumber: 34),
        Ingredient(name: "eggs", amount: 3, amountUnit: .whole, orderNumber: 44),
        Ingredient(name: "parsley", amount: 3, amountUnit: .whole, orderNumber: 52),
        Ingredient(name: "eggs", amount: 3, amountUnit: .whole, orderNumber: 16),
        Ingredient(name: "parsley", amount: 3, amountUnit: .whole, orderNumber: 18),
        Ingredient(name: "eggs", amount: 3, amountUnit: .whole, orderNumber: 17),
        Ingredient(name: "parsley", amount: 3, amountUnit: .whole, orderNumber: 12)
    ]
    
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName:"timelaps")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
                    .scaledToFit()
                    .background(Color.blue)
                
            }
            
            HStack {
                VStack {
                    Text("Ingredients")
                    ScrollView {
                        VStack {
                            ForEach(ingredients, id: \.id) { thisIngredient in
                                Text("\(thisIngredient.amount) \(thisIngredient.name)")
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.size.width/2)
                .clipped()
                }
                .background(Color.yellow)
                
                VStack {
                    Text("Steps")
                    ScrollView {
                        VStack {
                            ForEach(steps, id: \.id) { thisStep in
                                Text(thisStep.description)
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.size.width/2)
                .clipped()
                }
                .background(Color.green)
                
            }
        }
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}
