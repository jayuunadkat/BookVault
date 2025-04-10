//
//  BookListPresenter.swift
//  BookVault
//
//  Created by Jaymeen Unadkat on 10/04/25.
//

import Foundation

protocol BookListPresenterProtocol {
    func loadBooks(at index: Int) async
}

extension BookListPresenterProtocol {
    func loadBooks() async {
        await loadBooks(at: 0)
    }
}

final class BookListPresenter: ObservableObject, BookListPresenterProtocol {
    private let booksInteractor: BookListInteractorProtocol
    @Published var books: [Book] = []
    @Published var isLoading: Bool = false

    init(
        interactor: BookListInteractorProtocol = BookListInteractor()
    ) {
        self.booksInteractor = interactor
    }

    

    func loadBooks(at index: Int) async {
        guard books.isEmpty || index == books.count - 1 else { return }
        await startLoading()
        let page = books.isEmpty ? 1 : books.count / 10 + 1
        if page == 1 {
            Indicator.show()
        }
        do {
            let books = try await booksInteractor.loadBooks(for: page).results
            await booksFetched(for: page, books)
            Indicator.hide()
            await stopLoading()
        } catch {
            await stopLoading()
            Indicator.hide()
            print("Error while loading books: \(error.localizedDescription)")
        }
    }

    private func booksFetched(for page: Int, _ books: [Book]) async {
        await MainActor.run {
            if page == 1 {
                self.books = books
            } else {
                self.books.append(contentsOf: books)
            }
        }
    }

    private func startLoading() async {
        await MainActor.run {
            isLoading = true
        }
    }

    private func stopLoading() async {
        await MainActor.run {
            isLoading = false
        }
    }
}

