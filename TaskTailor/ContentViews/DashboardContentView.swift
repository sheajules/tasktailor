//
//  DashboardContentView.swift
//  TaskTailor
//
//  Created by Ross Chea on 2023-03-04.
//

import SwiftUI

struct DashboardContentView: View {
    @ObservedObject var categoryTaskService: CategoryTaskService = CategoryTaskService()
    @State private var seelctedType: TaskSize?

    var items: [TaskSize] = []

    init() {
        items = categoryTaskService.categoryCases
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemGray3]
        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.systemGray3]

    }

    @ViewBuilder
    var summaryView: some View {
        HStack(spacing: 8) {
            Text("M")
                .foregroundColor(Color(.systemGray3))
                .padding(4)
                .background(.green.opacity(0.3))
                .cornerRadius(12)
            Text("TU")
                .foregroundColor(Color(.systemGray3))
                .padding(4)
                .cornerRadius(12)
            Text("W")
                .foregroundColor(Color(.systemGray3))
                .padding(4)
                .cornerRadius(12)
            Text("TH")
                .foregroundColor(Color(.systemGray3))
                .padding(4)
                .background(.green.opacity(0.3))
                .cornerRadius(12)
            Text("SA")
                .foregroundColor(Color(.systemGray3))
                .padding(4)
                .cornerRadius(12)
            Text("SU")
                .foregroundColor(Color(.systemGray3))
                .padding(4)
                .background(.green.opacity(0.3))
                .cornerRadius(12)
        }
        Text("Steak: Week 3")
            .font(.subheadline)
            .foregroundColor(Color(.systemGray3))
        HStack {
            Text("Thursday's Best: 35 mins")
                .font(.subheadline)
                .foregroundColor(Color(.systemGray3))
            Text("Ave weekday: 23 mins")
                .font(.subheadline)
                .foregroundColor(Color(.systemGray3))
        }
    }

    @ViewBuilder
    func subjectHeader(taskCount: Int) -> some View {
        HStack {
            Text("\(taskCount)")
                .padding(4)
                .foregroundColor(.white)
                .background(.gray)
                .clipShape(Circle())
            Text("Incomplete")
            Divider()
            Text("0")
                .padding(4)
                .foregroundColor(.white)
                .background(.gray)
                .clipShape(Circle())
            Text("Completed")
        }
    }

    var sampleTasks: [String] = [
        "Clean bedroom",
        "Cook breakfast",
        "Draw"
    ]

    @State var toggleCheckbox: Bool = false

    @ViewBuilder
    func createCheckboxView(_ title: String) -> some View {
        Button {
            toggleCheckbox.toggle()
        } label: {
            HStack {
                Image(systemName: toggleCheckbox ? "checkmark.square.fill" : "square")
                Text(title)
                Spacer()
            }
        }
        .padding(.top, 4)
    }

    @ViewBuilder
    var trifectableView: some View {
        List {
            Text("Today's lineup")
                .font(.title)
                .foregroundColor(Color(.systemGray2))

            ForEach(items, id: \.self) { item in
                Section {

                    DisclosureGroup {
                        ForEach(sampleTasks, id: \.self) {
                            createCheckboxView($0)
                        }
                    } label: {
                        subjectHeader(taskCount: 0)
                    }

                    Text(item.text)
                        .listRowBackground(item.color)
                        .foregroundColor(Color(.white))
                        .onTapGesture {
                            self.seelctedType = item
                        }
                } header: {
                } footer: {
                    VStack {
                        Text("0 mins completed")
                            .font(.callout)
                    }
                }
            }
            HStack {
                Spacer()
                VStack(alignment: .trailing) {
                    HStack {
                        Text("Total completed: ")
                            .font(.caption2)
                            .foregroundColor(Color(.systemGray2))
                        Text("0 mins")
                            .font(.caption)
                            .foregroundColor(Color(.systemGray2))
                    }
                    HStack {
                        Text("Target time: ")
                            .font(.caption2)
                            .foregroundColor(Color(.systemGray3))
                        Text("65 mins")
                            .font(.caption2)
                            .foregroundColor(Color(.systemGray3))
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        Text("Complete the trifecta of tasks")
            .font(.subheadline)
            .foregroundColor(Color(.systemGray3))
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 8) {
                summaryView
                trifectableView
            }
            .fullScreenCover(item: $seelctedType) { item in
                NavigationView {
                    SelectTaskModalView(taskSize: item)
                        .navigationTitle("Select a \(item.rawValue) task")
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
            .environmentObject(categoryTaskService)
            .navigationTitle("Overview")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
