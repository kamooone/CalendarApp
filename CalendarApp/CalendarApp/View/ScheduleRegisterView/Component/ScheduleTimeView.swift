//
//  ScheduleTimeView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/06.
//

import SwiftUI

struct ScheduleTimeView: View {
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @State private var selectedStartTime = 0
    @State private var selectedEndTime = 0
    
    init() {
        var array: [String] = []
        for hour in 0..<24 {
            /// strideは、数値の範囲を指定したステップ（増加量）で反復処理するためのSwiftの関数です。
            for minute in stride(from: 0, through: 45, by: 15) {
                let time = String(format: "%02d:%02d", hour, minute)
                array.append(time)
            }
        }
        scheduleDetailViewModel.timeArray = array
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                // ToDo 開始より終了の方が早い場合はエラーにする。
                Text("開始")
                    .frame(width: geometry.size.width / 8, height: geometry.size.height / 10)
                    .font(.system(size: geometry.size.width / 25))
                    .offset(x:0, y:20)
                
                Picker("Select an StartTIme", selection: $selectedStartTime) {
                    ForEach(0..<scheduleDetailViewModel.timeArray.count, id: \.self) { index in
                        Text(scheduleDetailViewModel.timeArray[index])
                    }
                }
                .frame(width: geometry.size.width / 4, height: geometry.size.height / 10)
                .pickerStyle(MenuPickerStyle())
                .onChange(of: selectedStartTime) { newValue in
                    scheduleDetailViewModel.startTime = scheduleDetailViewModel.timeArray[newValue]
                }
                .offset(x:0, y:20)
                
                Text("終了")
                    .frame(width: geometry.size.width / 8, height: geometry.size.height / 10)
                    .font(.system(size: geometry.size.width / 25))
                    .offset(x:0, y:20)
                
                Picker("Select an EndTime", selection: $selectedEndTime) {
                    ForEach(0..<scheduleDetailViewModel.timeArray.count, id: \.self) { index in
                        Text(scheduleDetailViewModel.timeArray[index])
                    }
                }
                .frame(width: geometry.size.width / 4, height: geometry.size.height / 10)
                .pickerStyle(MenuPickerStyle())
                .onChange(of: selectedEndTime) { newValue in
                    scheduleDetailViewModel.endTime = scheduleDetailViewModel.timeArray[newValue]
                }
                .offset(x:0, y:20)
                
                Spacer()
            }
        }
    }
}
