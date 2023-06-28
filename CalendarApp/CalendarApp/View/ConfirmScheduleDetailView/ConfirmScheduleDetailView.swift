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
                HStack {
                    SelectedMonthDayView()
                }
                HStack {
                    Spacer()
                    EditButtonView()
                }
                
                ScrollView {
                    VStack(spacing: 20) {
                        Spacer().frame(height: 20)
                        ForEach(0..<scheduleDetailViewModel.scheduleDetailTitleArray.count, id: \.self) { index in
                            VStack {
                                Schedule(scheduleDetailViewModel: scheduleDetailViewModel, index: index)
                            }
                            .frame(width: geometry.size.width - 40, height: 80)
                            .background(Color.lemonchiffon)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                        }
                        Spacer().frame(height: 20)
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height * 0.75)
                .background(Color.lightGray)
                .offset(x: 0, y: -120)
            }
        }
    }
}

struct Schedule: View {
    var scheduleDetailViewModel: ScheduleDetailViewModel
    var index: Int
    
    var body: some View {
        VStack {
            HStack {
                // ToDo 未入力状態でボタンを押した場合は、赤文字で入力してくださいメッセージを表示させる
                Text("タイトル")
                    .font(.system(size: 16))
                Text(scheduleDetailViewModel.scheduleDetailTitleArray[index])
            }
            
            HStack {
                Text("開始")
                    .font(.system(size: 16))
                Text(scheduleDetailViewModel.startTimeArray[index])
                
                Text("〜")
                    .font(.system(size: 16))
                
                Text("終了")
                    .font(.system(size: 16))
                Text(scheduleDetailViewModel.endTimeArray[index])
            }
            
            HStack {
                Text("通知")
                    .font(.system(size: 16))
                Text(scheduleDetailViewModel.isNoticeArray[index] ? "ON" : "OFF")
            }
        }
    }
}
