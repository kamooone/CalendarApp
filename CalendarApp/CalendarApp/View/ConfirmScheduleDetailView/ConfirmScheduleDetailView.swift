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
                    // ToDo 見栄えが悪いので処理を関数にする
                    if isEditMode {
                        ScrollView {
                            VStack(spacing: 20) {
                                Spacer().frame(height: 20)
                                ForEach(0..<scheduleDetailViewModel.scheduleDetailTitleArray.count, id: \.self) { index in
                                    VStack {
                                        ScheduleEdit(scheduleDetailViewModel: scheduleDetailViewModel, index: index)
                                    }
                                    .frame(width: geometry.size.width - 40, height: 150)
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
                    } else {
                        // ToDo 見栄えが悪いので処理を関数にする
                        ScrollView {
                            VStack(spacing: 20) {
                                Spacer().frame(height: 20)
                                ForEach(0..<scheduleDetailViewModel.scheduleDetailTitleArray.count, id: \.self) { index in
                                    VStack {
                                        Schedule(scheduleDetailViewModel: scheduleDetailViewModel, index: index)
                                    }
                                    .frame(width: geometry.size.width - 40, height: 100)
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
                
                BannerAdsView()
                    .frame(width: geometry.size.width, height: 80)
                    .background(Color.yellow)
                    .offset(x: 0, y: -70)
                
                Spacer()
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

struct ScheduleEdit: View {
    var scheduleDetailViewModel: ScheduleDetailViewModel
    var index: Int
    @State private var textFieldValue: String = ""
    @State private var selectedStartTime = 0
    @State private var selectedEndTime = 0
    @State private var isSwitchOn = true
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                // ToDo 削除ボタンも必要
                
                HStack {
                    // ToDo 未入力状態でボタンを押した場合は、赤文字で入力してくださいメッセージを表示させる
                    Spacer()
                    TextField("", text: $textFieldValue)
                        .frame(width: 300)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .onChange(of: scheduleDetailViewModel.scheduleDetailTitleArray[index]) { newTitleDetail in
                            // 表示用
                            scheduleDetailViewModel.scheduleDetailTitle = newTitleDetail
                            // 更新用にバックアップ
                            scheduleDetailViewModel.updScheduleDetailTitleArray[index] = newTitleDetail
                        }
                    Spacer()
                }
                
                HStack {
                    Text("開始")
                        .font(.system(size: 16))
                    Picker("Select an StartTIme", selection: $selectedStartTime) {
                        ForEach(0..<scheduleDetailViewModel.timeArray.count, id: \.self) { _index in
                            Text(scheduleDetailViewModel.timeArray[_index])
                        }
                    }
                    .frame(width: 90, height: geometry.size.height / 10)
                    .pickerStyle(MenuPickerStyle())
                    .offset(x:0,y:0)
                    .onChange(of: selectedStartTime) { timeIndex in
                        // 表示用
                        scheduleDetailViewModel.startTime = scheduleDetailViewModel.timeArray[timeIndex]
                        // 更新用にバックアップ
                        scheduleDetailViewModel.updStartTimeArray[index] = scheduleDetailViewModel.timeArray[timeIndex]
                    }
                    
                    Text("〜")
                        .font(.system(size: 16))
                    
                    Text("終了")
                        .font(.system(size: 16))
                    Picker("Select an EndTime", selection: $selectedEndTime) {
                        ForEach(0..<scheduleDetailViewModel.timeArray.count, id: \.self) { _index in
                            Text(scheduleDetailViewModel.timeArray[_index])
                        }
                    }
                    .frame(width: 90, height: geometry.size.height / 10)
                    .pickerStyle(MenuPickerStyle())
                    .offset(x:0,y:0)
                    .onChange(of: selectedEndTime) { timeIndex in
                        // 表示用
                        scheduleDetailViewModel.endTime = scheduleDetailViewModel.timeArray[timeIndex]
                        // 更新用にバックアップ
                        scheduleDetailViewModel.updEndTimeArray[index] = scheduleDetailViewModel.timeArray[timeIndex]
                    }
                }
                
                HStack {
                    Toggle("通知", isOn: $isSwitchOn)
                        .offset(x:0,y:0)
                        .padding(.horizontal, 100)
                        .onChange(of: isSwitchOn) { newIsNotice in
                            // 表示用
                            scheduleDetailViewModel.isNotice = newIsNotice
                            // 更新用にバックアップ
                            scheduleDetailViewModel.updIsNoticeArray[index] = newIsNotice
                        }
                }
            }
            .onAppear {
                textFieldValue = scheduleDetailViewModel.scheduleDetailTitleArray[index]
                
                if let selectedIndex = scheduleDetailViewModel.timeArray.firstIndex(of: scheduleDetailViewModel.startTimeArray[index]) {
                    selectedStartTime = selectedIndex
                }
                if let selectedIndex = scheduleDetailViewModel.timeArray.firstIndex(of: scheduleDetailViewModel.endTimeArray[index]) {
                    selectedEndTime = selectedIndex
                }
                
                isSwitchOn = scheduleDetailViewModel.isNoticeArray[index]
            }
        }
    }
}
