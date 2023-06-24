//  RegisterUserNameView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/08.
//

import SwiftUI
import FirebaseAuth

struct RegisterUserNameView: View{
    @Binding var finishFlag: Bool
    @ObservedObject var VM = RegisterUserNameViewModel()
    var body: some View{
        VStack{
            Text("ユーザーネームを登録")
                .font(.title)
                .padding(.vertical, DEVICE_HEIGHT * 0.05)
            RegisterUserIconButton(icon: VM.icon)
            RegisterUserNameField(name: $VM.name)
            Divider()
            Button("次へ"){
                VM.RegisterUserNameIcon()
                finishFlag.toggle()
            }
            .frame(height: DEVICE_HEIGHT * 0.08)
        }
        .frame(width: VERTICAL_SCROLLPANEL_WIDTH)
        .background(Color.white)
        .cornerRadius(10)
    }
}
