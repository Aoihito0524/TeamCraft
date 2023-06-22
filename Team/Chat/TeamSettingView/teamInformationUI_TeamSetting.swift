//
//  teamInformationUI_TeamSetting.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/21.
//

import SwiftUI

struct teamInformationUI_TeamSetting: View{
    @ObservedObject var teamInfo: TeamInformation //imageのロード前後に観測が必要 -> observed
    @ObservedObject var image: ImageManager
    let imagePadding: CGFloat
    let imageWidth: CGFloat
    let imageHeight: CGFloat
    init(teamInfo: TeamInformation, image: ImageManager){
        self.teamInfo = teamInfo
        self.image = image
        imagePadding = DEVICE_WIDTH*0.01
        imageWidth = VERTICAL_SCROLLPANEL_WIDTH - imagePadding*2
        imageHeight = TeamInformation.ImageHeight(width: imageWidth)
    }
    var body: some View{
        VStack(alignment: .leading){
            Text("チーム情報")
                .font(.title)
            VStack(alignment: .leading){
                if let image = image.image{
                    HStack{
                        Spacer()
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: imageWidth, height: imageHeight)
                            .padding(imagePadding)
                        Spacer()
                    }
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
                    Spacer()
                }
                .padding(.leading, DEVICE_WIDTH * 0.04)
                .padding(.bottom, DEVICE_HEIGHT * 0.005)
            }
            .frame(width: VERTICAL_SCROLLPANEL_WIDTH)
            .background(Color.white)
        }
    }
}
