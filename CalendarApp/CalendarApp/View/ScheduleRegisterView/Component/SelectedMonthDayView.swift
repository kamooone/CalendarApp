//
//  SelectedMonthDayView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/06.
//

import SwiftUI

struct SelectedMonthDayView: View {
    let calendarViewModel = CalendarViewModel.shared
    
    var body: some View {
        Text("\(calendarViewModel.selectMonth)月\(calendarViewModel.selectDay)日")
            .font(.system(size: 24))
            .offset(x: 0, y: -40)
    }
}
