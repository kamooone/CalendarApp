//
//  ConfirmScheduleDetailButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/12.
//

import SwiftUI

struct ConfirmScheduleDetailView: View {
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    
    @State private var isRequestSuccessful = false
    @State private var isEditMode: Bool = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    let headerTitle: String = "スケジュール詳細確認"
    
    func bindViewModel() {
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue(label: "realm").async {
            scheduleDetailViewModel.getScheduleDetail { success in
                group.leave()
                
                if success {
                    print("非同期処理成功")
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        isRequestSuccessful = true
                    }
                } else {
                    print("非同期処理失敗")
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        isRequestSuccessful = false
                    }
                }
            }
        }
        
        // 成功失敗に関わらず呼ばれる
        group.notify(queue: .main) {
            print("非同期処理終了")
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
                    if isEditMode {
                        CancelButtonView(isEditMode: $isEditMode)
                        UpdateButtonView(isEditMode: $isEditMode)
                    } else {
                        EditButtonView(isEditMode: $isEditMode)
                    }
                }
                
                // 非同期処理が完了後にスケジュール詳細登録状況を表示させる
                if isRequestSuccessful {
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
                    .offset(x: 0, y: -100)
                }
            }
        }
        .onAppear {
            bindViewModel()
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
