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
        content.body = "スケジュール5分前です。準備は出来ていますか？"
        
        var dateComponents = DateComponents()
        dateComponents.year = calendarViewModel.selectYear
        dateComponents.month = calendarViewModel.selectMonth
        dateComponents.day = calendarViewModel.selectDay

        if let startTimeHour = Int(_scheduleDetailData.startTime.prefix(2)),
           let startTimeMinute = Int(_scheduleDetailData.startTime.suffix(2)) {
            let calendar = Calendar.current
            let targetDate = calendar.date(from: dateComponents) ?? Date()
            
            // 開始時間5分前の時間を求める
            var fiveMinutesBeforeComponents = DateComponents()
            fiveMinutesBeforeComponents.minute = startTimeMinute - 5
            fiveMinutesBeforeComponents.hour = startTimeHour
            
            if fiveMinutesBeforeComponents.minute! < 0 {
                fiveMinutesBeforeComponents.minute! += 60
                fiveMinutesBeforeComponents.hour! -= 1
            }
            
            // 負の時間を処理するために日付を調整
            if fiveMinutesBeforeComponents.hour! < 0 {
                let oneDayAgo = Calendar.current.date(byAdding: .day, value: -1, to: targetDate)!
                let newDateComponents = Calendar.current.dateComponents([.year, .month, .day], from: oneDayAgo)
                dateComponents.year = newDateComponents.year
                dateComponents.month = newDateComponents.month
                dateComponents.day = newDateComponents.day
                
                // 月が1月だった場合は前の年の12月になる
                if dateComponents.month == 1 {
                    dateComponents.year! -= 1
                    dateComponents.month = 12
                } else {
                    dateComponents.month! -= 1
                }
                
                fiveMinutesBeforeComponents.hour! += 24
            }
            
            if let fiveMinutesBeforeDate = calendar.date(bySettingHour: fiveMinutesBeforeComponents.hour!, minute: fiveMinutesBeforeComponents.minute!, second: 0, of: targetDate) {
                dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute], from: fiveMinutesBeforeDate)
                
                let identifier = String(describing: _scheduleDetailData.id)
                
                let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request) { (error) in
                    if let error = error {
                        print("Error adding notification request: \(error)")
                    } else {
                        print("Notification request added successfully")
                    }
                }
            }
        }
        
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

