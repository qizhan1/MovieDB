// *************************************************************************************************
// - MARK: Imports


import Foundation


// *************************************************************************************************
// MARK: MovieDBGetPosterParameters


class MovieDBGetPosterParameters: NSObject {
    
    
    let posterPath: String
    let size: ImageSize
    
    
    init(posterPath: String, size: ImageSize) {
        self.posterPath = posterPath
        self.size = size
        super.init()
    }
    
    
}

// *************************************************************************************************
// MARK: MovieDBGetPosterParameters NetworkParameterizable extension


extension MovieDBGetPosterParameters: NetworkParameterizable {
    
    
    func parameters() -> Parameters? {
        
        return nil
    }
    
    
}
