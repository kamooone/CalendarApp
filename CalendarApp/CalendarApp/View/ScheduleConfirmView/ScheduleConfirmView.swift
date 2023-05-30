//
//  ScheduleConfirmView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/05/31.
//

import SwiftUI

struct ScheduleConfirmView: View {
    let calendarViewModel = CalendarViewModel.shared
    
    var body: some View {
        VStack {
            HStack {
                BackButtonView()
                Spacer()
            }
            HStack {
                Spacer()
                Text("スケジュール登録")
                    .font(.system(size: 24))
                    .offset(x: 0, y: -60)
                Spacer()
            }
            VStack {
                Spacer()
                Text("\(calendarViewModel.selectMonth)月\(calendarViewModel.selectDay)日")
                    .font(.system(size: 24))
                    .offset(x: 0, y: -60)
                Spacer()
            }
            Spacer()
        }
    }
}

struct ScheduleConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleConfirmView()
    }
}
