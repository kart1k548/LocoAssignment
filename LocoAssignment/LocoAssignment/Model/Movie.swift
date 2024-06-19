import Foundation

/// Has the model data which is used the decode the json data we receive from  fetch all movies API response
struct MovieData: Decodable {
    let data: [Movie]
    private let totalResults: String
    
    var totalMovies: Int? {
        Int(totalResults)
    }
    
    enum CodingKeys: String, CodingKey {
        case data = "Search"
        case totalResults
    }
    
}

/// Contains the model data for each json object inside movies List
struct Movie: Decodable {
    let title: String
    let movieId: String
    let posterUrl: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case movieId = "imdbID"
        case posterUrl = "Poster"
    }
}

