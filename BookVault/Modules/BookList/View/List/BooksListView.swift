//
//  BooksListView.swift
//  BookVault
//
//  Created by Jaymeen Unadkat on 10/04/25.
//

import SwiftUI

struct BooksListView: View {
    @Binding var books: [Book]
    let onTap: (_ book: Book) -> Void
    let loadMore: (_ index: Int) -> ()
    var body: some View {
        LazyVStack(alignment: .leading, spacing: 12) {
            ForEach(0..<books.count, id: \.self) { index in
                BookCell(book: $books[index]) {
                    onTap(books[index])
                }
                .onTapGesture {
                    onTap(books[index])
                }
                .onAppear {
                    loadMore(index)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

}

#Preview {
    BooksListView(books: .constant([])) { book in

    } loadMore: { index in

    }
}
