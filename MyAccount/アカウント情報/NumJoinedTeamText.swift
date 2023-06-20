//
//  NumJoinedTeamView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI

struct NumJoinedTeamText: View{
    let num: Int
    var body: some View{
        VStack(alignment: .leading, spacing: DEVICE_HEIGHT*0.01){
            Text("過去に参加したチーム")
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
