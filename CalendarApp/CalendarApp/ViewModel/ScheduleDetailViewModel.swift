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
    
    private let schemaVersion: UInt64 = 2
    
    // DB登録処理
    func registerScheduleDetail() -> Int {
        //=======================================
        // レコードの生成
        //=======================================
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
        //=======================================
        // レコードの取得
        //=======================================
        // スキーマの設定
        let config = Realm.Configuration(schemaVersion: schemaVersion)
        
        do {
            let realm = try Realm(configuration: config)
            let scheduleDetailData = realm.objects(ScheduleDetailData.self)
            print(scheduleDetailData)
        } catch {
            print("Realmの読み込みエラー：\(error)")
            return 1
        }
        // ToDoパース処理を行う (選択した日付と同じレコードのみを取得してパースを行う。なので取得した時用の配列を用意する必要がある。)
        // ToDo その後、ConfirmScheduleDetailViewで表示させる
        
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
