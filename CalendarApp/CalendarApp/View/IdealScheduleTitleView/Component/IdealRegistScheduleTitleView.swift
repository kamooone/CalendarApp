//
//  IdealRegistScheduleTitleView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/20.
//

import SwiftUI

struct IdealRegistScheduleTitleView: View {
    @Binding var isShouldReloadView: Int
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    @EnvironmentObject var route: RouteObserver
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @State private var text = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var isReload: Bool = false
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text(LocalizedStringKey("EnterTheTitleOfYourIdealSchedule"))
                    .font(.system(size: screenSizeObject.screenSize.width / 20))
                    .offset(x: 0, y: 0)
            }
            
            HStack {
                TextField(LocalizedStringKey("ExampleIdealScheduleForHolidayA"), text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .offset(x: 5, y: 0)
                    .onChange(of: text) { newValue in
                        scheduleDetailViewModel.idealScheduleTitle = newValue
                    }
            }
            
            HStack {
                Button(action: {
                    if scheduleDetailViewModel.idealScheduleTitle.count != 0 && scheduleDetailViewModel.idealScheduleTitle.count < 11 {
                        route.path = .IdealSchedule
                    } else {
                        showAlert = true
                        if scheduleDetailViewModel.idealScheduleTitle.count == 0 {
                            alertMessage = "EnteringTitleIsRequired"
                        } else {
                            alertMessage = "PleaseEnterTheTitleWithin10Characters"
                        }
                    }
                }) {
                    Text(LocalizedStringKey("Next"))
                        .frame(width: screenSizeObject.screenSize.width / 10, height: screenSizeObject.screenSize.height / 30)
                        .font(.system(size: screenSizeObject.screenSize.width / 40))
                }
                .offset(x: 0, y: 0)
                .buttonStyle(NormalButtonStyle.normalButtonStyle())
                .padding()
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text(alertMessage),
                        dismissButton: .default(Text("OK")){
                            showAlert = false
                            alertMessage = ""
                        }
                    )
                }
            }
            Spacer()
        }
        .onAppear{
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            screenSizeObject.screenSize = window.bounds.size
        }
    }
}
