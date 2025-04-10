//
//  ListBooksModel.swift
//  BookVault
//
//  Created by Jaymeen Unadkat on 10/04/25.
//

import Foundation

// MARK: - ListBooksModel
struct ListBooksModel: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Book]
}

// MARK: - Result
struct Book: Codable, Hashable {
    let id: Int
    let title: String
    let authors: [Person]
    let summaries: [String]
    let translators: [Person]
    let subjects, bookshelves: [String]
    let languages: [Language]
    let copyright: Bool
    let mediaType: MediaType
    let formats: Formats
    let downloadCount: Int

    enum CodingKeys: String, CodingKey {
        case id, title, authors, summaries, translators, subjects, bookshelves, languages, copyright
        case mediaType = "media_type"
        case formats
        case downloadCount = "download_count"
    }

    var authorNames: String {
        authors.map(\.name).joined(separator: ", ")
    }
}

// MARK: - Person
struct Person: Codable, Hashable {
    let name: String
    let birthYear, deathYear: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case birthYear = "birth_year"
        case deathYear = "death_year"
    }
}

// MARK: - Formats
struct Formats: Codable, Hashable {
    let textHTML, applicationEpubZip, applicationXMobipocketEbook: String
    let textPlainCharsetUsASCII: String
    let applicationRDFXML: String
    let imageJPEG: String
    let applicationOctetStream: String
    let textPlainCharsetUTF8: String?
    let textHTMLCharsetUTF8: String?
    let textPlainCharsetISO88591: String?
    let textHTMLCharsetISO88591: String?

    enum CodingKeys: String, CodingKey {
        case textHTML = "text/html"
        case applicationEpubZip = "application/epub+zip"
        case applicationXMobipocketEbook = "application/x-mobipocket-ebook"
        case textPlainCharsetUsASCII = "text/plain; charset=us-ascii"
        case applicationRDFXML = "application/rdf+xml"
        case imageJPEG = "image/jpeg"
        case applicationOctetStream = "application/octet-stream"
        case textPlainCharsetUTF8 = "text/plain; charset=utf-8"
        case textHTMLCharsetUTF8 = "text/html; charset=utf-8"
        case textPlainCharsetISO88591 = "text/plain; charset=iso-8859-1"
        case textHTMLCharsetISO88591 = "text/html; charset=iso-8859-1"
    }
}

enum Language: String, Codable {
    case en = "en"
}

enum MediaType: String, Codable {
    case text = "Text"
}

extension Book {
    static let mockBook = Book(
        id: 1342,
        title: "Pride and Prejudice",
        authors: [
            Person(name: "Austen, Jane", birthYear: 1775, deathYear: 1817)
        ],
        summaries: [
            "\"Simple Sabotage Field Manual\" by United States. Office of Strategic Services is a historical publication written during the early 1940s, amid World War II. This manual acts as a guide for ordinary civilians to conduct simple acts of sabotage against enemy operations without the need for specialized training or equipment. Its main topic revolves around promoting small, accessible forms of resistance that could collectively disrupt the enemy's war effort.  The manual outlines various strategies and techniques for citizens to engage in sabotage that could be executed discreetly and with minimal risk. It provides specific suggestions for targeting transportation, communication, and industrial facilities to create delays and inefficiencies in enemy operations. The manual emphasizes the power of many individuals acting independently to contribute to a larger campaign of disruption, encouraging simple acts such as misplacing tools, delaying communication, or damaging equipment with household items. Overall, the \"Simple Sabotage Field Manual\" serves as a unique historical artifact that illustrates grassroots resistance efforts and the belief in the collective power of ordinary people during wartime. (This is an automatically generated summary.)"
        ],
        translators: [],
        subjects: [
            "Love stories",
            "Courtship -- Fiction",
            "Young women -- Fiction"
        ],
        bookshelves: [
            "Best Books Ever Listings",
            "Harvard Classics"
        ],
        languages: [.en],
        copyright: false,
        mediaType: .text, /// Assuming .text is a case in your MediaType enum
        formats: Formats.mockFormats,
        downloadCount: 982345
    )
}

extension Formats {
    static let mockFormats = Formats(
        textHTML: "https://www.gutenberg.org/files/1342/1342-h/1342-h.htm",
        applicationEpubZip: "https://www.gutenberg.org/ebooks/1342.epub.images",
        applicationXMobipocketEbook: "https://www.gutenberg.org/ebooks/1342.mobi.images",
        textPlainCharsetUsASCII: "https://www.gutenberg.org/files/1342/1342-0.txt",
        applicationRDFXML: "",
        imageJPEG: "https://www.gutenberg.org/cache/epub/1342/pg1342.cover.medium.jpg",
        applicationOctetStream: "",
        textPlainCharsetUTF8: "https://www.gutenberg.org/files/1342/1342-0.txt",
        textHTMLCharsetUTF8: "https://www.gutenberg.org/files/1342/1342-h/1342-h.htm",
        textPlainCharsetISO88591: nil,
        textHTMLCharsetISO88591: nil
    )
}
