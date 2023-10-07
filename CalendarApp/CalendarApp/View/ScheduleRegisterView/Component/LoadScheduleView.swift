//
//  LoadScheduleView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/06.
//

import SwiftUI

struct LoadScheduleView: View {
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    
    @State private var selectedOption = 0
    @State private var options: [String] = ["---------------"]
    @State private var isRequestSuccessful = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    func bindViewModel() {
        isRequestSuccessful = false
        //showAlert = false
        
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue(label: "realm").async {
            scheduleDetailViewModel.getIdealScheduleTitle { success in
                group.leave()
                
                if success {
                    print("非同期処理成功")
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        isRequestSuccessful = true
                        options.append(contentsOf: scheduleDetailViewModel.idealScheduleTitleArray)
                        selectedOption = 0
                    }
                } else {
                    print("非同期処理失敗")
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        isRequestSuccessful = false
                        showAlert = true
                        alertMessage = "FailedToGetSchedule"
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
            if isRequestSuccessful {
                VStack {
                    HStack {
                        Spacer()
                        Text(LocalizedStringKey("UseTheIdealScheduleYouCreated"))
                            .font(.system(size: geometry.size.width / 25))
                            .offset(x:0, y:10)
                        Spacer()
                    }
                    
                    HStack {
                        Picker("Select an option", selection: $selectedOption) {
                            ForEach(0..<options.count, id: \.self) { index in
                                Text(options[index])
                            }
                        }
                        .offset(x:geometry.size.width * 0.1, y:20)
                        .frame(width: geometry.size.width * 0.5, height: geometry.size.height / 5)
                        .onChange(of: selectedOption) { index in
                            scheduleDetailViewModel.idealScheduleTitle = options[index]
                        }
                        
                        SetButtonView(selectedOption: $selectedOption, showAlert: $showAlert, alertMessage: $alertMessage, scheduleDetailViewModel: scheduleDetailViewModel)
                            .frame(width: geometry.size.width * 0.5, height: geometry.size.height / 5)
                    }
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text(alertMessage),
                  dismissButton: .default(Text("OK")))
        }
        .onAppear{
            bindViewModel()
        }
    }
}

struct SetButtonView: View {
    @Binding var selectedOption: Int
    @Binding var showAlert: Bool
    @Binding var alertMessage: String
    let scheduleDetailViewModel: ScheduleDetailViewModel
    
    
    func bindViewModel() {
        
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue(label: "realm").async {
            scheduleDetailViewModel.getIdealScheduleDetail { success in
                group.leave()
                
                if success {
                    print("非同期処理成功")
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        // 先にレコード削除してから登録処理を行う
                        delete()
                        
                        scheduleDetailViewModel.scheduleDetailTitleArray = scheduleDetailViewModel.idealScheduleDetailTitleArray
                        scheduleDetailViewModel.startTimeArray = scheduleDetailViewModel.idealStartTimeArray
                        scheduleDetailViewModel.endTimeArray = scheduleDetailViewModel.idealEndTimeArray
                        scheduleDetailViewModel.isNoticeArray = scheduleDetailViewModel.idealIsNoticeArray
                        
                        print("理想スケジュール反映デバッグ")
                        print(scheduleDetailViewModel.scheduleDetailTitleArray)
                        print(scheduleDetailViewModel.startTimeArray)
                        print(scheduleDetailViewModel.endTimeArray)
                        print(scheduleDetailViewModel.isNoticeArray)
                        
                        update()
                    }
                } else {
                    print("非同期処理失敗")
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        showAlert = true
                        alertMessage = "SystemErrorHasOccurred"
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
            Button(action: {
                if selectedOption != 0 {
                    bindViewModel()
                } else {
                    showAlert = true
                    alertMessage = "ChooseYourIdealScheduleToSet"
                }
            }) {
                Text(LocalizedStringKey("Set"))
                    .frame(width: geometry.size.width * 0.5, height: geometry.size.height)
            }
            .buttonStyle(NormalButtonStyle.normalButtonStyle())
            .padding()
        }
    }
    
    func delete() {
        let scheduleDetailViewModel = ScheduleDetailViewModel.shared
        let calendarViewModel = CalendarViewModel.shared
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue(label: "realm").async {
            scheduleDetailViewModel.DeleteScheduleDetail(_year: String(calendarViewModel.selectYear), _month: String(calendarViewModel.selectMonth), _day: String(calendarViewModel.selectDay)) { success in
                group.leave()
                
                DispatchQueue.main.async {
                    withAnimation {
                        if success {
                            print("削除完了")
                        } else {
                            print("削除失敗")
                            alertMessage = "ThereWasProblem"
                            showAlert = true
                        }
                    }
                }
            }
        }
        
        // 成功失敗に関わらず呼ばれる
        group.notify(queue: .main) {
            print("非同期処理終了")
        }
    }
    
    func update() {
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue(label: "realm").async {
            scheduleDetailViewModel.setIdealScheduleDetail { success in
                group.leave()
                
                if success {
                    print("非同期処理成功")
                    alertMessage = "ConfigurationCompleted"
                    showAlert = true
                } else {
                    print("非同期処理失敗")
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        alertMessage = "ConfigurationFailed"
                        showAlert = true
                    }
                }
            }
        }
        
        // 成功失敗に関わらず呼ばれる
        group.notify(queue: .main) {
            print("非同期処理終了")
        }
    }
}
