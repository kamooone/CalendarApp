//
//  AppSetting.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/05/28.
//

import Foundation

class Setting: ObservableObject{
        
    // Loading view
    @Published var isLoading = true
    
    // Update view
    @Published var isReload = false
    
    // Disable screen touch
    @Published var isEnableLeftMenu = false
}
