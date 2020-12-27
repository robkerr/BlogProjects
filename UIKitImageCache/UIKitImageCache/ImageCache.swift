//
//  ImageCache.swift
//  CacheImageTest
//
//  Created by Rob Kerr on 12/27/20.
//

import UIKit

var imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImage(urlString: String, placeholderImage: UIImage?, errorImage: UIImage?) {
        print("image requested: \(urlString)")
        
        // If the requested url is already in the cache, return it directly
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            print("image found in cache: \(urlString)")
            image = cachedImage
            return
        }

        // passed in urlString must be a valid URL
        guard let url = URL(string: urlString) else {
            print("image url not valid: \(urlString)")
            return
        }
        
        // Set placeholder image, if provided
        if let placeholder = placeholderImage {
            DispatchQueue.main.async {
                print("Set placeholder")
                self.image = placeholder
            }
        }

        // NOTE: this is an artificial delay for demosntration purposes. This delay should be removed
        //       for a production implementation
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
            self.fetchImageFromNetwork(url: url, placeholderImage: placeholderImage, errorImage: errorImage)
        }
    }
    
    private func fetchImageFromNetwork(url: URL, placeholderImage: UIImage?, errorImage: UIImage?) {
        // Attempt to fetch image
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error ) in
            
            // If error returned by request, display error image
            if let err = error {
                print("image fetch error: \(err.localizedDescription)")
                if let errImage = errorImage {
                    DispatchQueue.main.async {
                        self?.image = errImage
                    }
                }
                return
            }
            
            // If http status code not OK, display error message
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
            if !(200...299).contains(statusCode) {
                if let errImage = errorImage {
                    DispatchQueue.main.async {
                        self?.image = errImage
                    }
                }
                return
            }
            
            // Extract image, store in cache, set to image source
            if let self = self, let data = data, let image = UIImage(data: data) {
                imageCache.setObject(image, forKey: url.absoluteString as NSString)
                DispatchQueue.main.async {
                    print("cached image saved and applied: \(url.absoluteString)")
                    self.image = image
                }
            }
        }.resume()
    }
}
