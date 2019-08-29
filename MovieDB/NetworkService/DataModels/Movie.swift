// *************************************************************************************************
// - MARK: Imports


import Foundation


// *************************************************************************************************
// - MARK: Movie


class Movie: Decodable {
    
    
    let popularity: Double?
    let voteCount: Int?
    let title: String?
    let overview: String?
    let releaseDate: String?
    let posterPath: String?
    let backdropPath: String?
    let originalTitle: String?
    let originalLanguage: String?
    
    
    enum CodingKeys: String, CodingKey {
        case popularity
        case voteCount = "vote_count"
        case title
        case releaseDate = "release_date"
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
    }
    
    
}


extension Movie {
    
    
    var releaseDateText: String? {
        guard let releaseDate = releaseDate else { return nil }
        
        return "Release Date: " + releaseDate
    }
    
    var originalLanguageText: String? {
        guard let originalLanguage = originalLanguage else { return nil }
        
        return "Original Language: " + originalLanguage
    }
    
    var originalTitleText: String? {
        guard let originalTitle = originalTitle else { return nil }
        
        return "Original Title: " + originalTitle
    }
    
    
}
