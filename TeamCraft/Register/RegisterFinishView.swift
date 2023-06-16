//
//  RegisterFinishView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/08.
//

import SwiftUI

struct RegisterFinishView: View{
    @Binding var registerFinishFlag: Bool
    var body: some View{
        VStack{
            Text("登録が完了しました")
                .padding(.vertical, DEVICE_HEIGHT * 0.05)
            Text("チームクラフトを始めよう！")
                .padding(.bottom, DEVICE_HEIGHT * 0.03)
            Divider()
            Button("始める"){
                registerFinishFlag.toggle()
            }
        }
        .cornerRadius(10)
        .background(Color.white)
    }
}
