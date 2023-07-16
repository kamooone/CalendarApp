//
//  HamburgerMenu.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/05/30.
//

import SwiftUI

struct HamburgerView: View {
    @EnvironmentObject var route: RouteObserver
    
    var body: some View  {
        Button(action: {
            route.path = .Setting
        }) {
            if let image = UIImage(named: "hamburger") {
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
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding() // ボタンの余白を調整
    }
}
