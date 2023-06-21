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
        VStack{
            TopBar_TeamSettingView()
            Text("チーム情報")
            teamInformationUI_TeamSetting(teamInfo: teamInfo, image: teamInfo.image)
            Text("プロフィール")
            HStack{
                UserIcon(size: DEVICE_WIDTH * 0.2).padding(DEVICE_WIDTH*0.08)
                Text(userName)
            }
            HStack{
                Text("役割")
                Text(teamCom.teamMemberRole[userId]!)
            }
            Button("チームを抜ける"){
                
            }
            .foregroundColor(.red)
        }
    }
}

struct TopBar_TeamSettingView: View{
    var body: some View{
        HStack{
            HStack{
                Text("チーム設定")
                    .font(.title)
            }
            .padding(.trailing, DEVICE_HEIGHT * 0.05)
        }
        .frame(width: DEVICE_WIDTH)
        .background(Color.white.opacity(0.92))
    }
}
