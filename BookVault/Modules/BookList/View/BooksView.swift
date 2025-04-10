//
//  BooksView.swift
//  BookVault
//
//  Created by Jaymeen Unadkat on 10/04/25.
//

import SwiftUI

struct BooksView: View {
    @StateObject var presenter: BookListPresenter

    @State var selectedBook: Book = .mockBook
    @State var moveToDetails: Bool = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    booksList
                        .padding(.top, 8)

                    if presenter.isLoading && !presenter.books.isEmpty {
                        ProgressView()
                            .frame(width: 20, height: 20, alignment: .center)
                            .padding(.top, 4)
                    }
                }
            }
            .task {
                await presenter.loadBooks()
            }
            .navigationTitle(Text("Books"))
            .background(.secondary.opacity(0.2))
            .scrollIndicators(.hidden)
            .navigationDestination(isPresented: $moveToDetails) {
                BookDetailsView(book: selectedBook)
            }
        }
    }

    private var booksList: some View {
        VStack {
            BooksListView(books: $presenter.books) { book in
                self.selectedBook = book
                self.moveToDetails = true
            } loadMore: { index in
                Task {
                    await presenter.loadBooks(at: index)
                }
            }
        }
    }

}

#Preview {
    BooksView(presenter: BookListPresenter())
}
