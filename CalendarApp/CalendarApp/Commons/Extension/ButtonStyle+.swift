//
//  ButtonStyle+.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/05/31.
//

import Foundation
import SwiftUI

extension ButtonStyle {
    static func smallButtonStyle() -> some ButtonStyle {
        return SmallButtonStyle()
    }
}

struct SmallButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.primary)
            .padding(3)
            .background(Color.secondary.opacity(0.5))
            .cornerRadius(3)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}
