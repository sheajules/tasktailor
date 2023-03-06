//
//  CategoryTaskService.swift
//  TaskTailor
//
//  Created by Ross Chea on 2023-03-05.
//

import SwiftUI

@MainActor
final class CategoryTaskService: ObservableObject {

    let persistencController = PersistenceController.shared

    init() {
        loadAllCategories()
    }

    @Published var categories: [CategoryEntity] = [] {
        didSet {
            projects = Array(
                categories
                    .compactMap {
                        $0.unwrappedProjectEntities
                    }.joined()
            )
        }
    }
    @Published var projects: [ProjectEntity] = [] {
        didSet {
            tasks = Array(
                projects
                    .compactMap {
                        $0.unwrappedTaskEntities
                    }.joined()
            )
        }
    }
    @Published var tasks: [TaskEntity] = [] {
        didSet {
            // Subtasks
        }
    }


    var categoryCases: [TaskSize] {
        TaskSize.allCases
    }

    var categoryTitles: [String] {
        categories.map {
            $0.title ?? ""
        }
    }

    // category > Projects > Tasks > Subtasks
    /// Category is the top level domain for tasks
    /// 1. Home, 2. Wellness, 3. Passion,  4. Social
    func createDefaultCategories() {
        persistencController.setupDefaultCategories()
    }

    func createProjectForCategory(_ categoryName: String, projectTitle: String) {
        guard let cat = categories.first(where: { $0.title == categoryName }) else {
            debugPrint("ERROR: category not found for \(categoryName)")
            return
        }
        persistencController.addProject(cat, projectTitle: projectTitle)
        loadAllCategories()
    }

    func createTask(categoryName: String, projectTitle: String, taskTitle: String) {
        guard let cat = categories.first(where: { $0.title == categoryName }) else {
            debugPrint("ERROR: category not found for \(categoryName)")
            return
        }
        guard let proj = cat.unwrappedProjectEntities.first(where: { $0.title == projectTitle }) else {
            debugPrint("ERROR: project not found for \(categoryName)")
            return
        }
        persistencController.addTaskToProject(proj, taskTitle: taskTitle)
        loadAllCategories()
    }

    func loadAllCategories() {
        categories = persistencController.fetchedCategoryObjects()
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
