//
//  NewPostView.swift
//  Recipeat
//
//  Created by Frank Bara on 3/18/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import SwiftUI

struct NewPostView: View {
    
    @State private var showSheet = false
    @State private var showImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var image: UIImage?
    
    
    //sample data
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
        
        ZStack {
            VStack {
                ZStack {
                    HStack {
                        if image != nil {
                            Image(uiImage: image!)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
                                .scaledToFit()
                                .background(Color.blue)
                        } else {
                            Image(systemName:"timelapse")
                                .resizable()
                                .frame(width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width)
                                .scaledToFit()
                                .background(Color.blue)
                        }
                    }
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                self.showSheet.toggle()
                            }) {
                                Image(systemName: "plus.circle")
                                    .font(.system(size: 30))
                                    .foregroundColor(.black)
                                    .background(Color.white)
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
                    VStack {
                        Text("Ingredients")
                        ScrollView {
                            HStack {
                                VStack(alignment: .leading) {
                                    ForEach(ingredients, id: \.id) { thisIngredient in
                                        Text("\(thisIngredient.amount) \(thisIngredient.name)")
                                    }
                                }.padding()
                                Spacer()
                            }
                        }
                        .frame(width: UIScreen.main.bounds.size.width/2)
                        .clipped()
                    }
                    .background(Color.yellow)
                    
                    VStack {
                        Text("Steps")
                        ScrollView {
                            HStack {
                                VStack(alignment: .leading) {
                                    ForEach(steps, id: \.id) { thisStep in
                                        Text(thisStep.description)
                                    }
                                }.padding()
                                Spacer()
                            }
                        }
                        .frame(width: UIScreen.main.bounds.size.width/2)
                        .clipped()
                    }
                    .background(Color.green)
                    
                }
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            .sheet(isPresented: $showImagePicker) {
                VStack {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach (0..<5) { _ in
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
        }
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}


