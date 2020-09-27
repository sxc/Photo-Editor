//
//  ContentView.swift
//  Photo Editor
//
//  Created by Xiaochun Shen on 2020/9/27.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    Image("testImage")
                        .resizable()
                        .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.75)
                        .clipped()
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            ThumbnailView(width: geometry.size.width*(21/100), height: geometry.size.height*(15/100), filterName: "Original")
                        }
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height * (1/4))
                    
                }
            }
            .navigationBarTitle("Filter App", displayMode: .inline)
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading) {
                    GalleryButton()
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
        ContentView()
    }
}

struct ThumbnailView: View {
    
    let width: CGFloat
    let height: CGFloat
    let filterName: String
    
    var body: some View {
        VStack {
            Text("Original")
                .foregroundColor(Color("LightGray"))
            Image("testImage")
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
    var body: some View {
        Button(action: {
            print("Open image gallery.")
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
