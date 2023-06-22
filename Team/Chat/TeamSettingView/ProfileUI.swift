//
//  ProfileUI.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/21.
//

import SwiftUI

struct ProfileUI: View{
    @Binding var myRole: String?
    let userName: String
    var body: some View{
        VStack(alignment: .leading){
            Text("プロフィール")
                .font(.title)
            HStack{
                UserIcon(size: DEVICE_WIDTH * 0.15).padding(DEVICE_WIDTH*0.07)
                Text(userName)
                    .font(.title2)
            }
            HStack{
                Text("役割")
                Text(myRole ?? "")
                    .padding(.leading, DEVICE_WIDTH * 0.06)
            }
            .padding(.leading, DEVICE_WIDTH*0.1)
        }
    }
}
