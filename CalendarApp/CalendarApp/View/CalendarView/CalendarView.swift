//
//  CalendarView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/05/28.
//

import SwiftUI
import Firebase

// ToDo カレンダーの月切り替え処理のチラつきをなくす、スワイプで切り替えれるようにする
struct CalendarView: View {
    @State private var isShouldReloadView: Int = 0
    let calendarViewModel = CalendarViewModel.shared
    let noticeSettingViewModel = NoticeSettingViewModel.shared
    let headerTitle: String = "ScheduleManagementApp"
    
    init() {
        noticeSettingViewModel.noticeInit()
        
        calendarViewModel.bindViewModel()
        
        Analytics.logEvent(
            "トップ画面",
            parameters: [
                "地域と名前":"東京、東京太郎"
            ]
        )
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Spacer()
                    HamburgerView()
                }
                HStack() {
                    HeaderView(_headerTitle: headerTitle)
                }
                
                HStack() {
                    YearMonthView(isShouldReloadView: $isShouldReloadView)
                }
                
                HStack() {
                    CalendarCellView()
                }
                
                HStack() {
                    BannerAdsView()
                        .frame(width: geometry.size.width, height: geometry.size.height * 0.1)
                        .background(Color.yellow)
                }
                Spacer()
            }
        }
        .id(isShouldReloadView) // reloadViewの変更によってViewの再描画をトリガーする
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
