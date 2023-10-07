//
//  IdealCanselButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/08/13.
//

import SwiftUI

struct CanselIdealButtonView: View {
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    @Binding var isEditMode: Bool
    
    var body: some View  {
        HStack {
            Spacer()
            Button(action: {
                isEditMode = false
            }) {
                Text(LocalizedStringKey("Cancel"))
                    .frame(width: screenSizeObject.screenSize.width / 8, height: screenSizeObject.screenSize.height / 20)
                    .font(.system(size: screenSizeObject.screenSize.width / 40))
            }
            .offset(x: 30, y: 0)
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
