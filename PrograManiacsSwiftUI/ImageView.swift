//
//  ImageLoader.swift
//  BeerSearch
//
//  Created by Rone Shender on 18/11/21.
//

import SwiftUI
import Combine

public class ImageLoader: ObservableObject {
    
    @Published internal var image = UIImage()
    
    public init(urlString: String,
                completionGetImage: ((ImageLoader) -> Void)? = nil,
                completionSetImage: ((Data) -> Void)? = nil) {
        
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            var newData: Data = Data()
            if let data = data {
                newData = data
                completionSetImage?(data)
            } else {
                completionGetImage?(self)
            }
            let image = UIImage(data: newData) ?? UIImage()
            self.setImage(image)
        }
        task.resume()
    }
    
    public func setImage(_ image: UIImage) {
        DispatchQueue.main.async {
            self.image = image
        }
    }
    
}

public struct ImageView: View {
    
    @ObservedObject private var imageLoader: ImageLoader
    
    public init(withURL urlString: String,
                completionGetImage: ((ImageLoader) -> Void)? = nil,
                completionSetImage: ((Data) -> Void)? = nil) {
        self.imageLoader = ImageLoader(urlString: urlString,
                                       completionGetImage: completionGetImage,
                                       completionSetImage: completionSetImage)
    }
    
    public var body: some View {
        Image(uiImage: self.imageLoader.image)
            .resizable()
    }
    
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(withURL: "https://www.themoviedb.org/t/p/w220_and_h330_face/2CAL2433ZeIihfX1Hb2139CX0pW.jpg")
    }
}
