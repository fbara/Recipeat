//
//  NewPostView.swift
//  Recipeat
//
//  Created by Frank Bara on 3/18/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import SwiftUI
import SPAlert

enum new_StepOrIngredient {
    case Step, Ingredient
}

struct NewPostView: View {
    
    @EnvironmentObject var env: GlobalEnvironment
    
    @State private var showSheet = false
    @State private var showImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var image: UIImage?
    @State private var halfModal_shown = false
    @State private var halfModal_title = ""
    @State private var halfModal_textfield_placeholder = ""
    @State private var halfModal_textfield1_val = ""
    @State private var halfModal_textfield2_val = ""
    @State private var halfModal_height: CGFloat = 380
    @State private var newItem_type: new_StepOrIngredient = .Step
    @State private var ingredientUnit_index = 0
    
    
    //sample data
    @State var steps: [Step] = [
        //        Step(description: "add eggs", orderNumber: 0),
        //        Step(description: "add eggs", orderNumber: 1),
        //        Step(description: "add eggs", orderNumber: 2),
        //        Step(description: "add eggs", orderNumber: 3),
        //        Step(description: "add eggs", orderNumber: 4),
        //        Step(description: "add eggs", orderNumber: 5),
        //        Step(description: "add eggs", orderNumber: 6),
        //        Step(description: "add eggs", orderNumber: 7),
        //        Step(description: "add eggs", orderNumber: 8)
    ]
    
