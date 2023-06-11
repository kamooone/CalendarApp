//
//  RegisterNoticeView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/06.
//

import SwiftUI

struct NoticeSettingView: View {
    @State private var isSwitchOn = false
    
    var body: some View {
        VStack {
            Toggle("通知", isOn: $isSwitchOn)
                .offset(x:0,y:60)
                .padding(.horizontal, 100)
        }
    }
}
