import Foundation
import UIKit

extension UIImageView {
    /// Loads the image from cache, if not found in cache then loads it after downloading
    /// - Parameter urlString: String URL of the image resource
    func loadImage(with urlString: String) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        if let cacheImage = ImageCache.shared.getImage(forKey: urlString) {
            self.image = cacheImage
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error {
                print(error)
            }
            
            if let data = data, let downloadedImage = UIImage(data: data){
                DispatchQueue.main.async {
                    self.image = downloadedImage
                    ImageCache.shared.set(downloadedImage, forKey: urlString)
                }
            }
        }.resume()
    }
}

