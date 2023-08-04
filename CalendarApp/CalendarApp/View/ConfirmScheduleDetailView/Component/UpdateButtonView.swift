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
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View  {
        HStack {
            Spacer()
            
            Button(action: {
                update()
            }) {
                Text("更新")
                    .frame(width: screenSizeObject.screenSize.width / 10, height: screenSizeObject.screenSize.height / 25)
                    .font(.system(size: screenSizeObject.screenSize.width / 25))
            }
            .offset(x: 0, y: 0)
            .buttonStyle(NormalButtonStyle.normalButtonStyle())
            .padding()
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(alertMessage),
                    dismissButton: .default(Text("OK")) {
                        isEditMode = false
                    }
                )
            }
        }
        .onAppear {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            screenSizeObject.screenSize = window.bounds.size
        }
    }
    
    func update() {
        let calendarViewModel = CalendarViewModel.shared
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue(label: "realm").async {
            scheduleDetailViewModel.UpdateScheduleDetail(_year: String(calendarViewModel.selectYear), _month: String(calendarViewModel.selectMonth), _day: String(calendarViewModel.selectDay)) { success in
                group.leave()
                
                DispatchQueue.main.async {
                    withAnimation {
                        if success {
                            alertMessage = "更新が完了しました"
                        } else {
                            alertMessage = "更新に失敗しました"
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
