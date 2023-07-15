//
//  SwiftUIView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/08.
//

import SwiftUI

struct YearMonthView: View {
    @Binding var isShouldReloadView: Int
    let calendarViewModel = CalendarViewModel.shared
    
    var body: some View {
        Button(action: {
            isShouldReloadView += 1
            calendarViewModel.selectMonth -= 1
            if calendarViewModel.selectMonth == 0 {
                calendarViewModel.selectMonth = 12
                calendarViewModel.selectYear -= 1
            }
            calendarViewModel.bindViewModel()
        }){
            Text("◀︎")
                .font(.system(size: 20))
        }
        .offset(x: 0, y: -50)
        .disabled(calendarViewModel.isSelectMonthSwitchButton)
        
        Text("\(String(calendarViewModel.selectYear))年\(calendarViewModel.selectMonth)月")
            .font(.system(size: 20))
            .offset(x: 0, y: -50)
        
        Button(action: {
            isShouldReloadView += 1
            calendarViewModel.selectMonth += 1
            if calendarViewModel.selectMonth == 13 {
                calendarViewModel.selectMonth = 1
                calendarViewModel.selectYear += 1
            }
            calendarViewModel.bindViewModel()
        }){
            Text("▶︎")
                .font(.system(size: 20))
        }
        .offset(x: 0, y: -50)
        .disabled(calendarViewModel.isSelectMonthSwitchButton)
    }
}
