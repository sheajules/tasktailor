//
//  CreateProjectModalView.swift
//  TaskTailor
//
//  Created by Ross Chea on 2023-03-05.
//

import SwiftUI

struct CreateProjectModalView: View {
    @EnvironmentObject var categoryTaskService: CategoryTaskService
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var projectTitle: String = ""
    @State var selectedCategory: String = ""

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
                Section("Create new project") {
                    VStack {
                        HStack {
                            Text("Project Title: ")
                            Spacer()
                        }
                        TextField("Build a computer", text: $projectTitle)
                    }
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(categoryTaskService.categories.map { $0.unwrappedTitle }, id: \.self) { title in
                            Text(title)
                        }
                    }
                }
            }
            Button {
                guard !projectTitle.isEmpty else {
                    debugPrint("projectTitle needs to be filled in")
                    return
                }
                categoryTaskService.createProjectForCategory(selectedCategory, projectTitle: projectTitle)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Create Project")
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color(.redPigment))
            .cornerRadius(16)
        }
        .padding()
        .onAppear {
            self.selectedCategory = categoryTaskService.categories.first?.unwrappedTitle ?? ""
        }
    }
}
