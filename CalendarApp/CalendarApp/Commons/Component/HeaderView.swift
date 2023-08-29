//
//  HeaderView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/06.
//

import SwiftUI

struct HeaderView: View {
    var _headerTitle: String

    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                Text(LocalizedStringKey(_headerTitle))
                    .font(.system(size: geometry.size.width / 20))
                    .fontWeight(.bold)
                Spacer()
            }
        }
    }
}
