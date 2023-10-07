//
//  IdealAppendScheduleDetailButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI
import RealmSwift

struct IdealAppendScheduleDetailButtonView: View {
    @Binding var isShouldReloadView: Int
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isReload: Bool = false
    
    var body: some View {
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
                        regist()
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
                Text(LocalizedStringKey("Add"))
                    .frame(width: screenSizeObject.screenSize.width / 8, height: screenSizeObject.screenSize.height / 20)
                    .font(.system(size: screenSizeObject.screenSize.width / 25))
            }
            .offset(x:0,y:0)
            .buttonStyle(NormalButtonStyle.normalButtonStyle())
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(alertMessage),
                    dismissButton: .default(Text("OK")){
                        if isReload {
                            isShouldReloadView += 1
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
    
    func regist() {
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue(label: "realm").async {
            scheduleDetailViewModel.registerIdealScheduleDetail { success in
                group.leave()
                
                if success {
                    print("非同期処理成功")
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        alertMessage = NSLocalizedString("RegistrationSuccessful", comment: "")
                        isReload = true
                        showAlert = true
                    }
                } else {
                    print("非同期処理失敗")
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        alertMessage = NSLocalizedString("SignupFailed", comment: "")
                        showAlert = true
                    }
                }
            }
        }
        
        group.notify(queue: .main) {
            print("非同期処理終了")
        }
    }
}