    @State var ingredients: [Ingredient] = [
        //        Ingredient(name: "eggs", amount: 3, amountUnit: .whole, orderNumber: 0),
        //        Ingredient(name: "parsley", amount: 3, amountUnit: .whole, orderNumber: 13),
        //        Ingredient(name: "eggs", amount: 3, amountUnit: .whole, orderNumber: 22),
        //        Ingredient(name: "parsley", amount: 2, amountUnit: .whole, orderNumber: 34),
        //        Ingredient(name: "eggs", amount: 3, amountUnit: .whole, orderNumber: 44),
        //        Ingredient(name: "parsley", amount: 3, amountUnit: .whole, orderNumber: 52),
        //        Ingredient(name: "eggs", amount: 3, amountUnit: .whole, orderNumber: 16),
        //        Ingredient(name: "parsley", amount: 3, amountUnit: .whole, orderNumber: 18),
        //        Ingredient(name: "eggs", amount: 3, amountUnit: .whole, orderNumber: 17),
        //        Ingredient(name: "parsley", amount: 3, amountUnit: .whole, orderNumber: 13),
        //        Ingredient(name: "eggs", amount: 3, amountUnit: .whole, orderNumber: 22),
        //        Ingredient(name: "parsley", amount: 2, amountUnit: .whole, orderNumber: 34),
        //        Ingredient(name: "eggs", amount: 3, amountUnit: .whole, orderNumber: 44),
        //        Ingredient(name: "parsley", amount: 3, amountUnit: .whole, orderNumber: 52),
        //        Ingredient(name: "eggs", amount: 3, amountUnit: .whole, orderNumber: 16),
        //        Ingredient(name: "parsley", amount: 3, amountUnit: .whole, orderNumber: 18),
        //        Ingredient(name: "eggs", amount: 3, amountUnit: .whole, orderNumber: 17),
        //        Ingredient(name: "parsley", amount: 3, amountUnit: .whole, orderNumber: 12)
    ]
    
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 65)
                ZStack {
                    HStack {
                        if image != nil {
                            Image(uiImage: image!)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
                                .scaledToFit()
                                .background(Color.black)
                        } else {
                            Image(systemName:"camera")
                                .resizable()
                                .scaledToFit()
                                .padding(130)
                                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
                                .background(Color.init(red: 1, green: 1, blue: 1))
                        }
                    }
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                self.showSheet.toggle()
                            }) {
                                ZStack {
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.black)
                                    Image(systemName: "plus.circle.fill")
                                        .foregroundColor(.white)
                                }
                                .font(.system(size: 30))
                                .shadow(radius: 4)
                                .opacity(0.7)
                                .padding()
                            }
                            .actionSheet(isPresented: $showSheet) {
                                ActionSheet(title: Text("Add a picture to your post"), message: nil, buttons: [
                                    .default(Text("Camera"), action: {
                                        self.showImagePicker = true
                                        self.sourceType = .camera
                                    }),
                                    .default(Text("Photo Library"), action: {
                                        self.showImagePicker = true
                                        self.sourceType = .photoLibrary
                                    }),
                                    .cancel()
                                ])
                            }
                        }
                        Spacer()
                        
                    }
                    
                }
                HStack {
                    //Ingredients
                    VStack {
                        Text("Ingredients")
                            .font(.headline)
                        ScrollView {
                            HStack {
                                VStack(alignment: .leading) {
                                    
                                    if ingredients.count > 0 {
                                        ForEach(ingredients, id: \.id) { thisIngredient in
                                            Text("\(thisIngredient.amount.stringWithoutZeroFraction) \(thisIngredient.amountUnit.rawValue) \(thisIngredient.name)")
                                                .padding(.bottom, 10)
                                        }.foregroundColor(Color.init(red: 108/255, green: 204/255, blue: 108/255))
                                    } else {
                                        Button(action: {
                                            self.update_halfModal(title: "ADD AN INGREDIENT", placeholder: "Enter new ingredient", itemType: .Step, height: 470)
                                            self.halfModal_shown = true
                                        }) {
                                            Text("Add Some Ingredients")
                                                .padding()
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    
                                }.padding()
                                Spacer()
                            }
                        }
                        .frame(width: UIScreen.main.bounds.size.width/2)
                        .clipped()
                        Button(action: {
                            self.update_halfModal(title: "ADD AN INGREDIENT", placeholder: "Enter new ingredient", itemType: .Ingredient, height: 470)
                            self.halfModal_shown = true
                        }) {
                            Text("Add New")
                                .padding()
                                .font(.headline)
                        }
                        
                        
                    }
                    .background(Color.clear)
                    
                    
                    //Steps
                    VStack {
                        Text("Steps")
                            .font(.headline)
                        ScrollView {
                            HStack {
                                VStack(alignment: .leading) {
                                    
                                    if steps.count > 0 {
                                        ForEach(steps, id: \.id) { thisStep in
                                            Text("\(thisStep.orderNumber)," + thisStep.description)
                                        }.foregroundColor(Color.init(red: 108/255, green: 172/255, blue: 204/255))
                                    } else {
                                        Button(action: {
                                            self.update_halfModal(title: "ADD A STEP", placeholder: "Enter new step", itemType: .Step, height: 380)
                                            self.halfModal_shown = true
                                        }) {
                                            Text("Add Some Steps")
                                                .padding()
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    
                                }.padding()
                                Spacer()
                            }
                        }
                        .frame(width: UIScreen.main.bounds.size.width/2)
                        .clipped()
                        
                        Button(action: {
                            self.update_halfModal(title: "ADD A STEP", placeholder: "Enter new step", itemType: .Step, height: 380)
                            self.halfModal_shown = true
                        }) {
                            Text("Add New")
                                .padding()
                                .font(.headline)
                        }
                        
                    }
                    .background(Color.clear)
                    
                    
                }
                .background(Color.init(red: 0.95, green: 0.95, blue: 0.95))
                
                Button(action: {
                    if let thisImage = self.image {
                        let thisRecipePost = RecipePost(steps: self.steps,
                                                        ingredients: self.ingredients,
                                                        postingUser: self.env.currentUser.establishedID,
                                                        description: "",
                                                        numberOfLikes: 0,
                                                        image: Image(uiImage: thisImage)
                            )
                        
                        print(thisRecipePost.dictionary)
                        
                        firestoreSubmit_data(docRef_string: "recipe/\(thisRecipePost.id)", dataToSave: thisRecipePost.dictionary, completion: { _ in })
                        
                    } else {
                        let alertView = SPAlertView(title: "Add a photo",
                                                    message: "You can't add a recipe without a photo.",
                                                    preset: SPAlertPreset.error)
                        alertView.duration = 3
                        alertView.present()
                    }
                    
                }) {
                    Text("Submit Recipe")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(25)
                        .frame(height: 48)
                        .background(darkBlue)
                        .cornerRadius(24)
                        .padding(10)
                }

                
                Spacer()
                    .frame(height: 65)
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .sheet(isPresented: $showImagePicker) {
                VStack {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach (0..<8) { _ in
                                Rectangle()
                                    .frame(width: 200, height: 200)
                                    .background(Color.red)
                            }
                        }
                        .padding()
                    }
                    .frame(height: 240)
                    .background(Color.blue)
                    imagePicker(image: self.$image, sourceType: self.sourceType)
                }
            }
            
            HalfModalView(isShown: $halfModal_shown, modalHeight: halfModal_height) {
                VStack {
                    Spacer().frame(height: 15)
                    Text("\(self.halfModal_title)").font(.headline)
                    
                    VStack {
                        HStack {
                            if self.newItem_type == .Ingredient {
                                TextField("#", text: self.$halfModal_textfield1_val)
                                    .frame(width: 40)
                                    .padding(10)
                                    .background(
                                        Rectangle()
                                            .cornerRadius(10)
                                            .foregroundColor(Color.init(red: 0.95, green: 0.95, blue: 0.95))
                                )
                                    .padding(20)
                                    .keyboardType(.numberPad)
                            }
                            
                            TextField("\(self.halfModal_textfield_placeholder)", text: self.$halfModal_textfield2_val)
                                .padding(10)
                                .background(
                                    Rectangle()
                                        .cornerRadius(10)
                                        .foregroundColor(Color.init(red: 0.95, green: 0.95, blue: 0.95))
                            )
                                .padding(20)
                        }
                        
                        if self.newItem_type == .Ingredient {
                            Picker(selection: self.$ingredientUnit_index, label: Text("Unit")) {
                                ForEach(0..<IngredientUnit.allCases.count) {
                                    Text(IngredientUnit.allCases[$0].rawValue).tag($0)
                                }
                            }
                            .labelsHidden()
                            .frame(height: 90)
                            .clipped()
                            .padding()
                        }
                        
                    }
                    
                    Button(action: {
                        self.add_newItem()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 35))
                            .foregroundColor(.init(red: 110/255, green: 210/255, blue: 110/255))
                    }
                    
                    
                    Spacer()
                }
            }
        }
    }
    
    func update_halfModal(title: String, placeholder: String, itemType: new_StepOrIngredient, height: CGFloat) {
        halfModal_textfield1_val = ""
        halfModal_textfield2_val = ""
        halfModal_title = title
        halfModal_textfield_placeholder = placeholder
        newItem_type = itemType
        halfModal_height = height
    }
    
    func hideModal() {
        
        UIApplication.shared.endEditing()
        halfModal_shown = false
    }
    
    func possible_stringToDouble(_ stringToValidate: String) -> Double? {
        
        let val: Double? = Double(stringToValidate) ?? nil
        
        if let val = val {
            return val
        } else {
            return nil
        }
        
    }
    
    
    func add_newItem() {
        
        if halfModal_textfield2_val == "" {
            let alertView = SPAlertView(title: newItem_type == .Step ? "Please add a step." : "Please add an ingredient.",
                                        message: "Make sure all text fields have an entry.",
                                        preset: SPAlertPreset.error)
            alertView.duration = 3
            alertView.present()
            
        } else {
            
            if newItem_type == .Step {
                steps.append(Step(description: halfModal_textfield2_val, orderNumber: steps.count))
                hideModal()
                
            } else if newItem_type == .Ingredient {
                
                if let amount = possible_stringToDouble(halfModal_textfield1_val) {
                    
                    let thisIngredientUnit = IngredientUnit.allCases[ingredientUnit_index]
                    
                    ingredients.append(Ingredient(name: halfModal_textfield2_val,
                                                  amount: amount,
                                                  amountUnit: thisIngredientUnit,
                                                  orderNumber: ingredients.count))
                    hideModal()
                    
                } else {
                    let alertView = SPAlertView(title: "Check the amount",
                                                message: "Please enter a number (i.e. \"1\" or \"3.4\")",
                                                preset: SPAlertPreset.error)
                    alertView.duration = 3
                    alertView.present()
                }
            }
        }
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}


