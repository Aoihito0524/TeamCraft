//
//  MessagesView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI

struct MessagesView: View{
    @ObservedObject var teamCom: TeamCommunication
    var body: some View{
        ScrollView{
            LazyVStack{
                ForEach(teamCom.messages, id: \.createAt){message in
                    MessageUI(message: message)
                }
            }
            .frame(width: VERTICAL_SCROLLPANEL_WIDTH)
        }
        .background(Color.white.opacity(0.82))
    }
}
