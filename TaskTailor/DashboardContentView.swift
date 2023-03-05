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

    var body: some View {
        VStack {
            Text("This is a modal view for : \(taskSize.text)")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.red)
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
