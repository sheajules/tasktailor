//
//  TaskModels.swift
//  TaskTailor
//
//  Created by Ross Chea on 2023-03-05.
//

import SwiftUI

enum ColorPalette: String {
    case darkJungleGreen
    case myrtleGreen
    case peachCrayola
    case wintergreenDream
    case redPigment
}

extension Color {
    init(_ colorPalette: ColorPalette) {
        self.init(colorPalette.rawValue)
    }
}

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

    var color: some View {
        switch self {
            case .small:
                return Color(.wintergreenDream)
            case .medium:
                return Color(.myrtleGreen)
            case .large:
                return Color(.darkJungleGreen)
        }
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

