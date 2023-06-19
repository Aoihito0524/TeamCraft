//
//  LoginView.swift
//  TeamCraft
//
//  Created by 木村友祐 on 2023/06/08.
//

import SwiftUI
import FirebaseAuth

struct RegisterByEmailView: View{
    @Binding var currentView: AuthenticationView.CurrentView
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
                if VM.password != VM.password_reenter{
                    VM.errorMessage = "同じパスワードを入力してください"
                    return;
                }
                //新規登録
                Auth.auth().createUser(withEmail: VM.email, password: VM.password) { authResult, error in
                    VM.ShowError_or_Finish(error: error)
                }
            }){
                Text("アカウント作成")
                    .enterButtonTexture()
                    .padding(.bottom, DEVICE_HEIGHT * 0.046)
            }
            HStack{
                Spacer()
                Button("ログインする"){
                    currentView = AuthenticationView.CurrentView.loginByEmail
                }
                .padding(DEVICE_WIDTH * 0.05)
            }
        }
        .frame(width: VERTICAL_SCROLLPANEL_WIDTH)
        .background(Color.white)
        .cornerRadius(10)
    }
}

class RegisterByEmailViewModel: ObservableObject{
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var password_reenter: String = ""
    @Published var errorOccured = false
    @Published var errorMessage = ""
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
            print("ログインに成功しました")
        }
    }
}
