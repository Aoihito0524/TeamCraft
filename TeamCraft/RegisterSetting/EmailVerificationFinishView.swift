//
//  EmailVerificationFinishView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/08.
//

import SwiftUI

struct EmailVerificationFinishView: View{
    @Binding var finishFlag: Bool
    var body: some View{
        VStack{
            Text("メール認証が完了しました")
                .font(.title)
                .padding(.vertical, DEVICE_HEIGHT * 0.07)
            Divider()
            Button("次へ"){
                finishFlag.toggle()
            }
            .frame(height: DEVICE_HEIGHT * 0.08)
        }
        .frame(width: VERTICAL_SCROLLPANEL_WIDTH)
        .background(Color.white)
        .cornerRadius(10)
    }
}
