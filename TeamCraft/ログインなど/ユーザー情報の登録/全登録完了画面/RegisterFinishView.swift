//
//  RegisterFinishView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/08.
//

import SwiftUI

struct RegisterFinishView: View{
    @Binding var finishFlag: Bool
    var body: some View{
        VStack{
            Text("登録が完了しました")
                .padding(.vertical, DEVICE_HEIGHT * 0.05)
                .font(.title)
            Text("チームクラフトを始めよう！")
                .padding(.bottom, DEVICE_HEIGHT * 0.03)
                .font(.body)
            Divider()
            Button("始める"){
                finishFlag.toggle()
            }
            .frame(height: DEVICE_HEIGHT * 0.08)
        }
        .frame(width: VERTICAL_SCROLLPANEL_WIDTH)
        .background(Color.white)
        .cornerRadius(10)
    }
}
