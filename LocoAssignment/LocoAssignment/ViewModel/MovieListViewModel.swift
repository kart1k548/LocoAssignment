import Foundation

/// Handles the business logic related to Movies List screen
class MovieListViewModel {
    private let movieService: MovieService
    var onMoviesReceived: (()-> Void)?
    var error: String? = nil
    private var page: Int = 1
    private var maxPage: Int = 1
    var searchKeyword: String = ""
    
    private(set) var movies: [Movie] = [] {
        didSet {
            movies.count > 0 ? onMoviesReceived?() : nil
        }
    }
    
    var haveMorePages: Bool {
        return page <= maxPage
    }
    
    init(movieService: MovieService = MovieService(apiRequest: APIRequest.shared)) {
        self.movieService = movieService
    }
    
    /// Creates the enpoint for fetch all movies API call by providing necessary params and then calls the API by providing the value for the callback to be called after receiving the API response
    public func fetchMovies() {
        let endpoint = Endpoint.fetchMovies(searchKeyword: self.searchKeyword, page: page)
        
        movieService.fetchMovies(with: endpoint) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movieData):
                    self?.movies += movieData.data
                    self?.page += 1
                    if let totalMovies = movieData.totalMovies {
                        self?.maxPage = totalMovies%10 == 0 ? totalMovies/10 : (totalMovies/10) + 1
                    }
                    
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
    
    /// sets all the necessary data members to their initial value once the user searches another movie
    public func setDefaultState() {
        page = 1
        maxPage = 1
        movies = []
    }
}
