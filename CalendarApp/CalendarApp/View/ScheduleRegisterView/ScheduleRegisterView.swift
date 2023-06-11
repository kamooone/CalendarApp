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
                }
                HStack {
                    HeaderView(_headerTitle: headerTitle)
                }
                VStack {
                    HStack {
                        SelectedMonthDayView()
                    }
                    
                    HStack {
                        RegisterScheduleButtonView()
                    }
                    
                    ZStack {
                        LoadScheduleView()
                    }
                    .frame(width: geometry.size.width, height: 80)
                    .background(Color.lightWhite)
                    .offset(x: 0, y: -100)
                    
                    
                    ZStack {
                        ScheduleTitleView()
                    }
                    .frame(width: geometry.size.width, height: 150)
                    .background(Color.lightWhite)
                    .offset(x: 0, y: -90)
    
                    
                    ZStack {
                        ScheduleDetailView()
                        
                        ScheduleTimeView()
                        
                        NoticeSettingView()
                        
                        HStack {
                            Spacer()
                            ConfirmScheduleDetailButtonView()
                                .offset(x:-30, y:0)
                            RegisterScheduleDetailButtonView()
                                .offset(x:30, y:0)
                            Spacer()
                        }

                    }
                    .frame(width:geometry.size.width, height:270)
                    .background(Color.lightWhite)
                    .offset(x: 0, y: -80)

                    Spacer()
                }
                
                BannerAdsView()
                    .frame(width: geometry.size.width, height: 80)
                    .background(Color.yellow)
                    .offset(x: 0, y: -70)
                
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
