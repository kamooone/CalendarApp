//
//  RegisterScheduleTitleView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/06.
//

import SwiftUI

struct ScheduleTitleView: View {
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @State private var text = ""
    
    var body: some View {
        VStack {
            Text("登録するスケジュールのタイトルを入力しよう！")
                .font(.system(size: 16))
                .offset(x: 0, y: -10)
            
            HStack {
                Text("タイトル")
                    .font(.system(size: 16))
                    .offset(x: 20, y: -20)
                TextField("例 : 遊園地に行く日", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .offset(x: 5, y: -20)
                    .onChange(of: text) { newValue in
                        scheduleDetailViewModel.scheduleTitle = newValue
                    }
                Spacer()
            }
        }
    }
}
