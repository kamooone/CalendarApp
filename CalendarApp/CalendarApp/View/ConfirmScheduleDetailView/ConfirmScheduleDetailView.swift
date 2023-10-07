//
//  ConfirmScheduleDetailButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/12.
//

import SwiftUI

struct ConfirmScheduleDetailView: View {
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    @EnvironmentObject var setting: Setting
    
    // ToDo この@Stateの値はConfirmScheduleDetailViewModelを作成してそこで管理する
    @State private var isRequestSuccessful = false
    @State private var isEditMode = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    let headerTitle: String = "CheckScheduleDetails"
    
    func bindViewModel() {
        isRequestSuccessful = false
        isEditMode = false
        showAlert = false
        alertMessage = ""
        
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
                        setting.isReload = false
                    }
                } else {
                    print("非同期処理失敗")
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        isRequestSuccessful = false
                        setting.isReload = false
                        showAlert = true
                        alertMessage = "スケジュールの取得に失敗しました。"
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
        VStack {
            
            HStack {
                BackButtonView()
                    .offset(x:0, y:20)
            }
            
            HStack {
                HeaderView(_headerTitle: headerTitle)
                    .offset(x:0, y:screenSizeObject.screenSize.height / 30 - 10)
            }
            
            HStack {
                SelectedMonthDayView()
                    .offset(x:0, y:screenSizeObject.screenSize.height / 30 + 30)
            }
            
            HStack {
                if isEditMode {
                    CancelButtonView(isEditMode: $isEditMode)
                        .offset(x:0, y:20)
                    UpdateButtonView(isEditMode: $isEditMode)
                        .offset(x:0, y:20)
                } else {
                    EditButtonView(isEditMode: $isEditMode)
                        .offset(x:0, y:20)
                }
            }
            
            VStack {
                // 非同期処理が完了後にスケジュール詳細登録状況を表示させる
                if isRequestSuccessful && !setting.isReload {
                    if isEditMode {
                        ScrollView {
                            VStack(spacing: 20) {
                                Spacer().frame(height: 20)
                                ForEach(0..<scheduleDetailViewModel.scheduleDetailTitleArray.count, id: \.self) { index in
                                    VStack {
                                        ScheduleEdit(scheduleDetailViewModel: scheduleDetailViewModel, index: index)
                                    }
                                    .frame(width: screenSizeObject.screenSize.width - 40, height: screenSizeObject.screenSize.height / 3)
                                    .background(Color.lemonchiffon)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 20)
                                }
                                Spacer().frame(height: 20)
                            }
                        }
                        .frame(width: screenSizeObject.screenSize.width, height: screenSizeObject.screenSize.height * 0.75)
                        .background(Color.lightGray)
                        .offset(x: 0, y: 10)
                    } else {
                        ScrollView {
                            VStack(spacing: 20) {
                                Spacer().frame(height: 20)
                                ForEach(0..<scheduleDetailViewModel.scheduleDetailTitleArray.count, id: \.self) { index in
                                    VStack {
                                        Schedule(scheduleDetailViewModel: scheduleDetailViewModel, index: index)
                                    }
                                    .frame(width: screenSizeObject.screenSize.width - 40, height: screenSizeObject.screenSize.height / 5)
                                    .background(Color.lemonchiffon)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 20)
                                }
                                Spacer().frame(height: 20)
                            }
                        }
                        .frame(width: screenSizeObject.screenSize.width, height: screenSizeObject.screenSize.height * 0.75)
                        .background(Color.lightGray)
                        .offset(x: 0, y: 10)
                    }
                }
            }
            
            VStack {
                BannerAdsView()
                    .frame(width: screenSizeObject.screenSize.width, height: screenSizeObject.screenSize.height * 0.1)
                    .background(Color.yellow)
                    .offset(x: 0, y: 0)
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("スケジュールの取得に失敗しました。"),
                  dismissButton: .default(Text("OK")))
        }
        .onAppear {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            screenSizeObject.screenSize = window.bounds.size
            bindViewModel()
        }
        .onChange(of: setting.isReload) { isReload in
            if isReload {
                bindViewModel()
            }
        }
    }
}

struct Schedule: View {
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    var scheduleDetailViewModel: ScheduleDetailViewModel
    var index: Int
    
