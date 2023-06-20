//
//  LoginByEmailView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/19.
//

import SwiftUI
import FirebaseAuth

struct LoginByEmailView: View{
    @Binding var currentView: AuthenticationView.CurrentView
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
            Button(action: {
                //新規登録
                Auth.auth().signIn(withEmail: VM.email, password: VM.password) { authResult, error in
                    VM.ShowError_or_Finish(error: error)
                }
            }){
                Text("ログイン")
                    .enterButtonTexture()
                    .padding(.bottom, DEVICE_HEIGHT * 0.046)
            }
            HStack{
                Spacer()
                Button("新規作成する"){
                    currentView = AuthenticationView.CurrentView.registerByEmail
                }
                .padding(DEVICE_WIDTH * 0.05)
            }
        }
        .frame(width: DEVICE_WIDTH * 0.85)
        .background(Color.white)
        .cornerRadius(10)
    }
}
