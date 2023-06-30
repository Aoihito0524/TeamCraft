//
//  LoginByEmailView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/19.
//

import SwiftUI
import FirebaseAuth

struct LoginByEmailView: View{
    @Binding var currentView: RegisterLoginView.CurrentView
    @ObservedObject var VM = LoginByEmailViewModel()
    var body: some View{
        VStack{
            Text("ログイン")
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
            //ログインボタン
            Button(action: {
                VM.TryLogin()
            }){
                Text("ログイン")
                    .enterButtonTexture()
                    .padding(.bottom, DEVICE_HEIGHT * 0.046)
            }
            HStack{
                Spacer()
                Button("新規作成する"){
                    currentView = RegisterLoginView.CurrentView.registerByEmail
                }
                .padding(DEVICE_WIDTH * 0.05)
            }
        }
        .frame(width: DEVICE_WIDTH * 0.85)
        .background(Color.white)
        .cornerRadius(10)
    }
}
