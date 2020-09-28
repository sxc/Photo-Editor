//
//  ImagePicker.swift
//  Photo Editor
//
//  Created by Xiaochun Shen on 2020/9/28.
//

import Foundation

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    @ObservedObject var imageController: ImageController
    @Binding var showImagePicker: Bool
    
    var configuration: PHPickerConfiguration
    
    init(imageController: ImageController, showImagePicker: Binding<Bool>) {
        configuration = PHPickerConfiguration()
        configuration.selectionLimit = 1
        configuration.filter = .images
        self.imageController = imageController
        self._showImagePicker = showImagePicker
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: PHPickerViewControllerDelegate {
        private let parent: ImagePicker
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            let itemProvider = results.first?.itemProvider
            if let itemProvider = itemProvider, itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                    if let image = image as? UIImage {
                        DispatchQueue.main.async {
                            self.parent.imageController.unprocessedImage = image
                        }
                    }
                    
                    
                }
                parent.showImagePicker = false 
            }
        }
    }
    
}
