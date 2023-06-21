//
//  JoinPopupView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/12.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct JoinPopupView: View{
    let closePopup: () -> ()
    let teamInfo: TeamInformation
    @ObservedObject var teamCom: TeamCommunication
    @State var ErrorMessage: String?
    @State var role: String?
    init(closePopup: @escaping () -> (), teamInfo: TeamInformation){
        self.closePopup = closePopup
        self.teamInfo = teamInfo
        teamCom = TeamCommunication(teamId: teamInfo.teamId)
    }
    var body: some View{
        VStack{
            if let message = ErrorMessage{
                Text(message)
            }
            Text("「\(teamInfo.title)」に参加しますか？")
            Text("役割を選択してください")
            ForEach(teamInfo.RoleLeft(), id: \.self){role in
                Button(role){
                    
                }
            }
            Divider()
            HStack{
                Button("参加する"){
                    if let role = role{
                        teamCom.Join(role: role, teamInfo: teamInfo)
                        closePopup()
                    }
                    else{
                        ErrorMessage = "役割を選択してください"
                    }
                }
                Button("参加しない"){closePopup()}
            }
        }
        .frame(width: DEVICE_WIDTH * 0.9)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 3)
    }
}


