import Foundation

/// Enum responsible for generating the URLRequest based on the params provided
enum Endpoint {
    case fetchMovies(searchKeyword: String, page: Int)
    case fetchMovieDetail(movieId: String)
    
    var request: URLRequest? {
        guard let url = self.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = self.httpMethod
        request.httpBody = self.httpBody
        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = Constants.scheme
        components.host = Constants.baseUrl
        components.queryItems = self.queryItems
        return components.url
    }
    
    private var queryItems: [URLQueryItem] {
        switch self {
        case .fetchMovies(let keyword, let page):
            return [
                URLQueryItem(name: "s", value: keyword),
                URLQueryItem(name: "apikey", value: Constants.API_KEY),
                URLQueryItem(name: "page", value: "\(page)")
            ]
        case .fetchMovieDetail(let movieId):
            return [
                URLQueryItem(name: "i", value: movieId),
                URLQueryItem(name: "apikey", value: Constants.API_KEY)
            ]
        }
    }
    
    private var httpMethod: String {
        switch self {
        case .fetchMovies:
            return "GET"
        case .fetchMovieDetail:
            return "GET"
        }
    }
    
    private var httpBody: Data? {
        switch self {
        case .fetchMovies:
            return nil
        case .fetchMovieDetail:
            return nil
        }
    }
}
