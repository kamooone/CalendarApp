//
//  CalendarCellView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/08.
//

import SwiftUI

struct CalendarCellView: View {
    @EnvironmentObject var screenSizeObject: ScreenSizeObject
    
    let calendarViewModel = CalendarViewModel.shared
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    
    // ToDo このStateの値はConfirmScheduleDetailViewModelを作成してそこで管理する
    @State private var isRequestSuccessful = false
    @State private var isEditMode = false
    @State private var showAlert = false
    
    func bindViewModel() {
        isRequestSuccessful = false
        isEditMode = false
        showAlert = false
        calendarViewModel.isSelectMonthSwitchButton = true
        
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue(label: "realm").async {
            scheduleDetailViewModel.getScheduleDetailMonth { success in
                group.leave()
                
                if success {
                    print("非同期処理成功")
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        isRequestSuccessful = true
                    }
                } else {
                    print("非同期処理失敗")
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        isRequestSuccessful = false
                        showAlert = true
                    }
                }
            }
        }
        
        // 成功失敗に関わらず呼ばれる
        group.notify(queue: .main) {
            print("非同期処理終了")
            calendarViewModel.isSelectMonthSwitchButton = false
        }
    }
    
    var body: some View {
        VStack {
            if isRequestSuccessful {
                HStack {
                    DaysWeekView()
                        .offset(x:0, y: -screenSizeObject.screenSize.height / 30)
                }
                
                //7*6のマスを表示する
                VStack(spacing: 0) {
                    ForEach(0..<6, id: \.self) { week in
                        ZStack {
                            HStack(spacing: 0) {
                                ForEach(0..<7, id: \.self) { _ in
                                    Rectangle()
                                        .stroke(Color.black)
                                        .frame(width: screenSizeObject.screenSize.width / 8, height: screenSizeObject.screenSize.height / 10)
                                }
                            }
                            
                            HStack(spacing: 0) {
                                ForEach(1..<8, id: \.self) { i in
                                    ZStack {
                                        VStack {
                                            DayStringtView(i: i, week: week)
                                                .frame(width: screenSizeObject.screenSize.width / 8, height: screenSizeObject.screenSize.height / 10)
                                        }
                                        VStack {
                                            CellTextView(i: i, week: week)
                                                .frame(width: screenSizeObject.screenSize.width / 8, height: screenSizeObject.screenSize.height / 10)
                                        }
                                    }
                                }
                            }
                        }
                        .frame(height: screenSizeObject.screenSize.height / 10)
                    }
                }
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("スケジュールの取得に失敗しました。"),
                  dismissButton: .default(Text("OK")))
        }
        .onAppear {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else { return }
            screenSizeObject.screenSize = window.bounds.size
            bindViewModel()
        }
    }
}

struct DaysWeekView: View {
    let calendarViewModel = CalendarViewModel.shared
    let dayofweek = ["日", "月", "火", "水", "木", "金", "土"]
    
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: geometry.size.width / 15) {
                Spacer()
                ForEach(self.dayofweek, id: \.self) { day in
                    HStack {
                        Text(day)
                            .font(.system(size: geometry.size.width / 20))
                            .foregroundColor(day == "土" ? Color.blue : (day == "日" ? Color.red : Color.black))
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                Spacer()
            }
        }
    }
}

struct DayStringtView: View {
    @EnvironmentObject var route: RouteObserver
    let calendarViewModel = CalendarViewModel.shared
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    let i: Int
    let week: Int
    
    var body: some View {
        GeometryReader { geometry in
            let cellSize = CGSize(width: geometry.size.width / 8, height: geometry.size.height / 10)
            
            if !(1..<calendarViewModel.numDaysMonth + 1).contains(i + week*7 - calendarViewModel.firstDayWeek.rawValue) {
                Text("")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                Button(action: {
                    print("\(i+week*7 - calendarViewModel.firstDayWeek.rawValue)日をタップ")
                    
                    // ルートをスケジュール登録に変更して、選択したセルの月日を取得
                    calendarViewModel.selectDay = i+week*7 - calendarViewModel.firstDayWeek.rawValue
                    
                    route.path = .ScheduleConfirm
                }) {
                    VStack {
                        Text("\(i + (week*7) - calendarViewModel.firstDayWeek.rawValue)")
                            .font(.system(size: cellSize.height * 2))
                            .foregroundColor((i+week*7) == 1 || (i+week*7) == 8 || (i+week*7) == 15 || (i+week*7) == 22 || (i+week*7) == 29 || (i+week*7) == 36 ? Color.red : ((i+week*7) == 7 || (i+week*7) == 14 || (i+week*7) == 21 || (i+week*7) == 28 || (i+week*7) == 35 ? Color.blue : Color.black))
                            .padding(.top, -cellSize.height * 5)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

struct CellTextView: View {
    let calendarViewModel = CalendarViewModel.shared
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    let i: Int
    let week: Int
    
    var body: some View {
        GeometryReader { geometry in
            let cellSize = CGSize(width: geometry.size.width / 8, height: geometry.size.height / 10)
            
            if !(1..<calendarViewModel.numDaysMonth + 1).contains(i + week*7 - calendarViewModel.firstDayWeek.rawValue) {
                Text("")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                Text("\(scheduleDetailViewModel.scheduleDetailMonthList[i + week*7 - calendarViewModel.firstDayWeek.rawValue - 1])")
                    .font(.system(size: cellSize.height * 1.5))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(Color.black) // ToDo 大事な予定には色を付けれるようにすればいいかも
                    .alignmentGuide(.top) { d in d[.bottom] }
                    .padding(.top, cellSize.height * 2)
            }
        }
    }
}
