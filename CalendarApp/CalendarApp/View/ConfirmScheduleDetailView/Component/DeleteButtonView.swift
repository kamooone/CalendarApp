//
//  DeleteButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/09.
//

import SwiftUI
import RealmSwift

struct DeleteButtonView: View {
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    @EnvironmentObject var setting: Setting
    let _id: String
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View  {
        HStack {
            Spacer()
            Button(action: {
                delete()
            }) {
                Text(LocalizedStringKey("Delete"))
                    .frame(width: screenSizeObject.screenSize.width / 10, height: screenSizeObject.screenSize.height / 40)
                    .font(.system(size: screenSizeObject.screenSize.width / 30))
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
            Spacer()
        }
        .onAppear {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            screenSizeObject.screenSize = window.bounds.size
        }
    }
    
    func delete() {
        let scheduleDetailViewModel = ScheduleDetailViewModel.shared
        let calendarViewModel = CalendarViewModel.shared
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue(label: "realm").async {
            scheduleDetailViewModel.DeleteScheduleDetail(_year: String(calendarViewModel.selectYear), _month: String(calendarViewModel.selectMonth), _day: String(calendarViewModel.selectDay), _uniqueId: String(_id)) { success in
                group.leave()
                
                DispatchQueue.main.async {
                    withAnimation {
                        if success {
                            alertMessage = "DeletionCompleted"
                        } else {
                            alertMessage = "DeletionFailed"
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
