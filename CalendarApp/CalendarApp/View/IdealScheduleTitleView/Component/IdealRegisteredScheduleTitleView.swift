//
//  IdealRegisteredScheduleTitleView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/20.
//

import SwiftUI

struct IdealRegisteredScheduleTitleView: View {
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @EnvironmentObject var setting: Setting
    @State private var text = ""
    
    // ToDo この@Stateの値はConfirmScheduleDetailViewModelを作成してそこで管理する
    @State private var isRequestSuccessful = false
    @State private var isEditMode = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    func bindViewModel() {
        isRequestSuccessful = false
        isEditMode = false
        showAlert = false
        alertMessage = ""
        scheduleDetailViewModel.isIdealScheduleUpdate = false
        
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
                    }
                } else {
                    print("非同期処理失敗")
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        isRequestSuccessful = false
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
            if isRequestSuccessful {
                HStack {
                    Text("登録済みの理想のスケジュール")
                        .font(.system(size: screenSizeObject.screenSize.width / 20))
                        .offset(x: 0, y: 5)
                }
                
                ScrollView {
                    VStack(spacing: 10) {
                        Spacer().frame(height: 10)
                        ForEach(0..<scheduleDetailViewModel.idealScheduleTitleArray.count, id: \.self) { index in
                            VStack {
                                IdealScheduleTitle(scheduleDetailViewModel: scheduleDetailViewModel, index: index)
                            }
                            .frame(width: screenSizeObject.screenSize.width * 0.8, height: screenSizeObject.screenSize.height / 20)
                            .background(Color.lemonchiffon)
                            .cornerRadius(10)
                            .padding(.horizontal, 20)
                        }
                        Spacer().frame(height: 10)
                    }
                }
                .frame(width: screenSizeObject.screenSize.width, height: screenSizeObject.screenSize.height / 5)
                .background(Color.lightWhite)
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
                setting.isReload = false
            }
        }
    }
}


struct IdealScheduleTitle: View {
    var scheduleDetailViewModel: ScheduleDetailViewModel
    var index: Int
    
    var body: some View {
        VStack {
            // ToDo 登録済み理想のスケジュールのタイトルを変更できるようにする。
            HStack {
                Spacer()
                Text(scheduleDetailViewModel.idealScheduleTitleArray[index])
                Spacer()
                EditIdealScheduleButtonView(_titleStr: scheduleDetailViewModel.idealScheduleTitleArray[index])
                DeleteIdealScheduleButtonView(_titleStr: scheduleDetailViewModel.idealScheduleTitleArray[index])
            }
        }
    }
}
