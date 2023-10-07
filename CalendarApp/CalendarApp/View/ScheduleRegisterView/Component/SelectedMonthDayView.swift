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
                let localizedMonth = NSLocalizedString("Month", comment: "")
                let localizedDay = NSLocalizedString("Day", comment: "")

                let formattedText = String.localizedStringWithFormat("%d \(localizedMonth) %d \(localizedDay)", calendarViewModel.selectMonth, calendarViewModel.selectDay)

                Text(formattedText)
                    .font(.system(size: geometry.size.width / 20))
                Spacer()
            }
        }
    }
}
