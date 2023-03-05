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
                                        .foregroundColor(.black)
                                }
                            }
                            .listRowInsets(.init(top: 0, leading: -4, bottom: 0, trailing: 0))
                        }
                        Button {
                            debugPrint("Add new task")
                        } label: {
                            HStack {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(Color(.systemGray5))
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
                                    .foregroundColor(Color(.systemGray5))
                            }
                        }
                        .offset(x: 24)
                    }
                } footer: {
                    // take the timeType and multiply it by count
                    Text("Estimated timeleft for tasks: \(getTotalTimeTextForTasks(items.count, timeType: taskSize)) mins")
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
}
