//
//  TeamSettingView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/21.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct TeamSettingView: View{
    @ObservedObject var teamInfo = TeamInformation()
    @ObservedObject var teamCom: TeamCommunication
    let userId = (Auth.auth().currentUser?.uid)!
    let userName = (Auth.auth().currentUser?.displayName)!
    init(teamCom: TeamCommunication){
        self.teamCom = teamCom
        self.teamInfo = TeamInformation(teamId: teamCom.teamId)
    }
    var body: some View{
        ZStack{
            Group{
                Rectangle()
                    .fill(BACKGROUND_COLOR)
                Rectangle()
                    .fill(Color.white.opacity(0.5))
            }
            .ignoresSafeArea()
            VStack(spacing: 0){
                TopBar_TeamSettingView()
                ScrollView{
                    VStack(alignment: .leading, spacing: DEVICE_HEIGHT * 0.05){
                        teamInformationUI_TeamSetting(teamInfo: teamInfo, image: teamInfo.image)
                        ProfileUI(myRole: $teamCom.teamMemberRole[userId], userName: userName)
                        Button("チームを抜ける"){
                            teamCom.Leave(userId: (Auth.auth().currentUser?.uid)!, teamInfo: teamInfo)
                        }
                        .foregroundColor(.red)
                        Spacer()
                    }
                    .padding(.top, DEVICE_HEIGHT * 0.05)
                }
            }
        }
        .onAppear{
            if teamInfo.isCompletelyLoaded(){return}
            teamInfo.RetrieveData(teamId: teamCom.teamId)
        }
    }
}

struct TopBar_TeamSettingView: View{
    var body: some View{
        HStack{
            HStack{
                Text("チーム設定")
                    .font(.title)
                    .padding(DEVICE_WIDTH * 0.05)
            }
        }
        .frame(width: DEVICE_WIDTH)
        .background(Color.white.opacity(0.92))
    }
}