    var body: some View {
        VStack {
            HStack {
                Text(LocalizedStringKey("TITLE"))
                    .font(.system(size: screenSizeObject.screenSize.width / 30))
                Text(scheduleDetailViewModel.scheduleDetailTitleArray[index])
            }
            
            HStack {
                Text(LocalizedStringKey("Start"))
                    .font(.system(size: screenSizeObject.screenSize.width / 30))
                Text(scheduleDetailViewModel.startTimeArray[index])
                
                Text("〜")
                    .font(.system(size: screenSizeObject.screenSize.width / 30))
                
                Text(LocalizedStringKey("End"))
                    .font(.system(size: screenSizeObject.screenSize.width / 30))
                Text(scheduleDetailViewModel.endTimeArray[index])
            }
            
            HStack {
                Text(LocalizedStringKey("Notice"))
                    .font(.system(size: screenSizeObject.screenSize.width / 30))
                Text(scheduleDetailViewModel.isNoticeArray[index] ? "ON" : "OFF")
            }
        }
        .onAppear {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            screenSizeObject.screenSize = window.bounds.size
        }
    }
}

struct ScheduleEdit: View {
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    var scheduleDetailViewModel: ScheduleDetailViewModel
    var index: Int
    @State private var textFieldValue: String = ""
    @State private var selectedStartTime = 0
    @State private var selectedEndTime = 0
    @State private var isSwitchOn = true
    
    var body: some View {
        
        VStack {
            
            HStack {
                Spacer()
                TextField("", text: $textFieldValue)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: textFieldValue) { newTitleDetail in
                        // 表示用
                        scheduleDetailViewModel.scheduleDetailTitle = newTitleDetail
                        // 更新用にバックアップ
                        scheduleDetailViewModel.updScheduleDetailTitleArray[index] = newTitleDetail
                    }
                    .offset(x:0, y:10)
                Spacer()
            }
            
            HStack {
                Text(LocalizedStringKey("Start"))
                    .font(.system(size: screenSizeObject.screenSize.width / 30))
                Picker("Select an StartTIme", selection: $selectedStartTime) {
                    ForEach(0..<scheduleDetailViewModel.timeArray.count, id: \.self) { _index in
                        Text(scheduleDetailViewModel.timeArray[_index])
                    }
                }
                .frame(width: screenSizeObject.screenSize.width / 4, height: screenSizeObject.screenSize.height / 10)
                .pickerStyle(MenuPickerStyle())
                .offset(x:0,y:0)
                .onChange(of: selectedStartTime) { timeIndex in
                    // 表示用
                    scheduleDetailViewModel.startTime = scheduleDetailViewModel.timeArray[timeIndex]
                    // 更新用にバックアップ
                    scheduleDetailViewModel.updStartTimeArray[index] = scheduleDetailViewModel.timeArray[timeIndex]
                }
                
                Text("〜")
                    .font(.system(size: screenSizeObject.screenSize.width / 30))
                
                Text(LocalizedStringKey("End"))
                    .font(.system(size: screenSizeObject.screenSize.width / 30))
                Picker("Select an EndTime", selection: $selectedEndTime) {
                    ForEach(0..<scheduleDetailViewModel.timeArray.count, id: \.self) { _index in
                        Text(scheduleDetailViewModel.timeArray[_index])
                    }
                }
                .frame(width: screenSizeObject.screenSize.width / 4, height: screenSizeObject.screenSize.height / 10)
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
                Toggle(LocalizedStringKey("Notice"), isOn: $isSwitchOn)
                    .font(.system(size: screenSizeObject.screenSize.width / 25))
                    .padding(.horizontal, screenSizeObject.screenSize.width / 5)
                    .onChange(of: isSwitchOn) { newIsNotice in
                        // 表示用
                        scheduleDetailViewModel.isNotice = newIsNotice
                        // 更新用にバックアップ
                        scheduleDetailViewModel.updIsNoticeArray[index] = newIsNotice
                    }
            }
            
            HStack {
                DeleteButtonView(_id: String(describing: scheduleDetailViewModel.uniqueIdArray[index]))
                    .offset(x:0,y:-10)
            }
        }
        .onAppear {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            screenSizeObject.screenSize = window.bounds.size
            
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
