//
//  IdealScheduleRegistButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI

struct IdealScheduleRegistButtonView: View {
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View  {
        Button(action: {
            if scheduleDetailViewModel.isIdealScheduleUpdate {
                update()
            } else {
                regist()
            }
        }) {
            Text("理想のスケジュールを登録")
                .frame(width: 200, height: 30)
        }
        .offset(x: 0, y: 0)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertMessage),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
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
                        alertMessage = "登録が成功しました"
                    }
                } else {
                    print("非同期処理失敗")
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        alertMessage = "登録に失敗しました"
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
    
    func update() {
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue(label: "realm").async {
            // ToDo 理想のスケジュール用の登録処理修正(登録済みのスケジュールは新規登録ではなくて更新になるようにする)
            scheduleDetailViewModel.updateIdealScheduleDetail { success in
                group.leave()
                
                if success {
                    print("非同期処理成功")
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        alertMessage = "登録が成功しました"
                    }
                } else {
                    print("非同期処理失敗")
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        alertMessage = "登録に失敗しました"
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
