//
//  IdealNoticeSettingView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/20.
//

import SwiftUI

struct IdealNoticeSettingView: View {
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @State private var isSwitchOn = true
    
    var body: some View {
        VStack {
            Toggle("通知", isOn: $isSwitchOn)
                .offset(x:0,y:60)
                .padding(.horizontal, 100)
                .onChange(of: isSwitchOn) { newValue in
                    scheduleDetailViewModel.idealIsNotice = newValue
                }
        }
    }
}
