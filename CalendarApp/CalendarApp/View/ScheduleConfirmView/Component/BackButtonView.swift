//
//  BackButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/05/31.
//

import SwiftUI

struct BackButtonView: View {
    @EnvironmentObject var route: RouteObserver
    
    var body: some View  {
        Button(action: {
            // ルートをカレンダーに変更
            route.path = .Calendar
        }) {
            if let image = UIImage(named: "back") {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
            } else {
                // 画像が見つからない場合にはシステムのデフォルト画像を表示します
                Image(systemName: "photo")
            }
        }
        .offset(x:0,y:-20)
        .buttonStyle(SmallButtonStyle.smallButtonStyle())
        .padding() // ボタンの余白を調整
    }
}

struct BackButtonView_Previews: PreviewProvider {
    static var previews: some View {
        BackButtonView()
    }
}
