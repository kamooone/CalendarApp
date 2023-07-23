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
    
    func bindViewModel() {
        isRequestSuccessful = false
        
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
                    // ToDo 取得失敗エラーアラート表示
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        isRequestSuccessful = false
                    }
                }
            }
        }
        
        // 成功失敗に関わらず呼ばれる
        group.notify(queue: .main) {
            // ToDo 失敗エラーアラート表示
            print("非同期処理終了")
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            Spacer()
            HStack {
                Spacer()
                Text("作成した理想のスケジュールを使用する")
                    .font(.system(size: 16))
                    .offset(x:0,y:10)
                Spacer()
            }
            
            if isRequestSuccessful {
                HStack {
                    Spacer()
                    // ToDo 設定後は次回以降もその設定している項目が選択されているようにしておく？
                    Picker("Select an option", selection: $selectedOption) {
                        ForEach(0..<options.count, id: \.self) { index in
                            Text(options[index])
                        }
                    }
                    .frame(width: geometry.size.width * 0.6, height: geometry.size.height / 10)
                    .pickerStyle(MenuPickerStyle())
                    .offset(x: 0, y: 25)
                    .onChange(of: selectedOption) { index in
                        scheduleDetailViewModel.idealScheduleTitle = options[index]
                    }

                    
                    SetButtonView(scheduleDetailViewModel: scheduleDetailViewModel)
                }
                Spacer()
            }
        }
        .onAppear{
            bindViewModel()
        }
    }
}

struct SetButtonView: View {
    let scheduleDetailViewModel: ScheduleDetailViewModel
    @State private var showAlert = false
    @State private var alertMessage = ""
    
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
                        scheduleDetailViewModel.scheduleDetailTitleArray = scheduleDetailViewModel.idealScheduleDetailTitleArray
                        scheduleDetailViewModel.startTimeArray = scheduleDetailViewModel.idealStartTimeArray
                        scheduleDetailViewModel.endTimeArray = scheduleDetailViewModel.idealEndTimeArray
                        scheduleDetailViewModel.isNoticeArray = scheduleDetailViewModel.idealIsNoticeArray
                        
                        print("ToDo うまく表示されてないのでデバッグ")
                        print(scheduleDetailViewModel.scheduleDetailTitleArray)
                        print(scheduleDetailViewModel.startTimeArray)
                        print(scheduleDetailViewModel.endTimeArray)
                        print(scheduleDetailViewModel.isNoticeArray)
                        
//                        // 更新用にupdに代入
//                        scheduleDetailViewModel.updScheduleDetailTitleArray = scheduleDetailViewModel.scheduleDetailTitleArray
//                        scheduleDetailViewModel.updStartTimeArray = scheduleDetailViewModel.startTimeArray
//                        scheduleDetailViewModel.updEndTimeArray = scheduleDetailViewModel.endTimeArray
//                        scheduleDetailViewModel.updIsNoticeArray = scheduleDetailViewModel.isNoticeArray
                        
                        // 先にレコード削除してから登録処理を行う
                        delete()
                        update()
                    }
                } else {
                    print("非同期処理失敗")
                    // ToDo 取得失敗エラーアラート表示
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        
                    }
                }
            }
        }
        
        // 成功失敗に関わらず呼ばれる
        group.notify(queue: .main) {
            // ToDo 失敗エラーアラート表示
            print("非同期処理終了")
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                bindViewModel()
            }) {
                Text("設定する")
                    .frame(width: 80, height: 30)
            }
            .buttonStyle(NormalButtonStyle.normalButtonStyle())
            .padding() // ボタンの余白を調整
            .offset(x:0,y:20)
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(alertMessage),
                    dismissButton: .default(Text("OK")) {}
                )
            }
            Spacer()
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
                    alertMessage = "設定が完了しました"
                } else {
                    print("非同期処理失敗")
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        alertMessage = "設定に失敗しました"
                    }
                }
            }
        }
        
        // 成功失敗に関わらず呼ばれる
        group.notify(queue: .main) {
            // ToDo 失敗エラーアラート表示
            print("非同期処理終了")
            showAlert = true
        }
    }
}
