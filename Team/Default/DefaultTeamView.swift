//
//  DefaultTeamView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/10.
//

import SwiftUI

struct DefaultTeamView: View{
    var body: some View{
        NavigationView{
            ZStack{
                Rectangle()
                    .fill(BACKGROUND_COLOR)
                    .ignoresSafeArea()
                VStack{
                    TopBar_DefaultTeamView()
                    Spacer()
                    Text("まだチームに参加していません")
                    Spacer()
                }
            }
        }
    }
}

struct TopBar_DefaultTeamView: View{
    @State var isCreatingTeam = false
    var body: some View{
        HStack{
            UserIcon(size: DEVICE_HEIGHT * 0.07)
                .padding(DEVICE_HEIGHT * 0.03)
            HStack{
                Text("チーム")
                    .font(.title)
                NavigationLink {
                    CreateTeamView(isCreatingTeam: $isCreatingTeam)
                } label: {
                    Text("+ チーム作成")
                }
            }
            .padding(.trailing, DEVICE_HEIGHT * 0.05)
        }
        .frame(width: DEVICE_WIDTH)
        .background(Color.white.opacity(0.92))
    }
}

//struct RecruitPreview: PreviewProvider{
//    static var previews: some View{
//        DefaultTeamView()
//    }
//}
