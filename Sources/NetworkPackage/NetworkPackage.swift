// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

public enum NetworkError: Error {
    case invalidURL
    case statuscode
    case wrongRespose
    case decodeError(error: Error)
}

public final class NetworkService: NetworkServiceProtocol {
    
    public init() { }
    
    public func fetchData<T: Codable>(urlString: String, completion: @escaping @Sendable (Result<T, NetworkError>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            if let error {
                completion(.failure(.decodeError(error: error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.wrongRespose))
                print(response as Any)
                return
            }
            
            guard (200...299).contains(response.statusCode) else {
                completion(.failure(NetworkError.statuscode))
                return
            }
            
            guard let data else {
                completion(.failure(NetworkError.wrongRespose))
                return
            }
            
            do {
                let fetchedData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(fetchedData))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.decodeError(error: error)))
                }
            }
        }.resume()
    }
}
