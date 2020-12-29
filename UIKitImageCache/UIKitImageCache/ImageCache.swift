//
//  ImageCache.swift
//  CacheImageTest
//
//  Created by Rob Kerr on 12/27/20
//

import UIKit

enum FetchMethod {
    case nsCache, urlCache
}

// Custom cache used for the urlSession method only (urlRequest uses the built-in URLCache.shared object)
var imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImage(urlString: String, placeholderImage: UIImage?, errorImage: UIImage?, fetchMethod: FetchMethod) {
        print("URLCache Method: image requested \(urlString)")
        
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

        // NOTE: this is an artificial delay for demonstration purposes. This delay should be removed
        //       for a production implementation
        DispatchQueue.global().asyncAfter(deadline: .now() + 2.0) {
            if fetchMethod == .urlCache {
                // This method uses URLRequest, and URLCache.shared for the cache
                self.fetchImageFromNetworkUsingURLCache(url: url, placeholderImage: placeholderImage, errorImage: errorImage)
            } else {
                // This method uses URLSession, and a custom NSCache for the cache
                self.fetchImageFromNetworkUsingNSCache(url: url, placeholderImage: placeholderImage, errorImage: errorImage)
            }
        }
    }
    
    private func fetchImageFromNetworkUsingURLCache(url: URL, placeholderImage: UIImage?, errorImage: UIImage?) {
        print("URLCache Method: fetch \(url.absoluteString)")
        
        // Attempt to fetch image
        let cache = URLCache.shared
        let request = URLRequest(url: url, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 60.0)
        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            print("URLCache Method: Setting image from cache: \(url.absoluteString)")
            DispatchQueue.main.async {
                self.image = image
            }
        } else {
            URLSession.shared.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
                if let err = error {
                    print("URLCache Method: image fetch error: \(err.localizedDescription)")
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
                    print("URLCache Method: image fetch status code error: \(statusCode)")
                    if let errImage = errorImage {
                        DispatchQueue.main.async {
                            self?.image = errImage
                        }
                    }
                    return
                }
                
                if let data = data, let response = response, let image = UIImage(data: data) {
                    print("URLCache Method: Setting image from network fetch: \(url.absoluteString)")
                    let cachedData = CachedURLResponse(response: response, data: data)
                    cache.storeCachedResponse(cachedData, for: request)
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }).resume()
        }
    }
    
    
    private func fetchImageFromNetworkUsingNSCache(url: URL, placeholderImage: UIImage?, errorImage: UIImage?) {
        print("NSCache Method image requested \(url.absoluteString)")
        
        // Attempt to fetch image
        URLSession.shared.dataTask(with: url) { [weak self] (data, response, error ) in
            
            // If error returned by request, display error image
            if let err = error {
                print("NSCache Method: image fetch error: \(err.localizedDescription)")
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
                print("NSCache Method: image fetch status code error: \(statusCode)")
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
                    print("NSCache Method: cached image saved and applied: \(url.absoluteString)")
                    self.image = image
                }
            }
        }.resume()
    }

}
