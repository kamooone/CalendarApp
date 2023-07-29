//
//  CalendarView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/05/28.
//

import SwiftUI

struct CalendarView: View {
    @State private var isShouldReloadView: Int = 0
    let calendarViewModel = CalendarViewModel.shared
    let headerTitle: String = "スケジュール管理アプリ"
    
    init() {
        calendarViewModel.bindViewModel()
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
                    DaysWeekView()
                }
                
                HStack() {
                    CalendarCellView()
                }
                
                HStack() {
                    BannerAdsView()
                        .frame(width: geometry.size.width, height: 80)
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
