//
//  DeleteIdealDetailScheduleButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/22.
//

import SwiftUI
import RealmSwift

struct DeleteIdealDetailScheduleButtonView: View {
    @EnvironmentObject var setting: Setting
    let _id: Int
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View  {
        Button(action: {
            delete()
        }) {
            Text("削除")
                .font(.system(size: 12))
                .frame(width: 60, height: 30)
        }
        .offset(x: 0, y: 0)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    setting.isReload = true
                }
            )
        }
    }
    
    func delete() {
        let scheduleDetailViewModel = ScheduleDetailViewModel.shared
        
        scheduleDetailViewModel.idealScheduleDetailTitleArray.remove(at: _id)
        scheduleDetailViewModel.idealStartTimeArray.remove(at: _id)
        scheduleDetailViewModel.idealEndTimeArray.remove(at: _id)
        scheduleDetailViewModel.idealIsNoticeArray.remove(at: _id)
        alertMessage = "削除が完了しました"
        showAlert = true
    }
}
