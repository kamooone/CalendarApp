//
//  EditIdealScheduleButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/21.
//

import SwiftUI

struct EditIdealScheduleButtonView: View {
    @EnvironmentObject var route: RouteObserver
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    let _titleStr: String
    
    var body: some View  {
        Button(action: {
            // ToDo 2023/7/21 この時点で_titleStrのデータを取得して、scheduleDetailViewModel各種に代入しておく。あとは既存のIdealScheduleRegistViewをそのまま使えると思う。(最後の登録のところだけ、更新にする必要？この時、編集モードというフラグを用意しておく？)
            scheduleDetailViewModel.idealScheduleTitle = _titleStr
            
            route.path = .IdealSchedule
        }) {
            Text("修正")
                .font(.system(size: 12))
                .frame(width: 60, height: 30)
        }
        .offset(x: 30, y: 0)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding()
    }
}
