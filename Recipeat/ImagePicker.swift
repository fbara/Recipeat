//
//  ImagePicker.swift
//  Recipeat
//
//  Created by Frank Bara on 3/21/20.
//  Copyright © 2020 BaraLabs. All rights reserved.
//

import Foundation
import SwiftUI

//---------ImagePicker - UIViewControllerRepresentable-------------
struct imagePicker: UIViewControllerRepresentable {
    
    @Binding var images: [Identifiable_UIImage]
    
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
        return imagePickerCoordinator(images: $images)
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<imagePicker>) {
        
    }
    
}


//---------COORDINATOR-------------
class imagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @Binding var images: [Identifiable_UIImage]
    
    init(images: Binding<[Identifiable_UIImage]>) {
        _images = images
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let uiimage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            images.append(
                Identifiable_UIImage(image: uiimage)
            )
        }
    }
}
