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
    static func miniButtonStyle() -> some ButtonStyle {
        return MiniButtonStyle()
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

struct MiniButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.primary)
            .padding(-6)
            .background(Color.secondary.opacity(0.5))
            .cornerRadius(12)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}
