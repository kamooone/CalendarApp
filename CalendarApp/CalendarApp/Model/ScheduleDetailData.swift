//
//  ScheduleDetailData.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/15.
//

import Foundation
import RealmSwift

class ScheduleDetailData: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var date = ""
    @Persisted var scheduleDetailTitle = ""
    @Persisted var startTime = ""
    @Persisted var endTime = ""
    @Persisted var isNotice = true
}

class IdealScheduleData: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var scheduleTitle = ""
    @Persisted var scheduleDetails = List<IdealScheduleDetailData>()
}

// スケジュール詳細を保持するための新しいクラスを作成します。
class IdealScheduleDetailData: Object {
    @Persisted var scheduleDetailTitle = ""
    @Persisted var startTime = ""
    @Persisted var endTime = ""
    @Persisted var isNotice = true
}
