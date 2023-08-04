//
//  CancelButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/01.
//

import SwiftUI

struct CancelButtonView: View {
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    @Binding var isEditMode: Bool
    
    var body: some View  {
        HStack {
            Spacer()
            Button(action: {
                isEditMode = false
            }) {
                Text("キャンセル")
                    .frame(width: screenSizeObject.screenSize.width / 6, height: screenSizeObject.screenSize.height / 25)
                    .font(.system(size: screenSizeObject.screenSize.width / 30))
            }
            .offset(x: screenSizeObject.screenSize.width / 3, y: 0)
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
