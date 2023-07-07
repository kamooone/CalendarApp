//
//  RegisterButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/01.
//

import SwiftUI

struct UpdateButtonView: View {
    @Binding var isEditMode: Bool
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View  {
        Button(action: {
            isEditMode = false
            update()
        }) {
            Text("更新")
                .frame(width: 50, height: 30)
        }
        .offset(x: 10, y: -100)
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
    
    func update() {
        let calendarViewModel = CalendarViewModel.shared
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue(label: "realm").async {
            scheduleDetailViewModel.UpdateScheduleDetail(_year: String(calendarViewModel.selectYear), _month: String(calendarViewModel.selectMonth), _day: String(calendarViewModel.selectDay)) { success in
                group.leave()
                
                if success {
                    print("非同期処理成功")
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        // ToDo 更新しましたポップアップが表示されないので確認する
                        alertMessage = "更新が完了しました"
                    }
                } else {
                    print("非同期処理失敗")
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        alertMessage = "更新に失敗しました"
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
