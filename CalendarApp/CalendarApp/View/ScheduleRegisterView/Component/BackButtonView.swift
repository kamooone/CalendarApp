//
//  BackButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/05/31.
//

import SwiftUI

struct BackButtonView: View {
    @EnvironmentObject var route: RouteObserver

    var body: some View {
        GeometryReader { geometry in // GeometryReaderを使用して親ビューのサイズを取得
            Button(action: {
                // ルートをカレンダーに変更
                if route.path == .ConfirmScheduleDetail {
                    route.path = .ScheduleConfirm
                } else if route.path == .ScheduleConfirm {
                    route.path = .Calendar
                } else if route.path == .Setting {
                    route.path = .Calendar
                } else if route.path == .IdealSchedule {
                    route.path = .IdealScheduleEnterTitle
                } else if route.path == .IdealConfirmScheduleDetail {
                    route.path = .IdealSchedule
                } else if route.path == .IdealScheduleEnterTitle {
                    route.path = .Setting
                }
            }) {
                if let image = UIImage(named: "back") {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: geometry.size.width / 20, height: geometry.size.width / 20)
                } else {
                    // 画像が見つからない場合にはシステムのデフォルト画像を表示します
                    Image(systemName: "photo")
                }
            }
            .offset(x: geometry.size.width * 0.01, y: geometry.size.width * 0.01)
            .buttonStyle(NormalButtonStyle.normalButtonStyle())
            .padding() // ボタンの余白を調整
        }

        Spacer()
    }
}
