//
//  CancelButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/01.
//

import SwiftUI

struct CancelButtonView: View {
    var scheduleDetailViewModel: ScheduleDetailViewModel
    
    var body: some View  {
        Button(action: {
            scheduleDetailViewModel.isEditMode = false
        }) {
            Text("キャンセル")
                .font(.system(size: 16))
                .foregroundColor(.white)
                .padding()
        }
        .offset(x: 0, y: -100)
        .buttonStyle(MiniButtonStyle.miniButtonStyle())
        .padding()
    }
}
