//
//  DefaultTeamView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/10.
//

import SwiftUI

struct DefaultTeamView: View{
    @State var isCreatingTeam = false
    var body: some View{
        ZStack{
            Rectangle()
                .fill(BACKGROUND_COLOR)
                .ignoresSafeArea()
            if !isCreatingTeam{
                VStack{
                    Button(action: {
                        isCreatingTeam = true
                    }){
                        Text("チーム作成")
                    }
                }
            }
            else{
                CreateTeamView(isCreatingTeam: $isCreatingTeam)
            }
        }
    }
}

//struct RecruitPreview: PreviewProvider{
//    static var previews: some View{
//        DefaultTeamView()
//    }
//}
