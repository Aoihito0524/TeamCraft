//
//  RegisterByEmailView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/08.
//

import SwiftUI
import FirebaseAuth

struct RegisterByEmailView: View{
    @Binding var currentView: RegisterLoginView.CurrentView
    @ObservedObject var VM = RegisterByEmailViewModel()
    var body: some View{
        VStack{
            Text("新規作成")
                .font(.largeTitle)
                .padding(.vertical, DEVICE_HEIGHT * 0.046)
            if VM.errorOccured{
                Text(VM.errorMessage)
            }
            TextField("メールアドレス", text: $VM.email)
                .textFieldTexture()
                .padding(.bottom, DEVICE_HEIGHT * 0.046)
            PasswordField(message: "パスワード", password: $VM.password)
                .textFieldTexture()
                .padding(.bottom, DEVICE_HEIGHT * 0.046)
            PasswordField(message: "パスワード再入力", password: $VM.password_reenter)
                .textFieldTexture()
                .padding(.bottom, DEVICE_HEIGHT * 0.046)
            Button(action: {
                VM.TryRegister()
            }){
                Text("アカウント作成")
                    .enterButtonTexture()
                    .padding(.bottom, DEVICE_HEIGHT * 0.046)
            }
            HStack{
                Spacer()
                Button("ログインする"){
                    currentView = RegisterLoginView.CurrentView.loginByEmail
                }
                .padding(DEVICE_WIDTH * 0.05)
            }
        }
        .frame(width: VERTICAL_SCROLLPANEL_WIDTH)
        .background(Color.white)
        .cornerRadius(10)
    }
}

