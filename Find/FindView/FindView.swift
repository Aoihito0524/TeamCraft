//
//  FindView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/10.
//

import SwiftUI
import FirebaseFirestore

struct FindView: View{
    @ObservedObject var VM = FindViewModel()
    var body: some View{
        ZStack{
            Rectangle()
                .fill(BACKGROUND_COLOR)
                .ignoresSafeArea()
            VStack{
                TopBar_FindView(searchText: $VM.searchText, DoSearch: VM.Search)
                ScrollView{
                    LazyVStack{
                        ForEach(VM.searchResults){ teamInfo in
                            teamInformationUI(teamInfo: teamInfo, image: teamInfo.image, clickedTeamInfo: $VM.clickedTeamInfo)
                        }
                        Divider()
                    }
                    .frame(width: VERTICAL_SCROLLPANEL_WIDTH)
                    .background(Color.white)
                }
            }
            if let clickedTeamInfo = VM.clickedTeamInfo{
                JoinPopupView(closePopup: VM.CloseJoinPopup, teamInfo: clickedTeamInfo)
            }
        }
    }
}
