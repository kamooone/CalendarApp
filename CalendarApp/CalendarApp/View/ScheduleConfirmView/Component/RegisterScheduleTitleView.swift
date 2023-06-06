//
//  RegisterScheduleTitleView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/06.
//

import SwiftUI

struct RegisterScheduleTitleView: View {
    @State private var text = ""
    
    var body: some View {
        VStack {
            Text("登録するスケジュールのタイトルを入力しよう！")
                .font(.system(size: 16))
                .offset(x: 0, y: 10)
            
            HStack {
                Text("※")
                    .foregroundColor(Color.red)
                    .font(.system(size: 16))
                    .offset(x: 20, y: -10)
                Text("タイトル")
                    .font(.system(size: 16))
                    .offset(x: 20, y: -10)
                TextField("例 : 休日の理想のスケジュール", text: $text)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .offset(x: 5, y: -10)
                Spacer()
            }
        }
    }
}
