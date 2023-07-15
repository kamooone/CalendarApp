//
//  CalendarAppApp.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/05/28.
//

import SwiftUI

@main
struct Calendar_SwiftUIApp: App {
    @StateObject var route = RouteObserver()
    @StateObject var setting = Setting()
    
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(route).environmentObject(setting)
        }
    }
}
