//
//  EditButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/29.
//

import SwiftUI

struct EditButtonView: View {
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    @Binding var isEditMode: Bool
    
    var body: some View  {
        HStack {
            Spacer()
            
            Button(action: {
                isEditMode = true
            }) {
                Text("修正")
                    .frame(width: screenSizeObject.screenSize.width / 10, height: screenSizeObject.screenSize.height / 25)
                    .font(.system(size: screenSizeObject.screenSize.width / 25))
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
