//
//  RegisterScheduleDetailButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/11.
//

import SwiftUI
import RealmSwift

struct RegisterScheduleDetailButtonView: View {
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        // ToDo タイトル未入力だとエラー表示させる。時間の設定がおかしい時もエラー表示させる。
        Button(action: {
            regist()
        }) {
            Text("登録")
                .frame(width: 50, height: 30)
        }
        .offset(x:0,y:105)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("メッセージ"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    func regist() {
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue(label: "realm").async {
            scheduleDetailViewModel.registerScheduleDetail { success in
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
            print("非同期処理終了")
            showAlert = true
        }
    }
}
