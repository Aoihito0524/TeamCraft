//
//  ChatViewModel.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/10.
//

import SwiftUI
import FirebaseFirestore

class ChatViewModel: ObservableObject{
    let teamId: String
    @Published var textMessage = ""
    @Published var teamCom: TeamCommunication
    init(teamId: String){
        self.teamId = teamId
        teamCom = TeamCommunication(teamId: teamId)
    }
    func AddMessage(message: String, user: String){
        teamCom.AddMessage(message: message, user: user)
    }
}
