//
//  MiniGameButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI

struct MiniGameButtonView: View {
    
    var body: some View  {
        Button(action: {
            // ToDo 資金不足のため、Coming soon　というポップアップを表示させる

        }) {
            Text("ミニゲーム")
                .frame(width: 300, height: 30)
        }
        .offset(x: 0, y: -50)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding()
    }
}
