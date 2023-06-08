//
//  RegisterFinishView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/08.
//

import SwiftUI

struct RegisterFinishView: View{
    @Binding var RegisterFinished: Bool
    var body: some View{
        VStack{
            Text("登録が完了しました")
            Text("チームクラフトを始めよう！")
            Button("始める"){
                RegisterFinished = true
            }
        }
    }
}
