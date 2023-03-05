//
//  TaskTailorApp.swift
//  TaskTailor
//
//  Created by Ross Chea on 2023-03-03.
//

import SwiftUI

@main
struct TaskTailorApp: App {
    var body: some Scene {
        WindowGroup {
            DashboardContentView()
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
