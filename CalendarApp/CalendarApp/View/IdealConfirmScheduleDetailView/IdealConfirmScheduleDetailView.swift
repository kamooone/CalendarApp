//
//  ConfirmScheduleDetailView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI

struct IdealConfirmScheduleDetailView: View {
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    
    @EnvironmentObject var setting: Setting
    
    // ToDo この@Stateの値はConfirmScheduleDetailViewModelを作成してそこで管理する
    @State private var isRequestSuccessful = false
    @State private var isEditMode = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    let headerTitle: String = "理想のスケジュール確認"
    
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
                    SelectIdealScheduleTitle()
                }
                
                HStack {
                    Spacer()
                    if isEditMode {
                        CancelButtonView(isEditMode: $isEditMode)
                        UpdateIdealScheduleDetailButtonView(isEditMode: $isEditMode)
                    } else {
                        EditButtonView(isEditMode: $isEditMode)
                    }
                }
                
                // ToDo 見栄えが悪いので処理を関数にする
                if isEditMode {
                    ScrollView {
                        VStack(spacing: 20) {
                            Spacer().frame(height: 20)
                            ForEach(0..<scheduleDetailViewModel.idealScheduleDetailTitleArray.count, id: \.self) { index in
                                VStack {
                                    IdealScheduleEdit(scheduleDetailViewModel: scheduleDetailViewModel, index: index)
                                }
                                .frame(width: geometry.size.width - 40, height: 220)
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
                            ForEach(0..<scheduleDetailViewModel.idealScheduleDetailTitleArray.count, id: \.self) { index in
                                VStack {
                                    IdealSchedule(scheduleDetailViewModel: scheduleDetailViewModel, index: index)
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
                
                BannerAdsView()
                    .frame(width: geometry.size.width, height: 80)
                    .background(Color.yellow)
                    .offset(x: 0, y: -70)
                
                Spacer()
            }
        }
    }
}

struct IdealSchedule: View {
    var scheduleDetailViewModel: ScheduleDetailViewModel
    var index: Int
    
    var body: some View {
        VStack {
            HStack {
                Text("タイトル")
                    .font(.system(size: 16))
                Text(scheduleDetailViewModel.idealScheduleDetailTitleArray[index])
            }
            
            HStack {
                Text("開始")
                    .font(.system(size: 16))
                Text(scheduleDetailViewModel.idealStartTimeArray[index])
                
                Text("〜")
                    .font(.system(size: 16))
                
                Text("終了")
                    .font(.system(size: 16))
                Text(scheduleDetailViewModel.idealEndTimeArray[index])
            }
            
            HStack {
                Text("通知")
                    .font(.system(size: 16))
                Text(scheduleDetailViewModel.idealIsNoticeArray[index] ? "ON" : "OFF")
            }
        }
    }
}

struct IdealScheduleEdit: View {
    var scheduleDetailViewModel: ScheduleDetailViewModel
    var index: Int
    @State private var textFieldValue: String = ""
    @State private var selectedStartTime = 0
    @State private var selectedEndTime = 0
    @State private var isSwitchOn = true
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                
                HStack {
                    // ToDo 未入力状態でボタンを押した場合は、赤文字で入力してくださいメッセージを表示させる
                    Spacer()
                    TextField("", text: $textFieldValue)
                        .frame(width: 300)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .onChange(of: textFieldValue) { newTitleDetail in
                            // 表示用
                            scheduleDetailViewModel.idealScheduleDetailTitle = newTitleDetail
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
                        scheduleDetailViewModel.idealStartTime = scheduleDetailViewModel.timeArray[timeIndex]
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
                        scheduleDetailViewModel.idealEndTime = scheduleDetailViewModel.timeArray[timeIndex]
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
                            scheduleDetailViewModel.idealIsNotice = newIsNotice
                            // 更新用にバックアップ
                            scheduleDetailViewModel.updIsNoticeArray[index] = newIsNotice
                        }
                }
                
                HStack {
                    DeleteIdealDetailScheduleButtonView(_id: index)
                }
            }
            .onAppear {
                textFieldValue = scheduleDetailViewModel.idealScheduleDetailTitleArray[index]
                
                if let selectedIndex = scheduleDetailViewModel.timeArray.firstIndex(of: scheduleDetailViewModel.idealStartTimeArray[index]) {
                    selectedStartTime = selectedIndex
                }
                if let selectedIndex = scheduleDetailViewModel.timeArray.firstIndex(of: scheduleDetailViewModel.idealEndTimeArray[index]) {
                    selectedEndTime = selectedIndex
                }
                
                isSwitchOn = scheduleDetailViewModel.idealIsNoticeArray[index]
            }
        }
    }
}
