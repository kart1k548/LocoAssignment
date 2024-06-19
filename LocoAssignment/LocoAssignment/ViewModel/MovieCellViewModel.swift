import Foundation
import UIKit

/// Handles the business logic for the movie cell UI
class MovieCellViewModel {
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
    }
    
    var movieTitle: String {
        movie.title
    }
    
    var moviePosterUrl: String {
        movie.posterUrl
    }
}
