//
//  IdealRegisteredScheduleTitleView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/20.
//

import SwiftUI

struct IdealRegisteredScheduleTitleView: View {
    @EnvironmentObject var route: RouteObserver
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @State private var text = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("登録済みの理想のスケジュール")
                    .font(.system(size: 16))
                    .offset(x: 0, y: 20)
            }
            
            // ToDo 過去に登録したスケジュールをfor文で表示させて、さらにそれぞれ編集と削除もできるようにする。
            
            Spacer()
        }
    }
}
