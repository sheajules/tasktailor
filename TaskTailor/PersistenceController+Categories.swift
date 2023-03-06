//
//  PersistenceController+Categories.swift
//  TaskTailor
//
//  Created by Ross Chea on 2023-03-05.
//

import CoreData

enum DBItem {
    case category, subject, task

    enum Err: Error {
        case noObjectsFound
    }
}

extension PersistenceController {
    func setupDefaultCategories() {
        let viewContext = container.viewContext

        let fetchedObjs = fetchedCategoryObjects()
        if !fetchedObjs.isEmpty {
            debugPrint("All categories added already: \(fetchedObjs)")
            return
        }

        CategorySection.allTitles.forEach {
            let cat = CategoryEntity(context: viewContext)
            cat.title = $0
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }

    func fetchedCategoryObjects(withProperty prop: String = "", likePredicate str: String = "") -> [CategoryEntity] {
        let viewContext = container.viewContext
        // categories
        let fetchRequest = CategoryEntity.fetchRequest()

        if !prop.isEmpty, !str.isEmpty {
            fetchRequest.predicate = NSPredicate(
                format: "\(prop) LIKE %@", str
            )
        }

        do {
            let fetchedObjects = try viewContext.fetch(fetchRequest)
            guard fetchedObjects.isEmpty else {
                return fetchedObjects
            }
        } catch {
            debugPrint("Failed to fetch category objects")
        }
        return []
    }

    func addProject(_ cat: CategoryEntity, projectTitle: String) {
        let project = ProjectEntity(context: container.viewContext)
        project.title = projectTitle
        cat.addToProjects(project)

        do {
            try container.viewContext.save()
        } catch {
            let nsError = error as NSError
            debugPrint("Failed to save Project with error \(nsError), \(nsError.userInfo)")
        }
    }

    func addTaskToProject(_ projectEntity: ProjectEntity, taskTitle: String) {
        let task = TaskEntity(context: container.viewContext)
        task.title = taskTitle
        projectEntity.addToTasks(task)

        do {
            try container.viewContext.save()
        } catch {
            let nsError = error as NSError
            debugPrint("Failed to save task with error \(nsError), \(nsError.userInfo)")
        }
    }
}


extension CategoryEntity {

    var unwrappedTitle: String {
        self.title ?? ""
    }

    var unwrappedProjectEntities: [ProjectEntity] {
        self.projects?.allObjects as? [ProjectEntity] ?? []
    }
}

extension ProjectEntity {

    var unwrappedTitle: String {
        self.title ?? ""
    }

    var unwrappedCategoryTitle: String {
        self.category?.title ?? ""
    }

    var unwrappedTaskEntities: [TaskEntity] {
        self.tasks?.allObjects as? [TaskEntity] ?? []
    }
}

extension TaskEntity {

    var unwrappedTitle: String {
        self.title ?? ""
    }

    var unwrappedProjectTitle: String {
        self.project?.title ?? ""
    }

//    var unwrappedTaskEntities: [TaskEntity] {
//        self.tasks?.allObjects as? [TaskEntity] ?? []
//    }
}
