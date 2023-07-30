//
//  HamburgerMenu.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/05/30.
//

import SwiftUI

struct HamburgerView: View {
    @EnvironmentObject var route: RouteObserver
    @State private var imageSize: CGSize = CGSize(width: 24, height: 24)
    
    var body: some View  {
        GeometryReader { geometry in
            let xOffset = geometry.size.width - imageSize.width * 3
            
            Button(action: {
                route.path = .Setting
            }) {
                if let image = UIImage(named: "hamburger") {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: imageSize.width, height: imageSize.height)
                } else {
                    Image(systemName: "photo")
                }
            }
            .buttonStyle(NormalButtonStyle.normalButtonStyle())
            .padding() // ボタンの余白を調整
            .onAppear {
                // 画像が表示されるサイズを端末の幅に合わせる
                imageSize = CGSize(width: geometry.size.width / 20, height: geometry.size.width / 20)
            }
            .offset(x: xOffset, y: 0)
        }
    }
}
