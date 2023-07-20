//
//  IdealScheduleTitleView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI

struct IdealScheduleTitleView: View {
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @State private var text = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("※")
                    .foregroundColor(Color.red)
                    .font(.system(size: 16))
                    .offset(x: 0, y: 20)
                Text("理想のスケジュールのタイトルを入力しよう！")
                    .font(.system(size: 16))
                    .offset(x: 0, y: 20)
            }
            
            HStack {
                // ToDo 未入力状態でボタンを押した場合は、赤文字で入力してくださいメッセージを表示させる
                TextField("例 : 休日Aの理想スケジュール", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .offset(x: 5, y: 0)
                    .onChange(of: text) { newValue in
                        scheduleDetailViewModel.idealScheduleTitle = newValue
                    }
                Spacer()
            }
        }
    }
}
