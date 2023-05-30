//
//  HamburgerMenu.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/05/30.
//

import SwiftUI

struct HamburgerView: View {
    
    var body: some View  {
        Button(action: {
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
        .buttonStyle(SmallButtonStyle()) // ボタンのスタイルを適用
        .padding() // ボタンの余白を調整
    }
}

struct SmallButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.primary)
            .padding(8)
            .background(Color.secondary.opacity(0.5))
            .cornerRadius(8)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0) // 押された時に縮小するアニメーションを追加
    }
}

struct HamburgerView_Previews: PreviewProvider {
    static var previews: some View {
        HamburgerView()
    }
}
