//
//  MiniGameButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI

struct MiniGameButtonView: View {
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    
    var body: some View  {
        HStack {
            Button(action: {
                // ToDo 資金不足のため、Coming soon　というポップアップを表示させる
                
            }) {
                Text("ミニゲーム")
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
