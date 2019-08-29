// *************************************************************************************************
// - MARK: Imports


import Foundation
import UIKit


// *************************************************************************************************
// - MARK: PosterImageDataProvider


class  PosterImageDataProvider {
    
    
    // - MARK: Singleton
    
    
    static let shared = PosterImageDataProvider()
    
    
    // - MARK: Private Properties
    
    
    private let concurrentPhotoQueue = DispatchQueue( label: "com.movieDB.photoQueue",
                                                      attributes: .concurrent)
    
    
    // - MARK: Cached data in memeory
    
    
    private var unsafeImageDict = [String: UIImage]()
    var imageDict: [String: UIImage] {
        var photoDictCopy = [String: UIImage]()
        concurrentPhotoQueue.sync {
            photoDictCopy = self.unsafeImageDict
        }
        return photoDictCopy
    }
    
    
    public func fetchPoster(for movie: Movie?,
                            with imageSize: ImageSize,
                            completion: @escaping (_ image: UIImage?) -> Void) {
        guard let photoURL = movie?.posterPath else {
            completion(nil)
            
            return
        }
        
        let url = imageSize.rawValue + photoURL
        let photoURLPathMD5 = url.MD5
        
        // 1. try memory
        if let cachedImage = imageDict[photoURLPathMD5] {
            completion(cachedImage)
            
            return
        }
        
        // 2. try local
        if let localImage = UIImage.getSavedImage(named: photoURLPathMD5) {
            insertImage(localImage, with: photoURLPathMD5)
            completion(localImage)
            
            return
        }
        
        // 3. try remote api
        guard let posterPath = movie?.posterPath else { return }
        MovieDBService.getPoster(at: posterPath, with: imageSize) { [weak self] (image, error) in
            completion(image)
            self?.insertImage(image, with: photoURLPathMD5)
            image?.save(at: .cachesDirectory, pathAndImageName: photoURLPathMD5)
        }
    }
    
    
    // - MARK: Private Methods
    
    
    private func insertImage(_ image: UIImage?, with key: String?) {
        guard let image = image, let key = key else { return }
        
        concurrentPhotoQueue.async(flags: .barrier) { [weak self] in
            self?.unsafeImageDict[key] = image
        }
    }
    
    
}


