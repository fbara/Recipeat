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
        .sheet(isPresented: $showImagePicker) {
            imagePicker(image: self.$image, sourceType: self.sourceType)
        }
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView()
    }
}

//---------ImagePicker - UIViewControllerRepresentable-------------
struct imagePicker: UIViewControllerRepresentable {
    
    @Binding var image: UIImage?
    
    typealias UIViewControllerType = UIImagePickerController
    typealias Coordinator = imagePickerCoordinator
    
    var sourceType: UIImagePickerController.SourceType = .camera
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<imagePicker>) -> UIImagePickerController {
        
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func makeCoordinator() -> imagePickerCoordinator {
        return imagePickerCoordinator(image: $image)
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<imagePicker>) {
        
    }
    
}


//---------COORDINATOR-------------
class imagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var image: UIImage?
    
    init(image: Binding<UIImage?>) {
        _image = image
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let uiimage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = uiimage
        }
    }
}
