//
//  CalendarViewModel.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/05/28.
//

import SwiftUI

// 曜日を表すenumにComparableプロトコルを準拠させることで、<演算子をオーバーロードし、曜日の比較を可能にする
enum Weekday: Int, Comparable {
    case monday = 0, tuesday, wednesday, thursday, friday, saturday, sunday

    static func < (lhs: Weekday, rhs: Weekday) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
}


final class CalendarViewModel: ObservableObject {
    //Action trigger for request API
    static let shared = CalendarViewModel()
    
    var firstDayWeek: Weekday = Weekday.monday
    var numDaysMonth: Int = 0
    let columns: CGFloat = 8
    let rows: CGFloat = 9
    
    // 年のみを取得
    var selectYear : Int = Calendar.current.component(.year, from: Date())
    // 月のみを取得
    var selectMonth : Int = Calendar.current.component(.month, from: Date())
    // 日のみを取得
    var selectDay : Int = Calendar.current.component(.day, from: Date())
    
    var isSelectMonthSwitchButton: Bool = false
    
    // 閏年の判定
    func leapYear(year:Int) -> Bool {
        return year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)
    }

    // 年月日から曜日を判定(ツェラーの公式より)
    func dayOfWeekCalc(year: Int, month: Int, day: Int) -> Weekday {
        var result: Weekday = .monday
        
        var changeYear = year
        var changeMonth = month
        
        // monthが1月と2月の場合のみそれぞれに12を加え，前年の年として計算
        if month <= 2 {
            changeYear -= 1
            changeMonth += 12
        }
        
        let firstTerm = (26 * (changeMonth + 1)) / 10
        let secondTerm = changeYear / 4
        let thirdTerm = 5 * (changeYear / 100)
        let fourthTerm = (changeYear / 100) / 4
        
        result = Weekday(rawValue: (day + firstTerm + changeYear + secondTerm + thirdTerm + fourthTerm + 5) % 7)!
        
        return result
    }
    
    // 日数を取得する
    func dayNumber(year: Int, month: Int) -> Int {
        switch month {
        case 1, 3, 5, 7, 8, 10, 12:
            return 31
        case 4, 6, 9, 11:
            return 30
        case 2:
            return leapYear(year: year) ? 29 : 28
        default:
            return 0
        }
    }
    
    // ToDo bindViewModelというメソッド名はおかしい
    func bindViewModel() {
        firstDayWeek = dayOfWeekCalc(year: selectYear, month: selectMonth,  day: 1)
        numDaysMonth = dayNumber(year: selectYear, month: selectMonth)
    }
    
    //=========================================
    // 使用しないためコメントアウト
    //=========================================
    // 週数を取得する
//    func getWeekNumber(year: Int, month: Int) -> Int {
//        if caseFourWeek(year: year, month: month) {
//            return 4
//        } else if caseSixWeek(year: year, month: month) {
//            return 6
//        } else {
//            return 5
//        }
//    }
//
//    // 週数が4の場合
//    private func caseFourWeek(year: Int, month: Int) -> Bool {
//        let firstDayOfWeek = dayOfWeekCalc(year: year, month: month, day: 1)
//        return !leapYear(year: year) && month == 2 && firstDayOfWeek == .sunday
//    }
//
//    // 週数が6の場合
//    private func caseSixWeek(year: Int, month: Int) -> Bool {
//        let firstDayOfWeek = dayOfWeekCalc(year: year, month: month, day: 1)
//        let days = dayNumber(year: year, month: month)
//        return (firstDayOfWeek == .saturday && days == 30) || (firstDayOfWeek >= .friday && days == 31)
//    }
}


struct CalendarViewModelVT {
    

}
