//
//  TestRealm.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/15.
//

import Foundation
import RealmSwift

class ScheduleDetailData: Object {
    /// SwiftUIだと@objc dynamic、UIkitだと@Persisted と書くのが一般的？
    @Persisted var date = "20230624"
    @Persisted var scheduleDetailTitle = ""
    @Persisted var startTime = ""
    @Persisted var endTime = ""
    @Persisted var isNotice = true
}

