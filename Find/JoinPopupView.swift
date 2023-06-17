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
    let teamInfo: TeamInformation
    var body: some View{
        VStack{
            Text("\(teamInfo.title)に参加しますか？")
            Text("teamId: \(teamInfo.teamId)")
            Divider()
            HStack{
                Button("参加する"){UserInformation.shared.JoinTeam(teamId: teamInfo.teamId)}
                Button("参加しない"){}
            }
        }
    }
}


