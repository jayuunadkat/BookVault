//
//  BookVaultApp.swift
//  BookVault
//
//  Created by Jaymeen Unadkat on 10/04/25.
//

import SwiftUI

@main
struct BookVaultApp: App {
    @State private var showLoader: Bool = false

    var body: some Scene {
        WindowGroup {
            BooksListRouter.createModule()
                .onReceive(NotificationCenter.default.publisher(for: .showLoader)) { result in
                    if let loaderData = result.object as? [Any], let showLoader = loaderData.first as? Bool {
                        self.showLoader = showLoader
                    }
                }
                .activityIndicator(show: self.showLoader)
        }

    }
}
