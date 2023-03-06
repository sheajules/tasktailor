//
//  TaskTailorApp.swift
//  TaskTailor
//
//  Created by Ross Chea on 2023-03-03.
//

import SwiftUI

@main
struct TaskTailorApp: App {
    @ObservedObject var categoryTaskService: CategoryTaskService = CategoryTaskService()
    var body: some Scene {
        WindowGroup {
            DashboardContentView()
                .onAppear {
                    categoryTaskService.createDefaultCategories()
                }
                .environmentObject(categoryTaskService)
        }
    }
}
