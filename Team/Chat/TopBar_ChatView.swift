//
//  TopBar_ChatView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/21.
//

import SwiftUI

struct TopBar_ChatView: View{
    @ObservedObject var teamCom: TeamCommunication
    var body: some View{
        HStack{
            UserIcon(size: DEVICE_HEIGHT * 0.07)
                .padding(DEVICE_HEIGHT * 0.03)
            HStack{
                Text("チーム")
                    .font(.title)
                NavigationLink{
                    TeamSettingView(teamCom: teamCom)
                } label: {
                    Image(systemName: "gearshape")
                }
                Image(systemName: "person")
            }
            .padding(.trailing, DEVICE_HEIGHT * 0.05)
        }
        .frame(width: DEVICE_WIDTH)
        .background(Color.white.opacity(0.92))
    }
}
