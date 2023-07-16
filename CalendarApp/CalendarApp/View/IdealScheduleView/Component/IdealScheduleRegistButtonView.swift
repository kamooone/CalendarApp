//
//  IdealScheduleRegistButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI

struct IdealScheduleRegistButtonView: View {
    
    var body: some View  {
        Button(action: {
        }) {
            Text("理想のスケジュールを登録")
                .frame(width: 200, height: 30)
        }
        .offset(x: 0, y: 0)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding()
    }
}
