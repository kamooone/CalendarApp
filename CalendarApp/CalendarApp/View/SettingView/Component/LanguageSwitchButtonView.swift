//
//  LanguageSwitchButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI

struct LanguageSwitcButtonView: View {
    
    var body: some View  {
        // ToDo ボタンではなく、ラジオボタンで言語切り替えできるようにここに表示させる
        Button(action: {

        }) {
            Text("言語切り替え")
                .frame(width: 300, height: 30)
        }
        .offset(x: 0, y: -50)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding()
    }
}
