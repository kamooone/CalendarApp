//
//  IdealConfirmScheduleDetailButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI

struct IdealConfirmScheduleDetailButtonView: View {
    @EnvironmentObject var route: RouteObserver
    
    var body: some View {
        
        Button(action: {
            route.path = .IdealConfirmScheduleDetail
        }) {
            Text("現在の追加状況を確認")
                .frame(width: 200, height: 30)
        }
        .offset(x:0,y:105)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding() // ボタンの余白を調整
    }
}
