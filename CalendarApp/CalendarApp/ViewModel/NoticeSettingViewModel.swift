//
//  NoticeSettingViewModel.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/08/14.
//

import SwiftUI
import UserNotifications

class ForegroundNotificationDelegate:NSObject,UNUserNotificationCenterDelegate{
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        //completionHandler([.alert, .list, .badge, .sound]) //~iOS13
        completionHandler([.banner, .list, .badge, .sound]) //iOS14~
    }
}

final class NoticeSettingViewModel: ObservableObject {
    //Action trigger for request API
    static let shared = NoticeSettingViewModel()
    var notificationDelegate = ForegroundNotificationDelegate()
    
    //==================================================================================
    // UNUserNotificationCenterを使用して通知の許可をリクエストし、ユーザーが許可したかどうかを確認
    //==================================================================================
    func noticeInit(){
        let center = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        center.requestAuthorization(options: options) { granted, error in
            if granted {
                print("許可されました！")
                //フォアグラウンド通知用、バックグラウンドのみなら不要
                UNUserNotificationCenter.current().delegate = self.notificationDelegate
            }else{
                print("拒否されました...")
            }
        }
    }
    
    //==================================================================================
    // 通知内容を登録するメソッド
    //==================================================================================
    func sendNotificationRequest() {
        let content = UNMutableNotificationContent()
        content.title = "通知タイトルテスト"
        content.body = "通知の内容テスト"
        
        var dateComponents = DateComponents()
        dateComponents.year = 2023
        dateComponents.month = Int.random(in: 9..<12)
        dateComponents.day = Int.random(in: 1..<28)
        dateComponents.hour = Int.random(in: 0..<23)
        dateComponents.minute = Int.random(in: 0..<60)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let randomInt = Int.random(in: 1..<1000)
        let request = UNNotificationRequest(identifier: String(randomInt), content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
        // 登録済みの通知一覧確認
        let center = UNUserNotificationCenter.current()
        center.getPendingNotificationRequests { (requests: [UNNotificationRequest]) in
            if requests.isEmpty {
                print("No pending notification requests.")
            } else {
                for request in requests {
                    // 各通知リクエストの情報を確認するための処理
                    print("Identifier: \(request.identifier)")
                    print("Content: \(String(describing: request.content))")
                    print("Trigger: \(String(describing: request.trigger))")
                    print("-----")
                }
            }
        }
    }
    
    //==================================================================================
    // 登録済みの通知削除
    //==================================================================================
    func deleteNotificationRequest() {
        // ToDo 削除したい通知のidentifierを求める処理
        let identifierToRemove = "510"
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifierToRemove])
    }
    
}

