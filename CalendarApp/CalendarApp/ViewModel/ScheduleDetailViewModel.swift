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
    
    var uniqueIdArray: [ObjectId] = []
    var scheduleDetailTitleArray: [String] = []
    var startTimeArray: [String] = []
    var endTimeArray: [String] = []
    var isNoticeArray: [Bool] = []
    
    // 修正画面で値を変更した時に一時的に格納する配列
    var updScheduleDetailTitleArray: [String] = []
    var updStartTimeArray: [String] = []
    var updEndTimeArray: [String] = []
    var updIsNoticeArray: [Bool] = []
    
    // カレンダー画面のセルに表示する用の配列
    var scheduleDetailMonthDayList: [String] = []
    var scheduleDetailMonthTextList: [String] = []
    
    var scheduleDetailMonthList: [String] = []
    
    var timeArray: [String] = []
    
    private let schemaVersion: UInt64 = 3
    
    // DB登録処理(一件のみ新規登録の処理)
    func registerScheduleDetail(completion: @escaping (Bool) -> Void) {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // スキーマの設定
        let config = Realm.Configuration(schemaVersion: schemaVersion)
        
        let scheduleDetailData = ScheduleDetailData()
        let calendarViewModel = CalendarViewModel.shared
        scheduleDetailData.id = ObjectId.generate()
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
    
    // レコード取得処理(日にち単位で取得 ToDo 月単位と同一メソッドにする)
    func getScheduleDetail(completion: @escaping (Bool) -> Void) {
        let config = Realm.Configuration(schemaVersion: schemaVersion)
        
        // DB取得の前にパース用の配列を初期化
        uniqueIdArray = []
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
                uniqueIdArray.append(scheduleDetailData.id)
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
                    if scheduleDetailTitleArray[i] != updScheduleDetailTitleArray[i] {
                        scheduleDetailTitleArray[i] = updScheduleDetailTitleArray[i]
                        scheduleDetailData[i].scheduleDetailTitle = updScheduleDetailTitleArray[i]
                    }
                    if startTimeArray[i] != updStartTimeArray[i] {
                        startTimeArray[i] = updStartTimeArray[i]
                        scheduleDetailData[i].startTime = startTimeArray[i]
                    }
                    if endTimeArray[i] != updEndTimeArray[i] {
                        endTimeArray[i] = updEndTimeArray[i]
                        scheduleDetailData[i].endTime = endTimeArray[i]
                    }
                    if isNoticeArray[i] != updIsNoticeArray[i] {
                        isNoticeArray[i] = updIsNoticeArray[i]
                        scheduleDetailData[i].isNotice = isNoticeArray[i]
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
    func DeleteScheduleDetail(_year: String, _month: String, _day: String, _uniqueId: String, completion: @escaping (Bool) -> Void) {
        let config = Realm.Configuration(schemaVersion: schemaVersion)
        
        do {
            let realm = try Realm(configuration: config)
            try realm.write {
                print("uniqueId確認")
                print(_uniqueId)
                guard let uniqueObjectId = try? ObjectId(string: _uniqueId) else {
                    print("ObjectIdの変換エラー")
                    completion(false)
                    return
                }
                let predicate = NSPredicate(format: "id == %@", uniqueObjectId)
                let scheduleDetailData = realm.objects(ScheduleDetailData.self).filter(predicate)
                realm.delete(scheduleDetailData)
                
                completion(true)
            }
        } catch {
            print("Realmの書き込みエラー：\(error)")
            completion(false)
        }
    }
    
    
    // レコード取得処理(月単位で取得 ToDo 日にち単位で取得のメソッドと同一メソッドにする)
    func getScheduleDetailMonth(completion: @escaping (Bool) -> Void) {
        let config = Realm.Configuration(schemaVersion: schemaVersion)
        
        // DB取得の前にパース用の配列を初期化
        scheduleDetailMonthList = []
        
        do {
            let realm = try Realm(configuration: config)
            let calendarViewModel = CalendarViewModel.shared
            
            // 該当する月のレコードをクエリで取得(表示するカレンダーの年月と同じレコードかつ、日付が早い順に取得)
            let scheduleDetailData = realm.objects(ScheduleDetailData.self)
                // ToDo どのようなロジックになっているのかを理解する
                .filter("date CONTAINS '\(calendarViewModel.selectYear)年\(calendarViewModel.selectMonth)月'")
                .sorted { (data1, data2) -> Bool in
                    guard let day1 = getDayFromString(data1.date), let day2 = getDayFromString(data2.date) else {
                        return false
                    }
                    return day1 < day2
                }
            
            // 取得したデータをパース処理
            for scheduleDetailData in scheduleDetailData {
                var day:String = ""
                let date = scheduleDetailData.date
                
                if let index = date.index(date.endIndex, offsetBy: -3, limitedBy: date.startIndex) {
                    let thirdLastCharacter = date[index]
                    
                    if CharacterSet.decimalDigits.contains(UnicodeScalar(String(thirdLastCharacter))!) {
                        let secondLastCharacter = date[date.index(date.endIndex, offsetBy: -2)]
                        day = String(thirdLastCharacter) + String(secondLastCharacter)
                    } else {
                        let secondLastCharacter = date[date.index(date.endIndex, offsetBy: -2)]
                        day = String(secondLastCharacter)
                    }
                }
                // ToDo 文字が六文字以上であれば、6文字までを格納する
                // ToDo 要素数を節約するため、辞書型の配列を使用する
                if scheduleDetailMonthDayList.count == 0 {
                    scheduleDetailMonthDayList.append(day)
                    scheduleDetailMonthTextList.append(scheduleDetailData.scheduleDetailTitle)
                } else if scheduleDetailMonthDayList[scheduleDetailMonthDayList.count - 1] != day {
                    scheduleDetailMonthDayList.append(day)
                    scheduleDetailMonthTextList.append(scheduleDetailData.scheduleDetailTitle)
                } else {
                    // 同じ日付であれば、内容を連結させる
                    scheduleDetailMonthTextList[scheduleDetailMonthDayList.count - 1] += "\n" + scheduleDetailData.scheduleDetailTitle
                }
            }
            print(scheduleDetailMonthDayList)
            print(scheduleDetailMonthTextList)
            
            
            var foundMatch = false
            var startIndex = 0
            scheduleDetailMonthList = Array(repeating: "", count: 31)

            // ToDo 31を該当する月の日数に該当する変数にする
            for i in 0..<31 {
                if foundMatch {
                    foundMatch = false
                    continue
                }

                for cnt in startIndex..<scheduleDetailMonthDayList.count {
                    if (i + 1) == Int(scheduleDetailMonthDayList[cnt]) {
                        scheduleDetailMonthList[i] = scheduleDetailMonthTextList[cnt]
                        foundMatch = true
                        startIndex = cnt + 1
                        break
                    }
                }
            }
            
            // ToDo 前月翌月に移動するボタンを押してもcalendarViewModel.selectMonthの値が変わっていない(ボタンを押す度に再描画は行われてるので良し)
            print("月毎のスケジュール詳細取得確認")
            print(scheduleDetailMonthList)
            
            // 非同期処理が成功したことを示す
            completion(true)
        } catch {
            print("Realmの読み込みエラー：\(error)")
            
            // 非同期処理失敗
            completion(false)
        }
    }
    
    func getDayFromString(_ dateString: String) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy年M月d日"
        if let date = dateFormatter.date(from: dateString) {
            let calendar = Calendar.current
            return calendar.component(.day, from: date)
        }
        return nil
    }
}
