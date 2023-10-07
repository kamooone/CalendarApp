//
//  LanguageSwitchButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI

struct LanguageSwitcButtonView: View {
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    
    var body: some View  {
        HStack {
            // ToDo ボタンではなく、ラジオボタンで言語切り替えできるようにここに表示させる
            Button(action: {
                
            }) {
                Text(LocalizedStringKey("LanguageChange"))
                    .frame(width: screenSizeObject.screenSize.width * 0.8, height: screenSizeObject.screenSize.height / 20)
                    .font(.system(size: screenSizeObject.screenSize.width / 20))
            }
            .offset(x: 0, y: 0)
            .buttonStyle(NormalButtonStyle.normalButtonStyle())
            .padding()
        }
        .onAppear {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            screenSizeObject.screenSize = window.bounds.size
        }
    }
}
