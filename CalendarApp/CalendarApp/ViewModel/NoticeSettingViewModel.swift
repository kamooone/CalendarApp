//
//  NoticeSettingViewModel.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/08/14.
//

import SwiftUI

final class NoticeSettingViewModel: ObservableObject {
    //Action trigger for request API
    static let shared = NoticeSettingViewModel()
    
    //==================================================================================
    // UNUserNotificationCenterを使用して通知の許可をリクエストし、ユーザーが許可したかどうかを確認
    //==================================================================================
    func noticeInit(){
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        center.requestAuthorization(options: options) { granted, error in
            if granted {
                print("許可されました！")
            }else{
                print("拒否されました...")
            }
        }
    }
    
    //==================================================================================
    // 通知内容を登録するメソッド
    //==================================================================================
    func sendNotificationRequest(){
        let content = UNMutableNotificationContent()
        content.title = "通知のタイトルです"
        content.body = "通知の内容です"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "通知No.1", content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
    }
}

