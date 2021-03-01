//
//  ImageViewLoader.swift
//  SwiftUISearchExample
//
//  Created by James Rochabrun on 7/21/20.
//

import SwiftUI

struct ImageOverlay: View {
    private let channel: Channel?
    
    init(item: Channel?) {
        self.channel = item
    }
    var body: some View {
        ZStack{
            VStack{
                Text(self.channel?.title ?? "").font(.title3).foregroundColor(.white)
                HStack{
                    Text(self.channel?.country ?? "").font(.body).foregroundColor(.white)
                    Text("|").font(.body).foregroundColor(.white)
                    Text(self.channel?.language ?? "").font(.body).foregroundColor(.white)
                }
            }
        }.background(Color.black)
        .opacity(0.5)
        .padding(0)
    }
}

struct ImageViewCache: View {
    
    // MARK:- Subscribers
    @ObservedObject var imageLoader: ImageLoader
    
    private let errorImage: UIImage?
    private let channel: Channel?
    
    init(urls: (urlString: String?, lowResURLString: String?), errorImage: UIImage?, item: Channel?) {
        imageLoader = ImageLoader(urls: urls, errorImage: errorImage)
        self.errorImage = errorImage
        self.channel = item
    }
    var body: some View {
        Image(uiImage: imageLoader.image ?? self.errorImage!).resizable().scaledToFit()
            .overlay(ImageOverlay(item: channel), alignment: .bottom)
    }
}
