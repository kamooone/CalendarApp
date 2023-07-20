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
            route.path = .IdealScheduleEnterTitle
        }) {
            Text("理想のスケジュール")
                .frame(width: 300, height: 30)
        }
        .offset(x: 0, y: -50)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding()
    }
}
