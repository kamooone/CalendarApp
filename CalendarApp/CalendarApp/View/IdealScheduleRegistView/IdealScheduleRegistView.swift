//
//  IdealScheduleRegistView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI

struct IdealScheduleRegistView: View {
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    let headerTitle: String = "のスケジュール"
    
    var body: some View {
        Color.lightGray.edgesIgnoringSafeArea(.all)
        VStack {
            HStack {
                BackButtonView()
                    .offset(x:0, y:20)
            }
            HStack {
                HeaderView(_headerTitle: scheduleDetailViewModel.idealScheduleTitle + headerTitle)
                    .offset(x:0, y:40)
            }
            VStack {
                HStack {
                    IdealScheduleDetailTitleView()
                }
                HStack {
                    IdealScheduleTimeView()
                }
                HStack {
                    IdealNoticeSettingView()
                }
                
                HStack {
                    Spacer()
                    IdealAppendScheduleDetailButtonView()
                        .offset(x:0, y:0)
                    Spacer()
                }
                
                HStack {
                    Spacer()
                    IdealConfirmScheduleDetailButtonView()
                        .offset(x:0, y:0)
                    Spacer()
                }
                .frame(width: screenSizeObject.screenSize.width, height: screenSizeObject.screenSize.height / 3)
                .background(Color.lightWhite)
                .offset(x: 0, y: 0)
                
                Spacer()
            }
            .offset(x:0,y:50)
            
            HStack {
                BannerAdsView()
                    .frame(width: screenSizeObject.screenSize.width, height: screenSizeObject.screenSize.height * 0.1)
                    .background(Color.yellow)
                    .offset(x: 0, y: -25)
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

struct IdealScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        IdealScheduleRegistView()
    }
}
