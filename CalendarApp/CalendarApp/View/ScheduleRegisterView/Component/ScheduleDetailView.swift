//
//  RegisterScheduleDetailView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/06.
//

import SwiftUI

struct ScheduleDetailView: View {
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @State private var text = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text("スケジュールを追加しよう！")
                        .font(.system(size: geometry.size.width / 25))
                        .offset(x: 0, y: 10)
                }
                
                HStack {
                    // ToDo 未入力状態でボタンを押した場合は、赤文字で入力してくださいメッセージを表示させる。もしくはキャラの画像で
                    Text("タイトル")
                        .font(.system(size: geometry.size.width / 25))
                        .offset(x: 20, y: 0)
                    TextField("例 : 午後の買い物", text: $text)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .offset(x: 5, y: 0)
                        .onChange(of: text) { newValue in
                            scheduleDetailViewModel.scheduleDetailTitle = newValue
                        }
                    Spacer()
                }
            }
        }
    }
}
