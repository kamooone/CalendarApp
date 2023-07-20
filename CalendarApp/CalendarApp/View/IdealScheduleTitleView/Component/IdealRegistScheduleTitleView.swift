//
//  IdealRegistScheduleTitleView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/20.
//

import SwiftUI

struct IdealRegistScheduleTitleView: View {
    @EnvironmentObject var route: RouteObserver
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @State private var text = ""
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("理想のスケジュールタイトルを入力しよう")
                    .font(.system(size: 16))
                    .offset(x: 0, y: 20)
            }
            
            HStack {
                // ToDo 未入力状態でボタンを押した場合は、赤文字で入力してくださいメッセージを表示させる
                TextField("例 : 休日Aの理想スケジュール", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .offset(x: 5, y: 20)
                    .onChange(of: text) { newValue in
                        scheduleDetailViewModel.idealScheduleTitle = newValue
                    }
            }
            
            HStack {
                Button(action: {
                    route.path = .IdealSchedule
                }) {
                    Text("次へ")
                        .frame(width: 50, height: 30)
                }
                .offset(x: 0, y: 0)
                .buttonStyle(NormalButtonStyle.normalButtonStyle())
                .padding()
            }
            Spacer()
        }
    }
}
