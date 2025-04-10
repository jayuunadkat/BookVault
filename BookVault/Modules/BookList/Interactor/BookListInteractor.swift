//
//  BookListInteractor.swift
//  BookVault
//
//  Created by Jaymeen Unadkat on 10/04/25.
//

import Foundation

protocol BookListInteractorProtocol: AnyObject {
    func loadBooks(for page: Int) async throws -> ListBooksModel
}

final class BookListInteractor: BookListInteractorProtocol {
    let bookRemoteDataManager: BookRemoteDataManagerProtocol

    init(remote: BookRemoteDataManagerProtocol = BookRemoteDataManager()) {
        self.bookRemoteDataManager = remote
    }

    func loadBooks(for page: Int) async throws -> ListBooksModel {
        try await bookRemoteDataManager.fetchBooks(at: page)
    }
}
