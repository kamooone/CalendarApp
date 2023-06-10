//
//  SwiftUIView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/08.
//

import SwiftUI

struct YearMonthView: View {
    @Binding var reloadView: Bool
    let calendarViewModel = CalendarViewModel.shared
    
    var body: some View {
        Button(action: {
            reloadView.toggle()
            // ToDo 月が1未満になったら12月になるようにして、年数を一つ下げる
            calendarViewModel.currentMonth -= 1
            calendarViewModel.bindViewModel()
        }){
            Text("◀︎")
                .font(.system(size: 20))
        }
        .offset(x: 0, y: -50)
        
        Text("\(String(calendarViewModel.selectYear))年\(calendarViewModel.selectMonth + calendarViewModel.currentMonth)月")
            .font(.system(size: 20))
            .offset(x: 0, y: -50)
        
        Button(action: {
            reloadView.toggle()
            // ToDo 月が12以上になったら1月になるようにして、年数を一つ上げる
            calendarViewModel.currentMonth += 1
            calendarViewModel.bindViewModel()
        }){
            Text("▶︎")
                .font(.system(size: 20))
        }
        .offset(x: 0, y: -50)
    }
}
