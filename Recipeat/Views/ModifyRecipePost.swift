//
//  ModifyRecipePost.swift
//  Recipeat
//
//  Created by Frank Bara on 4/27/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import SwiftUI
import SPAlert

struct ModifyRecipePost: View {
    @EnvironmentObject var env: GlobalEnvironment
    
    @Binding var binding_recipePost: RecipePost
    @Binding var images:  [Identifiable_UIImage]
    @Binding var isShown: Bool
    
    
    @State private var editingIngredients = false
    @State private var editingSteps = false
    @State private var listType = new_StepOrIngredient.Ingredient
    //@Binding var recipeDescription: String
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                if images.count > 0 {
                    ScrollView(.horizontal) {
                        HStack(spacing: 0) {
                            ForEach (self.images, id: \.id) { i in
                                Image(uiImage: i.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: UIScreen.main.bounds.size.width, height: 300)
                                
                            }
                        }
                        .background(Color.black)
                    }
                    .background(Color.black)
                    
                } else {
                    Text("Please go back and select at least 1 image.")
                        .frame(height: 300)
                    
                }
            }
            TextField("Name your recipe", text: $binding_recipePost.title)
                .padding()
            TextField("Give it a description", text: $binding_recipePost.description)
                .padding()
            
            HStack {
                List {
                    ForEach(binding_recipePost.ingredients, id: \.id) { thisIng in
                        Text("\(thisIng.name)")
                        .padding(EdgeInsets.init(top: 3, leading: 6, bottom: 3, trailing: 6))
                        .background(Color.init(red: 0.9, green: 0.9, blue: 0.9))
                        .cornerRadius(5)
                        .lineLimit(nil)
                }
                .onMove(perform: move)
                .onDelete(perform: delete)
                .onLongPressGesture {
                    withAnimation {
                        self.listType = .Ingredient
                        self.editingIngredients = true
                    }
                }
            }
                .environment(\.editMode, editingIngredients ? .constant(.active) : .constant(.inactive))
                List {
                    ForEach(binding_recipePost.steps, id: \.id) { thisStep in
                        Text("\(thisStep.description)")
                            .padding(EdgeInsets.init(top: 3, leading: 6, bottom: 3, trailing: 6))
                            .background(Color.init(red: 0.9, green: 0.9, blue: 0.9))
                            .cornerRadius(5)
                            .lineLimit(nil)
                    }
                    .onMove(perform: move)
                    .onDelete(perform: delete)
                    .onLongPressGesture {
                        withAnimation {
                            self.listType = .Step
                            self.editingSteps = true
                        }
                    }
                }
                    .environment(\.editMode, editingSteps ? .constant(.active) : .constant(.inactive))
            }
                
            Spacer()
        }
    }
    
    func delete(at offsets: IndexSet) {
        print(offsets)
        
        if listType == .Step {
             binding_recipePost.steps.remove(atOffsets: offsets)
        } else {
            binding_recipePost.ingredients.remove(atOffsets: offsets)
        }
        
    }
    
    func move(fromOffsets source: IndexSet, toOffsets destination: Int) {
        
        if listType == .Step {
             binding_recipePost.steps.move(fromOffsets: source, toOffset: destination)
             withAnimation {
                 editingSteps = false
             }
        } else {
            binding_recipePost.ingredients.move(fromOffsets: source, toOffset: destination)
            withAnimation {
                editingSteps = false
            }
        }
    }
    

    
}

//struct ModifyRecipePost_Previews: PreviewProvider {
//    static var previews: some View {
//        ModifyRecipePost(recipeTitle: .constant("abc"))
//    }
//}
