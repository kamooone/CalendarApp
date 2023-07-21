//
//  SelectIdealScheduleTitle.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/21.
//

import SwiftUI

struct SelectIdealScheduleTitle: View {
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    
    var body: some View {
        Text(scheduleDetailViewModel.idealScheduleTitle)
            .font(.system(size: 24))
            .offset(x: 0, y: -40)
    }
}
