//
//  CategoryTaskService.swift
//  TaskTailor
//
//  Created by Ross Chea on 2023-03-05.
//

import SwiftUI

@MainActor
class CategoryTaskService: ObservableObject {

    var categoryCases: [TaskSize] {
        TaskSize.allCases
    }

    var categoryTitles: [String] {
        TaskSize.allCases.map { $0.text }
    }

    // category > Projects > Tasks > Subtasks
    /// Category is the top level domain for tasks
    /// 1. Home, 2. Wellness, 3. Passion,  4. Social
    func createCategory() {

    }

    func createProject() {

    }

    func createTask() {

    }

    func getCategory() {

    }

    func updateCategory() {

    }

    func deleteTask() {

    }

    func deleteProject() {

    }

    func editCategory() {

    }
}
