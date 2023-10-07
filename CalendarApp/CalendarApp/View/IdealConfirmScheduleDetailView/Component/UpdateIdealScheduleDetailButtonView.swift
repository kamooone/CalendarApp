//
//  UpdateIdealScheduleDetailButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/22.
//

import SwiftUI

struct UpdateIdealScheduleDetailButtonView: View {
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    @EnvironmentObject var setting: Setting
    @Binding var isEditMode: Bool
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View  {
        HStack {
            Button(action: {
                if scheduleDetailViewModel.idealScheduleDetailTitle.count != 0 && scheduleDetailViewModel.idealScheduleDetailTitle.count < 11 {
                    
                    // 開始より終了の方が早い場合のエラーアラートも追加。
                    let startHour = scheduleDetailViewModel.idealStartTime.prefix(2)
                    let startMinute = scheduleDetailViewModel.idealStartTime.suffix(2)
                    let startTime = Int(startHour + startMinute)
                    let endHour = scheduleDetailViewModel.idealEndTime.prefix(2)
                    let endMinute = scheduleDetailViewModel.idealEndTime.suffix(2)
                    let endTime = Int(endHour + endMinute)
                    if Int(startTime!) < Int(endTime!) {
                        update()
                    } else {
                        showAlert = true
                        alertMessage = NSLocalizedString("PleaseSetTheEndTimeToBeLaterThanTheStartTime", comment: "")
                    }
                } else {
                    showAlert = true
                    if scheduleDetailViewModel.idealScheduleDetailTitle.count == 0 {
                        alertMessage = NSLocalizedString("EnteringTitleIsRequired", comment: "")
                    } else {
                        alertMessage = NSLocalizedString("PleaseEnterTheTitleWithin10Characters", comment: "")
                    }
                }
            }) {
                Text(LocalizedStringKey("Update"))
                    .frame(width: screenSizeObject.screenSize.width / 12, height: screenSizeObject.screenSize.height / 20)
                    .font(.system(size: screenSizeObject.screenSize.width / 40))
            }
            .offset(x: 10, y: 0)
            .buttonStyle(NormalButtonStyle.normalButtonStyle())
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(alertMessage),
                    dismissButton: .default(Text("OK")) {
                        if scheduleDetailViewModel.idealScheduleDetailTitle.count != 0 && scheduleDetailViewModel.idealScheduleDetailTitle.count < 11 {
                            let startHour = scheduleDetailViewModel.idealStartTime.prefix(2)
                            let startMinute = scheduleDetailViewModel.idealStartTime.suffix(2)
                            let startTime = Int(startHour + startMinute)
                            let endHour = scheduleDetailViewModel.idealEndTime.prefix(2)
                            let endMinute = scheduleDetailViewModel.idealEndTime.suffix(2)
                            let endTime = Int(endHour + endMinute)
                            if Int(startTime!) < Int(endTime!) {
                                isEditMode = false
                                setting.isReload = true
                            }
                        } else {
                            // タイトル入力に問題がある場合は何もしない
                        }
                    }
                )
            }
        }
        .onAppear{
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            screenSizeObject.screenSize = window.bounds.size
        }
    }
    
    func update() {
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue(label: "realm").async {
            scheduleDetailViewModel.updateIdealScheduleDetail { success in
                group.leave()
                
                if success {
                    print("非同期処理成功")
                    // 最新のデータ取得処理
                    bindViewModel()
                } else {
                    print("非同期処理失敗")
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        alertMessage = NSLocalizedString("SystemErrorHasOccurred", comment: "")
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
                        alertMessage = NSLocalizedString("UpdateCompleted", comment: "")
                        showAlert = true
                    }
                } else {
                    print("非同期処理失敗")
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        showAlert = true
                        alertMessage = NSLocalizedString("FailedToObtainTheUpdatedSchedule", comment: "")
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
