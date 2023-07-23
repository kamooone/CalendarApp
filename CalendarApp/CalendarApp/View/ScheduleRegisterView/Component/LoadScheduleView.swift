//
//  LoadScheduleView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/06.
//

import SwiftUI

struct LoadScheduleView: View {
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    
    @State private var selectedOption = 0
    @State private var options: [String] = ["---------------"]
    @State private var isRequestSuccessful = false
    
    func bindViewModel() {
        isRequestSuccessful = false
        
        let group = DispatchGroup()
        group.enter()
        
        DispatchQueue(label: "realm").async {
            scheduleDetailViewModel.getIdealScheduleTitle { success in
                group.leave()
                
                if success {
                    print("非同期処理成功")
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        isRequestSuccessful = true
                        options.append(contentsOf: scheduleDetailViewModel.idealScheduleTitleArray)
                        selectedOption = 0
                    }
                } else {
                    print("非同期処理失敗")
                    // ToDo 取得失敗エラーアラート表示
                    // メインスレッド（UI スレッド）で非同期に実行するメソッド
                    DispatchQueue.main.async {
                        isRequestSuccessful = false
                    }
                }
            }
        }
        
        // 成功失敗に関わらず呼ばれる
        group.notify(queue: .main) {
            // ToDo 失敗エラーアラート表示
            print("非同期処理終了")
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            Spacer()
            HStack {
                Spacer()
                Text("作成した理想のスケジュールを使用する")
                    .font(.system(size: 16))
                    .offset(x:0,y:10)
                Spacer()
            }
            
            if isRequestSuccessful {
                HStack {
                    Spacer()
                    Picker("Select an option", selection: $selectedOption) {
                        ForEach(0..<options.count, id: \.self) { index in
                            Text(options[index])
                        }
                    }
                    .frame(width: geometry.size.width * 0.6, height: geometry.size.height / 10)
                    .pickerStyle(MenuPickerStyle())
                    .offset(x:0,y:25)
                    
                    Button(action: {
                        
                    }) {
                        Text("設定する")
                            .frame(width: 80, height: 30)
                    }
                    .buttonStyle(NormalButtonStyle.normalButtonStyle())
                    .padding() // ボタンの余白を調整
                    .offset(x:0,y:20)
                    Spacer()
                }
                Spacer()
            }
        }
        .onAppear{
            bindViewModel()
        }
    }
}
