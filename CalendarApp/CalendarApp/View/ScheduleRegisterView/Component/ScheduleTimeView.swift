//
//  RegisterScheduleTimeView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/06.
//

import SwiftUI

struct ScheduleTimeView: View {
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @State private var selectedStartTime = 0
    @State private var selectedEndTime = 0
    var timeArray: [String] = []
    
    init() {
        var array: [String] = []
        for hour in 0..<24 {
            /// strideは、数値の範囲を指定したステップ（増加量）で反復処理するためのSwiftの関数です。
            for minute in stride(from: 0, through: 45, by: 15) {
                let time = String(format: "%02d:%02d", hour, minute)
                array.append(time)
            }
        }
        timeArray = array
    }
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                // ToDo 開始より終了の方が早い場合はエラーにする。
                Text("開始")
                    .font(.system(size: 16))
                    .offset(x:0,y:140)
                Picker("Select an StartTIme", selection: $selectedStartTime) {
                    ForEach(0..<timeArray.count, id: \.self) { index in
                        Text(timeArray[index])
                    }
                }
                .frame(width: 90, height: geometry.size.height / 10)
                .pickerStyle(MenuPickerStyle())
                .offset(x:0,y:140)
                .onChange(of: selectedStartTime) { newValue in
                    scheduleDetailViewModel.startTime = timeArray[newValue]
                }
                
                Text("〜　")
                    .font(.system(size: 16))
                    .offset(x:0,y:140)
                
                Text("終了")
                    .font(.system(size: 16))
                    .offset(x:0,y:140)
                Picker("Select an EndTime", selection: $selectedEndTime) {
                    ForEach(0..<timeArray.count, id: \.self) { index in
                        Text(timeArray[index])
                    }
                }
                .frame(width: 90, height: geometry.size.height / 10)
                .pickerStyle(MenuPickerStyle())
                .offset(x:0,y:140)
                .onChange(of: selectedEndTime) { newValue in
                    scheduleDetailViewModel.endTime = timeArray[newValue]
                }
                
                Spacer()
            }
        }
    }
}
