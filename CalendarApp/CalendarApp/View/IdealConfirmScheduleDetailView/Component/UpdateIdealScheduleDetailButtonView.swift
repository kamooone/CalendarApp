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
                update()
            }) {
                Text("更新")
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
                        isEditMode = false
                        setting.isReload = true
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
                        alertMessage = "システムエラーが発生しました。"
                        showAlert = true
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
                        alertMessage = "更新が完了しました"
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
            showAlert = true
        }
    }
}
