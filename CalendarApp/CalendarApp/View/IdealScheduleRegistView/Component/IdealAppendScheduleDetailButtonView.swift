//
//  IdealAppendScheduleDetailButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI
import RealmSwift

struct IdealAppendScheduleDetailButtonView: View {
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        // ToDo タイトル未入力だとエラー表示させる。時間の設定がおかしい時もエラー表示させる。
        // ToDo 登録完了したら入力内容を初期化する
        Button(action: {
            // この時に行うのはappendのみで、Realmにはまだ保存しない
            regist()
        }) {
            Text("追加")
                .frame(width: 50, height: 30)
        }
        .offset(x:0,y:105)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    func regist() {
        let scheduleDetailViewModel = ScheduleDetailViewModel.shared
        scheduleDetailViewModel.idealScheduleDetailTitleArray.append(scheduleDetailViewModel.idealScheduleDetailTitle)
        scheduleDetailViewModel.idealStartTimeArray.append(scheduleDetailViewModel.idealStartTime)
        scheduleDetailViewModel.idealEndTimeArray.append(scheduleDetailViewModel.idealEndTime)
        scheduleDetailViewModel.idealIsNoticeArray.append(scheduleDetailViewModel.idealIsNotice)
        
        // 編集画面で更新用にバックアップを取っておく
        scheduleDetailViewModel.updScheduleDetailTitleArray.append(scheduleDetailViewModel.idealScheduleDetailTitle)
        scheduleDetailViewModel.updStartTimeArray.append(scheduleDetailViewModel.idealStartTime)
        scheduleDetailViewModel.updEndTimeArray.append(scheduleDetailViewModel.idealEndTime)
        scheduleDetailViewModel.updIsNoticeArray.append(scheduleDetailViewModel.idealIsNotice)
        
        alertMessage = "追加しました"
        showAlert = true
    }
}
