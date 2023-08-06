//
//  IdealScheduleTimeView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/20.
//

import SwiftUI

struct IdealScheduleTimeView: View {
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
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
        HStack {
            Spacer()
            // ToDo 開始より終了の方が早い場合はエラーにする。
            Text("開始")
                .frame(width: screenSizeObject.screenSize.width / 8, height: screenSizeObject.screenSize.height / 10)
                .font(.system(size: screenSizeObject.screenSize.width / 25))
                .offset(x:0,y:0)
            Picker("Select an StartTIme", selection: $selectedStartTime) {
                ForEach(0..<scheduleDetailViewModel.timeArray.count, id: \.self) { index in
                    Text(scheduleDetailViewModel.timeArray[index])
                }
            }
            .frame(width: screenSizeObject.screenSize.width / 4, height: screenSizeObject.screenSize.height / 10)
            .pickerStyle(MenuPickerStyle())
            .offset(x:0,y:0)
            .onChange(of: selectedStartTime) { newValue in
                scheduleDetailViewModel.idealStartTime = scheduleDetailViewModel.timeArray[newValue]
            }
                        
            Text("終了")
                .frame(width: screenSizeObject.screenSize.width / 8, height: screenSizeObject.screenSize.height / 10)
                .font(.system(size: screenSizeObject.screenSize.width / 25))
                .offset(x:0,y:0)
            Picker("Select an EndTime", selection: $selectedEndTime) {
                ForEach(0..<scheduleDetailViewModel.timeArray.count, id: \.self) { index in
                    Text(scheduleDetailViewModel.timeArray[index])
                }
            }
            .frame(width: screenSizeObject.screenSize.width / 4, height: screenSizeObject.screenSize.height / 10)
            .pickerStyle(MenuPickerStyle())
            .offset(x:0,y:0)
            .onChange(of: selectedEndTime) { newValue in
                scheduleDetailViewModel.idealEndTime = scheduleDetailViewModel.timeArray[newValue]
            }
            
            Spacer()
        }
        .onAppear{
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            screenSizeObject.screenSize = window.bounds.size
        }
    }
}
