//
//  SelectTaskModalView.swift
//  TaskTailor
//
//  Created by Ross Chea on 2023-03-05.
//

import SwiftUI

struct SelectTaskModalView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var categoryTaskService: CategoryTaskService
    @State var taskSize: TaskSize
    @State var taskTitle: String = ""
    @State var selectedCategory: String = "Wellness"
    @State var selectedProject: String = "Workouts"
    var items: [String] = [
        "Already existing",
        "Tasks",
        "Where do we go now?"
    ]

    // Per section
    @State var isOpened: Bool = true
    @State var newTaskTitle: String = ""
    @State var addNewRowBelow: Bool = false
    @State var selectedSort: String = "oldest"

    @State var projectMapToTaskInputData: [String: String] = [:]
    @State var projectMapToTaskInput: [String: Binding<String>] = [:]

    var sortBys: [String] = [
        "oldest",
        "newest",
        "a-z",
        "z-a",
        "priority"
    ]

//    var projectItems: [String] = [
//        "Workouts",
//        "Mediation"
//    ]

    var body: some View {
        ZStack {
            content
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Select a \(taskSize.rawValue) task")
                    .font(.headline)
                    .foregroundColor(.white)
            }
            ToolbarItem(placement: .navigationBarLeading) {
                Button("ⓧ") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.white)
            }
            ToolbarItemGroup(placement: .secondaryAction) {
                Button("About") {
                    print("About tapped!")
                }

                Button("Help") {
                    print("Help tapped!")
                }
            }

        }
        .toolbarBackground(taskSize.colorShape, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }

    func getTotalTimeForTasks(_ taskCount: Int, timeType: TaskSize) -> Int {
        timeType.minsForTask * taskCount
    }

    func getTotalTimeTextForTasks(_ taskCount: Int, timeType: TaskSize) -> String {
        switch timeType {
            case .small:
                return "< \(getTotalTimeForTasks(taskCount, timeType: .small))"
            case .medium:
                return "< \(getTotalTimeForTasks(taskCount, timeType: .medium))"
            case .large:
                return "~ \(getTotalTimeForTasks(taskCount, timeType: .large))"
        }
    }

    @ViewBuilder
    func getTaskViewFrom(cat: CategoryEntity, proj: ProjectEntity) -> some View {
        DisclosureGroup(isExpanded: $isOpened) {
            ForEach(categoryTaskService.tasks.filter { $0.unwrappedProjectTitle == proj.unwrappedTitle }) { task in
                Button {
                    debugPrint("Task selected: \(task.unwrappedTitle)")
                } label: {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.black)
                        Text(task.unwrappedTitle)
                            .foregroundColor(.black)
                    }
                }
                .listRowInsets(.init(top: 0, leading: -4, bottom: 0, trailing: 0))
            }
            Button {
                let inputTitle = binding(for: proj.unwrappedTitle).wrappedValue
                guard !inputTitle.isEmpty else {
                    return
                }
                categoryTaskService.createTask(categoryName: cat.unwrappedTitle, projectTitle: proj.unwrappedTitle, taskTitle: inputTitle)
                projectMapToTaskInputData[proj.unwrappedTitle] = ""
            } label: {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(Color(.systemGray5))
                    TextField("New \(taskSize.rawValue) task", text: binding(for: proj.unwrappedTitle))
                        .onTapGesture {
                            guard !newTaskTitle.isEmpty else {
                                debugPrint("Task input is empty.")
                                return
                            }
                            categoryTaskService.createTask(
                                categoryName: cat.unwrappedTitle,
                                projectTitle: proj.unwrappedTitle,
                                taskTitle: projectMapToTaskInput[proj.unwrappedTitle]!.wrappedValue
                            )
                        }
                }
            }
            .listRowInsets(.init(top: 0, leading: -4, bottom: 0, trailing: 0))
        } label: {
            HStack {
                Text(proj.unwrappedTitle)
            }
        }
//        .onAppear {
//            categoryTaskService.projects.forEach { proj in
//                projectMapToTaskInput[proj.unwrappedTitle] = Binding(
//                    get: {
//                        projectMapToTaskInputData[proj.unwrappedTitle] ?? ""
//                    }, set: {
//                        projectMapToTaskInputData[proj.unwrappedTitle] = $0
//                    }
//                )
//            }
//        }
    }

    private func binding(for key: String) -> Binding<String> {
        if !projectMapToTaskInputData.keys.contains(key) {
            projectMapToTaskInputData[key] = ""
        }

        return Binding(
            get: {
                return self.projectMapToTaskInputData[key] ?? ""
            }, set: {
                self.projectMapToTaskInputData[key] = $0
            }
        )
    }

    var content: some View {
        VStack {
            Text("Add a search feature")
            Text("Pill filter category at the top *here")
            List {
                ForEach(categoryTaskService.categories) { cat in
                    Section {
                        ForEach(categoryTaskService.projects.filter { $0.unwrappedCategoryTitle == cat.unwrappedTitle }) { proj in
                            getTaskViewFrom(cat: cat, proj: proj)
                        }
                    } header: {
                        HStack {
                            Text(cat.unwrappedTitle)
                            Spacer()
                            Picker("Sort", selection: $selectedSort) {
                                ForEach(sortBys, id: \.self) { sortBy in
                                    Text(sortBy)
                                        .foregroundColor(Color(.systemGray5))
                                }
                            }
                            .offset(x: 24)
                        }
                    } footer: {
                        // take the timeType and multiply it by count
                        Text("Estimated timeleft for tasks: \(getTotalTimeTextForTasks(items.count, timeType: taskSize)) mins")
                    }
                }

//                Section("Wellness") {
//                    ForEach(items, id: \.self) { item in
//                        Text(item)
//                    }
//                }
//                Section("Passion") {
//                    ForEach(items, id: \.self) { item in
//                        Text(item)
//                    }
//                }
//                Section("Social") {
//                    ForEach(items, id: \.self) { item in
//                        Text(item)
//                    }
//                }
            }
        }
        .padding()
    }
}
