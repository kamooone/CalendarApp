//
//  ScheduleConfirmView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/05/31.
//

import SwiftUI

struct ScheduleConfirmView: View {
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
                        RegisterButtonView()
                    }
                    
                    ZStack {
                        LoadScheduleView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 130)
                    .background(Color.lightWhite)
                    .offset(x: 0, y: -100)
                    
                    
                    ZStack {
                        RegisterScheduleTitleView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: 160)
                    .background(Color.lightWhite)
                    .offset(x: 0, y: -90)
                    
                    
                    ZStack {
                        RegisterScheduleDetailView()
                        
                        RegisterScheduleTimeView()
                        
                        RegisterNoticeView()
                    }
                    .frame(width:geometry.size.width, height:250)
                    .background(Color.lightWhite)
                    .offset(x: 0, y: -80)
                    
                    
                    Spacer()
                }
                
                // ToDo 詳細を追加して行った時の表示の更新をどのようにするか
                
                BannerAdsView()
                Spacer()
            }
        }
    }
}

struct ScheduleConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleConfirmView()
    }
}
