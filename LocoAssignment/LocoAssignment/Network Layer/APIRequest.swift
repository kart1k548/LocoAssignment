import Foundation

///Singleton class responsible for handling all the api requests
class APIRequest {
    static var shared = APIRequest()

    private init() { }
    
    /// Handles the get api requests
    /// - Parameters:
    ///   - endpoint: has the URL Request
    ///   - completion: callback to be called once we recieve the response from the API
    func getAPIRequest<T: Decodable>(with endpoint: Endpoint, completion: @escaping (Result<T, MovieServiceError>)->Void) {
        guard let request = endpoint.request else { return }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(.unknown(error.localizedDescription)))
                    return
                }
                
                if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                    completion(.failure(.serverError("Server Error: \(response.statusCode)")))
                }
                
                if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        let responseData = try decoder.decode(T.self, from: data)
                        completion(.success(responseData))
                        
                    } catch {
                        completion(.failure(.decodingError("Decoding Error occured")))
                    }
                } else {
                    completion(.failure(.unknown("Unknown error occured")))
                }
        }.resume()
    }
}
