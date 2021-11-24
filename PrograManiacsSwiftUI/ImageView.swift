//
//  ImageLoader.swift
//  BeerSearch
//
//  Created by Rone Shender on 18/11/21.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    
    @Published var image = UIImage()
    
    init(urlString: String) {
        if let image = CacheImage.shared.cache.object(forKey: urlString as NSString) {
            self.image = image
        } else {
            guard let url = URL(string: urlString) else { return }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                let image = UIImage(data: data) ?? UIImage()
                CacheImage.shared.cache.setObject(image, forKey: urlString as NSString)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
            task.resume()
        }
    }
    
}

struct ImageView: View {
    
    @ObservedObject private var imageLoader: ImageLoader
    
    init(withURL url:String) {
        self.imageLoader = ImageLoader(urlString:url)
    }
    
    var body: some View {
        Image(uiImage: self.imageLoader.image)
            .resizable()
    }
    
}
