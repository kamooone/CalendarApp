//
//  DeleteIdealScheduleButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/21.
//

import SwiftUI
import RealmSwift

struct DeleteIdealScheduleButtonView: View {
    @EnvironmentObject var setting: Setting
    let _titleStr: String
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View  {
        Button(action: {
            idealDelete()
        }) {
            Text(LocalizedStringKey("Delete"))
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
    
    func idealDelete() {
        let scheduleDetailViewModel = ScheduleDetailViewModel.shared
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue(label: "realm").async {
            scheduleDetailViewModel.DeleteIdealSchedule(_titleStr: _titleStr) { success in
                group.leave()
                
                DispatchQueue.main.async {
                    withAnimation {
                        if success {
                            alertMessage = NSLocalizedString("DeletionCompleted", comment: "")
                        } else {
                            alertMessage = NSLocalizedString("DeletionFailed", comment: "")
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
