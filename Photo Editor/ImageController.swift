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
    var displayedImage: UIImage?
}
