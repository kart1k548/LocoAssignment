import Foundation

/// enum handles all the error cases we could encounter while working with API
enum MovieServiceError: Error {
    case decodingError(String)
    case serverError(String)
    case unknown(String)
}

 /// Service class responsible for handling all the api requests made related to movies
class MovieService {
    let apiRequest: APIRequest
    
    init(apiRequest: APIRequest) {
        self.apiRequest = apiRequest
    }
    
    /// Gets the response from the fetch all movies based on searchKeyword api request and passes it on further.
    /// - Parameters:
    ///   - endpoint: contains the URLRequest for fetch all movies API
    ///   - completion: callback to be called once we recieve response from the API
    func fetchMovies(with endpoint: Endpoint, completion: @escaping (Result<MovieData, MovieServiceError>)->Void) {
        apiRequest.getAPIRequest(with: endpoint) { result in
            completion(result)
        }
    }
    
    /// Gets the response from the fetch movie details API based on the movieID provided and passes it on further
    /// - Parameters:
    ///   - endpoint: contains the URLRequest for fetch movie details API
    ///   - completion: callback to be called once we receive response from the API
    func fetchMovieDetail(with endpoint: Endpoint, completion: @escaping (Result<MovieInfo, MovieServiceError>)->Void) {
        apiRequest.getAPIRequest(with: endpoint) { result in
            completion(result)
        }
    }
}
