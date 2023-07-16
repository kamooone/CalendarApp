//
//  SettingView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI

struct SettingView: View {
    
    let headerTitle: String = "設定"
    
    var body: some View {
        GeometryReader { geometry in
            // ToDo 間間に書くボタンの説明をしてるキャラクターを表示させる
            VStack {
                HStack {
                    BackButtonView()
                }
                HStack {
                    HeaderView(_headerTitle: headerTitle)
                }
                HStack {
                    IdealScheduleButtonView()
                }
                HStack {
                    MiniGameButtonView()
                }
                HStack {
                    LanguageSwitcButtonView()
                }
                HStack {
                    CharacterSwitchingButtonView()
                }
                HStack {
                    DonationButtonView()
                }
                HStack {
                    InquiryButtonView()
                }

                Spacer()
                
                BannerAdsView()
                    .frame(width: geometry.size.width, height: 80)
                    .background(Color.yellow)
                    .offset(x: 0, y: -70)
                

            }
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
