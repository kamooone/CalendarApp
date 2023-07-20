//
//  MainView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/05/28.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var route: RouteObserver
    @EnvironmentObject var setting: Setting
    
    var body: some View {
        ZStack{
            if setting.isLoading {
                SplashView()
            }
            else {
                switch route.path {
                case .Loading:
                    LoadingView()
                case .Calendar:
                    CalendarView()
                case .ScheduleConfirm:
                    ScheduleRegisterView()
                case .ConfirmScheduleDetail:
                    ConfirmScheduleDetailView()
                case .Setting:
                    SettingView()
                case .IdealScheduleEnterTitle:
                    IdealScheduleTitleView()
                case .IdealSchedule:
                    IdealScheduleRegistView()
                case .IdealConfirmScheduleDetail:
                    IdealConfirmScheduleDetailView()
                }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView().environmentObject(RouteObserver()).environmentObject(Setting())
    }
}

struct LoadingView: View{
    ///引数でmessageを指定した場合はそちらが優先される
    var message = "loading画面です。"//.localized()
    
    var body: some View {
        VStack{
            Text(message).color(.red)
            ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
                .frame(width: 50, height: 50)
                .color(.white)
        }
            //値が大きいほど前面(z軸)に表示される
            .zIndex(1)
            .matchParentSize()
            .background(Color.black.opacity(0.5))
    }
}
