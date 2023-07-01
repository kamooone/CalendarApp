//
//  RegisterButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/01.
//

import SwiftUI

struct UpdateButtonView: View {
    @Binding var isEditMode: Bool
    
    var body: some View  {
        Button(action: {
            isEditMode = false
            // ToDo DB更新処理
            
            // ToDo 更新しましたポップアップ表示
            
        }) {
            Text("更新")
                .frame(width: 50, height: 30)
        }
        .offset(x: 10, y: -100)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding()
    }
}
