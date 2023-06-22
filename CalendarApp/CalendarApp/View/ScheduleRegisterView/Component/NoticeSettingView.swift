//
//  RegisterNoticeView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/06.
//

import SwiftUI

struct NoticeSettingView: View {
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @State private var isSwitchOn = true
    
    var body: some View {
        VStack {
            Toggle("通知", isOn: $isSwitchOn)
                .offset(x:0,y:60)
                .padding(.horizontal, 100)
                .onChange(of: isSwitchOn) { newValue in
                    scheduleDetailViewModel.isNotice = newValue
                }
        }
    }
}
