//
//  DescriptionTextField.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI

struct DescriptionTextField: View{
    @Binding var descriptionText: String
    var body: some View{
        VStack(alignment: .leading){
            HStack{
                Text("概要")
                Text("（検索には影響しません）")
                Spacer()
            }
            TextField("概要を入力", text: $descriptionText)
                .frame(width: DEVICE_WIDTH * 0.8)
                .frame(minHeight: DEVICE_HEIGHT * 0.2)
                .overlay(Rectangle().stroke(Color.gray, lineWidth: 1))
        }
    }
}
