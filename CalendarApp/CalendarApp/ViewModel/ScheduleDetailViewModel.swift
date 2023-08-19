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
    
    var id = ""
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
    
    var isIdealScheduleUpdate: Bool = false
    
    var idealScheduleTitle = ""
    var idealScheduleDetailTitle = ""
    var idealStartTime = "00:00"
    var idealEndTime = "00:00"
    var idealIsNotice = true

    var idealScheduleTitleArray: [String] = []
    var idealScheduleDetailTitleArray: [String] = []
    var idealStartTimeArray: [String] = []
    var idealEndTimeArray: [String] = []
    var idealIsNoticeArray: [Bool] = []
    
    var timeArray: [String] = []
    
    private let schemaVersion: UInt64 = 8
    
    // DB登録処理(一件のみ新規登録の処理)
    func registerScheduleDetail(completion: @escaping (Bool) -> Void) {
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        // スキーマの設定
        let config = Realm.Configuration(schemaVersion: schemaVersion)
        
        let scheduleDetailData = ScheduleDetailData()
        let calendarViewModel = CalendarViewModel.shared
        self.id = String(describing: ObjectId.generate())
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
                
                // 通知をONに設定していたら通知登録処理
                if scheduleDetailData.isNotice {
                    let noticeSettingViewModel = NoticeSettingViewModel.shared
                    noticeSettingViewModel.sendNotificationRequest(_scheduleDetailData: scheduleDetailData)
                }
                
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
        scheduleDetailMonthDayList = []
        scheduleDetailMonthTextList = []
        
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
                if scheduleDetailMonthDayList.count == 0 {
                    scheduleDetailMonthDayList.append(day)
                    // 内容が7文字以上であれば、6文字+...を格納する
                    if scheduleDetailData.scheduleDetailTitle.count > 7 {
                        let startIndex = scheduleDetailData.scheduleDetailTitle.startIndex
                        let endIndex = scheduleDetailData.scheduleDetailTitle.index(startIndex, offsetBy: 5)
                        let truncatedTitle = scheduleDetailData.scheduleDetailTitle[startIndex...endIndex] + "..."
                        scheduleDetailMonthTextList.append(String(truncatedTitle))
                    } else {
                        scheduleDetailMonthTextList.append(scheduleDetailData.scheduleDetailTitle)
                    }
                } else if scheduleDetailMonthDayList[scheduleDetailMonthDayList.count - 1] != day {
                    scheduleDetailMonthDayList.append(day)
                    // 内容が7文字以上であれば、6文字+...を格納する
                    if scheduleDetailData.scheduleDetailTitle.count > 7 {
                        let startIndex = scheduleDetailData.scheduleDetailTitle.startIndex
                        let endIndex = scheduleDetailData.scheduleDetailTitle.index(startIndex, offsetBy: 5)
                        let truncatedTitle = scheduleDetailData.scheduleDetailTitle[startIndex...endIndex] + "..."
                        scheduleDetailMonthTextList.append(String(truncatedTitle))
                    } else {
                        scheduleDetailMonthTextList.append(scheduleDetailData.scheduleDetailTitle)
                    }
                } else {
                    let existingTitle = scheduleDetailMonthTextList[scheduleDetailMonthDayList.count - 1]
                    let newlineCount = existingTitle.components(separatedBy: "\n").count - 1
                    
                    // 同一日の最大表示詳細スケジュールは6つまでにする
                    if newlineCount < 5 {
                        // 内容が7文字以上であれば、6文字+...を格納する
                        if scheduleDetailData.scheduleDetailTitle.count > 7 {
                            let startIndex = scheduleDetailData.scheduleDetailTitle.startIndex
                            let endIndex = scheduleDetailData.scheduleDetailTitle.index(startIndex, offsetBy: 5)
                            let truncatedTitle = scheduleDetailData.scheduleDetailTitle[startIndex...endIndex] + "..."
                            scheduleDetailMonthTextList[scheduleDetailMonthDayList.count - 1] += "\n" + String(truncatedTitle)
                        } else {
                            scheduleDetailMonthTextList[scheduleDetailMonthDayList.count - 1] += "\n" + scheduleDetailData.scheduleDetailTitle
                        }
                    }
                }
            }
            
            var startIndex = 0
            scheduleDetailMonthList = Array(repeating: "", count: 31)

            for i in 0..<calendarViewModel.numDaysMonth {
                var matchedIndex: Int?
                for cnt in startIndex..<scheduleDetailMonthDayList.count {
                    if (i + 1) == Int(scheduleDetailMonthDayList[cnt]) {
                        scheduleDetailMonthList[i] = scheduleDetailMonthTextList[cnt]
                        matchedIndex = cnt
                        break
                    }
                }
                if let matchedIndex = matchedIndex {
                    startIndex = matchedIndex + 1
                }
            }
            
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
    
    // 理想のスケジュールDB登録処理
    func registerIdealScheduleDetail(completion: @escaping (Bool) -> Void) {
        let scheduleDetailViewModel = ScheduleDetailViewModel.shared
        let config = Realm.Configuration(schemaVersion: schemaVersion)
        
        
        let scheduleDetailData = IdealScheduleData()
        scheduleDetailData.scheduleTitle = self.idealScheduleTitle
        
        for i in 0..<scheduleDetailViewModel.idealScheduleDetailTitleArray.count {
            let idealScheduleDetailData = IdealScheduleDetailData()
            idealScheduleDetailData.scheduleDetailTitle = scheduleDetailViewModel.idealScheduleDetailTitleArray[i]
            idealScheduleDetailData.startTime = scheduleDetailViewModel.idealStartTimeArray[i]
            idealScheduleDetailData.endTime = scheduleDetailViewModel.idealEndTimeArray[i]
            idealScheduleDetailData.isNotice = scheduleDetailViewModel.idealIsNoticeArray[i]

            scheduleDetailData.scheduleDetails.append(idealScheduleDetailData)
        }
        
        do {
            let realm = try Realm(configuration: config)
            try realm.write {
                realm.add(scheduleDetailData)
                
                //================================================================
                // 登録処理デバッグ
                //================================================================
                print(Realm.Configuration.defaultConfiguration.fileURL!)
                print("scheduleDetailData",scheduleDetailData)
                
                
                // 非同期処理が成功したことを示す
                completion(true)
            }
        } catch {
            print("Realmの書き込みエラー：\(error)")
            // 非同期処理失敗
            completion(false)
        }
    }
    
    // 登録済みの理想のスケジュールDB更新処理
    func updateIdealScheduleDetail(completion: @escaping (Bool) -> Void) {
        let scheduleDetailViewModel = ScheduleDetailViewModel.shared
        let config = Realm.Configuration(schemaVersion: schemaVersion)

        do {
            let realm = try Realm(configuration: config)
            
            // 更新用のバックアップを反映
            scheduleDetailViewModel.idealScheduleDetailTitleArray = scheduleDetailViewModel.updScheduleDetailTitleArray
            scheduleDetailViewModel.idealStartTimeArray = scheduleDetailViewModel.updStartTimeArray
            scheduleDetailViewModel.idealEndTimeArray = scheduleDetailViewModel.updEndTimeArray
            scheduleDetailViewModel.idealIsNoticeArray = scheduleDetailViewModel.updIsNoticeArray
            
            // 更新対象のレコードを取得
            guard let scheduleDetailData = realm.objects(IdealScheduleData.self).filter("scheduleTitle == %@", self.idealScheduleTitle).first else {
                print("まだDBにレコードは登録していない状態での詳細スケジュールの更新")
                // この時、登録時は時間の昇順にしないが、保存してそれを取得して再度表示するときは昇順で取得して表示するようになる仕様
                completion(false)
                return
            }

            // レコードのプロパティを更新
            try realm.write {
                // 既存のスケジュール詳細を削除
                scheduleDetailData.scheduleDetails.removeAll()
                
                // 新しいスケジュール詳細を追加
                for i in 0..<scheduleDetailViewModel.idealScheduleDetailTitleArray.count {
                    let idealScheduleDetailData = IdealScheduleDetailData()
                    
                    // 更新用のバックアップを代入してDB更新
                    idealScheduleDetailData.scheduleDetailTitle = scheduleDetailViewModel.updScheduleDetailTitleArray[i]
                    idealScheduleDetailData.startTime = scheduleDetailViewModel.updStartTimeArray[i]
                    idealScheduleDetailData.endTime = scheduleDetailViewModel.updEndTimeArray[i]
                    idealScheduleDetailData.isNotice = scheduleDetailViewModel.updIsNoticeArray[i]

                    scheduleDetailData.scheduleDetails.append(idealScheduleDetailData)
                }
            }
            
            //================================================================
            // 更新処理デバッグ
            //================================================================
            print(Realm.Configuration.defaultConfiguration.fileURL!)
            print("scheduleDetailData", scheduleDetailData)

            // 非同期処理が成功したことを示す
            completion(true)
        } catch {
            print("Realmの書き込みエラー：\(error)")
            // 非同期処理失敗
            completion(false)
        }
    }

    // 登録済みの理想のスケジュールのタイトルのみを取得する
    func getIdealScheduleTitle(completion: @escaping (Bool) -> Void) {
        let config = Realm.Configuration(schemaVersion: schemaVersion)
        
        // DB取得の前にパース用の配列を初期化(この中にRealmから取得したタイトルの文字列を格納する)
        idealScheduleTitleArray = []
        
        do {
            let realm = try Realm(configuration: config)
            
            // 保存されている理想のスケジュールのタイトルのみを全て取得する
            let results = realm.objects(IdealScheduleData.self).distinct(by: ["scheduleTitle"])
            idealScheduleTitleArray = Array(results.map { $0.scheduleTitle })
            
            print("idealScheduleTitleArrayの値確認")
            print(idealScheduleTitleArray)
            
            // 非同期処理が成功したことを示す
            completion(true)
        } catch {
            print("Realmの読み込みエラー：\(error)")
            
            // 非同期処理失敗
            completion(false)
        }
    }
    
    // 登録済みの理想のスケジュールの詳細スケジュールを取得する
    func getIdealScheduleDetail(completion: @escaping (Bool) -> Void) {
        let config = Realm.Configuration(schemaVersion: schemaVersion)
        
        // DB取得の前にパース用の配列を初期化
        idealScheduleDetailTitleArray = []
        idealStartTimeArray = []
        idealEndTimeArray = []
        idealIsNoticeArray = []
        
        do {
            let realm = try Realm(configuration: config)
            
            // "理想のスケA"という値が入ったレコードを取得
            let results = realm.objects(IdealScheduleData.self).filter("scheduleTitle == %@", self.idealScheduleTitle)
            guard let idealScheduleA = results.first else {
                print("該当するレコードが見つかりませんでした")
                // 非同期処理失敗
                completion(false)
                return
            }
            
            // idealScheduleAのscheduleDetailsのカラムの値を取得し、startTimeの早い順に並び替える
            let scheduleDetails = idealScheduleA.scheduleDetails.sorted(byKeyPath: "startTime")
            
            // scheduleDetailsをidealScheduleDetailTitleArrayに代入
            idealScheduleDetailTitleArray = Array(scheduleDetails.map { $0.scheduleDetailTitle })
            idealStartTimeArray = Array(scheduleDetails.map { $0.startTime })
            idealEndTimeArray = Array(scheduleDetails.map { $0.endTime })
            idealIsNoticeArray = Array(scheduleDetails.map { $0.isNotice })
            
            print("idealScheduleDetailTitleArrayの値確認")
            print(idealScheduleDetailTitleArray)
            print(idealStartTimeArray)
            print(idealEndTimeArray)
            print(idealIsNoticeArray)
            
            // 編集画面で更新用にバックアップを取っておく
            updScheduleDetailTitleArray = idealScheduleDetailTitleArray
            updStartTimeArray = idealStartTimeArray
            updEndTimeArray = idealEndTimeArray
            updIsNoticeArray = idealIsNoticeArray
            
            // 非同期処理が成功したことを示す
            completion(true)
        } catch {
            print("Realmの読み込みエラー：\(error)")
            // 非同期処理失敗
            completion(false)
        }
    }

    
    // DB削除処理(登録済みの理想のスケジュールを削除)
    func DeleteIdealSchedule(_titleStr: String, completion: @escaping (Bool) -> Void) {
        let config = Realm.Configuration(schemaVersion: schemaVersion)

        do {
            let realm = try Realm(configuration: config)
            try realm.write {
                let predicate = NSPredicate(format: "scheduleTitle == %@", _titleStr)
                let scheduleDetailData = realm.objects(IdealScheduleData.self).filter(predicate)
                realm.delete(scheduleDetailData)

                completion(true)
            }
        } catch {
            print("Realmの書き込みエラー：\(error)")
            completion(false)
        }
    }
    
    
    // 理想のスケジュールの設定を反映させるために既存のレコードを削除する処理。
    func DeleteScheduleDetail(_year: String, _month: String, _day: String, completion: @escaping (Bool) -> Void) {
        let config = Realm.Configuration(schemaVersion: schemaVersion)
        
        do {
            let realm = try Realm(configuration: config)
            try realm.write {
                let predicate = NSPredicate(format: "date == %@ AND date CONTAINS %@ AND date CONTAINS %@", "\(_year)年\(_month)月\(_day)日", _year, _month)
                let scheduleDetailData = realm.objects(ScheduleDetailData.self).filter(predicate)
                realm.delete(scheduleDetailData)
                
                completion(true)
            }
        } catch {
            print("Realmの書き込みエラー：\(error)")
            completion(false)
        }
    }
    
    // DB登録処理(複数件の新規登録処理)
    func setIdealScheduleDetail(completion: @escaping (Bool) -> Void) {
        let scheduleDetailViewModel = ScheduleDetailViewModel.shared
        print(Realm.Configuration.defaultConfiguration.fileURL!)

        // スキーマの設定
        let config = Realm.Configuration(schemaVersion: schemaVersion)

        let calendarViewModel = CalendarViewModel.shared

        do {
            let realm = try Realm(configuration: config)
            try realm.write {
                for i in 0..<scheduleDetailViewModel.scheduleDetailTitleArray.count {
                    let scheduleDetailData = ScheduleDetailData()
                    scheduleDetailData.id = ObjectId.generate()
                    scheduleDetailData.date = "\(calendarViewModel.selectYear)年\(calendarViewModel.selectMonth)月\(calendarViewModel.selectDay)日"
                    scheduleDetailData.scheduleDetailTitle = scheduleDetailViewModel.scheduleDetailTitleArray[i]
                    scheduleDetailData.startTime = scheduleDetailViewModel.startTimeArray[i]
                    scheduleDetailData.endTime = scheduleDetailViewModel.endTimeArray[i]
                    scheduleDetailData.isNotice = scheduleDetailViewModel.isNoticeArray[i]

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
                }

                // 非同期処理が成功したことを示す
                completion(true)
            }
        } catch {
            print("Realmの書き込みエラー：\(error)")
            // 非同期処理失敗
            completion(false)
        }
    }

    
}
