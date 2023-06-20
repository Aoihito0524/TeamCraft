//
//  FindView_TopBar.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI

struct TopBar_FindView: View{
    @Binding var searchText: String
    let DoSearch: ()->()
    var body: some View{
        HStack{
            UserIcon(size: DEVICE_HEIGHT * 0.07)
                .padding(DEVICE_HEIGHT * 0.03)
            VStack{
                Text("探す")
                    .font(.title)
                SearchField(searchText: $searchText, DoSearch: DoSearch)
            }
            .padding(.trailing, DEVICE_HEIGHT * 0.05)
        }
        .background(Color.white.opacity(0.92))
    }
}
