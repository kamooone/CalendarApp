//
//  IdealScheduleRegistView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI

struct IdealScheduleRegistView: View {
    let headerTitle: String = "理想のスケジュールを作成"
    
    // ToDo 2023/7/16 理想のスケジュール保存処理
    var body: some View {
        Color.lightGray.edgesIgnoringSafeArea(.all)
        GeometryReader { geometry in
            VStack {
                HStack {
                    BackButtonView()
                }
                HStack {
                    HeaderView(_headerTitle: headerTitle)
                }
                VStack {
                    ZStack {
                        IdealScheduleDetailTitleView()
                        
                        IdealScheduleTimeView()
                        
                        IdealNoticeSettingView()
                        
                        HStack {
                            Spacer()
                            IdealAppendScheduleDetailButtonView()
                                .offset(x:0, y:0)
                            Spacer()
                        }

                        HStack {
                            Spacer()
                            // ToDo 2023/7/20 詳細スケジュール確認画面
                            IdealConfirmScheduleDetailButtonView()
                                .offset(x:0, y:100)
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                            IdealScheduleRegistButtonView()
                                .offset(x:0, y:300)
                            Spacer()
                        }
                    }
                    .frame(width:geometry.size.width, height:270)
                    .background(Color.lightWhite)
                    .offset(x: 0, y: -30)

                    Spacer()
                }
                
                BannerAdsView()
                    .frame(width: geometry.size.width, height: 80)
                    .background(Color.yellow)
                    .offset(x: 0, y: 0)
                
                Spacer()
            }
        }
    }
}

struct IdealScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        IdealScheduleRegistView()
    }
}
