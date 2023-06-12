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
            Text("確認")
                .frame(width: 50, height: 30)
        }
        .offset(x:0,y:105)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding() // ボタンの余白を調整
    }
}
