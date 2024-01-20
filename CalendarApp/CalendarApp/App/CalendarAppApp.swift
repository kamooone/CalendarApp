//
//  CalendarAppApp.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/05/28.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
}

@main
struct Calendar_SwiftUIApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var route = RouteObserver()
    @StateObject var setting = Setting()
    @StateObject var screenSizeObject = ScreenSizeObject()
    
    var body: some Scene {
        WindowGroup {
            MainView().environmentObject(route).environmentObject(setting).environmentObject(screenSizeObject)
        }
    }
}
