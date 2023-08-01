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
        GeometryReader { geometry in
            HStack {
                Spacer()
                Text("\(calendarViewModel.selectMonth)月\(calendarViewModel.selectDay)日")
                    .font(.system(size: geometry.size.width / 20))
                Spacer()
            }
        }
    }
}
