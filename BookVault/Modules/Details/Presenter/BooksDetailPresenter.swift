//
//  BooksDetailPresenter.swift
//  BookVault
//
//  Created by Jaymeen Unadkat on 10/04/25.
//

import Foundation
import UIKit


class BooksDetailPresenter: ObservableObject {

    func downloadAndShareBook(bookname: String, url: String) async {
        guard let url = URL(string: url) else {
            return
        }

        Indicator.show()
        
        if let downloadedBookURL: URL = try? await downloadBook(bookname: bookname, from: url.absoluteString) {
            shareBook(at: downloadedBookURL)
        }

        Indicator.hide()
    }

    func downloadBook(bookname: String, from urlString: String) async throws -> URL {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (tempURL, _) = try await URLSession.shared.download(from: url)

        let fileExtension = url.pathExtension.isEmpty ? "txt" : url.pathExtension
        let destinationURL = FileManager.default.temporaryDirectory.appendingPathComponent("\(bookname).\(fileExtension)")

        if FileManager.default.fileExists(atPath: destinationURL.path) {
            try FileManager.default.removeItem(at: destinationURL)
        }

        try FileManager.default.moveItem(at: tempURL, to: destinationURL)
        return destinationURL
    }


    func shareBook(at fileURL: URL) {
        DispatchQueue.main.async {
            let activityVC = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
            if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let rootVC = scene.windows.first?.rootViewController {
                rootVC.present(activityVC, animated: true)
            }
        }
    }
}
