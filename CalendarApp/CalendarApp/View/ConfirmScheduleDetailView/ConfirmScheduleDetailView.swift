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
                
                // ToDo 各種項目編集できるように&編集内容を更新(DB更新)&削除処理。
                
                ScrollView {
                    ForEach(0..<scheduleDetailViewModel.scheduleDetailTitleArray.count, id: \.self) { index in
                        VStack {
                            Schedule(scheduleDetailViewModel: scheduleDetailViewModel, index: index, width: geometry.size.width)
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

struct Schedule: View {
    var scheduleDetailViewModel: ScheduleDetailViewModel
    var index: Int
    var width: CGFloat
    
    var body: some View {
        VStack {
            Text(scheduleDetailViewModel.scheduleDetailTitleArray[index])
            Text(scheduleDetailViewModel.startTimeArray[index])
            Text(scheduleDetailViewModel.endTimeArray[index])
            Text(scheduleDetailViewModel.isNoticeArray[index] ? "Notice On" : "Notice Off")
        }
        .frame(width: width, height: 80)
        .background(Color.pink)
        .offset(x: 0, y: 0)
    }
}
