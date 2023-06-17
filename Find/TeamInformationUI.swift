//
//  TeamInformationUI.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/17.
//

import SwiftUI

struct teamInformationUI: View{
    let width = DEVICE_WIDTH*0.869
    @ObservedObject var teamInfo: TeamInformation //imageのロード前後に観測が必要 -> observed
    @Binding var clickedTeamInfo: TeamInformation?
    var body: some View{
        VStack(alignment: .leading){
            if let image = teamInfo.image{
                Image(uiImage: image)
                    .resizable()
                    .frame(width: width, height: TeamInformation.ImageHeight(width: width))
            }
            Group{
                HStack{
                    //タグ名横並び
                    ForEach(teamInfo.tags.tags){tag in
                        TagLabel(tag: tag)
                    }
                    //その横にタイトル
                    Text(teamInfo.title)
                        .font(.title3)
                }
                .padding(.bottom, DEVICE_HEIGHT * 0.02)
                Text(teamInfo.description)
                    .font(.body)
                    .lineLimit(5)
                Spacer()
            }
            .padding(.leading, DEVICE_WIDTH * 0.03)
        }
        .frame(width: width)
        .frame(maxHeight: DEVICE_HEIGHT * 0.3)
        .background(Color.white)
        .onTapGesture{
            clickedTeamInfo = teamInfo
        }
    }
}
