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
        Spacer()
        Text(_headerTitle)
            .font(.system(size: 24))
            .offset(x: 0, y: -60)
        Spacer()
    }
}
