//
//  NumJoinTeamView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI

struct NumJoinTeamText: View{
    let num: Int
    var body: some View{
        VStack(alignment: .leading, spacing: DEVICE_HEIGHT*0.01){
            Text("現在参加中のチーム")
                .font(.caption)
            if num != 0{
                Text("\(num)チーム")
            }
            else{
                Text("なし")
            }
        }
    }
}
