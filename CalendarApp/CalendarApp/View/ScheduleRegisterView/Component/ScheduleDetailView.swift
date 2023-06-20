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
        VStack {
            Text("スケジュールの詳細を設定しよう！")
                .font(.system(size: 16))
                .offset(x: 0, y: -70)
            
            HStack {
                Text("詳細タイトル")
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
