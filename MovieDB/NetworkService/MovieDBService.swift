// *************************************************************************************************
// - MARK: Imports


import Foundation
import UIKit


// *************************************************************************************************
// - MARK: PhotoSize Enum


enum ImageSize: String {
    case large = "w500/"
    case small = "w185/"
}


// *************************************************************************************************
// - MARK: MovieDBService


class MovieDBService: NetworkResponseValidatable {
    
    
    static func searchMovie(title: String, completion: @escaping (_ response: SearchMovieResponse?, _ error: String?) -> Void)  {
        let params = MovieDBSearchMovieParameters(title: title)
        
        Router<MovieDBEndpoint>().request(.searchMovie(params)) { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = MovieDBService.validateNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        
                        return
                    }
                    do {
                        let apiResponse = try JSONDecoder().decode(SearchMovieResponse.self, from: responseData)
                        completion(apiResponse, nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    
    // TODO: Pagination
    static func getPoster(at path: String, with size: ImageSize, completion: @escaping (_ image: UIImage?, _ error: String?) -> Void)  {
        let params = MovieDBGetPosterParameters(posterPath: path, size: size)
        
        Router<MovieDBEndpoint>().request(.getPoster(params)) { data, response, error in
            if error != nil {
                completion(nil, "Please check your network connection.")
            }
            
            if let response = response as? HTTPURLResponse {
                let result = MovieDBService.validateNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        
                        return
                    }
                    guard
                        let mimeType = response.mimeType, mimeType.hasPrefix("image"), error == nil,
                        let image = UIImage(data: responseData) else {
                            completion(nil, NetworkResponse.unableToDecode.rawValue)
                            return
                    }
                    completion(image, nil)
                    
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    
}
