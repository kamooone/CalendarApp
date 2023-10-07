//
//  ConfirmScheduleDetailView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI

struct IdealConfirmScheduleDetailView: View {
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    
    @EnvironmentObject var setting: Setting
    
    // ToDo この@Stateの値はConfirmScheduleDetailViewModelを作成してそこで管理する
    @State private var isRequestSuccessful = false
    @State private var isEditMode = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    let headerTitle: String = "ConfirmYourIdealSchedule"
    
    func bindViewModel() {
        isRequestSuccessful = false
        isEditMode = false
        showAlert = false
        alertMessage = ""
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue(label: "realm").async {
            scheduleDetailViewModel.getIdealScheduleDetail { success in
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
                        alertMessage = NSLocalizedString("FailedToGetSchedule", comment: "")
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
                    .offset(x:0, y:screenSizeObject.screenSize.height / 10 - 20)
            }
            
            HStack {
                HeaderView(_headerTitle: headerTitle)
                    .offset(x:0, y:screenSizeObject.screenSize.height / 10 + 0)
            }
            
            HStack {
                SelectIdealScheduleTitle()
            }
            
            HStack {
                if isEditMode {
                    CanselIdealButtonView(isEditMode: $isEditMode)
                    UpdateIdealScheduleDetailButtonView(isEditMode: $isEditMode)
                } else {
                    EditButtonView(isEditMode: $isEditMode)
                }
            }
            
            HStack {
                if isRequestSuccessful && !setting.isReload {
                    if isEditMode {
                        ScrollView {
                            VStack(spacing: 20) {
                                Spacer().frame(height: 20)
                                ForEach(0..<scheduleDetailViewModel.idealScheduleDetailTitleArray.count, id: \.self) { index in
                                    VStack {
                                        IdealScheduleEdit(scheduleDetailViewModel: scheduleDetailViewModel, index: index)
                                    }
                                    .frame(width: screenSizeObject.screenSize.width - 40, height: screenSizeObject.screenSize.height / 4)
                                    .background(Color.lemonchiffon)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 20)
                                }
                                Spacer().frame(height: 20)
                            }
                        }
                        .frame(width: screenSizeObject.screenSize.width, height: screenSizeObject.screenSize.height * 0.75)
                        .background(Color.lightGray)
                        .offset(x: 0, y: 0)
                    } else {
                        ScrollView {
                            VStack(spacing: 20) {
                                Spacer().frame(height: 20)
                                ForEach(0..<scheduleDetailViewModel.idealScheduleDetailTitleArray.count, id: \.self) { index in
                                    VStack {
                                        IdealSchedule(scheduleDetailViewModel: scheduleDetailViewModel, index: index)
                                    }
                                    .frame(width: screenSizeObject.screenSize.width - 40, height: screenSizeObject.screenSize.height / 6)
                                    .background(Color.lemonchiffon)
                                    .cornerRadius(10)
                                    .padding(.horizontal, 20)
                                }
                                Spacer().frame(height: 20)
                            }
                        }
                        .frame(width: screenSizeObject.screenSize.width, height: screenSizeObject.screenSize.height * 0.75)
                        .background(Color.lightGray)
                        .offset(x: 0, y: 0)
                    }
                }
            }
            
            HStack {
                BannerAdsView()
                    .frame(width: screenSizeObject.screenSize.width, height: screenSizeObject.screenSize.height * 0.1)
                    .background(Color.yellow)
                    .offset(x: 0, y: -50)
            }
            Spacer()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(LocalizedStringKey("FailedToGetSchedule")),
                  dismissButton: .default(Text("OK")))
        }
        .onChange(of: setting.isReload) { isReload in
            if isReload {
                bindViewModel()
            }
        }
        .onAppear{
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            screenSizeObject.screenSize = window.bounds.size
            bindViewModel()
        }
    }
}

struct IdealSchedule: View {
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    var scheduleDetailViewModel: ScheduleDetailViewModel
    var index: Int
    
