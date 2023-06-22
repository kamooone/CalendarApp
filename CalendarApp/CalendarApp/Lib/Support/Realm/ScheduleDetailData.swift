//
//  TestRealm.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/15.
//

import Foundation
import RealmSwift

class ScheduleDetailData: Object {
    /// SwiftUIだと@objc dynamic、UIkitだと@Persisted と書くのが一般的
    @objc dynamic var scheduleDetailTitle = ""
    @objc dynamic var startTime = ""
    @objc dynamic var endTime = ""
    @objc dynamic var isNotice = true
}

