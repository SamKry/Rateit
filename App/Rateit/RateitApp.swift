//
//  RateitApp.swift
//  Rateit
//
//  Created by Samuel Kreyenbühl on 04.09.23.
//

import SwiftUI

@main
struct RateitApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
