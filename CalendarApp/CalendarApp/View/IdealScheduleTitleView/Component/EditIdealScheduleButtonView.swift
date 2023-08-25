//
//  EditIdealScheduleButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/21.
//

import SwiftUI

struct EditIdealScheduleButtonView: View {
    @EnvironmentObject var route: RouteObserver
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    let _titleStr: String
    
    var body: some View  {
        Button(action: {
            scheduleDetailViewModel.idealScheduleTitle = _titleStr
            scheduleDetailViewModel.isIdealScheduleUpdate = true
            route.path = .IdealSchedule
        }) {
            Text("修正")
                .font(.system(size: 12))
                .frame(width: 60, height: 30)
        }
        .offset(x: 30, y: 0)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding()
    }
}
