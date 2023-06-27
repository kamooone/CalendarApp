//
//  ScheduleDetailViewModel.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/20.
//

import SwiftUI
import RealmSwift

final class ScheduleDetailViewModel: ObservableObject {
    //Action trigger for request API
    static let shared = ScheduleDetailViewModel()

    var scheduleDetailTitle = ""
    var startTime = ""
    var endTime = ""
    var isNotice = true
    
    var scheduleDetailTitleArray: [String] = []
    var startTimeArray: [String] = []
    var endTimeArray: [String] = []
    var isNoticeArray: [Bool] = []
    
    private let schemaVersion: UInt64 = 2
    
    // DB登録処理
    func registerScheduleDetail() -> Int {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // スキーマの設定
        let config = Realm.Configuration(schemaVersion: schemaVersion)
        
        let scheduleDetailData = ScheduleDetailData()
        let calendarViewModel = CalendarViewModel.shared
        scheduleDetailData.date = "\(calendarViewModel.selectYear)年\(calendarViewModel.selectMonth)月\(calendarViewModel.selectDay)日"
        scheduleDetailData.scheduleDetailTitle = self.scheduleDetailTitle
        scheduleDetailData.startTime = self.startTime
        scheduleDetailData.endTime = self.endTime
        scheduleDetailData.isNotice = self.isNotice
        do {
            let realm = try Realm(configuration: config)
            try realm.write {
                realm.add(scheduleDetailData)
            }
        } catch {
            print("Realmの書き込みエラー：\(error)")
            return 1
        }
        
        return 0
    }
    
    func getScheduleDetail() -> Int {
        let config = Realm.Configuration(schemaVersion: schemaVersion)

        // DB取得の前にパース用の配列を初期化
        scheduleDetailTitleArray = []
        startTimeArray = []
        endTimeArray = []
        isNoticeArray = []
        
        do {
            let realm = try Realm(configuration: config)
            let calendarViewModel = CalendarViewModel.shared
            let calendar = Calendar.current

            // 指定の日付
            let targetDateComponents = DateComponents(year: calendarViewModel.selectYear, month: calendarViewModel.selectMonth, day: calendarViewModel.selectDay)
            guard let targetDate = calendar.date(from: targetDateComponents) else {
                print("指定した日付が無効です。")
                return 1
            }

            // 日付を文字列に変換
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy年M月d日"
            let targetDateString = dateFormatter.string(from: targetDate)
            
            // ToDo startTimeが早い順に取得する。もしくは取得後に並べ替える。

            // 日付が一致するレコードをクエリで取得
            let predicate = NSPredicate(format: "date == %@", targetDateString)
            let scheduleDetailData = realm.objects(ScheduleDetailData.self).filter(predicate)

            // 取得したデータをパース処理
            for scheduleDetailData in scheduleDetailData {
                scheduleDetailTitleArray.append(scheduleDetailData.scheduleDetailTitle)
                startTimeArray.append(scheduleDetailData.startTime)
                endTimeArray.append(scheduleDetailData.endTime)
                isNoticeArray.append(scheduleDetailData.isNotice)
            }
            
//            print("scheduleDetailTitleArray",scheduleDetailTitleArray)
//            print("startTimeArray",startTimeArray)
//            print("endTimeArray",endTimeArray)
//            print("isNoticeArray",isNoticeArray)
//            print(scheduleDetailData)
//            print("----")
        } catch {
            print("Realmの読み込みエラー：\(error)")
            return 1
        }
        
        return 0
    }
    
    // DB削除処理
//    func deleteScheduleDetail() -> Int {
//        //=======================================
//        // レコードの削除
//        //=======================================
//
//        return 0
//    }
}
