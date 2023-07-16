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
    let headerTitle: String = "理想のスケジュール登録状況確認"
    
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
        .onChange(of: setting.isReload) { isReload in
            if isReload {
                bindViewModel()
                setting.isReload = false
            }
        }
    }
}
