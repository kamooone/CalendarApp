//
//  IdealScheduleTitleView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/20.
//

import SwiftUI

struct IdealScheduleTitleView: View {
    let headerTitle: String = "理想のスケジュール"
    
    // ToDo 2023/7/16 理想のスケジュール保存処理
    var body: some View {
        Color.lightGray.edgesIgnoringSafeArea(.all)
        GeometryReader { geometry in
            VStack {
                HStack {
                    BackButtonView()
                }
                HStack {
                    HeaderView(_headerTitle: headerTitle)
                }
                VStack {
                    ZStack {
                        IdealRegistScheduleTitleView()
                    }
                    .frame(width: geometry.size.width, height: 180)
                    .background(Color.lightWhite)
                    .offset(x: 0, y: -50)
                }
                // ToDo 過去に登録したスケジュールの編集と削除もできるようにする。
                
                BannerAdsView()
                    .frame(width: geometry.size.width, height: 80)
                    .background(Color.yellow)
                    .offset(x: 0, y: 0)
                
                Spacer()
            }
        }
    }
}
