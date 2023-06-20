//
//  ScheduleDetailViewModel.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/20.
//

import SwiftUI

final class ScheduleDetailViewModel: ObservableObject {
    //Action trigger for request API
    static let shared = ScheduleDetailViewModel()

    let scheduleDetailData = ScheduleDetailData()
    var scheduleDetailTitle = ""
    var startTime = ""
    var endTime = ""
    var isNotice = true
    
    // DB登録処理
    func registerScheduleDetail() -> Int {
        
        
        
        //=======================================
        // レコードの生成
        //=======================================
        var scheduleDetailData = ScheduleDetailData()
        scheduleDetailData.scheduleDetailTitle = self.scheduleDetailTitle
        scheduleDetailData.startTime = self.startTime
        scheduleDetailData.endTime = self.endTime
        scheduleDetailData.isNotice = self.isNotice
        
//            // 保存
//            let realm = try! Realm()
//            try! realm.write {
//                realm.add(shop)
//            }

        
        //=======================================
        // レコードの取得
        //=======================================
//            let realm = try! Realm()
//
//            let shopTable = realm.objects(Shop.self)
//            print("shopテーブルのデータ全て取得")
//            print(shopTable)
//
//            let menuTable = realm.objects(Menu.self)
//            print("menuテーブルのデータ全て取得")
//            print(menuTable)
        
        return 0
    }
}
