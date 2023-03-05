//
//  DashboardContentView.swift
//  TaskTailor
//
//  Created by Ross Chea on 2023-03-04.
//

import SwiftUI

enum TaskSize: String, CaseIterable {
    case small
    case medium
    case large

    var text: String {
        return "+ \(self.rawValue.capitalized) Task"
    }
}
extension TaskSize: Hashable, Identifiable {
    var id: Self { self }
    //    @MainActor
    //    nonisolated static var allCasesNonIsolated: [TaskSize] {
    //        get async throws  {
    //            await TaskSize.allCases
    //        }
    //    }
}



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

struct DashboardContentView: View {
    @ObservedObject var categoryTaskService: CategoryTaskService = CategoryTaskService()
    @State private var seelctedType: TaskSize?

    var items: [TaskSize] = []

    init() {
        items = categoryTaskService.categoryCases
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(items, id: \.self) { item in
                    Text(item.text)
                        .onTapGesture {
                            self.seelctedType = item
                        }
                }
            }
            .fullScreenCover(item: $seelctedType) { item in
                NavigationView {
                    FullScreenModalView(taskSize: item)
                        .navigationTitle("Select a \(item.rawValue) task")
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
            .environmentObject(categoryTaskService)
        }
    }
}

struct FullScreenModalView: View {
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

    var categoryItems: [String] = [
        "Home",
        "Wellness",
        "Social",
        "Passion"
    ]

    var projectItems: [String] = [
        "Workouts",
        "Mediation"
    ]

    var body: some View {
        ZStack {
            content
            VStack {
                Spacer()
                addTaskButton
                    .padding(.horizontal)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button("ⓧ") {
                    presentationMode.wrappedValue.dismiss()
                }
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
    }

    // Per section
    @State var isOpened: Bool = true
    @State var newTaskTitle: String = ""
    @State var addNewRowBelow: Bool = false
    @State var selectedSort: String = "oldest"
    var sortBys: [String] = [
        "oldest",
        "newest",
        "a-z",
        "z-a",
        "priority"
    ]

    var content: some View {
        VStack {
            List {
                Section {
                    DisclosureGroup(isExpanded: $isOpened) {
                        ForEach(items, id: \.self) { item in
                            Button {
                                debugPrint("Task selected: \(item)")
                            } label: {
                                HStack {
                                    Image(systemName: "plus.circle.fill")
                                    Text(item)
                                }
                            }
                            .listRowInsets(.init(top: 0, leading: -4, bottom: 0, trailing: 0))
                        }
                        Button {
                            debugPrint("Add new task")
                        } label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                TextField("New \(taskSize.rawValue) task", text: $newTaskTitle)
                                    .onTapGesture {
                                        addNewRowBelow = true
                                    }
                            }
                        }
                        .listRowInsets(.init(top: 0, leading: -4, bottom: 0, trailing: 0))
                    } label: {
                        HStack {
                            Text("Project X")
                        }
                    }
                } header: {
                    HStack {
                        Text("Home")
                        Spacer()
                        Picker("Sort", selection: $selectedSort) {
                            ForEach(sortBys, id: \.self) { sortBy in
                                Text(sortBy)
                            }
                        }
                    }
                } footer: {
                    // take the timeType and multiply it by count
                    Text("Estimated timeleft for tasks: < 15 mins")
                }
                Section("Wellness") {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                    }
                }
                Section("Passion") {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                    }
                }
                Section("Social") {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                    }
                }
            }
        }
        .padding()
    }

    var addTaskButton: some View {
        HStack {
            Spacer()
            Button {
                debugPrint("Do we need this button?")
            } label: {
                Text("Add task")
            }
            .padding()
            .background(.green)
            .cornerRadius(8)
            .padding(.bottom, 16)
        }
    }
}

struct CreateTaskModalView: View {
    @EnvironmentObject var categoryTaskService: CategoryTaskService
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var taskSize: TaskSize
    @State var taskTitle: String = ""
    @State var selectedCategory: String = "Wellness"
    @State var selectedProject: String = "Workouts"
    var items: [String] = [
        "Already existing",
        "Tasks",
        "Where do we go now?"
    ]

    var categoryItems: [String] = [
        "Home",
        "Wellness",
        "Social",
        "Passion"
    ]

    var projectItems: [String] = [
        "Workouts",
        "Mediation"
    ]

    var body: some View {

        ZStack {
            content
            VStack {
                Spacer()
                buttonOnTop
                    .padding(.horizontal)
            }

        }
    }

    var content: some View {
        VStack {
            HStack {
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Text("X")
                }
                .padding()
                .background(.gray)
                .cornerRadius(16)
                Spacer()
            }

            List {
                Section("Create new task") {
                    VStack {
                        HStack {
                            Text("Task Title: ")
                            Spacer()
                        }
                        TextField("+ Add new \(taskSize.rawValue.capitalized) task", text: $taskTitle)
                    }
                    HStack {
                        Text("Length of task: ")
                        Spacer()
                    }
                    Picker("time size", selection: $taskSize) {
                        ForEach(categoryTaskService.categoryCases, id: \.self) { item in
                            Text(item.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(categoryItems, id: \.self) { item in
                            Text(item)
                        }
                    }
                    Picker("Project", selection: $selectedProject) {
                        ForEach(projectItems, id: \.self) { item in
                            Text(item)
                        }
                    }
                }
            }

        }
        .padding()
    }

    var buttonOnTop: some View {
        HStack {
            Spacer()
            Button {
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Add task")
            }
            .padding()
            .background(.green)
            .cornerRadius(8)
            .padding(.bottom, 16)
        }
    }
}
