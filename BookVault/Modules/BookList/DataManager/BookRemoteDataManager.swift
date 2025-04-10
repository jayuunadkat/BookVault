//
//  BookRemoteDataManager.swift
//  BookVault
//
//  Created by Jaymeen Unadkat on 10/04/25.
//

import Foundation

protocol BookRemoteDataManagerProtocol {
    func fetchBooks(at page: Int) async throws -> ListBooksModel
}

final class BookRemoteDataManager: BookRemoteDataManagerProtocol {
    func fetchBooks(at page: Int) async throws -> ListBooksModel {
        let headers: [String: String] = [
            NetworkConstants.ApiHeaders.kContentType   : "application/json",
            "page": "\(page)"
        ]
        
        let urlString = NetworkConstants.shared.environment.serverBaseURL + APIEndPoints.getBooks.rawValue

        let applications = try await APIManager.shared.getApiRequest(
            manualHeaders: headers,
            urlString: urlString,
            type: ListBooksModel.self
        )

        return applications.response
    }
}
