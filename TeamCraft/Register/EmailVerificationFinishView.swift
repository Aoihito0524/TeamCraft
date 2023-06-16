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
                .padding(.vertical, DEVICE_HEIGHT * 0.1)
            Divider()
            Button("次へ"){
                finishFlag.toggle()
            }
        }
        .cornerRadius(10)
        .background(Color.white)
    }
}
