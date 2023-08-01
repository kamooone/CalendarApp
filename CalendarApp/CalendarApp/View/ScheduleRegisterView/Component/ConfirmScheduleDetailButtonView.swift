//
//  RegisterConfirmView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/11.
//

import SwiftUI

struct ConfirmScheduleDetailButtonView: View {
    @EnvironmentObject var route: RouteObserver
    
    var body: some View {
        
        Button(action: {
            route.path = .ConfirmScheduleDetail
        }) {
            Text("現在の追加状況を確認")
                .frame(width: 200, height: 30)
        }
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding() // ボタンの余白を調整
    }
}
