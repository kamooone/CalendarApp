//
//  IdealScheduleDetailTitleView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI

struct IdealScheduleDetailTitleView: View {
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @State private var text = ""
    
    var body: some View {
        VStack {
            HStack {
                Text(LocalizedStringKey("AddSchedule!"))
                    .font(.system(size: screenSizeObject.screenSize.width / 20))
                    .offset(x: 0, y: 20)
            }
            
            HStack {
                Text(LocalizedStringKey("TITLE"))
                    .font(.system(size: screenSizeObject.screenSize.width / 20))
                    .offset(x: 20, y: 0)
                TextField(LocalizedStringKey("ExampleAfternoonShopping"), text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .offset(x: 5, y: 0)
                    .onChange(of: text) { newValue in
                        scheduleDetailViewModel.idealScheduleDetailTitle = newValue
                    }
                Spacer()
            }
        }
        .offset(x:0,y:0)
        .onAppear{
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            screenSizeObject.screenSize = window.bounds.size
        }
    }
}
