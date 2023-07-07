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
    
    var isEditMode: Bool = false

    var scheduleDetailTitle = ""
    var startTime = "00:00"
    var endTime = "00:00"
    var isNotice = true
    
    var scheduleDetailTitleArray: [String] = []
    var startTimeArray: [String] = []
    var endTimeArray: [String] = []
    var isNoticeArray: [Bool] = []
    
    // 修正画面で値を変更した時に一時的に格納する配列
    var updScheduleDetailTitleArray: [String] = []
    var updStartTimeArray: [String] = []
    var updEndTimeArray: [String] = []
    var updIsNoticeArray: [Bool] = []
    
    
    var timeArray: [String] = []
    
    private let schemaVersion: UInt64 = 2
    
    // DB登録処理(一件のみ新規登録の処理)
    func registerScheduleDetail(completion: @escaping (Bool) -> Void) {
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
                
                //================================================================
                // 登録処理デバッグ
                //================================================================
                print(Realm.Configuration.defaultConfiguration.fileURL!)
                print("scheduleDetailData.scheduleDetailTitle",scheduleDetailData.scheduleDetailTitle)
                print("scheduleDetailData.startTime",scheduleDetailData.startTime)
                print("scheduleDetailData.endTime",scheduleDetailData.endTime)
                print("scheduleDetailData.isNotice",scheduleDetailData.isNotice)
                print(scheduleDetailData)
                
                // 非同期処理が成功したことを示す
                completion(true)
            }
        } catch {
            print("Realmの書き込みエラー：\(error)")
            // 非同期処理失敗
            completion(false)
        }
    }
    
    // レコード取得処理(一件のみ)
    func getScheduleDetail(completion: @escaping (Bool) -> Void) {
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
                completion(false)
                return
            }

            // 日付を文字列に変換
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy年M月d日"
            let targetDateString = dateFormatter.string(from: targetDate)

            // 日付が一致するレコードをクエリで取得
            let predicate = NSPredicate(format: "date == %@", targetDateString)
            let scheduleDetailData = realm.objects(ScheduleDetailData.self).filter(predicate).sorted(byKeyPath: "startTime")

            // 取得したデータをパース処理
            for scheduleDetailData in scheduleDetailData {
                scheduleDetailTitleArray.append(scheduleDetailData.scheduleDetailTitle)
                startTimeArray.append(scheduleDetailData.startTime)
                endTimeArray.append(scheduleDetailData.endTime)
                isNoticeArray.append(scheduleDetailData.isNotice)
            }
            
            // 編集画面で更新用にバックアップを取っておく
            updScheduleDetailTitleArray = scheduleDetailTitleArray
            updStartTimeArray = startTimeArray
            updEndTimeArray = endTimeArray
            updIsNoticeArray = isNoticeArray
            
            // 非同期処理が成功したことを示す
            completion(true)
        } catch {
            print("Realmの読み込みエラー：\(error)")
            
            // 非同期処理失敗
            completion(false)
        }
    }
    
    // DB更新処理(更新があったレコードを一括更新処理)
    func UpdateScheduleDetail(_year: String, _month: String, _day: String, completion: @escaping (Bool) -> Void) {
        let config = Realm.Configuration(schemaVersion: schemaVersion)
        
        do {
            let realm = try Realm(configuration: config)
            let predicate = NSPredicate(format: "date == %@", "\(_year)年\(_month)月\(_day)日")
            let scheduleDetailData = realm.objects(ScheduleDetailData.self).filter(predicate)
            print(scheduleDetailData)
            try realm.write {
                // 更新のあったフィールドのみ更新する
                for i in 0..<updScheduleDetailTitleArray.count {
                    // ToDo 更新しても更新されてないので確認する
                    if scheduleDetailTitleArray[i] != updScheduleDetailTitleArray[i] {
                        scheduleDetailData[i].date = updScheduleDetailTitleArray[i]
                    }
                    if scheduleDetailTitleArray[i] != updScheduleDetailTitleArray[i] {
                        scheduleDetailData[i].scheduleDetailTitle = updStartTimeArray[i]
                    }
                    if scheduleDetailTitleArray[i] != updScheduleDetailTitleArray[i] {
                        scheduleDetailData[i].startTime = updStartTimeArray[i]
                    }
                    if scheduleDetailTitleArray[i] != updScheduleDetailTitleArray[i] {
                        scheduleDetailData[i].endTime = updEndTimeArray[i]
                    }
                    if scheduleDetailTitleArray[i] != updScheduleDetailTitleArray[i] {
                        scheduleDetailData[i].isNotice = updIsNoticeArray[i]
                    }
                }
                completion(true)
            }
        } catch {
            print("Realmの書き込みエラー：\(error)")
            completion(false)
        }
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
