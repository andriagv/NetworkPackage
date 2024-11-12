//
//  NetworkServiceProtocol.swift
//  NetworkPackage
//
//  Created by Apple on 12.11.24.
//


public protocol NetworkServiceProtocol {
    func fetchData<T: Codable>(
        urlString: String,
        completion: @escaping @Sendable (Result<T, NetworkError>) -> Void
    )
}