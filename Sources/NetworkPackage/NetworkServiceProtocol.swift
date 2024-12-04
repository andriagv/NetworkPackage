//
//  NetworkServiceProtocol.swift
//  NetworkPackage
//
//  Created by Apple on 12.11.24.
//


import Foundation

public protocol NetworkServiceProtocol {
    @available(iOS 15, macOS 12.0, *)
    func fetchData<T: Codable>(urlString: String, headers: [String: String]?) async throws -> T

    @available(iOS 15, macOS 12.0, *)
    func postData<T: Codable>(urlString: String, body: [String: Any], headers: [String: String]?) async throws -> T
}


