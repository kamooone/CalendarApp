//
//  InquiryButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI

struct InquiryButtonView: View {
    
    var body: some View  {
        Button(action: {
            // ToDo メール送信画面を立ち上げる
        }) {
            Text("開発者へ問い合わせ")
                .frame(width: 300, height: 30)
        }
        .offset(x: 0, y: -50)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding()
    }
}
