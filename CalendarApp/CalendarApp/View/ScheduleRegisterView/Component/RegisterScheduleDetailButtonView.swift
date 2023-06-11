//
//  RegisterScheduleDetailButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/11.
//

import SwiftUI

struct RegisterScheduleDetailButtonView: View {
    
    var body: some View {
        
        Button(action: {
            
        }) {
            Text("登録")
                .frame(width: 50, height: 30)
        }
        .offset(x:0,y:105)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding() // ボタンの余白を調整        
    }
}
