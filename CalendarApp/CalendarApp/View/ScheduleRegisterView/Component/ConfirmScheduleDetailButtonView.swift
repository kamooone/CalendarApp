//
//  RegisterConfirmView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/11.
//

import SwiftUI

struct ConfirmScheduleDetailButtonView: View {
    @EnvironmentObject var route: RouteObserver
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Spacer()
                
                Button(action: {
                    route.path = .ConfirmScheduleDetail
                }) {
                    Text("現在の追加状況を確認")
                        .font(.system(size: geometry.size.width / 25))
                        .frame(width: geometry.size.width / 2, height: geometry.size.height)
                }
                .buttonStyle(NormalButtonStyle.normalButtonStyle())
                .padding()
                .offset(x:0, y:-60)
                
                Spacer()
            }
        }
    }
}
