//
//  DashboardContentView.swift
//  TaskTailor
//
//  Created by Ross Chea on 2023-03-04.
//

import SwiftUI

struct DashboardContentView: View {

    enum TaskSize: String, CaseIterable {
        case small
        case medium
        case large

        var text: String {
            return "+ \(self.rawValue.capitalized) Task"
        }
    }

    @State private var isPresented = false
    @State private var seelctedType: TaskSize = .small

    var items: [DashboardContentView.TaskSize] = TaskSize.allCases

    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                Text(item.text)
                    .onTapGesture {
                        self.isPresented.toggle()
                        self.seelctedType = item
                    }
            }
        }
        .fullScreenCover(isPresented: $isPresented) {
            FullScreenModalView(taskSize: $seelctedType)
        }
    }
}

struct FullScreenModalView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var taskSize: DashboardContentView.TaskSize
    @State var taskTitle: String = ""
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

    @State var selectedTimeSize: DashboardContentView.TaskSize = .small
    @State var selectedCategory: String = ""

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
                }

                HStack {
                    Text("Length of task: ")
                    Spacer()
                }
                Picker("size", selection: $selectedTimeSize) {
                    ForEach(DashboardContentView.TaskSize.allCases, id: \.self) { item in
                        Text(item.rawValue)
                    }
                }
                .pickerStyle(.segmented)
                Picker("Category", selection: $selectedCategory) {
                    ForEach(categoryItems, id: \.self) { item in
                        Text(item)
                    }
                }

                Spacer()
                    .frame(height: 40)

                Section("Home") {
                    ForEach(items, id: \.self) { item in
                        Text(item)
                    }
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
