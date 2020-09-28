//
//  ContentView.swift
//  Photo Editor
//
//  Created by Xiaochun Shen on 2020/9/27.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var imageController: ImageController
    @State var showImagePicker = false
    
    
    let availableFilters: [FilterType] = [.Original, .Sepia]
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    if let imageToDisplay = imageController.displayedImage, let originalImage = imageController.unprocessedImage {
                    
                        Image(uiImage: imageToDisplay)
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.75)
                        .clipped()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            
                            ForEach(availableFilters, id: \.self) { filter in
                                Button(action: {
                                    imageController.displayedImage = imageController.generateFilteredImage(inputImage: originalImage, filter: filter)
                                }) {
                                    ThumbnailView(imageToDisplay: imageToDisplay, width: geometry.size.width*(21/100), height: geometry.size.height*(15/100), filterName: "\(filter)")
                                }
                                
                            }
                            
                         
                            
                            
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * (1/4))
                    } else {
                        Spacer()
                        Text("Upload a photo to start editing.")
                            .frame(width: geometry.size.width, height: geometry.size.height*(0.25))
                        Spacer()
                    }
                }
            }
            
            .sheet(isPresented: $showImagePicker, content: {
                ImagePicker(imageController: imageController, showImagePicker: $showImagePicker)
            })
            
            
            .navigationBarTitle("Filter App", displayMode: .inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    GalleryButton(showImagePicker: $showImagePicker)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    SaveButton()
                }
                
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(ImageController())
    }
}

struct ThumbnailView: View {
    
    let imageToDisplay: UIImage
    
    let width: CGFloat
    let height: CGFloat
    let filterName: String
    
    var body: some View {
        VStack {
            Text(filterName)
                .foregroundColor(Color("LightGray"))
            Image(uiImage: imageToDisplay)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                .frame(width: width,
                       height: height)
                .cornerRadius(20)
                .clipped()
        }
        .padding(.leading, 10)
        .padding(.trailing, 10)
    }
}

struct GalleryButton: View {
    
    @Binding var showImagePicker: Bool
    
    var body: some View {
        Button(action: {
            showImagePicker = true
        }) {
            Image(systemName: "photo")
                .imageScale(.large)
        }
    }
}


struct SaveButton: View {
    var body: some View {
        Button(action: {
            print("Save edited photo.")
        }) {
            Image(systemName: "square.and.arrow.down")
                .imageScale(.large)
        }
    }
}
