//
//  CalendarCellView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/08.
//

import SwiftUI

struct CalendarCellView: View {
    @EnvironmentObject var route: RouteObserver
    let calendarViewModel = CalendarViewModel.shared
    
    var body: some View {
        //7*6のマスを表示する
        ForEach(0..<6, id: \.self) { week in
            ZStack {
                HStack(spacing: 0) {
                    ForEach(0..<7, id: \.self) { _ in
                        Rectangle()
                            .stroke(Color.black)
                            .frame(width: 50, height: 80)
                            .offset(x: 0, y: 0)
                    }
                }
                
                HStack(spacing: 0) {
                    ForEach(1..<8, id: \.self) { i in
                        if !(1..<calendarViewModel.numDaysMonth + 1).contains(i + week*7 - calendarViewModel.firstDayWeek.rawValue) {
                            Text("")
                                .frame(width: 50, height: 80)
                        } else {
                            Button(action: {
                                print("\(i+week*7 - calendarViewModel.firstDayWeek.rawValue)日をタップ")
                                
                                // ルートをスケジュール登録に変更して、選択したセルの月日を取得
                                route.path = .ScheduleConfirm
                                calendarViewModel.selectMonth = calendarViewModel.selectMonth + calendarViewModel.currentMonth
                                calendarViewModel.selectDay = i+week*7 - calendarViewModel.firstDayWeek.rawValue
                            }) {
                                Text("\(i + (week*7) - calendarViewModel.firstDayWeek.rawValue)")
                                    .frame(width: 50, height: 80)
                                    .foregroundColor((i+week*7) == 1 || (i+week*7) == 8 || (i+week*7) == 15 || (i+week*7) == 22 || (i+week*7) == 29 || (i+week*7) == 36 ? Color.red : ((i+week*7) == 7 || (i+week*7) == 14 || (i+week*7) == 21 || (i+week*7) == 28 || (i+week*7) == 35 ? Color.blue : Color.black))
                                    .offset(x: 0, y: -30)
                            }
                            .frame(width: 50, height: 80)
                            .offset(x: 0, y: 0)
                        }
                    }
                }
                
                // カレンダーのセルに文字を表示させる場合
                //                        HStack(spacing: 0) {
                //                            ForEach(1..<8, id: \.self) { i in
                //                                if ((i+week*7) - firstDayWeek.rawValue <= 0) {
                //                                    Text("")
                //                                        .frame(width: geometry.size.width / columns, height: geometry.size.height / rows)
                //                                } else if ((i+week*7) - firstDayWeek.rawValue > numDaysMonth) {
                //                                    Text("")
                //                                        .frame(width: geometry.size.width / columns, height: geometry.size.height / rows)
                //                                } else {
                //                                    Text("aaaa")
                //                                        .frame(width: geometry.size.width / columns, height: geometry.size.height / rows)
                //                                        .offset(x: 0, y: 10)
                //                                }
                //                            }
                //                        }
                
                
            }
            .padding(.bottom, -8)
            .offset(x: 0, y: -70)
        }
    }
}
