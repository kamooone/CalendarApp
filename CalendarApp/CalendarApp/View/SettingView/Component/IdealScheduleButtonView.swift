//
//  IdealScheduleButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI

struct IdealScheduleButtonView: View {
    @EnvironmentObject var route: RouteObserver
    
    var body: some View  {
        Button(action: {
            route.path = .IdealSchedule
        }) {
            Text("理想のスケジュールを作成")
                .frame(width: 300, height: 30)
        }
        .offset(x: 0, y: -50)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding()
    }
}
