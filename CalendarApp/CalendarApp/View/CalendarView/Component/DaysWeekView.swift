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
        GeometryReader { geometry in
            ForEach(self.dayofweek, id: \.self) { day in
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .frame(width: geometry.size.width / calendarViewModel.columns, height: geometry.size.height / calendarViewModel.rows)
                        .foregroundColor(Color.clear) // 今のところは表示の必要がないため透明にする
                        .offset(x: -3, y: -30)
                    
                    HStack {
                        Spacer().frame(width: 20)
                        Text(day)
                            .font(.system(size: 16))
                            .foregroundColor(day == "土" ? Color.blue : (day == "日" ? Color.red : Color.black))
                            .offset(x: -3, y: -30)
                        Spacer().frame(width: 13)
                    }
                }
            }
        }
    }
}
