//
//  SelectIdealScheduleTitle.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/21.
//

import SwiftUI

struct SelectIdealScheduleTitle: View {
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    
    var body: some View {
        HStack {
            Text(scheduleDetailViewModel.idealScheduleTitle)
                .frame(width: screenSizeObject.screenSize.width / 8, height: screenSizeObject.screenSize.height / 10)
                .font(.system(size: screenSizeObject.screenSize.width / 25))
                .offset(x: 0, y: screenSizeObject.screenSize.height / 10 + 30)
        }
        .onAppear{
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            screenSizeObject.screenSize = window.bounds.size
        }
    }
}
