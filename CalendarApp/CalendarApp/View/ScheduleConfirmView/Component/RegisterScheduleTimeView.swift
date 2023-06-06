//
//  RegisterScheduleTimeView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/06.
//

import SwiftUI

struct RegisterScheduleTimeView: View {
    @State private var selectedStartTime = 0
    @State private var selectedEndTime = 0
    let time = ["0:00", "0:15", "0:30", "0:45"]
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                Text("開始")
                    .font(.system(size: 16))
                    .offset(x:0,y:150)
                Picker("Select an StartTIme", selection: $selectedStartTime) {
                    ForEach(0..<time.count, id: \.self) { index in
                        Text(time[index])
                    }
                }
                .frame(width: 80, height: geometry.size.height / 10)
                .pickerStyle(MenuPickerStyle())
                .offset(x:0,y:150)
                
                Text("〜　")
                    .font(.system(size: 16))
                    .offset(x:0,y:150)
                
                Text("終了")
                    .font(.system(size: 16))
                    .offset(x:0,y:150)
                Picker("Select an EndTime", selection: $selectedEndTime) {
                    ForEach(0..<time.count, id: \.self) { index in
                        Text(time[index])
                    }
                }
                .frame(width: 80, height: geometry.size.height / 10)
                .pickerStyle(MenuPickerStyle())
                .offset(x:0,y:150)
                
                Spacer()
            }
        }
    }
}
