//
//  TeamView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/10.
//

import SwiftUI

struct TeamView: View{
    @ObservedObject var userInformation = UserInformation.shared
    var body: some View{
        ZStack(alignment: .top){
            //チームに入ってない時
            if userInformation.joinTeamIds.count == 0{
                DefaultTeamView()
            }
            //それ以外
            else{
                ChatView(teamId: userInformation.joinTeamIds[0])
            }
        }
    }
}
