//
//  EditButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/29.
//

import SwiftUI

struct EditButtonView: View {
    @Binding var isEditMode: Bool
    
    var body: some View  {
        Button(action: {
            isEditMode = true
        }) {
            Text("修正")
                .frame(width: 50, height: 30)
        }
        .offset(x: 0, y: -100)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding()
    }
}
