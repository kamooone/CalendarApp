//
//  ConfirmScheduleDetailButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/12.
//

import SwiftUI

struct ConfirmScheduleDetailView: View {
    let headerTitle: String = "スケジュール詳細確認"
    
//    init {
//        // ToDo ScheduleDetailViewモデルのメソッドでデータを取得して、表示させる。
//
//    }
    
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
