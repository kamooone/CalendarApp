//
//  IdealRegisteredScheduleTitleView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/20.
//

import SwiftUI

struct IdealRegisteredScheduleTitleView: View {
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
            VStack {
                if isRequestSuccessful {
                    HStack {
                        Text("登録済みの理想のスケジュール")
                            .font(.system(size: 16))
                            .offset(x: 0, y: 20)
                    }
                    
                    ScrollView {
                        VStack(spacing: 10) {
                            Spacer().frame(height: 10)
                            ForEach(0..<scheduleDetailViewModel.idealScheduleTitleArray.count, id: \.self) { index in
                                VStack {
                                    IdealScheduleTitle(scheduleDetailViewModel: scheduleDetailViewModel, index: index)
                                }
                                .frame(width: geometry.size.width - 40, height: 60)
                                .background(Color.lemonchiffon)
                                .cornerRadius(10)
                                .padding(.horizontal, 20)
                            }
                            Spacer().frame(height: 10)
                        }
                    }
                    .frame(width: geometry.size.width, height: 270)
                    .background(Color.lightWhite)
                    .offset(x: 0, y: 20)
                }
            }
        }
        .onAppear {
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
