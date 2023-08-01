//
//  ScheduleRegisterView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/05/31.
//

import SwiftUI

struct ScheduleRegisterView: View {
    let headerTitle: String = "スケジュール登録"
    
    var body: some View {
        Color.lightGray.edgesIgnoringSafeArea(.all)
        GeometryReader { geometry in
            VStack {
                HStack {
                    BackButtonView()
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height / 12)
                
                VStack {
                    HeaderView(_headerTitle: headerTitle)
                }
                .frame(width: geometry.size.width, height: geometry.size.height / 30)

                VStack {
                    SelectedMonthDayView()
                }
                .frame(width: geometry.size.width, height: geometry.size.height / 20)
                
                // ToDo 2023/8/2　ここから表示の最適化修正
                VStack {
                    LoadScheduleView()
                }
                .frame(width: geometry.size.width, height: geometry.size.height / 8)
                .background(Color.lightWhite)
                
                VStack {
                    ZStack {
                        ScheduleDetailView()
                        
                        ScheduleTimeView()
                        
                        NoticeSettingView()
                        
                        VStack {
                            ConfirmScheduleDetailButtonView()
                            RegisterScheduleDetailButtonView()
                        }
                    }
                    .frame(width:geometry.size.width, height:270)
                    .background(Color.lightWhite)

                    Spacer()
                }
                
                HStack {
                    BannerAdsView()
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.1)
                        .background(Color.yellow)
                }
                
                Spacer()
            }
        }
    }
}

struct ScheduleRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleRegisterView()
    }
}
