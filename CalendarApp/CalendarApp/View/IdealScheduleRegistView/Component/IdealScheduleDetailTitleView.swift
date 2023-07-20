//
//  IdealScheduleDetailTitleView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI

struct IdealScheduleDetailTitleView: View {
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @State private var text = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("※")
                    .foregroundColor(Color.red)
                    .font(.system(size: 16))
                    .offset(x: 0, y: -70)
                Text("スケジュールを追加しよう！")
                    .font(.system(size: 16))
                    .offset(x: 0, y: -70)
            }
            
            HStack {
                // ToDo 未入力状態でボタンを押した場合は、赤文字で入力してくださいメッセージを表示させる
                Text("タイトル")
                    .font(.system(size: 16))
                    .offset(x: 20, y: -40)
                TextField("例 : 午後の買い物", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .offset(x: 5, y: -40)
                    .onChange(of: text) { newValue in
                        scheduleDetailViewModel.scheduleDetailTitle = newValue
                    }
                Spacer()
            }
        }
    }
}
