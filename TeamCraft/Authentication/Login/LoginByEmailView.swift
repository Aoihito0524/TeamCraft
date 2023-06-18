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
    @State var email: String = ""
    @State var password: String = ""
    @State var errorOccured = false
    @State var errorMessage = ""
    var body: some View{
        VStack{
            Text("ログイン")
                .font(.largeTitle)
                .padding(.vertical, DEVICE_HEIGHT * 0.046)
            if errorOccured{
                Text(errorMessage)
            }
            TextField("メールアドレス", text: $email)
                .textFieldTexture()
                .padding(.bottom, DEVICE_HEIGHT * 0.046)
            PasswordField(message: "パスワード", password: $password)
                .textFieldTexture()
                .padding(.bottom, DEVICE_HEIGHT * 0.046)
            Button(action: {
                //新規登録
                Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    ShowError_or_Finish(error: error)
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
    func ShowError_or_Finish(error: (any Error)?){
        if let error = error as NSError? {
            if let errorCode = AuthErrorCode.Code(rawValue: error.code){
                errorOccured = true
                switch errorCode {
                case .invalidEmail:
                    errorMessage = "無効なメールアドレスです"
                    print("無効なメールアドレスです")
                default:
                    errorMessage = "エラーが発生しました。お問い合わせください"
                    print("その他のエラーが発生しました")
                }
            }
        } else {
            print("新規登録に成功しました")
        }
    }
}


