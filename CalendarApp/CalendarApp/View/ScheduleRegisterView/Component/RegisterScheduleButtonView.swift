//
//  RegisterButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/06.
//

import SwiftUI

struct RegisterScheduleButtonView: View {
    var body: some View {
        Spacer()
        Button(action: {
            
        }) {
            Text("登録")
                .frame(width: 50, height: 35)
        }
        .offset(x:0,y:-110)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding() // ボタンの余白を調整
    }
}
