//
//  CharacterSwitchingButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI

struct CharacterSwitchingButtonView: View {
    
    var body: some View  {
        // ToDo ボタンではなく、ラジオボタンでキャラクター表示を変更させるやつをここに表示させる
        Button(action: {

        }) {
            Text("キャラクター変更")
                .frame(width: 300, height: 30)
        }
        .offset(x: 0, y: -50)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding()
    }
}
