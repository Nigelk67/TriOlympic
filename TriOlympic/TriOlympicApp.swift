//
//  TriOlympicApp.swift
//  TriOlympic
//
//  Created by Nigel Karan on 24.12.21.
//

import SwiftUI

@main
struct TriOlympicApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
