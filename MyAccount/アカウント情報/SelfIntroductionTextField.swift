//
//  SelfIntroductionView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/20.
//

import SwiftUI

struct SelfIntroductionTextField: View{
    @Binding var SelfIntroductionText: String
    var body: some View{
        VStack(alignment: .leading, spacing: DEVICE_HEIGHT*0.01){
            Text("自己紹介文")
                .font(.caption)
            TextField("", text: $SelfIntroductionText)
                .lineLimit(nil)
                .frame(minHeight: DEVICE_HEIGHT * 0.1)
                .overlay(Rectangle().stroke(Color.gray, lineWidth: 1))
        }
    }
}
