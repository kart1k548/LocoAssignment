import Foundation

/// Contains the list of all the constants to be used across the project
enum Constants {
    static let scheme = "http"
    static let baseUrl = "omdbapi.com"
    static let API_KEY = "649bcf89"
    static let fetchMoviesUrl = "http://omdbapi.com/?s=haunt&type=movie&r=json&apikey=649bcf89"
    static let fetchMovieDetailUrl = "http://omdbapi.com/?type=movie&apikey=649bcf89&i=tt3074536"
}
