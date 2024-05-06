//
//  ImagePickerView.swift
//  TaskMind
//
//  Created by Aleksandra Rusak on 2024-05-06.
//

import SwiftUI
import UIKit

struct ImagePickerView: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    // Bindings to manage the selected image
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    var viewModel: ProfileViewViewModel
    
    // Creates a coordinator to manage the interaction between SwiftUI view and UIKit controller.
    func makeCoordinator() -> ImagePickerViewCoordinator {
            ImagePickerViewCoordinator(image: $image, isPresented: $isPresented, viewModel: viewModel)
        }
    
    // Creates and configures the UIImagePickerController.
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let pickerController = UIImagePickerController()
        pickerController.sourceType = sourceType
        pickerController.delegate = context.coordinator
        return pickerController
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        // Nothing to update here
    }

}

// Coordinator class to handle delegate responses from UIImagePickerController.
class ImagePickerViewCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    // Bindings to update the image in the SwiftUI view and manage the view's presentation.
    @Binding var image: UIImage?
    @Binding var isPresented: Bool
    var viewModel: ProfileViewViewModel
    
    // Initializer to set up the coordinator with required properties.
    init(image: Binding<UIImage?>, isPresented: Binding<Bool>, viewModel: ProfileViewViewModel) {
        _image = image
        _isPresented = isPresented
        self.viewModel = viewModel
    }
    
    // Delegate method called when an image is picked. Updates the bound image and triggers image saving.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let uiImage = info[.originalImage] as? UIImage {
            self.image = uiImage
            viewModel.saveImageToFirebaseStorage(uiImage)
        }
        self.isPresented = false // Dismiss the image picker.
    }
    
    // Delegate method called when the image picker is cancelled. Updates the presentation state.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.isPresented = false
    }
    
}

