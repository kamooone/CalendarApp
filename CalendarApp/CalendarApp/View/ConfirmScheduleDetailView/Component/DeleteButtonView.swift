//
//  DeleteButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/09.
//

import SwiftUI
import RealmSwift

struct DeleteButtonView: View {
    let _id: String
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
                    
                }
            )
        }
        .onAppear {
            scheduleDetailViewModel.uniqueId = _id
        }
    }
    
    func delete() {
        let scheduleDetailViewModel = ScheduleDetailViewModel.shared
        let calendarViewModel = CalendarViewModel.shared
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue(label: "realm").async {
            scheduleDetailViewModel.DeleteScheduleDetail(_year: String(calendarViewModel.selectYear), _month: String(calendarViewModel.selectMonth), _day: String(calendarViewModel.selectDay)) { success in
                group.leave()
                
                DispatchQueue.main.async {
                    withAnimation {
                        if success {
                            alertMessage = "削除が完了しました"
                        } else {
                            alertMessage = "削除に失敗しました"
                        }
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
