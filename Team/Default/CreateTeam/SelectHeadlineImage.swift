//
//  SelectHeadlineImage.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI

struct SelectHeadlineImage: View{
    @Binding var isSelectingImage: Bool
    @Binding var image: UIImage?
    var body: some View{
        Text("見出し画像")
            .padding(.leading, DEVICE_WIDTH * 0.1)
        Button(action: {isSelectingImage = true}){
            ZStack{
                Rectangle().fill(Color.gray)
                if let image = image{
                    Image(uiImage: image)
                        .resizable()
                }
            }
            .frame(width: VERTICAL_SCROLLPANEL_WIDTH, height: TeamInformation.ImageHeight(width: VERTICAL_SCROLLPANEL_WIDTH))
        }
        .sheet(isPresented: $isSelectingImage){
            ImagePicker(image: $image)
        }
    }
}
