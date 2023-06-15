//
//  RegisterScheduleDetailButtonView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/06/11.
//

import SwiftUI
import RealmSwift

// テーブル
class Shop: Object {
    @Persisted  var name = ""   // カラム
    @Persisted  var menu:Menu?  // カラム
}
// テーブル
class Menu: Object {
    @Persisted  var name = ""  // カラム
    @Persisted  var price = 0  // カラム
}


struct RegisterScheduleDetailButtonView: View {
    
    var body: some View {
        
        Button(action: {
            // ToDo スケジュール詳細登録処理。(一時的な保存はUserDefaultsでいいかもしれない。スケジュール本登録の時にRealmで保存する)
            // 本来はViewModelで行うが最初はテストなのでここで処理を行う
            
            //=======================================
            // レコードの生成
            //=======================================
//            let shop = Shop()
//            shop.name = "Chez Ame1"
//            let menu = Menu()
//            menu.name = "Chocolate1"
//            menu.price = 401
//            shop.menu = menu
//            // 保存
//            let realm = try! Realm()
//            try! realm.write {
//                realm.add(shop)
//            }
  
            
            //=======================================
            // レコードの取得
            //=======================================
            let realm = try! Realm()
            
            let shopTable = realm.objects(Shop.self)
            print("shopテーブルのデータ全て取得")
            print(shopTable)
            
            let menuTable = realm.objects(Menu.self)
            print("menuテーブルのデータ全て取得")
            print(menuTable)
            

            // Realmファイルが保存先のパス
            let fileURL = realm.configuration.fileURL
            print("Realm file path: \(fileURL?.path ?? "")")
            
            
        }) {
            Text("登録")
                .frame(width: 50, height: 30)
        }
        .offset(x:0,y:105)
        .buttonStyle(NormalButtonStyle.normalButtonStyle())
        .padding() // ボタンの余白を調整
    }
}
