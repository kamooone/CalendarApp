//
//  LoadScheduleView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/06.
//

import SwiftUI

struct LoadScheduleView: View {
    @State private var selectedOption = 0
    let options = ["-------------------", "作成した理想のスケ1", "作成した理想のスケ2", "作成した理想のスケ3"]
    
    var body: some View {
        GeometryReader { geometry in
            Spacer()
            HStack {
                Spacer()
                Text("作成した理想のスケジュールを使用する")
                    .font(.system(size: 16))
                    .offset(x:0,y:10)
                Spacer()
            }
            
            HStack {
                Spacer()
                Picker("Select an option", selection: $selectedOption) {
                    ForEach(0..<options.count, id: \.self) { index in
                        Text(options[index])
                    }
                }
                .frame(width: geometry.size.width * 0.6, height: geometry.size.height / 10)
                .pickerStyle(MenuPickerStyle())
                .offset(x:0,y:25)
                
                Button(action: {
                    
                }) {
                    Text("設定する")
                        .frame(width: 80, height: 30)
                }
                .buttonStyle(NormalButtonStyle.normalButtonStyle())
                .padding() // ボタンの余白を調整
                .offset(x:0,y:20)
                Spacer()
            }
            Spacer()
        }
    }
}
