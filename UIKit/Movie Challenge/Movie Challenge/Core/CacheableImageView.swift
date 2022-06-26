//
//  CacheableImageView.swift
//  Movie Challenge
//
//  Created by Cesar Paiva on 26/06/22.
//

import UIKit

class CacheableImageView: UIImageView {

    let imageCache = NSCache<AnyObject, AnyObject>()
    var imageURL: String?
    var dataTask: URLSessionDataTask?

    func downloadAndCacheImage(fromURL url: String) {

        self.imageURL = url

        guard let imageURL = URL(string: url) else {
            return
        }

        image = nil

        if imageInCache() {
            return
        }

        downloadImage(url: imageURL) { image in

            DispatchQueue.main.async {

                if self.imageURL == url {
                    self.image = image
                }
                self.cacheImage(image, key: imageURL)
            }
        }

        dataTask?.resume()
    }

    func cancelLoadingImage() {
        dataTask?.cancel()
        dataTask = nil
    }

    private func imageInCache() -> Bool {

        guard let imageFromCache = imageCache.object(forKey: imageURL as AnyObject) as? UIImage  else {
            return false
        }

        self.image = imageFromCache
        return true
    }

    private func downloadImage(url: URL, completionHandler: @escaping(_ image: UIImage) -> Void) {

        self.dataTask = URLSession.shared.dataTask(with: url) { data, response, error in

            guard let data = data,
                  let image = UIImage(data: data) else {
                return
            }

            completionHandler(image)
        }
    }

    private func cacheImage(_ image: UIImage, key: URL) {
        self.imageCache.setObject(image, forKey: key as AnyObject)
    }
}
