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
        
        Button(action: {
            if scheduleDetailViewModel.registerScheduleDetail() == 0 {
                alertMessage = "登録が成功しました"
            } else {
                alertMessage = "登録に失敗しました"
            }
            showAlert = true
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
}
