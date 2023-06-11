//
//  ButtonStyle+.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/05/31.
//

import Foundation
import SwiftUI

extension ButtonStyle {
    static func normalButtonStyle() -> some ButtonStyle {
        return NormalButtonStyle()
    }
}

struct NormalButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.primary)
            .padding(6)
            .background(Color.secondary.opacity(0.5))
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}
