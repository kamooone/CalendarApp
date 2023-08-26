//
//  IdealScheduleTitleView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/20.
//

import SwiftUI

struct IdealScheduleTitleView: View {
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    let headerTitle: String = "理想のスケジュール"
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @State private var isShouldReloadView: Int = 0
    
    func bindViewModel() {
        scheduleDetailViewModel.isIdealScheduleUpdate = false
        
        scheduleDetailViewModel.idealScheduleTitle = ""
        scheduleDetailViewModel.idealScheduleDetailTitle = ""
        scheduleDetailViewModel.idealStartTime = "00:00"
        scheduleDetailViewModel.idealEndTime = "00:00"
        scheduleDetailViewModel.idealIsNotice = true
        
        scheduleDetailViewModel.idealScheduleTitleArray = []
        scheduleDetailViewModel.idealScheduleDetailTitleArray = []
        scheduleDetailViewModel.idealStartTimeArray = []
        scheduleDetailViewModel.idealEndTimeArray = []
        scheduleDetailViewModel.idealIsNoticeArray = []
    }
    
    var body: some View {
        Color.lightGray.edgesIgnoringSafeArea(.all)
        VStack {
            HStack {
                BackButtonView()
                    .offset(x:0, y:0)
            }
            HStack {
                HeaderView(_headerTitle: headerTitle)
                    .offset(x:0, y:screenSizeObject.screenSize.height / 30 - 10)
            }
            HStack {
                IdealRegistScheduleTitleView(isShouldReloadView: $isShouldReloadView)
            }
            HStack {
                IdealRegisteredScheduleTitleView()
                    .offset(x:0, y:0)
            }
            HStack {
                BannerAdsView()
                    .frame(width: screenSizeObject.screenSize.width, height: screenSizeObject.screenSize.height * 0.1)
                    .background(Color.yellow)
                    .offset(x: 0, y: 0)
            }
            Spacer()
        }
        .id(isShouldReloadView)
        .onAppear{
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            screenSizeObject.screenSize = window.bounds.size
            bindViewModel()
        }
    }
}
