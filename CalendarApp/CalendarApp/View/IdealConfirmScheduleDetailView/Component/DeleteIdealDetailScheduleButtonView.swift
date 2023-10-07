//
//  DeleteIdealDetailScheduleButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/22.
//

import SwiftUI
import RealmSwift

struct DeleteIdealDetailScheduleButtonView: View {
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    @EnvironmentObject var setting: Setting
    let _id: Int
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View  {
        HStack {
            Button(action: {
                delete()
            }) {
                Text(LocalizedStringKey("Delete"))
                    .frame(width: screenSizeObject.screenSize.width / 8, height: screenSizeObject.screenSize.height / 30)
                    .font(.system(size: screenSizeObject.screenSize.width / 25))
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
        .onAppear{
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            screenSizeObject.screenSize = window.bounds.size
        }
    }
    
    func delete() {
        let scheduleDetailViewModel = ScheduleDetailViewModel.shared
        
        scheduleDetailViewModel.idealScheduleDetailTitleArray.remove(at: _id)
        scheduleDetailViewModel.idealStartTimeArray.remove(at: _id)
        scheduleDetailViewModel.idealEndTimeArray.remove(at: _id)
        scheduleDetailViewModel.idealIsNoticeArray.remove(at: _id)
        alertMessage = NSLocalizedString("DeletionCompleted", comment: "")
        showAlert = true
    }
}
