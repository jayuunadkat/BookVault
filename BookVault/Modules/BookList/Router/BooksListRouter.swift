//
//  BooksListRouter.swift
//  BookVault
//
//  Created by Jaymeen Unadkat on 10/04/25.
//

import SwiftUI

public protocol BooksListRouterProtocol {
    static func createModule() -> AnyView
}

final class BooksListRouter: BooksListRouterProtocol {
    static func createModule() -> AnyView {
        let dataManager: BookRemoteDataManagerProtocol = BookRemoteDataManager()
        let interactor: BookListInteractorProtocol = BookListInteractor(remote: dataManager)
        let presenter = BookListPresenter(interactor: interactor)
        return AnyView(BooksView(presenter: presenter))
    }
}
