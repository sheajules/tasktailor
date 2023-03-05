//
//  TaskModels.swift
//  TaskTailor
//
//  Created by Ross Chea on 2023-03-05.
//

import Foundation

enum TaskSize: String, CaseIterable {
    case small
    case medium
    case large

    var minsForTask: Int {
        switch self {
            case .small:
                return 5
            case .medium:
                return 15
            case .large:
                return 45
        }
    }

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
