//
//  IdealScheduleTitleView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/20.
//

import SwiftUI

struct IdealScheduleTitleView: View {
    let headerTitle: String = "理想のスケジュール"
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    
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
        GeometryReader { geometry in
            VStack {
                HStack {
                    BackButtonView()
                }
                HStack {
                    HeaderView(_headerTitle: headerTitle)
                }
                VStack {
                    ZStack {
                        IdealRegistScheduleTitleView()
                    }
                    .frame(width: geometry.size.width, height: 180)
                    .background(Color.lightWhite)
                    .offset(x: 0, y: -50)
                }
                VStack {
                    ZStack {
                        IdealRegisteredScheduleTitleView()
                            .frame(width: geometry.size.width, height: 180)
                            .background(Color.lightWhite)
                            .offset(x: 0, y: -20)
                    }
                }
                VStack {
                    BannerAdsView()
                        .frame(width: geometry.size.width, height: 80)
                        .background(Color.yellow)
                        .offset(x: 0, y: 150)
                }
            }
        }
        .onAppear{
            bindViewModel()
        }
    }
}
