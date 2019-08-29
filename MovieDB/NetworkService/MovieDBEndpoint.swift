// *************************************************************************************************
// - MARK: Imports


import Foundation


// *************************************************************************************************
// - MARK: MovieDBEndpoint


enum MovieDBEndpoint {
    case searchMovie(MovieDBSearchMovieParameters)
    case getPoster(MovieDBGetPosterParameters)
}


// *************************************************************************************************
// - MARK: MovieDBEndpoint Extension


extension MovieDBEndpoint: URLRequestConvertiable {
    
    
    var baseURL: URL {
        
        var urlStr = ""
        switch self {
        case .getPoster(_):
            urlStr = MovieDBServiceConfig.imageUrl
        case .searchMovie(_):
            urlStr = MovieDBServiceConfig.apiUrl
        }
        guard let url = URL(string: urlStr) else { fatalError("baseURL could not be configured.") }
        
        return url
    }
    
    
    var path: String {
        switch self {
        case .searchMovie:
            return "search/movie"
        case .getPoster(let params):
            return params.size.rawValue + params.posterPath
        }
    }
    
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    
    var task: HTTPTask {
        switch self {
        case .searchMovie(let params):
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: params.parameters())
        case .getPoster(_):
            return .request
        }
    }
    
    
    var headers: HTTPHeaders? {
        return nil
    }
    
    
}
