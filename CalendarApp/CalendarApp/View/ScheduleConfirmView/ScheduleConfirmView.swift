//
//  ScheduleConfirmView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/05/31.
//

import SwiftUI

struct ScheduleConfirmView: View {
    let calendarViewModel = CalendarViewModel.shared
    
    @State private var selectedOption = 0
    let options = ["-------------------", "作成した理想のスケ1", "作成した理想のスケ2", "作成した理想のスケ3"]
    @State private var text = ""

    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    BackButtonView()
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("スケジュール登録")
                        .font(.system(size: 24))
                        .offset(x: 0, y: -60)
                    Spacer()
                }
                VStack {
                    HStack {
                        Spacer()
                        Text("\(calendarViewModel.selectMonth)月\(calendarViewModel.selectDay)日")
                            .font(.system(size: 24))
                            .offset(x: 0, y: -40)
                        Spacer()
                    }
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            
                        }) {
                            Text("登録")
                        }
                        .offset(x:0,y:-110)
                        .buttonStyle(SmallButtonStyle.smallButtonStyle())
                        .padding() // ボタンの余白を調整
                    }
                    
                    HStack {
                        Text("作成した理想のスケジュールを使用する")
                            .font(.system(size: 16))
                            .offset(x: 0, y: -100)
                    }
                    
                    HStack {
                        Spacer()
                        Picker("Select an option", selection: $selectedOption) {
                            ForEach(0..<options.count, id: \.self) { index in
                                Text(options[index])
                            }
                        }
                        .frame(width: geometry.size.width * 0.6, height: geometry.size.height / 10)
                        .pickerStyle(MenuPickerStyle())
                        .offset(x:0,y:-110)
                        
                        Button(action: {
                            
                        }) {
                            Text("追加")
                        }
                        .offset(x:0,y:-110)
                        .buttonStyle(SmallButtonStyle.smallButtonStyle())
                        .padding() // ボタンの余白を調整
                        Spacer()
                    }
                    
                    VStack {
                        Text("登録するスケジュールのタイトルを入力しよう！")
                            .font(.system(size: 16))
                            .offset(x: 0, y: -100)
                        
                        HStack {
                            Text("※")
                                .foregroundColor(Color.red)
                                .font(.system(size: 16))
                                .offset(x: 20, y: -90)
                            Text("タイトル")
                                .font(.system(size: 16))
                                .offset(x: 20, y: -90)
                            TextField("例 : 休日の理想のスケジュール", text: $text)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .padding()
                                        .offset(x: 5, y: -90)
                            Spacer()
                        }
                    }
                    
                    
                    Spacer()
                }
                
                // ToDo タイトル入力などの各コンポーネントの実装
                
                Spacer()
            }
        }
    }
}

struct ScheduleConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleConfirmView()
    }
}
