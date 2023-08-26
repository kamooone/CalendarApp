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
    func sendNotificationRequest(_scheduleDetailData: ScheduleDetailData) {
        let calendarViewModel = CalendarViewModel.shared
        
        let content = UNMutableNotificationContent()
        content.title = _scheduleDetailData.scheduleDetailTitle
        content.body = "スケジュール5分前です。準備は出来ていますか？" // ToDo 文言の変更または文言を自由に出来るようにする改善あり
        
        var dateComponents = DateComponents()
        dateComponents.year = calendarViewModel.selectYear
        dateComponents.month = calendarViewModel.selectMonth
        dateComponents.day = calendarViewModel.selectDay
        // ToDo 5分前にする
        dateComponents.hour = Int(_scheduleDetailData.startTime.prefix(2))
        dateComponents.minute = Int(_scheduleDetailData.startTime.suffix(2))
        let identifier = String(describing: _scheduleDetailData.id)
        
        // ToDo 登録済みの通知の時間の修正更新した時にうまく通知設定ができてない？
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(request)
        
        // 登録済みの通知一覧確認(デバッグ用、本日のスケジュール一覧表時でも使用すると思う)
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
    func deleteNotificationRequest(_scheduleDetailData: ScheduleDetailData) {
        let identifierToRemove = String(describing: _scheduleDetailData.id)
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [identifierToRemove])
    }
    
}

