//
//  CancelButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/01.
//

import SwiftUI

struct CancelButtonView: View {
    @Binding var isEditMode: Bool
    
    var body: some View  {
        Button(action: {
            isEditMode = false
        }) {
            Text("キャンセル")
                .font(.system(size: 12))
                .frame(width: 60, height: 30)
        }
        .offset(x: 40, y: -100)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding()
    }
}
