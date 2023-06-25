//
//  ConfirmScheduleDetailButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/12.
//

import SwiftUI

struct ConfirmScheduleDetailView: View {
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @State private var showAlert = false
    @State private var alertMessage = ""
    let headerTitle: String = "スケジュール詳細確認"
    
    init() {
        if scheduleDetailViewModel.getScheduleDetail() == 0 {
            print("スケジュール詳細取得成功")
        } else {
            print("登録に失敗しました")
            // ToDo カレンダー画面に戻す処理
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    BackButtonView()
                }
                HStack {
                    HeaderView(_headerTitle: headerTitle)
                }
                
                ScrollView {
                    ForEach(0..<6, id: \.self) { week in
                        VStack {
                            Text("aaa")
                        }
                        .frame(width: geometry.size.width, height: 80)
                        .background(Color.pink)
                        .offset(x: 0, y: 0)
                    }
                }
            }
        }
    }
}
