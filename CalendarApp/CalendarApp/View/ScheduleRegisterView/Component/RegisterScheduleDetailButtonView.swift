//
//  RegisterScheduleDetailButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/11.
//

import SwiftUI
import RealmSwift

struct RegisterScheduleDetailButtonView: View {
    @Binding var isShouldReloadView: Int
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isReload: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                
                Button(action: {
                    if scheduleDetailViewModel.scheduleDetailTitle.count != 0 && scheduleDetailViewModel.scheduleDetailTitle.count < 11 {
                        // 開始より終了の方が早い場合のエラーアラートも追加。
                        let startHour = scheduleDetailViewModel.startTime.prefix(2)
                        let startMinute = scheduleDetailViewModel.startTime.suffix(2)
                        let startTime = Int(startHour + startMinute)
                        let endHour = scheduleDetailViewModel.endTime.prefix(2)
                        let endMinute = scheduleDetailViewModel.endTime.suffix(2)
                        let endTime = Int(endHour + endMinute)
                        if Int(startTime!) < Int(endTime!) {
                            regist()
                        } else {
                            showAlert = true
                            alertMessage = "開始時間より終了時間が後になるように設定してください。"
                        }
                    } else {
                        showAlert = true
                        if scheduleDetailViewModel.scheduleDetailTitle.count == 0 {
                            alertMessage = "タイトルの入力は必須です。"
                        } else {
                            alertMessage = "タイトルは10文字以内で入力してください。"
                        }
                    }
                }) {
                    Text("追加")
                        .font(.system(size: geometry.size.width / 25))
                        .frame(width: geometry.size.width / 2, height: geometry.size.height)
                }
                .buttonStyle(NormalButtonStyle.normalButtonStyle())
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(alertMessage),
                        dismissButton: .default(Text("OK")) {
                            if isReload {
                                isShouldReloadView += 1
                            }
                        }
                    )
                }
                .offset(x:0, y:-40)
                
                Spacer()
            }
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
                        isReload = true
                        showAlert = true
                    }
                } else {
                    print("非同期処理失敗")
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        alertMessage = "登録に失敗しました"
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
