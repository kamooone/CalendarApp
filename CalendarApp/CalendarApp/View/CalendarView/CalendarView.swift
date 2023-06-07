//
//  CalendarView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/05/28.
//

import SwiftUI

struct CalendarView: View {
    let calendarViewModel = CalendarViewModel.shared
    let headerTitle: String = "スケジュール登録"
    
    // ToDo カレンダーの表示の修正をする
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
                YearMonthView()
            }
            
            HStack() {
                DaysWeekView()
            }
            CalendarCellView()
        }
        .onAppear {
            calendarViewModel.bindViewModel()
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
