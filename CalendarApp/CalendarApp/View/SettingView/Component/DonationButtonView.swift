//
//  DonationButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI

struct DonationButtonView: View {
    
    var body: some View  {
        Button(action: {
            // ToDo 広告をいっぱい表示する画面に遷移させる
        }) {
            Text("開発者へお布施")
                .frame(width: 300, height: 30)
        }
        .offset(x: 0, y: -50)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding()
    }
}
