//
//  TaskTailorApp.swift
//  TaskTailor
//
//  Created by Ross Chea on 2023-03-03.
//

import SwiftUI

@main
struct TaskTailorApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
