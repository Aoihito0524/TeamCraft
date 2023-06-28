//
//  TeamInformationUI.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/17.
//

import SwiftUI

struct teamInformationUI: View{
    @ObservedObject var teamInfo: TeamInformation //imageのロード前後に観測が必要 -> observed
    @ObservedObject var image: ImageManager
    @Binding var clickedTeamInfo: TeamInformation?
    var body: some View{
        VStack(alignment: .leading){
            if let image = image.image{
                Image(uiImage: image)
                    .resizable()
                    .frame(width: VERTICAL_SCROLLPANEL_WIDTH, height: TeamInformation.ImageHeight(width: VERTICAL_SCROLLPANEL_WIDTH))
            }
            Group{
                HStack{
                    //タグ名横並び
                    ForEach(teamInfo.tags.tags){tag in
                        TagLabel(tag: tag)
                    }
                    //その横にタイトル
                    Text(teamInfo.title)
                        .font(.headline)
                }
                .padding(.vertical, DEVICE_HEIGHT * 0.007)
                //概要
                Text(teamInfo.description)
                    .font(.body)
                    .lineLimit(5)
                    .frame(maxHeight: DEVICE_HEIGHT * 0.15)
                Text("参加人数:  \(teamInfo.num_FullMember - teamInfo.NumLeft_Member())/\(teamInfo.num_FullMember)人")
                Spacer()
            }
            .padding(.leading, DEVICE_WIDTH * 0.04)
            .padding(.bottom, DEVICE_HEIGHT * 0.005)
        }
        .frame(width: VERTICAL_SCROLLPANEL_WIDTH)
        .background(Color.white)
        .onTapGesture{
            clickedTeamInfo = teamInfo
        }
    }
}
