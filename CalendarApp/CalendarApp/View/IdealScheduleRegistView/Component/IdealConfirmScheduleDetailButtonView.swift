//
//  IdealConfirmScheduleDetailButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI

struct IdealConfirmScheduleDetailButtonView: View {
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    @EnvironmentObject var route: RouteObserver
    
    var body: some View {
        HStack {
            Button(action: {
                route.path = .IdealConfirmScheduleDetail
            }) {
                Text(LocalizedStringKey("CheckCurrentAdditionStatus"))
                    .frame(width: screenSizeObject.screenSize.width * 0.8, height: screenSizeObject.screenSize.height / 20)
            }
            .offset(x:0,y:0)
            .buttonStyle(NormalButtonStyle.normalButtonStyle())
            .padding() // ボタンの余白を調整
        }
        .onAppear{
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            screenSizeObject.screenSize = window.bounds.size
        }
    }
}
