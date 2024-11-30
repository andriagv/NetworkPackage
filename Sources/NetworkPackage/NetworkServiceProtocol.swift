//
//  NetworkServiceProtocol.swift
//  NetworkPackage
//
//  Created by Apple on 12.11.24.
//


@available(iOS 15, macOS 12.0, *)
public protocol NetworkServiceProtocol {
    func fetchData<T: Codable>(urlString: String, headers: [String: String]?) async throws -> T
}
