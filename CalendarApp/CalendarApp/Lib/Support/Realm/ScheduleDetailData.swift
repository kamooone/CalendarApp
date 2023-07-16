//
//  TestRealm.swift
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

class IdealScheduleDetailData: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var scheduleTitle = ""
    @Persisted var scheduleDetailTitle = ""
    @Persisted var startTime = ""
    @Persisted var endTime = ""
    @Persisted var isNotice = true
}
