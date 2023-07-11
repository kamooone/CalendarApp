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
                
                // ToDo コードを分割させたい
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
            }
            .padding(.bottom, -8)
            .offset(x: 0, y: -70)
        }
        
        // ToDo スケジュール詳細をセルに表示させる
        ForEach(0..<6, id: \.self) { week in
            ZStack {
                HStack(spacing: 0) {
                    ForEach(1..<8, id: \.self) { i in
                        if !(1..<calendarViewModel.numDaysMonth + 1).contains(i + week*7 - calendarViewModel.firstDayWeek.rawValue) {
                            Text("")
                                .frame(width: 50, height: 80)
                        } else {
                            // ToDo 表示させる文字は一つの詳細スケジュールにつき6文字まで、二つ目以降は改行して代入して、一つのStringにする
                            Text("テストテスト\nテストテスト\nテストテスト\nテストテスト\nテストテスト\nテストテスト")
                                .font(.system(size: 7))
                                .frame(width: 50, height: 80)
                                .foregroundColor(Color.black) // ToDo 大事な予定には色を付けれるようにすればいいかも
                                .offset(x: 0, y: -470)
                        }
                    }
                }
            }
            .padding(.bottom, -8)
            .offset(x: 0, y: -70)
        }
        
    }
}
