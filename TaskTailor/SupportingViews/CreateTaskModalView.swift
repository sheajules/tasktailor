//
//  CreateTaskModalView.swift
//  TaskTailor
//
//  Created by Ross Chea on 2023-03-05.
//

import SwiftUI

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
}
