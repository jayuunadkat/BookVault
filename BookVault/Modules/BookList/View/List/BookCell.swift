//
//  BookCell.swift
//  BookVault
//
//  Created by Jaymeen Unadkat on 10/04/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct BookCell: View {
    @Binding var book: Book
    let onTap: () -> Void
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            cellHeaderView
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }

    private var cellHeaderView: some View {
        HStack(alignment: .top, spacing: 12) {
            WebImage(url: URL(string: book.formats.imageJPEG)) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: 50, height: 50, alignment: .trailing)
                    .cornerRadius(60)
                    .clipped()
            } placeholder: { }
            .indicator(.activity)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 0)
            VStack(alignment: .leading, spacing: 2) {

                Text(book.title)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                    .bold()
                    .foregroundColor(.primary)
                    .lineLimit(1)

                if let author = book.authors.first {
                    Text("Author: \(author.name)")
                        .font(.system(size: 12, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                }

                Text("Downloads: \(book.downloadCount)")
                    .font(.system(size: 12, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
            }

        }
        .padding(.horizontal, 12)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.background)
        .cornerRadius(12)
        .padding(.horizontal, 16)
    }
}

#Preview {
    VStack {
        BookCell(book: .constant(.mockBook)) {

        }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(.red.opacity(0.2))

}

