//
//  APIError.swift
//  
//
//  Created by Jaymeen Unadkat on 10/04/25.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case noInternet
    case serverError(String)
    case decodingError
    case unknown(String)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL."
        case .noInternet:
            return "No internet connection."
        case .serverError(let message):
            return "Server error: \(message)"
        case .decodingError:
            return "Failed to decode the response."
        case .unknown(let message):
            return "Unknown error: \(message)"
        }
    }
}
