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
            Text("チームクラフトを始めよう！")
            Button("始める"){
                registerFinishFlag.toggle()
            }
        }
    }
}
