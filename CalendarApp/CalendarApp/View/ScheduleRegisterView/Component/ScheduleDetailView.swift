//
//  RegisterScheduleDetailView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/06.
//

import SwiftUI

struct ScheduleDetailView: View {
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    @State private var text = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Text(LocalizedStringKey("AddSchedule!"))
                        .font(.system(size: geometry.size.width / 25))
                        .offset(x: 0, y: 10)
                }
                
                HStack {
                    Text(LocalizedStringKey("TITLE!"))
                        .font(.system(size: geometry.size.width / 25))
                        .offset(x: 20, y: 0)
                    TextField(LocalizedStringKey("ExampleAfternoonShopping"), text: $text)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding()
                        .offset(x: 5, y: 0)
                        .onChange(of: text) { newValue in
                            scheduleDetailViewModel.scheduleDetailTitle = newValue
                        }
                    Spacer()
                }
            }
        }
    }
}
