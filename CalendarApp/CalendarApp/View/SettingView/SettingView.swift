//
//  SettingView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    let headerTitle: String = "設定"
    
    // ToDo 2023/8/5 表示正規化
    var body: some View {
        // ToDo 間間に書くボタンの説明をしてるキャラクターを表示させる
        VStack {
            HStack {
                BackButtonView()
                    .offset(x:0, y:20)
            }
            HStack {
                HeaderView(_headerTitle: headerTitle)
                    .offset(x:0, y:screenSizeObject.screenSize.height / 30 - 10)
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
            
            HStack {
                BannerAdsView()
                .frame(width: screenSizeObject.screenSize.width, height: screenSizeObject.screenSize.height * 0.1)
                .background(Color.yellow)
                .offset(x: 0, y: 0)
            }
            Spacer()
        }
        .onAppear {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            screenSizeObject.screenSize = window.bounds.size
        }
    }
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
