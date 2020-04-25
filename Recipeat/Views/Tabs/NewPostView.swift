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
    @State private var images: [Identifiable_UIImage] = []
    @State private var halfModal_shown = false
    @State private var halfModal_title = ""
    @State private var halfModal_textfield_placeholder = ""
    @State private var halfModal_textfield1_val = ""
    @State private var halfModal_textfield2_val = ""
    @State private var halfModal_height: CGFloat = 380
    @State private var newItem_type: new_StepOrIngredient = .Step
    @State private var ingredientUnit_index = 0
    
    
    //sample data
    @State var steps: [Step] = []
    
    @State var ingredients: [Ingredient] = []
    
    
    var body: some View {
        
        ZStack {
            VStack(spacing: 0) {
                Spacer()
                    .frame(height: 65)
                ZStack {
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
                            Button(action: {
                                self.showSheet.toggle()
                            }) {
                                Image("pasta_icon")
                                    .renderingMode(.original)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(50)
                                    .frame(width: UIScreen.main.bounds.size.width, height: 300)
                                    .background(Color.init(red: 1, green: 1, blue: 1))
                            }
                            
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
                        
                    }.frame(height: 300)
                    
                }
                VStack {
                    HStack(spacing: 0) {
                        //Ingredients
                        VStack {
                            Text("Ingredients")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(darkBlue)
                                .foregroundColor(.white)
                            ScrollView {
                                HStack {
                                    VStack(alignment: .leading) {
                                        
                                        if ingredients.count > 0 {
                                            ForEach(ingredients, id: \.id) { thisIngredient in
                                                Text("\(thisIngredient.amount.stringWithoutZeroFraction) \(thisIngredient.amountUnit.rawValue) \(thisIngredient.name)")
                                            }.foregroundColor(Color.init(red: 0.3, green: 0.3, blue: 0.3))
                                                .padding(5).padding(.leading, 8).padding(.trailing, 3)
                                                .background(Color.init(red: 0.85, green: 0.85, blue: 0.85))
                                                .padding(.bottom, 4)
                                                .cornerRadius(5)
                                        } else {
                                            Button(action: {
                                                self.update_halfModal(title: "ADD AN INGREDIENT", placeholder: "Enter new ingredient", itemType: .Step, height: 470)
                                                self.halfModal_shown = true
                                            }) {
                                                Text("Add Some Ingredients")
                                                    .padding()
                                                    .foregroundColor(.gray)
                                                    .multilineTextAlignment(.center)
                                                    .frame(maxWidth: .infinity)
                                            }
                                        }
                                        
                                    }.padding(5)
                                    Spacer()
                                }
                            }
                            .frame(width: UIScreen.main.bounds.size.width/2)
                            .clipped()
                            Button(action: {
                                self.update_halfModal(title: "ADD AN INGREDIENT", placeholder: "Enter new ingredient", itemType: .Ingredient, height: 470)
                                self.halfModal_shown = true
                            }) {
                                Text("+ Ingredient")
                                    .padding()
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(height: 24)
                                    .background(mediumBlue)
                                    .cornerRadius(12)
                                    .padding(.bottom, 8)
                            }
                            
                            
                        }
                        .background(Color.clear)
                        
                        
                        //Steps
                        VStack {
                            Text("Steps")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .padding(10)
                                .background(darkBlue)
                                .foregroundColor(.white)
                            ScrollView {
                                HStack {
                                    VStack(alignment: .leading) {
                                        
                                        if steps.count > 0 {
                                            ForEach(steps, id: \.id) { thisStep in
                                                Text("\(thisStep.orderNumber)," + thisStep.description)
                                                .padding(5).padding(.leading, 8).padding(.trailing, 3)
                                                .background(Color.init(red: 0.85, green: 0.85, blue: 0.85))
                                                .padding(.bottom, 4)
                                            }.foregroundColor(Color.init(red: 0.3, green: 0.3, blue: 0.3))
                                        } else {
                                            Button(action: {
                                                self.update_halfModal(title: "ADD A STEP", placeholder: "Enter new step", itemType: .Step, height: 380)
                                                self.halfModal_shown = true
                                            }) {
                                                Text("Add Some Steps")
                                                    .padding()
                                                    .foregroundColor(.gray)
                                                    .multilineTextAlignment(.center)
                                                    .frame(maxWidth: .infinity)
                                                
                                            }
                                        }
                                        
                                    }.padding(5)
                                    Spacer()
                                }
                            }
                            .frame(width: UIScreen.main.bounds.size.width/2)
                            .clipped()
                            
                            Button(action: {
                                self.update_halfModal(title: "ADD A STEP", placeholder: "Enter new step", itemType: .Step, height: 380)
                                self.halfModal_shown = true
                            }) {
                                Text("+ Step")
                                    .padding()
                                    .font(.system(size: 12, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(height: 24)
                                    .background(mediumBlue)
                                    .cornerRadius(12)
                                    .padding(.bottom, 8)
                            }
                            
                        }
                        .background(Color.clear)
                        
                        
                    }
                    Button(action: {
                        
                        var actionsToComplete = 2 + self.images.count
                        var actionsCompleted = 0
                        
                        func check_success() {
                            print("\(actionsCompleted)/\(actionsToComplete)")
                            if actionsCompleted == actionsToComplete {
                                
                                let alertView = SPAlertView(title: "Recipe Submitted",
                                                            message: "Recipe submitted successfully!",
                                                            preset: SPAlertPreset.done)
                                alertView.duration = 3
                                alertView.present()
                                
                                self.clearPage()
                            }
                        }
                        
                        if self.images.count > 0 {
                            let thisRecipePost = RecipePost(steps: self.steps,
                                                            ingredients: self.ingredients,
                                                            postingUser: self.env.currentUser.establishedID,
                                                            description: "",
                                                            numberOfLikes: 0,
                                                            image: Image(uiImage: self.images[0].image)
                            )
                            
                            print(thisRecipePost.dictionary)
                            
                            self.env.currentUser.publishedRecipes.append(thisRecipePost.id.uuidString)
                            
                            firestoreSubmit_data(docRef_string: "recipe/\(thisRecipePost.id)", dataToSave: thisRecipePost.dictionary, completion: { _ in
                                actionsCompleted += 1
                                    check_success()
                            })
                            
                            firestoreUpdate_data(docRef_string: "users/\(self.env.currentUser.establishedID)", dataToUpdate: ["publishedRecipes" : self.env.currentUser.publishedRecipes], completion: { _ in
                                actionsCompleted += 1
                                check_success()
                            })
                            
                            for i in 0...self.images.count - 1 {
                                let image = self.images[i].image
                                uploadImage("recipe_\(thisRecipePost.id)_\(i)", image: image, completion: {_ in
                                    actionsCompleted += 1
                                    check_success()
                                })
                            }
                            
                            
                        } else {
                            let alertView = SPAlertView(title: "Add a photo",
                                                        message: "You can't add a recipe without a photo.",
                                                        preset: SPAlertPreset.error)
                            alertView.duration = 3
                            alertView.present()
                        }
                        
                    }) {
                        Text("Submit Recipe")
                            .padding(10)
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(25)
                            .frame(height: 48)
                            .frame(maxWidth: .infinity)
                            .background(vDarkBlue)
                            .shadow(radius: 3)
                    }
                    
                    
                    Spacer()
                        .frame(height: 65)
                }
                .background(Color.init(red: 0.95, green: 0.95, blue: 0.95))
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .sheet(isPresented: $showImagePicker) {
                VStack(spacing: 0) {
                    if self.images.count > 0 {
                        ScrollView(.horizontal) {
                            HStack {
                                ForEach (self.images, id: \.id) { i in
                                    Image(uiImage: i.image)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(height: 200)
                                        .shadow(radius: 3)
                                }
                            }
                            .padding()
                        }
                        .frame(height: 240)
                        .background(Color.white)
                    } else {
                        HStack {
                            Spacer()
                            Text("Please select an image from below.")
                            Spacer()
                            
                        }.frame(height: 240)
                            .background(Color.white)
                    }
                    HStack {
                        Button(action: { self.showImagePicker.toggle()}) {
                            Text("Done")
                                .padding()
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                                .frame(height: 24)
                                .background(mediumBlue)
                                .cornerRadius(12)
                            
                        }
                    }.frame(height: 57).frame(maxWidth: .infinity).background(Color.white)
                        .zIndex(1)
                    imagePicker(images: self.$images, sourceType: self.sourceType)
                        .offset(y: -57)
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
    
    func clearPage() {
        images.removeAll()
        halfModal_textfield1_val = ""
        halfModal_textfield2_val = ""
        ingredients = []
        steps = []
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}


