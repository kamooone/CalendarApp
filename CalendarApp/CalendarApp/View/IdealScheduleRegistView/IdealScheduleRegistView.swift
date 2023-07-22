//
//  IdealScheduleRegistView.swift
//  CalendarApp
//
//  Created by Kazusa Kondo on 2023/07/16.
//

import SwiftUI

struct IdealScheduleRegistView: View {
    let scheduleDetailViewModel = ScheduleDetailViewModel.shared
    let headerTitle: String = "のスケジュール"
    
    var body: some View {
        Color.lightGray.edgesIgnoringSafeArea(.all)
        GeometryReader { geometry in
            VStack {
                HStack {
                    BackButtonView()
                }
                HStack {
                    HeaderView(_headerTitle: scheduleDetailViewModel.idealScheduleTitle + headerTitle)
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
