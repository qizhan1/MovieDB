// *************************************************************************************************
// - MARK: Imports


import Foundation


// *************************************************************************************************
// - MARK: SearchMovieResponse


class SearchMovieResponse: Decodable {
    
    
    let page: Int?
    let totalResults: Int?
    let totalPages: Int?
    let results: [Movie]?
    
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
    
    
}
