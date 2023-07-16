//
//  IdealScheduleButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI

struct IdealScheduleButtonView: View {
    
    var body: some View  {
        Button(action: {
            // ToDo 理想のスケジュール作成画面に遷移させる
        }) {
            Text("理想のスケジュールを作成")
                .frame(width: 300, height: 30)
        }
        .offset(x: 0, y: -50)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding()
    }
}