    var body: some View {
        VStack {
            Spacer().frame(height: 5)
            
            HStack {
                Text(scheduleDetailViewModel.idealScheduleDetailTitleArray[index])
                    .frame(width: screenSizeObject.screenSize.width, height: screenSizeObject.screenSize.height / 30)
                    .font(.system(size: screenSizeObject.screenSize.width / 25))
            }
            .offset(x:0, y:0)
            
            Spacer().frame(height: 10)
            
            HStack {
                Text(LocalizedStringKey("Start"))
                    .frame(width: screenSizeObject.screenSize.width / 8, height: screenSizeObject.screenSize.height / 30)
                    .font(.system(size: screenSizeObject.screenSize.width / 25))
                Text(scheduleDetailViewModel.idealStartTimeArray[index])
                
                Text(LocalizedStringKey("End"))
                    .frame(width: screenSizeObject.screenSize.width / 8, height: screenSizeObject.screenSize.height / 30)
                    .font(.system(size: screenSizeObject.screenSize.width / 25))
                Text(scheduleDetailViewModel.idealEndTimeArray[index])
            }
            .offset(x:0, y:0)
            
            Spacer().frame(height: 10)
            
            HStack {
                Text(LocalizedStringKey("Notice"))
                    .frame(width: screenSizeObject.screenSize.width / 8, height: screenSizeObject.screenSize.height / 30)
                    .font(.system(size: screenSizeObject.screenSize.width / 25))
                Text(scheduleDetailViewModel.idealIsNoticeArray[index] ? "ON" : "OFF")
            }
            .offset(x:0, y:0)
            
            Spacer().frame(height: 5)
        }
        .onAppear{
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            screenSizeObject.screenSize = window.bounds.size
        }
    }
}

struct IdealScheduleEdit: View {
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
                    .frame(width: 300, height: 0)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .onChange(of: textFieldValue) { newTitleDetail in
                        // 表示用
                        scheduleDetailViewModel.idealScheduleDetailTitle = newTitleDetail
                        // 更新用にバックアップ
                        scheduleDetailViewModel.updScheduleDetailTitleArray[index] = newTitleDetail
                    }
                    .offset(x:0, y:20)
                Spacer()
            }
            
            HStack {
                Text(LocalizedStringKey("Start"))
                    .frame(width: screenSizeObject.screenSize.width / 8, height: 0)
                    .font(.system(size: screenSizeObject.screenSize.width / 25))
                Picker("Select an StartTIme", selection: $selectedStartTime) {
                    ForEach(0..<scheduleDetailViewModel.timeArray.count, id: \.self) { _index in
                        Text(scheduleDetailViewModel.timeArray[_index])
                    }
                }
                .frame(width: screenSizeObject.screenSize.width / 4, height: screenSizeObject.screenSize.height / 10)
                .pickerStyle(MenuPickerStyle())
                .pickerStyle(MenuPickerStyle())
                .offset(x:0,y:0)
                .onChange(of: selectedStartTime) { timeIndex in
                    // 表示用
                    scheduleDetailViewModel.idealStartTime = scheduleDetailViewModel.timeArray[timeIndex]
                    // 更新用にバックアップ
                    scheduleDetailViewModel.updStartTimeArray[index] = scheduleDetailViewModel.timeArray[timeIndex]
                }
                
                Text(LocalizedStringKey("End"))
                    .frame(width: screenSizeObject.screenSize.width / 8, height: screenSizeObject.screenSize.height / 10)
                    .font(.system(size: screenSizeObject.screenSize.width / 25))
                Picker("Select an EndTime", selection: $selectedEndTime) {
                    ForEach(0..<scheduleDetailViewModel.timeArray.count, id: \.self) { _index in
                        Text(scheduleDetailViewModel.timeArray[_index])
                    }
                }
                .frame(width: screenSizeObject.screenSize.width / 4, height: 0)
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
                Toggle(LocalizedStringKey("Notice"), isOn: $isSwitchOn)
                    .frame(width: screenSizeObject.screenSize.width / 4, height: 20)
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
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            screenSizeObject.screenSize = window.bounds.size
            
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
