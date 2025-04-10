//
//  BookDetailsView.swift
//  BookVault
//
//  Created by Jaymeen Unadkat on 10/04/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookDetailsView: View {
    @Environment(\.dismiss) var dismiss

    @StateObject var presenter: BooksDetailPresenter = BooksDetailPresenter()
    var book: Book
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ScrollView {
                bookHeaderImage
                    .padding(.top, 8)
                booksDescriptionView
            }
        }
        .background(.secondary.opacity(0.2))
        .scrollIndicators(.hidden)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.black)
                        .bold()
                }
                .frame(height: 30)
            }

            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task {
                        await presenter.downloadAndShareBook(bookname: book.title, url: book.formats.applicationOctetStream)
                    }

                } label: {
                    Image(systemName: "square.and.arrow.down")
                        .foregroundStyle(.black)
                        .bold()
                }
                .frame(height: 30)
                .offset(y: -7)
            }
        }
    }

    private var bookHeaderImage: some View {
        VStack(alignment: .center, spacing: 16) {
            WebImage(url: URL(string: book.formats.imageJPEG)) { image in
                image.resizable()
                    .scaledToFit()
            } placeholder: { }
            .frame(height: UIScreen.main.bounds.height / 3)

            VStack(alignment: .center, spacing: 8) {
                Text(book.title)
                    .font(.system(size: 24, weight: .bold, design: .rounded))

                VStack {
                    Text("Authors: \(book.authorNames)")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)

                    Text("Downloads: \(book.downloadCount)")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                }
            }

        }
        .frame(maxWidth: .infinity, alignment: .center)
    }

    private var booksDescriptionView: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Summary")
                .font(.system(size: 24, weight: .bold, design: .rounded))

            ForEach(book.summaries, id: \.self) { summary in
                HStack(alignment: .top, spacing: 8) {
                    Text("⚫️")
                        .font(.system(size: 8, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                        .offset(y: 6)

                    Text("\(summary)")
                        .font(.system(size: 18, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                }

            }
                .font(.system(size: 24, weight: .medium, design: .rounded))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    NavigationView {
        BookDetailsView(book: .mockBook)
    }
}




