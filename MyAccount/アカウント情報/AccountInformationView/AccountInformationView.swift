//
//  AccountInformationView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI

struct AccountInformationView: View{
    @State var SelfIntroductionText = "なし"
    @ObservedObject var userInformation = UserInformation.shared
    var body: some View{
        ScrollView{
            VStack(spacing: 0){
                //アイコンと名前
                UserSymbols()
                .padding(.vertical, DEVICE_HEIGHT * 0.04)
                VStack(alignment: .leading, spacing: DEVICE_HEIGHT*0.05){
                    SelfIntroductionTextField(SelfIntroductionText: $SelfIntroductionText)
                    NumJoinTeamText(num: userInformation.joinTeamIds.count)
                    NumJoinedTeamText(num: userInformation.joinedTeamIds.count)
                    EmailInfoText()
                }
                .padding(.horizontal, DEVICE_WIDTH*0.1)
                LogOutButton()
                .padding(.top, DEVICE_HEIGHT * 0.03)
                Spacer()
            }
            .frame(minHeight: DEVICE_HEIGHT*0.9)
            .frame(width: VERTICAL_SCROLLPANEL_WIDTH)
            .background(Color.white.opacity(0.82))
        }
    }
}
