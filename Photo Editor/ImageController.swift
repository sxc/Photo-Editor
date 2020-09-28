//
//  ImageController.swift
//  Photo Editor
//
//  Created by Xiaochun Shen on 2020/9/27.
//

import Foundation
import SwiftUI

class ImageController: ObservableObject {
    @Published var unprocessedImage: UIImage? {
        didSet {
            displayedImage = unprocessedImage
        }
    }
    @Published var displayedImage: UIImage?
    
    func generateFilteredImage(inputImage: UIImage?, filter: FilterType) -> UIImage? {
        let context = CIContext(options: nil)
        guard let imageToEdit = CIImage(image: inputImage!) else {
            return nil
        }
        switch filter {
        case .Original:
            return unprocessedImage
        case .Sepia:
            let filter = CIFilter(name: "CISepiaTone")
            filter?.setValue(imageToEdit, forKey: "inputImage")
            
            if let output = filter?.outputImage {
                if let cgimg = context.createCGImage(output, from: output.extent) {
                    let processedImage = UIImage(cgImage: cgimg)
                    return processedImage
                }
            }
       
            
        }
        return inputImage
    }
    
}
