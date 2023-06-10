//
//  CalendarView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/05/28.
//

import SwiftUI

struct CalendarView: View {
    @State private var shouldReloadView = false
    let calendarViewModel = CalendarViewModel.shared
    let headerTitle: String = "スケジュール登録"
    
    init() {
        calendarViewModel.bindViewModel()
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                HamburgerView()
            }
            HStack() {
                HeaderView(_headerTitle: headerTitle)
            }
            
            HStack() {
                YearMonthView(reloadView: $shouldReloadView)
            }
            
            HStack() {
                DaysWeekView()
            }
            CalendarCellView()
            
            Spacer()
        }
        .id(shouldReloadView) // reloadViewの変更によってViewの再描画をトリガーする
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
