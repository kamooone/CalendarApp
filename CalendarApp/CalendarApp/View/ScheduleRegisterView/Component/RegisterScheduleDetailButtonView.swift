//
//  RegisterScheduleDetailButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/11.
//

import SwiftUI
import RealmSwift

struct RegisterScheduleDetailButtonView: View {
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    
    var body: some View {
        
        Button(action: {
            scheduleDetailViewModel.registerScheduleDetail()
        }) {
            Text("登録")
                .frame(width: 50, height: 30)
        }
        .offset(x:0,y:105)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding()
    }
}
