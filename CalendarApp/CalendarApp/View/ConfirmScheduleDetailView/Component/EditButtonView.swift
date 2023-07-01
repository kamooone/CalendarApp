//
//  EditButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/29.
//

import SwiftUI

struct EditButtonView: View {
    @Binding var isEditMode: Bool
    
    var body: some View  {
        Button(action: {
            // ToDo 修正ボタンを押したら、修正ボタンを非表示にしてキャンセルボタンと更新ボタンを表示
            // スケジュール詳細確認の項目を修正出来るようにする。
            // キャンセルボタン、更新ボタンを押したら、修正ボタンのみを表示
            // 更新ボタンを押したら、更新内容をDBに更新
            
            isEditMode = true
        }) {
            Text("修正")
                .frame(width: 50, height: 30)
        }
        .offset(x: 0, y: -100)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding()
    }
}
