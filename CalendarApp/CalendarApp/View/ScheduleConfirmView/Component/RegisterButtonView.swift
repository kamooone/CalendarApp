//
//  RegisterButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/06.
//

import SwiftUI

struct RegisterButtonView: View {
    var body: some View {
        Button(action: {
            
        }) {
            Text("登録")
        }
        .offset(x:0,y:-110)
        .buttonStyle(SmallButtonStyle.smallButtonStyle())
        .padding() // ボタンの余白を調整
    }
}
