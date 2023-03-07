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
                .clipShape(Circle())
            Text("TU")
                .foregroundColor(Color(.systemGray3))
                .padding(4)
                .clipShape(Circle())
            Text("W")
                .foregroundColor(Color(.systemGray3))
                .padding(4)
                .clipShape(Circle())
            Text("TH")
                .foregroundColor(Color(.systemGray3))
                .padding(4)
                .background(.green.opacity(0.3))
                .clipShape(Circle())
            Text("SA")
                .foregroundColor(Color(.systemGray3))
                .padding(4)
                .clipShape(Circle())
            Text("SU")
                .foregroundColor(Color(.systemGray3))
                .padding(4)
                .background(.green.opacity(0.3))
                .clipShape(Circle())
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
    @State var enableProjectCreation: Bool = false


    @ViewBuilder
    func createCheckboxView(_ title: String, taskSize: TaskSize) -> some View {
        Button {
            toggleCheckbox.toggle()
        } label: {
            HStack {
                Image(systemName: toggleCheckbox ? "checkmark.square.fill" : "square")
                    .foregroundColor(.white)
                Text(title)
                    .foregroundColor(.white)
                Spacer()
                Text("\(taskSize.rawValue.first?.uppercased() ?? "")")
                    .padding(8)
                    .background(.white.opacity(0.5))
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .padding(.trailing, 8)
            }
        }
        .padding(.top, 4)
    }

    @ViewBuilder
    func createCompletedCheckboxView(_ title: String) -> some View {
        Button {
            toggleCheckbox.toggle()
        } label: {
            HStack {
                Image(systemName: "checkmark.square.fill")
                    .foregroundColor(.white)
                Text(title)
                    .foregroundColor(.white)
                Spacer()
                Text("S")
                    .padding(8)
                    .background(.white.opacity(0.5))
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .padding(.trailing, 8)
            }
        }
        .padding(.top, 4)
    }

    @State var isExpanded: Bool = true
    @State var isCompletedExpanded: Bool = false

    @ViewBuilder
    func createAddTaskButton(_ taskSize: TaskSize, action: @escaping () -> Void) -> some View {
        Button {
            action()
        } label: {
            HStack {
                Image(systemName: "plus.circle")
                    .foregroundColor(taskSize.color as? Color)
                Text("Tap to add a \(taskSize.rawValue) task")
                    .foregroundColor(taskSize.color as? Color)
                Spacer()
                Text("\(taskSize.rawValue.first?.uppercased() ?? "")")
                    .padding(8)
                    .background(.white.opacity(0.5))
                    .foregroundColor(taskSize.color as? Color)
                    .clipShape(Circle())
                    .padding(.trailing, 8)
            }
        }
        .padding(12)
        .padding(.horizontal, 8)
        .background(
            Rectangle()
                .strokeBorder(style: StrokeStyle(lineWidth: 2, dash: [8]))
                .foregroundColor(taskSize.color as? Color)
                .background(taskSize.color.opacity(0.5))
        )
        .padding(.vertical, 8)
        .cornerRadius(16)
    }


    @ViewBuilder
    var currentTasks: some View {
        DisclosureGroup(isExpanded: $isExpanded) {
            // create empty view & screens
            // TODO: Use real data
            createAddTaskButton(.small) {
                seelctedType = .small
            }
            .listRowInsets(.init(top: 0, leading: -12, bottom: 0, trailing: 8))
            createAddTaskButton(.medium) {
                seelctedType = .medium
            }
            .listRowInsets(.init(top: 0, leading: -12, bottom: 0, trailing: 8))
            createAddTaskButton(.large) {
                seelctedType = .large
            }
            .listRowInsets(.init(top: 0, leading: -12, bottom: 0, trailing: 8))

// TODO: Add inProgressAt date
//            ForEach(sampleTasks, id: \.self) {
//                createCheckboxView($0, taskSize: .small)
//                    .listRowBackground(Color(.wintergreenDream))
//                    .listRowInsets(.init(top: 0, leading: -4, bottom: 0, trailing: 0))
//            }
//            ForEach(sampleTasks, id: \.self) {
//                createCheckboxView($0, taskSize: .medium)
//                    .listRowBackground(TaskSize.medium.color)
//                    .listRowInsets(.init(top: 0, leading: -4, bottom: 0, trailing: 0))
//            }
//            ForEach(sampleTasks, id: \.self) {
//                createCheckboxView($0, taskSize: .large)
//                    .listRowBackground(TaskSize.large.color)
//                    .listRowInsets(.init(top: 0, leading: -4, bottom: 0, trailing: 0))
//            }
        } label: {
            Text("Today's tasks:")
                .font(.title2)
        }
        .foregroundColor(Color(.redPigment))
        .accentColor(Color(.redPigment))
    }

    var completedTasks: some View {
        DisclosureGroup(isExpanded: $isCompletedExpanded) {
            ForEach(sampleTasks, id: \.self) {
                createCompletedCheckboxView($0)
                    .listRowBackground(Color(.wintergreenDream).opacity(0.5))
            }
        } label: {
            HStack {
                Text("3")
                    .padding(8)
                    .foregroundColor(.white)
                    .background(.gray)
                    .clipShape(Circle())
                Text("Completed")
                Divider()
                Text("15 mins")
                    .padding(4)
                    .foregroundColor(.white)
                    .background(.gray)
                    .cornerRadius(12)
                Text("spent")
            }
        }
        .foregroundColor(Color(.peachCrayola))
        .accentColor(Color(.peachCrayola))
    }

    @ViewBuilder
    var trifectableView: some View {
        List {
            Text(Date.now, format: Date.FormatStyle(date: .complete, time: .omitted))
                .font(.title)
                .foregroundColor(Color(.systemGray2))
            HStack {
                ZStack {
                    Text("S")
                        .padding(8)
                        .background(TaskSize.small.color.opacity(0.1))
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .padding(.trailing, 8)
                    Image(systemName: "checkmark")
                        .resizable()
                        .foregroundColor(Color(.redPigment))
                        .frame(width: 24.0, height: 24.0)
                }
                Text("M")
                    .padding(8)
                    .background(TaskSize.medium.color.opacity(0.1))
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .padding(.trailing, 8)
                Text("L")
                    .padding(8)
                    .background(TaskSize.large.color.opacity(0.1))
                    .foregroundColor(.white)
                    .clipShape(Circle())
                    .padding(.trailing, 8)
                Text("Trifecta")
                    .foregroundColor(Color(.peachCrayola))
            }
            currentTasks
            completedTasks
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
        .background(Color(.peachCrayola))
        .scrollContentBackground(.hidden)

        Text("Complete the trifecta of tasks")
            .font(.subheadline)
            .foregroundColor(Color(.systemGray3))
    }

    @State private var isMenuOpened = false
    @State private var animationAmount: CGFloat = 0.0

    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 8) {
                    summaryView
                    trifectableView
                        .padding(.bottom, 36)
                }
                .fullScreenCover(item: $seelctedType) { item in
                    NavigationView {
                        SelectTaskModalView(taskSize: item)
                            .navigationBarTitleDisplayMode(.inline)
                    }
                    .accentColor(.white)
                }
                .fullScreenCover(isPresented: $enableProjectCreation, content: {
                    CreateProjectModalView()
                })
                .environmentObject(categoryTaskService)
                .navigationTitle("Overview")
                .navigationBarTitleDisplayMode(.inline)

                FloatingMenu(openValue: $animationAmount, isMenuOpen: $isMenuOpened) {
                    self.enableProjectCreation = true
                } showMenuLargeTaskClosure: {
                    self.seelctedType = .large
                } showMenuMediumTaskClosure: {
                    self.seelctedType = .medium
                } showMenuSmallTaskClosure: {
                    self.seelctedType = .small
                }
            }
        }
        .accentColor(.white)
    }
}
