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
            scheduleDetailViewModel.idealScheduleTitle = _titleStr
            scheduleDetailViewModel.isIdealScheduleUpdate = true
            bindViewModel()
        }) {
            Text("修正")
                .font(.system(size: 12))
                .frame(width: 60, height: 30)
        }
        .offset(x: 30, y: 0)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding()
    }
    
    func bindViewModel() {
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue(label: "realm").async {
            scheduleDetailViewModel.getIdealScheduleDetail { success in
                group.leave()
                
                if success {
                    print("非同期処理成功")
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        route.path = .IdealSchedule
                    }
                } else {
                    print("非同期処理失敗")
                    // ToDo 取得失敗エラーアラート表示
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        
                    }
                }
            }
        }
        
        // 成功失敗に関わらず呼ばれる
        group.notify(queue: .main) {
            // ToDo 失敗エラーアラート表示
            print("非同期処理終了")
        }
    }
}
