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
    var body: some View{
        VStack{
            Text("「\(teamInfo.title)」に参加しますか？")
            Divider()
            HStack{
                Button("参加する"){
                    UserInformation.shared.JoinTeam(teamId: teamInfo.teamId)
                    closePopup()
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


