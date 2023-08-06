//
//  IdealRegistScheduleTitleView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/20.
//

import SwiftUI

struct IdealRegistScheduleTitleView: View {
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    @EnvironmentObject var route: RouteObserver
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @State private var text = ""
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Text("理想のスケジュールのタイトルを入力しよう")
                    .font(.system(size: screenSizeObject.screenSize.width / 20))
                    .offset(x: 0, y: 0)
            }
            
            HStack {
                // ToDo 未入力状態でボタンを押した場合は、赤文字で入力してくださいメッセージを表示させる
                TextField("例 : 休日Aの理想スケジュール", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .offset(x: 5, y: 0)
                    .onChange(of: text) { newValue in
                        scheduleDetailViewModel.idealScheduleTitle = newValue
                    }
            }
            
            HStack {
                Button(action: {
                    route.path = .IdealSchedule
                }) {
                    Text("次へ")
                        .frame(width: screenSizeObject.screenSize.width / 10, height: screenSizeObject.screenSize.height / 30)
                        .font(.system(size: screenSizeObject.screenSize.width / 40))
                }
                .offset(x: 0, y: 0)
                .buttonStyle(NormalButtonStyle.normalButtonStyle())
                .padding()
            }
            Spacer()
        }
        .onAppear{
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            screenSizeObject.screenSize = window.bounds.size
        }
    }
}
