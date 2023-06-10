//
//  DaysWeekView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/08.
//

import SwiftUI

struct DaysWeekView: View {
    let calendarViewModel = CalendarViewModel.shared
    let dayofweek = ["日", "月", "火", "水", "木", "金", "土"]
    let cornerRadius: CGFloat = 5
    
    var body: some View {
        ForEach(self.dayofweek, id: \.self) { day in
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .frame(width: 50, height: 40)
                    .foregroundColor(Color.clear) // 曜日のテキストの背景色を指定するときに使う
                    .offset(x: -3, y: -60)
                
                HStack {
                    Spacer().frame(width: 20)
                    Text(day)
                        .font(.system(size: 16))
                        .foregroundColor(day == "土" ? Color.blue : (day == "日" ? Color.red : Color.black))
                        .offset(x: -3, y: -60)
                    Spacer().frame(width: 13)
                }
            }
        }
    }
}
