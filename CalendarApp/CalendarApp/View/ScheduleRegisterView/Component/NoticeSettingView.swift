//
//  NoticeSettingView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/06.
//

import SwiftUI

struct NoticeSettingView: View {
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @State private var isSwitchOn = true
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // ToDo2023/8/14 通知処理実装
                Toggle("通知", isOn: $isSwitchOn)
                    .font(.system(size: geometry.size.width / 25))
                    .padding(.horizontal, geometry.size.width / 5)
                    .onChange(of: isSwitchOn) { newValue in
                        scheduleDetailViewModel.isNotice = newValue
                    }
                    .offset(x:0, y:0)
            }
        }
    }
}
