// *************************************************************************************************
// - MARK: Imports


import Foundation


// *************************************************************************************************
// MARK: MovieDBSearchMovieParameters


@objc public class MovieDBSearchMovieParameters: NSObject {
    
    
    let title: String
    
    
    init(title: String) {
        self.title = title
        super.init()
    }
    
}


// *************************************************************************************************
// MARK: MovieDBSearchMovieParameters NetworkParameterizable extension


extension MovieDBSearchMovieParameters: NetworkParameterizable {
    
    
    func parameters() -> Parameters? {
        var parameters: Parameters = Parameters()
        parameters["api_key"] = MovieDBServiceConfig.apikey
        parameters["query"] = title
        return parameters
    }
    
    
}

