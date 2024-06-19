import Foundation

/// Contains the model data which can be used to decode the json data we recieve from the movie details API
struct MovieInfo: Decodable {
    let title: String
    let releaseDate: String
    let director: String
    let plot: String
    let posterUrl: String
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case releaseDate = "Released"
        case director = "Director"
        case plot = "Plot"
        case posterUrl = "Poster"
    }
}

extension MovieInfo {
    /// returns the mocked data in case any object needs
    static func getMockedData() -> MovieInfo {
        MovieInfo(title: "I'll Haunt You When I'm Dead", releaseDate: "27 Apr 2013", director: "Jeremy Kasten", plot: "Alleged encounters with vengeful ghosts are recalled.", posterUrl: "https://m.media-amazon.com/images/M/MV5BOTI5ODNhNGQtNDM5MC00OWRkLWFiNDMtZDRhZWYzNzMzZjhkXkEyXkFqcGdeQXVyMjkzMDk3Mjk@._V1_SX300.jpg")
    }
}

