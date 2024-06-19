import Foundation
import UIKit

/// responsible for handling the business logic for Movie details screen
class MovieDetailViewModel {
    var onMovieReceived: (() -> Void)?
    var error: String? = nil
    var movie: Movie
    
    private let movieService: MovieService
    
    private(set) var movieDetail: MovieInfo = .getMockedData() {
        didSet {
            onMovieReceived?()
        }
    }
    
    init(movieService: MovieService = MovieService(apiRequest: APIRequest.shared), movie: Movie) {
        self.movieService = movieService
        self.movie = movie
    }
    
    /// Creates the enpoint for fetch movie details API call by providing necessary params and then calls the API by providing the value for the callback to be called after receiving the API response
    public func fetchMovieDetail() {
        let endpoint = Endpoint.fetchMovieDetail(movieId: movie.movieId)
        
        movieService.fetchMovieDetail(with: endpoint) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movieDetail):
                    self?.movieDetail = movieDetail
                    
                case .failure(let error):
                    if let error = error as MovieServiceError? {
                        switch error {
                        case .decodingError(let error): self?.error = "Error: \(error)"
                        case .serverError(let error):
                            self?.error = "Server Error: \(error)"
                        case .unknown(let error):
                            self?.error = "Unknown Error: \(error)"
                        }
                    } else {
                        self?.error = error.localizedDescription
                    }
                }
            }
        }
    }
}
