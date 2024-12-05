// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

public enum NetworkError: Error, LocalizedError {
    case invalidURL
    case httpResponseError
    case statusCodeError(statusCode: Int)
    case noData
    case decodeError(error: Error)
    case encodingError
    case unknownError

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The URL provided is invalid."
        case .httpResponseError:
            return "The server response could not be processed."
        case .statusCodeError(let statusCode):
            return "Request failed with status code: \(statusCode)."
        case .noData:
            return "No data was returned from the server."
        case .decodeError(let error):
            return "Failed to decode the response: \(error.localizedDescription)."
        case .encodingError:
            return "Failed to encode the request body."
        case .unknownError:
            return "An unknown error occurred."
        }
    }
}

public final class NetworkService: NetworkServiceProtocol {
    public init() {}

    @available(iOS 15, macOS 12.0, *)
    public func fetchData<T: Codable>(urlString: String, headers: [String: String]? = nil) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        if let headers = headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        if let rawJSON = String(data: data, encoding: .utf8) {
            print("Raw JSON Response: \(rawJSON)")
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.httpResponseError
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.statusCodeError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodeError(error: error)
        }
    }

    @available(iOS 15, macOS 12.0, *)
    public func postData<T: Codable>(urlString: String, body: [String: Any], headers: [String: String]? = nil) async throws -> T {
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let headers = headers {
            for (key, value) in headers {
                urlRequest.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            throw NetworkError.encodingError
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.httpResponseError
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkError.statusCodeError(statusCode: httpResponse.statusCode)
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decodedData = try decoder.decode(T.self, from: data)
            return decodedData
        } catch {
            throw NetworkError.decodeError(error: error)
        }
    }
}
