//
//  IdealNoticeSettingView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/20.
//

import SwiftUI

struct IdealNoticeSettingView: View {
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @State private var isSwitchOn = true
    
    var body: some View {
        VStack {
            Toggle("通知", isOn: $isSwitchOn)
                .font(.system(size: screenSizeObject.screenSize.width / 25))
                .padding(.horizontal, screenSizeObject.screenSize.width / 5)
                .onChange(of: isSwitchOn) { newValue in
                    scheduleDetailViewModel.idealIsNotice = newValue
                }
                .offset(x:0, y:0)
        }
        .onAppear{
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            screenSizeObject.screenSize = window.bounds.size
        }
    }
}
