//
//  LoginView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/08.
//

import SwiftUI
import FirebaseAuth

struct RegisterEmailView: View{
    @State var email: String = ""
    @State var password: String = ""
    @State var password_reenter: String = ""
    @State var errorOccured = false
    @Binding var finishFlag: Bool
    @State var errorMessage = ""
    var body: some View{
        VStack{
            Text("新規作成")
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
            PasswordField(message: "パスワード再入力", password: $password_reenter)
                .textFieldTexture()
                .padding(.bottom, DEVICE_HEIGHT * 0.046)
            Button(action: {
                if password != password_reenter{
                    errorMessage = "同じパスワードを入力してください"
                    return;
                }
                //新規登録
                Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                    ShowError_or_Finish(error: error)
                }
            }){
                Text("アカウント作成")
                    .enterButtonTexture()
                    .padding(.bottom, DEVICE_HEIGHT * 0.046)
            }
        }
        .frame(width: DEVICE_WIDTH * 0.85, height: DEVICE_HEIGHT * 0.449)
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
                case .emailAlreadyInUse:
                    errorMessage = "既に存在するメールアドレスです"
                    print("既に存在するメールアドレスです")
                default:
                    errorMessage = "エラーが発生しました。お問い合わせください"
                    print("その他のエラーが発生しました")
                }
            }
        } else {
            finishFlag = true
            print("新規登録に成功しました")
        }
    }
}

struct PasswordField: View{
    let message: String
    @Binding var password: String
    @State var visible = false
    var body: some View{
        ZStack(alignment: .trailing) {
            TextField(message, text: $password)
                .opacity(visible ? 1 : 0)
            SecureField(message, text: $password)
                .opacity(visible ? 0 : 1)
            Button(action: {
                visible.toggle()
            }, label: {
                Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                    .padding()
                    .font(.system(size: 15))
                
            })
        }
    }
}

extension View {
    func textFieldTexture() -> some View {
        self.frame(width: DEVICE_WIDTH * 0.75, height: DEVICE_HEIGHT * 0.04)
        .background(Color(red: 0.396, green: 0.737, blue: 0.929))
        .cornerRadius(10)
        .textFieldStyle(.roundedBorder)
        .multilineTextAlignment(TextAlignment.center)
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(Color.black, lineWidth: 1)
            .background(Color.clear))
    }
    func enterButtonTexture() -> some View {
        self.frame(width: DEVICE_WIDTH * 0.75, height: DEVICE_HEIGHT * 0.04)
        .background(Color(red: 0.396, green: 0.737, blue: 0.929))
        .cornerRadius(10)
        .textFieldStyle(.roundedBorder)
        .multilineTextAlignment(TextAlignment.center)
        .overlay(RoundedRectangle(cornerRadius: 10)
            .stroke(Color.black, lineWidth: 1)
            .background(Color.clear))
    }
}
