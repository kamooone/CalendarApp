//
//  RegisterScheduleTimeView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/06.
//

import SwiftUI

struct RegisterScheduleTimeView: View {
    @State private var selectedOption = 0
    let time = ["0:00", "0:15", "0:30", "0:45"]
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                Text("開始")
                    .font(.system(size: 16))
                    .offset(x:0,y:40)
                Picker("Select an option", selection: $selectedOption) {
                    ForEach(0..<time.count, id: \.self) { index in
                        Text(time[index])
                    }
                }
                .frame(width: 80, height: geometry.size.height / 10)
                .pickerStyle(MenuPickerStyle())
                .offset(x:0,y:40)
                
                Text("〜　")
                    .font(.system(size: 16))
                    .offset(x:0,y:40)
                
                Text("終了")
                    .font(.system(size: 16))
                    .offset(x:0,y:40)
                Picker("Select an option", selection: $selectedOption) {
                    ForEach(0..<time.count, id: \.self) { index in
                        Text(time[index])
                    }
                }
                .frame(width: 80, height: geometry.size.height / 10)
                .pickerStyle(MenuPickerStyle())
                .offset(x:0,y:40)
                
                Spacer()
            }
        }
    }
}
